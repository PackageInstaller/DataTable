return {
	Play319651001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319651001
		arg_1_1.duration_ = 1.23

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319651002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 0.233333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.233333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon.awb")

				local var_4_5 = manager.audio:GetAudioName("bgm_activity_3_0_story_moon", "bgm_activity_3_0_story_moon")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_5 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_5

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_5
						arg_1_1.bgmTxt2_.text = var_4_5
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_6 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_7 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_8 = var_4_6:GetComponent("RectTransform")

				var_4_6:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_4_8.offsetMin = Vector2.New(0, 0)
				var_4_8.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0
				arg_1_1.fswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(319651001).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_9 = 0.149999999998999

			if 0.149999999998999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_10 = 0
			local var_4_11 = 0
			local var_4_12, var_4_13 = arg_1_1:GetPercentByPara(arg_1_1:FormatText(arg_1_1:GetWordFromCfg(319651001).content), 1)

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

			local var_4_15 = math.max(0, arg_1_1.talkMaxDuration)

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

			local var_4_16 = 0.15

			if 0.15 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_17 = 6
			local var_4_18 = 0.4
			local var_4_19, var_4_20 = arg_1_1:GetPercentByPara(arg_1_1:FormatText(arg_1_1:GetWordFromCfg(319651001).content), 1)

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_21 = var_4_17 <= 0 and var_4_18 or var_4_18 * ((var_4_20 - arg_1_1.typewritterCharCountI18N) / var_4_17)

				if (var_4_17 <= 0 and var_4_18 or var_4_18 * ((var_4_20 - arg_1_1.typewritterCharCountI18N) / var_4_17)) > 0 and var_4_18 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21

					if var_4_21 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_16
					end
				end
			end

			local var_4_22 = math.max(0.4, arg_1_1.talkMaxDuration)

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_22 then
				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_19, (arg_1_1.time_ - var_4_16) / var_4_22)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_16 + var_4_22 and arg_1_1.time_ < var_4_16 + var_4_22 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_19

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_20
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.cswbg_:SetActive(true)

				local var_4_23 = arg_1_1.cswt_:GetComponent("RectTransform")

				arg_1_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_23.offsetMin = Vector2.New(410, 330)
				var_4_23.offsetMax = Vector2.New(-400, -180)
				arg_1_1.cswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(419036).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.cswt_)

				arg_1_1.cswt_.fontSize = 174
				arg_1_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_1_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_4_24 = 0
			local var_4_25 = manager.audio:GetVoiceLength("story_v_out_319651", "319651001", "story_v_out_319651.awb") / 1000

			if var_4_25 > 0 and 1.233 < var_4_25 and var_4_25 + var_4_24 > arg_1_1.duration_ then
				arg_1_1.duration_ = var_4_25 + var_4_24
			end

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1:AudioAction("play", "voice", "story_v_out_319651", "319651001", "story_v_out_319651.awb")
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319651002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 319651002
		arg_7_1.duration_ = 3.13

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play319651003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.fswbg_:SetActive(true)
				arg_7_1.dialog_:SetActive(false)

				arg_7_1.fswtw_.percent = 0
				arg_7_1.fswt_.text = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(319651002).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.fswt_)

				arg_7_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_7_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_7_1.fswtw_:SetDirty()

				arg_7_1.typewritterCharCountI18N = 0

				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_7_1:ShowNextGo(false)
			end

			local var_10_0 = 0.149999999998999

			if 0.149999999998999 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.var_.oldValueTypewriter = arg_7_1.fswtw_.percent

				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_7_1:ShowNextGo(false)
			end

			local var_10_1 = 0
			local var_10_2 = 0
			local var_10_3, var_10_4 = arg_7_1:GetPercentByPara(arg_7_1:FormatText(arg_7_1:GetWordFromCfg(319651002).content), 1)

			if var_10_0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				local var_10_5 = var_10_1 <= 0 and var_10_2 or var_10_2 * ((var_10_4 - arg_7_1.typewritterCharCountI18N) / var_10_1)

				if (var_10_1 <= 0 and var_10_2 or var_10_2 * ((var_10_4 - arg_7_1.typewritterCharCountI18N) / var_10_1)) > 0 and var_10_2 < var_10_5 then
					arg_7_1.talkMaxDuration = var_10_5

					if var_10_5 + var_10_0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_5 + var_10_0
					end
				end
			end

			local var_10_6 = math.max(0, arg_7_1.talkMaxDuration)

			if var_10_0 <= arg_7_1.time_ and arg_7_1.time_ < var_10_0 + var_10_6 then
				arg_7_1.fswtw_.percent = Mathf.Lerp(arg_7_1.var_.oldValueTypewriter, var_10_3, (arg_7_1.time_ - var_10_0) / var_10_6)
				arg_7_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_7_1.fswtw_:SetDirty()
			end

			if arg_7_1.time_ >= var_10_0 + var_10_6 and arg_7_1.time_ < var_10_0 + var_10_6 + arg_10_0 then
				arg_7_1.fswtw_.percent = var_10_3

				arg_7_1.fswtw_:SetDirty()
				arg_7_1:ShowNextGo(true)

				arg_7_1.typewritterCharCountI18N = var_10_4
			end

			local var_10_7 = 0.333333333333333

			if 0.333333333333333 < arg_7_1.time_ and arg_7_1.time_ <= var_10_7 + arg_10_0 then
				arg_7_1.var_.oldValueTypewriter = arg_7_1.fswtw_.percent

				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_7_1:ShowNextGo(false)
			end

			local var_10_8 = 14
			local var_10_9 = 0.933333333333333
			local var_10_10, var_10_11 = arg_7_1:GetPercentByPara(arg_7_1:FormatText(arg_7_1:GetWordFromCfg(319651002).content), 1)

			if var_10_7 < arg_7_1.time_ and arg_7_1.time_ <= var_10_7 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				local var_10_12 = var_10_8 <= 0 and var_10_9 or var_10_9 * ((var_10_11 - arg_7_1.typewritterCharCountI18N) / var_10_8)

				if (var_10_8 <= 0 and var_10_9 or var_10_9 * ((var_10_11 - arg_7_1.typewritterCharCountI18N) / var_10_8)) > 0 and var_10_9 < var_10_12 then
					arg_7_1.talkMaxDuration = var_10_12

					if var_10_12 + var_10_7 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_12 + var_10_7
					end
				end
			end

			local var_10_13 = math.max(0.933333333333333, arg_7_1.talkMaxDuration)

			if var_10_7 <= arg_7_1.time_ and arg_7_1.time_ < var_10_7 + var_10_13 then
				arg_7_1.fswtw_.percent = Mathf.Lerp(arg_7_1.var_.oldValueTypewriter, var_10_10, (arg_7_1.time_ - var_10_7) / var_10_13)
				arg_7_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_7_1.fswtw_:SetDirty()
			end

			if arg_7_1.time_ >= var_10_7 + var_10_13 and arg_7_1.time_ < var_10_7 + var_10_13 + arg_10_0 then
				arg_7_1.fswtw_.percent = var_10_10

				arg_7_1.fswtw_:SetDirty()
				arg_7_1:ShowNextGo(true)

				arg_7_1.typewritterCharCountI18N = var_10_11
			end

			local var_10_14 = 0.333333333333333
			local var_10_15 = manager.audio:GetVoiceLength("story_v_out_319651", "319651002", "story_v_out_319651.awb") / 1000

			if var_10_15 > 0 and 2.8 < var_10_15 and var_10_15 + var_10_14 > arg_7_1.duration_ then
				arg_7_1.duration_ = var_10_15 + var_10_14
			end

			if var_10_14 < arg_7_1.time_ and arg_7_1.time_ <= var_10_14 + arg_10_0 then
				arg_7_1:AudioAction("play", "voice", "story_v_out_319651", "319651002", "story_v_out_319651.awb")
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play319651003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 319651003
		arg_11_1.duration_ = 7.87

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play319651004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if arg_11_1.bgs_.ST74 == nil then
				local var_14_0 = Object.Instantiate(arg_11_1.paintGo_)

				var_14_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST74")
				var_14_0.name = "ST74"
				var_14_0.transform.parent = arg_11_1.stage_.transform
				var_14_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.bgs_.ST74 = var_14_0
			end

			if 1 < arg_11_1.time_ and arg_11_1.time_ <= 1 + arg_14_0 then
				local var_14_1 = arg_11_1.bgs_.ST74

				arg_11_1.bgs_.ST74.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_14_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_14_2 = var_14_1:GetComponent("SpriteRenderer")

				if var_14_2 and var_14_2.sprite then
					local var_14_3 = 2 * (var_14_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_14_1.transform.localScale = Vector3.New(var_14_3 / var_14_2.sprite.bounds.size.y < var_14_3 * manager.ui.mainCameraCom_.aspect / var_14_2.sprite.bounds.size.x and var_14_3 * manager.ui.mainCameraCom_.aspect / var_14_2.sprite.bounds.size.x or var_14_3 / var_14_2.sprite.bounds.size.y, var_14_3 / var_14_2.sprite.bounds.size.y < var_14_3 * manager.ui.mainCameraCom_.aspect / var_14_2.sprite.bounds.size.x and var_14_3 * manager.ui.mainCameraCom_.aspect / var_14_2.sprite.bounds.size.x or var_14_3 / var_14_2.sprite.bounds.size.y, 0)
				end

				for iter_14_0, iter_14_1 in pairs(arg_11_1.bgs_) do
					if iter_14_0 ~= "ST74" then
						iter_14_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_14_4 = 0

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_4 + arg_14_0 then
				arg_11_1.mask_.enabled = true
				arg_11_1.mask_.raycastTarget = true

				arg_11_1:SetGaussion(false)
			end

			local var_14_5 = 1

			if var_14_4 <= arg_11_1.time_ and arg_11_1.time_ < var_14_4 + var_14_5 then
				local var_14_6 = Color.New(0, 0, 0)

				var_14_6.a = Mathf.Lerp(0, 1, (arg_11_1.time_ - var_14_4) / var_14_5)
				arg_11_1.mask_.color = var_14_6
			end

			if arg_11_1.time_ >= var_14_4 + var_14_5 and arg_11_1.time_ < var_14_4 + var_14_5 + arg_14_0 then
				local var_14_7 = Color.New(0, 0, 0)

				var_14_7.a = 1
				arg_11_1.mask_.color = var_14_7
			end

			local var_14_8 = 1

			if 1 < arg_11_1.time_ and arg_11_1.time_ <= var_14_8 + arg_14_0 then
				arg_11_1.mask_.enabled = true
				arg_11_1.mask_.raycastTarget = true

				arg_11_1:SetGaussion(false)
			end

			local var_14_9 = 2

			if var_14_8 <= arg_11_1.time_ and arg_11_1.time_ < var_14_8 + var_14_9 then
				local var_14_10 = Color.New(0, 0, 0)

				var_14_10.a = Mathf.Lerp(1, 0, (arg_11_1.time_ - var_14_8) / var_14_9)
				arg_11_1.mask_.color = var_14_10
			end

			if arg_11_1.time_ >= var_14_8 + var_14_9 and arg_11_1.time_ < var_14_8 + var_14_9 + arg_14_0 then
				local var_14_11 = Color.New(0, 0, 0)

				arg_11_1.mask_.enabled = false
				var_14_11.a = 0
				arg_11_1.mask_.color = var_14_11
			end

			if 1 < arg_11_1.time_ and arg_11_1.time_ <= 1 + arg_14_0 then
				arg_11_1.cswbg_:SetActive(false)
			end

			if 1 < arg_11_1.time_ and arg_11_1.time_ <= 1 + arg_14_0 then
				arg_11_1.fswbg_:SetActive(false)
				arg_11_1.dialog_:SetActive(false)
				SetActive(arg_11_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_11_1:ShowNextGo(false)
			end

			local var_14_12 = 1.149999999999

			if 1.149999999999 < arg_11_1.time_ and arg_11_1.time_ <= var_14_12 + arg_14_0 then
				arg_11_1.var_.oldValueTypewriter = arg_11_1.fswtw_.percent

				SetActive(arg_11_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_11_1:ShowNextGo(false)
			end

			local var_14_13 = 0
			local var_14_14 = 0
			local var_14_15, var_14_16 = arg_11_1:GetPercentByPara(arg_11_1:FormatText(arg_11_1:GetWordFromCfg(319651002).content), 1)

			if var_14_12 < arg_11_1.time_ and arg_11_1.time_ <= var_14_12 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0

				local var_14_17 = var_14_13 <= 0 and var_14_14 or var_14_14 * ((var_14_16 - arg_11_1.typewritterCharCountI18N) / var_14_13)

				if (var_14_13 <= 0 and var_14_14 or var_14_14 * ((var_14_16 - arg_11_1.typewritterCharCountI18N) / var_14_13)) > 0 and var_14_14 < var_14_17 then
					arg_11_1.talkMaxDuration = var_14_17

					if var_14_17 + var_14_12 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_17 + var_14_12
					end
				end
			end

			local var_14_18 = math.max(0, arg_11_1.talkMaxDuration)

			if var_14_12 <= arg_11_1.time_ and arg_11_1.time_ < var_14_12 + var_14_18 then
				arg_11_1.fswtw_.percent = Mathf.Lerp(arg_11_1.var_.oldValueTypewriter, var_14_15, (arg_11_1.time_ - var_14_12) / var_14_18)
				arg_11_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_11_1.fswtw_:SetDirty()
			end

			if arg_11_1.time_ >= var_14_12 + var_14_18 and arg_11_1.time_ < var_14_12 + var_14_18 + arg_14_0 then
				arg_11_1.fswtw_.percent = var_14_15

				arg_11_1.fswtw_:SetDirty()
				arg_11_1:ShowNextGo(true)

				arg_11_1.typewritterCharCountI18N = var_14_16
			end

			if 1.15 < arg_11_1.time_ and arg_11_1.time_ <= 1.15 + arg_14_0 then
				arg_11_1.fswbg_:SetActive(false)
				arg_11_1.dialog_:SetActive(false)
				SetActive(arg_11_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_11_1:ShowNextGo(false)
			end

			if arg_11_1.frameCnt_ <= 1 then
				arg_11_1.dialog_:SetActive(false)
			end

			local var_14_19 = 2.86666666666667
			local var_14_20 = 1

			if 2.86666666666667 < arg_11_1.time_ and arg_11_1.time_ <= var_14_19 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0

				arg_11_1.dialog_:SetActive(true)

				arg_11_1.dialogCg_.alpha = 0

				local var_14_21 = LeanTween.value(arg_11_1.dialog_, 0, 1, 0.3)

				var_14_21:setOnUpdate(LuaHelper.FloatAction(function(arg_15_0)
					arg_11_1.dialogCg_.alpha = arg_15_0
				end))
				var_14_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_11_1.dialog_)
					var_14_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_11_1.duration_ = arg_11_1.duration_ + 0.3

				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_22 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(319651003).content)

				arg_11_1.text_.text = var_14_22

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_24 = 40 <= 0 and var_14_20 or var_14_20 * (utf8.len(var_14_22) / 40)

				if (40 <= 0 and var_14_20 or var_14_20 * (utf8.len(var_14_22) / 40)) > 0 and var_14_20 < var_14_24 then
					arg_11_1.talkMaxDuration = var_14_24
					var_14_19 = var_14_19 + 0.3

					if var_14_24 + var_14_19 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_24 + var_14_19
					end
				end

				arg_11_1.text_.text = var_14_22
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_25 = var_14_19 + 0.3
			local var_14_26 = math.max(var_14_20, arg_11_1.talkMaxDuration)

			if var_14_19 + 0.3 <= arg_11_1.time_ and arg_11_1.time_ < var_14_25 + var_14_26 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_25) / var_14_26

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_25 + var_14_26 and arg_11_1.time_ < var_14_25 + var_14_26 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play319651004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319651004
		arg_17_1.duration_ = 14.43

		local var_17_0 = {
			zh = 8.5,
			ja = 14.433
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
				arg_17_0:Play319651005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["10058ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10058ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "10058ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "10058ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["10058ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["10058ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["10058ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["10058ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["10058ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10058ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["10058ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect10058ui_story == nil then
				arg_17_1.var_.characterEffect10058ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect10058ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect10058ui_story then
				arg_17_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_8 = 0
			local var_20_9 = 1.025

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(319651004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 41 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 41)

				if (41 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 41)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651004", "story_v_out_319651.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_319651", "319651004", "story_v_out_319651.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_out_319651", "319651004", "story_v_out_319651.awb")

						arg_17_1:RecordAudio("319651004", var_20_15)
						arg_17_1:RecordAudio("319651004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319651", "319651004", "story_v_out_319651.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319651", "319651004", "story_v_out_319651.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_16 and arg_17_1.time_ < var_20_8 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play319651005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319651005
		arg_21_1.duration_ = 7.4

		local var_21_0 = {
			zh = 2.9,
			ja = 7.4
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
				arg_21_0:Play319651006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_21_1.stage_.transform)

				var_24_0.name = "1084ui_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1084ui_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["1084ui_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["1084ui_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_3 = arg_21_1.actors_["1084ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1084ui_story = var_24_3.localPosition
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_21_1.time_ - 0) / var_24_4)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			local var_24_5 = arg_21_1.actors_["1084ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1084ui_story == nil then
				arg_21_1.var_.characterEffect1084ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_6 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.characterEffect1084ui_story and not isNil(var_24_5) then
					arg_21_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1084ui_story then
				arg_21_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_8 = arg_21_1.actors_["10058ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10058ui_story = var_24_8.localPosition
			end

			local var_24_9 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_9 then
				var_24_8.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10058ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_21_1.time_ - 0) / var_24_9)
				var_24_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_8.position).x, (manager.ui.mainCamera.transform.position - var_24_8.position).y, (manager.ui.mainCamera.transform.position - var_24_8.position).z)
				var_24_8.localEulerAngles.z = 0
				var_24_8.localEulerAngles.x = 0
				var_24_8.localEulerAngles = var_24_8.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_9 and arg_21_1.time_ < 0 + var_24_9 + arg_24_0 then
				var_24_8.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				var_24_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_8.position).x, (manager.ui.mainCamera.transform.position - var_24_8.position).y, (manager.ui.mainCamera.transform.position - var_24_8.position).z)
				var_24_8.localEulerAngles.z = 0
				var_24_8.localEulerAngles.x = 0
				var_24_8.localEulerAngles = var_24_8.localEulerAngles
			end

			local var_24_10 = arg_21_1.actors_["10058ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_10) and arg_21_1.var_.characterEffect10058ui_story == nil then
				arg_21_1.var_.characterEffect10058ui_story = var_24_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_11 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_11 and not isNil(var_24_10) then
				if arg_21_1.var_.characterEffect10058ui_story and not isNil(var_24_10) then
					arg_21_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_11)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_11 and arg_21_1.time_ < 0 + var_24_11 + arg_24_0 and not isNil(var_24_10) and arg_21_1.var_.characterEffect10058ui_story then
				arg_21_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_24_12 = 0
			local var_24_13 = 0.275

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_14 = arg_21_1:GetWordFromCfg(319651005)
				local var_24_15 = arg_21_1:FormatText(var_24_14.content)

				arg_21_1.text_.text = var_24_15

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_17 = 11 <= 0 and var_24_13 or var_24_13 * (utf8.len(var_24_15) / 11)

				if (11 <= 0 and var_24_13 or var_24_13 * (utf8.len(var_24_15) / 11)) > 0 and var_24_13 < var_24_17 then
					arg_21_1.talkMaxDuration = var_24_17

					if var_24_17 + var_24_12 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_17 + var_24_12
					end
				end

				arg_21_1.text_.text = var_24_15
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651005", "story_v_out_319651.awb") ~= 0 then
					local var_24_18 = manager.audio:GetVoiceLength("story_v_out_319651", "319651005", "story_v_out_319651.awb") / 1000

					if var_24_18 + var_24_12 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_18 + var_24_12
					end

					if var_24_14.prefab_name ~= "" and arg_21_1.actors_[var_24_14.prefab_name] ~= nil then
						local var_24_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_14.prefab_name].transform, "story_v_out_319651", "319651005", "story_v_out_319651.awb")

						arg_21_1:RecordAudio("319651005", var_24_19)
						arg_21_1:RecordAudio("319651005", var_24_19)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319651", "319651005", "story_v_out_319651.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319651", "319651005", "story_v_out_319651.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_20 = math.max(var_24_13, arg_21_1.talkMaxDuration)

			if var_24_12 <= arg_21_1.time_ and arg_21_1.time_ < var_24_12 + var_24_20 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_12) / var_24_20

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_12 + var_24_20 and arg_21_1.time_ < var_24_12 + var_24_20 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play319651006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319651006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play319651007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1084ui_story"]) and arg_25_1.var_.characterEffect1084ui_story == nil then
				arg_25_1.var_.characterEffect1084ui_story = arg_25_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1084ui_story"]) then
				if arg_25_1.var_.characterEffect1084ui_story and not isNil(arg_25_1.actors_["1084ui_story"]) then
					arg_25_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1084ui_story"]) and arg_25_1.var_.characterEffect1084ui_story then
				arg_25_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 1.2

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(319651006).content)

				arg_25_1.text_.text = var_28_3

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 48 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 48)

				if (48 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_3) / 48)) > 0 and var_28_2 < var_28_5 then
					arg_25_1.talkMaxDuration = var_28_5

					if var_28_5 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_3
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_6 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_6 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_6

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_6 and arg_25_1.time_ < var_28_1 + var_28_6 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play319651007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319651007
		arg_29_1.duration_ = 6.23

		local var_29_0 = {
			zh = 6.233,
			ja = 3.833
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
				arg_29_0:Play319651008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10058ui_story"]) and arg_29_1.var_.characterEffect10058ui_story == nil then
				arg_29_1.var_.characterEffect10058ui_story = arg_29_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10058ui_story"]) then
				if arg_29_1.var_.characterEffect10058ui_story and not isNil(arg_29_1.actors_["10058ui_story"]) then
					arg_29_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10058ui_story"]) and arg_29_1.var_.characterEffect10058ui_story then
				arg_29_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_32_2 = 0
			local var_32_3 = 0.55

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:GetWordFromCfg(319651007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 22 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 22)

				if (22 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 22)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651007", "story_v_out_319651.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_319651", "319651007", "story_v_out_319651.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_out_319651", "319651007", "story_v_out_319651.awb")

						arg_29_1:RecordAudio("319651007", var_32_9)
						arg_29_1:RecordAudio("319651007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_319651", "319651007", "story_v_out_319651.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_319651", "319651007", "story_v_out_319651.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_3, arg_29_1.talkMaxDuration)

			if var_32_2 <= arg_29_1.time_ and arg_29_1.time_ < var_32_2 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_2) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_2 + var_32_10 and arg_29_1.time_ < var_32_2 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play319651008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319651008
		arg_33_1.duration_ = 9.3

		local var_33_0 = {
			zh = 9.3,
			ja = 9.133
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
				arg_33_0:Play319651009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 1.125

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:GetWordFromCfg(319651008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 45 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 45)

				if (45 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 45)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651008", "story_v_out_319651.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_319651", "319651008", "story_v_out_319651.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_319651", "319651008", "story_v_out_319651.awb")

						arg_33_1:RecordAudio("319651008", var_36_6)
						arg_33_1:RecordAudio("319651008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_319651", "319651008", "story_v_out_319651.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_319651", "319651008", "story_v_out_319651.awb")
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
	Play319651009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319651009
		arg_37_1.duration_ = 9.2

		local var_37_0 = {
			zh = 9.2,
			ja = 8.466
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
				arg_37_0:Play319651010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10058ui_story = arg_37_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10058ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10058ui_story"].transform.position).z)
				arg_37_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10058ui_story"].transform.localEulerAngles = arg_37_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_37_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10058ui_story"].transform.position).z)
				arg_37_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10058ui_story"].transform.localEulerAngles = arg_37_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_1 = 0
			local var_40_2 = 1.05

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(319651009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 42 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 42)

				if (42 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_4) / 42)) > 0 and var_40_2 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651009", "story_v_out_319651.awb") ~= 0 then
					local var_40_7 = manager.audio:GetVoiceLength("story_v_out_319651", "319651009", "story_v_out_319651.awb") / 1000

					if var_40_7 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_1
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_319651", "319651009", "story_v_out_319651.awb")

						arg_37_1:RecordAudio("319651009", var_40_8)
						arg_37_1:RecordAudio("319651009", var_40_8)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_319651", "319651009", "story_v_out_319651.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_319651", "319651009", "story_v_out_319651.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_9 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_9 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_9

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_9 and arg_37_1.time_ < var_40_1 + var_40_9 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play319651010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319651010
		arg_41_1.duration_ = 5.03

		local var_41_0 = {
			zh = 4.333,
			ja = 5.033
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
				arg_41_0:Play319651011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1084ui_story = arg_41_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1084ui_story"].transform.position).z)
				arg_41_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1084ui_story"].transform.localEulerAngles = arg_41_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_41_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1084ui_story"].transform.position).z)
				arg_41_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1084ui_story"].transform.localEulerAngles = arg_41_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1084ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1084ui_story == nil then
				arg_41_1.var_.characterEffect1084ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1084ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1084ui_story then
				arg_41_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_4 = arg_41_1.actors_["10058ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect10058ui_story == nil then
				arg_41_1.var_.characterEffect10058ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_5 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_5 and not isNil(var_44_4) then
				if arg_41_1.var_.characterEffect10058ui_story and not isNil(var_44_4) then
					arg_41_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_5)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_5 and arg_41_1.time_ < 0 + var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect10058ui_story then
				arg_41_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_44_6 = 0
			local var_44_7 = 0.45

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_8 = arg_41_1:GetWordFromCfg(319651010)
				local var_44_9 = arg_41_1:FormatText(var_44_8.content)

				arg_41_1.text_.text = var_44_9

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 18 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 18)

				if (18 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 18)) > 0 and var_44_7 < var_44_11 then
					arg_41_1.talkMaxDuration = var_44_11

					if var_44_11 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_9
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651010", "story_v_out_319651.awb") ~= 0 then
					local var_44_12 = manager.audio:GetVoiceLength("story_v_out_319651", "319651010", "story_v_out_319651.awb") / 1000

					if var_44_12 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_6
					end

					if var_44_8.prefab_name ~= "" and arg_41_1.actors_[var_44_8.prefab_name] ~= nil then
						local var_44_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_8.prefab_name].transform, "story_v_out_319651", "319651010", "story_v_out_319651.awb")

						arg_41_1:RecordAudio("319651010", var_44_13)
						arg_41_1:RecordAudio("319651010", var_44_13)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_319651", "319651010", "story_v_out_319651.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_319651", "319651010", "story_v_out_319651.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play319651011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319651011
		arg_45_1.duration_ = 4.5

		local var_45_0 = {
			zh = 4.5,
			ja = 2.933
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
				arg_45_0:Play319651012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_48_0 = 0
			local var_48_1 = 0.6

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_2 = arg_45_1:GetWordFromCfg(319651011)
				local var_48_3 = arg_45_1:FormatText(var_48_2.content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 24 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 24)

				if (24 <= 0 and var_48_1 or var_48_1 * (utf8.len(var_48_3) / 24)) > 0 and var_48_1 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651011", "story_v_out_319651.awb") ~= 0 then
					local var_48_6 = manager.audio:GetVoiceLength("story_v_out_319651", "319651011", "story_v_out_319651.awb") / 1000

					if var_48_6 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_0
					end

					if var_48_2.prefab_name ~= "" and arg_45_1.actors_[var_48_2.prefab_name] ~= nil then
						local var_48_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_2.prefab_name].transform, "story_v_out_319651", "319651011", "story_v_out_319651.awb")

						arg_45_1:RecordAudio("319651011", var_48_7)
						arg_45_1:RecordAudio("319651011", var_48_7)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_319651", "319651011", "story_v_out_319651.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_319651", "319651011", "story_v_out_319651.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_8 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_8 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_8

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_8 and arg_45_1.time_ < var_48_0 + var_48_8 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play319651012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319651012
		arg_49_1.duration_ = 5.47

		local var_49_0 = {
			zh = 3.333,
			ja = 5.466
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
				arg_49_0:Play319651013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["10058ui_story"]) and arg_49_1.var_.characterEffect10058ui_story == nil then
				arg_49_1.var_.characterEffect10058ui_story = arg_49_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["10058ui_story"]) then
				if arg_49_1.var_.characterEffect10058ui_story and not isNil(arg_49_1.actors_["10058ui_story"]) then
					arg_49_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["10058ui_story"]) and arg_49_1.var_.characterEffect10058ui_story then
				arg_49_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_52_2 = arg_49_1.actors_["1084ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1084ui_story == nil then
				arg_49_1.var_.characterEffect1084ui_story = var_52_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_3 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_3 and not isNil(var_52_2) then
				if arg_49_1.var_.characterEffect1084ui_story and not isNil(var_52_2) then
					arg_49_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_3)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_3 and arg_49_1.time_ < 0 + var_52_3 + arg_52_0 and not isNil(var_52_2) and arg_49_1.var_.characterEffect1084ui_story then
				arg_49_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			local var_52_4 = 0
			local var_52_5 = 0.425

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(319651012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 17 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 17)

				if (17 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 17)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651012", "story_v_out_319651.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_319651", "319651012", "story_v_out_319651.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_319651", "319651012", "story_v_out_319651.awb")

						arg_49_1:RecordAudio("319651012", var_52_11)
						arg_49_1:RecordAudio("319651012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_319651", "319651012", "story_v_out_319651.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_319651", "319651012", "story_v_out_319651.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_12 and arg_49_1.time_ < var_52_4 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play319651013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319651013
		arg_53_1.duration_ = 8.37

		local var_53_0 = {
			zh = 3.966,
			ja = 8.366
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
				arg_53_0:Play319651014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.45

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(319651013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 18 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 18)

				if (18 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 18)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651013", "story_v_out_319651.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_319651", "319651013", "story_v_out_319651.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_319651", "319651013", "story_v_out_319651.awb")

						arg_53_1:RecordAudio("319651013", var_56_6)
						arg_53_1:RecordAudio("319651013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_319651", "319651013", "story_v_out_319651.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_319651", "319651013", "story_v_out_319651.awb")
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
	Play319651014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319651014
		arg_57_1.duration_ = 5.73

		local var_57_0 = {
			zh = 5.466,
			ja = 5.733
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
				arg_57_0:Play319651015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_60_0 = arg_57_1.actors_["10058ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect10058ui_story == nil then
				arg_57_1.var_.characterEffect10058ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_1 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 and not isNil(var_60_0) then
				if arg_57_1.var_.characterEffect10058ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_57_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_1)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect10058ui_story then
				arg_57_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_57_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_60_2 = arg_57_1.actors_["1084ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1084ui_story == nil then
				arg_57_1.var_.characterEffect1084ui_story = var_60_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_3 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.characterEffect1084ui_story and not isNil(var_60_2) then
					arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1084ui_story then
				arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_60_5 = 0
			local var_60_6 = 0.55

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_7 = arg_57_1:GetWordFromCfg(319651014)
				local var_60_8 = arg_57_1:FormatText(var_60_7.content)

				arg_57_1.text_.text = var_60_8

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 22 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 22)

				if (22 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 22)) > 0 and var_60_6 < var_60_10 then
					arg_57_1.talkMaxDuration = var_60_10

					if var_60_10 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_5
					end
				end

				arg_57_1.text_.text = var_60_8
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651014", "story_v_out_319651.awb") ~= 0 then
					local var_60_11 = manager.audio:GetVoiceLength("story_v_out_319651", "319651014", "story_v_out_319651.awb") / 1000

					if var_60_11 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_5
					end

					if var_60_7.prefab_name ~= "" and arg_57_1.actors_[var_60_7.prefab_name] ~= nil then
						local var_60_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_7.prefab_name].transform, "story_v_out_319651", "319651014", "story_v_out_319651.awb")

						arg_57_1:RecordAudio("319651014", var_60_12)
						arg_57_1:RecordAudio("319651014", var_60_12)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_319651", "319651014", "story_v_out_319651.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_319651", "319651014", "story_v_out_319651.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_13 = math.max(var_60_6, arg_57_1.talkMaxDuration)

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_13 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_5) / var_60_13

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_5 + var_60_13 and arg_57_1.time_ < var_60_5 + var_60_13 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play319651015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319651015
		arg_61_1.duration_ = 7.37

		local var_61_0 = {
			zh = 7.366,
			ja = 4.033
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
				arg_61_0:Play319651016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1084ui_story = arg_61_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1084ui_story"].transform.position).z)
				arg_61_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1084ui_story"].transform.localEulerAngles = arg_61_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_61_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1084ui_story"].transform.position).z)
				arg_61_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1084ui_story"].transform.localEulerAngles = arg_61_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_1 = 0
			local var_64_2 = 0.875

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(319651015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 35 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 35)

				if (35 <= 0 and var_64_2 or var_64_2 * (utf8.len(var_64_4) / 35)) > 0 and var_64_2 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_1
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651015", "story_v_out_319651.awb") ~= 0 then
					local var_64_7 = manager.audio:GetVoiceLength("story_v_out_319651", "319651015", "story_v_out_319651.awb") / 1000

					if var_64_7 + var_64_1 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_1
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_319651", "319651015", "story_v_out_319651.awb")

						arg_61_1:RecordAudio("319651015", var_64_8)
						arg_61_1:RecordAudio("319651015", var_64_8)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_319651", "319651015", "story_v_out_319651.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_319651", "319651015", "story_v_out_319651.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_9 = math.max(var_64_2, arg_61_1.talkMaxDuration)

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_9 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_1) / var_64_9

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_1 + var_64_9 and arg_61_1.time_ < var_64_1 + var_64_9 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play319651016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319651016
		arg_65_1.duration_ = 2.23

		local var_65_0 = {
			zh = 1.999999999999,
			ja = 2.233
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
				arg_65_0:Play319651017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10058ui_story = arg_65_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10058ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10058ui_story"].transform.position).z)
				arg_65_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10058ui_story"].transform.localEulerAngles = arg_65_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_65_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["10058ui_story"].transform.position).z)
				arg_65_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["10058ui_story"].transform.localEulerAngles = arg_65_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["10058ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect10058ui_story == nil then
				arg_65_1.var_.characterEffect10058ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect10058ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect10058ui_story then
				arg_65_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_68_4 = arg_65_1.actors_["1084ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1084ui_story == nil then
				arg_65_1.var_.characterEffect1084ui_story = var_68_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_5 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_5 and not isNil(var_68_4) then
				if arg_65_1.var_.characterEffect1084ui_story and not isNil(var_68_4) then
					arg_65_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_5)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_5 and arg_65_1.time_ < 0 + var_68_5 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect1084ui_story then
				arg_65_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_68_6 = 0
			local var_68_7 = 0.125

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_8 = arg_65_1:GetWordFromCfg(319651016)
				local var_68_9 = arg_65_1:FormatText(var_68_8.content)

				arg_65_1.text_.text = var_68_9

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 5 <= 0 and var_68_7 or var_68_7 * (utf8.len(var_68_9) / 5)

				if (5 <= 0 and var_68_7 or var_68_7 * (utf8.len(var_68_9) / 5)) > 0 and var_68_7 < var_68_11 then
					arg_65_1.talkMaxDuration = var_68_11

					if var_68_11 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_9
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651016", "story_v_out_319651.awb") ~= 0 then
					local var_68_12 = manager.audio:GetVoiceLength("story_v_out_319651", "319651016", "story_v_out_319651.awb") / 1000

					if var_68_12 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_12 + var_68_6
					end

					if var_68_8.prefab_name ~= "" and arg_65_1.actors_[var_68_8.prefab_name] ~= nil then
						local var_68_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_8.prefab_name].transform, "story_v_out_319651", "319651016", "story_v_out_319651.awb")

						arg_65_1:RecordAudio("319651016", var_68_13)
						arg_65_1:RecordAudio("319651016", var_68_13)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319651", "319651016", "story_v_out_319651.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319651", "319651016", "story_v_out_319651.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_14 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_14 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_14

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_14 and arg_65_1.time_ < var_68_6 + var_68_14 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play319651017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319651017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play319651018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["10058ui_story"]) and arg_69_1.var_.characterEffect10058ui_story == nil then
				arg_69_1.var_.characterEffect10058ui_story = arg_69_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["10058ui_story"]) then
				if arg_69_1.var_.characterEffect10058ui_story and not isNil(arg_69_1.actors_["10058ui_story"]) then
					arg_69_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["10058ui_story"]) and arg_69_1.var_.characterEffect10058ui_story then
				arg_69_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 1.025

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(319651017).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 41 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 41)

				if (41 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 41)) > 0 and var_72_2 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_6 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_6 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_6

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_6 and arg_69_1.time_ < var_72_1 + var_72_6 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play319651018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319651018
		arg_73_1.duration_ = 3.53

		local var_73_0 = {
			zh = 1.999999999999,
			ja = 3.533
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
				arg_73_0:Play319651019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_76_0 = arg_73_1.actors_["10058ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect10058ui_story == nil then
				arg_73_1.var_.characterEffect10058ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_1 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 and not isNil(var_76_0) then
				if arg_73_1.var_.characterEffect10058ui_story and not isNil(var_76_0) then
					arg_73_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect10058ui_story then
				arg_73_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_76_3 = 0
			local var_76_4 = 0.25

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_3 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_5 = arg_73_1:GetWordFromCfg(319651018)
				local var_76_6 = arg_73_1:FormatText(var_76_5.content)

				arg_73_1.text_.text = var_76_6

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_8 = 10 <= 0 and var_76_4 or var_76_4 * (utf8.len(var_76_6) / 10)

				if (10 <= 0 and var_76_4 or var_76_4 * (utf8.len(var_76_6) / 10)) > 0 and var_76_4 < var_76_8 then
					arg_73_1.talkMaxDuration = var_76_8

					if var_76_8 + var_76_3 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_3
					end
				end

				arg_73_1.text_.text = var_76_6
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651018", "story_v_out_319651.awb") ~= 0 then
					local var_76_9 = manager.audio:GetVoiceLength("story_v_out_319651", "319651018", "story_v_out_319651.awb") / 1000

					if var_76_9 + var_76_3 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_9 + var_76_3
					end

					if var_76_5.prefab_name ~= "" and arg_73_1.actors_[var_76_5.prefab_name] ~= nil then
						local var_76_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_5.prefab_name].transform, "story_v_out_319651", "319651018", "story_v_out_319651.awb")

						arg_73_1:RecordAudio("319651018", var_76_10)
						arg_73_1:RecordAudio("319651018", var_76_10)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_319651", "319651018", "story_v_out_319651.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_319651", "319651018", "story_v_out_319651.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_11 = math.max(var_76_4, arg_73_1.talkMaxDuration)

			if var_76_3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_3 + var_76_11 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_3) / var_76_11

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_3 + var_76_11 and arg_73_1.time_ < var_76_3 + var_76_11 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play319651019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319651019
		arg_77_1.duration_ = 9.87

		local var_77_0 = {
			zh = 8.266,
			ja = 9.866
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
				arg_77_0:Play319651020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_80_0 = 0
			local var_80_1 = 0.75

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_2 = arg_77_1:GetWordFromCfg(319651019)
				local var_80_3 = arg_77_1:FormatText(var_80_2.content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 30 <= 0 and var_80_1 or var_80_1 * (utf8.len(var_80_3) / 30)

				if (30 <= 0 and var_80_1 or var_80_1 * (utf8.len(var_80_3) / 30)) > 0 and var_80_1 < var_80_5 then
					arg_77_1.talkMaxDuration = var_80_5

					if var_80_5 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651019", "story_v_out_319651.awb") ~= 0 then
					local var_80_6 = manager.audio:GetVoiceLength("story_v_out_319651", "319651019", "story_v_out_319651.awb") / 1000

					if var_80_6 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_0
					end

					if var_80_2.prefab_name ~= "" and arg_77_1.actors_[var_80_2.prefab_name] ~= nil then
						local var_80_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_2.prefab_name].transform, "story_v_out_319651", "319651019", "story_v_out_319651.awb")

						arg_77_1:RecordAudio("319651019", var_80_7)
						arg_77_1:RecordAudio("319651019", var_80_7)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_319651", "319651019", "story_v_out_319651.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_319651", "319651019", "story_v_out_319651.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_8 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_8 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_8

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_8 and arg_77_1.time_ < var_80_0 + var_80_8 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play319651020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319651020
		arg_81_1.duration_ = 6.7

		local var_81_0 = {
			zh = 2.7,
			ja = 6.7
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
				arg_81_0:Play319651021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1084ui_story = arg_81_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1084ui_story"].transform.position).z)
				arg_81_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1084ui_story"].transform.localEulerAngles = arg_81_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_81_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1084ui_story"].transform.position).z)
				arg_81_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1084ui_story"].transform.localEulerAngles = arg_81_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["1084ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1084ui_story == nil then
				arg_81_1.var_.characterEffect1084ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1084ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1084ui_story then
				arg_81_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4137")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_4 = arg_81_1.actors_["10058ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect10058ui_story == nil then
				arg_81_1.var_.characterEffect10058ui_story = var_84_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_5 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_5 and not isNil(var_84_4) then
				if arg_81_1.var_.characterEffect10058ui_story and not isNil(var_84_4) then
					arg_81_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_5)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_5 and arg_81_1.time_ < 0 + var_84_5 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect10058ui_story then
				arg_81_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_84_6 = 0
			local var_84_7 = 0.35

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_8 = arg_81_1:GetWordFromCfg(319651020)
				local var_84_9 = arg_81_1:FormatText(var_84_8.content)

				arg_81_1.text_.text = var_84_9

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_11 = 14 <= 0 and var_84_7 or var_84_7 * (utf8.len(var_84_9) / 14)

				if (14 <= 0 and var_84_7 or var_84_7 * (utf8.len(var_84_9) / 14)) > 0 and var_84_7 < var_84_11 then
					arg_81_1.talkMaxDuration = var_84_11

					if var_84_11 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_11 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_9
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651020", "story_v_out_319651.awb") ~= 0 then
					local var_84_12 = manager.audio:GetVoiceLength("story_v_out_319651", "319651020", "story_v_out_319651.awb") / 1000

					if var_84_12 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_12 + var_84_6
					end

					if var_84_8.prefab_name ~= "" and arg_81_1.actors_[var_84_8.prefab_name] ~= nil then
						local var_84_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_8.prefab_name].transform, "story_v_out_319651", "319651020", "story_v_out_319651.awb")

						arg_81_1:RecordAudio("319651020", var_84_13)
						arg_81_1:RecordAudio("319651020", var_84_13)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_319651", "319651020", "story_v_out_319651.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_319651", "319651020", "story_v_out_319651.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_14 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_14 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_14

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_14 and arg_81_1.time_ < var_84_6 + var_84_14 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play319651021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319651021
		arg_85_1.duration_ = 4.67

		local var_85_0 = {
			zh = 2.566,
			ja = 4.666
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
				arg_85_0:Play319651022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos10058ui_story = arg_85_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10058ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10058ui_story"].transform.position).z)
				arg_85_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10058ui_story"].transform.localEulerAngles = arg_85_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_85_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["10058ui_story"].transform.position).z)
				arg_85_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["10058ui_story"].transform.localEulerAngles = arg_85_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["10058ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect10058ui_story == nil then
				arg_85_1.var_.characterEffect10058ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect10058ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect10058ui_story then
				arg_85_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_88_4 = arg_85_1.actors_["1084ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_4) and arg_85_1.var_.characterEffect1084ui_story == nil then
				arg_85_1.var_.characterEffect1084ui_story = var_88_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_5 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_5 and not isNil(var_88_4) then
				if arg_85_1.var_.characterEffect1084ui_story and not isNil(var_88_4) then
					arg_85_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_5)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_5 and arg_85_1.time_ < 0 + var_88_5 + arg_88_0 and not isNil(var_88_4) and arg_85_1.var_.characterEffect1084ui_story then
				arg_85_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_88_6 = 0
			local var_88_7 = 0.325

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_8 = arg_85_1:GetWordFromCfg(319651021)
				local var_88_9 = arg_85_1:FormatText(var_88_8.content)

				arg_85_1.text_.text = var_88_9

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 13 <= 0 and var_88_7 or var_88_7 * (utf8.len(var_88_9) / 13)

				if (13 <= 0 and var_88_7 or var_88_7 * (utf8.len(var_88_9) / 13)) > 0 and var_88_7 < var_88_11 then
					arg_85_1.talkMaxDuration = var_88_11

					if var_88_11 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_9
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651021", "story_v_out_319651.awb") ~= 0 then
					local var_88_12 = manager.audio:GetVoiceLength("story_v_out_319651", "319651021", "story_v_out_319651.awb") / 1000

					if var_88_12 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_12 + var_88_6
					end

					if var_88_8.prefab_name ~= "" and arg_85_1.actors_[var_88_8.prefab_name] ~= nil then
						local var_88_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_8.prefab_name].transform, "story_v_out_319651", "319651021", "story_v_out_319651.awb")

						arg_85_1:RecordAudio("319651021", var_88_13)
						arg_85_1:RecordAudio("319651021", var_88_13)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_319651", "319651021", "story_v_out_319651.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_319651", "319651021", "story_v_out_319651.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_14 and arg_85_1.time_ < var_88_6 + var_88_14 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play319651022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319651022
		arg_89_1.duration_ = 6.77

		local var_89_0 = {
			zh = 5.733,
			ja = 6.766
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
				arg_89_0:Play319651023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.6

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:GetWordFromCfg(319651022)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 24 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 24)

				if (24 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 24)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651022", "story_v_out_319651.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_319651", "319651022", "story_v_out_319651.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_319651", "319651022", "story_v_out_319651.awb")

						arg_89_1:RecordAudio("319651022", var_92_6)
						arg_89_1:RecordAudio("319651022", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_319651", "319651022", "story_v_out_319651.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_319651", "319651022", "story_v_out_319651.awb")
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
	Play319651023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319651023
		arg_93_1.duration_ = 1.5

		local var_93_0 = {
			zh = 1,
			ja = 1.5
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
				arg_93_0:Play319651024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["10058ui_story"]) and arg_93_1.var_.characterEffect10058ui_story == nil then
				arg_93_1.var_.characterEffect10058ui_story = arg_93_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["10058ui_story"]) then
				if arg_93_1.var_.characterEffect10058ui_story and not isNil(arg_93_1.actors_["10058ui_story"]) then
					arg_93_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["10058ui_story"]) and arg_93_1.var_.characterEffect10058ui_story then
				arg_93_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_96_1 = arg_93_1.actors_["1084ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1084ui_story == nil then
				arg_93_1.var_.characterEffect1084ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect1084ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1084ui_story then
				arg_93_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_96_4 = 0
			local var_96_5 = 0.05

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(319651023)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 2 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 2)

				if (2 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 2)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651023", "story_v_out_319651.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_319651", "319651023", "story_v_out_319651.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_out_319651", "319651023", "story_v_out_319651.awb")

						arg_93_1:RecordAudio("319651023", var_96_11)
						arg_93_1:RecordAudio("319651023", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_319651", "319651023", "story_v_out_319651.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_319651", "319651023", "story_v_out_319651.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_5, arg_93_1.talkMaxDuration)

			if var_96_4 <= arg_93_1.time_ and arg_93_1.time_ < var_96_4 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_4) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_4 + var_96_12 and arg_93_1.time_ < var_96_4 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play319651024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319651024
		arg_97_1.duration_ = 16.9

		local var_97_0 = {
			zh = 11.066,
			ja = 16.9
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
				arg_97_0:Play319651025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10058ui_story = arg_97_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10058ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10058ui_story"].transform.position).z)
				arg_97_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10058ui_story"].transform.localEulerAngles = arg_97_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_97_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10058ui_story"].transform.position).z)
				arg_97_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10058ui_story"].transform.localEulerAngles = arg_97_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["10058ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10058ui_story == nil then
				arg_97_1.var_.characterEffect10058ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect10058ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect10058ui_story then
				arg_97_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_100_4 = arg_97_1.actors_["1084ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.characterEffect1084ui_story == nil then
				arg_97_1.var_.characterEffect1084ui_story = var_100_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_5 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_5 and not isNil(var_100_4) then
				if arg_97_1.var_.characterEffect1084ui_story and not isNil(var_100_4) then
					arg_97_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_5)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_5 and arg_97_1.time_ < 0 + var_100_5 + arg_100_0 and not isNil(var_100_4) and arg_97_1.var_.characterEffect1084ui_story then
				arg_97_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_100_6 = 0
			local var_100_7 = 1.175

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_8 = arg_97_1:GetWordFromCfg(319651024)
				local var_100_9 = arg_97_1:FormatText(var_100_8.content)

				arg_97_1.text_.text = var_100_9

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 47 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_9) / 47)

				if (47 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_9) / 47)) > 0 and var_100_7 < var_100_11 then
					arg_97_1.talkMaxDuration = var_100_11

					if var_100_11 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_11 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_9
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651024", "story_v_out_319651.awb") ~= 0 then
					local var_100_12 = manager.audio:GetVoiceLength("story_v_out_319651", "319651024", "story_v_out_319651.awb") / 1000

					if var_100_12 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_12 + var_100_6
					end

					if var_100_8.prefab_name ~= "" and arg_97_1.actors_[var_100_8.prefab_name] ~= nil then
						local var_100_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_8.prefab_name].transform, "story_v_out_319651", "319651024", "story_v_out_319651.awb")

						arg_97_1:RecordAudio("319651024", var_100_13)
						arg_97_1:RecordAudio("319651024", var_100_13)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_319651", "319651024", "story_v_out_319651.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_319651", "319651024", "story_v_out_319651.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_14 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_14 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_14

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_14 and arg_97_1.time_ < var_100_6 + var_100_14 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play319651025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319651025
		arg_101_1.duration_ = 10.63

		local var_101_0 = {
			zh = 10.633,
			ja = 9.566
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
				arg_101_0:Play319651026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 1.15

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_1 = arg_101_1:GetWordFromCfg(319651025)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 46 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 46)

				if (46 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 46)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651025", "story_v_out_319651.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_319651", "319651025", "story_v_out_319651.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_319651", "319651025", "story_v_out_319651.awb")

						arg_101_1:RecordAudio("319651025", var_104_6)
						arg_101_1:RecordAudio("319651025", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_319651", "319651025", "story_v_out_319651.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_319651", "319651025", "story_v_out_319651.awb")
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
	Play319651026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 319651026
		arg_105_1.duration_ = 10.57

		local var_105_0 = {
			zh = 7.7,
			ja = 10.566
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
				arg_105_0:Play319651027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.85

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:GetWordFromCfg(319651026)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 34 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 34)

				if (34 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 34)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651026", "story_v_out_319651.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_319651", "319651026", "story_v_out_319651.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_319651", "319651026", "story_v_out_319651.awb")

						arg_105_1:RecordAudio("319651026", var_108_6)
						arg_105_1:RecordAudio("319651026", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_319651", "319651026", "story_v_out_319651.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_319651", "319651026", "story_v_out_319651.awb")
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
	Play319651027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 319651027
		arg_109_1.duration_ = 3.27

		local var_109_0 = {
			zh = 2.3,
			ja = 3.266
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
				arg_109_0:Play319651028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10058ui_story"]) and arg_109_1.var_.characterEffect10058ui_story == nil then
				arg_109_1.var_.characterEffect10058ui_story = arg_109_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["10058ui_story"]) then
				if arg_109_1.var_.characterEffect10058ui_story and not isNil(arg_109_1.actors_["10058ui_story"]) then
					arg_109_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["10058ui_story"]) and arg_109_1.var_.characterEffect10058ui_story then
				arg_109_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_112_1 = arg_109_1.actors_["1084ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1084ui_story == nil then
				arg_109_1.var_.characterEffect1084ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1084ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1084ui_story then
				arg_109_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_4 = 0
			local var_112_5 = 0.225

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(319651027)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 9 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 9)

				if (9 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 9)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651027", "story_v_out_319651.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_319651", "319651027", "story_v_out_319651.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_out_319651", "319651027", "story_v_out_319651.awb")

						arg_109_1:RecordAudio("319651027", var_112_11)
						arg_109_1:RecordAudio("319651027", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_319651", "319651027", "story_v_out_319651.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_319651", "319651027", "story_v_out_319651.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_12 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_12

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_12 and arg_109_1.time_ < var_112_4 + var_112_12 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play319651028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 319651028
		arg_113_1.duration_ = 9.37

		local var_113_0 = {
			zh = 7.4,
			ja = 9.366
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
				arg_113_0:Play319651029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["10058ui_story"]) and arg_113_1.var_.characterEffect10058ui_story == nil then
				arg_113_1.var_.characterEffect10058ui_story = arg_113_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["10058ui_story"]) then
				if arg_113_1.var_.characterEffect10058ui_story and not isNil(arg_113_1.actors_["10058ui_story"]) then
					arg_113_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["10058ui_story"]) and arg_113_1.var_.characterEffect10058ui_story then
				arg_113_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_116_2 = arg_113_1.actors_["1084ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.characterEffect1084ui_story == nil then
				arg_113_1.var_.characterEffect1084ui_story = var_116_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_3 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 and not isNil(var_116_2) then
				if arg_113_1.var_.characterEffect1084ui_story and not isNil(var_116_2) then
					arg_113_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_3)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.characterEffect1084ui_story then
				arg_113_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_116_4 = 0
			local var_116_5 = 0.8

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(319651028)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 32 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 32)

				if (32 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 32)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651028", "story_v_out_319651.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_out_319651", "319651028", "story_v_out_319651.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_out_319651", "319651028", "story_v_out_319651.awb")

						arg_113_1:RecordAudio("319651028", var_116_11)
						arg_113_1:RecordAudio("319651028", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_319651", "319651028", "story_v_out_319651.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_319651", "319651028", "story_v_out_319651.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_12 = math.max(var_116_5, arg_113_1.talkMaxDuration)

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_12 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_4) / var_116_12

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_4 + var_116_12 and arg_113_1.time_ < var_116_4 + var_116_12 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play319651029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 319651029
		arg_117_1.duration_ = 11.5

		local var_117_0 = {
			zh = 7.166,
			ja = 11.5
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
				arg_117_0:Play319651030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.95

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:GetWordFromCfg(319651029)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 38 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 38)

				if (38 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 38)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651029", "story_v_out_319651.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_319651", "319651029", "story_v_out_319651.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_319651", "319651029", "story_v_out_319651.awb")

						arg_117_1:RecordAudio("319651029", var_120_6)
						arg_117_1:RecordAudio("319651029", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_319651", "319651029", "story_v_out_319651.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_319651", "319651029", "story_v_out_319651.awb")
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
	Play319651030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 319651030
		arg_121_1.duration_ = 2.23

		local var_121_0 = {
			zh = 1.999999999999,
			ja = 2.233
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
				arg_121_0:Play319651031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1084ui_story = arg_121_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1084ui_story"].transform.position).z)
				arg_121_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1084ui_story"].transform.localEulerAngles = arg_121_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_121_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1084ui_story"].transform.position).z)
				arg_121_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1084ui_story"].transform.localEulerAngles = arg_121_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1084ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1084ui_story == nil then
				arg_121_1.var_.characterEffect1084ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1084ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1084ui_story then
				arg_121_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_4 = arg_121_1.actors_["10058ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect10058ui_story == nil then
				arg_121_1.var_.characterEffect10058ui_story = var_124_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_5 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_5 and not isNil(var_124_4) then
				if arg_121_1.var_.characterEffect10058ui_story and not isNil(var_124_4) then
					arg_121_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_5)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_5 and arg_121_1.time_ < 0 + var_124_5 + arg_124_0 and not isNil(var_124_4) and arg_121_1.var_.characterEffect10058ui_story then
				arg_121_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_124_6 = 0
			local var_124_7 = 0.125

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_8 = arg_121_1:GetWordFromCfg(319651030)
				local var_124_9 = arg_121_1:FormatText(var_124_8.content)

				arg_121_1.text_.text = var_124_9

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_11 = 5 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_9) / 5)

				if (5 <= 0 and var_124_7 or var_124_7 * (utf8.len(var_124_9) / 5)) > 0 and var_124_7 < var_124_11 then
					arg_121_1.talkMaxDuration = var_124_11

					if var_124_11 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_11 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_9
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651030", "story_v_out_319651.awb") ~= 0 then
					local var_124_12 = manager.audio:GetVoiceLength("story_v_out_319651", "319651030", "story_v_out_319651.awb") / 1000

					if var_124_12 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_12 + var_124_6
					end

					if var_124_8.prefab_name ~= "" and arg_121_1.actors_[var_124_8.prefab_name] ~= nil then
						local var_124_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_8.prefab_name].transform, "story_v_out_319651", "319651030", "story_v_out_319651.awb")

						arg_121_1:RecordAudio("319651030", var_124_13)
						arg_121_1:RecordAudio("319651030", var_124_13)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_319651", "319651030", "story_v_out_319651.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_319651", "319651030", "story_v_out_319651.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_14 = math.max(var_124_7, arg_121_1.talkMaxDuration)

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_14 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_6) / var_124_14

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_6 + var_124_14 and arg_121_1.time_ < var_124_6 + var_124_14 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play319651031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 319651031
		arg_125_1.duration_ = 8.2

		local var_125_0 = {
			zh = 7.3,
			ja = 8.2
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
				arg_125_0:Play319651032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1084ui_story = arg_125_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1084ui_story"].transform.position).z)
				arg_125_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1084ui_story"].transform.localEulerAngles = arg_125_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1084ui_story"].transform.position).z)
				arg_125_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1084ui_story"].transform.localEulerAngles = arg_125_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["10058ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10058ui_story = var_128_1.localPosition
			end

			local var_128_2 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 then
				var_128_1.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 0) / var_128_2)
				var_128_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_1.position).x, (manager.ui.mainCamera.transform.position - var_128_1.position).y, (manager.ui.mainCamera.transform.position - var_128_1.position).z)
				var_128_1.localEulerAngles.z = 0
				var_128_1.localEulerAngles.x = 0
				var_128_1.localEulerAngles = var_128_1.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 then
				var_128_1.localPosition = Vector3.New(0, 100, 0)
				var_128_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_1.position).x, (manager.ui.mainCamera.transform.position - var_128_1.position).y, (manager.ui.mainCamera.transform.position - var_128_1.position).z)
				var_128_1.localEulerAngles.z = 0
				var_128_1.localEulerAngles.x = 0
				var_128_1.localEulerAngles = var_128_1.localEulerAngles
			end

			local var_128_3 = 0
			local var_128_4 = 0.475

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_3 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_5 = arg_125_1:GetWordFromCfg(319651031)
				local var_128_6 = arg_125_1:FormatText(var_128_5.content)

				arg_125_1.text_.text = var_128_6

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_8 = 19 <= 0 and var_128_4 or var_128_4 * (utf8.len(var_128_6) / 19)

				if (19 <= 0 and var_128_4 or var_128_4 * (utf8.len(var_128_6) / 19)) > 0 and var_128_4 < var_128_8 then
					arg_125_1.talkMaxDuration = var_128_8

					if var_128_8 + var_128_3 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_3
					end
				end

				arg_125_1.text_.text = var_128_6
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651031", "story_v_out_319651.awb") ~= 0 then
					local var_128_9 = manager.audio:GetVoiceLength("story_v_out_319651", "319651031", "story_v_out_319651.awb") / 1000

					if var_128_9 + var_128_3 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_9 + var_128_3
					end

					if var_128_5.prefab_name ~= "" and arg_125_1.actors_[var_128_5.prefab_name] ~= nil then
						local var_128_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_5.prefab_name].transform, "story_v_out_319651", "319651031", "story_v_out_319651.awb")

						arg_125_1:RecordAudio("319651031", var_128_10)
						arg_125_1:RecordAudio("319651031", var_128_10)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_319651", "319651031", "story_v_out_319651.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_319651", "319651031", "story_v_out_319651.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_11 = math.max(var_128_4, arg_125_1.talkMaxDuration)

			if var_128_3 <= arg_125_1.time_ and arg_125_1.time_ < var_128_3 + var_128_11 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_3) / var_128_11

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_3 + var_128_11 and arg_125_1.time_ < var_128_3 + var_128_11 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play319651032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 319651032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play319651033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 1.25

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

				local var_132_1 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(319651032).content)

				arg_129_1.text_.text = var_132_1

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_3 = 50 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 50)

				if (50 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_1) / 50)) > 0 and var_132_0 < var_132_3 then
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
	Play319651033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 319651033
		arg_133_1.duration_ = 3.37

		local var_133_0 = {
			zh = 2.666,
			ja = 3.366
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
				arg_133_0:Play319651034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10058ui_story = arg_133_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10058ui_story"].transform.position).z)
				arg_133_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["10058ui_story"].transform.localEulerAngles = arg_133_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_133_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10058ui_story"].transform.position).z)
				arg_133_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["10058ui_story"].transform.localEulerAngles = arg_133_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["10058ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect10058ui_story == nil then
				arg_133_1.var_.characterEffect10058ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect10058ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect10058ui_story then
				arg_133_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_2")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_136_4 = 0
			local var_136_5 = 0.25

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_6 = arg_133_1:GetWordFromCfg(319651033)
				local var_136_7 = arg_133_1:FormatText(var_136_6.content)

				arg_133_1.text_.text = var_136_7

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_9 = 10 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 10)

				if (10 <= 0 and var_136_5 or var_136_5 * (utf8.len(var_136_7) / 10)) > 0 and var_136_5 < var_136_9 then
					arg_133_1.talkMaxDuration = var_136_9

					if var_136_9 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_9 + var_136_4
					end
				end

				arg_133_1.text_.text = var_136_7
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651033", "story_v_out_319651.awb") ~= 0 then
					local var_136_10 = manager.audio:GetVoiceLength("story_v_out_319651", "319651033", "story_v_out_319651.awb") / 1000

					if var_136_10 + var_136_4 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_4
					end

					if var_136_6.prefab_name ~= "" and arg_133_1.actors_[var_136_6.prefab_name] ~= nil then
						local var_136_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_6.prefab_name].transform, "story_v_out_319651", "319651033", "story_v_out_319651.awb")

						arg_133_1:RecordAudio("319651033", var_136_11)
						arg_133_1:RecordAudio("319651033", var_136_11)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_319651", "319651033", "story_v_out_319651.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_319651", "319651033", "story_v_out_319651.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_12 = math.max(var_136_5, arg_133_1.talkMaxDuration)

			if var_136_4 <= arg_133_1.time_ and arg_133_1.time_ < var_136_4 + var_136_12 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_4) / var_136_12

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_4 + var_136_12 and arg_133_1.time_ < var_136_4 + var_136_12 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play319651034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 319651034
		arg_137_1.duration_ = 4.2

		local var_137_0 = {
			zh = 1.999999999999,
			ja = 4.2
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
				arg_137_0:Play319651035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if arg_137_1.actors_["10066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10066ui_story"))) then
				local var_140_0 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_137_1.stage_.transform)

				var_140_0.name = "10066ui_story"
				var_140_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_137_1.actors_["10066ui_story"] = var_140_0

				local var_140_1 = var_140_0:GetComponentInChildren(typeof(CharacterEffect))

				var_140_1.enabled = true

				local var_140_2 = GameObjectTools.GetOrAddComponent(var_140_0, typeof(DynamicBoneHelper))

				if var_140_2 then
					var_140_2:EnableDynamicBone(false)
				end

				arg_137_1:ShowWeapon(var_140_1.transform, false)

				arg_137_1.var_["10066ui_story" .. "Animator"] = var_140_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_137_1.var_["10066ui_story" .. "Animator"].applyRootMotion = true
				arg_137_1.var_["10066ui_story" .. "LipSync"] = var_140_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_140_3 = arg_137_1.actors_["10066ui_story"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10066ui_story = var_140_3.localPosition
			end

			local var_140_4 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				var_140_3.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_137_1.time_ - 0) / var_140_4)
				var_140_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_3.position).x, (manager.ui.mainCamera.transform.position - var_140_3.position).y, (manager.ui.mainCamera.transform.position - var_140_3.position).z)
				var_140_3.localEulerAngles.z = 0
				var_140_3.localEulerAngles.x = 0
				var_140_3.localEulerAngles = var_140_3.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				var_140_3.localPosition = Vector3.New(0, -0.99, -5.83)
				var_140_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_3.position).x, (manager.ui.mainCamera.transform.position - var_140_3.position).y, (manager.ui.mainCamera.transform.position - var_140_3.position).z)
				var_140_3.localEulerAngles.z = 0
				var_140_3.localEulerAngles.x = 0
				var_140_3.localEulerAngles = var_140_3.localEulerAngles
			end

			local var_140_5 = arg_137_1.actors_["10066ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_5) and arg_137_1.var_.characterEffect10066ui_story == nil then
				arg_137_1.var_.characterEffect10066ui_story = var_140_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_6 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_6 and not isNil(var_140_5) then
				if arg_137_1.var_.characterEffect10066ui_story and not isNil(var_140_5) then
					arg_137_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_6 and arg_137_1.time_ < 0 + var_140_6 + arg_140_0 and not isNil(var_140_5) and arg_137_1.var_.characterEffect10066ui_story then
				arg_137_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_140_8 = arg_137_1.actors_["1084ui_story"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1084ui_story = var_140_8.localPosition
			end

			local var_140_9 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_9 then
				var_140_8.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 0) / var_140_9)
				var_140_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_8.position).x, (manager.ui.mainCamera.transform.position - var_140_8.position).y, (manager.ui.mainCamera.transform.position - var_140_8.position).z)
				var_140_8.localEulerAngles.z = 0
				var_140_8.localEulerAngles.x = 0
				var_140_8.localEulerAngles = var_140_8.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_9 and arg_137_1.time_ < 0 + var_140_9 + arg_140_0 then
				var_140_8.localPosition = Vector3.New(0, 100, 0)
				var_140_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_8.position).x, (manager.ui.mainCamera.transform.position - var_140_8.position).y, (manager.ui.mainCamera.transform.position - var_140_8.position).z)
				var_140_8.localEulerAngles.z = 0
				var_140_8.localEulerAngles.x = 0
				var_140_8.localEulerAngles = var_140_8.localEulerAngles
			end

			local var_140_10 = arg_137_1.actors_["10058ui_story"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10058ui_story = var_140_10.localPosition
			end

			local var_140_11 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_11 then
				var_140_10.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_137_1.time_ - 0) / var_140_11)
				var_140_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_10.position).x, (manager.ui.mainCamera.transform.position - var_140_10.position).y, (manager.ui.mainCamera.transform.position - var_140_10.position).z)
				var_140_10.localEulerAngles.z = 0
				var_140_10.localEulerAngles.x = 0
				var_140_10.localEulerAngles = var_140_10.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_11 and arg_137_1.time_ < 0 + var_140_11 + arg_140_0 then
				var_140_10.localPosition = Vector3.New(0, 100, 0)
				var_140_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_140_10.position).x, (manager.ui.mainCamera.transform.position - var_140_10.position).y, (manager.ui.mainCamera.transform.position - var_140_10.position).z)
				var_140_10.localEulerAngles.z = 0
				var_140_10.localEulerAngles.x = 0
				var_140_10.localEulerAngles = var_140_10.localEulerAngles
			end

			local var_140_12 = arg_137_1.actors_["10058ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_12) and arg_137_1.var_.characterEffect10058ui_story == nil then
				arg_137_1.var_.characterEffect10058ui_story = var_140_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_13 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_13 and not isNil(var_140_12) then
				if arg_137_1.var_.characterEffect10058ui_story and not isNil(var_140_12) then
					arg_137_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_137_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_13)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_13 and arg_137_1.time_ < 0 + var_140_13 + arg_140_0 and not isNil(var_140_12) and arg_137_1.var_.characterEffect10058ui_story then
				arg_137_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_137_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_140_14 = 0
			local var_140_15 = 0.05

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_14 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_16 = arg_137_1:GetWordFromCfg(319651034)
				local var_140_17 = arg_137_1:FormatText(var_140_16.content)

				arg_137_1.text_.text = var_140_17

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_19 = 2 <= 0 and var_140_15 or var_140_15 * (utf8.len(var_140_17) / 2)

				if (2 <= 0 and var_140_15 or var_140_15 * (utf8.len(var_140_17) / 2)) > 0 and var_140_15 < var_140_19 then
					arg_137_1.talkMaxDuration = var_140_19

					if var_140_19 + var_140_14 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_19 + var_140_14
					end
				end

				arg_137_1.text_.text = var_140_17
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651034", "story_v_out_319651.awb") ~= 0 then
					local var_140_20 = manager.audio:GetVoiceLength("story_v_out_319651", "319651034", "story_v_out_319651.awb") / 1000

					if var_140_20 + var_140_14 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_20 + var_140_14
					end

					if var_140_16.prefab_name ~= "" and arg_137_1.actors_[var_140_16.prefab_name] ~= nil then
						local var_140_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_16.prefab_name].transform, "story_v_out_319651", "319651034", "story_v_out_319651.awb")

						arg_137_1:RecordAudio("319651034", var_140_21)
						arg_137_1:RecordAudio("319651034", var_140_21)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_319651", "319651034", "story_v_out_319651.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_319651", "319651034", "story_v_out_319651.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_22 = math.max(var_140_15, arg_137_1.talkMaxDuration)

			if var_140_14 <= arg_137_1.time_ and arg_137_1.time_ < var_140_14 + var_140_22 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_14) / var_140_22

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_14 + var_140_22 and arg_137_1.time_ < var_140_14 + var_140_22 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play319651035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 319651035
		arg_141_1.duration_ = 8.63

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play319651036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if arg_141_1.bgs_.ML0201 == nil then
				local var_144_0 = Object.Instantiate(arg_141_1.paintGo_)

				var_144_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ML0201")
				var_144_0.name = "ML0201"
				var_144_0.transform.parent = arg_141_1.stage_.transform
				var_144_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_141_1.bgs_.ML0201 = var_144_0
			end

			if 1.96599999815226 < arg_141_1.time_ and arg_141_1.time_ <= 1.96599999815226 + arg_144_0 then
				local var_144_1 = arg_141_1.bgs_.ML0201

				arg_141_1.bgs_.ML0201.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_144_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_144_2 = var_144_1:GetComponent("SpriteRenderer")

				if var_144_2 and var_144_2.sprite then
					local var_144_3 = 2 * (var_144_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_144_1.transform.localScale = Vector3.New(var_144_3 / var_144_2.sprite.bounds.size.y < var_144_3 * manager.ui.mainCameraCom_.aspect / var_144_2.sprite.bounds.size.x and var_144_3 * manager.ui.mainCameraCom_.aspect / var_144_2.sprite.bounds.size.x or var_144_3 / var_144_2.sprite.bounds.size.y, var_144_3 / var_144_2.sprite.bounds.size.y < var_144_3 * manager.ui.mainCameraCom_.aspect / var_144_2.sprite.bounds.size.x and var_144_3 * manager.ui.mainCameraCom_.aspect / var_144_2.sprite.bounds.size.x or var_144_3 / var_144_2.sprite.bounds.size.y, 0)
				end

				for iter_144_0, iter_144_1 in pairs(arg_141_1.bgs_) do
					if iter_144_0 ~= "ML0201" then
						iter_144_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_144_4 = 0

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.allBtn_.enabled = false
			end

			if arg_141_1.time_ >= var_144_4 + 0.3 and arg_141_1.time_ < var_144_4 + 0.3 + arg_144_0 then
				arg_141_1.allBtn_.enabled = true
			end

			local var_144_5 = 0

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = true

				arg_141_1:SetGaussion(false)
			end

			local var_144_6 = 2

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_6 then
				local var_144_7 = Color.New(0, 0, 0)

				var_144_7.a = Mathf.Lerp(0, 1, (arg_141_1.time_ - var_144_5) / var_144_6)
				arg_141_1.mask_.color = var_144_7
			end

			if arg_141_1.time_ >= var_144_5 + var_144_6 and arg_141_1.time_ < var_144_5 + var_144_6 + arg_144_0 then
				local var_144_8 = Color.New(0, 0, 0)

				var_144_8.a = 1
				arg_141_1.mask_.color = var_144_8
			end

			local var_144_9 = 2

			if 2 < arg_141_1.time_ and arg_141_1.time_ <= var_144_9 + arg_144_0 then
				arg_141_1.mask_.enabled = true
				arg_141_1.mask_.raycastTarget = true

				arg_141_1:SetGaussion(false)
			end

			local var_144_10 = 2

			if var_144_9 <= arg_141_1.time_ and arg_141_1.time_ < var_144_9 + var_144_10 then
				local var_144_11 = Color.New(0, 0, 0)

				var_144_11.a = Mathf.Lerp(1, 0, (arg_141_1.time_ - var_144_9) / var_144_10)
				arg_141_1.mask_.color = var_144_11
			end

			if arg_141_1.time_ >= var_144_9 + var_144_10 and arg_141_1.time_ < var_144_9 + var_144_10 + arg_144_0 then
				local var_144_12 = Color.New(0, 0, 0)

				arg_141_1.mask_.enabled = false
				var_144_12.a = 0
				arg_141_1.mask_.color = var_144_12
			end

			local var_144_13 = arg_141_1.actors_["10066ui_story"].transform

			if 1.96666666666667 < arg_141_1.time_ and arg_141_1.time_ <= 1.96666666666667 + arg_144_0 then
				arg_141_1.var_.moveOldPos10066ui_story = var_144_13.localPosition
			end

			local var_144_14 = 0.001

			if 1.96666666666667 <= arg_141_1.time_ and arg_141_1.time_ < 1.96666666666667 + var_144_14 then
				var_144_13.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_141_1.time_ - 1.96666666666667) / var_144_14)
				var_144_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_13.position).x, (manager.ui.mainCamera.transform.position - var_144_13.position).y, (manager.ui.mainCamera.transform.position - var_144_13.position).z)
				var_144_13.localEulerAngles.z = 0
				var_144_13.localEulerAngles.x = 0
				var_144_13.localEulerAngles = var_144_13.localEulerAngles
			end

			if arg_141_1.time_ >= 1.96666666666667 + var_144_14 and arg_141_1.time_ < 1.96666666666667 + var_144_14 + arg_144_0 then
				var_144_13.localPosition = Vector3.New(0, 100, 0)
				var_144_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_144_13.position).x, (manager.ui.mainCamera.transform.position - var_144_13.position).y, (manager.ui.mainCamera.transform.position - var_144_13.position).z)
				var_144_13.localEulerAngles.z = 0
				var_144_13.localEulerAngles.x = 0
				var_144_13.localEulerAngles = var_144_13.localEulerAngles
			end

			local var_144_15 = arg_141_1.bgs_.ML0201.transform

			if 2 < arg_141_1.time_ and arg_141_1.time_ <= 2 + arg_144_0 then
				arg_141_1.var_.moveOldPosML0201 = var_144_15.localPosition
			end

			local var_144_16 = 0.001

			if 2 <= arg_141_1.time_ and arg_141_1.time_ < 2 + var_144_16 then
				var_144_15.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPosML0201, Vector3.New(0, 1, 10), (arg_141_1.time_ - 2) / var_144_16)
			end

			if arg_141_1.time_ >= 2 + var_144_16 and arg_141_1.time_ < 2 + var_144_16 + arg_144_0 then
				var_144_15.localPosition = Vector3.New(0, 1, 10)
			end

			local var_144_17 = arg_141_1.bgs_.ML0201.transform

			if 2.01666666666667 < arg_141_1.time_ and arg_141_1.time_ <= 2.01666666666667 + arg_144_0 then
				arg_141_1.var_.moveOldPosML0201 = var_144_17.localPosition
			end

			local var_144_18 = 1.96599999815226

			if 2.01666666666667 <= arg_141_1.time_ and arg_141_1.time_ < 2.01666666666667 + var_144_18 then
				var_144_17.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPosML0201, Vector3.New(0, 0.78, 8.15), (arg_141_1.time_ - 2.01666666666667) / var_144_18)
			end

			if arg_141_1.time_ >= 2.01666666666667 + var_144_18 and arg_141_1.time_ < 2.01666666666667 + var_144_18 + arg_144_0 then
				var_144_17.localPosition = Vector3.New(0, 0.78, 8.15)
			end

			if arg_141_1.frameCnt_ <= 1 then
				arg_141_1.dialog_:SetActive(false)
			end

			local var_144_19 = 3.63333333333333
			local var_144_20 = 1.375

			if 3.63333333333333 < arg_141_1.time_ and arg_141_1.time_ <= var_144_19 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				arg_141_1.dialog_:SetActive(true)

				arg_141_1.dialogCg_.alpha = 0

				local var_144_21 = LeanTween.value(arg_141_1.dialog_, 0, 1, 0.3)

				var_144_21:setOnUpdate(LuaHelper.FloatAction(function(arg_145_0)
					arg_141_1.dialogCg_.alpha = arg_145_0
				end))
				var_144_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_141_1.dialog_)
					var_144_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_141_1.duration_ = arg_141_1.duration_ + 0.3

				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_22 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(319651035).content)

				arg_141_1.text_.text = var_144_22

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_24 = 55 <= 0 and var_144_20 or var_144_20 * (utf8.len(var_144_22) / 55)

				if (55 <= 0 and var_144_20 or var_144_20 * (utf8.len(var_144_22) / 55)) > 0 and var_144_20 < var_144_24 then
					arg_141_1.talkMaxDuration = var_144_24
					var_144_19 = var_144_19 + 0.3

					if var_144_24 + var_144_19 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_24 + var_144_19
					end
				end

				arg_141_1.text_.text = var_144_22
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_25 = var_144_19 + 0.3
			local var_144_26 = math.max(var_144_20, arg_141_1.talkMaxDuration)

			if var_144_19 + 0.3 <= arg_141_1.time_ and arg_141_1.time_ < var_144_25 + var_144_26 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_25) / var_144_26

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_25 + var_144_26 and arg_141_1.time_ < var_144_25 + var_144_26 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "ML0201",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0201",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.96599999815226,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play319651036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 319651036
		arg_147_1.duration_ = 8.97

		local var_147_0 = {
			zh = 5,
			ja = 8.966
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
				arg_147_0:Play319651037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0.275

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_1 = arg_147_1:GetWordFromCfg(319651036)
				local var_150_2 = arg_147_1:FormatText(var_150_1.content)

				arg_147_1.text_.text = var_150_2

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_4 = 11 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 11)

				if (11 <= 0 and var_150_0 or var_150_0 * (utf8.len(var_150_2) / 11)) > 0 and var_150_0 < var_150_4 then
					arg_147_1.talkMaxDuration = var_150_4

					if var_150_4 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_4 + 0
					end
				end

				arg_147_1.text_.text = var_150_2
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651036", "story_v_out_319651.awb") ~= 0 then
					local var_150_5 = manager.audio:GetVoiceLength("story_v_out_319651", "319651036", "story_v_out_319651.awb") / 1000

					if var_150_5 + 0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + 0
					end

					if var_150_1.prefab_name ~= "" and arg_147_1.actors_[var_150_1.prefab_name] ~= nil then
						local var_150_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_1.prefab_name].transform, "story_v_out_319651", "319651036", "story_v_out_319651.awb")

						arg_147_1:RecordAudio("319651036", var_150_6)
						arg_147_1:RecordAudio("319651036", var_150_6)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_319651", "319651036", "story_v_out_319651.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_319651", "319651036", "story_v_out_319651.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_7 = math.max(var_150_0, arg_147_1.talkMaxDuration)

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - 0) / var_150_7

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play319651037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319651037
		arg_151_1.duration_ = 4.7

		local var_151_0 = {
			zh = 3.9,
			ja = 4.7
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
				arg_151_0:Play319651038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.45

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:GetWordFromCfg(319651037)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 18 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 18)

				if (18 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 18)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651037", "story_v_out_319651.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_out_319651", "319651037", "story_v_out_319651.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_out_319651", "319651037", "story_v_out_319651.awb")

						arg_151_1:RecordAudio("319651037", var_154_6)
						arg_151_1:RecordAudio("319651037", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_319651", "319651037", "story_v_out_319651.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_319651", "319651037", "story_v_out_319651.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play319651038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319651038
		arg_155_1.duration_ = 6.23

		local var_155_0 = {
			zh = 5.4,
			ja = 6.233
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
				arg_155_0:Play319651039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0.475

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_1 = arg_155_1:GetWordFromCfg(319651038)
				local var_158_2 = arg_155_1:FormatText(var_158_1.content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 19 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 19)

				if (19 <= 0 and var_158_0 or var_158_0 * (utf8.len(var_158_2) / 19)) > 0 and var_158_0 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + 0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651038", "story_v_out_319651.awb") ~= 0 then
					local var_158_5 = manager.audio:GetVoiceLength("story_v_out_319651", "319651038", "story_v_out_319651.awb") / 1000

					if var_158_5 + 0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_5 + 0
					end

					if var_158_1.prefab_name ~= "" and arg_155_1.actors_[var_158_1.prefab_name] ~= nil then
						local var_158_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_1.prefab_name].transform, "story_v_out_319651", "319651038", "story_v_out_319651.awb")

						arg_155_1:RecordAudio("319651038", var_158_6)
						arg_155_1:RecordAudio("319651038", var_158_6)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_319651", "319651038", "story_v_out_319651.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_319651", "319651038", "story_v_out_319651.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_0, arg_155_1.talkMaxDuration)

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - 0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play319651039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 319651039
		arg_159_1.duration_ = 8.23

		local var_159_0 = {
			zh = 7.266,
			ja = 8.233
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
				arg_159_0:Play319651040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0.8

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_1 = arg_159_1:GetWordFromCfg(319651039)
				local var_162_2 = arg_159_1:FormatText(var_162_1.content)

				arg_159_1.text_.text = var_162_2

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 32 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 32)

				if (32 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 32)) > 0 and var_162_0 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end

				arg_159_1.text_.text = var_162_2
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651039", "story_v_out_319651.awb") ~= 0 then
					local var_162_5 = manager.audio:GetVoiceLength("story_v_out_319651", "319651039", "story_v_out_319651.awb") / 1000

					if var_162_5 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + 0
					end

					if var_162_1.prefab_name ~= "" and arg_159_1.actors_[var_162_1.prefab_name] ~= nil then
						local var_162_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_1.prefab_name].transform, "story_v_out_319651", "319651039", "story_v_out_319651.awb")

						arg_159_1:RecordAudio("319651039", var_162_6)
						arg_159_1:RecordAudio("319651039", var_162_6)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_319651", "319651039", "story_v_out_319651.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_319651", "319651039", "story_v_out_319651.awb")
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
	Play319651040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 319651040
		arg_163_1.duration_ = 9.83

		local var_163_0 = {
			zh = 7.2,
			ja = 9.833
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
				arg_163_0:Play319651041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.825

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_1 = arg_163_1:GetWordFromCfg(319651040)
				local var_166_2 = arg_163_1:FormatText(var_166_1.content)

				arg_163_1.text_.text = var_166_2

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 33 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 33)

				if (33 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 33)) > 0 and var_166_0 < var_166_4 then
					arg_163_1.talkMaxDuration = var_166_4

					if var_166_4 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_4 + 0
					end
				end

				arg_163_1.text_.text = var_166_2
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651040", "story_v_out_319651.awb") ~= 0 then
					local var_166_5 = manager.audio:GetVoiceLength("story_v_out_319651", "319651040", "story_v_out_319651.awb") / 1000

					if var_166_5 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + 0
					end

					if var_166_1.prefab_name ~= "" and arg_163_1.actors_[var_166_1.prefab_name] ~= nil then
						local var_166_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_1.prefab_name].transform, "story_v_out_319651", "319651040", "story_v_out_319651.awb")

						arg_163_1:RecordAudio("319651040", var_166_6)
						arg_163_1:RecordAudio("319651040", var_166_6)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_319651", "319651040", "story_v_out_319651.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_319651", "319651040", "story_v_out_319651.awb")
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
	Play319651041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 319651041
		arg_167_1.duration_ = 8.57

		local var_167_0 = {
			zh = 8.3,
			ja = 8.566
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
				arg_167_0:Play319651042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.8

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:GetWordFromCfg(319651041)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 32 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 32)

				if (32 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 32)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651041", "story_v_out_319651.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_319651", "319651041", "story_v_out_319651.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_319651", "319651041", "story_v_out_319651.awb")

						arg_167_1:RecordAudio("319651041", var_170_6)
						arg_167_1:RecordAudio("319651041", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_319651", "319651041", "story_v_out_319651.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_319651", "319651041", "story_v_out_319651.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play319651042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 319651042
		arg_171_1.duration_ = 7.07

		local var_171_0 = {
			zh = 7.066,
			ja = 4.566
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
				arg_171_0:Play319651043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.475

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:GetWordFromCfg(319651042)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 19 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 19)

				if (19 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 19)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651042", "story_v_out_319651.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_out_319651", "319651042", "story_v_out_319651.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_out_319651", "319651042", "story_v_out_319651.awb")

						arg_171_1:RecordAudio("319651042", var_174_6)
						arg_171_1:RecordAudio("319651042", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_319651", "319651042", "story_v_out_319651.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_319651", "319651042", "story_v_out_319651.awb")
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
	Play319651043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 319651043
		arg_175_1.duration_ = 8.4

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play319651044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 2 < arg_175_1.time_ and arg_175_1.time_ <= 2 + arg_178_0 then
				local var_178_0 = arg_175_1.bgs_.ST74

				arg_175_1.bgs_.ST74.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_178_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_178_1 = var_178_0:GetComponent("SpriteRenderer")

				if var_178_1 and var_178_1.sprite then
					local var_178_2 = 2 * (var_178_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_178_0.transform.localScale = Vector3.New(var_178_2 / var_178_1.sprite.bounds.size.y < var_178_2 * manager.ui.mainCameraCom_.aspect / var_178_1.sprite.bounds.size.x and var_178_2 * manager.ui.mainCameraCom_.aspect / var_178_1.sprite.bounds.size.x or var_178_2 / var_178_1.sprite.bounds.size.y, var_178_2 / var_178_1.sprite.bounds.size.y < var_178_2 * manager.ui.mainCameraCom_.aspect / var_178_1.sprite.bounds.size.x and var_178_2 * manager.ui.mainCameraCom_.aspect / var_178_1.sprite.bounds.size.x or var_178_2 / var_178_1.sprite.bounds.size.y, 0)
				end

				for iter_178_0, iter_178_1 in pairs(arg_175_1.bgs_) do
					if iter_178_0 ~= "ST74" then
						iter_178_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_178_3 = 0

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_3 + arg_178_0 then
				arg_175_1.allBtn_.enabled = false
			end

			if arg_175_1.time_ >= var_178_3 + 0.3 and arg_175_1.time_ < var_178_3 + 0.3 + arg_178_0 then
				arg_175_1.allBtn_.enabled = true
			end

			local var_178_4 = 0

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_5 = 2

			if var_178_4 <= arg_175_1.time_ and arg_175_1.time_ < var_178_4 + var_178_5 then
				local var_178_6 = Color.New(0, 0, 0)

				var_178_6.a = Mathf.Lerp(0, 1, (arg_175_1.time_ - var_178_4) / var_178_5)
				arg_175_1.mask_.color = var_178_6
			end

			if arg_175_1.time_ >= var_178_4 + var_178_5 and arg_175_1.time_ < var_178_4 + var_178_5 + arg_178_0 then
				local var_178_7 = Color.New(0, 0, 0)

				var_178_7.a = 1
				arg_175_1.mask_.color = var_178_7
			end

			local var_178_8 = 2

			if 2 < arg_175_1.time_ and arg_175_1.time_ <= var_178_8 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_9 = 1.5

			if var_178_8 <= arg_175_1.time_ and arg_175_1.time_ < var_178_8 + var_178_9 then
				local var_178_10 = Color.New(0, 0, 0)

				var_178_10.a = Mathf.Lerp(1, 0, (arg_175_1.time_ - var_178_8) / var_178_9)
				arg_175_1.mask_.color = var_178_10
			end

			if arg_175_1.time_ >= var_178_8 + var_178_9 and arg_175_1.time_ < var_178_8 + var_178_9 + arg_178_0 then
				local var_178_11 = Color.New(0, 0, 0)

				arg_175_1.mask_.enabled = false
				var_178_11.a = 0
				arg_175_1.mask_.color = var_178_11
			end

			if arg_175_1.frameCnt_ <= 1 then
				arg_175_1.dialog_:SetActive(false)
			end

			local var_178_12 = 3.4
			local var_178_13 = 0.5

			if 3.4 < arg_175_1.time_ and arg_175_1.time_ <= var_178_12 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				arg_175_1.dialog_:SetActive(true)

				arg_175_1.dialogCg_.alpha = 0

				local var_178_14 = LeanTween.value(arg_175_1.dialog_, 0, 1, 0.3)

				var_178_14:setOnUpdate(LuaHelper.FloatAction(function(arg_179_0)
					arg_175_1.dialogCg_.alpha = arg_179_0
				end))
				var_178_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_175_1.dialog_)
					var_178_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_175_1.duration_ = arg_175_1.duration_ + 0.3

				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_15 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(319651043).content)

				arg_175_1.text_.text = var_178_15

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_17 = 20 <= 0 and var_178_13 or var_178_13 * (utf8.len(var_178_15) / 20)

				if (20 <= 0 and var_178_13 or var_178_13 * (utf8.len(var_178_15) / 20)) > 0 and var_178_13 < var_178_17 then
					arg_175_1.talkMaxDuration = var_178_17
					var_178_12 = var_178_12 + 0.3

					if var_178_17 + var_178_12 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_17 + var_178_12
					end
				end

				arg_175_1.text_.text = var_178_15
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_18 = var_178_12 + 0.3
			local var_178_19 = math.max(var_178_13, arg_175_1.talkMaxDuration)

			if var_178_12 + 0.3 <= arg_175_1.time_ and arg_175_1.time_ < var_178_18 + var_178_19 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_18) / var_178_19

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_18 + var_178_19 and arg_175_1.time_ < var_178_18 + var_178_19 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play319651044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 319651044
		arg_181_1.duration_ = 3.4

		local var_181_0 = {
			zh = 3.033,
			ja = 3.4
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play319651045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos10066ui_story = arg_181_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["10066ui_story"].transform.position).z)
				arg_181_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["10066ui_story"].transform.localEulerAngles = arg_181_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_181_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["10066ui_story"].transform.position).z)
				arg_181_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["10066ui_story"].transform.localEulerAngles = arg_181_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["10066ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect10066ui_story == nil then
				arg_181_1.var_.characterEffect10066ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect10066ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect10066ui_story then
				arg_181_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_2")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_184_4 = 0
			local var_184_5 = 0.275

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_6 = arg_181_1:GetWordFromCfg(319651044)
				local var_184_7 = arg_181_1:FormatText(var_184_6.content)

				arg_181_1.text_.text = var_184_7

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_9 = 11 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 11)

				if (11 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 11)) > 0 and var_184_5 < var_184_9 then
					arg_181_1.talkMaxDuration = var_184_9

					if var_184_9 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_9 + var_184_4
					end
				end

				arg_181_1.text_.text = var_184_7
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651044", "story_v_out_319651.awb") ~= 0 then
					local var_184_10 = manager.audio:GetVoiceLength("story_v_out_319651", "319651044", "story_v_out_319651.awb") / 1000

					if var_184_10 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_4
					end

					if var_184_6.prefab_name ~= "" and arg_181_1.actors_[var_184_6.prefab_name] ~= nil then
						local var_184_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_6.prefab_name].transform, "story_v_out_319651", "319651044", "story_v_out_319651.awb")

						arg_181_1:RecordAudio("319651044", var_184_11)
						arg_181_1:RecordAudio("319651044", var_184_11)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_319651", "319651044", "story_v_out_319651.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_319651", "319651044", "story_v_out_319651.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_12 = math.max(var_184_5, arg_181_1.talkMaxDuration)

			if var_184_4 <= arg_181_1.time_ and arg_181_1.time_ < var_184_4 + var_184_12 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_4) / var_184_12

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_4 + var_184_12 and arg_181_1.time_ < var_184_4 + var_184_12 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play319651045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 319651045
		arg_185_1.duration_ = 4.17

		local var_185_0 = {
			zh = 2.833,
			ja = 4.166
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play319651046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1084ui_story = arg_185_1.actors_["1084ui_story"].transform.localPosition

				arg_185_1:ShowWeapon(arg_185_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1084ui_story"].transform.position).z)
				arg_185_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1084ui_story"].transform.localEulerAngles = arg_185_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_185_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1084ui_story"].transform.position).z)
				arg_185_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1084ui_story"].transform.localEulerAngles = arg_185_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_188_1 = arg_185_1.actors_["1084ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1084ui_story == nil then
				arg_185_1.var_.characterEffect1084ui_story = var_188_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 and not isNil(var_188_1) then
				if arg_185_1.var_.characterEffect1084ui_story and not isNil(var_188_1) then
					arg_185_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1084ui_story then
				arg_185_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_188_4 = arg_185_1.actors_["10066ui_story"].transform

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10066ui_story = var_188_4.localPosition
			end

			local var_188_5 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_5 then
				var_188_4.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 0) / var_188_5)
				var_188_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_4.position).x, (manager.ui.mainCamera.transform.position - var_188_4.position).y, (manager.ui.mainCamera.transform.position - var_188_4.position).z)
				var_188_4.localEulerAngles.z = 0
				var_188_4.localEulerAngles.x = 0
				var_188_4.localEulerAngles = var_188_4.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_5 and arg_185_1.time_ < 0 + var_188_5 + arg_188_0 then
				var_188_4.localPosition = Vector3.New(0, 100, 0)
				var_188_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_4.position).x, (manager.ui.mainCamera.transform.position - var_188_4.position).y, (manager.ui.mainCamera.transform.position - var_188_4.position).z)
				var_188_4.localEulerAngles.z = 0
				var_188_4.localEulerAngles.x = 0
				var_188_4.localEulerAngles = var_188_4.localEulerAngles
			end

			local var_188_6 = arg_185_1.actors_["10066ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect10066ui_story == nil then
				arg_185_1.var_.characterEffect10066ui_story = var_188_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_7 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 and not isNil(var_188_6) then
				if arg_185_1.var_.characterEffect10066ui_story and not isNil(var_188_6) then
					arg_185_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_185_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 0) / var_188_7)
				end
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 and not isNil(var_188_6) and arg_185_1.var_.characterEffect10066ui_story then
				arg_185_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_185_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_188_8 = 0
			local var_188_9 = 0.275

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_10 = arg_185_1:GetWordFromCfg(319651045)
				local var_188_11 = arg_185_1:FormatText(var_188_10.content)

				arg_185_1.text_.text = var_188_11

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_13 = 11 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 11)

				if (11 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 11)) > 0 and var_188_9 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_8
					end
				end

				arg_185_1.text_.text = var_188_11
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651045", "story_v_out_319651.awb") ~= 0 then
					local var_188_14 = manager.audio:GetVoiceLength("story_v_out_319651", "319651045", "story_v_out_319651.awb") / 1000

					if var_188_14 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_8
					end

					if var_188_10.prefab_name ~= "" and arg_185_1.actors_[var_188_10.prefab_name] ~= nil then
						local var_188_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_10.prefab_name].transform, "story_v_out_319651", "319651045", "story_v_out_319651.awb")

						arg_185_1:RecordAudio("319651045", var_188_15)
						arg_185_1:RecordAudio("319651045", var_188_15)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_319651", "319651045", "story_v_out_319651.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_319651", "319651045", "story_v_out_319651.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_9, arg_185_1.talkMaxDuration)

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_8) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_8 + var_188_16 and arg_185_1.time_ < var_188_8 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play319651046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 319651046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play319651047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1084ui_story = arg_189_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1084ui_story"].transform.position).z)
				arg_189_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1084ui_story"].transform.localEulerAngles = arg_189_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_189_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1084ui_story"].transform.position).z)
				arg_189_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1084ui_story"].transform.localEulerAngles = arg_189_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_192_1 = arg_189_1.actors_["1084ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1084ui_story == nil then
				arg_189_1.var_.characterEffect1084ui_story = var_192_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_2 and not isNil(var_192_1) then
				if arg_189_1.var_.characterEffect1084ui_story and not isNil(var_192_1) then
					arg_189_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_2)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_2 and arg_189_1.time_ < 0 + var_192_2 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect1084ui_story then
				arg_189_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_192_3 = 0
			local var_192_4 = 0.8

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_3 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_5 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(319651046).content)

				arg_189_1.text_.text = var_192_5

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_7 = 32 <= 0 and var_192_4 or var_192_4 * (utf8.len(var_192_5) / 32)

				if (32 <= 0 and var_192_4 or var_192_4 * (utf8.len(var_192_5) / 32)) > 0 and var_192_4 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_3 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_3
					end
				end

				arg_189_1.text_.text = var_192_5
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_8 = math.max(var_192_4, arg_189_1.talkMaxDuration)

			if var_192_3 <= arg_189_1.time_ and arg_189_1.time_ < var_192_3 + var_192_8 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_3) / var_192_8

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_3 + var_192_8 and arg_189_1.time_ < var_192_3 + var_192_8 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play319651047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 319651047
		arg_193_1.duration_ = 6.37

		local var_193_0 = {
			zh = 3.2,
			ja = 6.366
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play319651048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos10066ui_story = arg_193_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10066ui_story"].transform.position).z)
				arg_193_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["10066ui_story"].transform.localEulerAngles = arg_193_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_193_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10066ui_story"].transform.position).z)
				arg_193_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["10066ui_story"].transform.localEulerAngles = arg_193_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["10066ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect10066ui_story == nil then
				arg_193_1.var_.characterEffect10066ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect10066ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect10066ui_story then
				arg_193_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_1")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_196_4 = 0
			local var_196_5 = 0.3

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:GetWordFromCfg(319651047)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 12 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 12)

				if (12 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 12)) > 0 and var_196_5 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651047", "story_v_out_319651.awb") ~= 0 then
					local var_196_10 = manager.audio:GetVoiceLength("story_v_out_319651", "319651047", "story_v_out_319651.awb") / 1000

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end

					if var_196_6.prefab_name ~= "" and arg_193_1.actors_[var_196_6.prefab_name] ~= nil then
						local var_196_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_6.prefab_name].transform, "story_v_out_319651", "319651047", "story_v_out_319651.awb")

						arg_193_1:RecordAudio("319651047", var_196_11)
						arg_193_1:RecordAudio("319651047", var_196_11)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_319651", "319651047", "story_v_out_319651.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_319651", "319651047", "story_v_out_319651.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_12 = math.max(var_196_5, arg_193_1.talkMaxDuration)

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_12 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_4) / var_196_12

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_4 + var_196_12 and arg_193_1.time_ < var_196_4 + var_196_12 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play319651048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 319651048
		arg_197_1.duration_ = 8

		local var_197_0 = {
			zh = 4.6,
			ja = 8
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play319651049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.475

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:GetWordFromCfg(319651048)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 19 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 19)

				if (19 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 19)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651048", "story_v_out_319651.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_319651", "319651048", "story_v_out_319651.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_319651", "319651048", "story_v_out_319651.awb")

						arg_197_1:RecordAudio("319651048", var_200_6)
						arg_197_1:RecordAudio("319651048", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_319651", "319651048", "story_v_out_319651.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_319651", "319651048", "story_v_out_319651.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play319651049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 319651049
		arg_201_1.duration_ = 10.7

		local var_201_0 = {
			zh = 6.866,
			ja = 10.7
		}
		local var_201_1 = manager.audio:GetLocalizationFlag()

		if var_201_0[var_201_1] ~= nil then
			arg_201_1.duration_ = var_201_0[var_201_1]
		end

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play319651050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos10058ui_story = arg_201_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10058ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["10058ui_story"].transform.position).z)
				arg_201_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["10058ui_story"].transform.localEulerAngles = arg_201_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_201_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["10058ui_story"].transform.position).z)
				arg_201_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["10058ui_story"].transform.localEulerAngles = arg_201_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["10058ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect10058ui_story == nil then
				arg_201_1.var_.characterEffect10058ui_story = var_204_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 and not isNil(var_204_1) then
				if arg_201_1.var_.characterEffect10058ui_story and not isNil(var_204_1) then
					arg_201_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 and not isNil(var_204_1) and arg_201_1.var_.characterEffect10058ui_story then
				arg_201_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_204_4 = arg_201_1.actors_["10066ui_story"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos10066ui_story = var_204_4.localPosition
			end

			local var_204_5 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_5 then
				var_204_4.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_201_1.time_ - 0) / var_204_5)
				var_204_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_4.position).x, (manager.ui.mainCamera.transform.position - var_204_4.position).y, (manager.ui.mainCamera.transform.position - var_204_4.position).z)
				var_204_4.localEulerAngles.z = 0
				var_204_4.localEulerAngles.x = 0
				var_204_4.localEulerAngles = var_204_4.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_5 and arg_201_1.time_ < 0 + var_204_5 + arg_204_0 then
				var_204_4.localPosition = Vector3.New(0.7, -0.99, -5.83)
				var_204_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_4.position).x, (manager.ui.mainCamera.transform.position - var_204_4.position).y, (manager.ui.mainCamera.transform.position - var_204_4.position).z)
				var_204_4.localEulerAngles.z = 0
				var_204_4.localEulerAngles.x = 0
				var_204_4.localEulerAngles = var_204_4.localEulerAngles
			end

			local var_204_6 = arg_201_1.actors_["10066ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_6) and arg_201_1.var_.characterEffect10066ui_story == nil then
				arg_201_1.var_.characterEffect10066ui_story = var_204_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_7 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 and not isNil(var_204_6) then
				if arg_201_1.var_.characterEffect10066ui_story and not isNil(var_204_6) then
					arg_201_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_201_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_7)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 and not isNil(var_204_6) and arg_201_1.var_.characterEffect10066ui_story then
				arg_201_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_201_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_204_8 = 0
			local var_204_9 = 0.75

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_8 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_10 = arg_201_1:GetWordFromCfg(319651049)
				local var_204_11 = arg_201_1:FormatText(var_204_10.content)

				arg_201_1.text_.text = var_204_11

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_13 = 30 <= 0 and var_204_9 or var_204_9 * (utf8.len(var_204_11) / 30)

				if (30 <= 0 and var_204_9 or var_204_9 * (utf8.len(var_204_11) / 30)) > 0 and var_204_9 < var_204_13 then
					arg_201_1.talkMaxDuration = var_204_13

					if var_204_13 + var_204_8 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_13 + var_204_8
					end
				end

				arg_201_1.text_.text = var_204_11
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651049", "story_v_out_319651.awb") ~= 0 then
					local var_204_14 = manager.audio:GetVoiceLength("story_v_out_319651", "319651049", "story_v_out_319651.awb") / 1000

					if var_204_14 + var_204_8 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_14 + var_204_8
					end

					if var_204_10.prefab_name ~= "" and arg_201_1.actors_[var_204_10.prefab_name] ~= nil then
						local var_204_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_10.prefab_name].transform, "story_v_out_319651", "319651049", "story_v_out_319651.awb")

						arg_201_1:RecordAudio("319651049", var_204_15)
						arg_201_1:RecordAudio("319651049", var_204_15)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_319651", "319651049", "story_v_out_319651.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_319651", "319651049", "story_v_out_319651.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_16 = math.max(var_204_9, arg_201_1.talkMaxDuration)

			if var_204_8 <= arg_201_1.time_ and arg_201_1.time_ < var_204_8 + var_204_16 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_8) / var_204_16

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_8 + var_204_16 and arg_201_1.time_ < var_204_8 + var_204_16 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play319651050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 319651050
		arg_205_1.duration_ = 13

		local var_205_0 = {
			zh = 6.666,
			ja = 13
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play319651051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.775

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:GetWordFromCfg(319651050)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 31 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 31)

				if (31 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 31)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651050", "story_v_out_319651.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_319651", "319651050", "story_v_out_319651.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_319651", "319651050", "story_v_out_319651.awb")

						arg_205_1:RecordAudio("319651050", var_208_6)
						arg_205_1:RecordAudio("319651050", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_319651", "319651050", "story_v_out_319651.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_319651", "319651050", "story_v_out_319651.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play319651051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 319651051
		arg_209_1.duration_ = 10.07

		local var_209_0 = {
			zh = 5.466,
			ja = 10.066
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play319651052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0.7

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_1 = arg_209_1:GetWordFromCfg(319651051)
				local var_212_2 = arg_209_1:FormatText(var_212_1.content)

				arg_209_1.text_.text = var_212_2

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_4 = 28 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 28)

				if (28 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_2) / 28)) > 0 and var_212_0 < var_212_4 then
					arg_209_1.talkMaxDuration = var_212_4

					if var_212_4 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_4 + 0
					end
				end

				arg_209_1.text_.text = var_212_2
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651051", "story_v_out_319651.awb") ~= 0 then
					local var_212_5 = manager.audio:GetVoiceLength("story_v_out_319651", "319651051", "story_v_out_319651.awb") / 1000

					if var_212_5 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + 0
					end

					if var_212_1.prefab_name ~= "" and arg_209_1.actors_[var_212_1.prefab_name] ~= nil then
						local var_212_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_1.prefab_name].transform, "story_v_out_319651", "319651051", "story_v_out_319651.awb")

						arg_209_1:RecordAudio("319651051", var_212_6)
						arg_209_1:RecordAudio("319651051", var_212_6)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_319651", "319651051", "story_v_out_319651.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_319651", "319651051", "story_v_out_319651.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_7 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_7 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_7

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_7 and arg_209_1.time_ < 0 + var_212_7 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play319651052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 319651052
		arg_213_1.duration_ = 5.47

		local var_213_0 = {
			zh = 3.533,
			ja = 5.466
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play319651053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_2")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_216_0 = arg_213_1.actors_["10066ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect10066ui_story == nil then
				arg_213_1.var_.characterEffect10066ui_story = var_216_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_1 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_1 and not isNil(var_216_0) then
				if arg_213_1.var_.characterEffect10066ui_story and not isNil(var_216_0) then
					arg_213_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_1 and arg_213_1.time_ < 0 + var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.characterEffect10066ui_story then
				arg_213_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_216_3 = arg_213_1.actors_["10058ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_3) and arg_213_1.var_.characterEffect10058ui_story == nil then
				arg_213_1.var_.characterEffect10058ui_story = var_216_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_4 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 and not isNil(var_216_3) then
				if arg_213_1.var_.characterEffect10058ui_story and not isNil(var_216_3) then
					arg_213_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_213_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_4)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 and not isNil(var_216_3) and arg_213_1.var_.characterEffect10058ui_story then
				arg_213_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_213_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_216_5 = 0
			local var_216_6 = 0.3

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_5 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_7 = arg_213_1:GetWordFromCfg(319651052)
				local var_216_8 = arg_213_1:FormatText(var_216_7.content)

				arg_213_1.text_.text = var_216_8

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_10 = 12 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_8) / 12)

				if (12 <= 0 and var_216_6 or var_216_6 * (utf8.len(var_216_8) / 12)) > 0 and var_216_6 < var_216_10 then
					arg_213_1.talkMaxDuration = var_216_10

					if var_216_10 + var_216_5 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_5
					end
				end

				arg_213_1.text_.text = var_216_8
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651052", "story_v_out_319651.awb") ~= 0 then
					local var_216_11 = manager.audio:GetVoiceLength("story_v_out_319651", "319651052", "story_v_out_319651.awb") / 1000

					if var_216_11 + var_216_5 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_11 + var_216_5
					end

					if var_216_7.prefab_name ~= "" and arg_213_1.actors_[var_216_7.prefab_name] ~= nil then
						local var_216_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_7.prefab_name].transform, "story_v_out_319651", "319651052", "story_v_out_319651.awb")

						arg_213_1:RecordAudio("319651052", var_216_12)
						arg_213_1:RecordAudio("319651052", var_216_12)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_319651", "319651052", "story_v_out_319651.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_319651", "319651052", "story_v_out_319651.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_13 = math.max(var_216_6, arg_213_1.talkMaxDuration)

			if var_216_5 <= arg_213_1.time_ and arg_213_1.time_ < var_216_5 + var_216_13 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_5) / var_216_13

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_5 + var_216_13 and arg_213_1.time_ < var_216_5 + var_216_13 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play319651053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 319651053
		arg_217_1.duration_ = 7.6

		local var_217_0 = {
			zh = 2.433,
			ja = 7.6
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play319651054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_220_0 = arg_217_1.actors_["10058ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect10058ui_story == nil then
				arg_217_1.var_.characterEffect10058ui_story = var_220_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_1 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_1 and not isNil(var_220_0) then
				if arg_217_1.var_.characterEffect10058ui_story and not isNil(var_220_0) then
					arg_217_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_1 and arg_217_1.time_ < 0 + var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.characterEffect10058ui_story then
				arg_217_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_220_3 = arg_217_1.actors_["10066ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_3) and arg_217_1.var_.characterEffect10066ui_story == nil then
				arg_217_1.var_.characterEffect10066ui_story = var_220_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_4 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 and not isNil(var_220_3) then
				if arg_217_1.var_.characterEffect10066ui_story and not isNil(var_220_3) then
					arg_217_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_217_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_4)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 and not isNil(var_220_3) and arg_217_1.var_.characterEffect10066ui_story then
				arg_217_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_217_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_220_5 = 0
			local var_220_6 = 0.275

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_5 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_7 = arg_217_1:GetWordFromCfg(319651053)
				local var_220_8 = arg_217_1:FormatText(var_220_7.content)

				arg_217_1.text_.text = var_220_8

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_10 = 11 <= 0 and var_220_6 or var_220_6 * (utf8.len(var_220_8) / 11)

				if (11 <= 0 and var_220_6 or var_220_6 * (utf8.len(var_220_8) / 11)) > 0 and var_220_6 < var_220_10 then
					arg_217_1.talkMaxDuration = var_220_10

					if var_220_10 + var_220_5 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_10 + var_220_5
					end
				end

				arg_217_1.text_.text = var_220_8
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651053", "story_v_out_319651.awb") ~= 0 then
					local var_220_11 = manager.audio:GetVoiceLength("story_v_out_319651", "319651053", "story_v_out_319651.awb") / 1000

					if var_220_11 + var_220_5 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_11 + var_220_5
					end

					if var_220_7.prefab_name ~= "" and arg_217_1.actors_[var_220_7.prefab_name] ~= nil then
						local var_220_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_7.prefab_name].transform, "story_v_out_319651", "319651053", "story_v_out_319651.awb")

						arg_217_1:RecordAudio("319651053", var_220_12)
						arg_217_1:RecordAudio("319651053", var_220_12)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_319651", "319651053", "story_v_out_319651.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_319651", "319651053", "story_v_out_319651.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_13 = math.max(var_220_6, arg_217_1.talkMaxDuration)

			if var_220_5 <= arg_217_1.time_ and arg_217_1.time_ < var_220_5 + var_220_13 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_5) / var_220_13

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_5 + var_220_13 and arg_217_1.time_ < var_220_5 + var_220_13 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play319651054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 319651054
		arg_221_1.duration_ = 3.63

		local var_221_0 = {
			zh = 2.933,
			ja = 3.633
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play319651055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos10066ui_story = arg_221_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_224_0 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 then
				arg_221_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_221_1.time_ - 0) / var_224_0)
				arg_221_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10066ui_story"].transform.position).z)
				arg_221_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["10066ui_story"].transform.localEulerAngles = arg_221_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 then
				arg_221_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0.7, -0.99, -5.83)
				arg_221_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_221_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_221_1.actors_["10066ui_story"].transform.position).z)
				arg_221_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_221_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_221_1.actors_["10066ui_story"].transform.localEulerAngles = arg_221_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_224_1 = arg_221_1.actors_["10066ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect10066ui_story == nil then
				arg_221_1.var_.characterEffect10066ui_story = var_224_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_2 and not isNil(var_224_1) then
				if arg_221_1.var_.characterEffect10066ui_story and not isNil(var_224_1) then
					arg_221_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= 0 + var_224_2 and arg_221_1.time_ < 0 + var_224_2 + arg_224_0 and not isNil(var_224_1) and arg_221_1.var_.characterEffect10066ui_story then
				arg_221_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_224_4 = arg_221_1.actors_["10058ui_story"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_4) and arg_221_1.var_.characterEffect10058ui_story == nil then
				arg_221_1.var_.characterEffect10058ui_story = var_224_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_5 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_5 and not isNil(var_224_4) then
				if arg_221_1.var_.characterEffect10058ui_story and not isNil(var_224_4) then
					arg_221_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_221_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_5)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_5 and arg_221_1.time_ < 0 + var_224_5 + arg_224_0 and not isNil(var_224_4) and arg_221_1.var_.characterEffect10058ui_story then
				arg_221_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_221_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_224_6 = 0
			local var_224_7 = 0.25

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_6 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_8 = arg_221_1:GetWordFromCfg(319651054)
				local var_224_9 = arg_221_1:FormatText(var_224_8.content)

				arg_221_1.text_.text = var_224_9

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_11 = 10 <= 0 and var_224_7 or var_224_7 * (utf8.len(var_224_9) / 10)

				if (10 <= 0 and var_224_7 or var_224_7 * (utf8.len(var_224_9) / 10)) > 0 and var_224_7 < var_224_11 then
					arg_221_1.talkMaxDuration = var_224_11

					if var_224_11 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_11 + var_224_6
					end
				end

				arg_221_1.text_.text = var_224_9
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651054", "story_v_out_319651.awb") ~= 0 then
					local var_224_12 = manager.audio:GetVoiceLength("story_v_out_319651", "319651054", "story_v_out_319651.awb") / 1000

					if var_224_12 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_12 + var_224_6
					end

					if var_224_8.prefab_name ~= "" and arg_221_1.actors_[var_224_8.prefab_name] ~= nil then
						local var_224_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_8.prefab_name].transform, "story_v_out_319651", "319651054", "story_v_out_319651.awb")

						arg_221_1:RecordAudio("319651054", var_224_13)
						arg_221_1:RecordAudio("319651054", var_224_13)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_319651", "319651054", "story_v_out_319651.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_319651", "319651054", "story_v_out_319651.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_14 = math.max(var_224_7, arg_221_1.talkMaxDuration)

			if var_224_6 <= arg_221_1.time_ and arg_221_1.time_ < var_224_6 + var_224_14 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_6) / var_224_14

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_6 + var_224_14 and arg_221_1.time_ < var_224_6 + var_224_14 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play319651055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 319651055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play319651056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10058ui_story = arg_225_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_228_0 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 then
				arg_225_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_225_1.time_ - 0) / var_228_0)
				arg_225_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["10058ui_story"].transform.position).z)
				arg_225_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["10058ui_story"].transform.localEulerAngles = arg_225_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 then
				arg_225_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_225_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["10058ui_story"].transform.position).z)
				arg_225_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["10058ui_story"].transform.localEulerAngles = arg_225_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_228_1 = arg_225_1.actors_["10058ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect10058ui_story == nil then
				arg_225_1.var_.characterEffect10058ui_story = var_228_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_2 and not isNil(var_228_1) then
				if arg_225_1.var_.characterEffect10058ui_story and not isNil(var_228_1) then
					arg_225_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_225_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_2)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_2 and arg_225_1.time_ < 0 + var_228_2 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect10058ui_story then
				arg_225_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_225_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_228_3 = arg_225_1.actors_["10066ui_story"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10066ui_story = var_228_3.localPosition
			end

			local var_228_4 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				var_228_3.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_225_1.time_ - 0) / var_228_4)
				var_228_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_3.position).x, (manager.ui.mainCamera.transform.position - var_228_3.position).y, (manager.ui.mainCamera.transform.position - var_228_3.position).z)
				var_228_3.localEulerAngles.z = 0
				var_228_3.localEulerAngles.x = 0
				var_228_3.localEulerAngles = var_228_3.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				var_228_3.localPosition = Vector3.New(0, 100, 0)
				var_228_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_228_3.position).x, (manager.ui.mainCamera.transform.position - var_228_3.position).y, (manager.ui.mainCamera.transform.position - var_228_3.position).z)
				var_228_3.localEulerAngles.z = 0
				var_228_3.localEulerAngles.x = 0
				var_228_3.localEulerAngles = var_228_3.localEulerAngles
			end

			local var_228_5 = arg_225_1.actors_["10066ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_5) and arg_225_1.var_.characterEffect10066ui_story == nil then
				arg_225_1.var_.characterEffect10066ui_story = var_228_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_6 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_6 and not isNil(var_228_5) then
				if arg_225_1.var_.characterEffect10066ui_story and not isNil(var_228_5) then
					arg_225_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_225_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_225_1.time_ - 0) / var_228_6)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_6 and arg_225_1.time_ < 0 + var_228_6 + arg_228_0 and not isNil(var_228_5) and arg_225_1.var_.characterEffect10066ui_story then
				arg_225_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_225_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_228_7 = 0
			local var_228_8 = 0.7

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_7 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_9 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(319651055).content)

				arg_225_1.text_.text = var_228_9

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_11 = 28 <= 0 and var_228_8 or var_228_8 * (utf8.len(var_228_9) / 28)

				if (28 <= 0 and var_228_8 or var_228_8 * (utf8.len(var_228_9) / 28)) > 0 and var_228_8 < var_228_11 then
					arg_225_1.talkMaxDuration = var_228_11

					if var_228_11 + var_228_7 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_11 + var_228_7
					end
				end

				arg_225_1.text_.text = var_228_9
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_12 = math.max(var_228_8, arg_225_1.talkMaxDuration)

			if var_228_7 <= arg_225_1.time_ and arg_225_1.time_ < var_228_7 + var_228_12 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_7) / var_228_12

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_7 + var_228_12 and arg_225_1.time_ < var_228_7 + var_228_12 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play319651056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 319651056
		arg_229_1.duration_ = 5.63

		local var_229_0 = {
			zh = 3.7,
			ja = 5.633
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
				arg_229_0:Play319651057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos10066ui_story = arg_229_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_232_0 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 then
				arg_229_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_229_1.time_ - 0) / var_232_0)
				arg_229_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10066ui_story"].transform.position).z)
				arg_229_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["10066ui_story"].transform.localEulerAngles = arg_229_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 then
				arg_229_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_229_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["10066ui_story"].transform.position).z)
				arg_229_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["10066ui_story"].transform.localEulerAngles = arg_229_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_232_1 = arg_229_1.actors_["10066ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect10066ui_story == nil then
				arg_229_1.var_.characterEffect10066ui_story = var_232_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_2 and not isNil(var_232_1) then
				if arg_229_1.var_.characterEffect10066ui_story and not isNil(var_232_1) then
					arg_229_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_2 and arg_229_1.time_ < 0 + var_232_2 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect10066ui_story then
				arg_229_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_2")
			end

			local var_232_4 = 0
			local var_232_5 = 0.45

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_6 = arg_229_1:GetWordFromCfg(319651056)
				local var_232_7 = arg_229_1:FormatText(var_232_6.content)

				arg_229_1.text_.text = var_232_7

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_9 = 18 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 18)

				if (18 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 18)) > 0 and var_232_5 < var_232_9 then
					arg_229_1.talkMaxDuration = var_232_9

					if var_232_9 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_9 + var_232_4
					end
				end

				arg_229_1.text_.text = var_232_7
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651056", "story_v_out_319651.awb") ~= 0 then
					local var_232_10 = manager.audio:GetVoiceLength("story_v_out_319651", "319651056", "story_v_out_319651.awb") / 1000

					if var_232_10 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_4
					end

					if var_232_6.prefab_name ~= "" and arg_229_1.actors_[var_232_6.prefab_name] ~= nil then
						local var_232_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_6.prefab_name].transform, "story_v_out_319651", "319651056", "story_v_out_319651.awb")

						arg_229_1:RecordAudio("319651056", var_232_11)
						arg_229_1:RecordAudio("319651056", var_232_11)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_319651", "319651056", "story_v_out_319651.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_319651", "319651056", "story_v_out_319651.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_12 = math.max(var_232_5, arg_229_1.talkMaxDuration)

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_12 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_4) / var_232_12

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_4 + var_232_12 and arg_229_1.time_ < var_232_4 + var_232_12 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play319651057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 319651057
		arg_233_1.duration_ = 2.5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play319651058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos1084ui_story = arg_233_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1084ui_story"].transform.position).z)
				arg_233_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1084ui_story"].transform.localEulerAngles = arg_233_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["1084ui_story"].transform.position).z)
				arg_233_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["1084ui_story"].transform.localEulerAngles = arg_233_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_236_1 = arg_233_1.actors_["10066ui_story"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos10066ui_story = var_236_1.localPosition
			end

			local var_236_2 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 then
				var_236_1.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_233_1.time_ - 0) / var_236_2)
				var_236_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_1.position).x, (manager.ui.mainCamera.transform.position - var_236_1.position).y, (manager.ui.mainCamera.transform.position - var_236_1.position).z)
				var_236_1.localEulerAngles.z = 0
				var_236_1.localEulerAngles.x = 0
				var_236_1.localEulerAngles = var_236_1.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 then
				var_236_1.localPosition = Vector3.New(0, 100, 0)
				var_236_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_1.position).x, (manager.ui.mainCamera.transform.position - var_236_1.position).y, (manager.ui.mainCamera.transform.position - var_236_1.position).z)
				var_236_1.localEulerAngles.z = 0
				var_236_1.localEulerAngles.x = 0
				var_236_1.localEulerAngles = var_236_1.localEulerAngles
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				local var_236_3 = arg_233_1.fswbg_.transform:Find("textbox/adapt/content") or arg_233_1.fswbg_.transform:Find("textbox/content")
				local var_236_4 = arg_233_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_236_5 = var_236_3:GetComponent("RectTransform")

				var_236_3:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_236_5.offsetMin = Vector2.New(0, 0)
				var_236_5.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.fswbg_:SetActive(true)
				arg_233_1.dialog_:SetActive(false)

				arg_233_1.fswtw_.percent = 0
				arg_233_1.fswt_.text = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(319651057).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.fswt_)

				arg_233_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_233_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_233_1.fswtw_:SetDirty()

				arg_233_1.typewritterCharCountI18N = 0

				SetActive(arg_233_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_233_1:ShowNextGo(false)
			end

			local var_236_6 = 0.149999999998999

			if 0.149999999998999 < arg_233_1.time_ and arg_233_1.time_ <= var_236_6 + arg_236_0 then
				arg_233_1.var_.oldValueTypewriter = arg_233_1.fswtw_.percent

				SetActive(arg_233_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_233_1:ShowNextGo(false)
			end

			local var_236_7 = 0
			local var_236_8 = 0
			local var_236_9, var_236_10 = arg_233_1:GetPercentByPara(arg_233_1:FormatText(arg_233_1:GetWordFromCfg(319651057).content), 1)

			if var_236_6 < arg_233_1.time_ and arg_233_1.time_ <= var_236_6 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				local var_236_11 = var_236_7 <= 0 and var_236_8 or var_236_8 * ((var_236_10 - arg_233_1.typewritterCharCountI18N) / var_236_7)

				if (var_236_7 <= 0 and var_236_8 or var_236_8 * ((var_236_10 - arg_233_1.typewritterCharCountI18N) / var_236_7)) > 0 and var_236_8 < var_236_11 then
					arg_233_1.talkMaxDuration = var_236_11

					if var_236_11 + var_236_6 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_11 + var_236_6
					end
				end
			end

			local var_236_12 = math.max(0, arg_233_1.talkMaxDuration)

			if var_236_6 <= arg_233_1.time_ and arg_233_1.time_ < var_236_6 + var_236_12 then
				arg_233_1.fswtw_.percent = Mathf.Lerp(arg_233_1.var_.oldValueTypewriter, var_236_9, (arg_233_1.time_ - var_236_6) / var_236_12)
				arg_233_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_233_1.fswtw_:SetDirty()
			end

			if arg_233_1.time_ >= var_236_6 + var_236_12 and arg_233_1.time_ < var_236_6 + var_236_12 + arg_236_0 then
				arg_233_1.fswtw_.percent = var_236_9

				arg_233_1.fswtw_:SetDirty()
				arg_233_1:ShowNextGo(true)

				arg_233_1.typewritterCharCountI18N = var_236_10
			end

			local var_236_13 = 0.366666666666667

			if 0.366666666666667 < arg_233_1.time_ and arg_233_1.time_ <= var_236_13 + arg_236_0 then
				arg_233_1.var_.oldValueTypewriter = arg_233_1.fswtw_.percent

				SetActive(arg_233_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_233_1:ShowNextGo(false)
			end

			local var_236_14 = 8
			local var_236_15 = 0.533333333333333
			local var_236_16, var_236_17 = arg_233_1:GetPercentByPara(arg_233_1:FormatText(arg_233_1:GetWordFromCfg(319651057).content), 1)

			if var_236_13 < arg_233_1.time_ and arg_233_1.time_ <= var_236_13 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				local var_236_18 = var_236_14 <= 0 and var_236_15 or var_236_15 * ((var_236_17 - arg_233_1.typewritterCharCountI18N) / var_236_14)

				if (var_236_14 <= 0 and var_236_15 or var_236_15 * ((var_236_17 - arg_233_1.typewritterCharCountI18N) / var_236_14)) > 0 and var_236_15 < var_236_18 then
					arg_233_1.talkMaxDuration = var_236_18

					if var_236_18 + var_236_13 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_18 + var_236_13
					end
				end
			end

			local var_236_19 = math.max(0.533333333333333, arg_233_1.talkMaxDuration)

			if var_236_13 <= arg_233_1.time_ and arg_233_1.time_ < var_236_13 + var_236_19 then
				arg_233_1.fswtw_.percent = Mathf.Lerp(arg_233_1.var_.oldValueTypewriter, var_236_16, (arg_233_1.time_ - var_236_13) / var_236_19)
				arg_233_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_233_1.fswtw_:SetDirty()
			end

			if arg_233_1.time_ >= var_236_13 + var_236_19 and arg_233_1.time_ < var_236_13 + var_236_19 + arg_236_0 then
				arg_233_1.fswtw_.percent = var_236_16

				arg_233_1.fswtw_:SetDirty()
				arg_233_1:ShowNextGo(true)

				arg_233_1.typewritterCharCountI18N = var_236_17
			end

			local var_236_20 = "STblack"

			if arg_233_1.bgs_.STblack == nil then
				local var_236_21 = Object.Instantiate(arg_233_1.paintGo_)

				var_236_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_236_20)
				var_236_21.name = var_236_20
				var_236_21.transform.parent = arg_233_1.stage_.transform
				var_236_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.bgs_[var_236_20] = var_236_21
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				local var_236_22 = arg_233_1.bgs_.STblack

				arg_233_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_236_22.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_236_23 = var_236_22:GetComponent("SpriteRenderer")

				if var_236_23 and var_236_23.sprite then
					local var_236_24 = 2 * (var_236_22.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_236_22.transform.localScale = Vector3.New(var_236_24 / var_236_23.sprite.bounds.size.y < var_236_24 * manager.ui.mainCameraCom_.aspect / var_236_23.sprite.bounds.size.x and var_236_24 * manager.ui.mainCameraCom_.aspect / var_236_23.sprite.bounds.size.x or var_236_24 / var_236_23.sprite.bounds.size.y, var_236_24 / var_236_23.sprite.bounds.size.y < var_236_24 * manager.ui.mainCameraCom_.aspect / var_236_23.sprite.bounds.size.x and var_236_24 * manager.ui.mainCameraCom_.aspect / var_236_23.sprite.bounds.size.x or var_236_24 / var_236_23.sprite.bounds.size.y, 0)
				end

				for iter_236_0, iter_236_1 in pairs(arg_233_1.bgs_) do
					if iter_236_0 ~= "STblack" then
						iter_236_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_236_25 = 0.366666666666667
			local var_236_26 = manager.audio:GetVoiceLength("story_v_out_319651", "319651057", "story_v_out_319651.awb") / 1000

			if var_236_26 > 0 and 2.133 < var_236_26 and var_236_26 + var_236_25 > arg_233_1.duration_ then
				arg_233_1.duration_ = var_236_26 + var_236_25
			end

			if var_236_25 < arg_233_1.time_ and arg_233_1.time_ <= var_236_25 + arg_236_0 then
				arg_233_1:AudioAction("play", "voice", "story_v_out_319651", "319651057", "story_v_out_319651.awb")
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.cswbg_:SetActive(true)

				local var_236_28 = arg_233_1.cswt_:GetComponent("RectTransform")

				arg_233_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_236_28.offsetMin = Vector2.New(410, 330)
				var_236_28.offsetMax = Vector2.New(-400, -175)
				arg_233_1.cswt_.text = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(419037).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.cswt_)

				arg_233_1.cswt_.fontSize = 180
				arg_233_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_233_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_233_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play319651058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 319651058
		arg_237_1.duration_ = 1

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play319651059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.fswbg_:SetActive(true)
				arg_237_1.dialog_:SetActive(false)

				arg_237_1.fswtw_.percent = 0
				arg_237_1.fswt_.text = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(319651058).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.fswt_)

				arg_237_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_237_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_237_1.fswtw_:SetDirty()

				arg_237_1.typewritterCharCountI18N = 0

				SetActive(arg_237_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_237_1:ShowNextGo(false)
			end

			local var_240_0 = 0.149999999998999

			if 0.149999999998999 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.var_.oldValueTypewriter = arg_237_1.fswtw_.percent

				SetActive(arg_237_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_237_1:ShowNextGo(false)
			end

			local var_240_1 = 0
			local var_240_2 = 0
			local var_240_3, var_240_4 = arg_237_1:GetPercentByPara(arg_237_1:FormatText(arg_237_1:GetWordFromCfg(319651058).content), 1)

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0

				local var_240_5 = var_240_1 <= 0 and var_240_2 or var_240_2 * ((var_240_4 - arg_237_1.typewritterCharCountI18N) / var_240_1)

				if (var_240_1 <= 0 and var_240_2 or var_240_2 * ((var_240_4 - arg_237_1.typewritterCharCountI18N) / var_240_1)) > 0 and var_240_2 < var_240_5 then
					arg_237_1.talkMaxDuration = var_240_5

					if var_240_5 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + var_240_0
					end
				end
			end

			local var_240_6 = math.max(0, arg_237_1.talkMaxDuration)

			if var_240_0 <= arg_237_1.time_ and arg_237_1.time_ < var_240_0 + var_240_6 then
				arg_237_1.fswtw_.percent = Mathf.Lerp(arg_237_1.var_.oldValueTypewriter, var_240_3, (arg_237_1.time_ - var_240_0) / var_240_6)
				arg_237_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_237_1.fswtw_:SetDirty()
			end

			if arg_237_1.time_ >= var_240_0 + var_240_6 and arg_237_1.time_ < var_240_0 + var_240_6 + arg_240_0 then
				arg_237_1.fswtw_.percent = var_240_3

				arg_237_1.fswtw_:SetDirty()
				arg_237_1:ShowNextGo(true)

				arg_237_1.typewritterCharCountI18N = var_240_4
			end

			local var_240_7 = 0.15

			if 0.15 < arg_237_1.time_ and arg_237_1.time_ <= var_240_7 + arg_240_0 then
				arg_237_1.var_.oldValueTypewriter = arg_237_1.fswtw_.percent

				SetActive(arg_237_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_237_1:ShowNextGo(false)
			end

			local var_240_8 = 14
			local var_240_9 = 0.533333333333333
			local var_240_10, var_240_11 = arg_237_1:GetPercentByPara(arg_237_1:FormatText(arg_237_1:GetWordFromCfg(319651058).content), 1)

			if var_240_7 < arg_237_1.time_ and arg_237_1.time_ <= var_240_7 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0

				local var_240_12 = var_240_8 <= 0 and var_240_9 or var_240_9 * ((var_240_11 - arg_237_1.typewritterCharCountI18N) / var_240_8)

				if (var_240_8 <= 0 and var_240_9 or var_240_9 * ((var_240_11 - arg_237_1.typewritterCharCountI18N) / var_240_8)) > 0 and var_240_9 < var_240_12 then
					arg_237_1.talkMaxDuration = var_240_12

					if var_240_12 + var_240_7 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_12 + var_240_7
					end
				end
			end

			local var_240_13 = math.max(0.533333333333333, arg_237_1.talkMaxDuration)

			if var_240_7 <= arg_237_1.time_ and arg_237_1.time_ < var_240_7 + var_240_13 then
				arg_237_1.fswtw_.percent = Mathf.Lerp(arg_237_1.var_.oldValueTypewriter, var_240_10, (arg_237_1.time_ - var_240_7) / var_240_13)
				arg_237_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_237_1.fswtw_:SetDirty()
			end

			if arg_237_1.time_ >= var_240_7 + var_240_13 and arg_237_1.time_ < var_240_7 + var_240_13 + arg_240_0 then
				arg_237_1.fswtw_.percent = var_240_10

				arg_237_1.fswtw_:SetDirty()
				arg_237_1:ShowNextGo(true)

				arg_237_1.typewritterCharCountI18N = var_240_11
			end

			local var_240_14 = 0
			local var_240_15 = manager.audio:GetVoiceLength("story_v_out_319651", "319651058", "story_v_out_319651.awb") / 1000

			if var_240_15 > 0 and 1 < var_240_15 and var_240_15 + var_240_14 > arg_237_1.duration_ then
				arg_237_1.duration_ = var_240_15 + var_240_14
			end

			if var_240_14 < arg_237_1.time_ and arg_237_1.time_ <= var_240_14 + arg_240_0 then
				arg_237_1:AudioAction("play", "voice", "story_v_out_319651", "319651058", "story_v_out_319651.awb")
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play319651059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 319651059
		arg_241_1.duration_ = 1.07

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play319651060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.fswbg_:SetActive(true)
				arg_241_1.dialog_:SetActive(false)

				arg_241_1.fswtw_.percent = 0
				arg_241_1.fswt_.text = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(319651059).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.fswt_)

				arg_241_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_241_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_241_1.fswtw_:SetDirty()

				arg_241_1.typewritterCharCountI18N = 0

				SetActive(arg_241_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_241_1:ShowNextGo(false)
			end

			local var_244_0 = 0.0666666666666667

			if 0.0666666666666667 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.var_.oldValueTypewriter = arg_241_1.fswtw_.percent

				SetActive(arg_241_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_241_1:ShowNextGo(false)
			end

			local var_244_1 = 13
			local var_244_2 = 0.866666666666667
			local var_244_3, var_244_4 = arg_241_1:GetPercentByPara(arg_241_1:FormatText(arg_241_1:GetWordFromCfg(319651059).content), 1)

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0

				local var_244_5 = var_244_1 <= 0 and var_244_2 or var_244_2 * ((var_244_4 - arg_241_1.typewritterCharCountI18N) / var_244_1)

				if (var_244_1 <= 0 and var_244_2 or var_244_2 * ((var_244_4 - arg_241_1.typewritterCharCountI18N) / var_244_1)) > 0 and var_244_2 < var_244_5 then
					arg_241_1.talkMaxDuration = var_244_5

					if var_244_5 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + var_244_0
					end
				end
			end

			local var_244_6 = math.max(0.866666666666667, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_6 then
				arg_241_1.fswtw_.percent = Mathf.Lerp(arg_241_1.var_.oldValueTypewriter, var_244_3, (arg_241_1.time_ - var_244_0) / var_244_6)
				arg_241_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_241_1.fswtw_:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_6 and arg_241_1.time_ < var_244_0 + var_244_6 + arg_244_0 then
				arg_241_1.fswtw_.percent = var_244_3

				arg_241_1.fswtw_:SetDirty()
				arg_241_1:ShowNextGo(true)

				arg_241_1.typewritterCharCountI18N = var_244_4
			end

			local var_244_7 = 0.149999999998999

			if 0.149999999998999 < arg_241_1.time_ and arg_241_1.time_ <= var_244_7 + arg_244_0 then
				arg_241_1.var_.oldValueTypewriter = arg_241_1.fswtw_.percent

				SetActive(arg_241_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_241_1:ShowNextGo(false)
			end

			local var_244_8 = 0
			local var_244_9 = 0
			local var_244_10, var_244_11 = arg_241_1:GetPercentByPara(arg_241_1:FormatText(arg_241_1:GetWordFromCfg(319651059).content), 1)

			if var_244_7 < arg_241_1.time_ and arg_241_1.time_ <= var_244_7 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0

				local var_244_12 = var_244_8 <= 0 and var_244_9 or var_244_9 * ((var_244_11 - arg_241_1.typewritterCharCountI18N) / var_244_8)

				if (var_244_8 <= 0 and var_244_9 or var_244_9 * ((var_244_11 - arg_241_1.typewritterCharCountI18N) / var_244_8)) > 0 and var_244_9 < var_244_12 then
					arg_241_1.talkMaxDuration = var_244_12

					if var_244_12 + var_244_7 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_12 + var_244_7
					end
				end
			end

			local var_244_13 = math.max(0, arg_241_1.talkMaxDuration)

			if var_244_7 <= arg_241_1.time_ and arg_241_1.time_ < var_244_7 + var_244_13 then
				arg_241_1.fswtw_.percent = Mathf.Lerp(arg_241_1.var_.oldValueTypewriter, var_244_10, (arg_241_1.time_ - var_244_7) / var_244_13)
				arg_241_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_241_1.fswtw_:SetDirty()
			end

			if arg_241_1.time_ >= var_244_7 + var_244_13 and arg_241_1.time_ < var_244_7 + var_244_13 + arg_244_0 then
				arg_241_1.fswtw_.percent = var_244_10

				arg_241_1.fswtw_:SetDirty()
				arg_241_1:ShowNextGo(true)

				arg_241_1.typewritterCharCountI18N = var_244_11
			end

			local var_244_14 = 0.0666666666666667
			local var_244_15 = manager.audio:GetVoiceLength("story_v_out_319651", "319651059", "story_v_out_319651.awb") / 1000

			if var_244_15 > 0 and 1 < var_244_15 and var_244_15 + var_244_14 > arg_241_1.duration_ then
				arg_241_1.duration_ = var_244_15 + var_244_14
			end

			if var_244_14 < arg_241_1.time_ and arg_241_1.time_ <= var_244_14 + arg_244_0 then
				arg_241_1:AudioAction("play", "voice", "story_v_out_319651", "319651059", "story_v_out_319651.awb")
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play319651060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 319651060
		arg_245_1.duration_ = 11.3

		local var_245_0 = {
			zh = 4.73300000298023,
			ja = 11.3000000029802
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
				arg_245_0:Play319651061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				local var_248_0 = arg_245_1.bgs_.ST74

				arg_245_1.bgs_.ST74.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_248_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_248_1 = var_248_0:GetComponent("SpriteRenderer")

				if var_248_1 and var_248_1.sprite then
					local var_248_2 = 2 * (var_248_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_248_0.transform.localScale = Vector3.New(var_248_2 / var_248_1.sprite.bounds.size.y < var_248_2 * manager.ui.mainCameraCom_.aspect / var_248_1.sprite.bounds.size.x and var_248_2 * manager.ui.mainCameraCom_.aspect / var_248_1.sprite.bounds.size.x or var_248_2 / var_248_1.sprite.bounds.size.y, var_248_2 / var_248_1.sprite.bounds.size.y < var_248_2 * manager.ui.mainCameraCom_.aspect / var_248_1.sprite.bounds.size.x and var_248_2 * manager.ui.mainCameraCom_.aspect / var_248_1.sprite.bounds.size.x or var_248_2 / var_248_1.sprite.bounds.size.y, 0)
				end

				for iter_248_0, iter_248_1 in pairs(arg_245_1.bgs_) do
					if iter_248_0 ~= "ST74" then
						iter_248_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_248_3 = 0

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_3 + arg_248_0 then
				arg_245_1.allBtn_.enabled = false
			end

			if arg_245_1.time_ >= var_248_3 + 0.3 and arg_245_1.time_ < var_248_3 + 0.3 + arg_248_0 then
				arg_245_1.allBtn_.enabled = true
			end

			local var_248_4 = 0

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_4 + arg_248_0 then
				arg_245_1.mask_.enabled = true
				arg_245_1.mask_.raycastTarget = true

				arg_245_1:SetGaussion(false)
			end

			local var_248_5 = 1.3

			if var_248_4 <= arg_245_1.time_ and arg_245_1.time_ < var_248_4 + var_248_5 then
				local var_248_6 = Color.New(0, 0, 0)

				var_248_6.a = Mathf.Lerp(1, 0, (arg_245_1.time_ - var_248_4) / var_248_5)
				arg_245_1.mask_.color = var_248_6
			end

			if arg_245_1.time_ >= var_248_4 + var_248_5 and arg_245_1.time_ < var_248_4 + var_248_5 + arg_248_0 then
				local var_248_7 = Color.New(0, 0, 0)

				arg_245_1.mask_.enabled = false
				var_248_7.a = 0
				arg_245_1.mask_.color = var_248_7
			end

			local var_248_8 = arg_245_1.actors_["1084ui_story"].transform

			if 1.3 < arg_245_1.time_ and arg_245_1.time_ <= 1.3 + arg_248_0 then
				arg_245_1.var_.moveOldPos1084ui_story = var_248_8.localPosition

				arg_245_1:ShowWeapon(arg_245_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_248_9 = 0.001

			if 1.3 <= arg_245_1.time_ and arg_245_1.time_ < 1.3 + var_248_9 then
				var_248_8.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_245_1.time_ - 1.3) / var_248_9)
				var_248_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_8.position).x, (manager.ui.mainCamera.transform.position - var_248_8.position).y, (manager.ui.mainCamera.transform.position - var_248_8.position).z)
				var_248_8.localEulerAngles.z = 0
				var_248_8.localEulerAngles.x = 0
				var_248_8.localEulerAngles = var_248_8.localEulerAngles
			end

			if arg_245_1.time_ >= 1.3 + var_248_9 and arg_245_1.time_ < 1.3 + var_248_9 + arg_248_0 then
				var_248_8.localPosition = Vector3.New(0, -0.97, -6)
				var_248_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_248_8.position).x, (manager.ui.mainCamera.transform.position - var_248_8.position).y, (manager.ui.mainCamera.transform.position - var_248_8.position).z)
				var_248_8.localEulerAngles.z = 0
				var_248_8.localEulerAngles.x = 0
				var_248_8.localEulerAngles = var_248_8.localEulerAngles
			end

			local var_248_10 = arg_245_1.actors_["1084ui_story"]

			if 1.3 < arg_245_1.time_ and arg_245_1.time_ <= 1.3 + arg_248_0 and not isNil(var_248_10) and arg_245_1.var_.characterEffect1084ui_story == nil then
				arg_245_1.var_.characterEffect1084ui_story = var_248_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_11 = 0.200000002980232

			if 1.3 <= arg_245_1.time_ and arg_245_1.time_ < 1.3 + var_248_11 and not isNil(var_248_10) then
				if arg_245_1.var_.characterEffect1084ui_story and not isNil(var_248_10) then
					arg_245_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= 1.3 + var_248_11 and arg_245_1.time_ < 1.3 + var_248_11 + arg_248_0 and not isNil(var_248_10) and arg_245_1.var_.characterEffect1084ui_story then
				arg_245_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 1.3 < arg_245_1.time_ and arg_245_1.time_ <= 1.3 + arg_248_0 then
				arg_245_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 1.3 < arg_245_1.time_ and arg_245_1.time_ <= 1.3 + arg_248_0 then
				arg_245_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.fswbg_:SetActive(false)
				arg_245_1.dialog_:SetActive(false)
				SetActive(arg_245_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_245_1:ShowNextGo(false)
			end

			local var_248_13 = 0.149999999998999

			if 0.149999999998999 < arg_245_1.time_ and arg_245_1.time_ <= var_248_13 + arg_248_0 then
				arg_245_1.var_.oldValueTypewriter = arg_245_1.fswtw_.percent

				SetActive(arg_245_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_245_1:ShowNextGo(false)
			end

			local var_248_14 = 0
			local var_248_15 = 0
			local var_248_16, var_248_17 = arg_245_1:GetPercentByPara(arg_245_1:FormatText(arg_245_1:GetWordFromCfg(319651059).content), 1)

			if var_248_13 < arg_245_1.time_ and arg_245_1.time_ <= var_248_13 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0

				local var_248_18 = var_248_14 <= 0 and var_248_15 or var_248_15 * ((var_248_17 - arg_245_1.typewritterCharCountI18N) / var_248_14)

				if (var_248_14 <= 0 and var_248_15 or var_248_15 * ((var_248_17 - arg_245_1.typewritterCharCountI18N) / var_248_14)) > 0 and var_248_15 < var_248_18 then
					arg_245_1.talkMaxDuration = var_248_18

					if var_248_18 + var_248_13 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_18 + var_248_13
					end
				end
			end

			local var_248_19 = math.max(0, arg_245_1.talkMaxDuration)

			if var_248_13 <= arg_245_1.time_ and arg_245_1.time_ < var_248_13 + var_248_19 then
				arg_245_1.fswtw_.percent = Mathf.Lerp(arg_245_1.var_.oldValueTypewriter, var_248_16, (arg_245_1.time_ - var_248_13) / var_248_19)
				arg_245_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_245_1.fswtw_:SetDirty()
			end

			if arg_245_1.time_ >= var_248_13 + var_248_19 and arg_245_1.time_ < var_248_13 + var_248_19 + arg_248_0 then
				arg_245_1.fswtw_.percent = var_248_16

				arg_245_1.fswtw_:SetDirty()
				arg_245_1:ShowNextGo(true)

				arg_245_1.typewritterCharCountI18N = var_248_17
			end

			if 0.15 < arg_245_1.time_ and arg_245_1.time_ <= 0.15 + arg_248_0 then
				arg_245_1.fswbg_:SetActive(false)
				arg_245_1.dialog_:SetActive(false)
				SetActive(arg_245_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_245_1:ShowNextGo(false)
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.cswbg_:SetActive(false)
			end

			if arg_245_1.frameCnt_ <= 1 then
				arg_245_1.dialog_:SetActive(false)
			end

			local var_248_20 = 1.50000000298023
			local var_248_21 = 0.4

			if 1.50000000298023 < arg_245_1.time_ and arg_245_1.time_ <= var_248_20 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0

				arg_245_1.dialog_:SetActive(true)

				arg_245_1.dialogCg_.alpha = 0

				local var_248_22 = LeanTween.value(arg_245_1.dialog_, 0, 1, 0.3)

				var_248_22:setOnUpdate(LuaHelper.FloatAction(function(arg_249_0)
					arg_245_1.dialogCg_.alpha = arg_249_0
				end))
				var_248_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_245_1.dialog_)
					var_248_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_245_1.duration_ = arg_245_1.duration_ + 0.3

				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_23 = arg_245_1:GetWordFromCfg(319651060)
				local var_248_24 = arg_245_1:FormatText(var_248_23.content)

				arg_245_1.text_.text = var_248_24

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_26 = 16 <= 0 and var_248_21 or var_248_21 * (utf8.len(var_248_24) / 16)

				if (16 <= 0 and var_248_21 or var_248_21 * (utf8.len(var_248_24) / 16)) > 0 and var_248_21 < var_248_26 then
					arg_245_1.talkMaxDuration = var_248_26
					var_248_20 = var_248_20 + 0.3

					if var_248_26 + var_248_20 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_26 + var_248_20
					end
				end

				arg_245_1.text_.text = var_248_24
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651060", "story_v_out_319651.awb") ~= 0 then
					local var_248_27 = manager.audio:GetVoiceLength("story_v_out_319651", "319651060", "story_v_out_319651.awb") / 1000

					if var_248_27 + var_248_20 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_27 + var_248_20
					end

					if var_248_23.prefab_name ~= "" and arg_245_1.actors_[var_248_23.prefab_name] ~= nil then
						local var_248_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_23.prefab_name].transform, "story_v_out_319651", "319651060", "story_v_out_319651.awb")

						arg_245_1:RecordAudio("319651060", var_248_28)
						arg_245_1:RecordAudio("319651060", var_248_28)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_319651", "319651060", "story_v_out_319651.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_319651", "319651060", "story_v_out_319651.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_29 = var_248_20 + 0.3
			local var_248_30 = math.max(var_248_21, arg_245_1.talkMaxDuration)

			if var_248_20 + 0.3 <= arg_245_1.time_ and arg_245_1.time_ < var_248_29 + var_248_30 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_29) / var_248_30

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_29 + var_248_30 and arg_245_1.time_ < var_248_29 + var_248_30 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play319651061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 319651061
		arg_251_1.duration_ = 10.13

		local var_251_0 = {
			zh = 7.533,
			ja = 10.133
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play319651062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos10066ui_story = arg_251_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_254_0 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 then
				arg_251_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_251_1.time_ - 0) / var_254_0)
				arg_251_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10066ui_story"].transform.position).z)
				arg_251_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["10066ui_story"].transform.localEulerAngles = arg_251_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 then
				arg_251_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_251_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["10066ui_story"].transform.position).z)
				arg_251_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["10066ui_story"].transform.localEulerAngles = arg_251_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_254_1 = arg_251_1.actors_["10066ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect10066ui_story == nil then
				arg_251_1.var_.characterEffect10066ui_story = var_254_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_2 and not isNil(var_254_1) then
				if arg_251_1.var_.characterEffect10066ui_story and not isNil(var_254_1) then
					arg_251_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_2 and arg_251_1.time_ < 0 + var_254_2 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect10066ui_story then
				arg_251_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_254_4 = arg_251_1.actors_["1084ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_4) and arg_251_1.var_.characterEffect1084ui_story == nil then
				arg_251_1.var_.characterEffect1084ui_story = var_254_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_5 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_5 and not isNil(var_254_4) then
				if arg_251_1.var_.characterEffect1084ui_story and not isNil(var_254_4) then
					arg_251_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_5)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_5 and arg_251_1.time_ < 0 + var_254_5 + arg_254_0 and not isNil(var_254_4) and arg_251_1.var_.characterEffect1084ui_story then
				arg_251_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_254_6 = arg_251_1.actors_["1084ui_story"].transform

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1084ui_story = var_254_6.localPosition
			end

			local var_254_7 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_7 then
				var_254_6.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_251_1.time_ - 0) / var_254_7)
				var_254_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_6.position).x, (manager.ui.mainCamera.transform.position - var_254_6.position).y, (manager.ui.mainCamera.transform.position - var_254_6.position).z)
				var_254_6.localEulerAngles.z = 0
				var_254_6.localEulerAngles.x = 0
				var_254_6.localEulerAngles = var_254_6.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_7 and arg_251_1.time_ < 0 + var_254_7 + arg_254_0 then
				var_254_6.localPosition = Vector3.New(0.7, -0.97, -6)
				var_254_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_6.position).x, (manager.ui.mainCamera.transform.position - var_254_6.position).y, (manager.ui.mainCamera.transform.position - var_254_6.position).z)
				var_254_6.localEulerAngles.z = 0
				var_254_6.localEulerAngles.x = 0
				var_254_6.localEulerAngles = var_254_6.localEulerAngles
			end

			local var_254_8 = 0
			local var_254_9 = 0.7

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_8 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_10 = arg_251_1:GetWordFromCfg(319651061)
				local var_254_11 = arg_251_1:FormatText(var_254_10.content)

				arg_251_1.text_.text = var_254_11

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_13 = 28 <= 0 and var_254_9 or var_254_9 * (utf8.len(var_254_11) / 28)

				if (28 <= 0 and var_254_9 or var_254_9 * (utf8.len(var_254_11) / 28)) > 0 and var_254_9 < var_254_13 then
					arg_251_1.talkMaxDuration = var_254_13

					if var_254_13 + var_254_8 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_13 + var_254_8
					end
				end

				arg_251_1.text_.text = var_254_11
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651061", "story_v_out_319651.awb") ~= 0 then
					local var_254_14 = manager.audio:GetVoiceLength("story_v_out_319651", "319651061", "story_v_out_319651.awb") / 1000

					if var_254_14 + var_254_8 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_14 + var_254_8
					end

					if var_254_10.prefab_name ~= "" and arg_251_1.actors_[var_254_10.prefab_name] ~= nil then
						local var_254_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_10.prefab_name].transform, "story_v_out_319651", "319651061", "story_v_out_319651.awb")

						arg_251_1:RecordAudio("319651061", var_254_15)
						arg_251_1:RecordAudio("319651061", var_254_15)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_319651", "319651061", "story_v_out_319651.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_319651", "319651061", "story_v_out_319651.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_16 = math.max(var_254_9, arg_251_1.talkMaxDuration)

			if var_254_8 <= arg_251_1.time_ and arg_251_1.time_ < var_254_8 + var_254_16 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_8) / var_254_16

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_8 + var_254_16 and arg_251_1.time_ < var_254_8 + var_254_16 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play319651062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 319651062
		arg_255_1.duration_ = 6.67

		local var_255_0 = {
			zh = 6.066,
			ja = 6.666
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
				arg_255_0:Play319651063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["10066ui_story"]) and arg_255_1.var_.characterEffect10066ui_story == nil then
				arg_255_1.var_.characterEffect10066ui_story = arg_255_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_0 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["10066ui_story"]) then
				if arg_255_1.var_.characterEffect10066ui_story and not isNil(arg_255_1.actors_["10066ui_story"]) then
					arg_255_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_255_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_0)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["10066ui_story"]) and arg_255_1.var_.characterEffect10066ui_story then
				arg_255_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_255_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_258_1 = arg_255_1.actors_["1084ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect1084ui_story == nil then
				arg_255_1.var_.characterEffect1084ui_story = var_258_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_2 and not isNil(var_258_1) then
				if arg_255_1.var_.characterEffect1084ui_story and not isNil(var_258_1) then
					arg_255_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_2 and arg_255_1.time_ < 0 + var_258_2 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect1084ui_story then
				arg_255_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_258_4 = 0
			local var_258_5 = 0.575

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_4 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_6 = arg_255_1:GetWordFromCfg(319651062)
				local var_258_7 = arg_255_1:FormatText(var_258_6.content)

				arg_255_1.text_.text = var_258_7

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_9 = 23 <= 0 and var_258_5 or var_258_5 * (utf8.len(var_258_7) / 23)

				if (23 <= 0 and var_258_5 or var_258_5 * (utf8.len(var_258_7) / 23)) > 0 and var_258_5 < var_258_9 then
					arg_255_1.talkMaxDuration = var_258_9

					if var_258_9 + var_258_4 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_9 + var_258_4
					end
				end

				arg_255_1.text_.text = var_258_7
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651062", "story_v_out_319651.awb") ~= 0 then
					local var_258_10 = manager.audio:GetVoiceLength("story_v_out_319651", "319651062", "story_v_out_319651.awb") / 1000

					if var_258_10 + var_258_4 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_10 + var_258_4
					end

					if var_258_6.prefab_name ~= "" and arg_255_1.actors_[var_258_6.prefab_name] ~= nil then
						local var_258_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_6.prefab_name].transform, "story_v_out_319651", "319651062", "story_v_out_319651.awb")

						arg_255_1:RecordAudio("319651062", var_258_11)
						arg_255_1:RecordAudio("319651062", var_258_11)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_319651", "319651062", "story_v_out_319651.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_319651", "319651062", "story_v_out_319651.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_12 = math.max(var_258_5, arg_255_1.talkMaxDuration)

			if var_258_4 <= arg_255_1.time_ and arg_255_1.time_ < var_258_4 + var_258_12 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_4) / var_258_12

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_4 + var_258_12 and arg_255_1.time_ < var_258_4 + var_258_12 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play319651063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 319651063
		arg_259_1.duration_ = 3.83

		local var_259_0 = {
			zh = 2.933,
			ja = 3.833
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
				arg_259_0:Play319651064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos10058ui_story = arg_259_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_262_0 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 then
				arg_259_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_259_1.time_ - 0) / var_262_0)
				arg_259_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10058ui_story"].transform.position).z)
				arg_259_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["10058ui_story"].transform.localEulerAngles = arg_259_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 then
				arg_259_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_259_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["10058ui_story"].transform.position).z)
				arg_259_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["10058ui_story"].transform.localEulerAngles = arg_259_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_262_1 = arg_259_1.actors_["10058ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect10058ui_story == nil then
				arg_259_1.var_.characterEffect10058ui_story = var_262_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_2 and not isNil(var_262_1) then
				if arg_259_1.var_.characterEffect10058ui_story and not isNil(var_262_1) then
					arg_259_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_2 and arg_259_1.time_ < 0 + var_262_2 + arg_262_0 and not isNil(var_262_1) and arg_259_1.var_.characterEffect10058ui_story then
				arg_259_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_262_4 = arg_259_1.actors_["1084ui_story"].transform

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1084ui_story = var_262_4.localPosition
			end

			local var_262_5 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_5 then
				var_262_4.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_259_1.time_ - 0) / var_262_5)
				var_262_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_262_4.position).x, (manager.ui.mainCamera.transform.position - var_262_4.position).y, (manager.ui.mainCamera.transform.position - var_262_4.position).z)
				var_262_4.localEulerAngles.z = 0
				var_262_4.localEulerAngles.x = 0
				var_262_4.localEulerAngles = var_262_4.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_5 and arg_259_1.time_ < 0 + var_262_5 + arg_262_0 then
				var_262_4.localPosition = Vector3.New(0, 100, 0)
				var_262_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_262_4.position).x, (manager.ui.mainCamera.transform.position - var_262_4.position).y, (manager.ui.mainCamera.transform.position - var_262_4.position).z)
				var_262_4.localEulerAngles.z = 0
				var_262_4.localEulerAngles.x = 0
				var_262_4.localEulerAngles = var_262_4.localEulerAngles
			end

			local var_262_6 = arg_259_1.actors_["1084ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_6) and arg_259_1.var_.characterEffect1084ui_story == nil then
				arg_259_1.var_.characterEffect1084ui_story = var_262_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_7 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_7 and not isNil(var_262_6) then
				if arg_259_1.var_.characterEffect1084ui_story and not isNil(var_262_6) then
					arg_259_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_7)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_7 and arg_259_1.time_ < 0 + var_262_7 + arg_262_0 and not isNil(var_262_6) and arg_259_1.var_.characterEffect1084ui_story then
				arg_259_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_262_8 = arg_259_1.actors_["10066ui_story"].transform

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos10066ui_story = var_262_8.localPosition
			end

			local var_262_9 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_9 then
				var_262_8.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_259_1.time_ - 0) / var_262_9)
				var_262_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_262_8.position).x, (manager.ui.mainCamera.transform.position - var_262_8.position).y, (manager.ui.mainCamera.transform.position - var_262_8.position).z)
				var_262_8.localEulerAngles.z = 0
				var_262_8.localEulerAngles.x = 0
				var_262_8.localEulerAngles = var_262_8.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_9 and arg_259_1.time_ < 0 + var_262_9 + arg_262_0 then
				var_262_8.localPosition = Vector3.New(0, 100, 0)
				var_262_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_262_8.position).x, (manager.ui.mainCamera.transform.position - var_262_8.position).y, (manager.ui.mainCamera.transform.position - var_262_8.position).z)
				var_262_8.localEulerAngles.z = 0
				var_262_8.localEulerAngles.x = 0
				var_262_8.localEulerAngles = var_262_8.localEulerAngles
			end

			local var_262_10 = arg_259_1.actors_["10066ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_10) and arg_259_1.var_.characterEffect10066ui_story == nil then
				arg_259_1.var_.characterEffect10066ui_story = var_262_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_11 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_11 and not isNil(var_262_10) then
				if arg_259_1.var_.characterEffect10066ui_story and not isNil(var_262_10) then
					arg_259_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_259_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_11)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_11 and arg_259_1.time_ < 0 + var_262_11 + arg_262_0 and not isNil(var_262_10) and arg_259_1.var_.characterEffect10066ui_story then
				arg_259_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_259_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if arg_259_1.frameCnt_ <= 1 then
				arg_259_1.dialog_:SetActive(false)
			end

			local var_262_12 = 0.5
			local var_262_13 = 0.3

			if 0.5 < arg_259_1.time_ and arg_259_1.time_ <= var_262_12 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0

				arg_259_1.dialog_:SetActive(true)

				arg_259_1.dialogCg_.alpha = 0

				local var_262_14 = LeanTween.value(arg_259_1.dialog_, 0, 1, 0.3)

				var_262_14:setOnUpdate(LuaHelper.FloatAction(function(arg_263_0)
					arg_259_1.dialogCg_.alpha = arg_263_0
				end))
				var_262_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_259_1.dialog_)
					var_262_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_259_1.duration_ = arg_259_1.duration_ + 0.3

				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_15 = arg_259_1:GetWordFromCfg(319651063)
				local var_262_16 = arg_259_1:FormatText(var_262_15.content)

				arg_259_1.text_.text = var_262_16

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_18 = 12 <= 0 and var_262_13 or var_262_13 * (utf8.len(var_262_16) / 12)

				if (12 <= 0 and var_262_13 or var_262_13 * (utf8.len(var_262_16) / 12)) > 0 and var_262_13 < var_262_18 then
					arg_259_1.talkMaxDuration = var_262_18
					var_262_12 = var_262_12 + 0.3

					if var_262_18 + var_262_12 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_18 + var_262_12
					end
				end

				arg_259_1.text_.text = var_262_16
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651063", "story_v_out_319651.awb") ~= 0 then
					local var_262_19 = manager.audio:GetVoiceLength("story_v_out_319651", "319651063", "story_v_out_319651.awb") / 1000

					if var_262_19 + var_262_12 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_19 + var_262_12
					end

					if var_262_15.prefab_name ~= "" and arg_259_1.actors_[var_262_15.prefab_name] ~= nil then
						local var_262_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_15.prefab_name].transform, "story_v_out_319651", "319651063", "story_v_out_319651.awb")

						arg_259_1:RecordAudio("319651063", var_262_20)
						arg_259_1:RecordAudio("319651063", var_262_20)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_319651", "319651063", "story_v_out_319651.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_319651", "319651063", "story_v_out_319651.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_21 = var_262_12 + 0.3
			local var_262_22 = math.max(var_262_13, arg_259_1.talkMaxDuration)

			if var_262_12 + 0.3 <= arg_259_1.time_ and arg_259_1.time_ < var_262_21 + var_262_22 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_21) / var_262_22

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_21 + var_262_22 and arg_259_1.time_ < var_262_21 + var_262_22 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play319651064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 319651064
		arg_265_1.duration_ = 7.1

		local var_265_0 = {
			zh = 7.1,
			ja = 6.433
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
				arg_265_0:Play319651065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos10066ui_story = arg_265_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_268_0 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_265_1.time_ - 0) / var_268_0)
				arg_265_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10066ui_story"].transform.position).z)
				arg_265_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["10066ui_story"].transform.localEulerAngles = arg_265_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_265_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10066ui_story"].transform.position).z)
				arg_265_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["10066ui_story"].transform.localEulerAngles = arg_265_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_268_1 = arg_265_1.actors_["10066ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect10066ui_story == nil then
				arg_265_1.var_.characterEffect10066ui_story = var_268_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_2 and not isNil(var_268_1) then
				if arg_265_1.var_.characterEffect10066ui_story and not isNil(var_268_1) then
					arg_265_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_2 and arg_265_1.time_ < 0 + var_268_2 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect10066ui_story then
				arg_265_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_268_4 = arg_265_1.actors_["10058ui_story"].transform

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos10058ui_story = var_268_4.localPosition
			end

			local var_268_5 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_5 then
				var_268_4.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10058ui_story, Vector3.New(0, 100, 0), (arg_265_1.time_ - 0) / var_268_5)
				var_268_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_4.position).x, (manager.ui.mainCamera.transform.position - var_268_4.position).y, (manager.ui.mainCamera.transform.position - var_268_4.position).z)
				var_268_4.localEulerAngles.z = 0
				var_268_4.localEulerAngles.x = 0
				var_268_4.localEulerAngles = var_268_4.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_5 and arg_265_1.time_ < 0 + var_268_5 + arg_268_0 then
				var_268_4.localPosition = Vector3.New(0, 100, 0)
				var_268_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_268_4.position).x, (manager.ui.mainCamera.transform.position - var_268_4.position).y, (manager.ui.mainCamera.transform.position - var_268_4.position).z)
				var_268_4.localEulerAngles.z = 0
				var_268_4.localEulerAngles.x = 0
				var_268_4.localEulerAngles = var_268_4.localEulerAngles
			end

			local var_268_6 = arg_265_1.actors_["10058ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_6) and arg_265_1.var_.characterEffect10058ui_story == nil then
				arg_265_1.var_.characterEffect10058ui_story = var_268_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_7 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_7 and not isNil(var_268_6) then
				if arg_265_1.var_.characterEffect10058ui_story and not isNil(var_268_6) then
					arg_265_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_265_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_265_1.time_ - 0) / var_268_7)
				end
			end

			if arg_265_1.time_ >= 0 + var_268_7 and arg_265_1.time_ < 0 + var_268_7 + arg_268_0 and not isNil(var_268_6) and arg_265_1.var_.characterEffect10058ui_story then
				arg_265_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_265_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_268_8 = 0
			local var_268_9 = 0.8

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_10 = arg_265_1:GetWordFromCfg(319651064)
				local var_268_11 = arg_265_1:FormatText(var_268_10.content)

				arg_265_1.text_.text = var_268_11

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_13 = 32 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 32)

				if (32 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 32)) > 0 and var_268_9 < var_268_13 then
					arg_265_1.talkMaxDuration = var_268_13

					if var_268_13 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_13 + var_268_8
					end
				end

				arg_265_1.text_.text = var_268_11
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651064", "story_v_out_319651.awb") ~= 0 then
					local var_268_14 = manager.audio:GetVoiceLength("story_v_out_319651", "319651064", "story_v_out_319651.awb") / 1000

					if var_268_14 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_14 + var_268_8
					end

					if var_268_10.prefab_name ~= "" and arg_265_1.actors_[var_268_10.prefab_name] ~= nil then
						local var_268_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_10.prefab_name].transform, "story_v_out_319651", "319651064", "story_v_out_319651.awb")

						arg_265_1:RecordAudio("319651064", var_268_15)
						arg_265_1:RecordAudio("319651064", var_268_15)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_319651", "319651064", "story_v_out_319651.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_319651", "319651064", "story_v_out_319651.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_16 = math.max(var_268_9, arg_265_1.talkMaxDuration)

			if var_268_8 <= arg_265_1.time_ and arg_265_1.time_ < var_268_8 + var_268_16 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_8) / var_268_16

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_8 + var_268_16 and arg_265_1.time_ < var_268_8 + var_268_16 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
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
	Play319651065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 319651065
		arg_269_1.duration_ = 4.53

		local var_269_0 = {
			zh = 3.2,
			ja = 4.533
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
				arg_269_0:Play319651066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0.425

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_1 = arg_269_1:GetWordFromCfg(319651065)
				local var_272_2 = arg_269_1:FormatText(var_272_1.content)

				arg_269_1.text_.text = var_272_2

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_4 = 17 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 17)

				if (17 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 17)) > 0 and var_272_0 < var_272_4 then
					arg_269_1.talkMaxDuration = var_272_4

					if var_272_4 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_4 + 0
					end
				end

				arg_269_1.text_.text = var_272_2
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651065", "story_v_out_319651.awb") ~= 0 then
					local var_272_5 = manager.audio:GetVoiceLength("story_v_out_319651", "319651065", "story_v_out_319651.awb") / 1000

					if var_272_5 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + 0
					end

					if var_272_1.prefab_name ~= "" and arg_269_1.actors_[var_272_1.prefab_name] ~= nil then
						local var_272_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_1.prefab_name].transform, "story_v_out_319651", "319651065", "story_v_out_319651.awb")

						arg_269_1:RecordAudio("319651065", var_272_6)
						arg_269_1:RecordAudio("319651065", var_272_6)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_319651", "319651065", "story_v_out_319651.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_319651", "319651065", "story_v_out_319651.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_7 = math.max(var_272_0, arg_269_1.talkMaxDuration)

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_7 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - 0) / var_272_7

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= 0 + var_272_7 and arg_269_1.time_ < 0 + var_272_7 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play319651066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 319651066
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play319651067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos10066ui_story = arg_273_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10066ui_story"].transform.position).z)
				arg_273_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["10066ui_story"].transform.localEulerAngles = arg_273_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_273_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10066ui_story"].transform.position).z)
				arg_273_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["10066ui_story"].transform.localEulerAngles = arg_273_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_276_1 = 0
			local var_276_2 = 0.525

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

				local var_276_3 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(319651066).content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 21 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 21)

				if (21 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 21)) > 0 and var_276_2 < var_276_5 then
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
				actorName = "10066ui_story",
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
	Play319651067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 319651067
		arg_277_1.duration_ = 5.73

		local var_277_0 = {
			zh = 3.033,
			ja = 5.733
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
				arg_277_0:Play319651068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos10058ui_story = arg_277_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_280_0 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 then
				arg_277_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10058ui_story, Vector3.New(0, -0.98, -6.1), (arg_277_1.time_ - 0) / var_280_0)
				arg_277_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10058ui_story"].transform.position).z)
				arg_277_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["10058ui_story"].transform.localEulerAngles = arg_277_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 then
				arg_277_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_277_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_277_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_277_1.actors_["10058ui_story"].transform.position).z)
				arg_277_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_277_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_277_1.actors_["10058ui_story"].transform.localEulerAngles = arg_277_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_280_1 = arg_277_1.actors_["10058ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect10058ui_story == nil then
				arg_277_1.var_.characterEffect10058ui_story = var_280_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_2 and not isNil(var_280_1) then
				if arg_277_1.var_.characterEffect10058ui_story and not isNil(var_280_1) then
					arg_277_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_2 and arg_277_1.time_ < 0 + var_280_2 + arg_280_0 and not isNil(var_280_1) and arg_277_1.var_.characterEffect10058ui_story then
				arg_277_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_280_4 = 0
			local var_280_5 = 0.35

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_6 = arg_277_1:GetWordFromCfg(319651067)
				local var_280_7 = arg_277_1:FormatText(var_280_6.content)

				arg_277_1.text_.text = var_280_7

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_9 = 14 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 14)

				if (14 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_7) / 14)) > 0 and var_280_5 < var_280_9 then
					arg_277_1.talkMaxDuration = var_280_9

					if var_280_9 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_9 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_7
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651067", "story_v_out_319651.awb") ~= 0 then
					local var_280_10 = manager.audio:GetVoiceLength("story_v_out_319651", "319651067", "story_v_out_319651.awb") / 1000

					if var_280_10 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_4
					end

					if var_280_6.prefab_name ~= "" and arg_277_1.actors_[var_280_6.prefab_name] ~= nil then
						local var_280_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_6.prefab_name].transform, "story_v_out_319651", "319651067", "story_v_out_319651.awb")

						arg_277_1:RecordAudio("319651067", var_280_11)
						arg_277_1:RecordAudio("319651067", var_280_11)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_319651", "319651067", "story_v_out_319651.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_319651", "319651067", "story_v_out_319651.awb")
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
				actorName = "10058ui_story",
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
	Play319651068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 319651068
		arg_281_1.duration_ = 2.2

		local var_281_0 = {
			zh = 1.866,
			ja = 2.2
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play319651069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos1084ui_story = arg_281_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_284_0 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 then
				arg_281_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_281_1.time_ - 0) / var_284_0)
				arg_281_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1084ui_story"].transform.position).z)
				arg_281_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1084ui_story"].transform.localEulerAngles = arg_281_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 then
				arg_281_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_281_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["1084ui_story"].transform.position).z)
				arg_281_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["1084ui_story"].transform.localEulerAngles = arg_281_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_284_1 = arg_281_1.actors_["1084ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect1084ui_story == nil then
				arg_281_1.var_.characterEffect1084ui_story = var_284_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_2 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_2 and not isNil(var_284_1) then
				if arg_281_1.var_.characterEffect1084ui_story and not isNil(var_284_1) then
					arg_281_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_2 and arg_281_1.time_ < 0 + var_284_2 + arg_284_0 and not isNil(var_284_1) and arg_281_1.var_.characterEffect1084ui_story then
				arg_281_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_284_4 = arg_281_1.actors_["10058ui_story"].transform

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos10058ui_story = var_284_4.localPosition
			end

			local var_284_5 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_5 then
				var_284_4.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10058ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_281_1.time_ - 0) / var_284_5)
				var_284_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_4.position).x, (manager.ui.mainCamera.transform.position - var_284_4.position).y, (manager.ui.mainCamera.transform.position - var_284_4.position).z)
				var_284_4.localEulerAngles.z = 0
				var_284_4.localEulerAngles.x = 0
				var_284_4.localEulerAngles = var_284_4.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_5 and arg_281_1.time_ < 0 + var_284_5 + arg_284_0 then
				var_284_4.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				var_284_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_284_4.position).x, (manager.ui.mainCamera.transform.position - var_284_4.position).y, (manager.ui.mainCamera.transform.position - var_284_4.position).z)
				var_284_4.localEulerAngles.z = 0
				var_284_4.localEulerAngles.x = 0
				var_284_4.localEulerAngles = var_284_4.localEulerAngles
			end

			local var_284_6 = arg_281_1.actors_["10058ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_6) and arg_281_1.var_.characterEffect10058ui_story == nil then
				arg_281_1.var_.characterEffect10058ui_story = var_284_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_7 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_7 and not isNil(var_284_6) then
				if arg_281_1.var_.characterEffect10058ui_story and not isNil(var_284_6) then
					arg_281_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_281_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_7)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_7 and arg_281_1.time_ < 0 + var_284_7 + arg_284_0 and not isNil(var_284_6) and arg_281_1.var_.characterEffect10058ui_story then
				arg_281_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_281_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_284_8 = 0
			local var_284_9 = 0.15

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_8 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_10 = arg_281_1:GetWordFromCfg(319651068)
				local var_284_11 = arg_281_1:FormatText(var_284_10.content)

				arg_281_1.text_.text = var_284_11

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_13 = 6 <= 0 and var_284_9 or var_284_9 * (utf8.len(var_284_11) / 6)

				if (6 <= 0 and var_284_9 or var_284_9 * (utf8.len(var_284_11) / 6)) > 0 and var_284_9 < var_284_13 then
					arg_281_1.talkMaxDuration = var_284_13

					if var_284_13 + var_284_8 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_13 + var_284_8
					end
				end

				arg_281_1.text_.text = var_284_11
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651068", "story_v_out_319651.awb") ~= 0 then
					local var_284_14 = manager.audio:GetVoiceLength("story_v_out_319651", "319651068", "story_v_out_319651.awb") / 1000

					if var_284_14 + var_284_8 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_14 + var_284_8
					end

					if var_284_10.prefab_name ~= "" and arg_281_1.actors_[var_284_10.prefab_name] ~= nil then
						local var_284_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_10.prefab_name].transform, "story_v_out_319651", "319651068", "story_v_out_319651.awb")

						arg_281_1:RecordAudio("319651068", var_284_15)
						arg_281_1:RecordAudio("319651068", var_284_15)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_319651", "319651068", "story_v_out_319651.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_319651", "319651068", "story_v_out_319651.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_16 = math.max(var_284_9, arg_281_1.talkMaxDuration)

			if var_284_8 <= arg_281_1.time_ and arg_281_1.time_ < var_284_8 + var_284_16 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_8) / var_284_16

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_8 + var_284_16 and arg_281_1.time_ < var_284_8 + var_284_16 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play319651069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 319651069
		arg_285_1.duration_ = 4.17

		local var_285_0 = {
			zh = 4.166,
			ja = 2.9
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play319651070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1084ui_story"]) and arg_285_1.var_.characterEffect1084ui_story == nil then
				arg_285_1.var_.characterEffect1084ui_story = arg_285_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1084ui_story"]) then
				if arg_285_1.var_.characterEffect1084ui_story and not isNil(arg_285_1.actors_["1084ui_story"]) then
					arg_285_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_285_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_0)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1084ui_story"]) and arg_285_1.var_.characterEffect1084ui_story then
				arg_285_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_285_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_288_1 = arg_285_1.actors_["10058ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect10058ui_story == nil then
				arg_285_1.var_.characterEffect10058ui_story = var_288_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_2 and not isNil(var_288_1) then
				if arg_285_1.var_.characterEffect10058ui_story and not isNil(var_288_1) then
					arg_285_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_2 and arg_285_1.time_ < 0 + var_288_2 + arg_288_0 and not isNil(var_288_1) and arg_285_1.var_.characterEffect10058ui_story then
				arg_285_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_288_4 = 0
			local var_288_5 = 0.425

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_6 = arg_285_1:GetWordFromCfg(319651069)
				local var_288_7 = arg_285_1:FormatText(var_288_6.content)

				arg_285_1.text_.text = var_288_7

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_9 = 17 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 17)

				if (17 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_7) / 17)) > 0 and var_288_5 < var_288_9 then
					arg_285_1.talkMaxDuration = var_288_9

					if var_288_9 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_7
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651069", "story_v_out_319651.awb") ~= 0 then
					local var_288_10 = manager.audio:GetVoiceLength("story_v_out_319651", "319651069", "story_v_out_319651.awb") / 1000

					if var_288_10 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_4
					end

					if var_288_6.prefab_name ~= "" and arg_285_1.actors_[var_288_6.prefab_name] ~= nil then
						local var_288_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_6.prefab_name].transform, "story_v_out_319651", "319651069", "story_v_out_319651.awb")

						arg_285_1:RecordAudio("319651069", var_288_11)
						arg_285_1:RecordAudio("319651069", var_288_11)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_319651", "319651069", "story_v_out_319651.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_319651", "319651069", "story_v_out_319651.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_12 = math.max(var_288_5, arg_285_1.talkMaxDuration)

			if var_288_4 <= arg_285_1.time_ and arg_285_1.time_ < var_288_4 + var_288_12 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_4) / var_288_12

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_4 + var_288_12 and arg_285_1.time_ < var_288_4 + var_288_12 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play319651070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 319651070
		arg_289_1.duration_ = 4.23

		local var_289_0 = {
			zh = 1.999999999999,
			ja = 4.233
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
				arg_289_0:Play319651071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos1084ui_story = arg_289_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_292_0 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 then
				arg_289_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_289_1.time_ - 0) / var_292_0)
				arg_289_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1084ui_story"].transform.position).z)
				arg_289_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1084ui_story"].transform.localEulerAngles = arg_289_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 then
				arg_289_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_289_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["1084ui_story"].transform.position).z)
				arg_289_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["1084ui_story"].transform.localEulerAngles = arg_289_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_292_1 = arg_289_1.actors_["1084ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect1084ui_story == nil then
				arg_289_1.var_.characterEffect1084ui_story = var_292_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_2 and not isNil(var_292_1) then
				if arg_289_1.var_.characterEffect1084ui_story and not isNil(var_292_1) then
					arg_289_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_2 and arg_289_1.time_ < 0 + var_292_2 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect1084ui_story then
				arg_289_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_292_4 = arg_289_1.actors_["10058ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_4) and arg_289_1.var_.characterEffect10058ui_story == nil then
				arg_289_1.var_.characterEffect10058ui_story = var_292_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_5 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_5 and not isNil(var_292_4) then
				if arg_289_1.var_.characterEffect10058ui_story and not isNil(var_292_4) then
					arg_289_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_289_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_289_1.time_ - 0) / var_292_5)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_5 and arg_289_1.time_ < 0 + var_292_5 + arg_292_0 and not isNil(var_292_4) and arg_289_1.var_.characterEffect10058ui_story then
				arg_289_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_289_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_292_6 = 0
			local var_292_7 = 0.175

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_6 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_8 = arg_289_1:GetWordFromCfg(319651070)
				local var_292_9 = arg_289_1:FormatText(var_292_8.content)

				arg_289_1.text_.text = var_292_9

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_11 = 7 <= 0 and var_292_7 or var_292_7 * (utf8.len(var_292_9) / 7)

				if (7 <= 0 and var_292_7 or var_292_7 * (utf8.len(var_292_9) / 7)) > 0 and var_292_7 < var_292_11 then
					arg_289_1.talkMaxDuration = var_292_11

					if var_292_11 + var_292_6 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_11 + var_292_6
					end
				end

				arg_289_1.text_.text = var_292_9
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651070", "story_v_out_319651.awb") ~= 0 then
					local var_292_12 = manager.audio:GetVoiceLength("story_v_out_319651", "319651070", "story_v_out_319651.awb") / 1000

					if var_292_12 + var_292_6 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_12 + var_292_6
					end

					if var_292_8.prefab_name ~= "" and arg_289_1.actors_[var_292_8.prefab_name] ~= nil then
						local var_292_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_8.prefab_name].transform, "story_v_out_319651", "319651070", "story_v_out_319651.awb")

						arg_289_1:RecordAudio("319651070", var_292_13)
						arg_289_1:RecordAudio("319651070", var_292_13)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_319651", "319651070", "story_v_out_319651.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_319651", "319651070", "story_v_out_319651.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_14 = math.max(var_292_7, arg_289_1.talkMaxDuration)

			if var_292_6 <= arg_289_1.time_ and arg_289_1.time_ < var_292_6 + var_292_14 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_6) / var_292_14

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_6 + var_292_14 and arg_289_1.time_ < var_292_6 + var_292_14 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play319651071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 319651071
		arg_293_1.duration_ = 6.8

		local var_293_0 = {
			zh = 6.8,
			ja = 3.7
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play319651072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos10058ui_story = arg_293_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_296_0 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 then
				arg_293_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10058ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_293_1.time_ - 0) / var_296_0)
				arg_293_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10058ui_story"].transform.position).z)
				arg_293_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["10058ui_story"].transform.localEulerAngles = arg_293_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 then
				arg_293_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_293_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["10058ui_story"].transform.position).z)
				arg_293_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["10058ui_story"].transform.localEulerAngles = arg_293_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_296_1 = arg_293_1.actors_["10058ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect10058ui_story == nil then
				arg_293_1.var_.characterEffect10058ui_story = var_296_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_2 and not isNil(var_296_1) then
				if arg_293_1.var_.characterEffect10058ui_story and not isNil(var_296_1) then
					arg_293_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_2 and arg_293_1.time_ < 0 + var_296_2 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect10058ui_story then
				arg_293_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_296_4 = arg_293_1.actors_["1084ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_4) and arg_293_1.var_.characterEffect1084ui_story == nil then
				arg_293_1.var_.characterEffect1084ui_story = var_296_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_5 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_5 and not isNil(var_296_4) then
				if arg_293_1.var_.characterEffect1084ui_story and not isNil(var_296_4) then
					arg_293_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_293_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_5)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_5 and arg_293_1.time_ < 0 + var_296_5 + arg_296_0 and not isNil(var_296_4) and arg_293_1.var_.characterEffect1084ui_story then
				arg_293_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_293_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_296_6 = 0
			local var_296_7 = 0.825

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_6 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_8 = arg_293_1:GetWordFromCfg(319651071)
				local var_296_9 = arg_293_1:FormatText(var_296_8.content)

				arg_293_1.text_.text = var_296_9

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_11 = 33 <= 0 and var_296_7 or var_296_7 * (utf8.len(var_296_9) / 33)

				if (33 <= 0 and var_296_7 or var_296_7 * (utf8.len(var_296_9) / 33)) > 0 and var_296_7 < var_296_11 then
					arg_293_1.talkMaxDuration = var_296_11

					if var_296_11 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_11 + var_296_6
					end
				end

				arg_293_1.text_.text = var_296_9
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651071", "story_v_out_319651.awb") ~= 0 then
					local var_296_12 = manager.audio:GetVoiceLength("story_v_out_319651", "319651071", "story_v_out_319651.awb") / 1000

					if var_296_12 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_12 + var_296_6
					end

					if var_296_8.prefab_name ~= "" and arg_293_1.actors_[var_296_8.prefab_name] ~= nil then
						local var_296_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_8.prefab_name].transform, "story_v_out_319651", "319651071", "story_v_out_319651.awb")

						arg_293_1:RecordAudio("319651071", var_296_13)
						arg_293_1:RecordAudio("319651071", var_296_13)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_319651", "319651071", "story_v_out_319651.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_319651", "319651071", "story_v_out_319651.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_14 = math.max(var_296_7, arg_293_1.talkMaxDuration)

			if var_296_6 <= arg_293_1.time_ and arg_293_1.time_ < var_296_6 + var_296_14 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_6) / var_296_14

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_6 + var_296_14 and arg_293_1.time_ < var_296_6 + var_296_14 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play319651072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 319651072
		arg_297_1.duration_ = 10.77

		local var_297_0 = {
			zh = 7.333,
			ja = 10.766
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
				arg_297_0:Play319651073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.925

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_1 = arg_297_1:GetWordFromCfg(319651072)
				local var_300_2 = arg_297_1:FormatText(var_300_1.content)

				arg_297_1.text_.text = var_300_2

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_4 = 37 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_2) / 37)

				if (37 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_2) / 37)) > 0 and var_300_0 < var_300_4 then
					arg_297_1.talkMaxDuration = var_300_4

					if var_300_4 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_4 + 0
					end
				end

				arg_297_1.text_.text = var_300_2
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651072", "story_v_out_319651.awb") ~= 0 then
					local var_300_5 = manager.audio:GetVoiceLength("story_v_out_319651", "319651072", "story_v_out_319651.awb") / 1000

					if var_300_5 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_5 + 0
					end

					if var_300_1.prefab_name ~= "" and arg_297_1.actors_[var_300_1.prefab_name] ~= nil then
						local var_300_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_1.prefab_name].transform, "story_v_out_319651", "319651072", "story_v_out_319651.awb")

						arg_297_1:RecordAudio("319651072", var_300_6)
						arg_297_1:RecordAudio("319651072", var_300_6)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_319651", "319651072", "story_v_out_319651.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_319651", "319651072", "story_v_out_319651.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_7 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_7 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_7

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_7 and arg_297_1.time_ < 0 + var_300_7 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play319651073 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 319651073
		arg_301_1.duration_ = 2

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play319651074(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1084ui_story = arg_301_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_304_0 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 then
				arg_301_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_301_1.time_ - 0) / var_304_0)
				arg_301_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1084ui_story"].transform.position).z)
				arg_301_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1084ui_story"].transform.localEulerAngles = arg_301_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 then
				arg_301_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_301_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["1084ui_story"].transform.position).z)
				arg_301_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["1084ui_story"].transform.localEulerAngles = arg_301_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_304_1 = arg_301_1.actors_["1084ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1084ui_story == nil then
				arg_301_1.var_.characterEffect1084ui_story = var_304_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_2 and not isNil(var_304_1) then
				if arg_301_1.var_.characterEffect1084ui_story and not isNil(var_304_1) then
					arg_301_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_2 and arg_301_1.time_ < 0 + var_304_2 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect1084ui_story then
				arg_301_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_2")
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_304_4 = arg_301_1.actors_["10058ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_4) and arg_301_1.var_.characterEffect10058ui_story == nil then
				arg_301_1.var_.characterEffect10058ui_story = var_304_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_5 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_5 and not isNil(var_304_4) then
				if arg_301_1.var_.characterEffect10058ui_story and not isNil(var_304_4) then
					arg_301_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_301_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_301_1.time_ - 0) / var_304_5)
				end
			end

			if arg_301_1.time_ >= 0 + var_304_5 and arg_301_1.time_ < 0 + var_304_5 + arg_304_0 and not isNil(var_304_4) and arg_301_1.var_.characterEffect10058ui_story then
				arg_301_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_301_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_304_6 = 0
			local var_304_7 = 0.075

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_6 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_8 = arg_301_1:GetWordFromCfg(319651073)
				local var_304_9 = arg_301_1:FormatText(var_304_8.content)

				arg_301_1.text_.text = var_304_9

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_11 = 3 <= 0 and var_304_7 or var_304_7 * (utf8.len(var_304_9) / 3)

				if (3 <= 0 and var_304_7 or var_304_7 * (utf8.len(var_304_9) / 3)) > 0 and var_304_7 < var_304_11 then
					arg_301_1.talkMaxDuration = var_304_11

					if var_304_11 + var_304_6 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_11 + var_304_6
					end
				end

				arg_301_1.text_.text = var_304_9
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651073", "story_v_out_319651.awb") ~= 0 then
					local var_304_12 = manager.audio:GetVoiceLength("story_v_out_319651", "319651073", "story_v_out_319651.awb") / 1000

					if var_304_12 + var_304_6 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_12 + var_304_6
					end

					if var_304_8.prefab_name ~= "" and arg_301_1.actors_[var_304_8.prefab_name] ~= nil then
						local var_304_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_8.prefab_name].transform, "story_v_out_319651", "319651073", "story_v_out_319651.awb")

						arg_301_1:RecordAudio("319651073", var_304_13)
						arg_301_1:RecordAudio("319651073", var_304_13)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_319651", "319651073", "story_v_out_319651.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_319651", "319651073", "story_v_out_319651.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_14 = math.max(var_304_7, arg_301_1.talkMaxDuration)

			if var_304_6 <= arg_301_1.time_ and arg_301_1.time_ < var_304_6 + var_304_14 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_6) / var_304_14

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_6 + var_304_14 and arg_301_1.time_ < var_304_6 + var_304_14 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play319651074 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 319651074
		arg_305_1.duration_ = 2.2

		local var_305_0 = {
			zh = 2.2,
			ja = 1.999999999999
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
				arg_305_0:Play319651075(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["1084ui_story"]) and arg_305_1.var_.characterEffect1084ui_story == nil then
				arg_305_1.var_.characterEffect1084ui_story = arg_305_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_0 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["1084ui_story"]) then
				if arg_305_1.var_.characterEffect1084ui_story and not isNil(arg_305_1.actors_["1084ui_story"]) then
					arg_305_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_0)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["1084ui_story"]) and arg_305_1.var_.characterEffect1084ui_story then
				arg_305_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_308_1 = arg_305_1.actors_["10058ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect10058ui_story == nil then
				arg_305_1.var_.characterEffect10058ui_story = var_308_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_2 and not isNil(var_308_1) then
				if arg_305_1.var_.characterEffect10058ui_story and not isNil(var_308_1) then
					arg_305_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= 0 + var_308_2 and arg_305_1.time_ < 0 + var_308_2 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect10058ui_story then
				arg_305_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_2")
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_308_4 = 0
			local var_308_5 = 0.2

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_4 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_6 = arg_305_1:GetWordFromCfg(319651074)
				local var_308_7 = arg_305_1:FormatText(var_308_6.content)

				arg_305_1.text_.text = var_308_7

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_9 = 8 <= 0 and var_308_5 or var_308_5 * (utf8.len(var_308_7) / 8)

				if (8 <= 0 and var_308_5 or var_308_5 * (utf8.len(var_308_7) / 8)) > 0 and var_308_5 < var_308_9 then
					arg_305_1.talkMaxDuration = var_308_9

					if var_308_9 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_9 + var_308_4
					end
				end

				arg_305_1.text_.text = var_308_7
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651074", "story_v_out_319651.awb") ~= 0 then
					local var_308_10 = manager.audio:GetVoiceLength("story_v_out_319651", "319651074", "story_v_out_319651.awb") / 1000

					if var_308_10 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_10 + var_308_4
					end

					if var_308_6.prefab_name ~= "" and arg_305_1.actors_[var_308_6.prefab_name] ~= nil then
						local var_308_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_6.prefab_name].transform, "story_v_out_319651", "319651074", "story_v_out_319651.awb")

						arg_305_1:RecordAudio("319651074", var_308_11)
						arg_305_1:RecordAudio("319651074", var_308_11)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_319651", "319651074", "story_v_out_319651.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_319651", "319651074", "story_v_out_319651.awb")
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

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play319651075 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 319651075
		arg_309_1.duration_ = 8.97

		local var_309_0 = {
			zh = 6.333,
			ja = 8.966
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play319651076(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["10058ui_story"]) and arg_309_1.var_.characterEffect10058ui_story == nil then
				arg_309_1.var_.characterEffect10058ui_story = arg_309_1.actors_["10058ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_0 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["10058ui_story"]) then
				if arg_309_1.var_.characterEffect10058ui_story and not isNil(arg_309_1.actors_["10058ui_story"]) then
					arg_309_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_309_1.var_.characterEffect10058ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_309_1.time_ - 0) / var_312_0)
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["10058ui_story"]) and arg_309_1.var_.characterEffect10058ui_story then
				arg_309_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_309_1.var_.characterEffect10058ui_story.fillRatio = 0.5
			end

			local var_312_1 = arg_309_1.actors_["1084ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1084ui_story == nil then
				arg_309_1.var_.characterEffect1084ui_story = var_312_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_2 and not isNil(var_312_1) then
				if arg_309_1.var_.characterEffect1084ui_story and not isNil(var_312_1) then
					arg_309_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_2 and arg_309_1.time_ < 0 + var_312_2 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect1084ui_story then
				arg_309_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_312_4 = 0
			local var_312_5 = 0.75

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_4 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_6 = arg_309_1:GetWordFromCfg(319651075)
				local var_312_7 = arg_309_1:FormatText(var_312_6.content)

				arg_309_1.text_.text = var_312_7

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_9 = 30 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 30)

				if (30 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 30)) > 0 and var_312_5 < var_312_9 then
					arg_309_1.talkMaxDuration = var_312_9

					if var_312_9 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_9 + var_312_4
					end
				end

				arg_309_1.text_.text = var_312_7
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651075", "story_v_out_319651.awb") ~= 0 then
					local var_312_10 = manager.audio:GetVoiceLength("story_v_out_319651", "319651075", "story_v_out_319651.awb") / 1000

					if var_312_10 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_4
					end

					if var_312_6.prefab_name ~= "" and arg_309_1.actors_[var_312_6.prefab_name] ~= nil then
						local var_312_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_6.prefab_name].transform, "story_v_out_319651", "319651075", "story_v_out_319651.awb")

						arg_309_1:RecordAudio("319651075", var_312_11)
						arg_309_1:RecordAudio("319651075", var_312_11)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_319651", "319651075", "story_v_out_319651.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_319651", "319651075", "story_v_out_319651.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_12 = math.max(var_312_5, arg_309_1.talkMaxDuration)

			if var_312_4 <= arg_309_1.time_ and arg_309_1.time_ < var_312_4 + var_312_12 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_4) / var_312_12

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_4 + var_312_12 and arg_309_1.time_ < var_312_4 + var_312_12 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play319651076 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 319651076
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play319651077(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1084ui_story"]) and arg_313_1.var_.characterEffect1084ui_story == nil then
				arg_313_1.var_.characterEffect1084ui_story = arg_313_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_0 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1084ui_story"]) then
				if arg_313_1.var_.characterEffect1084ui_story and not isNil(arg_313_1.actors_["1084ui_story"]) then
					arg_313_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_0)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1084ui_story"]) and arg_313_1.var_.characterEffect1084ui_story then
				arg_313_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_316_1 = 0
			local var_316_2 = 0.8

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_3 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(319651076).content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 32 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 32)

				if (32 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 32)) > 0 and var_316_2 < var_316_5 then
					arg_313_1.talkMaxDuration = var_316_5

					if var_316_5 + var_316_1 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + var_316_1
					end
				end

				arg_313_1.text_.text = var_316_3
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_6 = math.max(var_316_2, arg_313_1.talkMaxDuration)

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_6 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_1) / var_316_6

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_1 + var_316_6 and arg_313_1.time_ < var_316_1 + var_316_6 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play319651077 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 319651077
		arg_317_1.duration_ = 8.17

		local var_317_0 = {
			zh = 8.16666666666667,
			ja = 6.76666666666667
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
			arg_317_1.auto_ = false
		end

		function arg_317_1.playNext_(arg_319_0)
			arg_317_1.onStoryFinished_()
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.var_.moveOldPos10058ui_story = arg_317_1.actors_["10058ui_story"].transform.localPosition
			end

			local var_320_0 = 0.001

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 then
				arg_317_1.actors_["10058ui_story"].transform.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos10058ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_317_1.time_ - 0) / var_320_0)
				arg_317_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["10058ui_story"].transform.position).z)
				arg_317_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["10058ui_story"].transform.localEulerAngles = arg_317_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 then
				arg_317_1.actors_["10058ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_317_1.actors_["10058ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_317_1.actors_["10058ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["10058ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_317_1.actors_["10058ui_story"].transform.position).z)
				arg_317_1.actors_["10058ui_story"].transform.localEulerAngles.z = 0
				arg_317_1.actors_["10058ui_story"].transform.localEulerAngles.x = 0
				arg_317_1.actors_["10058ui_story"].transform.localEulerAngles = arg_317_1.actors_["10058ui_story"].transform.localEulerAngles
			end

			local var_320_1 = arg_317_1.actors_["10058ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect10058ui_story == nil then
				arg_317_1.var_.characterEffect10058ui_story = var_320_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 and not isNil(var_320_1) then
				if arg_317_1.var_.characterEffect10058ui_story and not isNil(var_320_1) then
					arg_317_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect10058ui_story then
				arg_317_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_1")
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if arg_317_1.frameCnt_ <= 1 then
				arg_317_1.dialog_:SetActive(false)
			end

			local var_320_4 = 1.16666666666667
			local var_320_5 = 0.7

			if 1.16666666666667 < arg_317_1.time_ and arg_317_1.time_ <= var_320_4 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0

				arg_317_1.dialog_:SetActive(true)

				arg_317_1.dialogCg_.alpha = 0

				local var_320_6 = LeanTween.value(arg_317_1.dialog_, 0, 1, 0.3)

				var_320_6:setOnUpdate(LuaHelper.FloatAction(function(arg_321_0)
					arg_317_1.dialogCg_.alpha = arg_321_0
				end))
				var_320_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_317_1.dialog_)
					var_320_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_317_1.duration_ = arg_317_1.duration_ + 0.3

				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_7 = arg_317_1:GetWordFromCfg(319651077)
				local var_320_8 = arg_317_1:FormatText(var_320_7.content)

				arg_317_1.text_.text = var_320_8

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_10 = 28 <= 0 and var_320_5 or var_320_5 * (utf8.len(var_320_8) / 28)

				if (28 <= 0 and var_320_5 or var_320_5 * (utf8.len(var_320_8) / 28)) > 0 and var_320_5 < var_320_10 then
					arg_317_1.talkMaxDuration = var_320_10
					var_320_4 = var_320_4 + 0.3

					if var_320_10 + var_320_4 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_10 + var_320_4
					end
				end

				arg_317_1.text_.text = var_320_8
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319651", "319651077", "story_v_out_319651.awb") ~= 0 then
					local var_320_11 = manager.audio:GetVoiceLength("story_v_out_319651", "319651077", "story_v_out_319651.awb") / 1000

					if var_320_11 + var_320_4 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_11 + var_320_4
					end

					if var_320_7.prefab_name ~= "" and arg_317_1.actors_[var_320_7.prefab_name] ~= nil then
						local var_320_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_7.prefab_name].transform, "story_v_out_319651", "319651077", "story_v_out_319651.awb")

						arg_317_1:RecordAudio("319651077", var_320_12)
						arg_317_1:RecordAudio("319651077", var_320_12)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_319651", "319651077", "story_v_out_319651.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_319651", "319651077", "story_v_out_319651.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_13 = var_320_4 + 0.3
			local var_320_14 = math.max(var_320_5, arg_317_1.talkMaxDuration)

			if var_320_4 + 0.3 <= arg_317_1.time_ and arg_317_1.time_ < var_320_13 + var_320_14 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_13) / var_320_14

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_13 + var_320_14 and arg_317_1.time_ < var_320_13 + var_320_14 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10058ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_317_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST74",
		"TextureConfig/Background/ML0201",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319651.awb"
	}
}
