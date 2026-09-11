return {
	Play416191001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416191001
		arg_1_1.duration_ = 9.1

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play416191002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.STwhite == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_4_0.name = "STwhite"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STwhite = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STwhite

				arg_1_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STwhite" then
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
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0
				arg_1_1.fswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(416191001).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_9 = 1.1

			if 1.1 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_10 = 28
			local var_4_11 = 1.86666666666667
			local var_4_12, var_4_13 = arg_1_1:GetPercentByPara(arg_1_1:FormatText(arg_1_1:GetWordFromCfg(416191001).content), 1)

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

			local var_4_15 = math.max(1.86666666666667, arg_1_1.talkMaxDuration)

			if var_4_9 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_15 then
				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_12, (arg_1_1.time_ - var_4_9) / var_4_15)
				arg_1_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_9 + var_4_15 and arg_1_1.time_ < var_4_9 + var_4_15 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_12

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_13
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_16 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_17 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_18 = var_4_16:GetComponent("RectTransform")

				var_4_16:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleLeft
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

			local var_4_22 = 0.5
			local var_4_23 = manager.audio:GetVoiceLength("story_v_out_416191", "416191001", "story_v_out_416191.awb") / 1000

			if var_4_23 > 0 and 8.6 < var_4_23 and var_4_23 + var_4_22 > arg_1_1.duration_ then
				arg_1_1.duration_ = var_4_23 + var_4_22
			end

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1:AudioAction("play", "voice", "story_v_out_416191", "416191001", "story_v_out_416191.awb")
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play416191002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 416191002
		arg_6_1.duration_ = 10.5

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play416191003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(true)
				arg_6_1.dialog_:SetActive(false)

				arg_6_1.fswtw_.percent = 0
				arg_6_1.fswt_.text = arg_6_1:FormatText(arg_6_1:GetWordFromCfg(416191002).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.fswt_)

				arg_6_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_6_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_6_1.fswtw_:SetDirty()

				arg_6_1.typewritterCharCountI18N = 0

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_0 = 0.533333333333333

			if 0.533333333333333 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_1 = 36
			local var_9_2 = 2.4
			local var_9_3, var_9_4 = arg_6_1:GetPercentByPara(arg_6_1:FormatText(arg_6_1:GetWordFromCfg(416191002).content), 1)

			if var_9_0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_0 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				local var_9_5 = var_9_1 <= 0 and var_9_2 or var_9_2 * ((var_9_4 - arg_6_1.typewritterCharCountI18N) / var_9_1)

				if (var_9_1 <= 0 and var_9_2 or var_9_2 * ((var_9_4 - arg_6_1.typewritterCharCountI18N) / var_9_1)) > 0 and var_9_2 < var_9_5 then
					arg_6_1.talkMaxDuration = var_9_5

					if var_9_5 + var_9_0 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_5 + var_9_0
					end
				end
			end

			local var_9_6 = math.max(2.4, arg_6_1.talkMaxDuration)

			if var_9_0 <= arg_6_1.time_ and arg_6_1.time_ < var_9_0 + var_9_6 then
				arg_6_1.fswtw_.percent = Mathf.Lerp(arg_6_1.var_.oldValueTypewriter, var_9_3, (arg_6_1.time_ - var_9_0) / var_9_6)
				arg_6_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_6_1.fswtw_:SetDirty()
			end

			if arg_6_1.time_ >= var_9_0 + var_9_6 and arg_6_1.time_ < var_9_0 + var_9_6 + arg_9_0 then
				arg_6_1.fswtw_.percent = var_9_3

				arg_6_1.fswtw_:SetDirty()
				arg_6_1:ShowNextGo(true)

				arg_6_1.typewritterCharCountI18N = var_9_4
			end

			local var_9_7 = 0.333333333333333
			local var_9_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191002", "story_v_out_416191.awb") / 1000

			if var_9_8 > 0 and 10.166 < var_9_8 and var_9_8 + var_9_7 > arg_6_1.duration_ then
				arg_6_1.duration_ = var_9_8 + var_9_7
			end

			if var_9_7 < arg_6_1.time_ and arg_6_1.time_ <= var_9_7 + arg_9_0 then
				arg_6_1:AudioAction("play", "voice", "story_v_out_416191", "416191002", "story_v_out_416191.awb")
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play416191003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 416191003
		arg_10_1.duration_ = 12.03

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play416191004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.fswbg_:SetActive(true)
				arg_10_1.dialog_:SetActive(false)

				arg_10_1.fswtw_.percent = 0
				arg_10_1.fswt_.text = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(416191003).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.fswt_)

				arg_10_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_10_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_10_1.fswtw_:SetDirty()

				arg_10_1.typewritterCharCountI18N = 0

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_0 = 0.633333333333333

			if 0.633333333333333 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_1 = 32
			local var_13_2 = 2.4
			local var_13_3, var_13_4 = arg_10_1:GetPercentByPara(arg_10_1:FormatText(arg_10_1:GetWordFromCfg(416191003).content), 1)

			if var_13_0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_0 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0

				local var_13_5 = var_13_1 <= 0 and var_13_2 or var_13_2 * ((var_13_4 - arg_10_1.typewritterCharCountI18N) / var_13_1)

				if (var_13_1 <= 0 and var_13_2 or var_13_2 * ((var_13_4 - arg_10_1.typewritterCharCountI18N) / var_13_1)) > 0 and var_13_2 < var_13_5 then
					arg_10_1.talkMaxDuration = var_13_5

					if var_13_5 + var_13_0 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_5 + var_13_0
					end
				end
			end

			local var_13_6 = math.max(2.4, arg_10_1.talkMaxDuration)

			if var_13_0 <= arg_10_1.time_ and arg_10_1.time_ < var_13_0 + var_13_6 then
				arg_10_1.fswtw_.percent = Mathf.Lerp(arg_10_1.var_.oldValueTypewriter, var_13_3, (arg_10_1.time_ - var_13_0) / var_13_6)
				arg_10_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_10_1.fswtw_:SetDirty()
			end

			if arg_10_1.time_ >= var_13_0 + var_13_6 and arg_10_1.time_ < var_13_0 + var_13_6 + arg_13_0 then
				arg_10_1.fswtw_.percent = var_13_3

				arg_10_1.fswtw_:SetDirty()
				arg_10_1:ShowNextGo(true)

				arg_10_1.typewritterCharCountI18N = var_13_4
			end

			local var_13_7 = 0.333333333333333
			local var_13_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191003", "story_v_out_416191.awb") / 1000

			if var_13_8 > 0 and 11.7 < var_13_8 and var_13_8 + var_13_7 > arg_10_1.duration_ then
				arg_10_1.duration_ = var_13_8 + var_13_7
			end

			if var_13_7 < arg_10_1.time_ and arg_10_1.time_ <= var_13_7 + arg_13_0 then
				arg_10_1:AudioAction("play", "voice", "story_v_out_416191", "416191003", "story_v_out_416191.awb")
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play416191004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 416191004
		arg_14_1.duration_ = 8.57

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play416191005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.fswbg_:SetActive(true)
				arg_14_1.dialog_:SetActive(false)

				arg_14_1.fswtw_.percent = 0
				arg_14_1.fswt_.text = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(416191004).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.fswt_)

				arg_14_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_14_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_14_1.fswtw_:SetDirty()

				arg_14_1.typewritterCharCountI18N = 0

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_0 = 0.633333333333333

			if 0.633333333333333 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_1 = 29
			local var_17_2 = 1.93333333333333
			local var_17_3, var_17_4 = arg_14_1:GetPercentByPara(arg_14_1:FormatText(arg_14_1:GetWordFromCfg(416191004).content), 1)

			if var_17_0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_0 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				local var_17_5 = var_17_1 <= 0 and var_17_2 or var_17_2 * ((var_17_4 - arg_14_1.typewritterCharCountI18N) / var_17_1)

				if (var_17_1 <= 0 and var_17_2 or var_17_2 * ((var_17_4 - arg_14_1.typewritterCharCountI18N) / var_17_1)) > 0 and var_17_2 < var_17_5 then
					arg_14_1.talkMaxDuration = var_17_5

					if var_17_5 + var_17_0 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_5 + var_17_0
					end
				end
			end

			local var_17_6 = math.max(1.93333333333333, arg_14_1.talkMaxDuration)

			if var_17_0 <= arg_14_1.time_ and arg_14_1.time_ < var_17_0 + var_17_6 then
				arg_14_1.fswtw_.percent = Mathf.Lerp(arg_14_1.var_.oldValueTypewriter, var_17_3, (arg_14_1.time_ - var_17_0) / var_17_6)
				arg_14_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_14_1.fswtw_:SetDirty()
			end

			if arg_14_1.time_ >= var_17_0 + var_17_6 and arg_14_1.time_ < var_17_0 + var_17_6 + arg_17_0 then
				arg_14_1.fswtw_.percent = var_17_3

				arg_14_1.fswtw_:SetDirty()
				arg_14_1:ShowNextGo(true)

				arg_14_1.typewritterCharCountI18N = var_17_4
			end

			local var_17_7 = 0.366666666666667
			local var_17_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191004", "story_v_out_416191.awb") / 1000

			if var_17_8 > 0 and 8.2 < var_17_8 and var_17_8 + var_17_7 > arg_14_1.duration_ then
				arg_14_1.duration_ = var_17_8 + var_17_7
			end

			if var_17_7 < arg_14_1.time_ and arg_14_1.time_ <= var_17_7 + arg_17_0 then
				arg_14_1:AudioAction("play", "voice", "story_v_out_416191", "416191004", "story_v_out_416191.awb")
			end

			local var_17_10 = 0.633333333333333

			if 0.633333333333333 < arg_14_1.time_ and arg_14_1.time_ <= var_17_10 + arg_17_0 then
				arg_14_1.allBtn_.enabled = false
			end

			if arg_14_1.time_ >= var_17_10 + 3.53333333333333 and arg_14_1.time_ < var_17_10 + 3.53333333333333 + arg_17_0 then
				arg_14_1.allBtn_.enabled = true
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play416191005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 416191005
		arg_18_1.duration_ = 6.9

		local var_18_0 = {
			zh = 6.9,
			ja = 5.766
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play416191006(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.mask_.enabled = true
				arg_18_1.mask_.raycastTarget = true

				arg_18_1:SetGaussion(false)
			end

			local var_21_0 = 0.466666666666667

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_0 then
				local var_21_1 = Color.New(0, 0, 0)

				var_21_1.a = Mathf.Lerp(0, 1, (arg_18_1.time_ - 0) / var_21_0)
				arg_18_1.mask_.color = var_21_1
			end

			if arg_18_1.time_ >= 0 + var_21_0 and arg_18_1.time_ < 0 + var_21_0 + arg_21_0 then
				local var_21_2 = Color.New(0, 0, 0)

				var_21_2.a = 1
				arg_18_1.mask_.color = var_21_2
			end

			local var_21_3 = 0.466666666666667

			if 0.466666666666667 < arg_18_1.time_ and arg_18_1.time_ <= var_21_3 + arg_21_0 then
				arg_18_1.mask_.enabled = true
				arg_18_1.mask_.raycastTarget = true

				arg_18_1:SetGaussion(false)
			end

			local var_21_4 = 1.53333333333333

			if var_21_3 <= arg_18_1.time_ and arg_18_1.time_ < var_21_3 + var_21_4 then
				local var_21_5 = Color.New(0, 0, 0)

				var_21_5.a = Mathf.Lerp(1, 0, (arg_18_1.time_ - var_21_3) / var_21_4)
				arg_18_1.mask_.color = var_21_5
			end

			if arg_18_1.time_ >= var_21_3 + var_21_4 and arg_18_1.time_ < var_21_3 + var_21_4 + arg_21_0 then
				local var_21_6 = Color.New(0, 0, 0)

				arg_18_1.mask_.enabled = false
				var_21_6.a = 0
				arg_18_1.mask_.color = var_21_6
			end

			if 0.466666666666667 < arg_18_1.time_ and arg_18_1.time_ <= 0.466666666666667 + arg_21_0 then
				arg_18_1.fswbg_:SetActive(false)
				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_18_1:ShowNextGo(false)
			end

			if 0.483333333333333 < arg_18_1.time_ and arg_18_1.time_ <= 0.483333333333333 + arg_21_0 then
				arg_18_1.fswbg_:SetActive(false)
				arg_18_1.dialog_:SetActive(false)
				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_18_1:ShowNextGo(false)
			end

			if arg_18_1.frameCnt_ <= 1 then
				arg_18_1.dialog_:SetActive(false)
			end

			local var_21_7 = 1.7
			local var_21_8 = 0.375

			if 1.7 < arg_18_1.time_ and arg_18_1.time_ <= var_21_7 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				arg_18_1.dialog_:SetActive(true)

				arg_18_1.dialogCg_.alpha = 0

				local var_21_9 = LeanTween.value(arg_18_1.dialog_, 0, 1, 0.3)

				var_21_9:setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
					arg_18_1.dialogCg_.alpha = arg_22_0
				end))
				var_21_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_18_1.dialog_)
					var_21_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_18_1.duration_ = arg_18_1.duration_ + 0.3

				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, true)
				arg_18_1.iconController_:SetSelectedState("hero")

				arg_18_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_6")

				arg_18_1.callingController_:SetSelectedState("normal")

				arg_18_1.keyicon_.color = Color.New(1, 1, 1)
				arg_18_1.icon_.color = Color.New(1, 1, 1)

				local var_21_10 = arg_18_1:GetWordFromCfg(416191005)
				local var_21_11 = arg_18_1:FormatText(var_21_10.content)

				arg_18_1.text_.text = var_21_11

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_13 = 15 <= 0 and var_21_8 or var_21_8 * (utf8.len(var_21_11) / 15)

				if (15 <= 0 and var_21_8 or var_21_8 * (utf8.len(var_21_11) / 15)) > 0 and var_21_8 < var_21_13 then
					arg_18_1.talkMaxDuration = var_21_13
					var_21_7 = var_21_7 + 0.3

					if var_21_13 + var_21_7 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_13 + var_21_7
					end
				end

				arg_18_1.text_.text = var_21_11
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191005", "story_v_out_416191.awb") ~= 0 then
					local var_21_14 = manager.audio:GetVoiceLength("story_v_out_416191", "416191005", "story_v_out_416191.awb") / 1000

					if var_21_14 + var_21_7 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_14 + var_21_7
					end

					if var_21_10.prefab_name ~= "" and arg_18_1.actors_[var_21_10.prefab_name] ~= nil then
						local var_21_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_10.prefab_name].transform, "story_v_out_416191", "416191005", "story_v_out_416191.awb")

						arg_18_1:RecordAudio("416191005", var_21_15)
						arg_18_1:RecordAudio("416191005", var_21_15)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_416191", "416191005", "story_v_out_416191.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_416191", "416191005", "story_v_out_416191.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_16 = var_21_7 + 0.3
			local var_21_17 = math.max(var_21_8, arg_18_1.talkMaxDuration)

			if var_21_7 + 0.3 <= arg_18_1.time_ and arg_18_1.time_ < var_21_16 + var_21_17 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_16) / var_21_17

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_16 + var_21_17 and arg_18_1.time_ < var_21_16 + var_21_17 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play416191006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 416191006
		arg_24_1.duration_ = 2.37

		local var_24_0 = {
			zh = 1.5,
			ja = 2.366
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
				arg_24_0:Play416191007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.125

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_3")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_1 = arg_24_1:GetWordFromCfg(416191006)
				local var_27_2 = arg_24_1:FormatText(var_27_1.content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 5 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 5)

				if (5 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 5)) > 0 and var_27_0 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191006", "story_v_out_416191.awb") ~= 0 then
					local var_27_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191006", "story_v_out_416191.awb") / 1000

					if var_27_5 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + 0
					end

					if var_27_1.prefab_name ~= "" and arg_24_1.actors_[var_27_1.prefab_name] ~= nil then
						local var_27_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_1.prefab_name].transform, "story_v_out_416191", "416191006", "story_v_out_416191.awb")

						arg_24_1:RecordAudio("416191006", var_27_6)
						arg_24_1:RecordAudio("416191006", var_27_6)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_416191", "416191006", "story_v_out_416191.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_416191", "416191006", "story_v_out_416191.awb")
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
	Play416191007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 416191007
		arg_28_1.duration_ = 7.8

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play416191008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.bgs_.SS1608 == nil then
				local var_31_0 = Object.Instantiate(arg_28_1.paintGo_)

				var_31_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS1608")
				var_31_0.name = "SS1608"
				var_31_0.transform.parent = arg_28_1.stage_.transform
				var_31_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.bgs_.SS1608 = var_31_0
			end

			if 1 < arg_28_1.time_ and arg_28_1.time_ <= 1 + arg_31_0 then
				local var_31_1 = arg_28_1.bgs_.SS1608

				arg_28_1.bgs_.SS1608.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_31_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_31_2 = var_31_1:GetComponent("SpriteRenderer")

				if var_31_2 and var_31_2.sprite then
					local var_31_3 = 2 * (var_31_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_31_1.transform.localScale = Vector3.New(var_31_3 / var_31_2.sprite.bounds.size.y < var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x and var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x or var_31_3 / var_31_2.sprite.bounds.size.y, var_31_3 / var_31_2.sprite.bounds.size.y < var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x and var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x or var_31_3 / var_31_2.sprite.bounds.size.y, 0)
				end

				for iter_31_0, iter_31_1 in pairs(arg_28_1.bgs_) do
					if iter_31_0 ~= "SS1608" then
						iter_31_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_31_4 = 1

			if 1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.allBtn_.enabled = false
			end

			if arg_28_1.time_ >= var_31_4 + 0.3 and arg_28_1.time_ < var_31_4 + 0.3 + arg_31_0 then
				arg_28_1.allBtn_.enabled = true
			end

			local var_31_5 = 0

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_6 = 1.03333333333333

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 then
				local var_31_7 = Color.New(0, 0, 0)

				var_31_7.a = Mathf.Lerp(0, 1, (arg_28_1.time_ - var_31_5) / var_31_6)
				arg_28_1.mask_.color = var_31_7
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 then
				local var_31_8 = Color.New(0, 0, 0)

				var_31_8.a = 1
				arg_28_1.mask_.color = var_31_8
			end

			local var_31_9 = 1.03333333333333

			if 1.03333333333333 < arg_28_1.time_ and arg_28_1.time_ <= var_31_9 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_10 = 2.13333333333333

			if var_31_9 <= arg_28_1.time_ and arg_28_1.time_ < var_31_9 + var_31_10 then
				local var_31_11 = Color.New(0, 0, 0)

				var_31_11.a = Mathf.Lerp(1, 0, (arg_28_1.time_ - var_31_9) / var_31_10)
				arg_28_1.mask_.color = var_31_11
			end

			if arg_28_1.time_ >= var_31_9 + var_31_10 and arg_28_1.time_ < var_31_9 + var_31_10 + arg_31_0 then
				local var_31_12 = Color.New(0, 0, 0)

				arg_28_1.mask_.enabled = false
				var_31_12.a = 0
				arg_28_1.mask_.color = var_31_12
			end

			local var_31_13 = arg_28_1.bgs_.SS1608.transform

			if 1.03333333333333 < arg_28_1.time_ and arg_28_1.time_ <= 1.03333333333333 + arg_31_0 then
				arg_28_1.var_.moveOldPosSS1608 = var_31_13.localPosition
			end

			local var_31_14 = 0.001

			if 1.03333333333333 <= arg_28_1.time_ and arg_28_1.time_ < 1.03333333333333 + var_31_14 then
				var_31_13.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPosSS1608, Vector3.New(0, 0.78, 8), (arg_28_1.time_ - 1.03333333333333) / var_31_14)
			end

			if arg_28_1.time_ >= 1.03333333333333 + var_31_14 and arg_28_1.time_ < 1.03333333333333 + var_31_14 + arg_31_0 then
				var_31_13.localPosition = Vector3.New(0, 0.78, 8)
			end

			local var_31_15 = arg_28_1.bgs_.SS1608.transform

			if 1.06733333333333 < arg_28_1.time_ and arg_28_1.time_ <= 1.06733333333333 + arg_31_0 then
				arg_28_1.var_.moveOldPosSS1608 = var_31_15.localPosition
			end

			local var_31_16 = 2.49933333333333

			if 1.06733333333333 <= arg_28_1.time_ and arg_28_1.time_ < 1.06733333333333 + var_31_16 then
				var_31_15.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPosSS1608, Vector3.New(0, 0.4, 6), (arg_28_1.time_ - 1.06733333333333) / var_31_16)
			end

			if arg_28_1.time_ >= 1.06733333333333 + var_31_16 and arg_28_1.time_ < 1.06733333333333 + var_31_16 + arg_31_0 then
				var_31_15.localPosition = Vector3.New(0, 0.4, 6)
			end

			local var_31_17 = manager.ui.mainCamera.transform

			if 1.03333333333333 < arg_28_1.time_ and arg_28_1.time_ <= 1.03333333333333 + arg_31_0 then
				arg_28_1.var_.shakeOldPos = var_31_17.localPosition
			end

			local var_31_18 = 0.411224965255799

			if 1.03333333333333 <= arg_28_1.time_ and arg_28_1.time_ < 1.03333333333333 + var_31_18 then
				local var_31_19, var_31_20 = math.modf((arg_28_1.time_ - 1.03333333333333) / 0.066)

				var_31_17.localPosition = Vector3.New(var_31_20 * 0.13, var_31_20 * 0.13, var_31_20 * 0.13) + arg_28_1.var_.shakeOldPos
			end

			if arg_28_1.time_ >= 1.03333333333333 + var_31_18 and arg_28_1.time_ < 1.03333333333333 + var_31_18 + arg_31_0 then
				var_31_17.localPosition = arg_28_1.var_.shakeOldPos
			end

			if 1.03333333333333 < arg_28_1.time_ and arg_28_1.time_ <= 1.03333333333333 + arg_31_0 then
				arg_28_1:AudioAction("play", "effect", "se_story_5", "se_story_5_heartbeat", "")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_31_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_28_1.bgmTxt_.text ~= var_31_24 and arg_28_1.bgmTxt_.text ~= "" then
						if arg_28_1.bgmTxt2_.text ~= "" then
							arg_28_1.bgmTxt_.text = arg_28_1.bgmTxt2_.text
						end

						arg_28_1.bgmTxt2_.text = var_31_24

						arg_28_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_28_1.bgmTxt_.text = var_31_24
						arg_28_1.bgmTxt2_.text = var_31_24
					end

					if arg_28_1.bgmTimer then
						arg_28_1.bgmTimer:Stop()

						arg_28_1.bgmTimer = nil
					end

					if arg_28_1.settingData.show_music_name == 1 then
						arg_28_1.musicController:SetSelectedState("show")
						arg_28_1.musicAnimator_:Play("open", 0, 0)

						if arg_28_1.settingData.music_time ~= 0 then
							arg_28_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_28_1.settingData.music_time), function()
								if arg_28_1 == nil or isNil(arg_28_1.bgmTxt_) then
									return
								end

								arg_28_1.musicController:SetSelectedState("hide")
								arg_28_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.833333333333333 < arg_28_1.time_ and arg_28_1.time_ <= 0.833333333333333 + arg_31_0 then
				arg_28_1:AudioAction("play", "music", "bgm_activity_3_4_story_seabed", "bgm_activity_3_4_story_seabed", "bgm_activity_3_4_story_seabed.awb")

				local var_31_27 = manager.audio:GetAudioName("bgm_activity_3_4_story_seabed", "bgm_activity_3_4_story_seabed")

				if "" ~= "" then
					if arg_28_1.bgmTxt_.text ~= var_31_27 and arg_28_1.bgmTxt_.text ~= "" then
						if arg_28_1.bgmTxt2_.text ~= "" then
							arg_28_1.bgmTxt_.text = arg_28_1.bgmTxt2_.text
						end

						arg_28_1.bgmTxt2_.text = var_31_27

						arg_28_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_28_1.bgmTxt_.text = var_31_27
						arg_28_1.bgmTxt2_.text = var_31_27
					end

					if arg_28_1.bgmTimer then
						arg_28_1.bgmTimer:Stop()

						arg_28_1.bgmTimer = nil
					end

					if arg_28_1.settingData.show_music_name == 1 then
						arg_28_1.musicController:SetSelectedState("show")
						arg_28_1.musicAnimator_:Play("open", 0, 0)

						if arg_28_1.settingData.music_time ~= 0 then
							arg_28_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_28_1.settingData.music_time), function()
								if arg_28_1 == nil or isNil(arg_28_1.bgmTxt_) then
									return
								end

								arg_28_1.musicController:SetSelectedState("hide")
								arg_28_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_28_1.frameCnt_ <= 1 then
				arg_28_1.dialog_:SetActive(false)
			end

			local var_31_28 = 2.8
			local var_31_29 = 1.45

			if 2.8 < arg_28_1.time_ and arg_28_1.time_ <= var_31_28 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				arg_28_1.dialog_:SetActive(true)

				arg_28_1.dialogCg_.alpha = 0

				local var_31_30 = LeanTween.value(arg_28_1.dialog_, 0, 1, 0.3)

				var_31_30:setOnUpdate(LuaHelper.FloatAction(function(arg_34_0)
					arg_28_1.dialogCg_.alpha = arg_34_0
				end))
				var_31_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_28_1.dialog_)
					var_31_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_28_1.duration_ = arg_28_1.duration_ + 0.3

				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_31 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(416191007).content)

				arg_28_1.text_.text = var_31_31

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_33 = 58 <= 0 and var_31_29 or var_31_29 * (utf8.len(var_31_31) / 58)

				if (58 <= 0 and var_31_29 or var_31_29 * (utf8.len(var_31_31) / 58)) > 0 and var_31_29 < var_31_33 then
					arg_28_1.talkMaxDuration = var_31_33
					var_31_28 = var_31_28 + 0.3

					if var_31_33 + var_31_28 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_33 + var_31_28
					end
				end

				arg_28_1.text_.text = var_31_31
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_34 = var_31_28 + 0.3
			local var_31_35 = math.max(var_31_29, arg_28_1.talkMaxDuration)

			if var_31_28 + 0.3 <= arg_28_1.time_ and arg_28_1.time_ < var_31_34 + var_31_35 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_34) / var_31_35

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_34 + var_31_35 and arg_28_1.time_ < var_31_34 + var_31_35 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1608",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.03333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1608",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.49933333333333,
				className = "StoryMoveNode",
				startTime = 1.06733333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play416191008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 416191008
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play416191009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0.05 < arg_36_1.time_ and arg_36_1.time_ <= 0.05 + arg_39_0 then
				arg_36_1:AudioAction("play", "effect", "se_story_127", "se_story_127_thunder", "")
			end

			if 0.1 < arg_36_1.time_ and arg_36_1.time_ <= 0.1 + arg_39_0 then
				arg_36_1:AudioAction("stop", "effect", "se_story_5", "se_story_5_heartbeat", "")
			end

			local var_39_2 = 0
			local var_39_3 = 1.275

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_4 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(416191008).content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_6 = 51 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_4) / 51)

				if (51 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_4) / 51)) > 0 and var_39_3 < var_39_6 then
					arg_36_1.talkMaxDuration = var_39_6

					if var_39_6 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_2
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_3, arg_36_1.talkMaxDuration)

			if var_39_2 <= arg_36_1.time_ and arg_36_1.time_ < var_39_2 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_2) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_2 + var_39_7 and arg_36_1.time_ < var_39_2 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play416191009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 416191009
		arg_40_1.duration_ = 6.9

		local var_40_0 = {
			zh = 4.133,
			ja = 6.9
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
				arg_40_0:Play416191010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.475

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_1 = arg_40_1:GetWordFromCfg(416191009)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 19 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 19)

				if (19 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 19)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191009", "story_v_out_416191.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191009", "story_v_out_416191.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_416191", "416191009", "story_v_out_416191.awb")

						arg_40_1:RecordAudio("416191009", var_43_6)
						arg_40_1:RecordAudio("416191009", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_416191", "416191009", "story_v_out_416191.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_416191", "416191009", "story_v_out_416191.awb")
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
	Play416191010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 416191010
		arg_44_1.duration_ = 11.5

		local var_44_0 = {
			zh = 5.6,
			ja = 11.5
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
				arg_44_0:Play416191011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.7

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_1 = arg_44_1:GetWordFromCfg(416191010)
				local var_47_2 = arg_44_1:FormatText(var_47_1.content)

				arg_44_1.text_.text = var_47_2

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 28 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 28)

				if (28 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 28)) > 0 and var_47_0 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + 0
					end
				end

				arg_44_1.text_.text = var_47_2
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191010", "story_v_out_416191.awb") ~= 0 then
					local var_47_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191010", "story_v_out_416191.awb") / 1000

					if var_47_5 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + 0
					end

					if var_47_1.prefab_name ~= "" and arg_44_1.actors_[var_47_1.prefab_name] ~= nil then
						local var_47_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_1.prefab_name].transform, "story_v_out_416191", "416191010", "story_v_out_416191.awb")

						arg_44_1:RecordAudio("416191010", var_47_6)
						arg_44_1:RecordAudio("416191010", var_47_6)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_416191", "416191010", "story_v_out_416191.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_416191", "416191010", "story_v_out_416191.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_7 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_7

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play416191011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 416191011
		arg_48_1.duration_ = 10.13

		local var_48_0 = {
			zh = 6,
			ja = 10.133
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
				arg_48_0:Play416191012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.525

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_1 = arg_48_1:GetWordFromCfg(416191011)
				local var_51_2 = arg_48_1:FormatText(var_51_1.content)

				arg_48_1.text_.text = var_51_2

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 21 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 21)

				if (21 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 21)) > 0 and var_51_0 < var_51_4 then
					arg_48_1.talkMaxDuration = var_51_4

					if var_51_4 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_4 + 0
					end
				end

				arg_48_1.text_.text = var_51_2
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191011", "story_v_out_416191.awb") ~= 0 then
					local var_51_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191011", "story_v_out_416191.awb") / 1000

					if var_51_5 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + 0
					end

					if var_51_1.prefab_name ~= "" and arg_48_1.actors_[var_51_1.prefab_name] ~= nil then
						local var_51_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_1.prefab_name].transform, "story_v_out_416191", "416191011", "story_v_out_416191.awb")

						arg_48_1:RecordAudio("416191011", var_51_6)
						arg_48_1:RecordAudio("416191011", var_51_6)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_416191", "416191011", "story_v_out_416191.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_416191", "416191011", "story_v_out_416191.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_7 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_7 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_7

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_7 and arg_48_1.time_ < 0 + var_51_7 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play416191012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 416191012
		arg_52_1.duration_ = 8.1

		local var_52_0 = {
			zh = 5.566,
			ja = 8.1
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
				arg_52_0:Play416191013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.575

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_1 = arg_52_1:GetWordFromCfg(416191012)
				local var_55_2 = arg_52_1:FormatText(var_55_1.content)

				arg_52_1.text_.text = var_55_2

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 23 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 23)

				if (23 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 23)) > 0 and var_55_0 < var_55_4 then
					arg_52_1.talkMaxDuration = var_55_4

					if var_55_4 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_4 + 0
					end
				end

				arg_52_1.text_.text = var_55_2
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191012", "story_v_out_416191.awb") ~= 0 then
					local var_55_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191012", "story_v_out_416191.awb") / 1000

					if var_55_5 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + 0
					end

					if var_55_1.prefab_name ~= "" and arg_52_1.actors_[var_55_1.prefab_name] ~= nil then
						local var_55_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_1.prefab_name].transform, "story_v_out_416191", "416191012", "story_v_out_416191.awb")

						arg_52_1:RecordAudio("416191012", var_55_6)
						arg_52_1:RecordAudio("416191012", var_55_6)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_416191", "416191012", "story_v_out_416191.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_416191", "416191012", "story_v_out_416191.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_7 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_7 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_7

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_7 and arg_52_1.time_ < 0 + var_55_7 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play416191013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 416191013
		arg_56_1.duration_ = 6.1

		local var_56_0 = {
			zh = 6.1,
			ja = 5.866
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
				arg_56_0:Play416191014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0.575

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_1 = arg_56_1:GetWordFromCfg(416191013)
				local var_59_2 = arg_56_1:FormatText(var_59_1.content)

				arg_56_1.text_.text = var_59_2

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 23 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 23)

				if (23 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 23)) > 0 and var_59_0 < var_59_4 then
					arg_56_1.talkMaxDuration = var_59_4

					if var_59_4 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_4 + 0
					end
				end

				arg_56_1.text_.text = var_59_2
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191013", "story_v_out_416191.awb") ~= 0 then
					local var_59_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191013", "story_v_out_416191.awb") / 1000

					if var_59_5 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + 0
					end

					if var_59_1.prefab_name ~= "" and arg_56_1.actors_[var_59_1.prefab_name] ~= nil then
						local var_59_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_1.prefab_name].transform, "story_v_out_416191", "416191013", "story_v_out_416191.awb")

						arg_56_1:RecordAudio("416191013", var_59_6)
						arg_56_1:RecordAudio("416191013", var_59_6)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_416191", "416191013", "story_v_out_416191.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_416191", "416191013", "story_v_out_416191.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_7 and arg_56_1.time_ < 0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play416191014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 416191014
		arg_60_1.duration_ = 4.9

		local var_60_0 = {
			zh = 3.366,
			ja = 4.9
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
				arg_60_0:Play416191015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.45

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_1 = arg_60_1:GetWordFromCfg(416191014)
				local var_63_2 = arg_60_1:FormatText(var_63_1.content)

				arg_60_1.text_.text = var_63_2

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 18 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 18)

				if (18 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 18)) > 0 and var_63_0 < var_63_4 then
					arg_60_1.talkMaxDuration = var_63_4

					if var_63_4 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_4 + 0
					end
				end

				arg_60_1.text_.text = var_63_2
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191014", "story_v_out_416191.awb") ~= 0 then
					local var_63_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191014", "story_v_out_416191.awb") / 1000

					if var_63_5 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + 0
					end

					if var_63_1.prefab_name ~= "" and arg_60_1.actors_[var_63_1.prefab_name] ~= nil then
						local var_63_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_1.prefab_name].transform, "story_v_out_416191", "416191014", "story_v_out_416191.awb")

						arg_60_1:RecordAudio("416191014", var_63_6)
						arg_60_1:RecordAudio("416191014", var_63_6)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_416191", "416191014", "story_v_out_416191.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_416191", "416191014", "story_v_out_416191.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_7 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_7 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_7

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_7 and arg_60_1.time_ < 0 + var_63_7 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play416191015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 416191015
		arg_64_1.duration_ = 9.6

		local var_64_0 = {
			zh = 6.333,
			ja = 9.6
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
				arg_64_0:Play416191016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.475

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_1 = arg_64_1:GetWordFromCfg(416191015)
				local var_67_2 = arg_64_1:FormatText(var_67_1.content)

				arg_64_1.text_.text = var_67_2

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 19 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 19)

				if (19 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 19)) > 0 and var_67_0 < var_67_4 then
					arg_64_1.talkMaxDuration = var_67_4

					if var_67_4 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_4 + 0
					end
				end

				arg_64_1.text_.text = var_67_2
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191015", "story_v_out_416191.awb") ~= 0 then
					local var_67_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191015", "story_v_out_416191.awb") / 1000

					if var_67_5 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + 0
					end

					if var_67_1.prefab_name ~= "" and arg_64_1.actors_[var_67_1.prefab_name] ~= nil then
						local var_67_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_1.prefab_name].transform, "story_v_out_416191", "416191015", "story_v_out_416191.awb")

						arg_64_1:RecordAudio("416191015", var_67_6)
						arg_64_1:RecordAudio("416191015", var_67_6)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_416191", "416191015", "story_v_out_416191.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_416191", "416191015", "story_v_out_416191.awb")
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
	Play416191016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 416191016
		arg_68_1.duration_ = 6.4

		local var_68_0 = {
			zh = 5.2,
			ja = 6.4
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
				arg_68_0:Play416191017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.625

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_1 = arg_68_1:GetWordFromCfg(416191016)
				local var_71_2 = arg_68_1:FormatText(var_71_1.content)

				arg_68_1.text_.text = var_71_2

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 25 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 25)

				if (25 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 25)) > 0 and var_71_0 < var_71_4 then
					arg_68_1.talkMaxDuration = var_71_4

					if var_71_4 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_4 + 0
					end
				end

				arg_68_1.text_.text = var_71_2
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191016", "story_v_out_416191.awb") ~= 0 then
					local var_71_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191016", "story_v_out_416191.awb") / 1000

					if var_71_5 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + 0
					end

					if var_71_1.prefab_name ~= "" and arg_68_1.actors_[var_71_1.prefab_name] ~= nil then
						local var_71_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_1.prefab_name].transform, "story_v_out_416191", "416191016", "story_v_out_416191.awb")

						arg_68_1:RecordAudio("416191016", var_71_6)
						arg_68_1:RecordAudio("416191016", var_71_6)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_416191", "416191016", "story_v_out_416191.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_416191", "416191016", "story_v_out_416191.awb")
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
	Play416191017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 416191017
		arg_72_1.duration_ = 6.57

		local var_72_0 = {
			zh = 5.566,
			ja = 6.566
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
				arg_72_0:Play416191018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.5

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
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_1 = arg_72_1:GetWordFromCfg(416191017)
				local var_75_2 = arg_72_1:FormatText(var_75_1.content)

				arg_72_1.text_.text = var_75_2

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 20 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 20)

				if (20 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 20)) > 0 and var_75_0 < var_75_4 then
					arg_72_1.talkMaxDuration = var_75_4

					if var_75_4 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_4 + 0
					end
				end

				arg_72_1.text_.text = var_75_2
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191017", "story_v_out_416191.awb") ~= 0 then
					local var_75_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191017", "story_v_out_416191.awb") / 1000

					if var_75_5 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + 0
					end

					if var_75_1.prefab_name ~= "" and arg_72_1.actors_[var_75_1.prefab_name] ~= nil then
						local var_75_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_1.prefab_name].transform, "story_v_out_416191", "416191017", "story_v_out_416191.awb")

						arg_72_1:RecordAudio("416191017", var_75_6)
						arg_72_1:RecordAudio("416191017", var_75_6)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_416191", "416191017", "story_v_out_416191.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_416191", "416191017", "story_v_out_416191.awb")
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
	Play416191018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 416191018
		arg_76_1.duration_ = 7.8

		local var_76_0 = {
			zh = 5.366,
			ja = 7.8
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
				arg_76_0:Play416191019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.5

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_1 = arg_76_1:GetWordFromCfg(416191018)
				local var_79_2 = arg_76_1:FormatText(var_79_1.content)

				arg_76_1.text_.text = var_79_2

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 20 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 20)

				if (20 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 20)) > 0 and var_79_0 < var_79_4 then
					arg_76_1.talkMaxDuration = var_79_4

					if var_79_4 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_4 + 0
					end
				end

				arg_76_1.text_.text = var_79_2
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191018", "story_v_out_416191.awb") ~= 0 then
					local var_79_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191018", "story_v_out_416191.awb") / 1000

					if var_79_5 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + 0
					end

					if var_79_1.prefab_name ~= "" and arg_76_1.actors_[var_79_1.prefab_name] ~= nil then
						local var_79_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_1.prefab_name].transform, "story_v_out_416191", "416191018", "story_v_out_416191.awb")

						arg_76_1:RecordAudio("416191018", var_79_6)
						arg_76_1:RecordAudio("416191018", var_79_6)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_416191", "416191018", "story_v_out_416191.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_416191", "416191018", "story_v_out_416191.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play416191019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 416191019
		arg_80_1.duration_ = 8.73

		local var_80_0 = {
			zh = 4.666,
			ja = 8.733
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
				arg_80_0:Play416191020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.55

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_1 = arg_80_1:GetWordFromCfg(416191019)
				local var_83_2 = arg_80_1:FormatText(var_83_1.content)

				arg_80_1.text_.text = var_83_2

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_4 = 22 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 22)

				if (22 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 22)) > 0 and var_83_0 < var_83_4 then
					arg_80_1.talkMaxDuration = var_83_4

					if var_83_4 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_4 + 0
					end
				end

				arg_80_1.text_.text = var_83_2
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191019", "story_v_out_416191.awb") ~= 0 then
					local var_83_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191019", "story_v_out_416191.awb") / 1000

					if var_83_5 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + 0
					end

					if var_83_1.prefab_name ~= "" and arg_80_1.actors_[var_83_1.prefab_name] ~= nil then
						local var_83_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_1.prefab_name].transform, "story_v_out_416191", "416191019", "story_v_out_416191.awb")

						arg_80_1:RecordAudio("416191019", var_83_6)
						arg_80_1:RecordAudio("416191019", var_83_6)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_416191", "416191019", "story_v_out_416191.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_416191", "416191019", "story_v_out_416191.awb")
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
	Play416191020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 416191020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play416191021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0.1 < arg_84_1.time_ and arg_84_1.time_ <= 0.1 + arg_87_0 then
				arg_84_1:AudioAction("play", "effect", "se_story_139", "se_story_139_metalhit01", "")
			end

			local var_87_1 = 0
			local var_87_2 = 1.7

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_3 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(416191020).content)

				arg_84_1.text_.text = var_87_3

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 68 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_3) / 68)

				if (68 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_3) / 68)) > 0 and var_87_2 < var_87_5 then
					arg_84_1.talkMaxDuration = var_87_5

					if var_87_5 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + var_87_1
					end
				end

				arg_84_1.text_.text = var_87_3
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_6 = math.max(var_87_2, arg_84_1.talkMaxDuration)

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_6 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_1) / var_87_6

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_1 + var_87_6 and arg_84_1.time_ < var_87_1 + var_87_6 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play416191021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 416191021
		arg_88_1.duration_ = 6.07

		local var_88_0 = {
			zh = 4.4,
			ja = 6.066
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
				arg_88_0:Play416191022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0.45

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_1 = arg_88_1:GetWordFromCfg(416191021)
				local var_91_2 = arg_88_1:FormatText(var_91_1.content)

				arg_88_1.text_.text = var_91_2

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_4 = 18 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_2) / 18)

				if (18 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_2) / 18)) > 0 and var_91_0 < var_91_4 then
					arg_88_1.talkMaxDuration = var_91_4

					if var_91_4 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_4 + 0
					end
				end

				arg_88_1.text_.text = var_91_2
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191021", "story_v_out_416191.awb") ~= 0 then
					local var_91_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191021", "story_v_out_416191.awb") / 1000

					if var_91_5 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_5 + 0
					end

					if var_91_1.prefab_name ~= "" and arg_88_1.actors_[var_91_1.prefab_name] ~= nil then
						local var_91_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_1.prefab_name].transform, "story_v_out_416191", "416191021", "story_v_out_416191.awb")

						arg_88_1:RecordAudio("416191021", var_91_6)
						arg_88_1:RecordAudio("416191021", var_91_6)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_416191", "416191021", "story_v_out_416191.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_416191", "416191021", "story_v_out_416191.awb")
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
	Play416191022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 416191022
		arg_92_1.duration_ = 7.47

		local var_92_0 = {
			zh = 4.2,
			ja = 7.466
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
				arg_92_0:Play416191023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0.5

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_1 = arg_92_1:GetWordFromCfg(416191022)
				local var_95_2 = arg_92_1:FormatText(var_95_1.content)

				arg_92_1.text_.text = var_95_2

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_4 = 20 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 20)

				if (20 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 20)) > 0 and var_95_0 < var_95_4 then
					arg_92_1.talkMaxDuration = var_95_4

					if var_95_4 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_4 + 0
					end
				end

				arg_92_1.text_.text = var_95_2
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191022", "story_v_out_416191.awb") ~= 0 then
					local var_95_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191022", "story_v_out_416191.awb") / 1000

					if var_95_5 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + 0
					end

					if var_95_1.prefab_name ~= "" and arg_92_1.actors_[var_95_1.prefab_name] ~= nil then
						local var_95_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_1.prefab_name].transform, "story_v_out_416191", "416191022", "story_v_out_416191.awb")

						arg_92_1:RecordAudio("416191022", var_95_6)
						arg_92_1:RecordAudio("416191022", var_95_6)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_416191", "416191022", "story_v_out_416191.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_416191", "416191022", "story_v_out_416191.awb")
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
	Play416191023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 416191023
		arg_96_1.duration_ = 5.5

		local var_96_0 = {
			zh = 3.966,
			ja = 5.5
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
				arg_96_0:Play416191024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0.425

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_1 = arg_96_1:GetWordFromCfg(416191023)
				local var_99_2 = arg_96_1:FormatText(var_99_1.content)

				arg_96_1.text_.text = var_99_2

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_4 = 18 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 18)

				if (18 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 18)) > 0 and var_99_0 < var_99_4 then
					arg_96_1.talkMaxDuration = var_99_4

					if var_99_4 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_4 + 0
					end
				end

				arg_96_1.text_.text = var_99_2
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191023", "story_v_out_416191.awb") ~= 0 then
					local var_99_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191023", "story_v_out_416191.awb") / 1000

					if var_99_5 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + 0
					end

					if var_99_1.prefab_name ~= "" and arg_96_1.actors_[var_99_1.prefab_name] ~= nil then
						local var_99_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_1.prefab_name].transform, "story_v_out_416191", "416191023", "story_v_out_416191.awb")

						arg_96_1:RecordAudio("416191023", var_99_6)
						arg_96_1:RecordAudio("416191023", var_99_6)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_416191", "416191023", "story_v_out_416191.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_416191", "416191023", "story_v_out_416191.awb")
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
	Play416191024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 416191024
		arg_100_1.duration_ = 5.93

		local var_100_0 = {
			zh = 4.933,
			ja = 5.933
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
				arg_100_0:Play416191025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0.425

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_1 = arg_100_1:GetWordFromCfg(416191024)
				local var_103_2 = arg_100_1:FormatText(var_103_1.content)

				arg_100_1.text_.text = var_103_2

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_4 = 17 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 17)

				if (17 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 17)) > 0 and var_103_0 < var_103_4 then
					arg_100_1.talkMaxDuration = var_103_4

					if var_103_4 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_4 + 0
					end
				end

				arg_100_1.text_.text = var_103_2
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191024", "story_v_out_416191.awb") ~= 0 then
					local var_103_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191024", "story_v_out_416191.awb") / 1000

					if var_103_5 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + 0
					end

					if var_103_1.prefab_name ~= "" and arg_100_1.actors_[var_103_1.prefab_name] ~= nil then
						local var_103_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_1.prefab_name].transform, "story_v_out_416191", "416191024", "story_v_out_416191.awb")

						arg_100_1:RecordAudio("416191024", var_103_6)
						arg_100_1:RecordAudio("416191024", var_103_6)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_416191", "416191024", "story_v_out_416191.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_416191", "416191024", "story_v_out_416191.awb")
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
	Play416191025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 416191025
		arg_104_1.duration_ = 6

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play416191026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.mask_.enabled = true
				arg_104_1.mask_.raycastTarget = true

				arg_104_1:SetGaussion(false)
			end

			local var_107_0 = 1

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 then
				local var_107_1 = Color.New(1, 1, 1)

				var_107_1.a = Mathf.Lerp(1, 0, (arg_104_1.time_ - 0) / var_107_0)
				arg_104_1.mask_.color = var_107_1
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 then
				local var_107_2 = Color.New(1, 1, 1)

				arg_104_1.mask_.enabled = false
				var_107_2.a = 0
				arg_104_1.mask_.color = var_107_2
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				local var_107_3 = arg_104_1.bgs_.SS1608

				arg_104_1.bgs_.SS1608.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_107_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_107_4 = var_107_3:GetComponent("SpriteRenderer")

				if var_107_4 and var_107_4.sprite then
					local var_107_5 = 2 * (var_107_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_107_3.transform.localScale = Vector3.New(var_107_5 / var_107_4.sprite.bounds.size.y < var_107_5 * manager.ui.mainCameraCom_.aspect / var_107_4.sprite.bounds.size.x and var_107_5 * manager.ui.mainCameraCom_.aspect / var_107_4.sprite.bounds.size.x or var_107_5 / var_107_4.sprite.bounds.size.y, var_107_5 / var_107_4.sprite.bounds.size.y < var_107_5 * manager.ui.mainCameraCom_.aspect / var_107_4.sprite.bounds.size.x and var_107_5 * manager.ui.mainCameraCom_.aspect / var_107_4.sprite.bounds.size.x or var_107_5 / var_107_4.sprite.bounds.size.y, 0)
				end

				for iter_107_0, iter_107_1 in pairs(arg_104_1.bgs_) do
					if iter_107_0 ~= "SS1608" then
						iter_107_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0.2 < arg_104_1.time_ and arg_104_1.time_ <= 0.2 + arg_107_0 then
				arg_104_1:AudioAction("play", "effect", "se_story_139", "se_story_139_metalhit02", "")
			end

			if arg_104_1.frameCnt_ <= 1 then
				arg_104_1.dialog_:SetActive(false)
			end

			local var_107_7 = 1
			local var_107_8 = 1.475

			if 1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_7 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0

				arg_104_1.dialog_:SetActive(true)

				arg_104_1.dialogCg_.alpha = 0

				local var_107_9 = LeanTween.value(arg_104_1.dialog_, 0, 1, 0.3)

				var_107_9:setOnUpdate(LuaHelper.FloatAction(function(arg_108_0)
					arg_104_1.dialogCg_.alpha = arg_108_0
				end))
				var_107_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_104_1.dialog_)
					var_107_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_104_1.duration_ = arg_104_1.duration_ + 0.3

				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_10 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(416191025).content)

				arg_104_1.text_.text = var_107_10

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_12 = 59 <= 0 and var_107_8 or var_107_8 * (utf8.len(var_107_10) / 59)

				if (59 <= 0 and var_107_8 or var_107_8 * (utf8.len(var_107_10) / 59)) > 0 and var_107_8 < var_107_12 then
					arg_104_1.talkMaxDuration = var_107_12
					var_107_7 = var_107_7 + 0.3

					if var_107_12 + var_107_7 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_12 + var_107_7
					end
				end

				arg_104_1.text_.text = var_107_10
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_13 = var_107_7 + 0.3
			local var_107_14 = math.max(var_107_8, arg_104_1.talkMaxDuration)

			if var_107_7 + 0.3 <= arg_104_1.time_ and arg_104_1.time_ < var_107_13 + var_107_14 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_13) / var_107_14

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_13 + var_107_14 and arg_104_1.time_ < var_107_13 + var_107_14 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play416191026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 416191026
		arg_110_1.duration_ = 8.4

		local var_110_0 = {
			zh = 3.8,
			ja = 8.4
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
				arg_110_0:Play416191027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.325

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

				local var_113_1 = arg_110_1:GetWordFromCfg(416191026)
				local var_113_2 = arg_110_1:FormatText(var_113_1.content)

				arg_110_1.text_.text = var_113_2

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 13 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 13)

				if (13 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 13)) > 0 and var_113_0 < var_113_4 then
					arg_110_1.talkMaxDuration = var_113_4

					if var_113_4 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_4 + 0
					end
				end

				arg_110_1.text_.text = var_113_2
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191026", "story_v_out_416191.awb") ~= 0 then
					local var_113_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191026", "story_v_out_416191.awb") / 1000

					if var_113_5 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + 0
					end

					if var_113_1.prefab_name ~= "" and arg_110_1.actors_[var_113_1.prefab_name] ~= nil then
						local var_113_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_1.prefab_name].transform, "story_v_out_416191", "416191026", "story_v_out_416191.awb")

						arg_110_1:RecordAudio("416191026", var_113_6)
						arg_110_1:RecordAudio("416191026", var_113_6)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_416191", "416191026", "story_v_out_416191.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_416191", "416191026", "story_v_out_416191.awb")
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
	Play416191027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 416191027
		arg_114_1.duration_ = 5.37

		local var_114_0 = {
			zh = 2.5,
			ja = 5.366
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
				arg_114_0:Play416191028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0.325

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_1 = arg_114_1:GetWordFromCfg(416191027)
				local var_117_2 = arg_114_1:FormatText(var_117_1.content)

				arg_114_1.text_.text = var_117_2

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 13 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 13)

				if (13 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 13)) > 0 and var_117_0 < var_117_4 then
					arg_114_1.talkMaxDuration = var_117_4

					if var_117_4 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_4 + 0
					end
				end

				arg_114_1.text_.text = var_117_2
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191027", "story_v_out_416191.awb") ~= 0 then
					local var_117_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191027", "story_v_out_416191.awb") / 1000

					if var_117_5 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + 0
					end

					if var_117_1.prefab_name ~= "" and arg_114_1.actors_[var_117_1.prefab_name] ~= nil then
						local var_117_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_1.prefab_name].transform, "story_v_out_416191", "416191027", "story_v_out_416191.awb")

						arg_114_1:RecordAudio("416191027", var_117_6)
						arg_114_1:RecordAudio("416191027", var_117_6)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_416191", "416191027", "story_v_out_416191.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_416191", "416191027", "story_v_out_416191.awb")
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
	Play416191028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 416191028
		arg_118_1.duration_ = 9.37

		local var_118_0 = {
			zh = 8.3,
			ja = 9.366
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
				arg_118_0:Play416191029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0.7

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_1 = arg_118_1:GetWordFromCfg(416191028)
				local var_121_2 = arg_118_1:FormatText(var_121_1.content)

				arg_118_1.text_.text = var_121_2

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 28 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 28)

				if (28 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 28)) > 0 and var_121_0 < var_121_4 then
					arg_118_1.talkMaxDuration = var_121_4

					if var_121_4 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_4 + 0
					end
				end

				arg_118_1.text_.text = var_121_2
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191028", "story_v_out_416191.awb") ~= 0 then
					local var_121_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191028", "story_v_out_416191.awb") / 1000

					if var_121_5 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + 0
					end

					if var_121_1.prefab_name ~= "" and arg_118_1.actors_[var_121_1.prefab_name] ~= nil then
						local var_121_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_1.prefab_name].transform, "story_v_out_416191", "416191028", "story_v_out_416191.awb")

						arg_118_1:RecordAudio("416191028", var_121_6)
						arg_118_1:RecordAudio("416191028", var_121_6)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_416191", "416191028", "story_v_out_416191.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_416191", "416191028", "story_v_out_416191.awb")
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
	Play416191029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 416191029
		arg_122_1.duration_ = 9.47

		local var_122_0 = {
			zh = 5.8,
			ja = 9.466
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
				arg_122_0:Play416191030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0.575

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_1 = arg_122_1:GetWordFromCfg(416191029)
				local var_125_2 = arg_122_1:FormatText(var_125_1.content)

				arg_122_1.text_.text = var_125_2

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_4 = 23 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_2) / 23)

				if (23 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_2) / 23)) > 0 and var_125_0 < var_125_4 then
					arg_122_1.talkMaxDuration = var_125_4

					if var_125_4 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_4 + 0
					end
				end

				arg_122_1.text_.text = var_125_2
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191029", "story_v_out_416191.awb") ~= 0 then
					local var_125_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191029", "story_v_out_416191.awb") / 1000

					if var_125_5 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_5 + 0
					end

					if var_125_1.prefab_name ~= "" and arg_122_1.actors_[var_125_1.prefab_name] ~= nil then
						local var_125_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_1.prefab_name].transform, "story_v_out_416191", "416191029", "story_v_out_416191.awb")

						arg_122_1:RecordAudio("416191029", var_125_6)
						arg_122_1:RecordAudio("416191029", var_125_6)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_416191", "416191029", "story_v_out_416191.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_416191", "416191029", "story_v_out_416191.awb")
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
	Play416191030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 416191030
		arg_126_1.duration_ = 4.23

		local var_126_0 = {
			zh = 4.2,
			ja = 4.233
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
				arg_126_0:Play416191031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0.425

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_1 = arg_126_1:GetWordFromCfg(416191030)
				local var_129_2 = arg_126_1:FormatText(var_129_1.content)

				arg_126_1.text_.text = var_129_2

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_4 = 17 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 17)

				if (17 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 17)) > 0 and var_129_0 < var_129_4 then
					arg_126_1.talkMaxDuration = var_129_4

					if var_129_4 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_4 + 0
					end
				end

				arg_126_1.text_.text = var_129_2
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191030", "story_v_out_416191.awb") ~= 0 then
					local var_129_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191030", "story_v_out_416191.awb") / 1000

					if var_129_5 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_5 + 0
					end

					if var_129_1.prefab_name ~= "" and arg_126_1.actors_[var_129_1.prefab_name] ~= nil then
						local var_129_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_1.prefab_name].transform, "story_v_out_416191", "416191030", "story_v_out_416191.awb")

						arg_126_1:RecordAudio("416191030", var_129_6)
						arg_126_1:RecordAudio("416191030", var_129_6)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_416191", "416191030", "story_v_out_416191.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_416191", "416191030", "story_v_out_416191.awb")
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
	Play416191031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 416191031
		arg_130_1.duration_ = 6.3

		local var_130_0 = {
			zh = 6.3,
			ja = 4.366
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
				arg_130_0:Play416191032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0.525

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_1 = arg_130_1:GetWordFromCfg(416191031)
				local var_133_2 = arg_130_1:FormatText(var_133_1.content)

				arg_130_1.text_.text = var_133_2

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 21 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 21)

				if (21 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 21)) > 0 and var_133_0 < var_133_4 then
					arg_130_1.talkMaxDuration = var_133_4

					if var_133_4 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_4 + 0
					end
				end

				arg_130_1.text_.text = var_133_2
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191031", "story_v_out_416191.awb") ~= 0 then
					local var_133_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191031", "story_v_out_416191.awb") / 1000

					if var_133_5 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_5 + 0
					end

					if var_133_1.prefab_name ~= "" and arg_130_1.actors_[var_133_1.prefab_name] ~= nil then
						local var_133_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_1.prefab_name].transform, "story_v_out_416191", "416191031", "story_v_out_416191.awb")

						arg_130_1:RecordAudio("416191031", var_133_6)
						arg_130_1:RecordAudio("416191031", var_133_6)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_416191", "416191031", "story_v_out_416191.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_416191", "416191031", "story_v_out_416191.awb")
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
	Play416191032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 416191032
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play416191033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0.15 < arg_134_1.time_ and arg_134_1.time_ <= 0.15 + arg_137_0 then
				arg_134_1:AudioAction("play", "effect", "se_story_127", "se_story_127_hot", "")
			end

			local var_137_1 = 0
			local var_137_2 = 1.15

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_3 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(416191032).content)

				arg_134_1.text_.text = var_137_3

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_5 = 46 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_3) / 46)

				if (46 <= 0 and var_137_2 or var_137_2 * (utf8.len(var_137_3) / 46)) > 0 and var_137_2 < var_137_5 then
					arg_134_1.talkMaxDuration = var_137_5

					if var_137_5 + var_137_1 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_5 + var_137_1
					end
				end

				arg_134_1.text_.text = var_137_3
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_6 = math.max(var_137_2, arg_134_1.talkMaxDuration)

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_6 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_1) / var_137_6

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_1 + var_137_6 and arg_134_1.time_ < var_137_1 + var_137_6 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play416191033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 416191033
		arg_138_1.duration_ = 12

		local var_138_0 = {
			zh = 8.966,
			ja = 12
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
				arg_138_0:Play416191034(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 1.025

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_1 = arg_138_1:GetWordFromCfg(416191033)
				local var_141_2 = arg_138_1:FormatText(var_141_1.content)

				arg_138_1.text_.text = var_141_2

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_4 = 41 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_2) / 41)

				if (41 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_2) / 41)) > 0 and var_141_0 < var_141_4 then
					arg_138_1.talkMaxDuration = var_141_4

					if var_141_4 + 0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_4 + 0
					end
				end

				arg_138_1.text_.text = var_141_2
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191033", "story_v_out_416191.awb") ~= 0 then
					local var_141_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191033", "story_v_out_416191.awb") / 1000

					if var_141_5 + 0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_5 + 0
					end

					if var_141_1.prefab_name ~= "" and arg_138_1.actors_[var_141_1.prefab_name] ~= nil then
						local var_141_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_1.prefab_name].transform, "story_v_out_416191", "416191033", "story_v_out_416191.awb")

						arg_138_1:RecordAudio("416191033", var_141_6)
						arg_138_1:RecordAudio("416191033", var_141_6)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_416191", "416191033", "story_v_out_416191.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_416191", "416191033", "story_v_out_416191.awb")
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
	Play416191034 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 416191034
		arg_142_1.duration_ = 14.77

		local var_142_0 = {
			zh = 10.766,
			ja = 14.766
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
				arg_142_0:Play416191035(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 0.9

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_1 = arg_142_1:GetWordFromCfg(416191034)
				local var_145_2 = arg_142_1:FormatText(var_145_1.content)

				arg_142_1.text_.text = var_145_2

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_4 = 36 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_2) / 36)

				if (36 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_2) / 36)) > 0 and var_145_0 < var_145_4 then
					arg_142_1.talkMaxDuration = var_145_4

					if var_145_4 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_4 + 0
					end
				end

				arg_142_1.text_.text = var_145_2
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191034", "story_v_out_416191.awb") ~= 0 then
					local var_145_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191034", "story_v_out_416191.awb") / 1000

					if var_145_5 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + 0
					end

					if var_145_1.prefab_name ~= "" and arg_142_1.actors_[var_145_1.prefab_name] ~= nil then
						local var_145_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_1.prefab_name].transform, "story_v_out_416191", "416191034", "story_v_out_416191.awb")

						arg_142_1:RecordAudio("416191034", var_145_6)
						arg_142_1:RecordAudio("416191034", var_145_6)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_416191", "416191034", "story_v_out_416191.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_416191", "416191034", "story_v_out_416191.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_7 = math.max(var_145_0, arg_142_1.talkMaxDuration)

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_7 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - 0) / var_145_7

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= 0 + var_145_7 and arg_142_1.time_ < 0 + var_145_7 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play416191035 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 416191035
		arg_146_1.duration_ = 6.2

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play416191036(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				local var_149_0 = arg_146_1.var_.effect778

				if not arg_146_1.var_.effect778 then
					var_149_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_149_0.name = "778"
					arg_146_1.var_.effect778 = var_149_0
				else
					var_149_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_149_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_149_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_149_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_149_3 = var_149_0.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_149_0, iter_149_1 in ipairs((var_149_3:ToTable())) do
					iter_149_1.transform.localScale = Vector3.New(iter_149_1.transform.localScale.x / var_149_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_149_3 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_149_1.transform.localScale.y / var_149_2, iter_149_1.transform.localScale.z)
				end
			end

			local var_149_5 = arg_146_1.bgs_.SS1608.transform

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPosSS1608 = var_149_5.localPosition
			end

			local var_149_6 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_6 then
				var_149_5.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPosSS1608, Vector3.New(0, 1, 10), (arg_146_1.time_ - 0) / var_149_6)
			end

			if arg_146_1.time_ >= 0 + var_149_6 and arg_146_1.time_ < 0 + var_149_6 + arg_149_0 then
				var_149_5.localPosition = Vector3.New(0, 1, 10)
			end

			local var_149_7 = arg_146_1.bgs_.SS1608.transform

			if 0.034 < arg_146_1.time_ and arg_146_1.time_ <= 0.034 + arg_149_0 then
				arg_146_1.var_.moveOldPosSS1608 = var_149_7.localPosition
			end

			local var_149_8 = 1.83266666666667

			if 0.034 <= arg_146_1.time_ and arg_146_1.time_ < 0.034 + var_149_8 then
				var_149_7.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPosSS1608, Vector3.New(0, 1, 9), (arg_146_1.time_ - 0.034) / var_149_8)
			end

			if arg_146_1.time_ >= 0.034 + var_149_8 and arg_146_1.time_ < 0.034 + var_149_8 + arg_149_0 then
				var_149_7.localPosition = Vector3.New(0, 1, 9)
			end

			if arg_146_1.frameCnt_ <= 1 then
				arg_146_1.dialog_:SetActive(false)
			end

			local var_149_9 = 1.2
			local var_149_10 = 1.425

			if 1.2 < arg_146_1.time_ and arg_146_1.time_ <= var_149_9 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0

				arg_146_1.dialog_:SetActive(true)

				arg_146_1.dialogCg_.alpha = 0

				local var_149_11 = LeanTween.value(arg_146_1.dialog_, 0, 1, 0.3)

				var_149_11:setOnUpdate(LuaHelper.FloatAction(function(arg_150_0)
					arg_146_1.dialogCg_.alpha = arg_150_0
				end))
				var_149_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_146_1.dialog_)
					var_149_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_146_1.duration_ = arg_146_1.duration_ + 0.3

				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_12 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(416191035).content)

				arg_146_1.text_.text = var_149_12

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_14 = 57 <= 0 and var_149_10 or var_149_10 * (utf8.len(var_149_12) / 57)

				if (57 <= 0 and var_149_10 or var_149_10 * (utf8.len(var_149_12) / 57)) > 0 and var_149_10 < var_149_14 then
					arg_146_1.talkMaxDuration = var_149_14
					var_149_9 = var_149_9 + 0.3

					if var_149_14 + var_149_9 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_14 + var_149_9
					end
				end

				arg_146_1.text_.text = var_149_12
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_15 = var_149_9 + 0.3
			local var_149_16 = math.max(var_149_10, arg_146_1.talkMaxDuration)

			if var_149_9 + 0.3 <= arg_146_1.time_ and arg_146_1.time_ < var_149_15 + var_149_16 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_15) / var_149_16

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_15 + var_149_16 and arg_146_1.time_ < var_149_15 + var_149_16 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1608",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1608",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.83266666666667,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play416191036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 416191036
		arg_152_1.duration_ = 6.73

		local var_152_0 = {
			zh = 5.133,
			ja = 6.733
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
				arg_152_0:Play416191037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0.575

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_1 = arg_152_1:GetWordFromCfg(416191036)
				local var_155_2 = arg_152_1:FormatText(var_155_1.content)

				arg_152_1.text_.text = var_155_2

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_4 = 23 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 23)

				if (23 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 23)) > 0 and var_155_0 < var_155_4 then
					arg_152_1.talkMaxDuration = var_155_4

					if var_155_4 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_4 + 0
					end
				end

				arg_152_1.text_.text = var_155_2
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191036", "story_v_out_416191.awb") ~= 0 then
					local var_155_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191036", "story_v_out_416191.awb") / 1000

					if var_155_5 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + 0
					end

					if var_155_1.prefab_name ~= "" and arg_152_1.actors_[var_155_1.prefab_name] ~= nil then
						local var_155_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_1.prefab_name].transform, "story_v_out_416191", "416191036", "story_v_out_416191.awb")

						arg_152_1:RecordAudio("416191036", var_155_6)
						arg_152_1:RecordAudio("416191036", var_155_6)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_416191", "416191036", "story_v_out_416191.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_416191", "416191036", "story_v_out_416191.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_7 = math.max(var_155_0, arg_152_1.talkMaxDuration)

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_7 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - 0) / var_155_7

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= 0 + var_155_7 and arg_152_1.time_ < 0 + var_155_7 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play416191037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 416191037
		arg_156_1.duration_ = 6.43

		local var_156_0 = {
			zh = 3.9,
			ja = 6.433
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play416191038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0.325

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_1 = arg_156_1:GetWordFromCfg(416191037)
				local var_159_2 = arg_156_1:FormatText(var_159_1.content)

				arg_156_1.text_.text = var_159_2

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_4 = 13 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 13)

				if (13 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 13)) > 0 and var_159_0 < var_159_4 then
					arg_156_1.talkMaxDuration = var_159_4

					if var_159_4 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_4 + 0
					end
				end

				arg_156_1.text_.text = var_159_2
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191037", "story_v_out_416191.awb") ~= 0 then
					local var_159_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191037", "story_v_out_416191.awb") / 1000

					if var_159_5 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + 0
					end

					if var_159_1.prefab_name ~= "" and arg_156_1.actors_[var_159_1.prefab_name] ~= nil then
						local var_159_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_1.prefab_name].transform, "story_v_out_416191", "416191037", "story_v_out_416191.awb")

						arg_156_1:RecordAudio("416191037", var_159_6)
						arg_156_1:RecordAudio("416191037", var_159_6)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_416191", "416191037", "story_v_out_416191.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_416191", "416191037", "story_v_out_416191.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_7 = math.max(var_159_0, arg_156_1.talkMaxDuration)

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_7 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - 0) / var_159_7

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= 0 + var_159_7 and arg_156_1.time_ < 0 + var_159_7 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play416191038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 416191038
		arg_160_1.duration_ = 7.67

		local var_160_0 = {
			zh = 7.666,
			ja = 5.7
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play416191039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0.65

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_1 = arg_160_1:GetWordFromCfg(416191038)
				local var_163_2 = arg_160_1:FormatText(var_163_1.content)

				arg_160_1.text_.text = var_163_2

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_4 = 26 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 26)

				if (26 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 26)) > 0 and var_163_0 < var_163_4 then
					arg_160_1.talkMaxDuration = var_163_4

					if var_163_4 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_4 + 0
					end
				end

				arg_160_1.text_.text = var_163_2
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191038", "story_v_out_416191.awb") ~= 0 then
					local var_163_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191038", "story_v_out_416191.awb") / 1000

					if var_163_5 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + 0
					end

					if var_163_1.prefab_name ~= "" and arg_160_1.actors_[var_163_1.prefab_name] ~= nil then
						local var_163_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_1.prefab_name].transform, "story_v_out_416191", "416191038", "story_v_out_416191.awb")

						arg_160_1:RecordAudio("416191038", var_163_6)
						arg_160_1:RecordAudio("416191038", var_163_6)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_416191", "416191038", "story_v_out_416191.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_416191", "416191038", "story_v_out_416191.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_7 = math.max(var_163_0, arg_160_1.talkMaxDuration)

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_7 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - 0) / var_163_7

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= 0 + var_163_7 and arg_160_1.time_ < 0 + var_163_7 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play416191039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 416191039
		arg_164_1.duration_ = 5.27

		local var_164_0 = {
			zh = 4.3,
			ja = 5.266
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play416191040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0.425

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_1 = arg_164_1:GetWordFromCfg(416191039)
				local var_167_2 = arg_164_1:FormatText(var_167_1.content)

				arg_164_1.text_.text = var_167_2

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_4 = 17 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_2) / 17)

				if (17 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_2) / 17)) > 0 and var_167_0 < var_167_4 then
					arg_164_1.talkMaxDuration = var_167_4

					if var_167_4 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_4 + 0
					end
				end

				arg_164_1.text_.text = var_167_2
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191039", "story_v_out_416191.awb") ~= 0 then
					local var_167_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191039", "story_v_out_416191.awb") / 1000

					if var_167_5 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_5 + 0
					end

					if var_167_1.prefab_name ~= "" and arg_164_1.actors_[var_167_1.prefab_name] ~= nil then
						local var_167_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_1.prefab_name].transform, "story_v_out_416191", "416191039", "story_v_out_416191.awb")

						arg_164_1:RecordAudio("416191039", var_167_6)
						arg_164_1:RecordAudio("416191039", var_167_6)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_416191", "416191039", "story_v_out_416191.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_416191", "416191039", "story_v_out_416191.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_7 = math.max(var_167_0, arg_164_1.talkMaxDuration)

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_7 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - 0) / var_167_7

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= 0 + var_167_7 and arg_164_1.time_ < 0 + var_167_7 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play416191040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 416191040
		arg_168_1.duration_ = 9.97

		local var_168_0 = {
			zh = 5.666,
			ja = 9.966
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
				arg_168_0:Play416191041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0.525

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_1 = arg_168_1:GetWordFromCfg(416191040)
				local var_171_2 = arg_168_1:FormatText(var_171_1.content)

				arg_168_1.text_.text = var_171_2

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_4 = 21 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 21)

				if (21 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 21)) > 0 and var_171_0 < var_171_4 then
					arg_168_1.talkMaxDuration = var_171_4

					if var_171_4 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_4 + 0
					end
				end

				arg_168_1.text_.text = var_171_2
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191040", "story_v_out_416191.awb") ~= 0 then
					local var_171_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191040", "story_v_out_416191.awb") / 1000

					if var_171_5 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_5 + 0
					end

					if var_171_1.prefab_name ~= "" and arg_168_1.actors_[var_171_1.prefab_name] ~= nil then
						local var_171_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_1.prefab_name].transform, "story_v_out_416191", "416191040", "story_v_out_416191.awb")

						arg_168_1:RecordAudio("416191040", var_171_6)
						arg_168_1:RecordAudio("416191040", var_171_6)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_416191", "416191040", "story_v_out_416191.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_416191", "416191040", "story_v_out_416191.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_7 = math.max(var_171_0, arg_168_1.talkMaxDuration)

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_7 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - 0) / var_171_7

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= 0 + var_171_7 and arg_168_1.time_ < 0 + var_171_7 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play416191041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 416191041
		arg_172_1.duration_ = 6.03

		local var_172_0 = {
			zh = 6.033,
			ja = 5.433
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play416191042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0.275

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_1 = arg_172_1:GetWordFromCfg(416191041)
				local var_175_2 = arg_172_1:FormatText(var_175_1.content)

				arg_172_1.text_.text = var_175_2

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_4 = 11 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 11)

				if (11 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 11)) > 0 and var_175_0 < var_175_4 then
					arg_172_1.talkMaxDuration = var_175_4

					if var_175_4 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_4 + 0
					end
				end

				arg_172_1.text_.text = var_175_2
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191041", "story_v_out_416191.awb") ~= 0 then
					local var_175_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191041", "story_v_out_416191.awb") / 1000

					if var_175_5 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + 0
					end

					if var_175_1.prefab_name ~= "" and arg_172_1.actors_[var_175_1.prefab_name] ~= nil then
						local var_175_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_1.prefab_name].transform, "story_v_out_416191", "416191041", "story_v_out_416191.awb")

						arg_172_1:RecordAudio("416191041", var_175_6)
						arg_172_1:RecordAudio("416191041", var_175_6)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_416191", "416191041", "story_v_out_416191.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_416191", "416191041", "story_v_out_416191.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_7 = math.max(var_175_0, arg_172_1.talkMaxDuration)

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_7 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - 0) / var_175_7

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= 0 + var_175_7 and arg_172_1.time_ < 0 + var_175_7 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play416191042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 416191042
		arg_176_1.duration_ = 6.67

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play416191043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0.766666666666667 < arg_176_1.time_ and arg_176_1.time_ <= 0.766666666666667 + arg_179_0 then
				local var_179_0 = arg_176_1.bgs_.STwhite

				arg_176_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_179_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_179_1 = var_179_0:GetComponent("SpriteRenderer")

				if var_179_1 and var_179_1.sprite then
					local var_179_2 = 2 * (var_179_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_179_0.transform.localScale = Vector3.New(var_179_2 / var_179_1.sprite.bounds.size.y < var_179_2 * manager.ui.mainCameraCom_.aspect / var_179_1.sprite.bounds.size.x and var_179_2 * manager.ui.mainCameraCom_.aspect / var_179_1.sprite.bounds.size.x or var_179_2 / var_179_1.sprite.bounds.size.y, var_179_2 / var_179_1.sprite.bounds.size.y < var_179_2 * manager.ui.mainCameraCom_.aspect / var_179_1.sprite.bounds.size.x and var_179_2 * manager.ui.mainCameraCom_.aspect / var_179_1.sprite.bounds.size.x or var_179_2 / var_179_1.sprite.bounds.size.y, 0)
				end

				for iter_179_0, iter_179_1 in pairs(arg_176_1.bgs_) do
					if iter_179_0 ~= "STwhite" then
						iter_179_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_179_3 = 0

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_3 + arg_179_0 then
				arg_176_1.mask_.enabled = true
				arg_176_1.mask_.raycastTarget = true

				arg_176_1:SetGaussion(false)
			end

			local var_179_4 = 0.766666666666667

			if var_179_3 <= arg_176_1.time_ and arg_176_1.time_ < var_179_3 + var_179_4 then
				local var_179_5 = Color.New(1, 1, 1)

				var_179_5.a = Mathf.Lerp(0, 1, (arg_176_1.time_ - var_179_3) / var_179_4)
				arg_176_1.mask_.color = var_179_5
			end

			if arg_176_1.time_ >= var_179_3 + var_179_4 and arg_176_1.time_ < var_179_3 + var_179_4 + arg_179_0 then
				local var_179_6 = Color.New(1, 1, 1)

				var_179_6.a = 1
				arg_176_1.mask_.color = var_179_6
			end

			local var_179_7 = 0.766666666666667

			if 0.766666666666667 < arg_176_1.time_ and arg_176_1.time_ <= var_179_7 + arg_179_0 then
				arg_176_1.mask_.enabled = true
				arg_176_1.mask_.raycastTarget = true

				arg_176_1:SetGaussion(false)
			end

			local var_179_8 = 1.23333333333333

			if var_179_7 <= arg_176_1.time_ and arg_176_1.time_ < var_179_7 + var_179_8 then
				local var_179_9 = Color.New(1, 1, 1)

				var_179_9.a = Mathf.Lerp(1, 0, (arg_176_1.time_ - var_179_7) / var_179_8)
				arg_176_1.mask_.color = var_179_9
			end

			if arg_176_1.time_ >= var_179_7 + var_179_8 and arg_176_1.time_ < var_179_7 + var_179_8 + arg_179_0 then
				local var_179_10 = Color.New(1, 1, 1)

				arg_176_1.mask_.enabled = false
				var_179_10.a = 0
				arg_176_1.mask_.color = var_179_10
			end

			if 1.33333333333333 < arg_176_1.time_ and arg_176_1.time_ <= 1.33333333333333 + arg_179_0 then
				arg_176_1:AudioAction("play", "effect", "se_story_11", "se_story_11_fire", "")
			end

			if arg_176_1.frameCnt_ <= 1 then
				arg_176_1.dialog_:SetActive(false)
			end

			local var_179_12 = 1.66666666666667
			local var_179_13 = 1.475

			if 1.66666666666667 < arg_176_1.time_ and arg_176_1.time_ <= var_179_12 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0

				arg_176_1.dialog_:SetActive(true)

				arg_176_1.dialogCg_.alpha = 0

				local var_179_14 = LeanTween.value(arg_176_1.dialog_, 0, 1, 0.3)

				var_179_14:setOnUpdate(LuaHelper.FloatAction(function(arg_180_0)
					arg_176_1.dialogCg_.alpha = arg_180_0
				end))
				var_179_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_176_1.dialog_)
					var_179_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_176_1.duration_ = arg_176_1.duration_ + 0.3

				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_15 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(416191042).content)

				arg_176_1.text_.text = var_179_15

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_17 = 59 <= 0 and var_179_13 or var_179_13 * (utf8.len(var_179_15) / 59)

				if (59 <= 0 and var_179_13 or var_179_13 * (utf8.len(var_179_15) / 59)) > 0 and var_179_13 < var_179_17 then
					arg_176_1.talkMaxDuration = var_179_17
					var_179_12 = var_179_12 + 0.3

					if var_179_17 + var_179_12 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_17 + var_179_12
					end
				end

				arg_176_1.text_.text = var_179_15
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_18 = var_179_12 + 0.3
			local var_179_19 = math.max(var_179_13, arg_176_1.talkMaxDuration)

			if var_179_12 + 0.3 <= arg_176_1.time_ and arg_176_1.time_ < var_179_18 + var_179_19 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_18) / var_179_19

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_18 + var_179_19 and arg_176_1.time_ < var_179_18 + var_179_19 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play416191043 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 416191043
		arg_182_1.duration_ = 8.17

		local var_182_0 = {
			zh = 6.866,
			ja = 8.166
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
				arg_182_0:Play416191044(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0.525

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_6")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_1 = arg_182_1:GetWordFromCfg(416191043)
				local var_185_2 = arg_182_1:FormatText(var_185_1.content)

				arg_182_1.text_.text = var_185_2

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_4 = 21 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_2) / 21)

				if (21 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_2) / 21)) > 0 and var_185_0 < var_185_4 then
					arg_182_1.talkMaxDuration = var_185_4

					if var_185_4 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_4 + 0
					end
				end

				arg_182_1.text_.text = var_185_2
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191043", "story_v_out_416191.awb") ~= 0 then
					local var_185_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191043", "story_v_out_416191.awb") / 1000

					if var_185_5 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_5 + 0
					end

					if var_185_1.prefab_name ~= "" and arg_182_1.actors_[var_185_1.prefab_name] ~= nil then
						local var_185_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_1.prefab_name].transform, "story_v_out_416191", "416191043", "story_v_out_416191.awb")

						arg_182_1:RecordAudio("416191043", var_185_6)
						arg_182_1:RecordAudio("416191043", var_185_6)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_416191", "416191043", "story_v_out_416191.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_416191", "416191043", "story_v_out_416191.awb")
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
	Play416191044 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 416191044
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play416191045(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0
			local var_189_1 = 1.125

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0

				arg_186_1.dialog_:SetActive(true)

				arg_186_1.dialogCg_.alpha = 0

				local var_189_2 = LeanTween.value(arg_186_1.dialog_, 0, 1, 0.3)

				var_189_2:setOnUpdate(LuaHelper.FloatAction(function(arg_190_0)
					arg_186_1.dialogCg_.alpha = arg_190_0
				end))
				var_189_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_186_1.dialog_)
					var_189_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_186_1.duration_ = arg_186_1.duration_ + 0.3

				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_3 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(416191044).content)

				arg_186_1.text_.text = var_189_3

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_5 = 45 <= 0 and var_189_1 or var_189_1 * (utf8.len(var_189_3) / 45)

				if (45 <= 0 and var_189_1 or var_189_1 * (utf8.len(var_189_3) / 45)) > 0 and var_189_1 < var_189_5 then
					arg_186_1.talkMaxDuration = var_189_5
					var_189_0 = var_189_0 + 0.3

					if var_189_5 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_5 + var_189_0
					end
				end

				arg_186_1.text_.text = var_189_3
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_6 = var_189_0 + 0.3
			local var_189_7 = math.max(var_189_1, arg_186_1.talkMaxDuration)

			if var_189_0 + 0.3 <= arg_186_1.time_ and arg_186_1.time_ < var_189_6 + var_189_7 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_6) / var_189_7

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_6 + var_189_7 and arg_186_1.time_ < var_189_6 + var_189_7 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play416191045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 416191045
		arg_192_1.duration_ = 7.77

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play416191046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if arg_192_1.bgs_.F09f == nil then
				local var_195_0 = Object.Instantiate(arg_192_1.paintGo_)

				var_195_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F09f")
				var_195_0.name = "F09f"
				var_195_0.transform.parent = arg_192_1.stage_.transform
				var_195_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_192_1.bgs_.F09f = var_195_0
			end

			if 1.33333333333333 < arg_192_1.time_ and arg_192_1.time_ <= 1.33333333333333 + arg_195_0 then
				local var_195_1 = arg_192_1.bgs_.F09f

				arg_192_1.bgs_.F09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_195_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_195_2 = var_195_1:GetComponent("SpriteRenderer")

				if var_195_2 and var_195_2.sprite then
					local var_195_3 = 2 * (var_195_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_195_1.transform.localScale = Vector3.New(var_195_3 / var_195_2.sprite.bounds.size.y < var_195_3 * manager.ui.mainCameraCom_.aspect / var_195_2.sprite.bounds.size.x and var_195_3 * manager.ui.mainCameraCom_.aspect / var_195_2.sprite.bounds.size.x or var_195_3 / var_195_2.sprite.bounds.size.y, var_195_3 / var_195_2.sprite.bounds.size.y < var_195_3 * manager.ui.mainCameraCom_.aspect / var_195_2.sprite.bounds.size.x and var_195_3 * manager.ui.mainCameraCom_.aspect / var_195_2.sprite.bounds.size.x or var_195_3 / var_195_2.sprite.bounds.size.y, 0)
				end

				for iter_195_0, iter_195_1 in pairs(arg_192_1.bgs_) do
					if iter_195_0 ~= "F09f" then
						iter_195_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_195_4 = 0

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_4 + arg_195_0 then
				arg_192_1.allBtn_.enabled = false
			end

			if arg_192_1.time_ >= var_195_4 + 0.3 and arg_192_1.time_ < var_195_4 + 0.3 + arg_195_0 then
				arg_192_1.allBtn_.enabled = true
			end

			local var_195_5 = 0

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_5 + arg_195_0 then
				arg_192_1.mask_.enabled = true
				arg_192_1.mask_.raycastTarget = true

				arg_192_1:SetGaussion(false)
			end

			local var_195_6 = 1.33333333333333

			if var_195_5 <= arg_192_1.time_ and arg_192_1.time_ < var_195_5 + var_195_6 then
				local var_195_7 = Color.New(0, 0, 0)

				var_195_7.a = Mathf.Lerp(0, 1, (arg_192_1.time_ - var_195_5) / var_195_6)
				arg_192_1.mask_.color = var_195_7
			end

			if arg_192_1.time_ >= var_195_5 + var_195_6 and arg_192_1.time_ < var_195_5 + var_195_6 + arg_195_0 then
				local var_195_8 = Color.New(0, 0, 0)

				var_195_8.a = 1
				arg_192_1.mask_.color = var_195_8
			end

			local var_195_9 = 1.33333333333333

			if 1.33333333333333 < arg_192_1.time_ and arg_192_1.time_ <= var_195_9 + arg_195_0 then
				arg_192_1.mask_.enabled = true
				arg_192_1.mask_.raycastTarget = true

				arg_192_1:SetGaussion(false)
			end

			local var_195_10 = 1.53333333333333

			if var_195_9 <= arg_192_1.time_ and arg_192_1.time_ < var_195_9 + var_195_10 then
				local var_195_11 = Color.New(0, 0, 0)

				var_195_11.a = Mathf.Lerp(1, 0, (arg_192_1.time_ - var_195_9) / var_195_10)
				arg_192_1.mask_.color = var_195_11
			end

			if arg_192_1.time_ >= var_195_9 + var_195_10 and arg_192_1.time_ < var_195_9 + var_195_10 + arg_195_0 then
				local var_195_12 = Color.New(0, 0, 0)

				arg_192_1.mask_.enabled = false
				var_195_12.a = 0
				arg_192_1.mask_.color = var_195_12
			end

			if 1.33333333333333 < arg_192_1.time_ and arg_192_1.time_ <= 1.33333333333333 + arg_195_0 then
				arg_192_1:AudioAction("play", "effect", "se_story_139", "se_story_139_metalhit03", "")
			end

			if arg_192_1.frameCnt_ <= 1 then
				arg_192_1.dialog_:SetActive(false)
			end

			local var_195_14 = 2.76666666666667
			local var_195_15 = 1.075

			if 2.76666666666667 < arg_192_1.time_ and arg_192_1.time_ <= var_195_14 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0

				arg_192_1.dialog_:SetActive(true)

				arg_192_1.dialogCg_.alpha = 0

				local var_195_16 = LeanTween.value(arg_192_1.dialog_, 0, 1, 0.3)

				var_195_16:setOnUpdate(LuaHelper.FloatAction(function(arg_196_0)
					arg_192_1.dialogCg_.alpha = arg_196_0
				end))
				var_195_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_192_1.dialog_)
					var_195_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_192_1.duration_ = arg_192_1.duration_ + 0.3

				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_17 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(416191045).content)

				arg_192_1.text_.text = var_195_17

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_19 = 43 <= 0 and var_195_15 or var_195_15 * (utf8.len(var_195_17) / 43)

				if (43 <= 0 and var_195_15 or var_195_15 * (utf8.len(var_195_17) / 43)) > 0 and var_195_15 < var_195_19 then
					arg_192_1.talkMaxDuration = var_195_19
					var_195_14 = var_195_14 + 0.3

					if var_195_19 + var_195_14 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_19 + var_195_14
					end
				end

				arg_192_1.text_.text = var_195_17
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_20 = var_195_14 + 0.3
			local var_195_21 = math.max(var_195_15, arg_192_1.talkMaxDuration)

			if var_195_14 + 0.3 <= arg_192_1.time_ and arg_192_1.time_ < var_195_20 + var_195_21 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_20) / var_195_21

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_20 + var_195_21 and arg_192_1.time_ < var_195_20 + var_195_21 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play416191046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 416191046
		arg_198_1.duration_ = 6

		local var_198_0 = {
			zh = 6,
			ja = 3.1
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
				arg_198_0:Play416191047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if arg_198_1.actors_["1028"] == nil then
				local var_201_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

				if not isNil(var_201_0) then
					local var_201_1 = Object.Instantiate(var_201_0, arg_198_1.canvasGo_.transform)

					var_201_1.transform:SetSiblingIndex(1)

					var_201_1.name = "1028"
					var_201_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_198_1.actors_["1028"] = var_201_1

					if arg_198_1.isInRecall_ then
						for iter_201_0, iter_201_1 in ipairs((var_201_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_201_1.color = arg_198_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_201_2 = arg_198_1.actors_["1028"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_2) and arg_198_1.var_.actorSpriteComps1028 == nil then
				arg_198_1.var_.actorSpriteComps1028 = var_201_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_3 = 0.2

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_3 and not isNil(var_201_2) then
				if arg_198_1.var_.actorSpriteComps1028 then
					for iter_201_2, iter_201_3 in pairs(arg_198_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_201_3 then
							if arg_198_1.isInRecall_ then
								iter_201_3.color = Color.New(Mathf.Lerp(iter_201_3.color.r, arg_198_1.hightColor1.r, (arg_198_1.time_ - 0) / var_201_3), Mathf.Lerp(iter_201_3.color.g, arg_198_1.hightColor1.g, (arg_198_1.time_ - 0) / var_201_3), (Mathf.Lerp(iter_201_3.color.b, arg_198_1.hightColor1.b, (arg_198_1.time_ - 0) / var_201_3)))
							else
								local var_201_4 = Mathf.Lerp(iter_201_3.color.r, 1, (arg_198_1.time_ - 0) / var_201_3)

								iter_201_3.color = Color.New(var_201_4, var_201_4, var_201_4)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= 0 + var_201_3 and arg_198_1.time_ < 0 + var_201_3 + arg_201_0 and not isNil(var_201_2) and arg_198_1.var_.actorSpriteComps1028 then
				for iter_201_4, iter_201_5 in pairs(arg_198_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_201_5 then
						iter_201_5.color = arg_198_1.isInRecall_ and (arg_198_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_198_1.var_.actorSpriteComps1028 = nil
			end

			local var_201_5 = arg_198_1.actors_["1028"].transform

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1028 = var_201_5.localPosition
				var_201_5.localScale = Vector3.New(1, 1, 1)

				arg_198_1:CheckSpriteTmpPos("1028", 3)

				for iter_201_6 = 0, var_201_5.childCount - 1 do
					local var_201_6 = var_201_5:GetChild(iter_201_6)

					if var_201_6.name == "split_2" or not string.find(var_201_6.name, "split") then
						var_201_6.gameObject:SetActive(true)
					else
						var_201_6.gameObject:SetActive(false)
					end
				end
			end

			local var_201_7 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_7 then
				var_201_5.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_198_1.time_ - 0) / var_201_7)
			end

			if arg_198_1.time_ >= 0 + var_201_7 and arg_198_1.time_ < 0 + var_201_7 + arg_201_0 then
				var_201_5.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_201_8 = 0
			local var_201_9 = 0.25

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_8 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_10 = arg_198_1:GetWordFromCfg(416191046)
				local var_201_11 = arg_198_1:FormatText(var_201_10.content)

				arg_198_1.text_.text = var_201_11

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_13 = 10 <= 0 and var_201_9 or var_201_9 * (utf8.len(var_201_11) / 10)

				if (10 <= 0 and var_201_9 or var_201_9 * (utf8.len(var_201_11) / 10)) > 0 and var_201_9 < var_201_13 then
					arg_198_1.talkMaxDuration = var_201_13

					if var_201_13 + var_201_8 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_13 + var_201_8
					end
				end

				arg_198_1.text_.text = var_201_11
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191046", "story_v_out_416191.awb") ~= 0 then
					local var_201_14 = manager.audio:GetVoiceLength("story_v_out_416191", "416191046", "story_v_out_416191.awb") / 1000

					if var_201_14 + var_201_8 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_14 + var_201_8
					end

					if var_201_10.prefab_name ~= "" and arg_198_1.actors_[var_201_10.prefab_name] ~= nil then
						local var_201_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_10.prefab_name].transform, "story_v_out_416191", "416191046", "story_v_out_416191.awb")

						arg_198_1:RecordAudio("416191046", var_201_15)
						arg_198_1:RecordAudio("416191046", var_201_15)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_416191", "416191046", "story_v_out_416191.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_416191", "416191046", "story_v_out_416191.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_16 = math.max(var_201_9, arg_198_1.talkMaxDuration)

			if var_201_8 <= arg_198_1.time_ and arg_198_1.time_ < var_201_8 + var_201_16 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_8) / var_201_16

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_8 + var_201_16 and arg_198_1.time_ < var_201_8 + var_201_16 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play416191047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 416191047
		arg_202_1.duration_ = 6.1

		local var_202_0 = {
			zh = 6.1,
			ja = 5.866
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
				arg_202_0:Play416191048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if arg_202_1.actors_["1086"] == nil then
				local var_205_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

				if not isNil(var_205_0) then
					local var_205_1 = Object.Instantiate(var_205_0, arg_202_1.canvasGo_.transform)

					var_205_1.transform:SetSiblingIndex(1)

					var_205_1.name = "1086"
					var_205_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_202_1.actors_["1086"] = var_205_1

					if arg_202_1.isInRecall_ then
						for iter_205_0, iter_205_1 in ipairs((var_205_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_205_1.color = arg_202_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_205_2 = arg_202_1.actors_["1086"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_2) and arg_202_1.var_.actorSpriteComps1086 == nil then
				arg_202_1.var_.actorSpriteComps1086 = var_205_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_3 = 0.2

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_3 and not isNil(var_205_2) then
				if arg_202_1.var_.actorSpriteComps1086 then
					for iter_205_2, iter_205_3 in pairs(arg_202_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_205_3 then
							if arg_202_1.isInRecall_ then
								iter_205_3.color = Color.New(Mathf.Lerp(iter_205_3.color.r, arg_202_1.hightColor1.r, (arg_202_1.time_ - 0) / var_205_3), Mathf.Lerp(iter_205_3.color.g, arg_202_1.hightColor1.g, (arg_202_1.time_ - 0) / var_205_3), (Mathf.Lerp(iter_205_3.color.b, arg_202_1.hightColor1.b, (arg_202_1.time_ - 0) / var_205_3)))
							else
								local var_205_4 = Mathf.Lerp(iter_205_3.color.r, 1, (arg_202_1.time_ - 0) / var_205_3)

								iter_205_3.color = Color.New(var_205_4, var_205_4, var_205_4)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= 0 + var_205_3 and arg_202_1.time_ < 0 + var_205_3 + arg_205_0 and not isNil(var_205_2) and arg_202_1.var_.actorSpriteComps1086 then
				for iter_205_4, iter_205_5 in pairs(arg_202_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_205_5 then
						iter_205_5.color = arg_202_1.isInRecall_ and (arg_202_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_202_1.var_.actorSpriteComps1086 = nil
			end

			local var_205_5 = arg_202_1.actors_["1028"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_5) and arg_202_1.var_.actorSpriteComps1028 == nil then
				arg_202_1.var_.actorSpriteComps1028 = var_205_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_6 = 0.2

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_6 and not isNil(var_205_5) then
				if arg_202_1.var_.actorSpriteComps1028 then
					for iter_205_6, iter_205_7 in pairs(arg_202_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_205_7 then
							if arg_202_1.isInRecall_ then
								iter_205_7.color = Color.New(Mathf.Lerp(iter_205_7.color.r, arg_202_1.hightColor2.r, (arg_202_1.time_ - 0) / var_205_6), Mathf.Lerp(iter_205_7.color.g, arg_202_1.hightColor2.g, (arg_202_1.time_ - 0) / var_205_6), (Mathf.Lerp(iter_205_7.color.b, arg_202_1.hightColor2.b, (arg_202_1.time_ - 0) / var_205_6)))
							else
								local var_205_7 = Mathf.Lerp(iter_205_7.color.r, 0.5, (arg_202_1.time_ - 0) / var_205_6)

								iter_205_7.color = Color.New(var_205_7, var_205_7, var_205_7)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= 0 + var_205_6 and arg_202_1.time_ < 0 + var_205_6 + arg_205_0 and not isNil(var_205_5) and arg_202_1.var_.actorSpriteComps1028 then
				for iter_205_8, iter_205_9 in pairs(arg_202_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_205_9 then
						iter_205_9.color = arg_202_1.isInRecall_ and (arg_202_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_202_1.var_.actorSpriteComps1028 = nil
			end

			local var_205_8 = arg_202_1.actors_["1028"].transform

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos1028 = var_205_8.localPosition
				var_205_8.localScale = Vector3.New(1, 1, 1)

				arg_202_1:CheckSpriteTmpPos("1028", 7)

				for iter_205_10 = 0, var_205_8.childCount - 1 do
					local var_205_9 = var_205_8:GetChild(iter_205_10)

					if var_205_9.name == "" or not string.find(var_205_9.name, "split") then
						var_205_9.gameObject:SetActive(true)
					else
						var_205_9.gameObject:SetActive(false)
					end
				end
			end

			local var_205_10 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_10 then
				var_205_8.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_202_1.time_ - 0) / var_205_10)
			end

			if arg_202_1.time_ >= 0 + var_205_10 and arg_202_1.time_ < 0 + var_205_10 + arg_205_0 then
				var_205_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_205_11 = arg_202_1.actors_["1086"].transform

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos1086 = var_205_11.localPosition
				var_205_11.localScale = Vector3.New(1, 1, 1)

				arg_202_1:CheckSpriteTmpPos("1086", 3)

				for iter_205_11 = 0, var_205_11.childCount - 1 do
					local var_205_12 = var_205_11:GetChild(iter_205_11)

					if var_205_12.name == "split_6" or not string.find(var_205_12.name, "split") then
						var_205_12.gameObject:SetActive(true)
					else
						var_205_12.gameObject:SetActive(false)
					end
				end
			end

			local var_205_13 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_13 then
				var_205_11.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_202_1.time_ - 0) / var_205_13)
			end

			if arg_202_1.time_ >= 0 + var_205_13 and arg_202_1.time_ < 0 + var_205_13 + arg_205_0 then
				var_205_11.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_205_14 = 0
			local var_205_15 = 0.575

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_14 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_16 = arg_202_1:GetWordFromCfg(416191047)
				local var_205_17 = arg_202_1:FormatText(var_205_16.content)

				arg_202_1.text_.text = var_205_17

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_19 = 23 <= 0 and var_205_15 or var_205_15 * (utf8.len(var_205_17) / 23)

				if (23 <= 0 and var_205_15 or var_205_15 * (utf8.len(var_205_17) / 23)) > 0 and var_205_15 < var_205_19 then
					arg_202_1.talkMaxDuration = var_205_19

					if var_205_19 + var_205_14 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_19 + var_205_14
					end
				end

				arg_202_1.text_.text = var_205_17
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191047", "story_v_out_416191.awb") ~= 0 then
					local var_205_20 = manager.audio:GetVoiceLength("story_v_out_416191", "416191047", "story_v_out_416191.awb") / 1000

					if var_205_20 + var_205_14 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_20 + var_205_14
					end

					if var_205_16.prefab_name ~= "" and arg_202_1.actors_[var_205_16.prefab_name] ~= nil then
						local var_205_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_16.prefab_name].transform, "story_v_out_416191", "416191047", "story_v_out_416191.awb")

						arg_202_1:RecordAudio("416191047", var_205_21)
						arg_202_1:RecordAudio("416191047", var_205_21)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_416191", "416191047", "story_v_out_416191.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_416191", "416191047", "story_v_out_416191.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_22 = math.max(var_205_15, arg_202_1.talkMaxDuration)

			if var_205_14 <= arg_202_1.time_ and arg_202_1.time_ < var_205_14 + var_205_22 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_14) / var_205_22

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_14 + var_205_22 and arg_202_1.time_ < var_205_14 + var_205_22 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play416191048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 416191048
		arg_206_1.duration_ = 3.67

		local var_206_0 = {
			zh = 3.5,
			ja = 3.666
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
				arg_206_0:Play416191049(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["1028"]) and arg_206_1.var_.actorSpriteComps1028 == nil then
				arg_206_1.var_.actorSpriteComps1028 = arg_206_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_0 = 0.2

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["1028"]) then
				if arg_206_1.var_.actorSpriteComps1028 then
					for iter_209_0, iter_209_1 in pairs(arg_206_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_209_1 then
							if arg_206_1.isInRecall_ then
								iter_209_1.color = Color.New(Mathf.Lerp(iter_209_1.color.r, arg_206_1.hightColor1.r, (arg_206_1.time_ - 0) / var_209_0), Mathf.Lerp(iter_209_1.color.g, arg_206_1.hightColor1.g, (arg_206_1.time_ - 0) / var_209_0), (Mathf.Lerp(iter_209_1.color.b, arg_206_1.hightColor1.b, (arg_206_1.time_ - 0) / var_209_0)))
							else
								local var_209_1 = Mathf.Lerp(iter_209_1.color.r, 1, (arg_206_1.time_ - 0) / var_209_0)

								iter_209_1.color = Color.New(var_209_1, var_209_1, var_209_1)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["1028"]) and arg_206_1.var_.actorSpriteComps1028 then
				for iter_209_2, iter_209_3 in pairs(arg_206_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_209_3 then
						iter_209_3.color = arg_206_1.isInRecall_ and (arg_206_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_206_1.var_.actorSpriteComps1028 = nil
			end

			local var_209_2 = arg_206_1.actors_["1086"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_2) and arg_206_1.var_.actorSpriteComps1086 == nil then
				arg_206_1.var_.actorSpriteComps1086 = var_209_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_3 = 0.2

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_3 and not isNil(var_209_2) then
				if arg_206_1.var_.actorSpriteComps1086 then
					for iter_209_4, iter_209_5 in pairs(arg_206_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_209_5 then
							if arg_206_1.isInRecall_ then
								iter_209_5.color = Color.New(Mathf.Lerp(iter_209_5.color.r, arg_206_1.hightColor2.r, (arg_206_1.time_ - 0) / var_209_3), Mathf.Lerp(iter_209_5.color.g, arg_206_1.hightColor2.g, (arg_206_1.time_ - 0) / var_209_3), (Mathf.Lerp(iter_209_5.color.b, arg_206_1.hightColor2.b, (arg_206_1.time_ - 0) / var_209_3)))
							else
								local var_209_4 = Mathf.Lerp(iter_209_5.color.r, 0.5, (arg_206_1.time_ - 0) / var_209_3)

								iter_209_5.color = Color.New(var_209_4, var_209_4, var_209_4)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= 0 + var_209_3 and arg_206_1.time_ < 0 + var_209_3 + arg_209_0 and not isNil(var_209_2) and arg_206_1.var_.actorSpriteComps1086 then
				for iter_209_6, iter_209_7 in pairs(arg_206_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_209_7 then
						iter_209_7.color = arg_206_1.isInRecall_ and (arg_206_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_206_1.var_.actorSpriteComps1086 = nil
			end

			local var_209_5 = arg_206_1.actors_["1028"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1028 = var_209_5.localPosition
				var_209_5.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("1028", 3)

				for iter_209_8 = 0, var_209_5.childCount - 1 do
					local var_209_6 = var_209_5:GetChild(iter_209_8)

					if var_209_6.name == "split_2" or not string.find(var_209_6.name, "split") then
						var_209_6.gameObject:SetActive(true)
					else
						var_209_6.gameObject:SetActive(false)
					end
				end
			end

			local var_209_7 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_7 then
				var_209_5.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_206_1.time_ - 0) / var_209_7)
			end

			if arg_206_1.time_ >= 0 + var_209_7 and arg_206_1.time_ < 0 + var_209_7 + arg_209_0 then
				var_209_5.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_209_8 = arg_206_1.actors_["1086"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1086 = var_209_8.localPosition
				var_209_8.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("1086", 7)

				for iter_209_9 = 0, var_209_8.childCount - 1 do
					local var_209_9 = var_209_8:GetChild(iter_209_9)

					if var_209_9.name == "" or not string.find(var_209_9.name, "split") then
						var_209_9.gameObject:SetActive(true)
					else
						var_209_9.gameObject:SetActive(false)
					end
				end
			end

			local var_209_10 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_10 then
				var_209_8.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_206_1.time_ - 0) / var_209_10)
			end

			if arg_206_1.time_ >= 0 + var_209_10 and arg_206_1.time_ < 0 + var_209_10 + arg_209_0 then
				var_209_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_209_11 = 0
			local var_209_12 = 0.25

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_11 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_13 = arg_206_1:GetWordFromCfg(416191048)
				local var_209_14 = arg_206_1:FormatText(var_209_13.content)

				arg_206_1.text_.text = var_209_14

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_16 = 10 <= 0 and var_209_12 or var_209_12 * (utf8.len(var_209_14) / 10)

				if (10 <= 0 and var_209_12 or var_209_12 * (utf8.len(var_209_14) / 10)) > 0 and var_209_12 < var_209_16 then
					arg_206_1.talkMaxDuration = var_209_16

					if var_209_16 + var_209_11 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_16 + var_209_11
					end
				end

				arg_206_1.text_.text = var_209_14
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191048", "story_v_out_416191.awb") ~= 0 then
					local var_209_17 = manager.audio:GetVoiceLength("story_v_out_416191", "416191048", "story_v_out_416191.awb") / 1000

					if var_209_17 + var_209_11 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_17 + var_209_11
					end

					if var_209_13.prefab_name ~= "" and arg_206_1.actors_[var_209_13.prefab_name] ~= nil then
						local var_209_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_13.prefab_name].transform, "story_v_out_416191", "416191048", "story_v_out_416191.awb")

						arg_206_1:RecordAudio("416191048", var_209_18)
						arg_206_1:RecordAudio("416191048", var_209_18)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_416191", "416191048", "story_v_out_416191.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_416191", "416191048", "story_v_out_416191.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_19 = math.max(var_209_12, arg_206_1.talkMaxDuration)

			if var_209_11 <= arg_206_1.time_ and arg_206_1.time_ < var_209_11 + var_209_19 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_11) / var_209_19

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_11 + var_209_19 and arg_206_1.time_ < var_209_11 + var_209_19 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play416191049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 416191049
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play416191050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["1028"]) and arg_210_1.var_.actorSpriteComps1028 == nil then
				arg_210_1.var_.actorSpriteComps1028 = arg_210_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_0 = 0.2

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["1028"]) then
				if arg_210_1.var_.actorSpriteComps1028 then
					for iter_213_0, iter_213_1 in pairs(arg_210_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_213_1 then
							if arg_210_1.isInRecall_ then
								iter_213_1.color = Color.New(Mathf.Lerp(iter_213_1.color.r, arg_210_1.hightColor2.r, (arg_210_1.time_ - 0) / var_213_0), Mathf.Lerp(iter_213_1.color.g, arg_210_1.hightColor2.g, (arg_210_1.time_ - 0) / var_213_0), (Mathf.Lerp(iter_213_1.color.b, arg_210_1.hightColor2.b, (arg_210_1.time_ - 0) / var_213_0)))
							else
								local var_213_1 = Mathf.Lerp(iter_213_1.color.r, 0.5, (arg_210_1.time_ - 0) / var_213_0)

								iter_213_1.color = Color.New(var_213_1, var_213_1, var_213_1)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1028"]) and arg_210_1.var_.actorSpriteComps1028 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_213_3 then
						iter_213_3.color = arg_210_1.isInRecall_ and (arg_210_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_210_1.var_.actorSpriteComps1028 = nil
			end

			local var_213_2 = arg_210_1.actors_["1028"].transform

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos1028 = var_213_2.localPosition
				var_213_2.localScale = Vector3.New(1, 1, 1)

				arg_210_1:CheckSpriteTmpPos("1028", 7)

				for iter_213_4 = 0, var_213_2.childCount - 1 do
					local var_213_3 = var_213_2:GetChild(iter_213_4)

					if var_213_3.name == "" or not string.find(var_213_3.name, "split") then
						var_213_3.gameObject:SetActive(true)
					else
						var_213_3.gameObject:SetActive(false)
					end
				end
			end

			local var_213_4 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_4 then
				var_213_2.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_210_1.time_ - 0) / var_213_4)
			end

			if arg_210_1.time_ >= 0 + var_213_4 and arg_210_1.time_ < 0 + var_213_4 + arg_213_0 then
				var_213_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_213_5 = 0
			local var_213_6 = 1.475

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_5 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_7 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(416191049).content)

				arg_210_1.text_.text = var_213_7

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_9 = 59 <= 0 and var_213_6 or var_213_6 * (utf8.len(var_213_7) / 59)

				if (59 <= 0 and var_213_6 or var_213_6 * (utf8.len(var_213_7) / 59)) > 0 and var_213_6 < var_213_9 then
					arg_210_1.talkMaxDuration = var_213_9

					if var_213_9 + var_213_5 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_9 + var_213_5
					end
				end

				arg_210_1.text_.text = var_213_7
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_10 = math.max(var_213_6, arg_210_1.talkMaxDuration)

			if var_213_5 <= arg_210_1.time_ and arg_210_1.time_ < var_213_5 + var_213_10 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_5) / var_213_10

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_5 + var_213_10 and arg_210_1.time_ < var_213_5 + var_213_10 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play416191050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 416191050
		arg_214_1.duration_ = 5.83

		local var_214_0 = {
			zh = 5.366,
			ja = 5.833
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
				arg_214_0:Play416191051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["1028"]) and arg_214_1.var_.actorSpriteComps1028 == nil then
				arg_214_1.var_.actorSpriteComps1028 = arg_214_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_0 = 0.2

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["1028"]) then
				if arg_214_1.var_.actorSpriteComps1028 then
					for iter_217_0, iter_217_1 in pairs(arg_214_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_217_1 then
							if arg_214_1.isInRecall_ then
								iter_217_1.color = Color.New(Mathf.Lerp(iter_217_1.color.r, arg_214_1.hightColor1.r, (arg_214_1.time_ - 0) / var_217_0), Mathf.Lerp(iter_217_1.color.g, arg_214_1.hightColor1.g, (arg_214_1.time_ - 0) / var_217_0), (Mathf.Lerp(iter_217_1.color.b, arg_214_1.hightColor1.b, (arg_214_1.time_ - 0) / var_217_0)))
							else
								local var_217_1 = Mathf.Lerp(iter_217_1.color.r, 1, (arg_214_1.time_ - 0) / var_217_0)

								iter_217_1.color = Color.New(var_217_1, var_217_1, var_217_1)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["1028"]) and arg_214_1.var_.actorSpriteComps1028 then
				for iter_217_2, iter_217_3 in pairs(arg_214_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_217_3 then
						iter_217_3.color = arg_214_1.isInRecall_ and (arg_214_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_214_1.var_.actorSpriteComps1028 = nil
			end

			local var_217_2 = 0
			local var_217_3 = 0.475

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_2 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_7")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_4 = arg_214_1:GetWordFromCfg(416191050)
				local var_217_5 = arg_214_1:FormatText(var_217_4.content)

				arg_214_1.text_.text = var_217_5

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_7 = 19 <= 0 and var_217_3 or var_217_3 * (utf8.len(var_217_5) / 19)

				if (19 <= 0 and var_217_3 or var_217_3 * (utf8.len(var_217_5) / 19)) > 0 and var_217_3 < var_217_7 then
					arg_214_1.talkMaxDuration = var_217_7

					if var_217_7 + var_217_2 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_7 + var_217_2
					end
				end

				arg_214_1.text_.text = var_217_5
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191050", "story_v_out_416191.awb") ~= 0 then
					local var_217_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191050", "story_v_out_416191.awb") / 1000

					if var_217_8 + var_217_2 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_2
					end

					if var_217_4.prefab_name ~= "" and arg_214_1.actors_[var_217_4.prefab_name] ~= nil then
						local var_217_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_4.prefab_name].transform, "story_v_out_416191", "416191050", "story_v_out_416191.awb")

						arg_214_1:RecordAudio("416191050", var_217_9)
						arg_214_1:RecordAudio("416191050", var_217_9)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_416191", "416191050", "story_v_out_416191.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_416191", "416191050", "story_v_out_416191.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_10 = math.max(var_217_3, arg_214_1.talkMaxDuration)

			if var_217_2 <= arg_214_1.time_ and arg_214_1.time_ < var_217_2 + var_217_10 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_2) / var_217_10

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_2 + var_217_10 and arg_214_1.time_ < var_217_2 + var_217_10 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play416191051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 416191051
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play416191052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0.233333333333333 < arg_218_1.time_ and arg_218_1.time_ <= 0.233333333333333 + arg_221_0 then
				arg_218_1:AudioAction("play", "effect", "se_story_139", "se_story_139_metalhit01", "")
			end

			local var_221_1 = 0
			local var_221_2 = 1.625

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

				local var_221_3 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(416191051).content)

				arg_218_1.text_.text = var_221_3

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_5 = 65 <= 0 and var_221_2 or var_221_2 * (utf8.len(var_221_3) / 65)

				if (65 <= 0 and var_221_2 or var_221_2 * (utf8.len(var_221_3) / 65)) > 0 and var_221_2 < var_221_5 then
					arg_218_1.talkMaxDuration = var_221_5

					if var_221_5 + var_221_1 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_5 + var_221_1
					end
				end

				arg_218_1.text_.text = var_221_3
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_6 = math.max(var_221_2, arg_218_1.talkMaxDuration)

			if var_221_1 <= arg_218_1.time_ and arg_218_1.time_ < var_221_1 + var_221_6 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_1) / var_221_6

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_1 + var_221_6 and arg_218_1.time_ < var_221_1 + var_221_6 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play416191052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 416191052
		arg_222_1.duration_ = 6.73

		local var_222_0 = {
			zh = 6.733,
			ja = 4.466
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
				arg_222_0:Play416191053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["1028"]) and arg_222_1.var_.actorSpriteComps1028 == nil then
				arg_222_1.var_.actorSpriteComps1028 = arg_222_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_0 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["1028"]) then
				if arg_222_1.var_.actorSpriteComps1028 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								iter_225_1.color = Color.New(Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor1.r, (arg_222_1.time_ - 0) / var_225_0), Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor1.g, (arg_222_1.time_ - 0) / var_225_0), (Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor1.b, (arg_222_1.time_ - 0) / var_225_0)))
							else
								local var_225_1 = Mathf.Lerp(iter_225_1.color.r, 1, (arg_222_1.time_ - 0) / var_225_0)

								iter_225_1.color = Color.New(var_225_1, var_225_1, var_225_1)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["1028"]) and arg_222_1.var_.actorSpriteComps1028 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_225_3 then
						iter_225_3.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_222_1.var_.actorSpriteComps1028 = nil
			end

			local var_225_2 = arg_222_1.actors_["1028"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1028 = var_225_2.localPosition
				var_225_2.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("1028", 3)

				for iter_225_4 = 0, var_225_2.childCount - 1 do
					local var_225_3 = var_225_2:GetChild(iter_225_4)

					if var_225_3.name == "split_2" or not string.find(var_225_3.name, "split") then
						var_225_3.gameObject:SetActive(true)
					else
						var_225_3.gameObject:SetActive(false)
					end
				end
			end

			local var_225_4 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_4 then
				var_225_2.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_222_1.time_ - 0) / var_225_4)
			end

			if arg_222_1.time_ >= 0 + var_225_4 and arg_222_1.time_ < 0 + var_225_4 + arg_225_0 then
				var_225_2.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_225_5 = 0
			local var_225_6 = 0.65

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_5 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_7 = arg_222_1:GetWordFromCfg(416191052)
				local var_225_8 = arg_222_1:FormatText(var_225_7.content)

				arg_222_1.text_.text = var_225_8

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_10 = 26 <= 0 and var_225_6 or var_225_6 * (utf8.len(var_225_8) / 26)

				if (26 <= 0 and var_225_6 or var_225_6 * (utf8.len(var_225_8) / 26)) > 0 and var_225_6 < var_225_10 then
					arg_222_1.talkMaxDuration = var_225_10

					if var_225_10 + var_225_5 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_10 + var_225_5
					end
				end

				arg_222_1.text_.text = var_225_8
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191052", "story_v_out_416191.awb") ~= 0 then
					local var_225_11 = manager.audio:GetVoiceLength("story_v_out_416191", "416191052", "story_v_out_416191.awb") / 1000

					if var_225_11 + var_225_5 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_11 + var_225_5
					end

					if var_225_7.prefab_name ~= "" and arg_222_1.actors_[var_225_7.prefab_name] ~= nil then
						local var_225_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_7.prefab_name].transform, "story_v_out_416191", "416191052", "story_v_out_416191.awb")

						arg_222_1:RecordAudio("416191052", var_225_12)
						arg_222_1:RecordAudio("416191052", var_225_12)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_416191", "416191052", "story_v_out_416191.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_416191", "416191052", "story_v_out_416191.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_13 = math.max(var_225_6, arg_222_1.talkMaxDuration)

			if var_225_5 <= arg_222_1.time_ and arg_222_1.time_ < var_225_5 + var_225_13 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_5) / var_225_13

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_5 + var_225_13 and arg_222_1.time_ < var_225_5 + var_225_13 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play416191053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 416191053
		arg_226_1.duration_ = 5.37

		local var_226_0 = {
			zh = 2.5,
			ja = 5.366
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play416191054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["1028"]) and arg_226_1.var_.actorSpriteComps1028 == nil then
				arg_226_1.var_.actorSpriteComps1028 = arg_226_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_229_0 = 0.2

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["1028"]) then
				if arg_226_1.var_.actorSpriteComps1028 then
					for iter_229_0, iter_229_1 in pairs(arg_226_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_229_1 then
							if arg_226_1.isInRecall_ then
								iter_229_1.color = Color.New(Mathf.Lerp(iter_229_1.color.r, arg_226_1.hightColor2.r, (arg_226_1.time_ - 0) / var_229_0), Mathf.Lerp(iter_229_1.color.g, arg_226_1.hightColor2.g, (arg_226_1.time_ - 0) / var_229_0), (Mathf.Lerp(iter_229_1.color.b, arg_226_1.hightColor2.b, (arg_226_1.time_ - 0) / var_229_0)))
							else
								local var_229_1 = Mathf.Lerp(iter_229_1.color.r, 0.5, (arg_226_1.time_ - 0) / var_229_0)

								iter_229_1.color = Color.New(var_229_1, var_229_1, var_229_1)
							end
						end
					end
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["1028"]) and arg_226_1.var_.actorSpriteComps1028 then
				for iter_229_2, iter_229_3 in pairs(arg_226_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_229_3 then
						iter_229_3.color = arg_226_1.isInRecall_ and (arg_226_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_226_1.var_.actorSpriteComps1028 = nil
			end

			local var_229_2 = 0
			local var_229_3 = 0.325

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_2 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_3")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_4 = arg_226_1:GetWordFromCfg(416191053)
				local var_229_5 = arg_226_1:FormatText(var_229_4.content)

				arg_226_1.text_.text = var_229_5

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_7 = 13 <= 0 and var_229_3 or var_229_3 * (utf8.len(var_229_5) / 13)

				if (13 <= 0 and var_229_3 or var_229_3 * (utf8.len(var_229_5) / 13)) > 0 and var_229_3 < var_229_7 then
					arg_226_1.talkMaxDuration = var_229_7

					if var_229_7 + var_229_2 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_7 + var_229_2
					end
				end

				arg_226_1.text_.text = var_229_5
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191053", "story_v_out_416191.awb") ~= 0 then
					local var_229_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191053", "story_v_out_416191.awb") / 1000

					if var_229_8 + var_229_2 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_8 + var_229_2
					end

					if var_229_4.prefab_name ~= "" and arg_226_1.actors_[var_229_4.prefab_name] ~= nil then
						local var_229_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_4.prefab_name].transform, "story_v_out_416191", "416191053", "story_v_out_416191.awb")

						arg_226_1:RecordAudio("416191053", var_229_9)
						arg_226_1:RecordAudio("416191053", var_229_9)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_416191", "416191053", "story_v_out_416191.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_416191", "416191053", "story_v_out_416191.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_10 = math.max(var_229_3, arg_226_1.talkMaxDuration)

			if var_229_2 <= arg_226_1.time_ and arg_226_1.time_ < var_229_2 + var_229_10 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_2) / var_229_10

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_2 + var_229_10 and arg_226_1.time_ < var_229_2 + var_229_10 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play416191054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 416191054
		arg_230_1.duration_ = 5.87

		local var_230_0 = {
			zh = 5.033,
			ja = 5.866
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play416191055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["1028"]) and arg_230_1.var_.actorSpriteComps1028 == nil then
				arg_230_1.var_.actorSpriteComps1028 = arg_230_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_0 = 0.2

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["1028"]) then
				if arg_230_1.var_.actorSpriteComps1028 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_233_1 then
							if arg_230_1.isInRecall_ then
								iter_233_1.color = Color.New(Mathf.Lerp(iter_233_1.color.r, arg_230_1.hightColor1.r, (arg_230_1.time_ - 0) / var_233_0), Mathf.Lerp(iter_233_1.color.g, arg_230_1.hightColor1.g, (arg_230_1.time_ - 0) / var_233_0), (Mathf.Lerp(iter_233_1.color.b, arg_230_1.hightColor1.b, (arg_230_1.time_ - 0) / var_233_0)))
							else
								local var_233_1 = Mathf.Lerp(iter_233_1.color.r, 1, (arg_230_1.time_ - 0) / var_233_0)

								iter_233_1.color = Color.New(var_233_1, var_233_1, var_233_1)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["1028"]) and arg_230_1.var_.actorSpriteComps1028 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_233_3 then
						iter_233_3.color = arg_230_1.isInRecall_ and (arg_230_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_230_1.var_.actorSpriteComps1028 = nil
			end

			local var_233_2 = 0
			local var_233_3 = 0.55

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_2 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_4 = arg_230_1:GetWordFromCfg(416191054)
				local var_233_5 = arg_230_1:FormatText(var_233_4.content)

				arg_230_1.text_.text = var_233_5

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_7 = 22 <= 0 and var_233_3 or var_233_3 * (utf8.len(var_233_5) / 22)

				if (22 <= 0 and var_233_3 or var_233_3 * (utf8.len(var_233_5) / 22)) > 0 and var_233_3 < var_233_7 then
					arg_230_1.talkMaxDuration = var_233_7

					if var_233_7 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_7 + var_233_2
					end
				end

				arg_230_1.text_.text = var_233_5
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191054", "story_v_out_416191.awb") ~= 0 then
					local var_233_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191054", "story_v_out_416191.awb") / 1000

					if var_233_8 + var_233_2 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_8 + var_233_2
					end

					if var_233_4.prefab_name ~= "" and arg_230_1.actors_[var_233_4.prefab_name] ~= nil then
						local var_233_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_4.prefab_name].transform, "story_v_out_416191", "416191054", "story_v_out_416191.awb")

						arg_230_1:RecordAudio("416191054", var_233_9)
						arg_230_1:RecordAudio("416191054", var_233_9)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_416191", "416191054", "story_v_out_416191.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_416191", "416191054", "story_v_out_416191.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_10 = math.max(var_233_3, arg_230_1.talkMaxDuration)

			if var_233_2 <= arg_230_1.time_ and arg_230_1.time_ < var_233_2 + var_233_10 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_2) / var_233_10

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_2 + var_233_10 and arg_230_1.time_ < var_233_2 + var_233_10 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play416191055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 416191055
		arg_234_1.duration_ = 6.43

		local var_234_0 = {
			zh = 3.9,
			ja = 6.433
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play416191056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["1028"]) and arg_234_1.var_.actorSpriteComps1028 == nil then
				arg_234_1.var_.actorSpriteComps1028 = arg_234_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_0 = 0.2

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["1028"]) then
				if arg_234_1.var_.actorSpriteComps1028 then
					for iter_237_0, iter_237_1 in pairs(arg_234_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_237_1 then
							if arg_234_1.isInRecall_ then
								iter_237_1.color = Color.New(Mathf.Lerp(iter_237_1.color.r, arg_234_1.hightColor2.r, (arg_234_1.time_ - 0) / var_237_0), Mathf.Lerp(iter_237_1.color.g, arg_234_1.hightColor2.g, (arg_234_1.time_ - 0) / var_237_0), (Mathf.Lerp(iter_237_1.color.b, arg_234_1.hightColor2.b, (arg_234_1.time_ - 0) / var_237_0)))
							else
								local var_237_1 = Mathf.Lerp(iter_237_1.color.r, 0.5, (arg_234_1.time_ - 0) / var_237_0)

								iter_237_1.color = Color.New(var_237_1, var_237_1, var_237_1)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["1028"]) and arg_234_1.var_.actorSpriteComps1028 then
				for iter_237_2, iter_237_3 in pairs(arg_234_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_237_3 then
						iter_237_3.color = arg_234_1.isInRecall_ and (arg_234_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_234_1.var_.actorSpriteComps1028 = nil
			end

			local var_237_2 = 0
			local var_237_3 = 0.325

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_2 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_6")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_4 = arg_234_1:GetWordFromCfg(416191055)
				local var_237_5 = arg_234_1:FormatText(var_237_4.content)

				arg_234_1.text_.text = var_237_5

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_7 = 13 <= 0 and var_237_3 or var_237_3 * (utf8.len(var_237_5) / 13)

				if (13 <= 0 and var_237_3 or var_237_3 * (utf8.len(var_237_5) / 13)) > 0 and var_237_3 < var_237_7 then
					arg_234_1.talkMaxDuration = var_237_7

					if var_237_7 + var_237_2 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_7 + var_237_2
					end
				end

				arg_234_1.text_.text = var_237_5
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191055", "story_v_out_416191.awb") ~= 0 then
					local var_237_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191055", "story_v_out_416191.awb") / 1000

					if var_237_8 + var_237_2 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_8 + var_237_2
					end

					if var_237_4.prefab_name ~= "" and arg_234_1.actors_[var_237_4.prefab_name] ~= nil then
						local var_237_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_4.prefab_name].transform, "story_v_out_416191", "416191055", "story_v_out_416191.awb")

						arg_234_1:RecordAudio("416191055", var_237_9)
						arg_234_1:RecordAudio("416191055", var_237_9)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_416191", "416191055", "story_v_out_416191.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_416191", "416191055", "story_v_out_416191.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_10 = math.max(var_237_3, arg_234_1.talkMaxDuration)

			if var_237_2 <= arg_234_1.time_ and arg_234_1.time_ < var_237_2 + var_237_10 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_2) / var_237_10

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_2 + var_237_10 and arg_234_1.time_ < var_237_2 + var_237_10 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play416191056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 416191056
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play416191057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos1028 = arg_238_1.actors_["1028"].transform.localPosition
				arg_238_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_238_1:CheckSpriteTmpPos("1028", 7)

				for iter_241_0 = 0, arg_238_1.actors_["1028"].transform.childCount - 1 do
					local var_241_0 = arg_238_1.actors_["1028"].transform:GetChild(iter_241_0)

					if var_241_0.name == "" or not string.find(var_241_0.name, "split") then
						var_241_0.gameObject:SetActive(true)
					else
						var_241_0.gameObject:SetActive(false)
					end
				end
			end

			local var_241_1 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_1 then
				arg_238_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_238_1.time_ - 0) / var_241_1)
			end

			if arg_238_1.time_ >= 0 + var_241_1 and arg_238_1.time_ < 0 + var_241_1 + arg_241_0 then
				arg_238_1.actors_["1028"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_241_2 = 0
			local var_241_3 = 1.45

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_2 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_4 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(416191056).content)

				arg_238_1.text_.text = var_241_4

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_6 = 58 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_4) / 58)

				if (58 <= 0 and var_241_3 or var_241_3 * (utf8.len(var_241_4) / 58)) > 0 and var_241_3 < var_241_6 then
					arg_238_1.talkMaxDuration = var_241_6

					if var_241_6 + var_241_2 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_6 + var_241_2
					end
				end

				arg_238_1.text_.text = var_241_4
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_7 = math.max(var_241_3, arg_238_1.talkMaxDuration)

			if var_241_2 <= arg_238_1.time_ and arg_238_1.time_ < var_241_2 + var_241_7 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_2) / var_241_7

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_2 + var_241_7 and arg_238_1.time_ < var_241_2 + var_241_7 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play416191057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 416191057
		arg_242_1.duration_ = 7.5

		local var_242_0 = {
			zh = 7.5,
			ja = 5.8
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play416191058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["1028"]) and arg_242_1.var_.actorSpriteComps1028 == nil then
				arg_242_1.var_.actorSpriteComps1028 = arg_242_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_245_0 = 0.2

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["1028"]) then
				if arg_242_1.var_.actorSpriteComps1028 then
					for iter_245_0, iter_245_1 in pairs(arg_242_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_245_1 then
							if arg_242_1.isInRecall_ then
								iter_245_1.color = Color.New(Mathf.Lerp(iter_245_1.color.r, arg_242_1.hightColor1.r, (arg_242_1.time_ - 0) / var_245_0), Mathf.Lerp(iter_245_1.color.g, arg_242_1.hightColor1.g, (arg_242_1.time_ - 0) / var_245_0), (Mathf.Lerp(iter_245_1.color.b, arg_242_1.hightColor1.b, (arg_242_1.time_ - 0) / var_245_0)))
							else
								local var_245_1 = Mathf.Lerp(iter_245_1.color.r, 1, (arg_242_1.time_ - 0) / var_245_0)

								iter_245_1.color = Color.New(var_245_1, var_245_1, var_245_1)
							end
						end
					end
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["1028"]) and arg_242_1.var_.actorSpriteComps1028 then
				for iter_245_2, iter_245_3 in pairs(arg_242_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_245_3 then
						iter_245_3.color = arg_242_1.isInRecall_ and (arg_242_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_242_1.var_.actorSpriteComps1028 = nil
			end

			local var_245_2 = arg_242_1.actors_["1028"].transform

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos1028 = var_245_2.localPosition
				var_245_2.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("1028", 3)

				for iter_245_4 = 0, var_245_2.childCount - 1 do
					local var_245_3 = var_245_2:GetChild(iter_245_4)

					if var_245_3.name == "split_2" or not string.find(var_245_3.name, "split") then
						var_245_3.gameObject:SetActive(true)
					else
						var_245_3.gameObject:SetActive(false)
					end
				end
			end

			local var_245_4 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_4 then
				var_245_2.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_242_1.time_ - 0) / var_245_4)
			end

			if arg_242_1.time_ >= 0 + var_245_4 and arg_242_1.time_ < 0 + var_245_4 + arg_245_0 then
				var_245_2.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_245_5 = 0
			local var_245_6 = 0.4

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_5 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_7 = arg_242_1:GetWordFromCfg(416191057)
				local var_245_8 = arg_242_1:FormatText(var_245_7.content)

				arg_242_1.text_.text = var_245_8

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_10 = 16 <= 0 and var_245_6 or var_245_6 * (utf8.len(var_245_8) / 16)

				if (16 <= 0 and var_245_6 or var_245_6 * (utf8.len(var_245_8) / 16)) > 0 and var_245_6 < var_245_10 then
					arg_242_1.talkMaxDuration = var_245_10

					if var_245_10 + var_245_5 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_10 + var_245_5
					end
				end

				arg_242_1.text_.text = var_245_8
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191057", "story_v_out_416191.awb") ~= 0 then
					local var_245_11 = manager.audio:GetVoiceLength("story_v_out_416191", "416191057", "story_v_out_416191.awb") / 1000

					if var_245_11 + var_245_5 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_11 + var_245_5
					end

					if var_245_7.prefab_name ~= "" and arg_242_1.actors_[var_245_7.prefab_name] ~= nil then
						local var_245_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_7.prefab_name].transform, "story_v_out_416191", "416191057", "story_v_out_416191.awb")

						arg_242_1:RecordAudio("416191057", var_245_12)
						arg_242_1:RecordAudio("416191057", var_245_12)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_416191", "416191057", "story_v_out_416191.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_416191", "416191057", "story_v_out_416191.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_13 = math.max(var_245_6, arg_242_1.talkMaxDuration)

			if var_245_5 <= arg_242_1.time_ and arg_242_1.time_ < var_245_5 + var_245_13 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_5) / var_245_13

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_5 + var_245_13 and arg_242_1.time_ < var_245_5 + var_245_13 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play416191058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 416191058
		arg_246_1.duration_ = 5.77

		local var_246_0 = {
			zh = 4.533,
			ja = 5.766
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play416191059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0.5

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_1 = arg_246_1:GetWordFromCfg(416191058)
				local var_249_2 = arg_246_1:FormatText(var_249_1.content)

				arg_246_1.text_.text = var_249_2

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_4 = 20 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_2) / 20)

				if (20 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_2) / 20)) > 0 and var_249_0 < var_249_4 then
					arg_246_1.talkMaxDuration = var_249_4

					if var_249_4 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_4 + 0
					end
				end

				arg_246_1.text_.text = var_249_2
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191058", "story_v_out_416191.awb") ~= 0 then
					local var_249_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191058", "story_v_out_416191.awb") / 1000

					if var_249_5 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_5 + 0
					end

					if var_249_1.prefab_name ~= "" and arg_246_1.actors_[var_249_1.prefab_name] ~= nil then
						local var_249_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_1.prefab_name].transform, "story_v_out_416191", "416191058", "story_v_out_416191.awb")

						arg_246_1:RecordAudio("416191058", var_249_6)
						arg_246_1:RecordAudio("416191058", var_249_6)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_416191", "416191058", "story_v_out_416191.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_416191", "416191058", "story_v_out_416191.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_7 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_7 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_7

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_7 and arg_246_1.time_ < 0 + var_249_7 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play416191059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 416191059
		arg_250_1.duration_ = 6.06

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play416191060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_9001
			local var_253_9000

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos1028 = arg_250_1.actors_["1028"].transform.localPosition
				arg_250_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("1028", 7)

				for iter_253_0 = 0, arg_250_1.actors_["1028"].transform.childCount - 1 do
					local var_253_0 = arg_250_1.actors_["1028"].transform:GetChild(iter_253_0)

					if var_253_0.name == "" or not string.find(var_253_0.name, "split") then
						var_253_0.gameObject:SetActive(true)
					else
						var_253_0.gameObject:SetActive(false)
					end
				end
			end

			local var_253_1 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_1 then
				arg_250_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_250_1.time_ - 0) / var_253_1)
			end

			if arg_250_1.time_ >= 0 + var_253_1 and arg_250_1.time_ < 0 + var_253_1 + arg_253_0 then
				arg_250_1.actors_["1028"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.166666666666667 < arg_250_1.time_ and arg_250_1.time_ <= 0.166666666666667 + arg_253_0 then
				local var_253_2 = arg_250_1.var_.effect7777

				if not arg_250_1.var_.effect7777 then
					var_253_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), manager.ui.mainCamera.transform)
					var_253_2.name = "7777"
					arg_250_1.var_.effect7777 = var_253_2
				else
					var_253_2.transform:SetParent(var_253_9001)
				end

				var_253_2.transform.localPosition = Vector3.New(0, 0, 0.66)
				var_253_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_253_4 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_253_5 = var_253_2.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_253_1, iter_253_2 in ipairs((var_253_5:ToTable())) do
					iter_253_2.transform.localScale = Vector3.New(iter_253_2.transform.localScale.x / var_253_4 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_253_5 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_253_2.transform.localScale.y / var_253_4, iter_253_2.transform.localScale.z)
				end
			end

			if 0.533333333333333 < arg_250_1.time_ and arg_250_1.time_ <= 0.533333333333333 + arg_253_0 then
				if arg_250_1.var_.effect7777 then
					Object.Destroy(arg_250_1.var_.effect7777)

					arg_250_1.var_.effect7777 = nil
				end
			end

			local var_253_8 = 0

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_8 + arg_253_0 then
				arg_250_1.allBtn_.enabled = false
			end

			if arg_250_1.time_ >= var_253_8 + 1.76666666666667 and arg_250_1.time_ < var_253_8 + 1.76666666666667 + arg_253_0 then
				arg_250_1.allBtn_.enabled = true
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				local var_253_9 = arg_250_1.actors_["1028"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_253_9 then
					arg_250_1.var_.alphaOldValue1028 = var_253_9.alpha
					arg_250_1.var_.characterEffect1028 = var_253_9
				end

				arg_250_1.var_.alphaOldValue1028 = 1
			end

			local var_253_10 = 0.433333333333333

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_10 then
				if arg_250_1.var_.characterEffect1028 then
					arg_250_1.var_.characterEffect1028.alpha = Mathf.Lerp(arg_250_1.var_.alphaOldValue1028, 0, (arg_250_1.time_ - 0) / var_253_10)
				end
			end

			if arg_250_1.time_ >= 0 + var_253_10 and arg_250_1.time_ < 0 + var_253_10 + arg_253_0 and arg_250_1.var_.characterEffect1028 then
				arg_250_1.var_.characterEffect1028.alpha = 0
			end

			if 0.309470200352371 < arg_250_1.time_ and arg_250_1.time_ <= 0.309470200352371 + arg_253_0 then
				local var_253_11 = arg_250_1.var_.effect244

				if not arg_250_1.var_.effect244 then
					var_253_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), manager.ui.mainCamera.transform)
					var_253_11.name = "244"
					arg_250_1.var_.effect244 = var_253_11
				else
					var_253_11.transform:SetParent(var_253_9000)
				end

				var_253_11.transform.localPosition = Vector3.New(0, 0, 0)
				var_253_11.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_253_13 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_253_14 = var_253_11.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_253_3, iter_253_4 in ipairs((var_253_14:ToTable())) do
					iter_253_4.transform.localScale = Vector3.New(iter_253_4.transform.localScale.x / var_253_13 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_253_14 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_253_4.transform.localScale.y / var_253_13, iter_253_4.transform.localScale.z)
				end
			end

			if 1.16666666666667 < arg_250_1.time_ and arg_250_1.time_ <= 1.16666666666667 + arg_253_0 then
				if arg_250_1.var_.effect244 then
					Object.Destroy(arg_250_1.var_.effect244)

					arg_250_1.var_.effect244 = nil
				end
			end

			if 0.2 < arg_250_1.time_ and arg_250_1.time_ <= 0.2 + arg_253_0 then
				arg_250_1:AudioAction("play", "effect", "se_story_127", "se_story_127_thunder", "")
			end

			if arg_250_1.frameCnt_ <= 1 then
				arg_250_1.dialog_:SetActive(false)
			end

			local var_253_18 = 1.0571964663143
			local var_253_19 = 1.375

			if 1.0571964663143 < arg_250_1.time_ and arg_250_1.time_ <= var_253_18 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0

				arg_250_1.dialog_:SetActive(true)

				arg_250_1.dialogCg_.alpha = 0

				local var_253_20 = LeanTween.value(arg_250_1.dialog_, 0, 1, 0.3)

				var_253_20:setOnUpdate(LuaHelper.FloatAction(function(arg_254_0)
					arg_250_1.dialogCg_.alpha = arg_254_0
				end))
				var_253_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_250_1.dialog_)
					var_253_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_250_1.duration_ = arg_250_1.duration_ + 0.3

				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_21 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(416191059).content)

				arg_250_1.text_.text = var_253_21

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_23 = 55 <= 0 and var_253_19 or var_253_19 * (utf8.len(var_253_21) / 55)

				if (55 <= 0 and var_253_19 or var_253_19 * (utf8.len(var_253_21) / 55)) > 0 and var_253_19 < var_253_23 then
					arg_250_1.talkMaxDuration = var_253_23
					var_253_18 = var_253_18 + 0.3

					if var_253_23 + var_253_18 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_23 + var_253_18
					end
				end

				arg_250_1.text_.text = var_253_21
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_24 = var_253_18 + 0.3
			local var_253_25 = math.max(var_253_19, arg_250_1.talkMaxDuration)

			if var_253_18 + 0.3 <= arg_250_1.time_ and arg_250_1.time_ < var_253_24 + var_253_25 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_24) / var_253_25

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_24 + var_253_25 and arg_250_1.time_ < var_253_24 + var_253_25 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play416191060 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 416191060
		arg_256_1.duration_ = 12.23

		local var_256_0 = {
			zh = 7.9,
			ja = 12.233
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play416191061(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(arg_256_1.actors_["1028"]) and arg_256_1.var_.actorSpriteComps1028 == nil then
				arg_256_1.var_.actorSpriteComps1028 = arg_256_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_259_0 = 0.2

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 and not isNil(arg_256_1.actors_["1028"]) then
				if arg_256_1.var_.actorSpriteComps1028 then
					for iter_259_0, iter_259_1 in pairs(arg_256_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_259_1 then
							if arg_256_1.isInRecall_ then
								iter_259_1.color = Color.New(Mathf.Lerp(iter_259_1.color.r, arg_256_1.hightColor1.r, (arg_256_1.time_ - 0) / var_259_0), Mathf.Lerp(iter_259_1.color.g, arg_256_1.hightColor1.g, (arg_256_1.time_ - 0) / var_259_0), (Mathf.Lerp(iter_259_1.color.b, arg_256_1.hightColor1.b, (arg_256_1.time_ - 0) / var_259_0)))
							else
								local var_259_1 = Mathf.Lerp(iter_259_1.color.r, 1, (arg_256_1.time_ - 0) / var_259_0)

								iter_259_1.color = Color.New(var_259_1, var_259_1, var_259_1)
							end
						end
					end
				end
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 and not isNil(arg_256_1.actors_["1028"]) and arg_256_1.var_.actorSpriteComps1028 then
				for iter_259_2, iter_259_3 in pairs(arg_256_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_259_3 then
						iter_259_3.color = arg_256_1.isInRecall_ and (arg_256_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_256_1.var_.actorSpriteComps1028 = nil
			end

			local var_259_2 = arg_256_1.actors_["1028"].transform

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.var_.moveOldPos1028 = var_259_2.localPosition
				var_259_2.localScale = Vector3.New(1, 1, 1)

				arg_256_1:CheckSpriteTmpPos("1028", 3)

				for iter_259_4 = 0, var_259_2.childCount - 1 do
					local var_259_3 = var_259_2:GetChild(iter_259_4)

					if var_259_3.name == "split_2" or not string.find(var_259_3.name, "split") then
						var_259_3.gameObject:SetActive(true)
					else
						var_259_3.gameObject:SetActive(false)
					end
				end
			end

			local var_259_4 = 0.001

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_4 then
				var_259_2.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_256_1.time_ - 0) / var_259_4)
			end

			if arg_256_1.time_ >= 0 + var_259_4 and arg_256_1.time_ < 0 + var_259_4 + arg_259_0 then
				var_259_2.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				local var_259_5 = arg_256_1.actors_["1028"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_259_5 then
					arg_256_1.var_.alphaOldValue1028 = var_259_5.alpha
					arg_256_1.var_.characterEffect1028 = var_259_5
				end

				arg_256_1.var_.alphaOldValue1028 = 0
			end

			local var_259_6 = 0.333333343267441

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_6 then
				if arg_256_1.var_.characterEffect1028 then
					arg_256_1.var_.characterEffect1028.alpha = Mathf.Lerp(arg_256_1.var_.alphaOldValue1028, 1, (arg_256_1.time_ - 0) / var_259_6)
				end
			end

			if arg_256_1.time_ >= 0 + var_259_6 and arg_256_1.time_ < 0 + var_259_6 + arg_259_0 and arg_256_1.var_.characterEffect1028 then
				arg_256_1.var_.characterEffect1028.alpha = 1
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				if arg_256_1.var_.effect244 then
					Object.Destroy(arg_256_1.var_.effect244)

					arg_256_1.var_.effect244 = nil
				end
			end

			local var_259_8 = 0
			local var_259_9 = 0.725

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_8 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_10 = arg_256_1:GetWordFromCfg(416191060)
				local var_259_11 = arg_256_1:FormatText(var_259_10.content)

				arg_256_1.text_.text = var_259_11

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_13 = 29 <= 0 and var_259_9 or var_259_9 * (utf8.len(var_259_11) / 29)

				if (29 <= 0 and var_259_9 or var_259_9 * (utf8.len(var_259_11) / 29)) > 0 and var_259_9 < var_259_13 then
					arg_256_1.talkMaxDuration = var_259_13

					if var_259_13 + var_259_8 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_13 + var_259_8
					end
				end

				arg_256_1.text_.text = var_259_11
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191060", "story_v_out_416191.awb") ~= 0 then
					local var_259_14 = manager.audio:GetVoiceLength("story_v_out_416191", "416191060", "story_v_out_416191.awb") / 1000

					if var_259_14 + var_259_8 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_14 + var_259_8
					end

					if var_259_10.prefab_name ~= "" and arg_256_1.actors_[var_259_10.prefab_name] ~= nil then
						local var_259_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_10.prefab_name].transform, "story_v_out_416191", "416191060", "story_v_out_416191.awb")

						arg_256_1:RecordAudio("416191060", var_259_15)
						arg_256_1:RecordAudio("416191060", var_259_15)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_416191", "416191060", "story_v_out_416191.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_416191", "416191060", "story_v_out_416191.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_16 = math.max(var_259_9, arg_256_1.talkMaxDuration)

			if var_259_8 <= arg_256_1.time_ and arg_256_1.time_ < var_259_8 + var_259_16 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_8) / var_259_16

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_8 + var_259_16 and arg_256_1.time_ < var_259_8 + var_259_16 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play416191061 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 416191061
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play416191062(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(arg_260_1.actors_["1028"]) and arg_260_1.var_.actorSpriteComps1028 == nil then
				arg_260_1.var_.actorSpriteComps1028 = arg_260_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_263_0 = 0.2

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_0 and not isNil(arg_260_1.actors_["1028"]) then
				if arg_260_1.var_.actorSpriteComps1028 then
					for iter_263_0, iter_263_1 in pairs(arg_260_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_263_1 then
							if arg_260_1.isInRecall_ then
								iter_263_1.color = Color.New(Mathf.Lerp(iter_263_1.color.r, arg_260_1.hightColor2.r, (arg_260_1.time_ - 0) / var_263_0), Mathf.Lerp(iter_263_1.color.g, arg_260_1.hightColor2.g, (arg_260_1.time_ - 0) / var_263_0), (Mathf.Lerp(iter_263_1.color.b, arg_260_1.hightColor2.b, (arg_260_1.time_ - 0) / var_263_0)))
							else
								local var_263_1 = Mathf.Lerp(iter_263_1.color.r, 0.5, (arg_260_1.time_ - 0) / var_263_0)

								iter_263_1.color = Color.New(var_263_1, var_263_1, var_263_1)
							end
						end
					end
				end
			end

			if arg_260_1.time_ >= 0 + var_263_0 and arg_260_1.time_ < 0 + var_263_0 + arg_263_0 and not isNil(arg_260_1.actors_["1028"]) and arg_260_1.var_.actorSpriteComps1028 then
				for iter_263_2, iter_263_3 in pairs(arg_260_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_263_3 then
						iter_263_3.color = arg_260_1.isInRecall_ and (arg_260_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_260_1.var_.actorSpriteComps1028 = nil
			end

			local var_263_2 = 0
			local var_263_3 = 1.25

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_2 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_4 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(416191061).content)

				arg_260_1.text_.text = var_263_4

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_6 = 50 <= 0 and var_263_3 or var_263_3 * (utf8.len(var_263_4) / 50)

				if (50 <= 0 and var_263_3 or var_263_3 * (utf8.len(var_263_4) / 50)) > 0 and var_263_3 < var_263_6 then
					arg_260_1.talkMaxDuration = var_263_6

					if var_263_6 + var_263_2 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_6 + var_263_2
					end
				end

				arg_260_1.text_.text = var_263_4
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_7 = math.max(var_263_3, arg_260_1.talkMaxDuration)

			if var_263_2 <= arg_260_1.time_ and arg_260_1.time_ < var_263_2 + var_263_7 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_2) / var_263_7

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_2 + var_263_7 and arg_260_1.time_ < var_263_2 + var_263_7 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play416191062 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 416191062
		arg_264_1.duration_ = 5.53

		local var_264_0 = {
			zh = 5.533,
			ja = 5.1
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play416191063(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(arg_264_1.actors_["1028"]) and arg_264_1.var_.actorSpriteComps1028 == nil then
				arg_264_1.var_.actorSpriteComps1028 = arg_264_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_267_0 = 0.2

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 and not isNil(arg_264_1.actors_["1028"]) then
				if arg_264_1.var_.actorSpriteComps1028 then
					for iter_267_0, iter_267_1 in pairs(arg_264_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_267_1 then
							if arg_264_1.isInRecall_ then
								iter_267_1.color = Color.New(Mathf.Lerp(iter_267_1.color.r, arg_264_1.hightColor1.r, (arg_264_1.time_ - 0) / var_267_0), Mathf.Lerp(iter_267_1.color.g, arg_264_1.hightColor1.g, (arg_264_1.time_ - 0) / var_267_0), (Mathf.Lerp(iter_267_1.color.b, arg_264_1.hightColor1.b, (arg_264_1.time_ - 0) / var_267_0)))
							else
								local var_267_1 = Mathf.Lerp(iter_267_1.color.r, 1, (arg_264_1.time_ - 0) / var_267_0)

								iter_267_1.color = Color.New(var_267_1, var_267_1, var_267_1)
							end
						end
					end
				end
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 and not isNil(arg_264_1.actors_["1028"]) and arg_264_1.var_.actorSpriteComps1028 then
				for iter_267_2, iter_267_3 in pairs(arg_264_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_267_3 then
						iter_267_3.color = arg_264_1.isInRecall_ and (arg_264_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_264_1.var_.actorSpriteComps1028 = nil
			end

			local var_267_2 = arg_264_1.actors_["1028"].transform

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos1028 = var_267_2.localPosition
				var_267_2.localScale = Vector3.New(1, 1, 1)

				arg_264_1:CheckSpriteTmpPos("1028", 3)

				for iter_267_4 = 0, var_267_2.childCount - 1 do
					local var_267_3 = var_267_2:GetChild(iter_267_4)

					if var_267_3.name == "split_2" or not string.find(var_267_3.name, "split") then
						var_267_3.gameObject:SetActive(true)
					else
						var_267_3.gameObject:SetActive(false)
					end
				end
			end

			local var_267_4 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_4 then
				var_267_2.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_264_1.time_ - 0) / var_267_4)
			end

			if arg_264_1.time_ >= 0 + var_267_4 and arg_264_1.time_ < 0 + var_267_4 + arg_267_0 then
				var_267_2.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_267_5 = 0
			local var_267_6 = 0.425

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_5 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_7 = arg_264_1:GetWordFromCfg(416191062)
				local var_267_8 = arg_264_1:FormatText(var_267_7.content)

				arg_264_1.text_.text = var_267_8

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_10 = 17 <= 0 and var_267_6 or var_267_6 * (utf8.len(var_267_8) / 17)

				if (17 <= 0 and var_267_6 or var_267_6 * (utf8.len(var_267_8) / 17)) > 0 and var_267_6 < var_267_10 then
					arg_264_1.talkMaxDuration = var_267_10

					if var_267_10 + var_267_5 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_10 + var_267_5
					end
				end

				arg_264_1.text_.text = var_267_8
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191062", "story_v_out_416191.awb") ~= 0 then
					local var_267_11 = manager.audio:GetVoiceLength("story_v_out_416191", "416191062", "story_v_out_416191.awb") / 1000

					if var_267_11 + var_267_5 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_11 + var_267_5
					end

					if var_267_7.prefab_name ~= "" and arg_264_1.actors_[var_267_7.prefab_name] ~= nil then
						local var_267_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_7.prefab_name].transform, "story_v_out_416191", "416191062", "story_v_out_416191.awb")

						arg_264_1:RecordAudio("416191062", var_267_12)
						arg_264_1:RecordAudio("416191062", var_267_12)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_416191", "416191062", "story_v_out_416191.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_416191", "416191062", "story_v_out_416191.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_13 = math.max(var_267_6, arg_264_1.talkMaxDuration)

			if var_267_5 <= arg_264_1.time_ and arg_264_1.time_ < var_267_5 + var_267_13 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_5) / var_267_13

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_5 + var_267_13 and arg_264_1.time_ < var_267_5 + var_267_13 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play416191063 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 416191063
		arg_268_1.duration_ = 5.27

		local var_268_0 = {
			zh = 4.3,
			ja = 5.266
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play416191064(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(arg_268_1.actors_["1028"]) and arg_268_1.var_.actorSpriteComps1028 == nil then
				arg_268_1.var_.actorSpriteComps1028 = arg_268_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_0 = 0.2

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 and not isNil(arg_268_1.actors_["1028"]) then
				if arg_268_1.var_.actorSpriteComps1028 then
					for iter_271_0, iter_271_1 in pairs(arg_268_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_271_1 then
							if arg_268_1.isInRecall_ then
								iter_271_1.color = Color.New(Mathf.Lerp(iter_271_1.color.r, arg_268_1.hightColor2.r, (arg_268_1.time_ - 0) / var_271_0), Mathf.Lerp(iter_271_1.color.g, arg_268_1.hightColor2.g, (arg_268_1.time_ - 0) / var_271_0), (Mathf.Lerp(iter_271_1.color.b, arg_268_1.hightColor2.b, (arg_268_1.time_ - 0) / var_271_0)))
							else
								local var_271_1 = Mathf.Lerp(iter_271_1.color.r, 0.5, (arg_268_1.time_ - 0) / var_271_0)

								iter_271_1.color = Color.New(var_271_1, var_271_1, var_271_1)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 and not isNil(arg_268_1.actors_["1028"]) and arg_268_1.var_.actorSpriteComps1028 then
				for iter_271_2, iter_271_3 in pairs(arg_268_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_271_3 then
						iter_271_3.color = arg_268_1.isInRecall_ and (arg_268_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_268_1.var_.actorSpriteComps1028 = nil
			end

			local var_271_2 = 0
			local var_271_3 = 0.425

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_2 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_6")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_4 = arg_268_1:GetWordFromCfg(416191063)
				local var_271_5 = arg_268_1:FormatText(var_271_4.content)

				arg_268_1.text_.text = var_271_5

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_7 = 17 <= 0 and var_271_3 or var_271_3 * (utf8.len(var_271_5) / 17)

				if (17 <= 0 and var_271_3 or var_271_3 * (utf8.len(var_271_5) / 17)) > 0 and var_271_3 < var_271_7 then
					arg_268_1.talkMaxDuration = var_271_7

					if var_271_7 + var_271_2 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_7 + var_271_2
					end
				end

				arg_268_1.text_.text = var_271_5
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191063", "story_v_out_416191.awb") ~= 0 then
					local var_271_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191063", "story_v_out_416191.awb") / 1000

					if var_271_8 + var_271_2 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_8 + var_271_2
					end

					if var_271_4.prefab_name ~= "" and arg_268_1.actors_[var_271_4.prefab_name] ~= nil then
						local var_271_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_4.prefab_name].transform, "story_v_out_416191", "416191063", "story_v_out_416191.awb")

						arg_268_1:RecordAudio("416191063", var_271_9)
						arg_268_1:RecordAudio("416191063", var_271_9)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_416191", "416191063", "story_v_out_416191.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_416191", "416191063", "story_v_out_416191.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_10 = math.max(var_271_3, arg_268_1.talkMaxDuration)

			if var_271_2 <= arg_268_1.time_ and arg_268_1.time_ < var_271_2 + var_271_10 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_2) / var_271_10

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_2 + var_271_10 and arg_268_1.time_ < var_271_2 + var_271_10 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play416191064 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 416191064
		arg_272_1.duration_ = 9.97

		local var_272_0 = {
			zh = 5.666,
			ja = 9.966
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play416191065(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0.525

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_6")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_1 = arg_272_1:GetWordFromCfg(416191064)
				local var_275_2 = arg_272_1:FormatText(var_275_1.content)

				arg_272_1.text_.text = var_275_2

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_4 = 21 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 21)

				if (21 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 21)) > 0 and var_275_0 < var_275_4 then
					arg_272_1.talkMaxDuration = var_275_4

					if var_275_4 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_4 + 0
					end
				end

				arg_272_1.text_.text = var_275_2
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191064", "story_v_out_416191.awb") ~= 0 then
					local var_275_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191064", "story_v_out_416191.awb") / 1000

					if var_275_5 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_5 + 0
					end

					if var_275_1.prefab_name ~= "" and arg_272_1.actors_[var_275_1.prefab_name] ~= nil then
						local var_275_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_1.prefab_name].transform, "story_v_out_416191", "416191064", "story_v_out_416191.awb")

						arg_272_1:RecordAudio("416191064", var_275_6)
						arg_272_1:RecordAudio("416191064", var_275_6)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_416191", "416191064", "story_v_out_416191.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_416191", "416191064", "story_v_out_416191.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_7 = math.max(var_275_0, arg_272_1.talkMaxDuration)

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_7 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - 0) / var_275_7

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= 0 + var_275_7 and arg_272_1.time_ < 0 + var_275_7 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play416191065 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 416191065
		arg_276_1.duration_ = 4.9

		local var_276_0 = {
			zh = 4.9,
			ja = 4.766
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play416191066(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(arg_276_1.actors_["1028"]) and arg_276_1.var_.actorSpriteComps1028 == nil then
				arg_276_1.var_.actorSpriteComps1028 = arg_276_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_0 = 0.2

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 and not isNil(arg_276_1.actors_["1028"]) then
				if arg_276_1.var_.actorSpriteComps1028 then
					for iter_279_0, iter_279_1 in pairs(arg_276_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_279_1 then
							if arg_276_1.isInRecall_ then
								iter_279_1.color = Color.New(Mathf.Lerp(iter_279_1.color.r, arg_276_1.hightColor1.r, (arg_276_1.time_ - 0) / var_279_0), Mathf.Lerp(iter_279_1.color.g, arg_276_1.hightColor1.g, (arg_276_1.time_ - 0) / var_279_0), (Mathf.Lerp(iter_279_1.color.b, arg_276_1.hightColor1.b, (arg_276_1.time_ - 0) / var_279_0)))
							else
								local var_279_1 = Mathf.Lerp(iter_279_1.color.r, 1, (arg_276_1.time_ - 0) / var_279_0)

								iter_279_1.color = Color.New(var_279_1, var_279_1, var_279_1)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 and not isNil(arg_276_1.actors_["1028"]) and arg_276_1.var_.actorSpriteComps1028 then
				for iter_279_2, iter_279_3 in pairs(arg_276_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_279_3 then
						iter_279_3.color = arg_276_1.isInRecall_ and (arg_276_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_276_1.var_.actorSpriteComps1028 = nil
			end

			local var_279_2 = 0
			local var_279_3 = 0.45

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_2 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_4 = arg_276_1:GetWordFromCfg(416191065)
				local var_279_5 = arg_276_1:FormatText(var_279_4.content)

				arg_276_1.text_.text = var_279_5

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_7 = 18 <= 0 and var_279_3 or var_279_3 * (utf8.len(var_279_5) / 18)

				if (18 <= 0 and var_279_3 or var_279_3 * (utf8.len(var_279_5) / 18)) > 0 and var_279_3 < var_279_7 then
					arg_276_1.talkMaxDuration = var_279_7

					if var_279_7 + var_279_2 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_7 + var_279_2
					end
				end

				arg_276_1.text_.text = var_279_5
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191065", "story_v_out_416191.awb") ~= 0 then
					local var_279_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191065", "story_v_out_416191.awb") / 1000

					if var_279_8 + var_279_2 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_8 + var_279_2
					end

					if var_279_4.prefab_name ~= "" and arg_276_1.actors_[var_279_4.prefab_name] ~= nil then
						local var_279_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_4.prefab_name].transform, "story_v_out_416191", "416191065", "story_v_out_416191.awb")

						arg_276_1:RecordAudio("416191065", var_279_9)
						arg_276_1:RecordAudio("416191065", var_279_9)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_416191", "416191065", "story_v_out_416191.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_416191", "416191065", "story_v_out_416191.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_10 = math.max(var_279_3, arg_276_1.talkMaxDuration)

			if var_279_2 <= arg_276_1.time_ and arg_276_1.time_ < var_279_2 + var_279_10 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_2) / var_279_10

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_2 + var_279_10 and arg_276_1.time_ < var_279_2 + var_279_10 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play416191066 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 416191066
		arg_280_1.duration_ = 8.17

		local var_280_0 = {
			zh = 6.866,
			ja = 8.166
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play416191067(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(arg_280_1.actors_["1028"]) and arg_280_1.var_.actorSpriteComps1028 == nil then
				arg_280_1.var_.actorSpriteComps1028 = arg_280_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_283_0 = 0.2

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 and not isNil(arg_280_1.actors_["1028"]) then
				if arg_280_1.var_.actorSpriteComps1028 then
					for iter_283_0, iter_283_1 in pairs(arg_280_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_283_1 then
							if arg_280_1.isInRecall_ then
								iter_283_1.color = Color.New(Mathf.Lerp(iter_283_1.color.r, arg_280_1.hightColor2.r, (arg_280_1.time_ - 0) / var_283_0), Mathf.Lerp(iter_283_1.color.g, arg_280_1.hightColor2.g, (arg_280_1.time_ - 0) / var_283_0), (Mathf.Lerp(iter_283_1.color.b, arg_280_1.hightColor2.b, (arg_280_1.time_ - 0) / var_283_0)))
							else
								local var_283_1 = Mathf.Lerp(iter_283_1.color.r, 0.5, (arg_280_1.time_ - 0) / var_283_0)

								iter_283_1.color = Color.New(var_283_1, var_283_1, var_283_1)
							end
						end
					end
				end
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 and not isNil(arg_280_1.actors_["1028"]) and arg_280_1.var_.actorSpriteComps1028 then
				for iter_283_2, iter_283_3 in pairs(arg_280_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_283_3 then
						iter_283_3.color = arg_280_1.isInRecall_ and (arg_280_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_280_1.var_.actorSpriteComps1028 = nil
			end

			local var_283_2 = 0
			local var_283_3 = 0.525

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_2 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_6")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_4 = arg_280_1:GetWordFromCfg(416191066)
				local var_283_5 = arg_280_1:FormatText(var_283_4.content)

				arg_280_1.text_.text = var_283_5

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_7 = 21 <= 0 and var_283_3 or var_283_3 * (utf8.len(var_283_5) / 21)

				if (21 <= 0 and var_283_3 or var_283_3 * (utf8.len(var_283_5) / 21)) > 0 and var_283_3 < var_283_7 then
					arg_280_1.talkMaxDuration = var_283_7

					if var_283_7 + var_283_2 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_2
					end
				end

				arg_280_1.text_.text = var_283_5
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191066", "story_v_out_416191.awb") ~= 0 then
					local var_283_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191066", "story_v_out_416191.awb") / 1000

					if var_283_8 + var_283_2 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_8 + var_283_2
					end

					if var_283_4.prefab_name ~= "" and arg_280_1.actors_[var_283_4.prefab_name] ~= nil then
						local var_283_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_4.prefab_name].transform, "story_v_out_416191", "416191066", "story_v_out_416191.awb")

						arg_280_1:RecordAudio("416191066", var_283_9)
						arg_280_1:RecordAudio("416191066", var_283_9)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_416191", "416191066", "story_v_out_416191.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_416191", "416191066", "story_v_out_416191.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_10 = math.max(var_283_3, arg_280_1.talkMaxDuration)

			if var_283_2 <= arg_280_1.time_ and arg_280_1.time_ < var_283_2 + var_283_10 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_2) / var_283_10

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_2 + var_283_10 and arg_280_1.time_ < var_283_2 + var_283_10 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play416191067 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 416191067
		arg_284_1.duration_ = 5.8

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play416191068(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_9000

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(arg_284_1.actors_["1086"]) and arg_284_1.var_.actorSpriteComps1086 == nil then
				arg_284_1.var_.actorSpriteComps1086 = arg_284_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_287_0 = 0.2

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 and not isNil(arg_284_1.actors_["1086"]) then
				if arg_284_1.var_.actorSpriteComps1086 then
					for iter_287_0, iter_287_1 in pairs(arg_284_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_287_1 then
							if arg_284_1.isInRecall_ then
								iter_287_1.color = Color.New(Mathf.Lerp(iter_287_1.color.r, arg_284_1.hightColor2.r, (arg_284_1.time_ - 0) / var_287_0), Mathf.Lerp(iter_287_1.color.g, arg_284_1.hightColor2.g, (arg_284_1.time_ - 0) / var_287_0), (Mathf.Lerp(iter_287_1.color.b, arg_284_1.hightColor2.b, (arg_284_1.time_ - 0) / var_287_0)))
							else
								local var_287_1 = Mathf.Lerp(iter_287_1.color.r, 0.5, (arg_284_1.time_ - 0) / var_287_0)

								iter_287_1.color = Color.New(var_287_1, var_287_1, var_287_1)
							end
						end
					end
				end
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 and not isNil(arg_284_1.actors_["1086"]) and arg_284_1.var_.actorSpriteComps1086 then
				for iter_287_2, iter_287_3 in pairs(arg_284_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_287_3 then
						iter_287_3.color = arg_284_1.isInRecall_ and (arg_284_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_284_1.var_.actorSpriteComps1086 = nil
			end

			local var_287_2 = arg_284_1.actors_["1028"].transform

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPos1028 = var_287_2.localPosition
				var_287_2.localScale = Vector3.New(1, 1, 1)

				arg_284_1:CheckSpriteTmpPos("1028", 7)

				for iter_287_4 = 0, var_287_2.childCount - 1 do
					local var_287_3 = var_287_2:GetChild(iter_287_4)

					if var_287_3.name == "" or not string.find(var_287_3.name, "split") then
						var_287_3.gameObject:SetActive(true)
					else
						var_287_3.gameObject:SetActive(false)
					end
				end
			end

			local var_287_4 = 0.001

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_4 then
				var_287_2.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_284_1.time_ - 0) / var_287_4)
			end

			if arg_284_1.time_ >= 0 + var_287_4 and arg_284_1.time_ < 0 + var_287_4 + arg_287_0 then
				var_287_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_287_5 = manager.ui.mainCamera.transform

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.shakeOldPos = var_287_5.localPosition
			end

			local var_287_6 = 0.566666666666667

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_6 then
				local var_287_7, var_287_8 = math.modf((arg_284_1.time_ - 0) / 0.066)

				var_287_5.localPosition = Vector3.New(var_287_8 * 0.13, var_287_8 * 0.13, var_287_8 * 0.13) + arg_284_1.var_.shakeOldPos
			end

			if arg_284_1.time_ >= 0 + var_287_6 and arg_284_1.time_ < 0 + var_287_6 + arg_287_0 then
				var_287_5.localPosition = arg_284_1.var_.shakeOldPos
			end

			local var_287_9 = 0.366666666666667

			if 0.366666666666667 < arg_284_1.time_ and arg_284_1.time_ <= var_287_9 + arg_287_0 then
				arg_284_1.mask_.enabled = true
				arg_284_1.mask_.raycastTarget = true

				arg_284_1:SetGaussion(false)
			end

			local var_287_10 = 0.633333333333333

			if var_287_9 <= arg_284_1.time_ and arg_284_1.time_ < var_287_9 + var_287_10 then
				local var_287_11 = Color.New(1, 1, 1)

				var_287_11.a = Mathf.Lerp(1, 0, (arg_284_1.time_ - var_287_9) / var_287_10)
				arg_284_1.mask_.color = var_287_11
			end

			if arg_284_1.time_ >= var_287_9 + var_287_10 and arg_284_1.time_ < var_287_9 + var_287_10 + arg_287_0 then
				local var_287_12 = Color.New(1, 1, 1)

				arg_284_1.mask_.enabled = false
				var_287_12.a = 0
				arg_284_1.mask_.color = var_287_12
			end

			local var_287_13 = 0

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_13 + arg_287_0 then
				arg_284_1.allBtn_.enabled = false
			end

			if arg_284_1.time_ >= var_287_13 + 1 and arg_284_1.time_ < var_287_13 + 1 + arg_287_0 then
				arg_284_1.allBtn_.enabled = true
			end

			if 0.366666666666667 < arg_284_1.time_ and arg_284_1.time_ <= 0.366666666666667 + arg_287_0 then
				local var_287_14 = arg_284_1.var_.effect116

				if not arg_284_1.var_.effect116 then
					var_287_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_keep"), manager.ui.mainCamera.transform)
					var_287_14.name = "116"
					arg_284_1.var_.effect116 = var_287_14
				else
					var_287_14.transform:SetParent(var_287_9000)
				end

				var_287_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_287_14.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_287_16 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_287_17 = var_287_14.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_287_5, iter_287_6 in ipairs((var_287_17:ToTable())) do
					iter_287_6.transform.localScale = Vector3.New(iter_287_6.transform.localScale.x / var_287_16 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_287_17 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_287_6.transform.localScale.y / var_287_16, iter_287_6.transform.localScale.z)
				end
			end

			if 0.4 < arg_284_1.time_ and arg_284_1.time_ <= 0.4 + arg_287_0 then
				arg_284_1:AudioAction("play", "effect", "se_story_side_1028", "se_story_1028_thunder", "")
			end

			if arg_284_1.frameCnt_ <= 1 then
				arg_284_1.dialog_:SetActive(false)
			end

			local var_287_20 = 0.8
			local var_287_21 = 1.35

			if 0.8 < arg_284_1.time_ and arg_284_1.time_ <= var_287_20 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0

				arg_284_1.dialog_:SetActive(true)

				arg_284_1.dialogCg_.alpha = 0

				local var_287_22 = LeanTween.value(arg_284_1.dialog_, 0, 1, 0.3)

				var_287_22:setOnUpdate(LuaHelper.FloatAction(function(arg_288_0)
					arg_284_1.dialogCg_.alpha = arg_288_0
				end))
				var_287_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_284_1.dialog_)
					var_287_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_284_1.duration_ = arg_284_1.duration_ + 0.3

				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_23 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(416191067).content)

				arg_284_1.text_.text = var_287_23

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_25 = 54 <= 0 and var_287_21 or var_287_21 * (utf8.len(var_287_23) / 54)

				if (54 <= 0 and var_287_21 or var_287_21 * (utf8.len(var_287_23) / 54)) > 0 and var_287_21 < var_287_25 then
					arg_284_1.talkMaxDuration = var_287_25
					var_287_20 = var_287_20 + 0.3

					if var_287_25 + var_287_20 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_25 + var_287_20
					end
				end

				arg_284_1.text_.text = var_287_23
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_26 = var_287_20 + 0.3
			local var_287_27 = math.max(var_287_21, arg_284_1.talkMaxDuration)

			if var_287_20 + 0.3 <= arg_284_1.time_ and arg_284_1.time_ < var_287_26 + var_287_27 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_26) / var_287_27

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_26 + var_287_27 and arg_284_1.time_ < var_287_26 + var_287_27 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play416191068 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 416191068
		arg_290_1.duration_ = 6.97

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play416191069(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 1 < arg_290_1.time_ and arg_290_1.time_ <= 1 + arg_293_0 then
				local var_293_0 = arg_290_1.bgs_.STwhite

				arg_290_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_293_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_293_1 = var_293_0:GetComponent("SpriteRenderer")

				if var_293_1 and var_293_1.sprite then
					local var_293_2 = 2 * (var_293_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_293_0.transform.localScale = Vector3.New(var_293_2 / var_293_1.sprite.bounds.size.y < var_293_2 * manager.ui.mainCameraCom_.aspect / var_293_1.sprite.bounds.size.x and var_293_2 * manager.ui.mainCameraCom_.aspect / var_293_1.sprite.bounds.size.x or var_293_2 / var_293_1.sprite.bounds.size.y, var_293_2 / var_293_1.sprite.bounds.size.y < var_293_2 * manager.ui.mainCameraCom_.aspect / var_293_1.sprite.bounds.size.x and var_293_2 * manager.ui.mainCameraCom_.aspect / var_293_1.sprite.bounds.size.x or var_293_2 / var_293_1.sprite.bounds.size.y, 0)
				end

				for iter_293_0, iter_293_1 in pairs(arg_290_1.bgs_) do
					if iter_293_0 ~= "STwhite" then
						iter_293_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_293_3 = 1

			if 1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_3 + arg_293_0 then
				arg_290_1.allBtn_.enabled = false
			end

			if arg_290_1.time_ >= var_293_3 + 0.3 and arg_290_1.time_ < var_293_3 + 0.3 + arg_293_0 then
				arg_290_1.allBtn_.enabled = true
			end

			local var_293_4 = 0

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_4 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_5 = 1

			if var_293_4 <= arg_290_1.time_ and arg_290_1.time_ < var_293_4 + var_293_5 then
				local var_293_6 = Color.New(0, 0, 0)

				var_293_6.a = Mathf.Lerp(0, 1, (arg_290_1.time_ - var_293_4) / var_293_5)
				arg_290_1.mask_.color = var_293_6
			end

			if arg_290_1.time_ >= var_293_4 + var_293_5 and arg_290_1.time_ < var_293_4 + var_293_5 + arg_293_0 then
				local var_293_7 = Color.New(0, 0, 0)

				var_293_7.a = 1
				arg_290_1.mask_.color = var_293_7
			end

			local var_293_8 = 1

			if 1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_8 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_9 = 1.36666666666667

			if var_293_8 <= arg_290_1.time_ and arg_290_1.time_ < var_293_8 + var_293_9 then
				local var_293_10 = Color.New(0, 0, 0)

				var_293_10.a = Mathf.Lerp(1, 0, (arg_290_1.time_ - var_293_8) / var_293_9)
				arg_290_1.mask_.color = var_293_10
			end

			if arg_290_1.time_ >= var_293_8 + var_293_9 and arg_290_1.time_ < var_293_8 + var_293_9 + arg_293_0 then
				local var_293_11 = Color.New(0, 0, 0)

				arg_290_1.mask_.enabled = false
				var_293_11.a = 0
				arg_290_1.mask_.color = var_293_11
			end

			if 1 < arg_290_1.time_ and arg_290_1.time_ <= 1 + arg_293_0 then
				if arg_290_1.var_.effect116 then
					Object.Destroy(arg_290_1.var_.effect116)

					arg_290_1.var_.effect116 = nil
				end
			end

			if 1.63333333333333 < arg_290_1.time_ and arg_290_1.time_ <= 1.63333333333333 + arg_293_0 then
				arg_290_1:AudioAction("play", "effect", "se_story_138", "se_story_138_elecskill01", "")
			end

			if arg_290_1.frameCnt_ <= 1 then
				arg_290_1.dialog_:SetActive(false)
			end

			local var_293_14 = 1.96666666666667
			local var_293_15 = 1.55

			if 1.96666666666667 < arg_290_1.time_ and arg_290_1.time_ <= var_293_14 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0

				arg_290_1.dialog_:SetActive(true)

				arg_290_1.dialogCg_.alpha = 0

				local var_293_16 = LeanTween.value(arg_290_1.dialog_, 0, 1, 0.3)

				var_293_16:setOnUpdate(LuaHelper.FloatAction(function(arg_294_0)
					arg_290_1.dialogCg_.alpha = arg_294_0
				end))
				var_293_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_290_1.dialog_)
					var_293_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_290_1.duration_ = arg_290_1.duration_ + 0.3

				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_17 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(416191068).content)

				arg_290_1.text_.text = var_293_17

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_19 = 62 <= 0 and var_293_15 or var_293_15 * (utf8.len(var_293_17) / 62)

				if (62 <= 0 and var_293_15 or var_293_15 * (utf8.len(var_293_17) / 62)) > 0 and var_293_15 < var_293_19 then
					arg_290_1.talkMaxDuration = var_293_19
					var_293_14 = var_293_14 + 0.3

					if var_293_19 + var_293_14 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_19 + var_293_14
					end
				end

				arg_290_1.text_.text = var_293_17
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_20 = var_293_14 + 0.3
			local var_293_21 = math.max(var_293_15, arg_290_1.talkMaxDuration)

			if var_293_14 + 0.3 <= arg_290_1.time_ and arg_290_1.time_ < var_293_20 + var_293_21 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_20) / var_293_21

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_20 + var_293_21 and arg_290_1.time_ < var_293_20 + var_293_21 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play416191069 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 416191069
		arg_296_1.duration_ = 8.37

		local var_296_0 = {
			zh = 8.366,
			ja = 7.933
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play416191070(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 1 < arg_296_1.time_ and arg_296_1.time_ <= 1 + arg_299_0 then
				local var_299_0 = arg_296_1.bgs_.F09f

				arg_296_1.bgs_.F09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_299_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_299_1 = var_299_0:GetComponent("SpriteRenderer")

				if var_299_1 and var_299_1.sprite then
					local var_299_2 = 2 * (var_299_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_299_0.transform.localScale = Vector3.New(var_299_2 / var_299_1.sprite.bounds.size.y < var_299_2 * manager.ui.mainCameraCom_.aspect / var_299_1.sprite.bounds.size.x and var_299_2 * manager.ui.mainCameraCom_.aspect / var_299_1.sprite.bounds.size.x or var_299_2 / var_299_1.sprite.bounds.size.y, var_299_2 / var_299_1.sprite.bounds.size.y < var_299_2 * manager.ui.mainCameraCom_.aspect / var_299_1.sprite.bounds.size.x and var_299_2 * manager.ui.mainCameraCom_.aspect / var_299_1.sprite.bounds.size.x or var_299_2 / var_299_1.sprite.bounds.size.y, 0)
				end

				for iter_299_0, iter_299_1 in pairs(arg_296_1.bgs_) do
					if iter_299_0 ~= "F09f" then
						iter_299_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_299_3 = 1

			if 1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_3 + arg_299_0 then
				arg_296_1.allBtn_.enabled = false
			end

			if arg_296_1.time_ >= var_299_3 + 0.3 and arg_296_1.time_ < var_299_3 + 0.3 + arg_299_0 then
				arg_296_1.allBtn_.enabled = true
			end

			local var_299_4 = 0

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_4 + arg_299_0 then
				arg_296_1.mask_.enabled = true
				arg_296_1.mask_.raycastTarget = true

				arg_296_1:SetGaussion(false)
			end

			local var_299_5 = 1

			if var_299_4 <= arg_296_1.time_ and arg_296_1.time_ < var_299_4 + var_299_5 then
				local var_299_6 = Color.New(0, 0, 0)

				var_299_6.a = Mathf.Lerp(0, 1, (arg_296_1.time_ - var_299_4) / var_299_5)
				arg_296_1.mask_.color = var_299_6
			end

			if arg_296_1.time_ >= var_299_4 + var_299_5 and arg_296_1.time_ < var_299_4 + var_299_5 + arg_299_0 then
				local var_299_7 = Color.New(0, 0, 0)

				var_299_7.a = 1
				arg_296_1.mask_.color = var_299_7
			end

			local var_299_8 = 1

			if 1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_8 + arg_299_0 then
				arg_296_1.mask_.enabled = true
				arg_296_1.mask_.raycastTarget = true

				arg_296_1:SetGaussion(false)
			end

			local var_299_9 = 2

			if var_299_8 <= arg_296_1.time_ and arg_296_1.time_ < var_299_8 + var_299_9 then
				local var_299_10 = Color.New(0, 0, 0)

				var_299_10.a = Mathf.Lerp(1, 0, (arg_296_1.time_ - var_299_8) / var_299_9)
				arg_296_1.mask_.color = var_299_10
			end

			if arg_296_1.time_ >= var_299_8 + var_299_9 and arg_296_1.time_ < var_299_8 + var_299_9 + arg_299_0 then
				local var_299_11 = Color.New(0, 0, 0)

				arg_296_1.mask_.enabled = false
				var_299_11.a = 0
				arg_296_1.mask_.color = var_299_11
			end

			local var_299_12 = arg_296_1.actors_["1086"]

			if 1 < arg_296_1.time_ and arg_296_1.time_ <= 1 + arg_299_0 and not isNil(var_299_12) and arg_296_1.var_.actorSpriteComps1086 == nil then
				arg_296_1.var_.actorSpriteComps1086 = var_299_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_13 = 0.2

			if 1 <= arg_296_1.time_ and arg_296_1.time_ < 1 + var_299_13 and not isNil(var_299_12) then
				if arg_296_1.var_.actorSpriteComps1086 then
					for iter_299_2, iter_299_3 in pairs(arg_296_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_299_3 then
							if arg_296_1.isInRecall_ then
								iter_299_3.color = Color.New(Mathf.Lerp(iter_299_3.color.r, arg_296_1.hightColor1.r, (arg_296_1.time_ - 1) / var_299_13), Mathf.Lerp(iter_299_3.color.g, arg_296_1.hightColor1.g, (arg_296_1.time_ - 1) / var_299_13), (Mathf.Lerp(iter_299_3.color.b, arg_296_1.hightColor1.b, (arg_296_1.time_ - 1) / var_299_13)))
							else
								local var_299_14 = Mathf.Lerp(iter_299_3.color.r, 1, (arg_296_1.time_ - 1) / var_299_13)

								iter_299_3.color = Color.New(var_299_14, var_299_14, var_299_14)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= 1 + var_299_13 and arg_296_1.time_ < 1 + var_299_13 + arg_299_0 and not isNil(var_299_12) and arg_296_1.var_.actorSpriteComps1086 then
				for iter_299_4, iter_299_5 in pairs(arg_296_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_299_5 then
						iter_299_5.color = arg_296_1.isInRecall_ and (arg_296_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_296_1.var_.actorSpriteComps1086 = nil
			end

			local var_299_15

			if 1 < arg_296_1.time_ and arg_296_1.time_ <= 1 + arg_299_0 then
				local var_299_16 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_299_16 then
					var_299_16.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_299_16.radialBlurScale = 0
					var_299_16.radialBlurGradient = 1
					var_299_16.radialBlurIntensity = 1

					if var_299_15 then
						var_299_16.radialBlurTarget = var_299_15.transform
					end
				end
			end

			local var_299_17 = 0.3

			if 1 <= arg_296_1.time_ and arg_296_1.time_ < 1 + var_299_17 then
				local var_299_18 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_299_18 then
					var_299_18.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_299_18.radialBlurScale = Mathf.Lerp(0, 0, (arg_296_1.time_ - 1) / var_299_17)
					var_299_18.radialBlurGradient = Mathf.Lerp(1, 1, (arg_296_1.time_ - 1) / var_299_17)
					var_299_18.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_296_1.time_ - 1) / var_299_17)
				end
			end

			if arg_296_1.time_ >= 1 + var_299_17 and arg_296_1.time_ < 1 + var_299_17 + arg_299_0 then
				local var_299_19 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_299_19 then
					var_299_19.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_299_19.radialBlurScale = 0
					var_299_19.radialBlurGradient = 1
					var_299_19.radialBlurIntensity = 1
				end
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			if arg_296_1.frameCnt_ <= 1 then
				arg_296_1.dialog_:SetActive(false)
			end

			local var_299_21 = 2.6
			local var_299_22 = 0.4

			if 2.6 < arg_296_1.time_ and arg_296_1.time_ <= var_299_21 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0

				arg_296_1.dialog_:SetActive(true)

				arg_296_1.dialogCg_.alpha = 0

				local var_299_23 = LeanTween.value(arg_296_1.dialog_, 0, 1, 0.3)

				var_299_23:setOnUpdate(LuaHelper.FloatAction(function(arg_300_0)
					arg_296_1.dialogCg_.alpha = arg_300_0
				end))
				var_299_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_296_1.dialog_)
					var_299_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_296_1.duration_ = arg_296_1.duration_ + 0.3

				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, true)
				arg_296_1.iconController_:SetSelectedState("hero")

				arg_296_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_5")

				arg_296_1.callingController_:SetSelectedState("normal")

				arg_296_1.keyicon_.color = Color.New(1, 1, 1)
				arg_296_1.icon_.color = Color.New(1, 1, 1)

				local var_299_24 = arg_296_1:GetWordFromCfg(416191069)
				local var_299_25 = arg_296_1:FormatText(var_299_24.content)

				arg_296_1.text_.text = var_299_25

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_27 = 16 <= 0 and var_299_22 or var_299_22 * (utf8.len(var_299_25) / 16)

				if (16 <= 0 and var_299_22 or var_299_22 * (utf8.len(var_299_25) / 16)) > 0 and var_299_22 < var_299_27 then
					arg_296_1.talkMaxDuration = var_299_27
					var_299_21 = var_299_21 + 0.3

					if var_299_27 + var_299_21 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_27 + var_299_21
					end
				end

				arg_296_1.text_.text = var_299_25
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191069", "story_v_out_416191.awb") ~= 0 then
					local var_299_28 = manager.audio:GetVoiceLength("story_v_out_416191", "416191069", "story_v_out_416191.awb") / 1000

					if var_299_28 + var_299_21 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_28 + var_299_21
					end

					if var_299_24.prefab_name ~= "" and arg_296_1.actors_[var_299_24.prefab_name] ~= nil then
						local var_299_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_24.prefab_name].transform, "story_v_out_416191", "416191069", "story_v_out_416191.awb")

						arg_296_1:RecordAudio("416191069", var_299_29)
						arg_296_1:RecordAudio("416191069", var_299_29)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_416191", "416191069", "story_v_out_416191.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_416191", "416191069", "story_v_out_416191.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_30 = var_299_21 + 0.3
			local var_299_31 = math.max(var_299_22, arg_296_1.talkMaxDuration)

			if var_299_21 + 0.3 <= arg_296_1.time_ and arg_296_1.time_ < var_299_30 + var_299_31 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_30) / var_299_31

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_30 + var_299_31 and arg_296_1.time_ < var_299_30 + var_299_31 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play416191070 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 416191070
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play416191071(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:AudioAction("play", "effect", "se_story_120_04", "se_story_120_04_clap", "")
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:AudioAction("stop", "effect", "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			local var_305_2 = 0
			local var_305_3 = 1.3

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_2 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_4 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(416191070).content)

				arg_302_1.text_.text = var_305_4

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_6 = 52 <= 0 and var_305_3 or var_305_3 * (utf8.len(var_305_4) / 52)

				if (52 <= 0 and var_305_3 or var_305_3 * (utf8.len(var_305_4) / 52)) > 0 and var_305_3 < var_305_6 then
					arg_302_1.talkMaxDuration = var_305_6

					if var_305_6 + var_305_2 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_6 + var_305_2
					end
				end

				arg_302_1.text_.text = var_305_4
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_7 = math.max(var_305_3, arg_302_1.talkMaxDuration)

			if var_305_2 <= arg_302_1.time_ and arg_302_1.time_ < var_305_2 + var_305_7 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_2) / var_305_7

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_2 + var_305_7 and arg_302_1.time_ < var_305_2 + var_305_7 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play416191071 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 416191071
		arg_306_1.duration_ = 10.2

		local var_306_0 = {
			zh = 10.1996666666667,
			ja = 7.43266666666667
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play416191072(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 1.53333333333333 < arg_306_1.time_ and arg_306_1.time_ <= 1.53333333333333 + arg_309_0 and not isNil(arg_306_1.actors_["1086"]) and arg_306_1.var_.actorSpriteComps1086 == nil then
				arg_306_1.var_.actorSpriteComps1086 = arg_306_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_0 = 0.2

			if 1.53333333333333 <= arg_306_1.time_ and arg_306_1.time_ < 1.53333333333333 + var_309_0 and not isNil(arg_306_1.actors_["1086"]) then
				if arg_306_1.var_.actorSpriteComps1086 then
					for iter_309_0, iter_309_1 in pairs(arg_306_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_309_1 then
							if arg_306_1.isInRecall_ then
								iter_309_1.color = Color.New(Mathf.Lerp(iter_309_1.color.r, arg_306_1.hightColor1.r, (arg_306_1.time_ - 1.53333333333333) / var_309_0), Mathf.Lerp(iter_309_1.color.g, arg_306_1.hightColor1.g, (arg_306_1.time_ - 1.53333333333333) / var_309_0), (Mathf.Lerp(iter_309_1.color.b, arg_306_1.hightColor1.b, (arg_306_1.time_ - 1.53333333333333) / var_309_0)))
							else
								local var_309_1 = Mathf.Lerp(iter_309_1.color.r, 1, (arg_306_1.time_ - 1.53333333333333) / var_309_0)

								iter_309_1.color = Color.New(var_309_1, var_309_1, var_309_1)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= 1.53333333333333 + var_309_0 and arg_306_1.time_ < 1.53333333333333 + var_309_0 + arg_309_0 and not isNil(arg_306_1.actors_["1086"]) and arg_306_1.var_.actorSpriteComps1086 then
				for iter_309_2, iter_309_3 in pairs(arg_306_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_309_3 then
						iter_309_3.color = arg_306_1.isInRecall_ and (arg_306_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_306_1.var_.actorSpriteComps1086 = nil
			end

			local var_309_2 = arg_306_1.actors_["1086"].transform

			if 1.53333333333333 < arg_306_1.time_ and arg_306_1.time_ <= 1.53333333333333 + arg_309_0 then
				arg_306_1.var_.moveOldPos1086 = var_309_2.localPosition
				var_309_2.localScale = Vector3.New(1, 1, 1)

				arg_306_1:CheckSpriteTmpPos("1086", 3)

				for iter_309_4 = 0, var_309_2.childCount - 1 do
					local var_309_3 = var_309_2:GetChild(iter_309_4)

					if var_309_3.name == "split_5" or not string.find(var_309_3.name, "split") then
						var_309_3.gameObject:SetActive(true)
					else
						var_309_3.gameObject:SetActive(false)
					end
				end
			end

			local var_309_4 = 0.001

			if 1.53333333333333 <= arg_306_1.time_ and arg_306_1.time_ < 1.53333333333333 + var_309_4 then
				var_309_2.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_306_1.time_ - 1.53333333333333) / var_309_4)
			end

			if arg_306_1.time_ >= 1.53333333333333 + var_309_4 and arg_306_1.time_ < 1.53333333333333 + var_309_4 + arg_309_0 then
				var_309_2.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_309_5

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				local var_309_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_309_6 then
					var_309_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_309_6.radialBlurScale = 0
					var_309_6.radialBlurGradient = 1
					var_309_6.radialBlurIntensity = 1

					if var_309_5 then
						var_309_6.radialBlurTarget = var_309_5.transform
					end
				end
			end

			local var_309_7 = 0.833333333333333

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_7 then
				local var_309_8 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_309_8 then
					var_309_8.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_309_8.radialBlurScale = Mathf.Lerp(0, 0, (arg_306_1.time_ - 0) / var_309_7)
					var_309_8.radialBlurGradient = Mathf.Lerp(1, 1, (arg_306_1.time_ - 0) / var_309_7)
					var_309_8.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_306_1.time_ - 0) / var_309_7)
				end
			end

			if arg_306_1.time_ >= 0 + var_309_7 and arg_306_1.time_ < 0 + var_309_7 + arg_309_0 then
				local var_309_9 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_309_9 then
					var_309_9.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_309_9.radialBlurScale = 0
					var_309_9.radialBlurGradient = 1
					var_309_9.radialBlurIntensity = 1
				end
			end

			local var_309_10 = 0

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_10 + arg_309_0 then
				arg_306_1.mask_.enabled = true
				arg_306_1.mask_.raycastTarget = true

				arg_306_1:SetGaussion(false)
			end

			local var_309_11 = 1.73333333333333

			if var_309_10 <= arg_306_1.time_ and arg_306_1.time_ < var_309_10 + var_309_11 then
				local var_309_12 = Color.New(0, 0, 0)

				var_309_12.a = Mathf.Lerp(1, 0, (arg_306_1.time_ - var_309_10) / var_309_11)
				arg_306_1.mask_.color = var_309_12
			end

			if arg_306_1.time_ >= var_309_10 + var_309_11 and arg_306_1.time_ < var_309_10 + var_309_11 + arg_309_0 then
				local var_309_13 = Color.New(0, 0, 0)

				arg_306_1.mask_.enabled = false
				var_309_13.a = 0
				arg_306_1.mask_.color = var_309_13
			end

			if 1.53333333333333 < arg_306_1.time_ and arg_306_1.time_ <= 1.53333333333333 + arg_309_0 then
				local var_309_14 = arg_306_1.actors_["1086"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_309_14 then
					arg_306_1.var_.alphaOldValue1086 = var_309_14.alpha
					arg_306_1.var_.characterEffect1086 = var_309_14
				end

				arg_306_1.var_.alphaOldValue1086 = 0
			end

			local var_309_15 = 0.2

			if 1.53333333333333 <= arg_306_1.time_ and arg_306_1.time_ < 1.53333333333333 + var_309_15 then
				if arg_306_1.var_.characterEffect1086 then
					arg_306_1.var_.characterEffect1086.alpha = Mathf.Lerp(arg_306_1.var_.alphaOldValue1086, 1, (arg_306_1.time_ - 1.53333333333333) / var_309_15)
				end
			end

			if arg_306_1.time_ >= 1.53333333333333 + var_309_15 and arg_306_1.time_ < 1.53333333333333 + var_309_15 + arg_309_0 and arg_306_1.var_.characterEffect1086 then
				arg_306_1.var_.characterEffect1086.alpha = 1
			end

			if arg_306_1.frameCnt_ <= 1 then
				arg_306_1.dialog_:SetActive(false)
			end

			local var_309_16 = 1.86666666666667
			local var_309_17 = 0.6

			if 1.86666666666667 < arg_306_1.time_ and arg_306_1.time_ <= var_309_16 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0

				arg_306_1.dialog_:SetActive(true)

				arg_306_1.dialogCg_.alpha = 0

				local var_309_18 = LeanTween.value(arg_306_1.dialog_, 0, 1, 0.3)

				var_309_18:setOnUpdate(LuaHelper.FloatAction(function(arg_310_0)
					arg_306_1.dialogCg_.alpha = arg_310_0
				end))
				var_309_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_306_1.dialog_)
					var_309_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_306_1.duration_ = arg_306_1.duration_ + 0.3

				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_19 = arg_306_1:GetWordFromCfg(416191071)
				local var_309_20 = arg_306_1:FormatText(var_309_19.content)

				arg_306_1.text_.text = var_309_20

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_22 = 24 <= 0 and var_309_17 or var_309_17 * (utf8.len(var_309_20) / 24)

				if (24 <= 0 and var_309_17 or var_309_17 * (utf8.len(var_309_20) / 24)) > 0 and var_309_17 < var_309_22 then
					arg_306_1.talkMaxDuration = var_309_22
					var_309_16 = var_309_16 + 0.3

					if var_309_22 + var_309_16 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_22 + var_309_16
					end
				end

				arg_306_1.text_.text = var_309_20
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191071", "story_v_out_416191.awb") ~= 0 then
					local var_309_23 = manager.audio:GetVoiceLength("story_v_out_416191", "416191071", "story_v_out_416191.awb") / 1000

					if var_309_23 + var_309_16 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_23 + var_309_16
					end

					if var_309_19.prefab_name ~= "" and arg_306_1.actors_[var_309_19.prefab_name] ~= nil then
						local var_309_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_19.prefab_name].transform, "story_v_out_416191", "416191071", "story_v_out_416191.awb")

						arg_306_1:RecordAudio("416191071", var_309_24)
						arg_306_1:RecordAudio("416191071", var_309_24)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_416191", "416191071", "story_v_out_416191.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_416191", "416191071", "story_v_out_416191.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_25 = var_309_16 + 0.3
			local var_309_26 = math.max(var_309_17, arg_306_1.talkMaxDuration)

			if var_309_16 + 0.3 <= arg_306_1.time_ and arg_306_1.time_ < var_309_25 + var_309_26 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_25) / var_309_26

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_25 + var_309_26 and arg_306_1.time_ < var_309_25 + var_309_26 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.53333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play416191072 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 416191072
		arg_312_1.duration_ = 10.13

		local var_312_0 = {
			zh = 6.033,
			ja = 10.133
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play416191073(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(arg_312_1.actors_["1028"]) and arg_312_1.var_.actorSpriteComps1028 == nil then
				arg_312_1.var_.actorSpriteComps1028 = arg_312_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_0 = 0.2

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 and not isNil(arg_312_1.actors_["1028"]) then
				if arg_312_1.var_.actorSpriteComps1028 then
					for iter_315_0, iter_315_1 in pairs(arg_312_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_315_1 then
							if arg_312_1.isInRecall_ then
								iter_315_1.color = Color.New(Mathf.Lerp(iter_315_1.color.r, arg_312_1.hightColor1.r, (arg_312_1.time_ - 0) / var_315_0), Mathf.Lerp(iter_315_1.color.g, arg_312_1.hightColor1.g, (arg_312_1.time_ - 0) / var_315_0), (Mathf.Lerp(iter_315_1.color.b, arg_312_1.hightColor1.b, (arg_312_1.time_ - 0) / var_315_0)))
							else
								local var_315_1 = Mathf.Lerp(iter_315_1.color.r, 1, (arg_312_1.time_ - 0) / var_315_0)

								iter_315_1.color = Color.New(var_315_1, var_315_1, var_315_1)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 and not isNil(arg_312_1.actors_["1028"]) and arg_312_1.var_.actorSpriteComps1028 then
				for iter_315_2, iter_315_3 in pairs(arg_312_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_315_3 then
						iter_315_3.color = arg_312_1.isInRecall_ and (arg_312_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_312_1.var_.actorSpriteComps1028 = nil
			end

			local var_315_2 = arg_312_1.actors_["1086"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_2) and arg_312_1.var_.actorSpriteComps1086 == nil then
				arg_312_1.var_.actorSpriteComps1086 = var_315_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_3 = 0.2

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_3 and not isNil(var_315_2) then
				if arg_312_1.var_.actorSpriteComps1086 then
					for iter_315_4, iter_315_5 in pairs(arg_312_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_315_5 then
							if arg_312_1.isInRecall_ then
								iter_315_5.color = Color.New(Mathf.Lerp(iter_315_5.color.r, arg_312_1.hightColor2.r, (arg_312_1.time_ - 0) / var_315_3), Mathf.Lerp(iter_315_5.color.g, arg_312_1.hightColor2.g, (arg_312_1.time_ - 0) / var_315_3), (Mathf.Lerp(iter_315_5.color.b, arg_312_1.hightColor2.b, (arg_312_1.time_ - 0) / var_315_3)))
							else
								local var_315_4 = Mathf.Lerp(iter_315_5.color.r, 0.5, (arg_312_1.time_ - 0) / var_315_3)

								iter_315_5.color = Color.New(var_315_4, var_315_4, var_315_4)
							end
						end
					end
				end
			end

			if arg_312_1.time_ >= 0 + var_315_3 and arg_312_1.time_ < 0 + var_315_3 + arg_315_0 and not isNil(var_315_2) and arg_312_1.var_.actorSpriteComps1086 then
				for iter_315_6, iter_315_7 in pairs(arg_312_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_315_7 then
						iter_315_7.color = arg_312_1.isInRecall_ and (arg_312_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_312_1.var_.actorSpriteComps1086 = nil
			end

			local var_315_5 = arg_312_1.actors_["1028"].transform

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos1028 = var_315_5.localPosition
				var_315_5.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("1028", 2)

				for iter_315_8 = 0, var_315_5.childCount - 1 do
					local var_315_6 = var_315_5:GetChild(iter_315_8)

					if var_315_6.name == "" or not string.find(var_315_6.name, "split") then
						var_315_6.gameObject:SetActive(true)
					else
						var_315_6.gameObject:SetActive(false)
					end
				end
			end

			local var_315_7 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_7 then
				var_315_5.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_312_1.time_ - 0) / var_315_7)
			end

			if arg_312_1.time_ >= 0 + var_315_7 and arg_312_1.time_ < 0 + var_315_7 + arg_315_0 then
				var_315_5.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_315_8 = arg_312_1.actors_["1086"].transform

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos1086 = var_315_8.localPosition
				var_315_8.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("1086", 4)

				for iter_315_9 = 0, var_315_8.childCount - 1 do
					local var_315_9 = var_315_8:GetChild(iter_315_9)

					if var_315_9.name == "split_5" or not string.find(var_315_9.name, "split") then
						var_315_9.gameObject:SetActive(true)
					else
						var_315_9.gameObject:SetActive(false)
					end
				end
			end

			local var_315_10 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_10 then
				var_315_8.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_312_1.time_ - 0) / var_315_10)
			end

			if arg_312_1.time_ >= 0 + var_315_10 and arg_312_1.time_ < 0 + var_315_10 + arg_315_0 then
				var_315_8.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_315_11 = 0
			local var_315_12 = 0.525

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_11 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_13 = arg_312_1:GetWordFromCfg(416191072)
				local var_315_14 = arg_312_1:FormatText(var_315_13.content)

				arg_312_1.text_.text = var_315_14

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_16 = 21 <= 0 and var_315_12 or var_315_12 * (utf8.len(var_315_14) / 21)

				if (21 <= 0 and var_315_12 or var_315_12 * (utf8.len(var_315_14) / 21)) > 0 and var_315_12 < var_315_16 then
					arg_312_1.talkMaxDuration = var_315_16

					if var_315_16 + var_315_11 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_16 + var_315_11
					end
				end

				arg_312_1.text_.text = var_315_14
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191072", "story_v_out_416191.awb") ~= 0 then
					local var_315_17 = manager.audio:GetVoiceLength("story_v_out_416191", "416191072", "story_v_out_416191.awb") / 1000

					if var_315_17 + var_315_11 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_17 + var_315_11
					end

					if var_315_13.prefab_name ~= "" and arg_312_1.actors_[var_315_13.prefab_name] ~= nil then
						local var_315_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_13.prefab_name].transform, "story_v_out_416191", "416191072", "story_v_out_416191.awb")

						arg_312_1:RecordAudio("416191072", var_315_18)
						arg_312_1:RecordAudio("416191072", var_315_18)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_416191", "416191072", "story_v_out_416191.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_416191", "416191072", "story_v_out_416191.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_19 = math.max(var_315_12, arg_312_1.talkMaxDuration)

			if var_315_11 <= arg_312_1.time_ and arg_312_1.time_ < var_315_11 + var_315_19 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_11) / var_315_19

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_11 + var_315_19 and arg_312_1.time_ < var_315_11 + var_315_19 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play416191073 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 416191073
		arg_316_1.duration_ = 7.9

		local var_316_0 = {
			zh = 5.566,
			ja = 7.9
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play416191074(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(arg_316_1.actors_["1086"]) and arg_316_1.var_.actorSpriteComps1086 == nil then
				arg_316_1.var_.actorSpriteComps1086 = arg_316_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_0 = 0.2

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_0 and not isNil(arg_316_1.actors_["1086"]) then
				if arg_316_1.var_.actorSpriteComps1086 then
					for iter_319_0, iter_319_1 in pairs(arg_316_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_319_1 then
							if arg_316_1.isInRecall_ then
								iter_319_1.color = Color.New(Mathf.Lerp(iter_319_1.color.r, arg_316_1.hightColor1.r, (arg_316_1.time_ - 0) / var_319_0), Mathf.Lerp(iter_319_1.color.g, arg_316_1.hightColor1.g, (arg_316_1.time_ - 0) / var_319_0), (Mathf.Lerp(iter_319_1.color.b, arg_316_1.hightColor1.b, (arg_316_1.time_ - 0) / var_319_0)))
							else
								local var_319_1 = Mathf.Lerp(iter_319_1.color.r, 1, (arg_316_1.time_ - 0) / var_319_0)

								iter_319_1.color = Color.New(var_319_1, var_319_1, var_319_1)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= 0 + var_319_0 and arg_316_1.time_ < 0 + var_319_0 + arg_319_0 and not isNil(arg_316_1.actors_["1086"]) and arg_316_1.var_.actorSpriteComps1086 then
				for iter_319_2, iter_319_3 in pairs(arg_316_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_319_3 then
						iter_319_3.color = arg_316_1.isInRecall_ and (arg_316_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_316_1.var_.actorSpriteComps1086 = nil
			end

			local var_319_2 = arg_316_1.actors_["1028"]

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(var_319_2) and arg_316_1.var_.actorSpriteComps1028 == nil then
				arg_316_1.var_.actorSpriteComps1028 = var_319_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_3 = 0.2

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_3 and not isNil(var_319_2) then
				if arg_316_1.var_.actorSpriteComps1028 then
					for iter_319_4, iter_319_5 in pairs(arg_316_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_319_5 then
							if arg_316_1.isInRecall_ then
								iter_319_5.color = Color.New(Mathf.Lerp(iter_319_5.color.r, arg_316_1.hightColor2.r, (arg_316_1.time_ - 0) / var_319_3), Mathf.Lerp(iter_319_5.color.g, arg_316_1.hightColor2.g, (arg_316_1.time_ - 0) / var_319_3), (Mathf.Lerp(iter_319_5.color.b, arg_316_1.hightColor2.b, (arg_316_1.time_ - 0) / var_319_3)))
							else
								local var_319_4 = Mathf.Lerp(iter_319_5.color.r, 0.5, (arg_316_1.time_ - 0) / var_319_3)

								iter_319_5.color = Color.New(var_319_4, var_319_4, var_319_4)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= 0 + var_319_3 and arg_316_1.time_ < 0 + var_319_3 + arg_319_0 and not isNil(var_319_2) and arg_316_1.var_.actorSpriteComps1028 then
				for iter_319_6, iter_319_7 in pairs(arg_316_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_319_7 then
						iter_319_7.color = arg_316_1.isInRecall_ and (arg_316_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_316_1.var_.actorSpriteComps1028 = nil
			end

			local var_319_5 = arg_316_1.actors_["1086"].transform

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.var_.moveOldPos1086 = var_319_5.localPosition
				var_319_5.localScale = Vector3.New(1, 1, 1)

				arg_316_1:CheckSpriteTmpPos("1086", 4)

				for iter_319_8 = 0, var_319_5.childCount - 1 do
					local var_319_6 = var_319_5:GetChild(iter_319_8)

					if var_319_6.name == "split_4" or not string.find(var_319_6.name, "split") then
						var_319_6.gameObject:SetActive(true)
					else
						var_319_6.gameObject:SetActive(false)
					end
				end
			end

			local var_319_7 = 0.001

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_7 then
				var_319_5.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_316_1.time_ - 0) / var_319_7)
			end

			if arg_316_1.time_ >= 0 + var_319_7 and arg_316_1.time_ < 0 + var_319_7 + arg_319_0 then
				var_319_5.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_319_8 = 0
			local var_319_9 = 0.45

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_8 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_10 = arg_316_1:GetWordFromCfg(416191073)
				local var_319_11 = arg_316_1:FormatText(var_319_10.content)

				arg_316_1.text_.text = var_319_11

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_13 = 18 <= 0 and var_319_9 or var_319_9 * (utf8.len(var_319_11) / 18)

				if (18 <= 0 and var_319_9 or var_319_9 * (utf8.len(var_319_11) / 18)) > 0 and var_319_9 < var_319_13 then
					arg_316_1.talkMaxDuration = var_319_13

					if var_319_13 + var_319_8 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_13 + var_319_8
					end
				end

				arg_316_1.text_.text = var_319_11
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191073", "story_v_out_416191.awb") ~= 0 then
					local var_319_14 = manager.audio:GetVoiceLength("story_v_out_416191", "416191073", "story_v_out_416191.awb") / 1000

					if var_319_14 + var_319_8 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_14 + var_319_8
					end

					if var_319_10.prefab_name ~= "" and arg_316_1.actors_[var_319_10.prefab_name] ~= nil then
						local var_319_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_10.prefab_name].transform, "story_v_out_416191", "416191073", "story_v_out_416191.awb")

						arg_316_1:RecordAudio("416191073", var_319_15)
						arg_316_1:RecordAudio("416191073", var_319_15)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_416191", "416191073", "story_v_out_416191.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_416191", "416191073", "story_v_out_416191.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_16 = math.max(var_319_9, arg_316_1.talkMaxDuration)

			if var_319_8 <= arg_316_1.time_ and arg_316_1.time_ < var_319_8 + var_319_16 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_8) / var_319_16

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_8 + var_319_16 and arg_316_1.time_ < var_319_8 + var_319_16 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_316_1:InitPlayNodeList()
	end,
	Play416191074 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 416191074
		arg_320_1.duration_ = 7.17

		local var_320_0 = {
			zh = 5.266,
			ja = 7.166
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play416191075(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 and not isNil(arg_320_1.actors_["1028"]) and arg_320_1.var_.actorSpriteComps1028 == nil then
				arg_320_1.var_.actorSpriteComps1028 = arg_320_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_323_0 = 0.2

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_0 and not isNil(arg_320_1.actors_["1028"]) then
				if arg_320_1.var_.actorSpriteComps1028 then
					for iter_323_0, iter_323_1 in pairs(arg_320_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_323_1 then
							if arg_320_1.isInRecall_ then
								iter_323_1.color = Color.New(Mathf.Lerp(iter_323_1.color.r, arg_320_1.hightColor1.r, (arg_320_1.time_ - 0) / var_323_0), Mathf.Lerp(iter_323_1.color.g, arg_320_1.hightColor1.g, (arg_320_1.time_ - 0) / var_323_0), (Mathf.Lerp(iter_323_1.color.b, arg_320_1.hightColor1.b, (arg_320_1.time_ - 0) / var_323_0)))
							else
								local var_323_1 = Mathf.Lerp(iter_323_1.color.r, 1, (arg_320_1.time_ - 0) / var_323_0)

								iter_323_1.color = Color.New(var_323_1, var_323_1, var_323_1)
							end
						end
					end
				end
			end

			if arg_320_1.time_ >= 0 + var_323_0 and arg_320_1.time_ < 0 + var_323_0 + arg_323_0 and not isNil(arg_320_1.actors_["1028"]) and arg_320_1.var_.actorSpriteComps1028 then
				for iter_323_2, iter_323_3 in pairs(arg_320_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_323_3 then
						iter_323_3.color = arg_320_1.isInRecall_ and (arg_320_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_320_1.var_.actorSpriteComps1028 = nil
			end

			local var_323_2 = arg_320_1.actors_["1086"]

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 and not isNil(var_323_2) and arg_320_1.var_.actorSpriteComps1086 == nil then
				arg_320_1.var_.actorSpriteComps1086 = var_323_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_323_3 = 0.2

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_3 and not isNil(var_323_2) then
				if arg_320_1.var_.actorSpriteComps1086 then
					for iter_323_4, iter_323_5 in pairs(arg_320_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_323_5 then
							if arg_320_1.isInRecall_ then
								iter_323_5.color = Color.New(Mathf.Lerp(iter_323_5.color.r, arg_320_1.hightColor2.r, (arg_320_1.time_ - 0) / var_323_3), Mathf.Lerp(iter_323_5.color.g, arg_320_1.hightColor2.g, (arg_320_1.time_ - 0) / var_323_3), (Mathf.Lerp(iter_323_5.color.b, arg_320_1.hightColor2.b, (arg_320_1.time_ - 0) / var_323_3)))
							else
								local var_323_4 = Mathf.Lerp(iter_323_5.color.r, 0.5, (arg_320_1.time_ - 0) / var_323_3)

								iter_323_5.color = Color.New(var_323_4, var_323_4, var_323_4)
							end
						end
					end
				end
			end

			if arg_320_1.time_ >= 0 + var_323_3 and arg_320_1.time_ < 0 + var_323_3 + arg_323_0 and not isNil(var_323_2) and arg_320_1.var_.actorSpriteComps1086 then
				for iter_323_6, iter_323_7 in pairs(arg_320_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_323_7 then
						iter_323_7.color = arg_320_1.isInRecall_ and (arg_320_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_320_1.var_.actorSpriteComps1086 = nil
			end

			local var_323_5 = 0
			local var_323_6 = 0.55

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_5 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_7 = arg_320_1:GetWordFromCfg(416191074)
				local var_323_8 = arg_320_1:FormatText(var_323_7.content)

				arg_320_1.text_.text = var_323_8

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_10 = 22 <= 0 and var_323_6 or var_323_6 * (utf8.len(var_323_8) / 22)

				if (22 <= 0 and var_323_6 or var_323_6 * (utf8.len(var_323_8) / 22)) > 0 and var_323_6 < var_323_10 then
					arg_320_1.talkMaxDuration = var_323_10

					if var_323_10 + var_323_5 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_10 + var_323_5
					end
				end

				arg_320_1.text_.text = var_323_8
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191074", "story_v_out_416191.awb") ~= 0 then
					local var_323_11 = manager.audio:GetVoiceLength("story_v_out_416191", "416191074", "story_v_out_416191.awb") / 1000

					if var_323_11 + var_323_5 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_11 + var_323_5
					end

					if var_323_7.prefab_name ~= "" and arg_320_1.actors_[var_323_7.prefab_name] ~= nil then
						local var_323_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_7.prefab_name].transform, "story_v_out_416191", "416191074", "story_v_out_416191.awb")

						arg_320_1:RecordAudio("416191074", var_323_12)
						arg_320_1:RecordAudio("416191074", var_323_12)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_416191", "416191074", "story_v_out_416191.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_416191", "416191074", "story_v_out_416191.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_13 = math.max(var_323_6, arg_320_1.talkMaxDuration)

			if var_323_5 <= arg_320_1.time_ and arg_320_1.time_ < var_323_5 + var_323_13 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_5) / var_323_13

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_5 + var_323_13 and arg_320_1.time_ < var_323_5 + var_323_13 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play416191075 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 416191075
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play416191076(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(arg_324_1.actors_["1028"]) and arg_324_1.var_.actorSpriteComps1028 == nil then
				arg_324_1.var_.actorSpriteComps1028 = arg_324_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_327_0 = 0.2

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_0 and not isNil(arg_324_1.actors_["1028"]) then
				if arg_324_1.var_.actorSpriteComps1028 then
					for iter_327_0, iter_327_1 in pairs(arg_324_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_327_1 then
							if arg_324_1.isInRecall_ then
								iter_327_1.color = Color.New(Mathf.Lerp(iter_327_1.color.r, arg_324_1.hightColor2.r, (arg_324_1.time_ - 0) / var_327_0), Mathf.Lerp(iter_327_1.color.g, arg_324_1.hightColor2.g, (arg_324_1.time_ - 0) / var_327_0), (Mathf.Lerp(iter_327_1.color.b, arg_324_1.hightColor2.b, (arg_324_1.time_ - 0) / var_327_0)))
							else
								local var_327_1 = Mathf.Lerp(iter_327_1.color.r, 0.5, (arg_324_1.time_ - 0) / var_327_0)

								iter_327_1.color = Color.New(var_327_1, var_327_1, var_327_1)
							end
						end
					end
				end
			end

			if arg_324_1.time_ >= 0 + var_327_0 and arg_324_1.time_ < 0 + var_327_0 + arg_327_0 and not isNil(arg_324_1.actors_["1028"]) and arg_324_1.var_.actorSpriteComps1028 then
				for iter_327_2, iter_327_3 in pairs(arg_324_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_327_3 then
						iter_327_3.color = arg_324_1.isInRecall_ and (arg_324_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_324_1.var_.actorSpriteComps1028 = nil
			end

			local var_327_2 = arg_324_1.actors_["1028"].transform

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.var_.moveOldPos1028 = var_327_2.localPosition
				var_327_2.localScale = Vector3.New(1, 1, 1)

				arg_324_1:CheckSpriteTmpPos("1028", 7)

				for iter_327_4 = 0, var_327_2.childCount - 1 do
					local var_327_3 = var_327_2:GetChild(iter_327_4)

					if var_327_3.name == "" or not string.find(var_327_3.name, "split") then
						var_327_3.gameObject:SetActive(true)
					else
						var_327_3.gameObject:SetActive(false)
					end
				end
			end

			local var_327_4 = 0.001

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_4 then
				var_327_2.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_324_1.time_ - 0) / var_327_4)
			end

			if arg_324_1.time_ >= 0 + var_327_4 and arg_324_1.time_ < 0 + var_327_4 + arg_327_0 then
				var_327_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_327_5 = arg_324_1.actors_["1086"].transform

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.var_.moveOldPos1086 = var_327_5.localPosition
				var_327_5.localScale = Vector3.New(1, 1, 1)

				arg_324_1:CheckSpriteTmpPos("1086", 7)

				for iter_327_5 = 0, var_327_5.childCount - 1 do
					local var_327_6 = var_327_5:GetChild(iter_327_5)

					if var_327_6.name == "" or not string.find(var_327_6.name, "split") then
						var_327_6.gameObject:SetActive(true)
					else
						var_327_6.gameObject:SetActive(false)
					end
				end
			end

			local var_327_7 = 0.001

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_7 then
				var_327_5.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_324_1.time_ - 0) / var_327_7)
			end

			if arg_324_1.time_ >= 0 + var_327_7 and arg_324_1.time_ < 0 + var_327_7 + arg_327_0 then
				var_327_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_327_8 = 0
			local var_327_9 = 1.3

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_8 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_10 = arg_324_1:FormatText(arg_324_1:GetWordFromCfg(416191075).content)

				arg_324_1.text_.text = var_327_10

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_12 = 52 <= 0 and var_327_9 or var_327_9 * (utf8.len(var_327_10) / 52)

				if (52 <= 0 and var_327_9 or var_327_9 * (utf8.len(var_327_10) / 52)) > 0 and var_327_9 < var_327_12 then
					arg_324_1.talkMaxDuration = var_327_12

					if var_327_12 + var_327_8 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_12 + var_327_8
					end
				end

				arg_324_1.text_.text = var_327_10
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_13 = math.max(var_327_9, arg_324_1.talkMaxDuration)

			if var_327_8 <= arg_324_1.time_ and arg_324_1.time_ < var_327_8 + var_327_13 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_8) / var_327_13

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_8 + var_327_13 and arg_324_1.time_ < var_327_8 + var_327_13 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_324_1:InitPlayNodeList()
	end,
	Play416191076 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 416191076
		arg_328_1.duration_ = 5.4

		local var_328_0 = {
			zh = 4.066,
			ja = 5.4
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play416191077(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(arg_328_1.actors_["1028"]) and arg_328_1.var_.actorSpriteComps1028 == nil then
				arg_328_1.var_.actorSpriteComps1028 = arg_328_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_331_0 = 0.2

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_0 and not isNil(arg_328_1.actors_["1028"]) then
				if arg_328_1.var_.actorSpriteComps1028 then
					for iter_331_0, iter_331_1 in pairs(arg_328_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_331_1 then
							if arg_328_1.isInRecall_ then
								iter_331_1.color = Color.New(Mathf.Lerp(iter_331_1.color.r, arg_328_1.hightColor1.r, (arg_328_1.time_ - 0) / var_331_0), Mathf.Lerp(iter_331_1.color.g, arg_328_1.hightColor1.g, (arg_328_1.time_ - 0) / var_331_0), (Mathf.Lerp(iter_331_1.color.b, arg_328_1.hightColor1.b, (arg_328_1.time_ - 0) / var_331_0)))
							else
								local var_331_1 = Mathf.Lerp(iter_331_1.color.r, 1, (arg_328_1.time_ - 0) / var_331_0)

								iter_331_1.color = Color.New(var_331_1, var_331_1, var_331_1)
							end
						end
					end
				end
			end

			if arg_328_1.time_ >= 0 + var_331_0 and arg_328_1.time_ < 0 + var_331_0 + arg_331_0 and not isNil(arg_328_1.actors_["1028"]) and arg_328_1.var_.actorSpriteComps1028 then
				for iter_331_2, iter_331_3 in pairs(arg_328_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_331_3 then
						iter_331_3.color = arg_328_1.isInRecall_ and (arg_328_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_328_1.var_.actorSpriteComps1028 = nil
			end

			local var_331_2 = arg_328_1.actors_["1028"].transform

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.var_.moveOldPos1028 = var_331_2.localPosition
				var_331_2.localScale = Vector3.New(1, 1, 1)

				arg_328_1:CheckSpriteTmpPos("1028", 2)

				for iter_331_4 = 0, var_331_2.childCount - 1 do
					local var_331_3 = var_331_2:GetChild(iter_331_4)

					if var_331_3.name == "split_6" or not string.find(var_331_3.name, "split") then
						var_331_3.gameObject:SetActive(true)
					else
						var_331_3.gameObject:SetActive(false)
					end
				end
			end

			local var_331_4 = 0.001

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_4 then
				var_331_2.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_328_1.time_ - 0) / var_331_4)
			end

			if arg_328_1.time_ >= 0 + var_331_4 and arg_328_1.time_ < 0 + var_331_4 + arg_331_0 then
				var_331_2.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_331_5 = 0
			local var_331_6 = 0.55

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_5 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_7 = arg_328_1:GetWordFromCfg(416191076)
				local var_331_8 = arg_328_1:FormatText(var_331_7.content)

				arg_328_1.text_.text = var_331_8

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_10 = 22 <= 0 and var_331_6 or var_331_6 * (utf8.len(var_331_8) / 22)

				if (22 <= 0 and var_331_6 or var_331_6 * (utf8.len(var_331_8) / 22)) > 0 and var_331_6 < var_331_10 then
					arg_328_1.talkMaxDuration = var_331_10

					if var_331_10 + var_331_5 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_10 + var_331_5
					end
				end

				arg_328_1.text_.text = var_331_8
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191076", "story_v_out_416191.awb") ~= 0 then
					local var_331_11 = manager.audio:GetVoiceLength("story_v_out_416191", "416191076", "story_v_out_416191.awb") / 1000

					if var_331_11 + var_331_5 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_11 + var_331_5
					end

					if var_331_7.prefab_name ~= "" and arg_328_1.actors_[var_331_7.prefab_name] ~= nil then
						local var_331_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_7.prefab_name].transform, "story_v_out_416191", "416191076", "story_v_out_416191.awb")

						arg_328_1:RecordAudio("416191076", var_331_12)
						arg_328_1:RecordAudio("416191076", var_331_12)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_416191", "416191076", "story_v_out_416191.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_416191", "416191076", "story_v_out_416191.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_13 = math.max(var_331_6, arg_328_1.talkMaxDuration)

			if var_331_5 <= arg_328_1.time_ and arg_328_1.time_ < var_331_5 + var_331_13 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_5) / var_331_13

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_5 + var_331_13 and arg_328_1.time_ < var_331_5 + var_331_13 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_328_1:InitPlayNodeList()
	end,
	Play416191077 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 416191077
		arg_332_1.duration_ = 8.67

		local var_332_0 = {
			zh = 8.666,
			ja = 5.4
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play416191078(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(arg_332_1.actors_["1086"]) and arg_332_1.var_.actorSpriteComps1086 == nil then
				arg_332_1.var_.actorSpriteComps1086 = arg_332_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_335_0 = 0.2

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_0 and not isNil(arg_332_1.actors_["1086"]) then
				if arg_332_1.var_.actorSpriteComps1086 then
					for iter_335_0, iter_335_1 in pairs(arg_332_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_335_1 then
							if arg_332_1.isInRecall_ then
								iter_335_1.color = Color.New(Mathf.Lerp(iter_335_1.color.r, arg_332_1.hightColor1.r, (arg_332_1.time_ - 0) / var_335_0), Mathf.Lerp(iter_335_1.color.g, arg_332_1.hightColor1.g, (arg_332_1.time_ - 0) / var_335_0), (Mathf.Lerp(iter_335_1.color.b, arg_332_1.hightColor1.b, (arg_332_1.time_ - 0) / var_335_0)))
							else
								local var_335_1 = Mathf.Lerp(iter_335_1.color.r, 1, (arg_332_1.time_ - 0) / var_335_0)

								iter_335_1.color = Color.New(var_335_1, var_335_1, var_335_1)
							end
						end
					end
				end
			end

			if arg_332_1.time_ >= 0 + var_335_0 and arg_332_1.time_ < 0 + var_335_0 + arg_335_0 and not isNil(arg_332_1.actors_["1086"]) and arg_332_1.var_.actorSpriteComps1086 then
				for iter_335_2, iter_335_3 in pairs(arg_332_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_335_3 then
						iter_335_3.color = arg_332_1.isInRecall_ and (arg_332_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_332_1.var_.actorSpriteComps1086 = nil
			end

			local var_335_2 = arg_332_1.actors_["1028"]

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(var_335_2) and arg_332_1.var_.actorSpriteComps1028 == nil then
				arg_332_1.var_.actorSpriteComps1028 = var_335_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_335_3 = 0.2

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_3 and not isNil(var_335_2) then
				if arg_332_1.var_.actorSpriteComps1028 then
					for iter_335_4, iter_335_5 in pairs(arg_332_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_335_5 then
							if arg_332_1.isInRecall_ then
								iter_335_5.color = Color.New(Mathf.Lerp(iter_335_5.color.r, arg_332_1.hightColor2.r, (arg_332_1.time_ - 0) / var_335_3), Mathf.Lerp(iter_335_5.color.g, arg_332_1.hightColor2.g, (arg_332_1.time_ - 0) / var_335_3), (Mathf.Lerp(iter_335_5.color.b, arg_332_1.hightColor2.b, (arg_332_1.time_ - 0) / var_335_3)))
							else
								local var_335_4 = Mathf.Lerp(iter_335_5.color.r, 0.5, (arg_332_1.time_ - 0) / var_335_3)

								iter_335_5.color = Color.New(var_335_4, var_335_4, var_335_4)
							end
						end
					end
				end
			end

			if arg_332_1.time_ >= 0 + var_335_3 and arg_332_1.time_ < 0 + var_335_3 + arg_335_0 and not isNil(var_335_2) and arg_332_1.var_.actorSpriteComps1028 then
				for iter_335_6, iter_335_7 in pairs(arg_332_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_335_7 then
						iter_335_7.color = arg_332_1.isInRecall_ and (arg_332_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_332_1.var_.actorSpriteComps1028 = nil
			end

			local var_335_5 = arg_332_1.actors_["1086"].transform

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.var_.moveOldPos1086 = var_335_5.localPosition
				var_335_5.localScale = Vector3.New(1, 1, 1)

				arg_332_1:CheckSpriteTmpPos("1086", 4)

				for iter_335_8 = 0, var_335_5.childCount - 1 do
					local var_335_6 = var_335_5:GetChild(iter_335_8)

					if var_335_6.name == "split_1" or not string.find(var_335_6.name, "split") then
						var_335_6.gameObject:SetActive(true)
					else
						var_335_6.gameObject:SetActive(false)
					end
				end
			end

			local var_335_7 = 0.001

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_7 then
				var_335_5.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_332_1.time_ - 0) / var_335_7)
			end

			if arg_332_1.time_ >= 0 + var_335_7 and arg_332_1.time_ < 0 + var_335_7 + arg_335_0 then
				var_335_5.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_335_8 = 0
			local var_335_9 = 0.65

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_8 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_10 = arg_332_1:GetWordFromCfg(416191077)
				local var_335_11 = arg_332_1:FormatText(var_335_10.content)

				arg_332_1.text_.text = var_335_11

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_13 = 26 <= 0 and var_335_9 or var_335_9 * (utf8.len(var_335_11) / 26)

				if (26 <= 0 and var_335_9 or var_335_9 * (utf8.len(var_335_11) / 26)) > 0 and var_335_9 < var_335_13 then
					arg_332_1.talkMaxDuration = var_335_13

					if var_335_13 + var_335_8 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_13 + var_335_8
					end
				end

				arg_332_1.text_.text = var_335_11
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191077", "story_v_out_416191.awb") ~= 0 then
					local var_335_14 = manager.audio:GetVoiceLength("story_v_out_416191", "416191077", "story_v_out_416191.awb") / 1000

					if var_335_14 + var_335_8 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_14 + var_335_8
					end

					if var_335_10.prefab_name ~= "" and arg_332_1.actors_[var_335_10.prefab_name] ~= nil then
						local var_335_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_10.prefab_name].transform, "story_v_out_416191", "416191077", "story_v_out_416191.awb")

						arg_332_1:RecordAudio("416191077", var_335_15)
						arg_332_1:RecordAudio("416191077", var_335_15)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_416191", "416191077", "story_v_out_416191.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_416191", "416191077", "story_v_out_416191.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_16 = math.max(var_335_9, arg_332_1.talkMaxDuration)

			if var_335_8 <= arg_332_1.time_ and arg_332_1.time_ < var_335_8 + var_335_16 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_8) / var_335_16

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_8 + var_335_16 and arg_332_1.time_ < var_335_8 + var_335_16 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play416191078 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 416191078
		arg_336_1.duration_ = 8.6

		local var_336_0 = {
			zh = 4.266,
			ja = 8.6
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play416191079(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0.4

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_1 = arg_336_1:GetWordFromCfg(416191078)
				local var_339_2 = arg_336_1:FormatText(var_339_1.content)

				arg_336_1.text_.text = var_339_2

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_4 = 16 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_2) / 16)

				if (16 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_2) / 16)) > 0 and var_339_0 < var_339_4 then
					arg_336_1.talkMaxDuration = var_339_4

					if var_339_4 + 0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_4 + 0
					end
				end

				arg_336_1.text_.text = var_339_2
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191078", "story_v_out_416191.awb") ~= 0 then
					local var_339_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191078", "story_v_out_416191.awb") / 1000

					if var_339_5 + 0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_5 + 0
					end

					if var_339_1.prefab_name ~= "" and arg_336_1.actors_[var_339_1.prefab_name] ~= nil then
						local var_339_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_1.prefab_name].transform, "story_v_out_416191", "416191078", "story_v_out_416191.awb")

						arg_336_1:RecordAudio("416191078", var_339_6)
						arg_336_1:RecordAudio("416191078", var_339_6)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_416191", "416191078", "story_v_out_416191.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_416191", "416191078", "story_v_out_416191.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_7 = math.max(var_339_0, arg_336_1.talkMaxDuration)

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_7 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - 0) / var_339_7

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= 0 + var_339_7 and arg_336_1.time_ < 0 + var_339_7 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play416191079 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 416191079
		arg_340_1.duration_ = 5.2

		local var_340_0 = {
			zh = 4.833,
			ja = 5.2
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play416191080(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(arg_340_1.actors_["1028"]) and arg_340_1.var_.actorSpriteComps1028 == nil then
				arg_340_1.var_.actorSpriteComps1028 = arg_340_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_343_0 = 0.2

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_0 and not isNil(arg_340_1.actors_["1028"]) then
				if arg_340_1.var_.actorSpriteComps1028 then
					for iter_343_0, iter_343_1 in pairs(arg_340_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_343_1 then
							if arg_340_1.isInRecall_ then
								iter_343_1.color = Color.New(Mathf.Lerp(iter_343_1.color.r, arg_340_1.hightColor1.r, (arg_340_1.time_ - 0) / var_343_0), Mathf.Lerp(iter_343_1.color.g, arg_340_1.hightColor1.g, (arg_340_1.time_ - 0) / var_343_0), (Mathf.Lerp(iter_343_1.color.b, arg_340_1.hightColor1.b, (arg_340_1.time_ - 0) / var_343_0)))
							else
								local var_343_1 = Mathf.Lerp(iter_343_1.color.r, 1, (arg_340_1.time_ - 0) / var_343_0)

								iter_343_1.color = Color.New(var_343_1, var_343_1, var_343_1)
							end
						end
					end
				end
			end

			if arg_340_1.time_ >= 0 + var_343_0 and arg_340_1.time_ < 0 + var_343_0 + arg_343_0 and not isNil(arg_340_1.actors_["1028"]) and arg_340_1.var_.actorSpriteComps1028 then
				for iter_343_2, iter_343_3 in pairs(arg_340_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_343_3 then
						iter_343_3.color = arg_340_1.isInRecall_ and (arg_340_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_340_1.var_.actorSpriteComps1028 = nil
			end

			local var_343_2 = arg_340_1.actors_["1086"]

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(var_343_2) and arg_340_1.var_.actorSpriteComps1086 == nil then
				arg_340_1.var_.actorSpriteComps1086 = var_343_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_343_3 = 0.2

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_3 and not isNil(var_343_2) then
				if arg_340_1.var_.actorSpriteComps1086 then
					for iter_343_4, iter_343_5 in pairs(arg_340_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_343_5 then
							if arg_340_1.isInRecall_ then
								iter_343_5.color = Color.New(Mathf.Lerp(iter_343_5.color.r, arg_340_1.hightColor2.r, (arg_340_1.time_ - 0) / var_343_3), Mathf.Lerp(iter_343_5.color.g, arg_340_1.hightColor2.g, (arg_340_1.time_ - 0) / var_343_3), (Mathf.Lerp(iter_343_5.color.b, arg_340_1.hightColor2.b, (arg_340_1.time_ - 0) / var_343_3)))
							else
								local var_343_4 = Mathf.Lerp(iter_343_5.color.r, 0.5, (arg_340_1.time_ - 0) / var_343_3)

								iter_343_5.color = Color.New(var_343_4, var_343_4, var_343_4)
							end
						end
					end
				end
			end

			if arg_340_1.time_ >= 0 + var_343_3 and arg_340_1.time_ < 0 + var_343_3 + arg_343_0 and not isNil(var_343_2) and arg_340_1.var_.actorSpriteComps1086 then
				for iter_343_6, iter_343_7 in pairs(arg_340_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_343_7 then
						iter_343_7.color = arg_340_1.isInRecall_ and (arg_340_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_340_1.var_.actorSpriteComps1086 = nil
			end

			local var_343_5 = arg_340_1.actors_["1028"].transform

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.var_.moveOldPos1028 = var_343_5.localPosition
				var_343_5.localScale = Vector3.New(1, 1, 1)

				arg_340_1:CheckSpriteTmpPos("1028", 2)

				for iter_343_8 = 0, var_343_5.childCount - 1 do
					local var_343_6 = var_343_5:GetChild(iter_343_8)

					if var_343_6.name == "split_7" or not string.find(var_343_6.name, "split") then
						var_343_6.gameObject:SetActive(true)
					else
						var_343_6.gameObject:SetActive(false)
					end
				end
			end

			local var_343_7 = 0.001

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_7 then
				var_343_5.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_340_1.time_ - 0) / var_343_7)
			end

			if arg_340_1.time_ >= 0 + var_343_7 and arg_340_1.time_ < 0 + var_343_7 + arg_343_0 then
				var_343_5.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_343_8 = 0
			local var_343_9 = 0.55

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_8 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_10 = arg_340_1:GetWordFromCfg(416191079)
				local var_343_11 = arg_340_1:FormatText(var_343_10.content)

				arg_340_1.text_.text = var_343_11

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_13 = 22 <= 0 and var_343_9 or var_343_9 * (utf8.len(var_343_11) / 22)

				if (22 <= 0 and var_343_9 or var_343_9 * (utf8.len(var_343_11) / 22)) > 0 and var_343_9 < var_343_13 then
					arg_340_1.talkMaxDuration = var_343_13

					if var_343_13 + var_343_8 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_13 + var_343_8
					end
				end

				arg_340_1.text_.text = var_343_11
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191079", "story_v_out_416191.awb") ~= 0 then
					local var_343_14 = manager.audio:GetVoiceLength("story_v_out_416191", "416191079", "story_v_out_416191.awb") / 1000

					if var_343_14 + var_343_8 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_14 + var_343_8
					end

					if var_343_10.prefab_name ~= "" and arg_340_1.actors_[var_343_10.prefab_name] ~= nil then
						local var_343_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_10.prefab_name].transform, "story_v_out_416191", "416191079", "story_v_out_416191.awb")

						arg_340_1:RecordAudio("416191079", var_343_15)
						arg_340_1:RecordAudio("416191079", var_343_15)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_416191", "416191079", "story_v_out_416191.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_416191", "416191079", "story_v_out_416191.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_16 = math.max(var_343_9, arg_340_1.talkMaxDuration)

			if var_343_8 <= arg_340_1.time_ and arg_340_1.time_ < var_343_8 + var_343_16 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_8) / var_343_16

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_8 + var_343_16 and arg_340_1.time_ < var_343_8 + var_343_16 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play416191080 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 416191080
		arg_344_1.duration_ = 10.67

		local var_344_0 = {
			zh = 4.833,
			ja = 10.666
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play416191081(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(arg_344_1.actors_["1086"]) and arg_344_1.var_.actorSpriteComps1086 == nil then
				arg_344_1.var_.actorSpriteComps1086 = arg_344_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_347_0 = 0.2

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_0 and not isNil(arg_344_1.actors_["1086"]) then
				if arg_344_1.var_.actorSpriteComps1086 then
					for iter_347_0, iter_347_1 in pairs(arg_344_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_347_1 then
							if arg_344_1.isInRecall_ then
								iter_347_1.color = Color.New(Mathf.Lerp(iter_347_1.color.r, arg_344_1.hightColor1.r, (arg_344_1.time_ - 0) / var_347_0), Mathf.Lerp(iter_347_1.color.g, arg_344_1.hightColor1.g, (arg_344_1.time_ - 0) / var_347_0), (Mathf.Lerp(iter_347_1.color.b, arg_344_1.hightColor1.b, (arg_344_1.time_ - 0) / var_347_0)))
							else
								local var_347_1 = Mathf.Lerp(iter_347_1.color.r, 1, (arg_344_1.time_ - 0) / var_347_0)

								iter_347_1.color = Color.New(var_347_1, var_347_1, var_347_1)
							end
						end
					end
				end
			end

			if arg_344_1.time_ >= 0 + var_347_0 and arg_344_1.time_ < 0 + var_347_0 + arg_347_0 and not isNil(arg_344_1.actors_["1086"]) and arg_344_1.var_.actorSpriteComps1086 then
				for iter_347_2, iter_347_3 in pairs(arg_344_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_347_3 then
						iter_347_3.color = arg_344_1.isInRecall_ and (arg_344_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_344_1.var_.actorSpriteComps1086 = nil
			end

			local var_347_2 = arg_344_1.actors_["1028"]

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(var_347_2) and arg_344_1.var_.actorSpriteComps1028 == nil then
				arg_344_1.var_.actorSpriteComps1028 = var_347_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_347_3 = 0.2

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_3 and not isNil(var_347_2) then
				if arg_344_1.var_.actorSpriteComps1028 then
					for iter_347_4, iter_347_5 in pairs(arg_344_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_347_5 then
							if arg_344_1.isInRecall_ then
								iter_347_5.color = Color.New(Mathf.Lerp(iter_347_5.color.r, arg_344_1.hightColor2.r, (arg_344_1.time_ - 0) / var_347_3), Mathf.Lerp(iter_347_5.color.g, arg_344_1.hightColor2.g, (arg_344_1.time_ - 0) / var_347_3), (Mathf.Lerp(iter_347_5.color.b, arg_344_1.hightColor2.b, (arg_344_1.time_ - 0) / var_347_3)))
							else
								local var_347_4 = Mathf.Lerp(iter_347_5.color.r, 0.5, (arg_344_1.time_ - 0) / var_347_3)

								iter_347_5.color = Color.New(var_347_4, var_347_4, var_347_4)
							end
						end
					end
				end
			end

			if arg_344_1.time_ >= 0 + var_347_3 and arg_344_1.time_ < 0 + var_347_3 + arg_347_0 and not isNil(var_347_2) and arg_344_1.var_.actorSpriteComps1028 then
				for iter_347_6, iter_347_7 in pairs(arg_344_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_347_7 then
						iter_347_7.color = arg_344_1.isInRecall_ and (arg_344_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_344_1.var_.actorSpriteComps1028 = nil
			end

			local var_347_5 = 0
			local var_347_6 = 0.5

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_5 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_7 = arg_344_1:GetWordFromCfg(416191080)
				local var_347_8 = arg_344_1:FormatText(var_347_7.content)

				arg_344_1.text_.text = var_347_8

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_10 = 20 <= 0 and var_347_6 or var_347_6 * (utf8.len(var_347_8) / 20)

				if (20 <= 0 and var_347_6 or var_347_6 * (utf8.len(var_347_8) / 20)) > 0 and var_347_6 < var_347_10 then
					arg_344_1.talkMaxDuration = var_347_10

					if var_347_10 + var_347_5 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_10 + var_347_5
					end
				end

				arg_344_1.text_.text = var_347_8
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191080", "story_v_out_416191.awb") ~= 0 then
					local var_347_11 = manager.audio:GetVoiceLength("story_v_out_416191", "416191080", "story_v_out_416191.awb") / 1000

					if var_347_11 + var_347_5 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_11 + var_347_5
					end

					if var_347_7.prefab_name ~= "" and arg_344_1.actors_[var_347_7.prefab_name] ~= nil then
						local var_347_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_7.prefab_name].transform, "story_v_out_416191", "416191080", "story_v_out_416191.awb")

						arg_344_1:RecordAudio("416191080", var_347_12)
						arg_344_1:RecordAudio("416191080", var_347_12)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_416191", "416191080", "story_v_out_416191.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_416191", "416191080", "story_v_out_416191.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_13 = math.max(var_347_6, arg_344_1.talkMaxDuration)

			if var_347_5 <= arg_344_1.time_ and arg_344_1.time_ < var_347_5 + var_347_13 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_5) / var_347_13

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_5 + var_347_13 and arg_344_1.time_ < var_347_5 + var_347_13 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play416191081 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 416191081
		arg_348_1.duration_ = 8.7

		local var_348_0 = {
			zh = 6,
			ja = 8.7
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play416191082(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(arg_348_1.actors_["1028"]) and arg_348_1.var_.actorSpriteComps1028 == nil then
				arg_348_1.var_.actorSpriteComps1028 = arg_348_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_351_0 = 0.2

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_0 and not isNil(arg_348_1.actors_["1028"]) then
				if arg_348_1.var_.actorSpriteComps1028 then
					for iter_351_0, iter_351_1 in pairs(arg_348_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_351_1 then
							if arg_348_1.isInRecall_ then
								iter_351_1.color = Color.New(Mathf.Lerp(iter_351_1.color.r, arg_348_1.hightColor1.r, (arg_348_1.time_ - 0) / var_351_0), Mathf.Lerp(iter_351_1.color.g, arg_348_1.hightColor1.g, (arg_348_1.time_ - 0) / var_351_0), (Mathf.Lerp(iter_351_1.color.b, arg_348_1.hightColor1.b, (arg_348_1.time_ - 0) / var_351_0)))
							else
								local var_351_1 = Mathf.Lerp(iter_351_1.color.r, 1, (arg_348_1.time_ - 0) / var_351_0)

								iter_351_1.color = Color.New(var_351_1, var_351_1, var_351_1)
							end
						end
					end
				end
			end

			if arg_348_1.time_ >= 0 + var_351_0 and arg_348_1.time_ < 0 + var_351_0 + arg_351_0 and not isNil(arg_348_1.actors_["1028"]) and arg_348_1.var_.actorSpriteComps1028 then
				for iter_351_2, iter_351_3 in pairs(arg_348_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_351_3 then
						iter_351_3.color = arg_348_1.isInRecall_ and (arg_348_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_348_1.var_.actorSpriteComps1028 = nil
			end

			local var_351_2 = arg_348_1.actors_["1086"]

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(var_351_2) and arg_348_1.var_.actorSpriteComps1086 == nil then
				arg_348_1.var_.actorSpriteComps1086 = var_351_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_351_3 = 0.2

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_3 and not isNil(var_351_2) then
				if arg_348_1.var_.actorSpriteComps1086 then
					for iter_351_4, iter_351_5 in pairs(arg_348_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_351_5 then
							if arg_348_1.isInRecall_ then
								iter_351_5.color = Color.New(Mathf.Lerp(iter_351_5.color.r, arg_348_1.hightColor2.r, (arg_348_1.time_ - 0) / var_351_3), Mathf.Lerp(iter_351_5.color.g, arg_348_1.hightColor2.g, (arg_348_1.time_ - 0) / var_351_3), (Mathf.Lerp(iter_351_5.color.b, arg_348_1.hightColor2.b, (arg_348_1.time_ - 0) / var_351_3)))
							else
								local var_351_4 = Mathf.Lerp(iter_351_5.color.r, 0.5, (arg_348_1.time_ - 0) / var_351_3)

								iter_351_5.color = Color.New(var_351_4, var_351_4, var_351_4)
							end
						end
					end
				end
			end

			if arg_348_1.time_ >= 0 + var_351_3 and arg_348_1.time_ < 0 + var_351_3 + arg_351_0 and not isNil(var_351_2) and arg_348_1.var_.actorSpriteComps1086 then
				for iter_351_6, iter_351_7 in pairs(arg_348_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_351_7 then
						iter_351_7.color = arg_348_1.isInRecall_ and (arg_348_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_348_1.var_.actorSpriteComps1086 = nil
			end

			local var_351_5 = arg_348_1.actors_["1028"].transform

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.var_.moveOldPos1028 = var_351_5.localPosition
				var_351_5.localScale = Vector3.New(1, 1, 1)

				arg_348_1:CheckSpriteTmpPos("1028", 2)

				for iter_351_8 = 0, var_351_5.childCount - 1 do
					local var_351_6 = var_351_5:GetChild(iter_351_8)

					if var_351_6.name == "" or not string.find(var_351_6.name, "split") then
						var_351_6.gameObject:SetActive(true)
					else
						var_351_6.gameObject:SetActive(false)
					end
				end
			end

			local var_351_7 = 0.001

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_7 then
				var_351_5.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_348_1.time_ - 0) / var_351_7)
			end

			if arg_348_1.time_ >= 0 + var_351_7 and arg_348_1.time_ < 0 + var_351_7 + arg_351_0 then
				var_351_5.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_351_8 = 0
			local var_351_9 = 0.45

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_8 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_10 = arg_348_1:GetWordFromCfg(416191081)
				local var_351_11 = arg_348_1:FormatText(var_351_10.content)

				arg_348_1.text_.text = var_351_11

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_13 = 18 <= 0 and var_351_9 or var_351_9 * (utf8.len(var_351_11) / 18)

				if (18 <= 0 and var_351_9 or var_351_9 * (utf8.len(var_351_11) / 18)) > 0 and var_351_9 < var_351_13 then
					arg_348_1.talkMaxDuration = var_351_13

					if var_351_13 + var_351_8 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_13 + var_351_8
					end
				end

				arg_348_1.text_.text = var_351_11
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191081", "story_v_out_416191.awb") ~= 0 then
					local var_351_14 = manager.audio:GetVoiceLength("story_v_out_416191", "416191081", "story_v_out_416191.awb") / 1000

					if var_351_14 + var_351_8 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_14 + var_351_8
					end

					if var_351_10.prefab_name ~= "" and arg_348_1.actors_[var_351_10.prefab_name] ~= nil then
						local var_351_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_10.prefab_name].transform, "story_v_out_416191", "416191081", "story_v_out_416191.awb")

						arg_348_1:RecordAudio("416191081", var_351_15)
						arg_348_1:RecordAudio("416191081", var_351_15)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_416191", "416191081", "story_v_out_416191.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_416191", "416191081", "story_v_out_416191.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_16 = math.max(var_351_9, arg_348_1.talkMaxDuration)

			if var_351_8 <= arg_348_1.time_ and arg_348_1.time_ < var_351_8 + var_351_16 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_8) / var_351_16

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_8 + var_351_16 and arg_348_1.time_ < var_351_8 + var_351_16 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	Play416191082 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 416191082
		arg_352_1.duration_ = 11.07

		local var_352_0 = {
			zh = 11.066,
			ja = 10.566
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play416191083(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 and not isNil(arg_352_1.actors_["1086"]) and arg_352_1.var_.actorSpriteComps1086 == nil then
				arg_352_1.var_.actorSpriteComps1086 = arg_352_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_355_0 = 0.2

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_0 and not isNil(arg_352_1.actors_["1086"]) then
				if arg_352_1.var_.actorSpriteComps1086 then
					for iter_355_0, iter_355_1 in pairs(arg_352_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_355_1 then
							if arg_352_1.isInRecall_ then
								iter_355_1.color = Color.New(Mathf.Lerp(iter_355_1.color.r, arg_352_1.hightColor1.r, (arg_352_1.time_ - 0) / var_355_0), Mathf.Lerp(iter_355_1.color.g, arg_352_1.hightColor1.g, (arg_352_1.time_ - 0) / var_355_0), (Mathf.Lerp(iter_355_1.color.b, arg_352_1.hightColor1.b, (arg_352_1.time_ - 0) / var_355_0)))
							else
								local var_355_1 = Mathf.Lerp(iter_355_1.color.r, 1, (arg_352_1.time_ - 0) / var_355_0)

								iter_355_1.color = Color.New(var_355_1, var_355_1, var_355_1)
							end
						end
					end
				end
			end

			if arg_352_1.time_ >= 0 + var_355_0 and arg_352_1.time_ < 0 + var_355_0 + arg_355_0 and not isNil(arg_352_1.actors_["1086"]) and arg_352_1.var_.actorSpriteComps1086 then
				for iter_355_2, iter_355_3 in pairs(arg_352_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_355_3 then
						iter_355_3.color = arg_352_1.isInRecall_ and (arg_352_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_352_1.var_.actorSpriteComps1086 = nil
			end

			local var_355_2 = arg_352_1.actors_["1028"].transform

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.var_.moveOldPos1028 = var_355_2.localPosition
				var_355_2.localScale = Vector3.New(1, 1, 1)

				arg_352_1:CheckSpriteTmpPos("1028", 7)

				for iter_355_4 = 0, var_355_2.childCount - 1 do
					local var_355_3 = var_355_2:GetChild(iter_355_4)

					if var_355_3.name == "split_2" or not string.find(var_355_3.name, "split") then
						var_355_3.gameObject:SetActive(true)
					else
						var_355_3.gameObject:SetActive(false)
					end
				end
			end

			local var_355_4 = 0.001

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_4 then
				var_355_2.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_352_1.time_ - 0) / var_355_4)
			end

			if arg_352_1.time_ >= 0 + var_355_4 and arg_352_1.time_ < 0 + var_355_4 + arg_355_0 then
				var_355_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_355_5 = arg_352_1.actors_["1086"].transform

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.var_.moveOldPos1086 = var_355_5.localPosition
				var_355_5.localScale = Vector3.New(1, 1, 1)

				arg_352_1:CheckSpriteTmpPos("1086", 3)

				for iter_355_5 = 0, var_355_5.childCount - 1 do
					local var_355_6 = var_355_5:GetChild(iter_355_5)

					if var_355_6.name == "split_1" or not string.find(var_355_6.name, "split") then
						var_355_6.gameObject:SetActive(true)
					else
						var_355_6.gameObject:SetActive(false)
					end
				end
			end

			local var_355_7 = 0.001

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_7 then
				var_355_5.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_352_1.time_ - 0) / var_355_7)
			end

			if arg_352_1.time_ >= 0 + var_355_7 and arg_352_1.time_ < 0 + var_355_7 + arg_355_0 then
				var_355_5.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_355_8 = 0
			local var_355_9 = 0.775

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_8 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_10 = arg_352_1:GetWordFromCfg(416191082)
				local var_355_11 = arg_352_1:FormatText(var_355_10.content)

				arg_352_1.text_.text = var_355_11

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_13 = 31 <= 0 and var_355_9 or var_355_9 * (utf8.len(var_355_11) / 31)

				if (31 <= 0 and var_355_9 or var_355_9 * (utf8.len(var_355_11) / 31)) > 0 and var_355_9 < var_355_13 then
					arg_352_1.talkMaxDuration = var_355_13

					if var_355_13 + var_355_8 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_13 + var_355_8
					end
				end

				arg_352_1.text_.text = var_355_11
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191082", "story_v_out_416191.awb") ~= 0 then
					local var_355_14 = manager.audio:GetVoiceLength("story_v_out_416191", "416191082", "story_v_out_416191.awb") / 1000

					if var_355_14 + var_355_8 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_14 + var_355_8
					end

					if var_355_10.prefab_name ~= "" and arg_352_1.actors_[var_355_10.prefab_name] ~= nil then
						local var_355_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_10.prefab_name].transform, "story_v_out_416191", "416191082", "story_v_out_416191.awb")

						arg_352_1:RecordAudio("416191082", var_355_15)
						arg_352_1:RecordAudio("416191082", var_355_15)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_416191", "416191082", "story_v_out_416191.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_416191", "416191082", "story_v_out_416191.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_16 = math.max(var_355_9, arg_352_1.talkMaxDuration)

			if var_355_8 <= arg_352_1.time_ and arg_352_1.time_ < var_355_8 + var_355_16 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_8) / var_355_16

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_8 + var_355_16 and arg_352_1.time_ < var_355_8 + var_355_16 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_352_1:InitPlayNodeList()
	end,
	Play416191083 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 416191083
		arg_356_1.duration_ = 15.03

		local var_356_0 = {
			zh = 11.6,
			ja = 15.033
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play416191084(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.var_.moveOldPos1086 = arg_356_1.actors_["1086"].transform.localPosition
				arg_356_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_356_1:CheckSpriteTmpPos("1086", 3)

				for iter_359_0 = 0, arg_356_1.actors_["1086"].transform.childCount - 1 do
					local var_359_0 = arg_356_1.actors_["1086"].transform:GetChild(iter_359_0)

					if var_359_0.name == "split_6" or not string.find(var_359_0.name, "split") then
						var_359_0.gameObject:SetActive(true)
					else
						var_359_0.gameObject:SetActive(false)
					end
				end
			end

			local var_359_1 = 0.001

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_1 then
				arg_356_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_356_1.time_ - 0) / var_359_1)
			end

			if arg_356_1.time_ >= 0 + var_359_1 and arg_356_1.time_ < 0 + var_359_1 + arg_359_0 then
				arg_356_1.actors_["1086"].transform.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_359_2 = 0
			local var_359_3 = 0.9

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_2 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_4 = arg_356_1:GetWordFromCfg(416191083)
				local var_359_5 = arg_356_1:FormatText(var_359_4.content)

				arg_356_1.text_.text = var_359_5

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_7 = 37 <= 0 and var_359_3 or var_359_3 * (utf8.len(var_359_5) / 37)

				if (37 <= 0 and var_359_3 or var_359_3 * (utf8.len(var_359_5) / 37)) > 0 and var_359_3 < var_359_7 then
					arg_356_1.talkMaxDuration = var_359_7

					if var_359_7 + var_359_2 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_7 + var_359_2
					end
				end

				arg_356_1.text_.text = var_359_5
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191083", "story_v_out_416191.awb") ~= 0 then
					local var_359_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191083", "story_v_out_416191.awb") / 1000

					if var_359_8 + var_359_2 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_8 + var_359_2
					end

					if var_359_4.prefab_name ~= "" and arg_356_1.actors_[var_359_4.prefab_name] ~= nil then
						local var_359_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_4.prefab_name].transform, "story_v_out_416191", "416191083", "story_v_out_416191.awb")

						arg_356_1:RecordAudio("416191083", var_359_9)
						arg_356_1:RecordAudio("416191083", var_359_9)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_416191", "416191083", "story_v_out_416191.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_416191", "416191083", "story_v_out_416191.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_10 = math.max(var_359_3, arg_356_1.talkMaxDuration)

			if var_359_2 <= arg_356_1.time_ and arg_356_1.time_ < var_359_2 + var_359_10 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_2) / var_359_10

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_2 + var_359_10 and arg_356_1.time_ < var_359_2 + var_359_10 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_356_1:InitPlayNodeList()
	end,
	Play416191084 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 416191084
		arg_360_1.duration_ = 6.9

		local var_360_0 = {
			zh = 6.9,
			ja = 5.833
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play416191085(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0.475

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				arg_360_1.leftNameTxt_.text = arg_360_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_1 = arg_360_1:GetWordFromCfg(416191084)
				local var_363_2 = arg_360_1:FormatText(var_363_1.content)

				arg_360_1.text_.text = var_363_2

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_4 = 19 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_2) / 19)

				if (19 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_2) / 19)) > 0 and var_363_0 < var_363_4 then
					arg_360_1.talkMaxDuration = var_363_4

					if var_363_4 + 0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_4 + 0
					end
				end

				arg_360_1.text_.text = var_363_2
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191084", "story_v_out_416191.awb") ~= 0 then
					local var_363_5 = manager.audio:GetVoiceLength("story_v_out_416191", "416191084", "story_v_out_416191.awb") / 1000

					if var_363_5 + 0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_5 + 0
					end

					if var_363_1.prefab_name ~= "" and arg_360_1.actors_[var_363_1.prefab_name] ~= nil then
						local var_363_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_1.prefab_name].transform, "story_v_out_416191", "416191084", "story_v_out_416191.awb")

						arg_360_1:RecordAudio("416191084", var_363_6)
						arg_360_1:RecordAudio("416191084", var_363_6)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_416191", "416191084", "story_v_out_416191.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_416191", "416191084", "story_v_out_416191.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_7 = math.max(var_363_0, arg_360_1.talkMaxDuration)

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_7 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - 0) / var_363_7

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= 0 + var_363_7 and arg_360_1.time_ < 0 + var_363_7 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play416191085 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 416191085
		arg_364_1.duration_ = 11.83

		local var_364_0 = {
			zh = 9.233,
			ja = 11.833
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play416191086(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.var_.moveOldPos1086 = arg_364_1.actors_["1086"].transform.localPosition
				arg_364_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_364_1:CheckSpriteTmpPos("1086", 3)

				for iter_367_0 = 0, arg_364_1.actors_["1086"].transform.childCount - 1 do
					local var_367_0 = arg_364_1.actors_["1086"].transform:GetChild(iter_367_0)

					if var_367_0.name == "split_5" or not string.find(var_367_0.name, "split") then
						var_367_0.gameObject:SetActive(true)
					else
						var_367_0.gameObject:SetActive(false)
					end
				end
			end

			local var_367_1 = 0.001

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_1 then
				arg_364_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_364_1.time_ - 0) / var_367_1)
			end

			if arg_364_1.time_ >= 0 + var_367_1 and arg_364_1.time_ < 0 + var_367_1 + arg_367_0 then
				arg_364_1.actors_["1086"].transform.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_367_2 = 0
			local var_367_3 = 0.8

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_2 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_4 = arg_364_1:GetWordFromCfg(416191085)
				local var_367_5 = arg_364_1:FormatText(var_367_4.content)

				arg_364_1.text_.text = var_367_5

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_7 = 32 <= 0 and var_367_3 or var_367_3 * (utf8.len(var_367_5) / 32)

				if (32 <= 0 and var_367_3 or var_367_3 * (utf8.len(var_367_5) / 32)) > 0 and var_367_3 < var_367_7 then
					arg_364_1.talkMaxDuration = var_367_7

					if var_367_7 + var_367_2 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_7 + var_367_2
					end
				end

				arg_364_1.text_.text = var_367_5
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191085", "story_v_out_416191.awb") ~= 0 then
					local var_367_8 = manager.audio:GetVoiceLength("story_v_out_416191", "416191085", "story_v_out_416191.awb") / 1000

					if var_367_8 + var_367_2 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_8 + var_367_2
					end

					if var_367_4.prefab_name ~= "" and arg_364_1.actors_[var_367_4.prefab_name] ~= nil then
						local var_367_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_4.prefab_name].transform, "story_v_out_416191", "416191085", "story_v_out_416191.awb")

						arg_364_1:RecordAudio("416191085", var_367_9)
						arg_364_1:RecordAudio("416191085", var_367_9)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_416191", "416191085", "story_v_out_416191.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_416191", "416191085", "story_v_out_416191.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_10 = math.max(var_367_3, arg_364_1.talkMaxDuration)

			if var_367_2 <= arg_364_1.time_ and arg_364_1.time_ < var_367_2 + var_367_10 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_2) / var_367_10

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_2 + var_367_10 and arg_364_1.time_ < var_367_2 + var_367_10 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_364_1:InitPlayNodeList()
	end,
	Play416191086 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 416191086
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play416191087(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 and not isNil(arg_368_1.actors_["1086"]) and arg_368_1.var_.actorSpriteComps1086 == nil then
				arg_368_1.var_.actorSpriteComps1086 = arg_368_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_371_0 = 0.2

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_0 and not isNil(arg_368_1.actors_["1086"]) then
				if arg_368_1.var_.actorSpriteComps1086 then
					for iter_371_0, iter_371_1 in pairs(arg_368_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_371_1 then
							if arg_368_1.isInRecall_ then
								iter_371_1.color = Color.New(Mathf.Lerp(iter_371_1.color.r, arg_368_1.hightColor2.r, (arg_368_1.time_ - 0) / var_371_0), Mathf.Lerp(iter_371_1.color.g, arg_368_1.hightColor2.g, (arg_368_1.time_ - 0) / var_371_0), (Mathf.Lerp(iter_371_1.color.b, arg_368_1.hightColor2.b, (arg_368_1.time_ - 0) / var_371_0)))
							else
								local var_371_1 = Mathf.Lerp(iter_371_1.color.r, 0.5, (arg_368_1.time_ - 0) / var_371_0)

								iter_371_1.color = Color.New(var_371_1, var_371_1, var_371_1)
							end
						end
					end
				end
			end

			if arg_368_1.time_ >= 0 + var_371_0 and arg_368_1.time_ < 0 + var_371_0 + arg_371_0 and not isNil(arg_368_1.actors_["1086"]) and arg_368_1.var_.actorSpriteComps1086 then
				for iter_371_2, iter_371_3 in pairs(arg_368_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_371_3 then
						iter_371_3.color = arg_368_1.isInRecall_ and (arg_368_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_368_1.var_.actorSpriteComps1086 = nil
			end

			local var_371_2 = 0
			local var_371_3 = 1.05

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_2 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, false)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_4 = arg_368_1:FormatText(arg_368_1:GetWordFromCfg(416191086).content)

				arg_368_1.text_.text = var_371_4

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_6 = 42 <= 0 and var_371_3 or var_371_3 * (utf8.len(var_371_4) / 42)

				if (42 <= 0 and var_371_3 or var_371_3 * (utf8.len(var_371_4) / 42)) > 0 and var_371_3 < var_371_6 then
					arg_368_1.talkMaxDuration = var_371_6

					if var_371_6 + var_371_2 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_6 + var_371_2
					end
				end

				arg_368_1.text_.text = var_371_4
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_7 = math.max(var_371_3, arg_368_1.talkMaxDuration)

			if var_371_2 <= arg_368_1.time_ and arg_368_1.time_ < var_371_2 + var_371_7 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_2) / var_371_7

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_2 + var_371_7 and arg_368_1.time_ < var_371_2 + var_371_7 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play416191087 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 416191087
		arg_372_1.duration_ = 5.83

		local var_372_0 = {
			zh = 5.833,
			ja = 4.933
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play416191088(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 and not isNil(arg_372_1.actors_["1086"]) and arg_372_1.var_.actorSpriteComps1086 == nil then
				arg_372_1.var_.actorSpriteComps1086 = arg_372_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_375_0 = 0.2

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_0 and not isNil(arg_372_1.actors_["1086"]) then
				if arg_372_1.var_.actorSpriteComps1086 then
					for iter_375_0, iter_375_1 in pairs(arg_372_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_375_1 then
							if arg_372_1.isInRecall_ then
								iter_375_1.color = Color.New(Mathf.Lerp(iter_375_1.color.r, arg_372_1.hightColor1.r, (arg_372_1.time_ - 0) / var_375_0), Mathf.Lerp(iter_375_1.color.g, arg_372_1.hightColor1.g, (arg_372_1.time_ - 0) / var_375_0), (Mathf.Lerp(iter_375_1.color.b, arg_372_1.hightColor1.b, (arg_372_1.time_ - 0) / var_375_0)))
							else
								local var_375_1 = Mathf.Lerp(iter_375_1.color.r, 1, (arg_372_1.time_ - 0) / var_375_0)

								iter_375_1.color = Color.New(var_375_1, var_375_1, var_375_1)
							end
						end
					end
				end
			end

			if arg_372_1.time_ >= 0 + var_375_0 and arg_372_1.time_ < 0 + var_375_0 + arg_375_0 and not isNil(arg_372_1.actors_["1086"]) and arg_372_1.var_.actorSpriteComps1086 then
				for iter_375_2, iter_375_3 in pairs(arg_372_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_375_3 then
						iter_375_3.color = arg_372_1.isInRecall_ and (arg_372_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_372_1.var_.actorSpriteComps1086 = nil
			end

			local var_375_2 = arg_372_1.actors_["1086"].transform

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.var_.moveOldPos1086 = var_375_2.localPosition
				var_375_2.localScale = Vector3.New(1, 1, 1)

				arg_372_1:CheckSpriteTmpPos("1086", 3)

				for iter_375_4 = 0, var_375_2.childCount - 1 do
					local var_375_3 = var_375_2:GetChild(iter_375_4)

					if var_375_3.name == "split_1" or not string.find(var_375_3.name, "split") then
						var_375_3.gameObject:SetActive(true)
					else
						var_375_3.gameObject:SetActive(false)
					end
				end
			end

			local var_375_4 = 0.001

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_4 then
				var_375_2.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_372_1.time_ - 0) / var_375_4)
			end

			if arg_372_1.time_ >= 0 + var_375_4 and arg_372_1.time_ < 0 + var_375_4 + arg_375_0 then
				var_375_2.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_375_5 = 0
			local var_375_6 = 0.425

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_5 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_7 = arg_372_1:GetWordFromCfg(416191087)
				local var_375_8 = arg_372_1:FormatText(var_375_7.content)

				arg_372_1.text_.text = var_375_8

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_10 = 17 <= 0 and var_375_6 or var_375_6 * (utf8.len(var_375_8) / 17)

				if (17 <= 0 and var_375_6 or var_375_6 * (utf8.len(var_375_8) / 17)) > 0 and var_375_6 < var_375_10 then
					arg_372_1.talkMaxDuration = var_375_10

					if var_375_10 + var_375_5 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_10 + var_375_5
					end
				end

				arg_372_1.text_.text = var_375_8
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191087", "story_v_out_416191.awb") ~= 0 then
					local var_375_11 = manager.audio:GetVoiceLength("story_v_out_416191", "416191087", "story_v_out_416191.awb") / 1000

					if var_375_11 + var_375_5 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_11 + var_375_5
					end

					if var_375_7.prefab_name ~= "" and arg_372_1.actors_[var_375_7.prefab_name] ~= nil then
						local var_375_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_7.prefab_name].transform, "story_v_out_416191", "416191087", "story_v_out_416191.awb")

						arg_372_1:RecordAudio("416191087", var_375_12)
						arg_372_1:RecordAudio("416191087", var_375_12)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_416191", "416191087", "story_v_out_416191.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_416191", "416191087", "story_v_out_416191.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_13 = math.max(var_375_6, arg_372_1.talkMaxDuration)

			if var_375_5 <= arg_372_1.time_ and arg_372_1.time_ < var_375_5 + var_375_13 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_5) / var_375_13

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_5 + var_375_13 and arg_372_1.time_ < var_375_5 + var_375_13 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play416191088 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 416191088
		arg_376_1.duration_ = 10.07

		local var_376_0 = {
			zh = 4.8,
			ja = 10.066
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play416191089(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(arg_376_1.actors_["1028"]) and arg_376_1.var_.actorSpriteComps1028 == nil then
				arg_376_1.var_.actorSpriteComps1028 = arg_376_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_379_0 = 0.2

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 and not isNil(arg_376_1.actors_["1028"]) then
				if arg_376_1.var_.actorSpriteComps1028 then
					for iter_379_0, iter_379_1 in pairs(arg_376_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_379_1 then
							if arg_376_1.isInRecall_ then
								iter_379_1.color = Color.New(Mathf.Lerp(iter_379_1.color.r, arg_376_1.hightColor1.r, (arg_376_1.time_ - 0) / var_379_0), Mathf.Lerp(iter_379_1.color.g, arg_376_1.hightColor1.g, (arg_376_1.time_ - 0) / var_379_0), (Mathf.Lerp(iter_379_1.color.b, arg_376_1.hightColor1.b, (arg_376_1.time_ - 0) / var_379_0)))
							else
								local var_379_1 = Mathf.Lerp(iter_379_1.color.r, 1, (arg_376_1.time_ - 0) / var_379_0)

								iter_379_1.color = Color.New(var_379_1, var_379_1, var_379_1)
							end
						end
					end
				end
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 and not isNil(arg_376_1.actors_["1028"]) and arg_376_1.var_.actorSpriteComps1028 then
				for iter_379_2, iter_379_3 in pairs(arg_376_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_379_3 then
						iter_379_3.color = arg_376_1.isInRecall_ and (arg_376_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_376_1.var_.actorSpriteComps1028 = nil
			end

			local var_379_2 = arg_376_1.actors_["1086"]

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(var_379_2) and arg_376_1.var_.actorSpriteComps1086 == nil then
				arg_376_1.var_.actorSpriteComps1086 = var_379_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_379_3 = 0.2

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_3 and not isNil(var_379_2) then
				if arg_376_1.var_.actorSpriteComps1086 then
					for iter_379_4, iter_379_5 in pairs(arg_376_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_379_5 then
							if arg_376_1.isInRecall_ then
								iter_379_5.color = Color.New(Mathf.Lerp(iter_379_5.color.r, arg_376_1.hightColor2.r, (arg_376_1.time_ - 0) / var_379_3), Mathf.Lerp(iter_379_5.color.g, arg_376_1.hightColor2.g, (arg_376_1.time_ - 0) / var_379_3), (Mathf.Lerp(iter_379_5.color.b, arg_376_1.hightColor2.b, (arg_376_1.time_ - 0) / var_379_3)))
							else
								local var_379_4 = Mathf.Lerp(iter_379_5.color.r, 0.5, (arg_376_1.time_ - 0) / var_379_3)

								iter_379_5.color = Color.New(var_379_4, var_379_4, var_379_4)
							end
						end
					end
				end
			end

			if arg_376_1.time_ >= 0 + var_379_3 and arg_376_1.time_ < 0 + var_379_3 + arg_379_0 and not isNil(var_379_2) and arg_376_1.var_.actorSpriteComps1086 then
				for iter_379_6, iter_379_7 in pairs(arg_376_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_379_7 then
						iter_379_7.color = arg_376_1.isInRecall_ and (arg_376_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_376_1.var_.actorSpriteComps1086 = nil
			end

			local var_379_5 = arg_376_1.actors_["1028"].transform

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.var_.moveOldPos1028 = var_379_5.localPosition
				var_379_5.localScale = Vector3.New(1, 1, 1)

				arg_376_1:CheckSpriteTmpPos("1028", 2)

				for iter_379_8 = 0, var_379_5.childCount - 1 do
					local var_379_6 = var_379_5:GetChild(iter_379_8)

					if var_379_6.name == "" or not string.find(var_379_6.name, "split") then
						var_379_6.gameObject:SetActive(true)
					else
						var_379_6.gameObject:SetActive(false)
					end
				end
			end

			local var_379_7 = 0.001

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_7 then
				var_379_5.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_376_1.time_ - 0) / var_379_7)
			end

			if arg_376_1.time_ >= 0 + var_379_7 and arg_376_1.time_ < 0 + var_379_7 + arg_379_0 then
				var_379_5.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_379_8 = arg_376_1.actors_["1086"].transform

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.var_.moveOldPos1086 = var_379_8.localPosition
				var_379_8.localScale = Vector3.New(1, 1, 1)

				arg_376_1:CheckSpriteTmpPos("1086", 4)

				for iter_379_9 = 0, var_379_8.childCount - 1 do
					local var_379_9 = var_379_8:GetChild(iter_379_9)

					if var_379_9.name == "" or not string.find(var_379_9.name, "split") then
						var_379_9.gameObject:SetActive(true)
					else
						var_379_9.gameObject:SetActive(false)
					end
				end
			end

			local var_379_10 = 0.001

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_10 then
				var_379_8.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_376_1.time_ - 0) / var_379_10)
			end

			if arg_376_1.time_ >= 0 + var_379_10 and arg_376_1.time_ < 0 + var_379_10 + arg_379_0 then
				var_379_8.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_379_11 = 0
			local var_379_12 = 0.575

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_11 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_13 = arg_376_1:GetWordFromCfg(416191088)
				local var_379_14 = arg_376_1:FormatText(var_379_13.content)

				arg_376_1.text_.text = var_379_14

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_16 = 23 <= 0 and var_379_12 or var_379_12 * (utf8.len(var_379_14) / 23)

				if (23 <= 0 and var_379_12 or var_379_12 * (utf8.len(var_379_14) / 23)) > 0 and var_379_12 < var_379_16 then
					arg_376_1.talkMaxDuration = var_379_16

					if var_379_16 + var_379_11 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_16 + var_379_11
					end
				end

				arg_376_1.text_.text = var_379_14
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191088", "story_v_out_416191.awb") ~= 0 then
					local var_379_17 = manager.audio:GetVoiceLength("story_v_out_416191", "416191088", "story_v_out_416191.awb") / 1000

					if var_379_17 + var_379_11 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_17 + var_379_11
					end

					if var_379_13.prefab_name ~= "" and arg_376_1.actors_[var_379_13.prefab_name] ~= nil then
						local var_379_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_13.prefab_name].transform, "story_v_out_416191", "416191088", "story_v_out_416191.awb")

						arg_376_1:RecordAudio("416191088", var_379_18)
						arg_376_1:RecordAudio("416191088", var_379_18)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_416191", "416191088", "story_v_out_416191.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_416191", "416191088", "story_v_out_416191.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_19 = math.max(var_379_12, arg_376_1.talkMaxDuration)

			if var_379_11 <= arg_376_1.time_ and arg_376_1.time_ < var_379_11 + var_379_19 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_11) / var_379_19

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_11 + var_379_19 and arg_376_1.time_ < var_379_11 + var_379_19 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_376_1:InitPlayNodeList()
	end,
	Play416191089 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 416191089
		arg_380_1.duration_ = 5.2

		local var_380_0 = {
			zh = 3.666,
			ja = 5.2
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play416191090(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(arg_380_1.actors_["1086"]) and arg_380_1.var_.actorSpriteComps1086 == nil then
				arg_380_1.var_.actorSpriteComps1086 = arg_380_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_383_0 = 0.2

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_0 and not isNil(arg_380_1.actors_["1086"]) then
				if arg_380_1.var_.actorSpriteComps1086 then
					for iter_383_0, iter_383_1 in pairs(arg_380_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_383_1 then
							if arg_380_1.isInRecall_ then
								iter_383_1.color = Color.New(Mathf.Lerp(iter_383_1.color.r, arg_380_1.hightColor1.r, (arg_380_1.time_ - 0) / var_383_0), Mathf.Lerp(iter_383_1.color.g, arg_380_1.hightColor1.g, (arg_380_1.time_ - 0) / var_383_0), (Mathf.Lerp(iter_383_1.color.b, arg_380_1.hightColor1.b, (arg_380_1.time_ - 0) / var_383_0)))
							else
								local var_383_1 = Mathf.Lerp(iter_383_1.color.r, 1, (arg_380_1.time_ - 0) / var_383_0)

								iter_383_1.color = Color.New(var_383_1, var_383_1, var_383_1)
							end
						end
					end
				end
			end

			if arg_380_1.time_ >= 0 + var_383_0 and arg_380_1.time_ < 0 + var_383_0 + arg_383_0 and not isNil(arg_380_1.actors_["1086"]) and arg_380_1.var_.actorSpriteComps1086 then
				for iter_383_2, iter_383_3 in pairs(arg_380_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_383_3 then
						iter_383_3.color = arg_380_1.isInRecall_ and (arg_380_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_380_1.var_.actorSpriteComps1086 = nil
			end

			local var_383_2 = arg_380_1.actors_["1028"]

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(var_383_2) and arg_380_1.var_.actorSpriteComps1028 == nil then
				arg_380_1.var_.actorSpriteComps1028 = var_383_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_383_3 = 0.2

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_3 and not isNil(var_383_2) then
				if arg_380_1.var_.actorSpriteComps1028 then
					for iter_383_4, iter_383_5 in pairs(arg_380_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_383_5 then
							if arg_380_1.isInRecall_ then
								iter_383_5.color = Color.New(Mathf.Lerp(iter_383_5.color.r, arg_380_1.hightColor2.r, (arg_380_1.time_ - 0) / var_383_3), Mathf.Lerp(iter_383_5.color.g, arg_380_1.hightColor2.g, (arg_380_1.time_ - 0) / var_383_3), (Mathf.Lerp(iter_383_5.color.b, arg_380_1.hightColor2.b, (arg_380_1.time_ - 0) / var_383_3)))
							else
								local var_383_4 = Mathf.Lerp(iter_383_5.color.r, 0.5, (arg_380_1.time_ - 0) / var_383_3)

								iter_383_5.color = Color.New(var_383_4, var_383_4, var_383_4)
							end
						end
					end
				end
			end

			if arg_380_1.time_ >= 0 + var_383_3 and arg_380_1.time_ < 0 + var_383_3 + arg_383_0 and not isNil(var_383_2) and arg_380_1.var_.actorSpriteComps1028 then
				for iter_383_6, iter_383_7 in pairs(arg_380_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_383_7 then
						iter_383_7.color = arg_380_1.isInRecall_ and (arg_380_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_380_1.var_.actorSpriteComps1028 = nil
			end

			local var_383_5 = arg_380_1.actors_["1086"].transform

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.var_.moveOldPos1086 = var_383_5.localPosition
				var_383_5.localScale = Vector3.New(1, 1, 1)

				arg_380_1:CheckSpriteTmpPos("1086", 4)

				for iter_383_8 = 0, var_383_5.childCount - 1 do
					local var_383_6 = var_383_5:GetChild(iter_383_8)

					if var_383_6.name == "split_4" or not string.find(var_383_6.name, "split") then
						var_383_6.gameObject:SetActive(true)
					else
						var_383_6.gameObject:SetActive(false)
					end
				end
			end

			local var_383_7 = 0.001

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_7 then
				var_383_5.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_380_1.time_ - 0) / var_383_7)
			end

			if arg_380_1.time_ >= 0 + var_383_7 and arg_380_1.time_ < 0 + var_383_7 + arg_383_0 then
				var_383_5.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_383_8 = 0
			local var_383_9 = 0.325

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_8 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				arg_380_1.leftNameTxt_.text = arg_380_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_10 = arg_380_1:GetWordFromCfg(416191089)
				local var_383_11 = arg_380_1:FormatText(var_383_10.content)

				arg_380_1.text_.text = var_383_11

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_13 = 13 <= 0 and var_383_9 or var_383_9 * (utf8.len(var_383_11) / 13)

				if (13 <= 0 and var_383_9 or var_383_9 * (utf8.len(var_383_11) / 13)) > 0 and var_383_9 < var_383_13 then
					arg_380_1.talkMaxDuration = var_383_13

					if var_383_13 + var_383_8 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_13 + var_383_8
					end
				end

				arg_380_1.text_.text = var_383_11
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191089", "story_v_out_416191.awb") ~= 0 then
					local var_383_14 = manager.audio:GetVoiceLength("story_v_out_416191", "416191089", "story_v_out_416191.awb") / 1000

					if var_383_14 + var_383_8 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_14 + var_383_8
					end

					if var_383_10.prefab_name ~= "" and arg_380_1.actors_[var_383_10.prefab_name] ~= nil then
						local var_383_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_10.prefab_name].transform, "story_v_out_416191", "416191089", "story_v_out_416191.awb")

						arg_380_1:RecordAudio("416191089", var_383_15)
						arg_380_1:RecordAudio("416191089", var_383_15)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_416191", "416191089", "story_v_out_416191.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_416191", "416191089", "story_v_out_416191.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_16 = math.max(var_383_9, arg_380_1.talkMaxDuration)

			if var_383_8 <= arg_380_1.time_ and arg_380_1.time_ < var_383_8 + var_383_16 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_8) / var_383_16

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_8 + var_383_16 and arg_380_1.time_ < var_383_8 + var_383_16 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play416191090 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 416191090
		arg_384_1.duration_ = 6.5

		local var_384_0 = {
			zh = 5,
			ja = 6.5
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play416191091(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(arg_384_1.actors_["1028"]) and arg_384_1.var_.actorSpriteComps1028 == nil then
				arg_384_1.var_.actorSpriteComps1028 = arg_384_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_387_0 = 0.2

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_0 and not isNil(arg_384_1.actors_["1028"]) then
				if arg_384_1.var_.actorSpriteComps1028 then
					for iter_387_0, iter_387_1 in pairs(arg_384_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_387_1 then
							if arg_384_1.isInRecall_ then
								iter_387_1.color = Color.New(Mathf.Lerp(iter_387_1.color.r, arg_384_1.hightColor1.r, (arg_384_1.time_ - 0) / var_387_0), Mathf.Lerp(iter_387_1.color.g, arg_384_1.hightColor1.g, (arg_384_1.time_ - 0) / var_387_0), (Mathf.Lerp(iter_387_1.color.b, arg_384_1.hightColor1.b, (arg_384_1.time_ - 0) / var_387_0)))
							else
								local var_387_1 = Mathf.Lerp(iter_387_1.color.r, 1, (arg_384_1.time_ - 0) / var_387_0)

								iter_387_1.color = Color.New(var_387_1, var_387_1, var_387_1)
							end
						end
					end
				end
			end

			if arg_384_1.time_ >= 0 + var_387_0 and arg_384_1.time_ < 0 + var_387_0 + arg_387_0 and not isNil(arg_384_1.actors_["1028"]) and arg_384_1.var_.actorSpriteComps1028 then
				for iter_387_2, iter_387_3 in pairs(arg_384_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_387_3 then
						iter_387_3.color = arg_384_1.isInRecall_ and (arg_384_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_384_1.var_.actorSpriteComps1028 = nil
			end

			local var_387_2 = arg_384_1.actors_["1086"]

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 and not isNil(var_387_2) and arg_384_1.var_.actorSpriteComps1086 == nil then
				arg_384_1.var_.actorSpriteComps1086 = var_387_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_387_3 = 0.2

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_3 and not isNil(var_387_2) then
				if arg_384_1.var_.actorSpriteComps1086 then
					for iter_387_4, iter_387_5 in pairs(arg_384_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_387_5 then
							if arg_384_1.isInRecall_ then
								iter_387_5.color = Color.New(Mathf.Lerp(iter_387_5.color.r, arg_384_1.hightColor2.r, (arg_384_1.time_ - 0) / var_387_3), Mathf.Lerp(iter_387_5.color.g, arg_384_1.hightColor2.g, (arg_384_1.time_ - 0) / var_387_3), (Mathf.Lerp(iter_387_5.color.b, arg_384_1.hightColor2.b, (arg_384_1.time_ - 0) / var_387_3)))
							else
								local var_387_4 = Mathf.Lerp(iter_387_5.color.r, 0.5, (arg_384_1.time_ - 0) / var_387_3)

								iter_387_5.color = Color.New(var_387_4, var_387_4, var_387_4)
							end
						end
					end
				end
			end

			if arg_384_1.time_ >= 0 + var_387_3 and arg_384_1.time_ < 0 + var_387_3 + arg_387_0 and not isNil(var_387_2) and arg_384_1.var_.actorSpriteComps1086 then
				for iter_387_6, iter_387_7 in pairs(arg_384_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_387_7 then
						iter_387_7.color = arg_384_1.isInRecall_ and (arg_384_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_384_1.var_.actorSpriteComps1086 = nil
			end

			local var_387_5 = 0
			local var_387_6 = 0.55

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= var_387_5 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_7 = arg_384_1:GetWordFromCfg(416191090)
				local var_387_8 = arg_384_1:FormatText(var_387_7.content)

				arg_384_1.text_.text = var_387_8

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_10 = 22 <= 0 and var_387_6 or var_387_6 * (utf8.len(var_387_8) / 22)

				if (22 <= 0 and var_387_6 or var_387_6 * (utf8.len(var_387_8) / 22)) > 0 and var_387_6 < var_387_10 then
					arg_384_1.talkMaxDuration = var_387_10

					if var_387_10 + var_387_5 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_10 + var_387_5
					end
				end

				arg_384_1.text_.text = var_387_8
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416191", "416191090", "story_v_out_416191.awb") ~= 0 then
					local var_387_11 = manager.audio:GetVoiceLength("story_v_out_416191", "416191090", "story_v_out_416191.awb") / 1000

					if var_387_11 + var_387_5 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_11 + var_387_5
					end

					if var_387_7.prefab_name ~= "" and arg_384_1.actors_[var_387_7.prefab_name] ~= nil then
						local var_387_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_7.prefab_name].transform, "story_v_out_416191", "416191090", "story_v_out_416191.awb")

						arg_384_1:RecordAudio("416191090", var_387_12)
						arg_384_1:RecordAudio("416191090", var_387_12)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_416191", "416191090", "story_v_out_416191.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_416191", "416191090", "story_v_out_416191.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_13 = math.max(var_387_6, arg_384_1.talkMaxDuration)

			if var_387_5 <= arg_384_1.time_ and arg_384_1.time_ < var_387_5 + var_387_13 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_5) / var_387_13

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_5 + var_387_13 and arg_384_1.time_ < var_387_5 + var_387_13 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play416191091 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 416191091
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
			arg_388_1.auto_ = false
		end

		function arg_388_1.playNext_(arg_390_0)
			arg_388_1.onStoryFinished_()
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(arg_388_1.actors_["1028"]) and arg_388_1.var_.actorSpriteComps1028 == nil then
				arg_388_1.var_.actorSpriteComps1028 = arg_388_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_391_0 = 0.2

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 and not isNil(arg_388_1.actors_["1028"]) then
				if arg_388_1.var_.actorSpriteComps1028 then
					for iter_391_0, iter_391_1 in pairs(arg_388_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_391_1 then
							if arg_388_1.isInRecall_ then
								iter_391_1.color = Color.New(Mathf.Lerp(iter_391_1.color.r, arg_388_1.hightColor2.r, (arg_388_1.time_ - 0) / var_391_0), Mathf.Lerp(iter_391_1.color.g, arg_388_1.hightColor2.g, (arg_388_1.time_ - 0) / var_391_0), (Mathf.Lerp(iter_391_1.color.b, arg_388_1.hightColor2.b, (arg_388_1.time_ - 0) / var_391_0)))
							else
								local var_391_1 = Mathf.Lerp(iter_391_1.color.r, 0.5, (arg_388_1.time_ - 0) / var_391_0)

								iter_391_1.color = Color.New(var_391_1, var_391_1, var_391_1)
							end
						end
					end
				end
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 and not isNil(arg_388_1.actors_["1028"]) and arg_388_1.var_.actorSpriteComps1028 then
				for iter_391_2, iter_391_3 in pairs(arg_388_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_391_3 then
						iter_391_3.color = arg_388_1.isInRecall_ and (arg_388_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_388_1.var_.actorSpriteComps1028 = nil
			end

			local var_391_2 = arg_388_1.actors_["1028"].transform

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos1028 = var_391_2.localPosition
				var_391_2.localScale = Vector3.New(1, 1, 1)

				arg_388_1:CheckSpriteTmpPos("1028", 7)

				for iter_391_4 = 0, var_391_2.childCount - 1 do
					local var_391_3 = var_391_2:GetChild(iter_391_4)

					if var_391_3.name == "" or not string.find(var_391_3.name, "split") then
						var_391_3.gameObject:SetActive(true)
					else
						var_391_3.gameObject:SetActive(false)
					end
				end
			end

			local var_391_4 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_4 then
				var_391_2.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_388_1.time_ - 0) / var_391_4)
			end

			if arg_388_1.time_ >= 0 + var_391_4 and arg_388_1.time_ < 0 + var_391_4 + arg_391_0 then
				var_391_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_391_5 = arg_388_1.actors_["1086"].transform

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos1086 = var_391_5.localPosition
				var_391_5.localScale = Vector3.New(1, 1, 1)

				arg_388_1:CheckSpriteTmpPos("1086", 7)

				for iter_391_5 = 0, var_391_5.childCount - 1 do
					local var_391_6 = var_391_5:GetChild(iter_391_5)

					if var_391_6.name == "" or not string.find(var_391_6.name, "split") then
						var_391_6.gameObject:SetActive(true)
					else
						var_391_6.gameObject:SetActive(false)
					end
				end
			end

			local var_391_7 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_7 then
				var_391_5.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_388_1.time_ - 0) / var_391_7)
			end

			if arg_388_1.time_ >= 0 + var_391_7 and arg_388_1.time_ < 0 + var_391_7 + arg_391_0 then
				var_391_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_391_8 = 0
			local var_391_9 = 1.65

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_8 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_10 = arg_388_1:FormatText(arg_388_1:GetWordFromCfg(416191091).content)

				arg_388_1.text_.text = var_391_10

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_12 = 66 <= 0 and var_391_9 or var_391_9 * (utf8.len(var_391_10) / 66)

				if (66 <= 0 and var_391_9 or var_391_9 * (utf8.len(var_391_10) / 66)) > 0 and var_391_9 < var_391_12 then
					arg_388_1.talkMaxDuration = var_391_12

					if var_391_12 + var_391_8 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_12 + var_391_8
					end
				end

				arg_388_1.text_.text = var_391_10
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_13 = math.max(var_391_9, arg_388_1.talkMaxDuration)

			if var_391_8 <= arg_388_1.time_ and arg_388_1.time_ < var_391_8 + var_391_13 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_8) / var_391_13

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_8 + var_391_13 and arg_388_1.time_ < var_391_8 + var_391_13 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/SS1608",
		"TextureConfig/Background/F09f"
	},
	voices = {
		"story_v_out_416191.awb"
	}
}
