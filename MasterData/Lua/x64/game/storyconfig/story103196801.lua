return {
	Play319681001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319681001
		arg_1_1.duration_ = 1

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play319681002(arg_1_1)
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.cswbg_:SetActive(true)

				local var_4_3 = arg_1_1.cswt_:GetComponent("RectTransform")

				arg_1_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_3.offsetMin = Vector2.New(410, 330)
				var_4_3.offsetMax = Vector2.New(-400, -175)
				arg_1_1.cswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(419039).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.cswt_)

				arg_1_1.cswt_.fontSize = 180
				arg_1_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_1_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0
				arg_1_1.fswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(319681001).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_4 = 0.166666666666667

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_5 = 2
			local var_4_6 = 0.133333333333333
			local var_4_7, var_4_8 = arg_1_1:GetPercentByPara(arg_1_1:FormatText(arg_1_1:GetWordFromCfg(319681001).content), 1)

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

			local var_4_10 = math.max(0.133333333333333, arg_1_1.talkMaxDuration)

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
				local var_4_11 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_12 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_13 = var_4_11:GetComponent("RectTransform")

				var_4_11:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_4_13.offsetMin = Vector2.New(0, 0)
				var_4_13.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play319681002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 319681002
		arg_6_1.duration_ = 1

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play319681003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1.cswbg_:SetActive(true)

				local var_9_0 = arg_6_1.cswt_:GetComponent("RectTransform")

				arg_6_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_9_0.offsetMin = Vector2.New(410, 330)
				var_9_0.offsetMax = Vector2.New(-400, -175)
				arg_6_1.cswt_.text = arg_6_1:FormatText(arg_6_1:GetWordFromCfg(419040).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.cswt_)

				arg_6_1.cswt_.fontSize = 180
				arg_6_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_6_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_6_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play319681003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 319681003
		arg_10_1.duration_ = 1.33

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play319681004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				local var_13_0 = arg_10_1.fswbg_.transform:Find("textbox/adapt/content") or arg_10_1.fswbg_.transform:Find("textbox/content")
				local var_13_1 = arg_10_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_13_2 = var_13_0:GetComponent("RectTransform")

				var_13_0:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_13_2.offsetMin = Vector2.New(0, 0)
				var_13_2.offsetMax = Vector2.New(0, 0)
			end

			if 0.7 < arg_10_1.time_ and arg_10_1.time_ <= 0.7 + arg_13_0 then
				arg_10_1.fswbg_:SetActive(true)
				arg_10_1.dialog_:SetActive(false)

				arg_10_1.fswtw_.percent = 0
				arg_10_1.fswt_.text = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(319681003).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.fswt_)

				arg_10_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_10_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_10_1.fswtw_:SetDirty()

				arg_10_1.typewritterCharCountI18N = 0

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_3 = 0.866666666666667

			if 0.866666666666667 < arg_10_1.time_ and arg_10_1.time_ <= var_13_3 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_4 = 7
			local var_13_5 = 0.466666666666667
			local var_13_6, var_13_7 = arg_10_1:GetPercentByPara(arg_10_1:FormatText(arg_10_1:GetWordFromCfg(319681003).content), 1)

			if var_13_3 < arg_10_1.time_ and arg_10_1.time_ <= var_13_3 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0

				local var_13_8 = var_13_4 <= 0 and var_13_5 or var_13_5 * ((var_13_7 - arg_10_1.typewritterCharCountI18N) / var_13_4)

				if (var_13_4 <= 0 and var_13_5 or var_13_5 * ((var_13_7 - arg_10_1.typewritterCharCountI18N) / var_13_4)) > 0 and var_13_5 < var_13_8 then
					arg_10_1.talkMaxDuration = var_13_8

					if var_13_8 + var_13_3 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_8 + var_13_3
					end
				end
			end

			local var_13_9 = math.max(0.466666666666667, arg_10_1.talkMaxDuration)

			if var_13_3 <= arg_10_1.time_ and arg_10_1.time_ < var_13_3 + var_13_9 then
				arg_10_1.fswtw_.percent = Mathf.Lerp(arg_10_1.var_.oldValueTypewriter, var_13_6, (arg_10_1.time_ - var_13_3) / var_13_9)
				arg_10_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_10_1.fswtw_:SetDirty()
			end

			if arg_10_1.time_ >= var_13_3 + var_13_9 and arg_10_1.time_ < var_13_3 + var_13_9 + arg_13_0 then
				arg_10_1.fswtw_.percent = var_13_6

				arg_10_1.fswtw_:SetDirty()
				arg_10_1:ShowNextGo(true)

				arg_10_1.typewritterCharCountI18N = var_13_7
			end

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.cswbg_:SetActive(true)

				local var_13_10 = arg_10_1.cswt_:GetComponent("RectTransform")

				arg_10_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_13_10.offsetMin = Vector2.New(410, 330)
				var_13_10.offsetMax = Vector2.New(-400, -175)
				arg_10_1.cswt_.text = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(419041).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.cswt_)

				arg_10_1.cswt_.fontSize = 180
				arg_10_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_10_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_10_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play319681004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 319681004
		arg_14_1.duration_ = 7.77

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play319681005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if arg_14_1.bgs_.XH0407a == nil then
				local var_17_0 = Object.Instantiate(arg_14_1.paintGo_)

				var_17_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0407a")
				var_17_0.name = "XH0407a"
				var_17_0.transform.parent = arg_14_1.stage_.transform
				var_17_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_14_1.bgs_.XH0407a = var_17_0
			end

			if 1 < arg_14_1.time_ and arg_14_1.time_ <= 1 + arg_17_0 then
				local var_17_1 = arg_14_1.bgs_.XH0407a

				arg_14_1.bgs_.XH0407a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_17_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_17_2 = var_17_1:GetComponent("SpriteRenderer")

				if var_17_2 and var_17_2.sprite then
					local var_17_3 = 2 * (var_17_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_17_1.transform.localScale = Vector3.New(var_17_3 / var_17_2.sprite.bounds.size.y < var_17_3 * manager.ui.mainCameraCom_.aspect / var_17_2.sprite.bounds.size.x and var_17_3 * manager.ui.mainCameraCom_.aspect / var_17_2.sprite.bounds.size.x or var_17_3 / var_17_2.sprite.bounds.size.y, var_17_3 / var_17_2.sprite.bounds.size.y < var_17_3 * manager.ui.mainCameraCom_.aspect / var_17_2.sprite.bounds.size.x and var_17_3 * manager.ui.mainCameraCom_.aspect / var_17_2.sprite.bounds.size.x or var_17_3 / var_17_2.sprite.bounds.size.y, 0)
				end

				for iter_17_0, iter_17_1 in pairs(arg_14_1.bgs_) do
					if iter_17_0 ~= "XH0407a" then
						iter_17_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_17_4 = 0

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_4 + arg_17_0 then
				arg_14_1.allBtn_.enabled = false
			end

			if arg_14_1.time_ >= var_17_4 + 1 and arg_14_1.time_ < var_17_4 + 1 + arg_17_0 then
				arg_14_1.allBtn_.enabled = true
			end

			local var_17_5 = 1

			if 1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_5 + arg_17_0 then
				arg_14_1.mask_.enabled = true
				arg_14_1.mask_.raycastTarget = true

				arg_14_1:SetGaussion(false)
			end

			local var_17_6 = 2

			if var_17_5 <= arg_14_1.time_ and arg_14_1.time_ < var_17_5 + var_17_6 then
				local var_17_7 = Color.New(1, 1, 1)

				var_17_7.a = Mathf.Lerp(1, 0, (arg_14_1.time_ - var_17_5) / var_17_6)
				arg_14_1.mask_.color = var_17_7
			end

			if arg_14_1.time_ >= var_17_5 + var_17_6 and arg_14_1.time_ < var_17_5 + var_17_6 + arg_17_0 then
				local var_17_8 = Color.New(1, 1, 1)

				arg_14_1.mask_.enabled = false
				var_17_8.a = 0
				arg_14_1.mask_.color = var_17_8
			end

			if 1 < arg_14_1.time_ and arg_14_1.time_ <= 1 + arg_17_0 then
				arg_14_1.fswbg_:SetActive(false)
				arg_14_1.dialog_:SetActive(false)
				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			if 1.01666666666667 < arg_14_1.time_ and arg_14_1.time_ <= 1.01666666666667 + arg_17_0 then
				arg_14_1.fswbg_:SetActive(false)
				arg_14_1.dialog_:SetActive(false)
				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			if 1 < arg_14_1.time_ and arg_14_1.time_ <= 1 + arg_17_0 then
				arg_14_1.cswbg_:SetActive(false)
			end

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_17_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_14_1.bgmTxt_.text ~= var_17_11 and arg_14_1.bgmTxt_.text ~= "" then
						if arg_14_1.bgmTxt2_.text ~= "" then
							arg_14_1.bgmTxt_.text = arg_14_1.bgmTxt2_.text
						end

						arg_14_1.bgmTxt2_.text = var_17_11

						arg_14_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_14_1.bgmTxt_.text = var_17_11
						arg_14_1.bgmTxt2_.text = var_17_11
					end

					if arg_14_1.bgmTimer then
						arg_14_1.bgmTimer:Stop()

						arg_14_1.bgmTimer = nil
					end

					if arg_14_1.settingData.show_music_name == 1 then
						arg_14_1.musicController:SetSelectedState("show")
						arg_14_1.musicAnimator_:Play("open", 0, 0)

						if arg_14_1.settingData.music_time ~= 0 then
							arg_14_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_14_1.settingData.music_time), function()
								if arg_14_1 == nil or isNil(arg_14_1.bgmTxt_) then
									return
								end

								arg_14_1.musicController:SetSelectedState("hide")
								arg_14_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2.7 < arg_14_1.time_ and arg_14_1.time_ <= 2.7 + arg_17_0 then
				arg_14_1:AudioAction("play", "music", "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense.awb")

				local var_17_14 = manager.audio:GetAudioName("bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense")

				if "" ~= "" then
					if arg_14_1.bgmTxt_.text ~= var_17_14 and arg_14_1.bgmTxt_.text ~= "" then
						if arg_14_1.bgmTxt2_.text ~= "" then
							arg_14_1.bgmTxt_.text = arg_14_1.bgmTxt2_.text
						end

						arg_14_1.bgmTxt2_.text = var_17_14

						arg_14_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_14_1.bgmTxt_.text = var_17_14
						arg_14_1.bgmTxt2_.text = var_17_14
					end

					if arg_14_1.bgmTimer then
						arg_14_1.bgmTimer:Stop()

						arg_14_1.bgmTimer = nil
					end

					if arg_14_1.settingData.show_music_name == 1 then
						arg_14_1.musicController:SetSelectedState("show")
						arg_14_1.musicAnimator_:Play("open", 0, 0)

						if arg_14_1.settingData.music_time ~= 0 then
							arg_14_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_14_1.settingData.music_time), function()
								if arg_14_1 == nil or isNil(arg_14_1.bgmTxt_) then
									return
								end

								arg_14_1.musicController:SetSelectedState("hide")
								arg_14_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_14_1.frameCnt_ <= 1 then
				arg_14_1.dialog_:SetActive(false)
			end

			local var_17_15 = 2.76666666666667
			local var_17_16 = 0.675

			if 2.76666666666667 < arg_14_1.time_ and arg_14_1.time_ <= var_17_15 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				arg_14_1.dialog_:SetActive(true)

				arg_14_1.dialogCg_.alpha = 0

				local var_17_17 = LeanTween.value(arg_14_1.dialog_, 0, 1, 0.3)

				var_17_17:setOnUpdate(LuaHelper.FloatAction(function(arg_20_0)
					arg_14_1.dialogCg_.alpha = arg_20_0
				end))
				var_17_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_14_1.dialog_)
					var_17_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_14_1.duration_ = arg_14_1.duration_ + 0.3

				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_18 = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(319681004).content)

				arg_14_1.text_.text = var_17_18

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_20 = 27 <= 0 and var_17_16 or var_17_16 * (utf8.len(var_17_18) / 27)

				if (27 <= 0 and var_17_16 or var_17_16 * (utf8.len(var_17_18) / 27)) > 0 and var_17_16 < var_17_20 then
					arg_14_1.talkMaxDuration = var_17_20
					var_17_15 = var_17_15 + 0.3

					if var_17_20 + var_17_15 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_20 + var_17_15
					end
				end

				arg_14_1.text_.text = var_17_18
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_21 = var_17_15 + 0.3
			local var_17_22 = math.max(var_17_16, arg_14_1.talkMaxDuration)

			if var_17_15 + 0.3 <= arg_14_1.time_ and arg_14_1.time_ < var_17_21 + var_17_22 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_21) / var_17_22

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_21 + var_17_22 and arg_14_1.time_ < var_17_21 + var_17_22 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play319681005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 319681005
		arg_22_1.duration_ = 5

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play319681006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 1.35

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_1 = arg_22_1:FormatText(arg_22_1:GetWordFromCfg(319681005).content)

				arg_22_1.text_.text = var_25_1

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_3 = 54 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_1) / 54)

				if (54 <= 0 and var_25_0 or var_25_0 * (utf8.len(var_25_1) / 54)) > 0 and var_25_0 < var_25_3 then
					arg_22_1.talkMaxDuration = var_25_3

					if var_25_3 + 0 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_3 + 0
					end
				end

				arg_22_1.text_.text = var_25_1
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_4 = math.max(var_25_0, arg_22_1.talkMaxDuration)

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_4 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - 0) / var_25_4

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= 0 + var_25_4 and arg_22_1.time_ < 0 + var_25_4 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play319681006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 319681006
		arg_26_1.duration_ = 2.03

		local var_26_0 = {
			zh = 1.533,
			ja = 2.033
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play319681007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.15

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_1 = arg_26_1:GetWordFromCfg(319681006)
				local var_29_2 = arg_26_1:FormatText(var_29_1.content)

				arg_26_1.text_.text = var_29_2

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 6 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 6)

				if (6 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 6)) > 0 and var_29_0 < var_29_4 then
					arg_26_1.talkMaxDuration = var_29_4

					if var_29_4 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_4 + 0
					end
				end

				arg_26_1.text_.text = var_29_2
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681006", "story_v_out_319681.awb") ~= 0 then
					local var_29_5 = manager.audio:GetVoiceLength("story_v_out_319681", "319681006", "story_v_out_319681.awb") / 1000

					if var_29_5 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + 0
					end

					if var_29_1.prefab_name ~= "" and arg_26_1.actors_[var_29_1.prefab_name] ~= nil then
						local var_29_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_1.prefab_name].transform, "story_v_out_319681", "319681006", "story_v_out_319681.awb")

						arg_26_1:RecordAudio("319681006", var_29_6)
						arg_26_1:RecordAudio("319681006", var_29_6)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_319681", "319681006", "story_v_out_319681.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_319681", "319681006", "story_v_out_319681.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_7 = math.max(var_29_0, arg_26_1.talkMaxDuration)

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_7 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - 0) / var_29_7

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= 0 + var_29_7 and arg_26_1.time_ < 0 + var_29_7 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play319681007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 319681007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play319681008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1:AudioAction("play", "effect", "se_story_130", "se_story_130__drip", "")
			end

			local var_33_1 = 0
			local var_33_2 = 1.225

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_3 = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(319681007).content)

				arg_30_1.text_.text = var_33_3

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_5 = 49 <= 0 and var_33_2 or var_33_2 * (utf8.len(var_33_3) / 49)

				if (49 <= 0 and var_33_2 or var_33_2 * (utf8.len(var_33_3) / 49)) > 0 and var_33_2 < var_33_5 then
					arg_30_1.talkMaxDuration = var_33_5

					if var_33_5 + var_33_1 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_5 + var_33_1
					end
				end

				arg_30_1.text_.text = var_33_3
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_6 = math.max(var_33_2, arg_30_1.talkMaxDuration)

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_6 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_1) / var_33_6

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_1 + var_33_6 and arg_30_1.time_ < var_33_1 + var_33_6 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play319681008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 319681008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play319681009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = 0.625

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, false)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_1 = arg_34_1:FormatText(arg_34_1:GetWordFromCfg(319681008).content)

				arg_34_1.text_.text = var_37_1

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_3 = 25 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_1) / 25)

				if (25 <= 0 and var_37_0 or var_37_0 * (utf8.len(var_37_1) / 25)) > 0 and var_37_0 < var_37_3 then
					arg_34_1.talkMaxDuration = var_37_3

					if var_37_3 + 0 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_3 + 0
					end
				end

				arg_34_1.text_.text = var_37_1
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_4 = math.max(var_37_0, arg_34_1.talkMaxDuration)

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_4 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - 0) / var_37_4

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= 0 + var_37_4 and arg_34_1.time_ < 0 + var_37_4 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play319681009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 319681009
		arg_38_1.duration_ = 7.03

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play319681010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0.999999999999 < arg_38_1.time_ and arg_38_1.time_ <= 0.999999999999 + arg_41_0 then
				local var_41_0 = arg_38_1.bgs_.XH0407a

				arg_38_1.bgs_.XH0407a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_41_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_41_1 = var_41_0:GetComponent("SpriteRenderer")

				if var_41_1 and var_41_1.sprite then
					local var_41_2 = 2 * (var_41_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_41_0.transform.localScale = Vector3.New(var_41_2 / var_41_1.sprite.bounds.size.y < var_41_2 * manager.ui.mainCameraCom_.aspect / var_41_1.sprite.bounds.size.x and var_41_2 * manager.ui.mainCameraCom_.aspect / var_41_1.sprite.bounds.size.x or var_41_2 / var_41_1.sprite.bounds.size.y, var_41_2 / var_41_1.sprite.bounds.size.y < var_41_2 * manager.ui.mainCameraCom_.aspect / var_41_1.sprite.bounds.size.x and var_41_2 * manager.ui.mainCameraCom_.aspect / var_41_1.sprite.bounds.size.x or var_41_2 / var_41_1.sprite.bounds.size.y, 0)
				end

				for iter_41_0, iter_41_1 in pairs(arg_38_1.bgs_) do
					if iter_41_0 ~= "XH0407a" then
						iter_41_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_41_3 = 0

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_3 + arg_41_0 then
				arg_38_1.allBtn_.enabled = false
			end

			if arg_38_1.time_ >= var_41_3 + 0.3 and arg_38_1.time_ < var_41_3 + 0.3 + arg_41_0 then
				arg_38_1.allBtn_.enabled = true
			end

			local var_41_4 = 0

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_4 + arg_41_0 then
				arg_38_1.mask_.enabled = true
				arg_38_1.mask_.raycastTarget = true

				arg_38_1:SetGaussion(false)
			end

			local var_41_5 = 1

			if var_41_4 <= arg_38_1.time_ and arg_38_1.time_ < var_41_4 + var_41_5 then
				local var_41_6 = Color.New(0, 0, 0)

				var_41_6.a = Mathf.Lerp(0, 1, (arg_38_1.time_ - var_41_4) / var_41_5)
				arg_38_1.mask_.color = var_41_6
			end

			if arg_38_1.time_ >= var_41_4 + var_41_5 and arg_38_1.time_ < var_41_4 + var_41_5 + arg_41_0 then
				local var_41_7 = Color.New(0, 0, 0)

				var_41_7.a = 1
				arg_38_1.mask_.color = var_41_7
			end

			local var_41_8 = 0.999999999999

			if 0.999999999999 < arg_38_1.time_ and arg_38_1.time_ <= var_41_8 + arg_41_0 then
				arg_38_1.mask_.enabled = true
				arg_38_1.mask_.raycastTarget = true

				arg_38_1:SetGaussion(false)
			end

			local var_41_9 = 1.03333333333333

			if var_41_8 <= arg_38_1.time_ and arg_38_1.time_ < var_41_8 + var_41_9 then
				local var_41_10 = Color.New(0, 0, 0)

				var_41_10.a = Mathf.Lerp(1, 0, (arg_38_1.time_ - var_41_8) / var_41_9)
				arg_38_1.mask_.color = var_41_10
			end

			if arg_38_1.time_ >= var_41_8 + var_41_9 and arg_38_1.time_ < var_41_8 + var_41_9 + arg_41_0 then
				local var_41_11 = Color.New(0, 0, 0)

				arg_38_1.mask_.enabled = false
				var_41_11.a = 0
				arg_38_1.mask_.color = var_41_11
			end

			if arg_38_1.frameCnt_ <= 1 then
				arg_38_1.dialog_:SetActive(false)
			end

			local var_41_12 = 2.03333333333233
			local var_41_13 = 0.225

			if 2.03333333333233 < arg_38_1.time_ and arg_38_1.time_ <= var_41_12 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0

				arg_38_1.dialog_:SetActive(true)

				arg_38_1.dialogCg_.alpha = 0

				local var_41_14 = LeanTween.value(arg_38_1.dialog_, 0, 1, 0.3)

				var_41_14:setOnUpdate(LuaHelper.FloatAction(function(arg_42_0)
					arg_38_1.dialogCg_.alpha = arg_42_0
				end))
				var_41_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_38_1.dialog_)
					var_41_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_38_1.duration_ = arg_38_1.duration_ + 0.3

				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_15 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(319681009).content)

				arg_38_1.text_.text = var_41_15

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_17 = 9 <= 0 and var_41_13 or var_41_13 * (utf8.len(var_41_15) / 9)

				if (9 <= 0 and var_41_13 or var_41_13 * (utf8.len(var_41_15) / 9)) > 0 and var_41_13 < var_41_17 then
					arg_38_1.talkMaxDuration = var_41_17
					var_41_12 = var_41_12 + 0.3

					if var_41_17 + var_41_12 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_17 + var_41_12
					end
				end

				arg_38_1.text_.text = var_41_15
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_18 = var_41_12 + 0.3
			local var_41_19 = math.max(var_41_13, arg_38_1.talkMaxDuration)

			if var_41_12 + 0.3 <= arg_38_1.time_ and arg_38_1.time_ < var_41_18 + var_41_19 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_18) / var_41_19

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_18 + var_41_19 and arg_38_1.time_ < var_41_18 + var_41_19 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play319681010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 319681010
		arg_44_1.duration_ = 3.7

		local var_44_0 = {
			zh = 2.9,
			ja = 3.7
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
				arg_44_0:Play319681011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.275

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_1 = arg_44_1:GetWordFromCfg(319681010)
				local var_47_2 = arg_44_1:FormatText(var_47_1.content)

				arg_44_1.text_.text = var_47_2

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 11 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 11)

				if (11 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 11)) > 0 and var_47_0 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + 0
					end
				end

				arg_44_1.text_.text = var_47_2
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681010", "story_v_out_319681.awb") ~= 0 then
					local var_47_5 = manager.audio:GetVoiceLength("story_v_out_319681", "319681010", "story_v_out_319681.awb") / 1000

					if var_47_5 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + 0
					end

					if var_47_1.prefab_name ~= "" and arg_44_1.actors_[var_47_1.prefab_name] ~= nil then
						local var_47_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_1.prefab_name].transform, "story_v_out_319681", "319681010", "story_v_out_319681.awb")

						arg_44_1:RecordAudio("319681010", var_47_6)
						arg_44_1:RecordAudio("319681010", var_47_6)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_319681", "319681010", "story_v_out_319681.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_319681", "319681010", "story_v_out_319681.awb")
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
	Play319681011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 319681011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play319681012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.325

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

				local var_51_1 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(319681011).content)

				arg_48_1.text_.text = var_51_1

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_3 = 13 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 13)

				if (13 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 13)) > 0 and var_51_0 < var_51_3 then
					arg_48_1.talkMaxDuration = var_51_3

					if var_51_3 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_3 + 0
					end
				end

				arg_48_1.text_.text = var_51_1
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_4 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_4

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play319681012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 319681012
		arg_52_1.duration_ = 2

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play319681013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				local var_55_0 = arg_52_1.fswbg_.transform:Find("textbox/adapt/content") or arg_52_1.fswbg_.transform:Find("textbox/content")
				local var_55_1 = arg_52_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_55_2 = var_55_0:GetComponent("RectTransform")

				var_55_0:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_55_2.offsetMin = Vector2.New(0, 0)
				var_55_2.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.fswbg_:SetActive(true)
				arg_52_1.dialog_:SetActive(false)

				arg_52_1.fswtw_.percent = 0
				arg_52_1.fswt_.text = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(319681012).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.fswt_)

				arg_52_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_52_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_52_1.fswtw_:SetDirty()

				arg_52_1.typewritterCharCountI18N = 0

				SetActive(arg_52_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_52_1:ShowNextGo(false)
			end

			local var_55_3 = 0.566666666666667

			if 0.566666666666667 < arg_52_1.time_ and arg_52_1.time_ <= var_55_3 + arg_55_0 then
				arg_52_1.var_.oldValueTypewriter = arg_52_1.fswtw_.percent

				SetActive(arg_52_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_52_1:ShowNextGo(false)
			end

			local var_55_4 = 19
			local var_55_5 = 1.26666666666667
			local var_55_6, var_55_7 = arg_52_1:GetPercentByPara(arg_52_1:FormatText(arg_52_1:GetWordFromCfg(319681012).content), 1)

			if var_55_3 < arg_52_1.time_ and arg_52_1.time_ <= var_55_3 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0

				local var_55_8 = var_55_4 <= 0 and var_55_5 or var_55_5 * ((var_55_7 - arg_52_1.typewritterCharCountI18N) / var_55_4)

				if (var_55_4 <= 0 and var_55_5 or var_55_5 * ((var_55_7 - arg_52_1.typewritterCharCountI18N) / var_55_4)) > 0 and var_55_5 < var_55_8 then
					arg_52_1.talkMaxDuration = var_55_8

					if var_55_8 + var_55_3 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_3
					end
				end
			end

			local var_55_9 = math.max(1.26666666666667, arg_52_1.talkMaxDuration)

			if var_55_3 <= arg_52_1.time_ and arg_52_1.time_ < var_55_3 + var_55_9 then
				arg_52_1.fswtw_.percent = Mathf.Lerp(arg_52_1.var_.oldValueTypewriter, var_55_6, (arg_52_1.time_ - var_55_3) / var_55_9)
				arg_52_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_52_1.fswtw_:SetDirty()
			end

			if arg_52_1.time_ >= var_55_3 + var_55_9 and arg_52_1.time_ < var_55_3 + var_55_9 + arg_55_0 then
				arg_52_1.fswtw_.percent = var_55_6

				arg_52_1.fswtw_:SetDirty()
				arg_52_1:ShowNextGo(true)

				arg_52_1.typewritterCharCountI18N = var_55_7
			end

			local var_55_10 = "STblack"

			if arg_52_1.bgs_.STblack == nil then
				local var_55_11 = Object.Instantiate(arg_52_1.paintGo_)

				var_55_11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_55_10)
				var_55_11.name = var_55_10
				var_55_11.transform.parent = arg_52_1.stage_.transform
				var_55_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.bgs_[var_55_10] = var_55_11
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				local var_55_12 = arg_52_1.bgs_.STblack

				arg_52_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_55_12.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_55_13 = var_55_12:GetComponent("SpriteRenderer")

				if var_55_13 and var_55_13.sprite then
					local var_55_14 = 2 * (var_55_12.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_55_12.transform.localScale = Vector3.New(var_55_14 / var_55_13.sprite.bounds.size.y < var_55_14 * manager.ui.mainCameraCom_.aspect / var_55_13.sprite.bounds.size.x and var_55_14 * manager.ui.mainCameraCom_.aspect / var_55_13.sprite.bounds.size.x or var_55_14 / var_55_13.sprite.bounds.size.y, var_55_14 / var_55_13.sprite.bounds.size.y < var_55_14 * manager.ui.mainCameraCom_.aspect / var_55_13.sprite.bounds.size.x and var_55_14 * manager.ui.mainCameraCom_.aspect / var_55_13.sprite.bounds.size.x or var_55_14 / var_55_13.sprite.bounds.size.y, 0)
				end

				for iter_55_0, iter_55_1 in pairs(arg_52_1.bgs_) do
					if iter_55_0 ~= "STblack" then
						iter_55_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_55_15 = 0

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_15 + arg_55_0 then
				arg_52_1.mask_.enabled = true
				arg_52_1.mask_.raycastTarget = false

				arg_52_1:SetGaussion(false)
			end

			local var_55_16 = 0.0666666666666667

			if var_55_15 <= arg_52_1.time_ and arg_52_1.time_ < var_55_15 + var_55_16 then
				local var_55_17 = Color.New(1, 1, 1)

				var_55_17.a = Mathf.Lerp(1, 0, (arg_52_1.time_ - var_55_15) / var_55_16)
				arg_52_1.mask_.color = var_55_17
			end

			if arg_52_1.time_ >= var_55_15 + var_55_16 and arg_52_1.time_ < var_55_15 + var_55_16 + arg_55_0 then
				local var_55_18 = Color.New(1, 1, 1)

				arg_52_1.mask_.enabled = false
				var_55_18.a = 0
				arg_52_1.mask_.color = var_55_18
			end

			local var_55_19 = 0.566666666666667
			local var_55_20 = manager.audio:GetVoiceLength("story_v_out_319681", "319681012", "story_v_out_319681.awb") / 1000

			if var_55_20 > 0 and 1 < var_55_20 and var_55_20 + var_55_19 > arg_52_1.duration_ then
				arg_52_1.duration_ = var_55_20 + var_55_19
			end

			if var_55_19 < arg_52_1.time_ and arg_52_1.time_ <= var_55_19 + arg_55_0 then
				arg_52_1:AudioAction("play", "voice", "story_v_out_319681", "319681012", "story_v_out_319681.awb")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.cswbg_:SetActive(true)

				local var_55_22 = arg_52_1.cswt_:GetComponent("RectTransform")

				arg_52_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_55_22.offsetMin = Vector2.New(410, 330)
				var_55_22.offsetMax = Vector2.New(-400, -175)
				arg_52_1.cswt_.text = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(419042).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.cswt_)

				arg_52_1.cswt_.fontSize = 180
				arg_52_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_52_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_52_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play319681013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 319681013
		arg_56_1.duration_ = 1

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play319681014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.fswbg_:SetActive(true)
				arg_56_1.dialog_:SetActive(false)

				arg_56_1.fswtw_.percent = 0
				arg_56_1.fswt_.text = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(319681013).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.fswt_)

				arg_56_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_56_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_56_1.fswtw_:SetDirty()

				arg_56_1.typewritterCharCountI18N = 0

				SetActive(arg_56_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_56_1:ShowNextGo(false)
			end

			local var_59_0 = 0.166666666666667

			if 0.166666666666667 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.var_.oldValueTypewriter = arg_56_1.fswtw_.percent

				SetActive(arg_56_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_56_1:ShowNextGo(false)
			end

			local var_59_1 = 10
			local var_59_2 = 0.666666666666667
			local var_59_3, var_59_4 = arg_56_1:GetPercentByPara(arg_56_1:FormatText(arg_56_1:GetWordFromCfg(319681013).content), 1)

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				local var_59_5 = var_59_1 <= 0 and var_59_2 or var_59_2 * ((var_59_4 - arg_56_1.typewritterCharCountI18N) / var_59_1)

				if (var_59_1 <= 0 and var_59_2 or var_59_2 * ((var_59_4 - arg_56_1.typewritterCharCountI18N) / var_59_1)) > 0 and var_59_2 < var_59_5 then
					arg_56_1.talkMaxDuration = var_59_5

					if var_59_5 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + var_59_0
					end
				end
			end

			local var_59_6 = math.max(0.666666666666667, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_6 then
				arg_56_1.fswtw_.percent = Mathf.Lerp(arg_56_1.var_.oldValueTypewriter, var_59_3, (arg_56_1.time_ - var_59_0) / var_59_6)
				arg_56_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_56_1.fswtw_:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_6 and arg_56_1.time_ < var_59_0 + var_59_6 + arg_59_0 then
				arg_56_1.fswtw_.percent = var_59_3

				arg_56_1.fswtw_:SetDirty()
				arg_56_1:ShowNextGo(true)

				arg_56_1.typewritterCharCountI18N = var_59_4
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play319681014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 319681014
		arg_60_1.duration_ = 2

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play319681015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.fswbg_:SetActive(true)
				arg_60_1.dialog_:SetActive(false)

				arg_60_1.fswtw_.percent = 0
				arg_60_1.fswt_.text = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(319681014).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.fswt_)

				arg_60_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_60_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_60_1.fswtw_:SetDirty()

				arg_60_1.typewritterCharCountI18N = 0

				SetActive(arg_60_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_60_1:ShowNextGo(false)
			end

			local var_63_0 = 0.666666666666667

			if 0.666666666666667 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.var_.oldValueTypewriter = arg_60_1.fswtw_.percent

				SetActive(arg_60_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_60_1:ShowNextGo(false)
			end

			local var_63_1 = 3
			local var_63_2 = 0.2
			local var_63_3, var_63_4 = arg_60_1:GetPercentByPara(arg_60_1:FormatText(arg_60_1:GetWordFromCfg(319681014).content), 1)

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				local var_63_5 = var_63_1 <= 0 and var_63_2 or var_63_2 * ((var_63_4 - arg_60_1.typewritterCharCountI18N) / var_63_1)

				if (var_63_1 <= 0 and var_63_2 or var_63_2 * ((var_63_4 - arg_60_1.typewritterCharCountI18N) / var_63_1)) > 0 and var_63_2 < var_63_5 then
					arg_60_1.talkMaxDuration = var_63_5

					if var_63_5 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + var_63_0
					end
				end
			end

			local var_63_6 = math.max(0.2, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_6 then
				arg_60_1.fswtw_.percent = Mathf.Lerp(arg_60_1.var_.oldValueTypewriter, var_63_3, (arg_60_1.time_ - var_63_0) / var_63_6)
				arg_60_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_60_1.fswtw_:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_6 and arg_60_1.time_ < var_63_0 + var_63_6 + arg_63_0 then
				arg_60_1.fswtw_.percent = var_63_3

				arg_60_1.fswtw_:SetDirty()
				arg_60_1:ShowNextGo(true)

				arg_60_1.typewritterCharCountI18N = var_63_4
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				local var_63_7 = arg_60_1.bgs_.STblack

				arg_60_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_63_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_63_8 = var_63_7:GetComponent("SpriteRenderer")

				if var_63_8 and var_63_8.sprite then
					local var_63_9 = 2 * (var_63_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_63_7.transform.localScale = Vector3.New(var_63_9 / var_63_8.sprite.bounds.size.y < var_63_9 * manager.ui.mainCameraCom_.aspect / var_63_8.sprite.bounds.size.x and var_63_9 * manager.ui.mainCameraCom_.aspect / var_63_8.sprite.bounds.size.x or var_63_9 / var_63_8.sprite.bounds.size.y, var_63_9 / var_63_8.sprite.bounds.size.y < var_63_9 * manager.ui.mainCameraCom_.aspect / var_63_8.sprite.bounds.size.x and var_63_9 * manager.ui.mainCameraCom_.aspect / var_63_8.sprite.bounds.size.x or var_63_9 / var_63_8.sprite.bounds.size.y, 0)
				end

				for iter_63_0, iter_63_1 in pairs(arg_60_1.bgs_) do
					if iter_63_0 ~= "STblack" then
						iter_63_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_63_10 = 0

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = false

				arg_60_1:SetGaussion(false)
			end

			local var_63_11 = 0.0666666666666667

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_11 then
				local var_63_12 = Color.New(1, 1, 1)

				var_63_12.a = Mathf.Lerp(1, 0, (arg_60_1.time_ - var_63_10) / var_63_11)
				arg_60_1.mask_.color = var_63_12
			end

			if arg_60_1.time_ >= var_63_10 + var_63_11 and arg_60_1.time_ < var_63_10 + var_63_11 + arg_63_0 then
				local var_63_13 = Color.New(1, 1, 1)

				arg_60_1.mask_.enabled = false
				var_63_13.a = 0
				arg_60_1.mask_.color = var_63_13
			end

			local var_63_14 = 0
			local var_63_15 = manager.audio:GetVoiceLength("story_v_out_319681", "319681014", "story_v_out_319681.awb") / 1000

			if var_63_15 > 0 and 1 < var_63_15 and var_63_15 + var_63_14 > arg_60_1.duration_ then
				arg_60_1.duration_ = var_63_15 + var_63_14
			end

			if var_63_14 < arg_60_1.time_ and arg_60_1.time_ <= var_63_14 + arg_63_0 then
				arg_60_1:AudioAction("play", "voice", "story_v_out_319681", "319681014", "story_v_out_319681.awb")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.cswbg_:SetActive(true)

				local var_63_17 = arg_60_1.cswt_:GetComponent("RectTransform")

				arg_60_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_63_17.offsetMin = Vector2.New(410, 330)
				var_63_17.offsetMax = Vector2.New(-400, -175)
				arg_60_1.cswt_.text = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(419043).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.cswt_)

				arg_60_1.cswt_.fontSize = 180
				arg_60_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_60_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_60_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play319681015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 319681015
		arg_64_1.duration_ = 1

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play319681016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.fswbg_:SetActive(true)
				arg_64_1.dialog_:SetActive(false)

				arg_64_1.fswtw_.percent = 0
				arg_64_1.fswt_.text = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(319681015).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.fswt_)

				arg_64_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_64_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_64_1.fswtw_:SetDirty()

				arg_64_1.typewritterCharCountI18N = 0

				SetActive(arg_64_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_64_1:ShowNextGo(false)
			end

			local var_67_0 = 0.1

			if 0.1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.var_.oldValueTypewriter = arg_64_1.fswtw_.percent

				SetActive(arg_64_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_64_1:ShowNextGo(false)
			end

			local var_67_1 = 7
			local var_67_2 = 0.466666666666667
			local var_67_3, var_67_4 = arg_64_1:GetPercentByPara(arg_64_1:FormatText(arg_64_1:GetWordFromCfg(319681015).content), 1)

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0

				local var_67_5 = var_67_1 <= 0 and var_67_2 or var_67_2 * ((var_67_4 - arg_64_1.typewritterCharCountI18N) / var_67_1)

				if (var_67_1 <= 0 and var_67_2 or var_67_2 * ((var_67_4 - arg_64_1.typewritterCharCountI18N) / var_67_1)) > 0 and var_67_2 < var_67_5 then
					arg_64_1.talkMaxDuration = var_67_5

					if var_67_5 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + var_67_0
					end
				end
			end

			local var_67_6 = math.max(0.466666666666667, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_6 then
				arg_64_1.fswtw_.percent = Mathf.Lerp(arg_64_1.var_.oldValueTypewriter, var_67_3, (arg_64_1.time_ - var_67_0) / var_67_6)
				arg_64_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_64_1.fswtw_:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_6 and arg_64_1.time_ < var_67_0 + var_67_6 + arg_67_0 then
				arg_64_1.fswtw_.percent = var_67_3

				arg_64_1.fswtw_:SetDirty()
				arg_64_1:ShowNextGo(true)

				arg_64_1.typewritterCharCountI18N = var_67_4
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play319681016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 319681016
		arg_68_1.duration_ = 1.13

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play319681017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.fswbg_:SetActive(true)
				arg_68_1.dialog_:SetActive(false)

				arg_68_1.fswtw_.percent = 0
				arg_68_1.fswt_.text = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(319681016).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.fswt_)

				arg_68_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_68_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_68_1.fswtw_:SetDirty()

				arg_68_1.typewritterCharCountI18N = 0

				SetActive(arg_68_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_68_1:ShowNextGo(false)
			end

			local var_71_0 = 0.4

			if 0.4 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.var_.oldValueTypewriter = arg_68_1.fswtw_.percent

				SetActive(arg_68_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_68_1:ShowNextGo(false)
			end

			local var_71_1 = 2
			local var_71_2 = 0.133333333333333
			local var_71_3, var_71_4 = arg_68_1:GetPercentByPara(arg_68_1:FormatText(arg_68_1:GetWordFromCfg(319681016).content), 1)

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0

				local var_71_5 = var_71_1 <= 0 and var_71_2 or var_71_2 * ((var_71_4 - arg_68_1.typewritterCharCountI18N) / var_71_1)

				if (var_71_1 <= 0 and var_71_2 or var_71_2 * ((var_71_4 - arg_68_1.typewritterCharCountI18N) / var_71_1)) > 0 and var_71_2 < var_71_5 then
					arg_68_1.talkMaxDuration = var_71_5

					if var_71_5 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + var_71_0
					end
				end
			end

			local var_71_6 = math.max(0.133333333333333, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_6 then
				arg_68_1.fswtw_.percent = Mathf.Lerp(arg_68_1.var_.oldValueTypewriter, var_71_3, (arg_68_1.time_ - var_71_0) / var_71_6)
				arg_68_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_68_1.fswtw_:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_6 and arg_68_1.time_ < var_71_0 + var_71_6 + arg_71_0 then
				arg_68_1.fswtw_.percent = var_71_3

				arg_68_1.fswtw_:SetDirty()
				arg_68_1:ShowNextGo(true)

				arg_68_1.typewritterCharCountI18N = var_71_4
			end

			local var_71_7 = 0
			local var_71_8 = manager.audio:GetVoiceLength("story_v_out_319681", "319681016", "story_v_out_319681.awb") / 1000

			if var_71_8 > 0 and 1.133 < var_71_8 and var_71_8 + var_71_7 > arg_68_1.duration_ then
				arg_68_1.duration_ = var_71_8 + var_71_7
			end

			if var_71_7 < arg_68_1.time_ and arg_68_1.time_ <= var_71_7 + arg_71_0 then
				arg_68_1:AudioAction("play", "voice", "story_v_out_319681", "319681016", "story_v_out_319681.awb")
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play319681017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 319681017
		arg_72_1.duration_ = 1.37

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play319681018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0.2 < arg_72_1.time_ and arg_72_1.time_ <= 0.2 + arg_75_0 then
				arg_72_1.fswbg_:SetActive(true)
				arg_72_1.dialog_:SetActive(false)

				arg_72_1.fswtw_.percent = 0
				arg_72_1.fswt_.text = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(319681017).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.fswt_)

				arg_72_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_72_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_72_1.fswtw_:SetDirty()

				arg_72_1.typewritterCharCountI18N = 0

				SetActive(arg_72_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_72_1:ShowNextGo(false)
			end

			local var_75_0 = 0.366666666666667

			if 0.366666666666667 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.var_.oldValueTypewriter = arg_72_1.fswtw_.percent

				SetActive(arg_72_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_72_1:ShowNextGo(false)
			end

			local var_75_1 = 4
			local var_75_2 = 0.266666666666667
			local var_75_3, var_75_4 = arg_72_1:GetPercentByPara(arg_72_1:FormatText(arg_72_1:GetWordFromCfg(319681017).content), 1)

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0

				local var_75_5 = var_75_1 <= 0 and var_75_2 or var_75_2 * ((var_75_4 - arg_72_1.typewritterCharCountI18N) / var_75_1)

				if (var_75_1 <= 0 and var_75_2 or var_75_2 * ((var_75_4 - arg_72_1.typewritterCharCountI18N) / var_75_1)) > 0 and var_75_2 < var_75_5 then
					arg_72_1.talkMaxDuration = var_75_5

					if var_75_5 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + var_75_0
					end
				end
			end

			local var_75_6 = math.max(0.266666666666667, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_6 then
				arg_72_1.fswtw_.percent = Mathf.Lerp(arg_72_1.var_.oldValueTypewriter, var_75_3, (arg_72_1.time_ - var_75_0) / var_75_6)
				arg_72_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_72_1.fswtw_:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_6 and arg_72_1.time_ < var_75_0 + var_75_6 + arg_75_0 then
				arg_72_1.fswtw_.percent = var_75_3

				arg_72_1.fswtw_:SetDirty()
				arg_72_1:ShowNextGo(true)

				arg_72_1.typewritterCharCountI18N = var_75_4
			end

			local var_75_7 = 0

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_7 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = false

				arg_72_1:SetGaussion(false)
			end

			local var_75_8 = 0.0166666666666667

			if var_75_7 <= arg_72_1.time_ and arg_72_1.time_ < var_75_7 + var_75_8 then
				local var_75_9 = Color.New(1, 1, 1)

				var_75_9.a = Mathf.Lerp(1, 0, (arg_72_1.time_ - var_75_7) / var_75_8)
				arg_72_1.mask_.color = var_75_9
			end

			if arg_72_1.time_ >= var_75_7 + var_75_8 and arg_72_1.time_ < var_75_7 + var_75_8 + arg_75_0 then
				local var_75_10 = Color.New(1, 1, 1)

				arg_72_1.mask_.enabled = false
				var_75_10.a = 0
				arg_72_1.mask_.color = var_75_10
			end

			local var_75_11 = 0.366666666666667
			local var_75_12 = manager.audio:GetVoiceLength("story_v_out_319681", "319681017", "story_v_out_319681.awb") / 1000

			if var_75_12 > 0 and 1 < var_75_12 and var_75_12 + var_75_11 > arg_72_1.duration_ then
				arg_72_1.duration_ = var_75_12 + var_75_11
			end

			if var_75_11 < arg_72_1.time_ and arg_72_1.time_ <= var_75_11 + arg_75_0 then
				arg_72_1:AudioAction("play", "voice", "story_v_out_319681", "319681017", "story_v_out_319681.awb")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.cswbg_:SetActive(true)

				local var_75_14 = arg_72_1.cswt_:GetComponent("RectTransform")

				arg_72_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_75_14.offsetMin = Vector2.New(410, 330)
				var_75_14.offsetMax = Vector2.New(-400, -175)
				arg_72_1.cswt_.text = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(419044).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.cswt_)

				arg_72_1.cswt_.fontSize = 180
				arg_72_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_72_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_72_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play319681018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 319681018
		arg_76_1.duration_ = 1.1

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play319681019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.fswbg_:SetActive(true)
				arg_76_1.dialog_:SetActive(false)

				arg_76_1.fswtw_.percent = 0
				arg_76_1.fswt_.text = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(319681018).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.fswt_)

				arg_76_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_76_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_76_1.fswtw_:SetDirty()

				arg_76_1.typewritterCharCountI18N = 0

				SetActive(arg_76_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_76_1:ShowNextGo(false)
			end

			local var_79_0 = 0.1

			if 0.1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.var_.oldValueTypewriter = arg_76_1.fswtw_.percent

				SetActive(arg_76_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_76_1:ShowNextGo(false)
			end

			local var_79_1 = 4
			local var_79_2 = 0.133333333333333
			local var_79_3, var_79_4 = arg_76_1:GetPercentByPara(arg_76_1:FormatText(arg_76_1:GetWordFromCfg(319681018).content), 1)

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0

				local var_79_5 = var_79_1 <= 0 and var_79_2 or var_79_2 * ((var_79_4 - arg_76_1.typewritterCharCountI18N) / var_79_1)

				if (var_79_1 <= 0 and var_79_2 or var_79_2 * ((var_79_4 - arg_76_1.typewritterCharCountI18N) / var_79_1)) > 0 and var_79_2 < var_79_5 then
					arg_76_1.talkMaxDuration = var_79_5

					if var_79_5 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + var_79_0
					end
				end
			end

			local var_79_6 = math.max(0.133333333333333, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_6 then
				arg_76_1.fswtw_.percent = Mathf.Lerp(arg_76_1.var_.oldValueTypewriter, var_79_3, (arg_76_1.time_ - var_79_0) / var_79_6)
				arg_76_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_76_1.fswtw_:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_6 and arg_76_1.time_ < var_79_0 + var_79_6 + arg_79_0 then
				arg_76_1.fswtw_.percent = var_79_3

				arg_76_1.fswtw_:SetDirty()
				arg_76_1:ShowNextGo(true)

				arg_76_1.typewritterCharCountI18N = var_79_4
			end

			local var_79_7 = 0.1
			local var_79_8 = manager.audio:GetVoiceLength("story_v_out_319681", "319681018", "story_v_out_319681.awb") / 1000

			if var_79_8 > 0 and 1 < var_79_8 and var_79_8 + var_79_7 > arg_76_1.duration_ then
				arg_76_1.duration_ = var_79_8 + var_79_7
			end

			if var_79_7 < arg_76_1.time_ and arg_76_1.time_ <= var_79_7 + arg_79_0 then
				arg_76_1:AudioAction("play", "voice", "story_v_out_319681", "319681018", "story_v_out_319681.awb")
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play319681019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 319681019
		arg_80_1.duration_ = 6

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play319681020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				local var_83_0 = arg_80_1.bgs_.STblack

				arg_80_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_83_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_83_1 = var_83_0:GetComponent("SpriteRenderer")

				if var_83_1 and var_83_1.sprite then
					local var_83_2 = 2 * (var_83_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_83_0.transform.localScale = Vector3.New(var_83_2 / var_83_1.sprite.bounds.size.y < var_83_2 * manager.ui.mainCameraCom_.aspect / var_83_1.sprite.bounds.size.x and var_83_2 * manager.ui.mainCameraCom_.aspect / var_83_1.sprite.bounds.size.x or var_83_2 / var_83_1.sprite.bounds.size.y, var_83_2 / var_83_1.sprite.bounds.size.y < var_83_2 * manager.ui.mainCameraCom_.aspect / var_83_1.sprite.bounds.size.x and var_83_2 * manager.ui.mainCameraCom_.aspect / var_83_1.sprite.bounds.size.x or var_83_2 / var_83_1.sprite.bounds.size.y, 0)
				end

				for iter_83_0, iter_83_1 in pairs(arg_80_1.bgs_) do
					if iter_83_0 ~= "STblack" then
						iter_83_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_83_3 = 0

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_3 + arg_83_0 then
				arg_80_1.mask_.enabled = true
				arg_80_1.mask_.raycastTarget = true

				arg_80_1:SetGaussion(false)
			end

			local var_83_4 = 1.03723490191624

			if var_83_3 <= arg_80_1.time_ and arg_80_1.time_ < var_83_3 + var_83_4 then
				local var_83_5 = Color.New(0, 0, 0)

				var_83_5.a = Mathf.Lerp(1, 0, (arg_80_1.time_ - var_83_3) / var_83_4)
				arg_80_1.mask_.color = var_83_5
			end

			if arg_80_1.time_ >= var_83_3 + var_83_4 and arg_80_1.time_ < var_83_3 + var_83_4 + arg_83_0 then
				local var_83_6 = Color.New(0, 0, 0)

				arg_80_1.mask_.enabled = false
				var_83_6.a = 0
				arg_80_1.mask_.color = var_83_6
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:AudioAction("play", "effect", "se_story_130", "se_story_130_fall1", "")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.cswbg_:SetActive(false)
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.fswbg_:SetActive(false)
				arg_80_1.dialog_:SetActive(false)
				SetActive(arg_80_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_80_1:ShowNextGo(false)
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.fswbg_:SetActive(false)
				arg_80_1.dialog_:SetActive(false)
				SetActive(arg_80_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_80_1:ShowNextGo(false)
			end

			if arg_80_1.frameCnt_ <= 1 then
				arg_80_1.dialog_:SetActive(false)
			end

			local var_83_8 = 1
			local var_83_9 = 1.125

			if 1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_8 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0

				arg_80_1.dialog_:SetActive(true)

				arg_80_1.dialogCg_.alpha = 0

				local var_83_10 = LeanTween.value(arg_80_1.dialog_, 0, 1, 0.3)

				var_83_10:setOnUpdate(LuaHelper.FloatAction(function(arg_84_0)
					arg_80_1.dialogCg_.alpha = arg_84_0
				end))
				var_83_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_80_1.dialog_)
					var_83_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_80_1.duration_ = arg_80_1.duration_ + 0.3

				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_11 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(319681019).content)

				arg_80_1.text_.text = var_83_11

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_13 = 45 <= 0 and var_83_9 or var_83_9 * (utf8.len(var_83_11) / 45)

				if (45 <= 0 and var_83_9 or var_83_9 * (utf8.len(var_83_11) / 45)) > 0 and var_83_9 < var_83_13 then
					arg_80_1.talkMaxDuration = var_83_13
					var_83_8 = var_83_8 + 0.3

					if var_83_13 + var_83_8 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_13 + var_83_8
					end
				end

				arg_80_1.text_.text = var_83_11
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_14 = var_83_8 + 0.3
			local var_83_15 = math.max(var_83_9, arg_80_1.talkMaxDuration)

			if var_83_8 + 0.3 <= arg_80_1.time_ and arg_80_1.time_ < var_83_14 + var_83_15 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_14) / var_83_15

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_14 + var_83_15 and arg_80_1.time_ < var_83_14 + var_83_15 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play319681020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 319681020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play319681021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 1.15

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_1 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(319681020).content)

				arg_86_1.text_.text = var_89_1

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_3 = 46 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_1) / 46)

				if (46 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_1) / 46)) > 0 and var_89_0 < var_89_3 then
					arg_86_1.talkMaxDuration = var_89_3

					if var_89_3 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_3 + 0
					end
				end

				arg_86_1.text_.text = var_89_1
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_4 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_4 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_4

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_4 and arg_86_1.time_ < 0 + var_89_4 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play319681021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 319681021
		arg_90_1.duration_ = 3.7

		local var_90_0 = {
			zh = 2.233,
			ja = 3.7
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play319681022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.225

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_1 = arg_90_1:GetWordFromCfg(319681021)
				local var_93_2 = arg_90_1:FormatText(var_93_1.content)

				arg_90_1.text_.text = var_93_2

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_4 = 9 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 9)

				if (9 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_2) / 9)) > 0 and var_93_0 < var_93_4 then
					arg_90_1.talkMaxDuration = var_93_4

					if var_93_4 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_4 + 0
					end
				end

				arg_90_1.text_.text = var_93_2
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681021", "story_v_out_319681.awb") ~= 0 then
					local var_93_5 = manager.audio:GetVoiceLength("story_v_out_319681", "319681021", "story_v_out_319681.awb") / 1000

					if var_93_5 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + 0
					end

					if var_93_1.prefab_name ~= "" and arg_90_1.actors_[var_93_1.prefab_name] ~= nil then
						local var_93_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_1.prefab_name].transform, "story_v_out_319681", "319681021", "story_v_out_319681.awb")

						arg_90_1:RecordAudio("319681021", var_93_6)
						arg_90_1:RecordAudio("319681021", var_93_6)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_319681", "319681021", "story_v_out_319681.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_319681", "319681021", "story_v_out_319681.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_7 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_7 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_7

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_7 and arg_90_1.time_ < 0 + var_93_7 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play319681022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 319681022
		arg_94_1.duration_ = 5.63

		local var_94_0 = {
			zh = 4.533,
			ja = 5.633
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
				arg_94_0:Play319681023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if arg_94_1.bgs_.D10 == nil then
				local var_97_0 = Object.Instantiate(arg_94_1.paintGo_)

				var_97_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D10")
				var_97_0.name = "D10"
				var_97_0.transform.parent = arg_94_1.stage_.transform
				var_97_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_94_1.bgs_.D10 = var_97_0
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				local var_97_1 = arg_94_1.bgs_.D10

				arg_94_1.bgs_.D10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_97_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_97_2 = var_97_1:GetComponent("SpriteRenderer")

				if var_97_2 and var_97_2.sprite then
					local var_97_3 = 2 * (var_97_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_97_1.transform.localScale = Vector3.New(var_97_3 / var_97_2.sprite.bounds.size.y < var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x and var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x or var_97_3 / var_97_2.sprite.bounds.size.y, var_97_3 / var_97_2.sprite.bounds.size.y < var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x and var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x or var_97_3 / var_97_2.sprite.bounds.size.y, 0)
				end

				for iter_97_0, iter_97_1 in pairs(arg_94_1.bgs_) do
					if iter_97_0 ~= "D10" then
						iter_97_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_97_4 = 0

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1.allBtn_.enabled = false
			end

			if arg_94_1.time_ >= var_97_4 + 0.3 and arg_94_1.time_ < var_97_4 + 0.3 + arg_97_0 then
				arg_94_1.allBtn_.enabled = true
			end

			local var_97_5 = 0

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 then
				arg_94_1.mask_.enabled = true
				arg_94_1.mask_.raycastTarget = true

				arg_94_1:SetGaussion(false)
			end

			local var_97_6 = 2

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_6 then
				local var_97_7 = Color.New(0, 0, 0)

				var_97_7.a = Mathf.Lerp(1, 0, (arg_94_1.time_ - var_97_5) / var_97_6)
				arg_94_1.mask_.color = var_97_7
			end

			if arg_94_1.time_ >= var_97_5 + var_97_6 and arg_94_1.time_ < var_97_5 + var_97_6 + arg_97_0 then
				local var_97_8 = Color.New(0, 0, 0)

				arg_94_1.mask_.enabled = false
				var_97_8.a = 0
				arg_94_1.mask_.color = var_97_8
			end

			if arg_94_1.frameCnt_ <= 1 then
				arg_94_1.dialog_:SetActive(false)
			end

			local var_97_9 = 2
			local var_97_10 = 0.2

			if 2 < arg_94_1.time_ and arg_94_1.time_ <= var_97_9 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0

				arg_94_1.dialog_:SetActive(true)

				arg_94_1.dialogCg_.alpha = 0

				local var_97_11 = LeanTween.value(arg_94_1.dialog_, 0, 1, 0.3)

				var_97_11:setOnUpdate(LuaHelper.FloatAction(function(arg_98_0)
					arg_94_1.dialogCg_.alpha = arg_98_0
				end))
				var_97_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_94_1.dialog_)
					var_97_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_94_1.duration_ = arg_94_1.duration_ + 0.3

				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[660].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_12 = arg_94_1:GetWordFromCfg(319681022)
				local var_97_13 = arg_94_1:FormatText(var_97_12.content)

				arg_94_1.text_.text = var_97_13

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_15 = 8 <= 0 and var_97_10 or var_97_10 * (utf8.len(var_97_13) / 8)

				if (8 <= 0 and var_97_10 or var_97_10 * (utf8.len(var_97_13) / 8)) > 0 and var_97_10 < var_97_15 then
					arg_94_1.talkMaxDuration = var_97_15
					var_97_9 = var_97_9 + 0.3

					if var_97_15 + var_97_9 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_15 + var_97_9
					end
				end

				arg_94_1.text_.text = var_97_13
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681022", "story_v_out_319681.awb") ~= 0 then
					local var_97_16 = manager.audio:GetVoiceLength("story_v_out_319681", "319681022", "story_v_out_319681.awb") / 1000

					if var_97_16 + var_97_9 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_16 + var_97_9
					end

					if var_97_12.prefab_name ~= "" and arg_94_1.actors_[var_97_12.prefab_name] ~= nil then
						local var_97_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_12.prefab_name].transform, "story_v_out_319681", "319681022", "story_v_out_319681.awb")

						arg_94_1:RecordAudio("319681022", var_97_17)
						arg_94_1:RecordAudio("319681022", var_97_17)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_319681", "319681022", "story_v_out_319681.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_319681", "319681022", "story_v_out_319681.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_18 = var_97_9 + 0.3
			local var_97_19 = math.max(var_97_10, arg_94_1.talkMaxDuration)

			if var_97_9 + 0.3 <= arg_94_1.time_ and arg_94_1.time_ < var_97_18 + var_97_19 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_18) / var_97_19

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_18 + var_97_19 and arg_94_1.time_ < var_97_18 + var_97_19 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play319681023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 319681023
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play319681024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 1.05

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, false)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_1 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(319681023).content)

				arg_100_1.text_.text = var_103_1

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_3 = 42 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 42)

				if (42 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 42)) > 0 and var_103_0 < var_103_3 then
					arg_100_1.talkMaxDuration = var_103_3

					if var_103_3 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_3 + 0
					end
				end

				arg_100_1.text_.text = var_103_1
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_4 = math.max(var_103_0, arg_100_1.talkMaxDuration)

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_4 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - 0) / var_103_4

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= 0 + var_103_4 and arg_100_1.time_ < 0 + var_103_4 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play319681024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 319681024
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play319681025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 1.275

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_1 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(319681024).content)

				arg_104_1.text_.text = var_107_1

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_3 = 51 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 51)

				if (51 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 51)) > 0 and var_107_0 < var_107_3 then
					arg_104_1.talkMaxDuration = var_107_3

					if var_107_3 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_3 + 0
					end
				end

				arg_104_1.text_.text = var_107_1
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_4 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_4

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play319681025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 319681025
		arg_108_1.duration_ = 4.93

		local var_108_0 = {
			zh = 4.933,
			ja = 4.6
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
				arg_108_0:Play319681026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if arg_108_1.actors_["10079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10079ui_story"))) then
				local var_111_0 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_108_1.stage_.transform)

				var_111_0.name = "10079ui_story"
				var_111_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_108_1.actors_["10079ui_story"] = var_111_0

				local var_111_1 = var_111_0:GetComponentInChildren(typeof(CharacterEffect))

				var_111_1.enabled = true

				local var_111_2 = GameObjectTools.GetOrAddComponent(var_111_0, typeof(DynamicBoneHelper))

				if var_111_2 then
					var_111_2:EnableDynamicBone(false)
				end

				arg_108_1:ShowWeapon(var_111_1.transform, false)

				arg_108_1.var_["10079ui_story" .. "Animator"] = var_111_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_108_1.var_["10079ui_story" .. "Animator"].applyRootMotion = true
				arg_108_1.var_["10079ui_story" .. "LipSync"] = var_111_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_111_3 = arg_108_1.actors_["10079ui_story"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos10079ui_story = var_111_3.localPosition

				arg_108_1:ShowWeapon(arg_108_1.var_["10079ui_story" .. "Animator"].transform, false)
			end

			local var_111_4 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 then
				var_111_3.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_108_1.time_ - 0) / var_111_4)
				var_111_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_3.position).x, (manager.ui.mainCamera.transform.position - var_111_3.position).y, (manager.ui.mainCamera.transform.position - var_111_3.position).z)
				var_111_3.localEulerAngles.z = 0
				var_111_3.localEulerAngles.x = 0
				var_111_3.localEulerAngles = var_111_3.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 then
				var_111_3.localPosition = Vector3.New(0, -0.95, -6.05)
				var_111_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_3.position).x, (manager.ui.mainCamera.transform.position - var_111_3.position).y, (manager.ui.mainCamera.transform.position - var_111_3.position).z)
				var_111_3.localEulerAngles.z = 0
				var_111_3.localEulerAngles.x = 0
				var_111_3.localEulerAngles = var_111_3.localEulerAngles
			end

			local var_111_5 = arg_108_1.actors_["10079ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_5) and arg_108_1.var_.characterEffect10079ui_story == nil then
				arg_108_1.var_.characterEffect10079ui_story = var_111_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_6 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_6 and not isNil(var_111_5) then
				if arg_108_1.var_.characterEffect10079ui_story and not isNil(var_111_5) then
					arg_108_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_6 and arg_108_1.time_ < 0 + var_111_6 + arg_111_0 and not isNil(var_111_5) and arg_108_1.var_.characterEffect10079ui_story then
				arg_108_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action10_2")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_111_8 = 0
			local var_111_9 = 0.325

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_8 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_10 = arg_108_1:GetWordFromCfg(319681025)
				local var_111_11 = arg_108_1:FormatText(var_111_10.content)

				arg_108_1.text_.text = var_111_11

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_13 = 13 <= 0 and var_111_9 or var_111_9 * (utf8.len(var_111_11) / 13)

				if (13 <= 0 and var_111_9 or var_111_9 * (utf8.len(var_111_11) / 13)) > 0 and var_111_9 < var_111_13 then
					arg_108_1.talkMaxDuration = var_111_13

					if var_111_13 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_13 + var_111_8
					end
				end

				arg_108_1.text_.text = var_111_11
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681025", "story_v_out_319681.awb") ~= 0 then
					local var_111_14 = manager.audio:GetVoiceLength("story_v_out_319681", "319681025", "story_v_out_319681.awb") / 1000

					if var_111_14 + var_111_8 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_14 + var_111_8
					end

					if var_111_10.prefab_name ~= "" and arg_108_1.actors_[var_111_10.prefab_name] ~= nil then
						local var_111_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_10.prefab_name].transform, "story_v_out_319681", "319681025", "story_v_out_319681.awb")

						arg_108_1:RecordAudio("319681025", var_111_15)
						arg_108_1:RecordAudio("319681025", var_111_15)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_319681", "319681025", "story_v_out_319681.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_319681", "319681025", "story_v_out_319681.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_16 = math.max(var_111_9, arg_108_1.talkMaxDuration)

			if var_111_8 <= arg_108_1.time_ and arg_108_1.time_ < var_111_8 + var_111_16 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_8) / var_111_16

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_8 + var_111_16 and arg_108_1.time_ < var_111_8 + var_111_16 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play319681026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 319681026
		arg_112_1.duration_ = 6.63

		local var_112_0 = {
			zh = 5.8,
			ja = 6.633
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
				arg_112_0:Play319681027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0.475

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_1 = arg_112_1:GetWordFromCfg(319681026)
				local var_115_2 = arg_112_1:FormatText(var_115_1.content)

				arg_112_1.text_.text = var_115_2

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_4 = 19 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 19)

				if (19 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 19)) > 0 and var_115_0 < var_115_4 then
					arg_112_1.talkMaxDuration = var_115_4

					if var_115_4 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_4 + 0
					end
				end

				arg_112_1.text_.text = var_115_2
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681026", "story_v_out_319681.awb") ~= 0 then
					local var_115_5 = manager.audio:GetVoiceLength("story_v_out_319681", "319681026", "story_v_out_319681.awb") / 1000

					if var_115_5 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_5 + 0
					end

					if var_115_1.prefab_name ~= "" and arg_112_1.actors_[var_115_1.prefab_name] ~= nil then
						local var_115_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_1.prefab_name].transform, "story_v_out_319681", "319681026", "story_v_out_319681.awb")

						arg_112_1:RecordAudio("319681026", var_115_6)
						arg_112_1:RecordAudio("319681026", var_115_6)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_319681", "319681026", "story_v_out_319681.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_319681", "319681026", "story_v_out_319681.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_7 = math.max(var_115_0, arg_112_1.talkMaxDuration)

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_7 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - 0) / var_115_7

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= 0 + var_115_7 and arg_112_1.time_ < 0 + var_115_7 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play319681027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 319681027
		arg_116_1.duration_ = 3.9

		local var_116_0 = {
			zh = 3.9,
			ja = 3.6
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play319681028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos10079ui_story = arg_116_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_119_0 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 then
				arg_116_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_116_1.time_ - 0) / var_119_0)
				arg_116_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["10079ui_story"].transform.position).z)
				arg_116_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["10079ui_story"].transform.localEulerAngles = arg_116_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 then
				arg_116_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_116_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["10079ui_story"].transform.position).z)
				arg_116_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["10079ui_story"].transform.localEulerAngles = arg_116_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_119_1 = arg_116_1.actors_["10079ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect10079ui_story == nil then
				arg_116_1.var_.characterEffect10079ui_story = var_119_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_2 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_2 and not isNil(var_119_1) then
				if arg_116_1.var_.characterEffect10079ui_story and not isNil(var_119_1) then
					arg_116_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_2 and arg_116_1.time_ < 0 + var_119_2 + arg_119_0 and not isNil(var_119_1) and arg_116_1.var_.characterEffect10079ui_story then
				arg_116_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_119_4 = 0
			local var_119_5 = 0.275

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_6 = arg_116_1:GetWordFromCfg(319681027)
				local var_119_7 = arg_116_1:FormatText(var_119_6.content)

				arg_116_1.text_.text = var_119_7

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_9 = 11 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 11)

				if (11 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 11)) > 0 and var_119_5 < var_119_9 then
					arg_116_1.talkMaxDuration = var_119_9

					if var_119_9 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_4
					end
				end

				arg_116_1.text_.text = var_119_7
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681027", "story_v_out_319681.awb") ~= 0 then
					local var_119_10 = manager.audio:GetVoiceLength("story_v_out_319681", "319681027", "story_v_out_319681.awb") / 1000

					if var_119_10 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_4
					end

					if var_119_6.prefab_name ~= "" and arg_116_1.actors_[var_119_6.prefab_name] ~= nil then
						local var_119_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_6.prefab_name].transform, "story_v_out_319681", "319681027", "story_v_out_319681.awb")

						arg_116_1:RecordAudio("319681027", var_119_11)
						arg_116_1:RecordAudio("319681027", var_119_11)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_319681", "319681027", "story_v_out_319681.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_319681", "319681027", "story_v_out_319681.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_12 = math.max(var_119_5, arg_116_1.talkMaxDuration)

			if var_119_4 <= arg_116_1.time_ and arg_116_1.time_ < var_119_4 + var_119_12 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_4) / var_119_12

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_4 + var_119_12 and arg_116_1.time_ < var_119_4 + var_119_12 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play319681028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 319681028
		arg_120_1.duration_ = 6.57

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play319681029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["10079ui_story"]) and arg_120_1.var_.characterEffect10079ui_story == nil then
				arg_120_1.var_.characterEffect10079ui_story = arg_120_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["10079ui_story"]) then
				if arg_120_1.var_.characterEffect10079ui_story and not isNil(arg_120_1.actors_["10079ui_story"]) then
					arg_120_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_120_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_0)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["10079ui_story"]) and arg_120_1.var_.characterEffect10079ui_story then
				arg_120_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_120_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_123_1 = arg_120_1.actors_["10079ui_story"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos10079ui_story = var_123_1.localPosition
			end

			local var_123_2 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_2 then
				var_123_1.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_120_1.time_ - 0) / var_123_2)
				var_123_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_1.position).x, (manager.ui.mainCamera.transform.position - var_123_1.position).y, (manager.ui.mainCamera.transform.position - var_123_1.position).z)
				var_123_1.localEulerAngles.z = 0
				var_123_1.localEulerAngles.x = 0
				var_123_1.localEulerAngles = var_123_1.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_2 and arg_120_1.time_ < 0 + var_123_2 + arg_123_0 then
				var_123_1.localPosition = Vector3.New(0, 100, 0)
				var_123_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_1.position).x, (manager.ui.mainCamera.transform.position - var_123_1.position).y, (manager.ui.mainCamera.transform.position - var_123_1.position).z)
				var_123_1.localEulerAngles.z = 0
				var_123_1.localEulerAngles.x = 0
				var_123_1.localEulerAngles = var_123_1.localEulerAngles
			end

			local var_123_3 = 0

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_3 + arg_123_0 then
				arg_120_1.mask_.enabled = true
				arg_120_1.mask_.raycastTarget = false

				arg_120_1:SetGaussion(false)
			end

			local var_123_4 = 1.56666666666667

			if var_123_3 <= arg_120_1.time_ and arg_120_1.time_ < var_123_3 + var_123_4 then
				local var_123_5 = Color.New(1, 1, 1)

				var_123_5.a = Mathf.Lerp(1, 0, (arg_120_1.time_ - var_123_3) / var_123_4)
				arg_120_1.mask_.color = var_123_5
			end

			if arg_120_1.time_ >= var_123_3 + var_123_4 and arg_120_1.time_ < var_123_3 + var_123_4 + arg_123_0 then
				local var_123_6 = Color.New(1, 1, 1)

				arg_120_1.mask_.enabled = false
				var_123_6.a = 0
				arg_120_1.mask_.color = var_123_6
			end

			if arg_120_1.frameCnt_ <= 1 then
				arg_120_1.dialog_:SetActive(false)
			end

			local var_123_7 = 1.56666666666667
			local var_123_8 = 1.175

			if 1.56666666666667 < arg_120_1.time_ and arg_120_1.time_ <= var_123_7 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0

				arg_120_1.dialog_:SetActive(true)

				arg_120_1.dialogCg_.alpha = 0

				local var_123_9 = LeanTween.value(arg_120_1.dialog_, 0, 1, 0.3)

				var_123_9:setOnUpdate(LuaHelper.FloatAction(function(arg_124_0)
					arg_120_1.dialogCg_.alpha = arg_124_0
				end))
				var_123_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_120_1.dialog_)
					var_123_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_120_1.duration_ = arg_120_1.duration_ + 0.3

				SetActive(arg_120_1.leftNameGo_, false)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_10 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(319681028).content)

				arg_120_1.text_.text = var_123_10

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_12 = 47 <= 0 and var_123_8 or var_123_8 * (utf8.len(var_123_10) / 47)

				if (47 <= 0 and var_123_8 or var_123_8 * (utf8.len(var_123_10) / 47)) > 0 and var_123_8 < var_123_12 then
					arg_120_1.talkMaxDuration = var_123_12
					var_123_7 = var_123_7 + 0.3

					if var_123_12 + var_123_7 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_12 + var_123_7
					end
				end

				arg_120_1.text_.text = var_123_10
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_13 = var_123_7 + 0.3
			local var_123_14 = math.max(var_123_8, arg_120_1.talkMaxDuration)

			if var_123_7 + 0.3 <= arg_120_1.time_ and arg_120_1.time_ < var_123_13 + var_123_14 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_13) / var_123_14

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_13 + var_123_14 and arg_120_1.time_ < var_123_13 + var_123_14 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play319681029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 319681029
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play319681030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 1.25

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_1 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(319681029).content)

				arg_126_1.text_.text = var_129_1

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_3 = 50 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_1) / 50)

				if (50 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_1) / 50)) > 0 and var_129_0 < var_129_3 then
					arg_126_1.talkMaxDuration = var_129_3

					if var_129_3 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_3 + 0
					end
				end

				arg_126_1.text_.text = var_129_1
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_4 = math.max(var_129_0, arg_126_1.talkMaxDuration)

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_4 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - 0) / var_129_4

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= 0 + var_129_4 and arg_126_1.time_ < 0 + var_129_4 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play319681030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 319681030
		arg_130_1.duration_ = 3.53

		local var_130_0 = {
			zh = 1.9,
			ja = 3.533
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
				arg_130_0:Play319681031(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0.15

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1184")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_1 = arg_130_1:GetWordFromCfg(319681030)
				local var_133_2 = arg_130_1:FormatText(var_133_1.content)

				arg_130_1.text_.text = var_133_2

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_4 = 6 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 6)

				if (6 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_2) / 6)) > 0 and var_133_0 < var_133_4 then
					arg_130_1.talkMaxDuration = var_133_4

					if var_133_4 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_4 + 0
					end
				end

				arg_130_1.text_.text = var_133_2
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681030", "story_v_out_319681.awb") ~= 0 then
					local var_133_5 = manager.audio:GetVoiceLength("story_v_out_319681", "319681030", "story_v_out_319681.awb") / 1000

					if var_133_5 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_5 + 0
					end

					if var_133_1.prefab_name ~= "" and arg_130_1.actors_[var_133_1.prefab_name] ~= nil then
						local var_133_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_1.prefab_name].transform, "story_v_out_319681", "319681030", "story_v_out_319681.awb")

						arg_130_1:RecordAudio("319681030", var_133_6)
						arg_130_1:RecordAudio("319681030", var_133_6)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_319681", "319681030", "story_v_out_319681.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_319681", "319681030", "story_v_out_319681.awb")
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
	Play319681031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 319681031
		arg_134_1.duration_ = 7.81

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play319681032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 2 < arg_134_1.time_ and arg_134_1.time_ <= 2 + arg_137_0 then
				local var_137_0 = arg_134_1.bgs_.STblack

				arg_134_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_137_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_137_1 = var_137_0:GetComponent("SpriteRenderer")

				if var_137_1 and var_137_1.sprite then
					local var_137_2 = 2 * (var_137_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_137_0.transform.localScale = Vector3.New(var_137_2 / var_137_1.sprite.bounds.size.y < var_137_2 * manager.ui.mainCameraCom_.aspect / var_137_1.sprite.bounds.size.x and var_137_2 * manager.ui.mainCameraCom_.aspect / var_137_1.sprite.bounds.size.x or var_137_2 / var_137_1.sprite.bounds.size.y, var_137_2 / var_137_1.sprite.bounds.size.y < var_137_2 * manager.ui.mainCameraCom_.aspect / var_137_1.sprite.bounds.size.x and var_137_2 * manager.ui.mainCameraCom_.aspect / var_137_1.sprite.bounds.size.x or var_137_2 / var_137_1.sprite.bounds.size.y, 0)
				end

				for iter_137_0, iter_137_1 in pairs(arg_134_1.bgs_) do
					if iter_137_0 ~= "STblack" then
						iter_137_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_137_3 = 0

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_3 + arg_137_0 then
				arg_134_1.allBtn_.enabled = false
			end

			if arg_134_1.time_ >= var_137_3 + 0.3 and arg_134_1.time_ < var_137_3 + 0.3 + arg_137_0 then
				arg_134_1.allBtn_.enabled = true
			end

			local var_137_4 = 0

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_4 + arg_137_0 then
				arg_134_1.mask_.enabled = true
				arg_134_1.mask_.raycastTarget = true

				arg_134_1:SetGaussion(false)
			end

			local var_137_5 = 2

			if var_137_4 <= arg_134_1.time_ and arg_134_1.time_ < var_137_4 + var_137_5 then
				local var_137_6 = Color.New(0, 0, 0)

				var_137_6.a = Mathf.Lerp(0, 1, (arg_134_1.time_ - var_137_4) / var_137_5)
				arg_134_1.mask_.color = var_137_6
			end

			if arg_134_1.time_ >= var_137_4 + var_137_5 and arg_134_1.time_ < var_137_4 + var_137_5 + arg_137_0 then
				local var_137_7 = Color.New(0, 0, 0)

				var_137_7.a = 1
				arg_134_1.mask_.color = var_137_7
			end

			local var_137_8 = 2

			if 2 < arg_134_1.time_ and arg_134_1.time_ <= var_137_8 + arg_137_0 then
				arg_134_1.mask_.enabled = true
				arg_134_1.mask_.raycastTarget = true

				arg_134_1:SetGaussion(false)
			end

			local var_137_9 = 1.03333333333333

			if var_137_8 <= arg_134_1.time_ and arg_134_1.time_ < var_137_8 + var_137_9 then
				local var_137_10 = Color.New(0, 0, 0)

				var_137_10.a = Mathf.Lerp(1, 0, (arg_134_1.time_ - var_137_8) / var_137_9)
				arg_134_1.mask_.color = var_137_10
			end

			if arg_134_1.time_ >= var_137_8 + var_137_9 and arg_134_1.time_ < var_137_8 + var_137_9 + arg_137_0 then
				local var_137_11 = Color.New(0, 0, 0)

				arg_134_1.mask_.enabled = false
				var_137_11.a = 0
				arg_134_1.mask_.color = var_137_11
			end

			local var_137_12 = arg_134_1.actors_["10079ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_12) and arg_134_1.var_.characterEffect10079ui_story == nil then
				arg_134_1.var_.characterEffect10079ui_story = var_137_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_13 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_13 and not isNil(var_137_12) then
				if arg_134_1.var_.characterEffect10079ui_story and not isNil(var_137_12) then
					arg_134_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_134_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_13)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_13 and arg_134_1.time_ < 0 + var_137_13 + arg_137_0 and not isNil(var_137_12) and arg_134_1.var_.characterEffect10079ui_story then
				arg_134_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_134_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_137_14 = arg_134_1.actors_["10079ui_story"].transform

			if 2 < arg_134_1.time_ and arg_134_1.time_ <= 2 + arg_137_0 then
				arg_134_1.var_.moveOldPos10079ui_story = var_137_14.localPosition
			end

			local var_137_15 = 0.001

			if 2 <= arg_134_1.time_ and arg_134_1.time_ < 2 + var_137_15 then
				var_137_14.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_134_1.time_ - 2) / var_137_15)
				var_137_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_14.position).x, (manager.ui.mainCamera.transform.position - var_137_14.position).y, (manager.ui.mainCamera.transform.position - var_137_14.position).z)
				var_137_14.localEulerAngles.z = 0
				var_137_14.localEulerAngles.x = 0
				var_137_14.localEulerAngles = var_137_14.localEulerAngles
			end

			if arg_134_1.time_ >= 2 + var_137_15 and arg_134_1.time_ < 2 + var_137_15 + arg_137_0 then
				var_137_14.localPosition = Vector3.New(0, 100, 0)
				var_137_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_14.position).x, (manager.ui.mainCamera.transform.position - var_137_14.position).y, (manager.ui.mainCamera.transform.position - var_137_14.position).z)
				var_137_14.localEulerAngles.z = 0
				var_137_14.localEulerAngles.x = 0
				var_137_14.localEulerAngles = var_137_14.localEulerAngles
			end

			if arg_134_1.frameCnt_ <= 1 then
				arg_134_1.dialog_:SetActive(false)
			end

			local var_137_16 = 2.81311808908358
			local var_137_17 = 0.85

			if 2.81311808908358 < arg_134_1.time_ and arg_134_1.time_ <= var_137_16 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0

				arg_134_1.dialog_:SetActive(true)

				arg_134_1.dialogCg_.alpha = 0

				local var_137_18 = LeanTween.value(arg_134_1.dialog_, 0, 1, 0.3)

				var_137_18:setOnUpdate(LuaHelper.FloatAction(function(arg_138_0)
					arg_134_1.dialogCg_.alpha = arg_138_0
				end))
				var_137_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_134_1.dialog_)
					var_137_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_134_1.duration_ = arg_134_1.duration_ + 0.3

				SetActive(arg_134_1.leftNameGo_, false)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_19 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(319681031).content)

				arg_134_1.text_.text = var_137_19

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_21 = 34 <= 0 and var_137_17 or var_137_17 * (utf8.len(var_137_19) / 34)

				if (34 <= 0 and var_137_17 or var_137_17 * (utf8.len(var_137_19) / 34)) > 0 and var_137_17 < var_137_21 then
					arg_134_1.talkMaxDuration = var_137_21
					var_137_16 = var_137_16 + 0.3

					if var_137_21 + var_137_16 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_21 + var_137_16
					end
				end

				arg_134_1.text_.text = var_137_19
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_22 = var_137_16 + 0.3
			local var_137_23 = math.max(var_137_17, arg_134_1.talkMaxDuration)

			if var_137_16 + 0.3 <= arg_134_1.time_ and arg_134_1.time_ < var_137_22 + var_137_23 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_22) / var_137_23

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_22 + var_137_23 and arg_134_1.time_ < var_137_22 + var_137_23 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play319681032 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 319681032
		arg_140_1.duration_ = 6.47

		local var_140_0 = {
			zh = 4.266,
			ja = 6.466
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play319681033(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0.475

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_1 = arg_140_1:GetWordFromCfg(319681032)
				local var_143_2 = arg_140_1:FormatText(var_143_1.content)

				arg_140_1.text_.text = var_143_2

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_4 = 19 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_2) / 19)

				if (19 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_2) / 19)) > 0 and var_143_0 < var_143_4 then
					arg_140_1.talkMaxDuration = var_143_4

					if var_143_4 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_4 + 0
					end
				end

				arg_140_1.text_.text = var_143_2
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681032", "story_v_out_319681.awb") ~= 0 then
					local var_143_5 = manager.audio:GetVoiceLength("story_v_out_319681", "319681032", "story_v_out_319681.awb") / 1000

					if var_143_5 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + 0
					end

					if var_143_1.prefab_name ~= "" and arg_140_1.actors_[var_143_1.prefab_name] ~= nil then
						local var_143_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_1.prefab_name].transform, "story_v_out_319681", "319681032", "story_v_out_319681.awb")

						arg_140_1:RecordAudio("319681032", var_143_6)
						arg_140_1:RecordAudio("319681032", var_143_6)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_319681", "319681032", "story_v_out_319681.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_319681", "319681032", "story_v_out_319681.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_7 = math.max(var_143_0, arg_140_1.talkMaxDuration)

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_7 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - 0) / var_143_7

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= 0 + var_143_7 and arg_140_1.time_ < 0 + var_143_7 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play319681033 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 319681033
		arg_144_1.duration_ = 3.73

		local var_144_0 = {
			zh = 3.533,
			ja = 3.733
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play319681034(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.4

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_1 = arg_144_1:GetWordFromCfg(319681033)
				local var_147_2 = arg_144_1:FormatText(var_147_1.content)

				arg_144_1.text_.text = var_147_2

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_4 = 16 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 16)

				if (16 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 16)) > 0 and var_147_0 < var_147_4 then
					arg_144_1.talkMaxDuration = var_147_4

					if var_147_4 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_4 + 0
					end
				end

				arg_144_1.text_.text = var_147_2
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681033", "story_v_out_319681.awb") ~= 0 then
					local var_147_5 = manager.audio:GetVoiceLength("story_v_out_319681", "319681033", "story_v_out_319681.awb") / 1000

					if var_147_5 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + 0
					end

					if var_147_1.prefab_name ~= "" and arg_144_1.actors_[var_147_1.prefab_name] ~= nil then
						local var_147_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_1.prefab_name].transform, "story_v_out_319681", "319681033", "story_v_out_319681.awb")

						arg_144_1:RecordAudio("319681033", var_147_6)
						arg_144_1:RecordAudio("319681033", var_147_6)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_319681", "319681033", "story_v_out_319681.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_319681", "319681033", "story_v_out_319681.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_7 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_7 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_7

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_7 and arg_144_1.time_ < 0 + var_147_7 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play319681034 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 319681034
		arg_148_1.duration_ = 3.83

		local var_148_0 = {
			zh = 3.833,
			ja = 3.6
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play319681035(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0.5

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_1 = arg_148_1:GetWordFromCfg(319681034)
				local var_151_2 = arg_148_1:FormatText(var_151_1.content)

				arg_148_1.text_.text = var_151_2

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_4 = 20 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 20)

				if (20 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 20)) > 0 and var_151_0 < var_151_4 then
					arg_148_1.talkMaxDuration = var_151_4

					if var_151_4 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_4 + 0
					end
				end

				arg_148_1.text_.text = var_151_2
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681034", "story_v_out_319681.awb") ~= 0 then
					local var_151_5 = manager.audio:GetVoiceLength("story_v_out_319681", "319681034", "story_v_out_319681.awb") / 1000

					if var_151_5 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + 0
					end

					if var_151_1.prefab_name ~= "" and arg_148_1.actors_[var_151_1.prefab_name] ~= nil then
						local var_151_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_1.prefab_name].transform, "story_v_out_319681", "319681034", "story_v_out_319681.awb")

						arg_148_1:RecordAudio("319681034", var_151_6)
						arg_148_1:RecordAudio("319681034", var_151_6)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_319681", "319681034", "story_v_out_319681.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_319681", "319681034", "story_v_out_319681.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_7 = math.max(var_151_0, arg_148_1.talkMaxDuration)

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_7 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - 0) / var_151_7

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= 0 + var_151_7 and arg_148_1.time_ < 0 + var_151_7 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play319681035 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 319681035
		arg_152_1.duration_ = 4.77

		local var_152_0 = {
			zh = 4.76666666666667,
			ja = 4.508333330352
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
				arg_152_0:Play319681036(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if arg_152_1.bgs_.ST69 == nil then
				local var_155_0 = Object.Instantiate(arg_152_1.paintGo_)

				var_155_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST69")
				var_155_0.name = "ST69"
				var_155_0.transform.parent = arg_152_1.stage_.transform
				var_155_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_152_1.bgs_.ST69 = var_155_0
			end

			if 0.866666666666667 < arg_152_1.time_ and arg_152_1.time_ <= 0.866666666666667 + arg_155_0 then
				local var_155_1 = arg_152_1.bgs_.ST69

				arg_152_1.bgs_.ST69.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_155_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_155_2 = var_155_1:GetComponent("SpriteRenderer")

				if var_155_2 and var_155_2.sprite then
					local var_155_3 = 2 * (var_155_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_155_1.transform.localScale = Vector3.New(var_155_3 / var_155_2.sprite.bounds.size.y < var_155_3 * manager.ui.mainCameraCom_.aspect / var_155_2.sprite.bounds.size.x and var_155_3 * manager.ui.mainCameraCom_.aspect / var_155_2.sprite.bounds.size.x or var_155_3 / var_155_2.sprite.bounds.size.y, var_155_3 / var_155_2.sprite.bounds.size.y < var_155_3 * manager.ui.mainCameraCom_.aspect / var_155_2.sprite.bounds.size.x and var_155_3 * manager.ui.mainCameraCom_.aspect / var_155_2.sprite.bounds.size.x or var_155_3 / var_155_2.sprite.bounds.size.y, 0)
				end

				for iter_155_0, iter_155_1 in pairs(arg_152_1.bgs_) do
					if iter_155_0 ~= "ST69" then
						iter_155_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_155_4 = 0

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1.allBtn_.enabled = false
			end

			if arg_152_1.time_ >= var_155_4 + 0.3 and arg_152_1.time_ < var_155_4 + 0.3 + arg_155_0 then
				arg_152_1.allBtn_.enabled = true
			end

			local var_155_5 = 0

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_5 + arg_155_0 then
				arg_152_1.mask_.enabled = true
				arg_152_1.mask_.raycastTarget = true

				arg_152_1:SetGaussion(false)
			end

			local var_155_6 = 0.866666666666667

			if var_155_5 <= arg_152_1.time_ and arg_152_1.time_ < var_155_5 + var_155_6 then
				local var_155_7 = Color.New(0, 0, 0)

				var_155_7.a = Mathf.Lerp(0, 1, (arg_152_1.time_ - var_155_5) / var_155_6)
				arg_152_1.mask_.color = var_155_7
			end

			if arg_152_1.time_ >= var_155_5 + var_155_6 and arg_152_1.time_ < var_155_5 + var_155_6 + arg_155_0 then
				local var_155_8 = Color.New(0, 0, 0)

				var_155_8.a = 1
				arg_152_1.mask_.color = var_155_8
			end

			local var_155_9 = 0.866666666666667

			if 0.866666666666667 < arg_152_1.time_ and arg_152_1.time_ <= var_155_9 + arg_155_0 then
				arg_152_1.mask_.enabled = true
				arg_152_1.mask_.raycastTarget = true

				arg_152_1:SetGaussion(false)
			end

			local var_155_10 = 1.76666666666667

			if var_155_9 <= arg_152_1.time_ and arg_152_1.time_ < var_155_9 + var_155_10 then
				local var_155_11 = Color.New(0, 0, 0)

				var_155_11.a = Mathf.Lerp(1, 0, (arg_152_1.time_ - var_155_9) / var_155_10)
				arg_152_1.mask_.color = var_155_11
			end

			if arg_152_1.time_ >= var_155_9 + var_155_10 and arg_152_1.time_ < var_155_9 + var_155_10 + arg_155_0 then
				local var_155_12 = Color.New(0, 0, 0)

				arg_152_1.mask_.enabled = false
				var_155_12.a = 0
				arg_152_1.mask_.color = var_155_12
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_155_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_152_1.bgmTxt_.text ~= var_155_15 and arg_152_1.bgmTxt_.text ~= "" then
						if arg_152_1.bgmTxt2_.text ~= "" then
							arg_152_1.bgmTxt_.text = arg_152_1.bgmTxt2_.text
						end

						arg_152_1.bgmTxt2_.text = var_155_15

						arg_152_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_152_1.bgmTxt_.text = var_155_15
						arg_152_1.bgmTxt2_.text = var_155_15
					end

					if arg_152_1.bgmTimer then
						arg_152_1.bgmTimer:Stop()

						arg_152_1.bgmTimer = nil
					end

					if arg_152_1.settingData.show_music_name == 1 then
						arg_152_1.musicController:SetSelectedState("show")
						arg_152_1.musicAnimator_:Play("open", 0, 0)

						if arg_152_1.settingData.music_time ~= 0 then
							arg_152_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_152_1.settingData.music_time), function()
								if arg_152_1 == nil or isNil(arg_152_1.bgmTxt_) then
									return
								end

								arg_152_1.musicController:SetSelectedState("hide")
								arg_152_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_155_16 = arg_152_1.actors_["10079ui_story"].transform

			if 2.5083333303531 < arg_152_1.time_ and arg_152_1.time_ <= 2.5083333303531 + arg_155_0 then
				arg_152_1.var_.moveOldPos10079ui_story = var_155_16.localPosition
			end

			local var_155_17 = 0.001

			if 2.5083333303531 <= arg_152_1.time_ and arg_152_1.time_ < 2.5083333303531 + var_155_17 then
				var_155_16.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_152_1.time_ - 2.5083333303531) / var_155_17)
				var_155_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_16.position).x, (manager.ui.mainCamera.transform.position - var_155_16.position).y, (manager.ui.mainCamera.transform.position - var_155_16.position).z)
				var_155_16.localEulerAngles.z = 0
				var_155_16.localEulerAngles.x = 0
				var_155_16.localEulerAngles = var_155_16.localEulerAngles
			end

			if arg_152_1.time_ >= 2.5083333303531 + var_155_17 and arg_152_1.time_ < 2.5083333303531 + var_155_17 + arg_155_0 then
				var_155_16.localPosition = Vector3.New(0, -0.95, -6.05)
				var_155_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_16.position).x, (manager.ui.mainCamera.transform.position - var_155_16.position).y, (manager.ui.mainCamera.transform.position - var_155_16.position).z)
				var_155_16.localEulerAngles.z = 0
				var_155_16.localEulerAngles.x = 0
				var_155_16.localEulerAngles = var_155_16.localEulerAngles
			end

			local var_155_18 = arg_152_1.actors_["10079ui_story"]

			if 2.5083333303531 < arg_152_1.time_ and arg_152_1.time_ <= 2.5083333303531 + arg_155_0 and not isNil(var_155_18) and arg_152_1.var_.characterEffect10079ui_story == nil then
				arg_152_1.var_.characterEffect10079ui_story = var_155_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_19 = 0.200000002980232

			if 2.5083333303531 <= arg_152_1.time_ and arg_152_1.time_ < 2.5083333303531 + var_155_19 and not isNil(var_155_18) then
				if arg_152_1.var_.characterEffect10079ui_story and not isNil(var_155_18) then
					arg_152_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 2.5083333303531 + var_155_19 and arg_152_1.time_ < 2.5083333303531 + var_155_19 + arg_155_0 and not isNil(var_155_18) and arg_152_1.var_.characterEffect10079ui_story then
				arg_152_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 2.5083333303531 < arg_152_1.time_ and arg_152_1.time_ <= 2.5083333303531 + arg_155_0 then
				arg_152_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			if 2.5083333303531 < arg_152_1.time_ and arg_152_1.time_ <= 2.5083333303531 + arg_155_0 then
				arg_152_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if arg_152_1.frameCnt_ <= 1 then
				arg_152_1.dialog_:SetActive(false)
			end

			local var_155_21 = 2.86666666666667
			local var_155_22 = 0.075

			if 2.86666666666667 < arg_152_1.time_ and arg_152_1.time_ <= var_155_21 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0

				arg_152_1.dialog_:SetActive(true)

				arg_152_1.dialogCg_.alpha = 0

				local var_155_23 = LeanTween.value(arg_152_1.dialog_, 0, 1, 0.3)

				var_155_23:setOnUpdate(LuaHelper.FloatAction(function(arg_157_0)
					arg_152_1.dialogCg_.alpha = arg_157_0
				end))
				var_155_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_152_1.dialog_)
					var_155_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_152_1.duration_ = arg_152_1.duration_ + 0.3

				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_24 = arg_152_1:GetWordFromCfg(319681035)
				local var_155_25 = arg_152_1:FormatText(var_155_24.content)

				arg_152_1.text_.text = var_155_25

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_27 = 3 <= 0 and var_155_22 or var_155_22 * (utf8.len(var_155_25) / 3)

				if (3 <= 0 and var_155_22 or var_155_22 * (utf8.len(var_155_25) / 3)) > 0 and var_155_22 < var_155_27 then
					arg_152_1.talkMaxDuration = var_155_27
					var_155_21 = var_155_21 + 0.3

					if var_155_27 + var_155_21 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_27 + var_155_21
					end
				end

				arg_152_1.text_.text = var_155_25
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681035", "story_v_out_319681.awb") ~= 0 then
					local var_155_28 = manager.audio:GetVoiceLength("story_v_out_319681", "319681035", "story_v_out_319681.awb") / 1000

					if var_155_28 + var_155_21 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_28 + var_155_21
					end

					if var_155_24.prefab_name ~= "" and arg_152_1.actors_[var_155_24.prefab_name] ~= nil then
						local var_155_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_24.prefab_name].transform, "story_v_out_319681", "319681035", "story_v_out_319681.awb")

						arg_152_1:RecordAudio("319681035", var_155_29)
						arg_152_1:RecordAudio("319681035", var_155_29)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_319681", "319681035", "story_v_out_319681.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_319681", "319681035", "story_v_out_319681.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_30 = var_155_21 + 0.3
			local var_155_31 = math.max(var_155_22, arg_152_1.talkMaxDuration)

			if var_155_21 + 0.3 <= arg_152_1.time_ and arg_152_1.time_ < var_155_30 + var_155_31 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_30) / var_155_31

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_30 + var_155_31 and arg_152_1.time_ < var_155_30 + var_155_31 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2.5083333303531,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play319681036 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 319681036
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play319681037(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_162_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_159_1.bgmTxt_.text ~= var_162_2 and arg_159_1.bgmTxt_.text ~= "" then
						if arg_159_1.bgmTxt2_.text ~= "" then
							arg_159_1.bgmTxt_.text = arg_159_1.bgmTxt2_.text
						end

						arg_159_1.bgmTxt2_.text = var_162_2

						arg_159_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_159_1.bgmTxt_.text = var_162_2
						arg_159_1.bgmTxt2_.text = var_162_2
					end

					if arg_159_1.bgmTimer then
						arg_159_1.bgmTimer:Stop()

						arg_159_1.bgmTimer = nil
					end

					if arg_159_1.settingData.show_music_name == 1 then
						arg_159_1.musicController:SetSelectedState("show")
						arg_159_1.musicAnimator_:Play("open", 0, 0)

						if arg_159_1.settingData.music_time ~= 0 then
							arg_159_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_159_1.settingData.music_time), function()
								if arg_159_1 == nil or isNil(arg_159_1.bgmTxt_) then
									return
								end

								arg_159_1.musicController:SetSelectedState("hide")
								arg_159_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.233333333333333 < arg_159_1.time_ and arg_159_1.time_ <= 0.233333333333333 + arg_162_0 then
				arg_159_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_162_5 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_159_1.bgmTxt_.text ~= var_162_5 and arg_159_1.bgmTxt_.text ~= "" then
						if arg_159_1.bgmTxt2_.text ~= "" then
							arg_159_1.bgmTxt_.text = arg_159_1.bgmTxt2_.text
						end

						arg_159_1.bgmTxt2_.text = var_162_5

						arg_159_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_159_1.bgmTxt_.text = var_162_5
						arg_159_1.bgmTxt2_.text = var_162_5
					end

					if arg_159_1.bgmTimer then
						arg_159_1.bgmTimer:Stop()

						arg_159_1.bgmTimer = nil
					end

					if arg_159_1.settingData.show_music_name == 1 then
						arg_159_1.musicController:SetSelectedState("show")
						arg_159_1.musicAnimator_:Play("open", 0, 0)

						if arg_159_1.settingData.music_time ~= 0 then
							arg_159_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_159_1.settingData.music_time), function()
								if arg_159_1 == nil or isNil(arg_159_1.bgmTxt_) then
									return
								end

								arg_159_1.musicController:SetSelectedState("hide")
								arg_159_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_162_6 = arg_159_1.actors_["10079ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_6) and arg_159_1.var_.characterEffect10079ui_story == nil then
				arg_159_1.var_.characterEffect10079ui_story = var_162_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_7 = 0.208333333333334

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 and not isNil(var_162_6) then
				if arg_159_1.var_.characterEffect10079ui_story and not isNil(var_162_6) then
					arg_159_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_7)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 and not isNil(var_162_6) and arg_159_1.var_.characterEffect10079ui_story then
				arg_159_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_162_8 = 0
			local var_162_9 = 1

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_10 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(319681036).content)

				arg_159_1.text_.text = var_162_10

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_12 = 40 <= 0 and var_162_9 or var_162_9 * (utf8.len(var_162_10) / 40)

				if (40 <= 0 and var_162_9 or var_162_9 * (utf8.len(var_162_10) / 40)) > 0 and var_162_9 < var_162_12 then
					arg_159_1.talkMaxDuration = var_162_12

					if var_162_12 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_12 + var_162_8
					end
				end

				arg_159_1.text_.text = var_162_10
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_13 = math.max(var_162_9, arg_159_1.talkMaxDuration)

			if var_162_8 <= arg_159_1.time_ and arg_159_1.time_ < var_162_8 + var_162_13 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_8) / var_162_13

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_8 + var_162_13 and arg_159_1.time_ < var_162_8 + var_162_13 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play319681037 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 319681037
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play319681038(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 1.3

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(319681037).content)

				arg_165_1.text_.text = var_168_1

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_3 = 52 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 52)

				if (52 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 52)) > 0 and var_168_0 < var_168_3 then
					arg_165_1.talkMaxDuration = var_168_3

					if var_168_3 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_3 + 0
					end
				end

				arg_165_1.text_.text = var_168_1
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_4 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_4

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play319681038 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 319681038
		arg_169_1.duration_ = 2.57

		local var_169_0 = {
			zh = 1.999999999999,
			ja = 2.566
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play319681039(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10079ui_story = arg_169_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10079ui_story"].transform.position).z)
				arg_169_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10079ui_story"].transform.localEulerAngles = arg_169_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_169_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10079ui_story"].transform.position).z)
				arg_169_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10079ui_story"].transform.localEulerAngles = arg_169_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["10079ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect10079ui_story == nil then
				arg_169_1.var_.characterEffect10079ui_story = var_172_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_2 and not isNil(var_172_1) then
				if arg_169_1.var_.characterEffect10079ui_story and not isNil(var_172_1) then
					arg_169_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= 0 + var_172_2 and arg_169_1.time_ < 0 + var_172_2 + arg_172_0 and not isNil(var_172_1) and arg_169_1.var_.characterEffect10079ui_story then
				arg_169_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_172_4 = 0
			local var_172_5 = 0.1

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_6 = arg_169_1:GetWordFromCfg(319681038)
				local var_172_7 = arg_169_1:FormatText(var_172_6.content)

				arg_169_1.text_.text = var_172_7

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_9 = 4 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 4)

				if (4 <= 0 and var_172_5 or var_172_5 * (utf8.len(var_172_7) / 4)) > 0 and var_172_5 < var_172_9 then
					arg_169_1.talkMaxDuration = var_172_9

					if var_172_9 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_9 + var_172_4
					end
				end

				arg_169_1.text_.text = var_172_7
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681038", "story_v_out_319681.awb") ~= 0 then
					local var_172_10 = manager.audio:GetVoiceLength("story_v_out_319681", "319681038", "story_v_out_319681.awb") / 1000

					if var_172_10 + var_172_4 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_10 + var_172_4
					end

					if var_172_6.prefab_name ~= "" and arg_169_1.actors_[var_172_6.prefab_name] ~= nil then
						local var_172_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_6.prefab_name].transform, "story_v_out_319681", "319681038", "story_v_out_319681.awb")

						arg_169_1:RecordAudio("319681038", var_172_11)
						arg_169_1:RecordAudio("319681038", var_172_11)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_319681", "319681038", "story_v_out_319681.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_319681", "319681038", "story_v_out_319681.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_5, arg_169_1.talkMaxDuration)

			if var_172_4 <= arg_169_1.time_ and arg_169_1.time_ < var_172_4 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_4) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_4 + var_172_12 and arg_169_1.time_ < var_172_4 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play319681039 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 319681039
		arg_173_1.duration_ = 3.77

		local var_173_0 = {
			zh = 3.766,
			ja = 2.5
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play319681040(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if arg_173_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_176_0 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_173_1.stage_.transform)

				var_176_0.name = "1095ui_story"
				var_176_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_173_1.actors_["1095ui_story"] = var_176_0

				local var_176_1 = var_176_0:GetComponentInChildren(typeof(CharacterEffect))

				var_176_1.enabled = true

				local var_176_2 = GameObjectTools.GetOrAddComponent(var_176_0, typeof(DynamicBoneHelper))

				if var_176_2 then
					var_176_2:EnableDynamicBone(false)
				end

				arg_173_1:ShowWeapon(var_176_1.transform, false)

				arg_173_1.var_["1095ui_story" .. "Animator"] = var_176_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_173_1.var_["1095ui_story" .. "Animator"].applyRootMotion = true
				arg_173_1.var_["1095ui_story" .. "LipSync"] = var_176_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_176_3 = arg_173_1.actors_["1095ui_story"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1095ui_story = var_176_3.localPosition
			end

			local var_176_4 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 then
				var_176_3.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_173_1.time_ - 0) / var_176_4)
				var_176_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_3.position).x, (manager.ui.mainCamera.transform.position - var_176_3.position).y, (manager.ui.mainCamera.transform.position - var_176_3.position).z)
				var_176_3.localEulerAngles.z = 0
				var_176_3.localEulerAngles.x = 0
				var_176_3.localEulerAngles = var_176_3.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 then
				var_176_3.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_176_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_3.position).x, (manager.ui.mainCamera.transform.position - var_176_3.position).y, (manager.ui.mainCamera.transform.position - var_176_3.position).z)
				var_176_3.localEulerAngles.z = 0
				var_176_3.localEulerAngles.x = 0
				var_176_3.localEulerAngles = var_176_3.localEulerAngles
			end

			local var_176_5 = arg_173_1.actors_["1095ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_5) and arg_173_1.var_.characterEffect1095ui_story == nil then
				arg_173_1.var_.characterEffect1095ui_story = var_176_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_6 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_6 and not isNil(var_176_5) then
				if arg_173_1.var_.characterEffect1095ui_story and not isNil(var_176_5) then
					arg_173_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_6 and arg_173_1.time_ < 0 + var_176_6 + arg_176_0 and not isNil(var_176_5) and arg_173_1.var_.characterEffect1095ui_story then
				arg_173_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_176_8 = arg_173_1.actors_["10079ui_story"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10079ui_story = var_176_8.localPosition
			end

			local var_176_9 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_9 then
				var_176_8.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_173_1.time_ - 0) / var_176_9)
				var_176_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_8.position).x, (manager.ui.mainCamera.transform.position - var_176_8.position).y, (manager.ui.mainCamera.transform.position - var_176_8.position).z)
				var_176_8.localEulerAngles.z = 0
				var_176_8.localEulerAngles.x = 0
				var_176_8.localEulerAngles = var_176_8.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_9 and arg_173_1.time_ < 0 + var_176_9 + arg_176_0 then
				var_176_8.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_176_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_8.position).x, (manager.ui.mainCamera.transform.position - var_176_8.position).y, (manager.ui.mainCamera.transform.position - var_176_8.position).z)
				var_176_8.localEulerAngles.z = 0
				var_176_8.localEulerAngles.x = 0
				var_176_8.localEulerAngles = var_176_8.localEulerAngles
			end

			local var_176_10 = arg_173_1.actors_["10079ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_10) and arg_173_1.var_.characterEffect10079ui_story == nil then
				arg_173_1.var_.characterEffect10079ui_story = var_176_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_11 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_11 and not isNil(var_176_10) then
				if arg_173_1.var_.characterEffect10079ui_story and not isNil(var_176_10) then
					arg_173_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_11)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_11 and arg_173_1.time_ < 0 + var_176_11 + arg_176_0 and not isNil(var_176_10) and arg_173_1.var_.characterEffect10079ui_story then
				arg_173_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_176_12 = 0
			local var_176_13 = 0.35

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_12 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_14 = arg_173_1:GetWordFromCfg(319681039)
				local var_176_15 = arg_173_1:FormatText(var_176_14.content)

				arg_173_1.text_.text = var_176_15

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_17 = 14 <= 0 and var_176_13 or var_176_13 * (utf8.len(var_176_15) / 14)

				if (14 <= 0 and var_176_13 or var_176_13 * (utf8.len(var_176_15) / 14)) > 0 and var_176_13 < var_176_17 then
					arg_173_1.talkMaxDuration = var_176_17

					if var_176_17 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_17 + var_176_12
					end
				end

				arg_173_1.text_.text = var_176_15
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681039", "story_v_out_319681.awb") ~= 0 then
					local var_176_18 = manager.audio:GetVoiceLength("story_v_out_319681", "319681039", "story_v_out_319681.awb") / 1000

					if var_176_18 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_18 + var_176_12
					end

					if var_176_14.prefab_name ~= "" and arg_173_1.actors_[var_176_14.prefab_name] ~= nil then
						local var_176_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_14.prefab_name].transform, "story_v_out_319681", "319681039", "story_v_out_319681.awb")

						arg_173_1:RecordAudio("319681039", var_176_19)
						arg_173_1:RecordAudio("319681039", var_176_19)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_319681", "319681039", "story_v_out_319681.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_319681", "319681039", "story_v_out_319681.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_20 = math.max(var_176_13, arg_173_1.talkMaxDuration)

			if var_176_12 <= arg_173_1.time_ and arg_173_1.time_ < var_176_12 + var_176_20 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_12) / var_176_20

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_12 + var_176_20 and arg_173_1.time_ < var_176_12 + var_176_20 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play319681040 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 319681040
		arg_177_1.duration_ = 7.4

		local var_177_0 = {
			zh = 4.2,
			ja = 7.4
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play319681041(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1095ui_story"]) and arg_177_1.var_.characterEffect1095ui_story == nil then
				arg_177_1.var_.characterEffect1095ui_story = arg_177_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1095ui_story"]) then
				if arg_177_1.var_.characterEffect1095ui_story and not isNil(arg_177_1.actors_["1095ui_story"]) then
					arg_177_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_0)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1095ui_story"]) and arg_177_1.var_.characterEffect1095ui_story then
				arg_177_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4313")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_180_1 = arg_177_1.actors_["10079ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect10079ui_story == nil then
				arg_177_1.var_.characterEffect10079ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect10079ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect10079ui_story then
				arg_177_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_180_4 = 0
			local var_180_5 = 0.375

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(319681040)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 15 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 15)

				if (15 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 15)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681040", "story_v_out_319681.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_out_319681", "319681040", "story_v_out_319681.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_out_319681", "319681040", "story_v_out_319681.awb")

						arg_177_1:RecordAudio("319681040", var_180_11)
						arg_177_1:RecordAudio("319681040", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_319681", "319681040", "story_v_out_319681.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_319681", "319681040", "story_v_out_319681.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_12 = math.max(var_180_5, arg_177_1.talkMaxDuration)

			if var_180_4 <= arg_177_1.time_ and arg_177_1.time_ < var_180_4 + var_180_12 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_4) / var_180_12

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_4 + var_180_12 and arg_177_1.time_ < var_180_4 + var_180_12 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play319681041 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 319681041
		arg_181_1.duration_ = 8.87

		local var_181_0 = {
			zh = 5.733,
			ja = 8.866
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
				arg_181_0:Play319681042(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1095ui_story"]) and arg_181_1.var_.characterEffect1095ui_story == nil then
				arg_181_1.var_.characterEffect1095ui_story = arg_181_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1095ui_story"]) then
				if arg_181_1.var_.characterEffect1095ui_story and not isNil(arg_181_1.actors_["1095ui_story"]) then
					arg_181_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1095ui_story"]) and arg_181_1.var_.characterEffect1095ui_story then
				arg_181_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_184_2 = arg_181_1.actors_["10079ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.characterEffect10079ui_story == nil then
				arg_181_1.var_.characterEffect10079ui_story = var_184_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_3 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_3 and not isNil(var_184_2) then
				if arg_181_1.var_.characterEffect10079ui_story and not isNil(var_184_2) then
					arg_181_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_181_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_3)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_3 and arg_181_1.time_ < 0 + var_184_3 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.characterEffect10079ui_story then
				arg_181_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_181_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_184_4 = 0
			local var_184_5 = 0.725

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_6 = arg_181_1:GetWordFromCfg(319681041)
				local var_184_7 = arg_181_1:FormatText(var_184_6.content)

				arg_181_1.text_.text = var_184_7

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_9 = 29 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 29)

				if (29 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_7) / 29)) > 0 and var_184_5 < var_184_9 then
					arg_181_1.talkMaxDuration = var_184_9

					if var_184_9 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_9 + var_184_4
					end
				end

				arg_181_1.text_.text = var_184_7
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681041", "story_v_out_319681.awb") ~= 0 then
					local var_184_10 = manager.audio:GetVoiceLength("story_v_out_319681", "319681041", "story_v_out_319681.awb") / 1000

					if var_184_10 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_4
					end

					if var_184_6.prefab_name ~= "" and arg_181_1.actors_[var_184_6.prefab_name] ~= nil then
						local var_184_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_6.prefab_name].transform, "story_v_out_319681", "319681041", "story_v_out_319681.awb")

						arg_181_1:RecordAudio("319681041", var_184_11)
						arg_181_1:RecordAudio("319681041", var_184_11)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_319681", "319681041", "story_v_out_319681.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_319681", "319681041", "story_v_out_319681.awb")
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

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play319681042 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 319681042
		arg_185_1.duration_ = 5.5

		local var_185_0 = {
			zh = 2.2,
			ja = 5.5
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
				arg_185_0:Play319681043(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.25

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:GetWordFromCfg(319681042)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 10 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 10)

				if (10 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 10)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681042", "story_v_out_319681.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_319681", "319681042", "story_v_out_319681.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_319681", "319681042", "story_v_out_319681.awb")

						arg_185_1:RecordAudio("319681042", var_188_6)
						arg_185_1:RecordAudio("319681042", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_319681", "319681042", "story_v_out_319681.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_319681", "319681042", "story_v_out_319681.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play319681043 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 319681043
		arg_189_1.duration_ = 4.27

		local var_189_0 = {
			zh = 4.266,
			ja = 2.533
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play319681044(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10079ui_story = arg_189_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["10079ui_story"].transform.position).z)
				arg_189_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["10079ui_story"].transform.localEulerAngles = arg_189_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_189_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["10079ui_story"].transform.position).z)
				arg_189_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["10079ui_story"].transform.localEulerAngles = arg_189_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_192_1 = arg_189_1.actors_["10079ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect10079ui_story == nil then
				arg_189_1.var_.characterEffect10079ui_story = var_192_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_2 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_2 and not isNil(var_192_1) then
				if arg_189_1.var_.characterEffect10079ui_story and not isNil(var_192_1) then
					arg_189_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_189_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_2)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_2 and arg_189_1.time_ < 0 + var_192_2 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.characterEffect10079ui_story then
				arg_189_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_189_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_192_3 = arg_189_1.actors_["1095ui_story"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1095ui_story = var_192_3.localPosition
			end

			local var_192_4 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				var_192_3.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 0) / var_192_4)
				var_192_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_3.position).x, (manager.ui.mainCamera.transform.position - var_192_3.position).y, (manager.ui.mainCamera.transform.position - var_192_3.position).z)
				var_192_3.localEulerAngles.z = 0
				var_192_3.localEulerAngles.x = 0
				var_192_3.localEulerAngles = var_192_3.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				var_192_3.localPosition = Vector3.New(0, 100, 0)
				var_192_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_3.position).x, (manager.ui.mainCamera.transform.position - var_192_3.position).y, (manager.ui.mainCamera.transform.position - var_192_3.position).z)
				var_192_3.localEulerAngles.z = 0
				var_192_3.localEulerAngles.x = 0
				var_192_3.localEulerAngles = var_192_3.localEulerAngles
			end

			local var_192_5 = arg_189_1.actors_["1095ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.characterEffect1095ui_story == nil then
				arg_189_1.var_.characterEffect1095ui_story = var_192_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_6 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_6 and not isNil(var_192_5) then
				if arg_189_1.var_.characterEffect1095ui_story and not isNil(var_192_5) then
					arg_189_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_6)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_6 and arg_189_1.time_ < 0 + var_192_6 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.characterEffect1095ui_story then
				arg_189_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_192_7 = 0
			local var_192_8 = 0.575

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_7 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[722].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_9 = arg_189_1:GetWordFromCfg(319681043)
				local var_192_10 = arg_189_1:FormatText(var_192_9.content)

				arg_189_1.text_.text = var_192_10

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_12 = 23 <= 0 and var_192_8 or var_192_8 * (utf8.len(var_192_10) / 23)

				if (23 <= 0 and var_192_8 or var_192_8 * (utf8.len(var_192_10) / 23)) > 0 and var_192_8 < var_192_12 then
					arg_189_1.talkMaxDuration = var_192_12

					if var_192_12 + var_192_7 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_12 + var_192_7
					end
				end

				arg_189_1.text_.text = var_192_10
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681043", "story_v_out_319681.awb") ~= 0 then
					local var_192_13 = manager.audio:GetVoiceLength("story_v_out_319681", "319681043", "story_v_out_319681.awb") / 1000

					if var_192_13 + var_192_7 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_13 + var_192_7
					end

					if var_192_9.prefab_name ~= "" and arg_189_1.actors_[var_192_9.prefab_name] ~= nil then
						local var_192_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_9.prefab_name].transform, "story_v_out_319681", "319681043", "story_v_out_319681.awb")

						arg_189_1:RecordAudio("319681043", var_192_14)
						arg_189_1:RecordAudio("319681043", var_192_14)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_319681", "319681043", "story_v_out_319681.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_319681", "319681043", "story_v_out_319681.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_15 = math.max(var_192_8, arg_189_1.talkMaxDuration)

			if var_192_7 <= arg_189_1.time_ and arg_189_1.time_ < var_192_7 + var_192_15 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_7) / var_192_15

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_7 + var_192_15 and arg_189_1.time_ < var_192_7 + var_192_15 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play319681044 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 319681044
		arg_193_1.duration_ = 2

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play319681045(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos10079ui_story = arg_193_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10079ui_story"].transform.position).z)
				arg_193_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["10079ui_story"].transform.localEulerAngles = arg_193_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_193_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10079ui_story"].transform.position).z)
				arg_193_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["10079ui_story"].transform.localEulerAngles = arg_193_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["10079ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect10079ui_story == nil then
				arg_193_1.var_.characterEffect10079ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect10079ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect10079ui_story then
				arg_193_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_196_4 = 0
			local var_196_5 = 0.075

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:GetWordFromCfg(319681044)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 3 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 3)

				if (3 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 3)) > 0 and var_196_5 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681044", "story_v_out_319681.awb") ~= 0 then
					local var_196_10 = manager.audio:GetVoiceLength("story_v_out_319681", "319681044", "story_v_out_319681.awb") / 1000

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end

					if var_196_6.prefab_name ~= "" and arg_193_1.actors_[var_196_6.prefab_name] ~= nil then
						local var_196_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_6.prefab_name].transform, "story_v_out_319681", "319681044", "story_v_out_319681.awb")

						arg_193_1:RecordAudio("319681044", var_196_11)
						arg_193_1:RecordAudio("319681044", var_196_11)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_319681", "319681044", "story_v_out_319681.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_319681", "319681044", "story_v_out_319681.awb")
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
				actorName = "10079ui_story",
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
	Play319681045 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 319681045
		arg_197_1.duration_ = 2

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play319681046(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["10079ui_story"]) and arg_197_1.var_.characterEffect10079ui_story == nil then
				arg_197_1.var_.characterEffect10079ui_story = arg_197_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["10079ui_story"]) then
				if arg_197_1.var_.characterEffect10079ui_story and not isNil(arg_197_1.actors_["10079ui_story"]) then
					arg_197_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_197_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_0)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["10079ui_story"]) and arg_197_1.var_.characterEffect10079ui_story then
				arg_197_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_197_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_200_1 = arg_197_1.actors_["10079ui_story"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos10079ui_story = var_200_1.localPosition
			end

			local var_200_2 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 then
				var_200_1.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_197_1.time_ - 0) / var_200_2)
				var_200_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_1.position).x, (manager.ui.mainCamera.transform.position - var_200_1.position).y, (manager.ui.mainCamera.transform.position - var_200_1.position).z)
				var_200_1.localEulerAngles.z = 0
				var_200_1.localEulerAngles.x = 0
				var_200_1.localEulerAngles = var_200_1.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 then
				var_200_1.localPosition = Vector3.New(0, 100, 0)
				var_200_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_200_1.position).x, (manager.ui.mainCamera.transform.position - var_200_1.position).y, (manager.ui.mainCamera.transform.position - var_200_1.position).z)
				var_200_1.localEulerAngles.z = 0
				var_200_1.localEulerAngles.x = 0
				var_200_1.localEulerAngles = var_200_1.localEulerAngles
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				local var_200_3 = arg_197_1.fswbg_.transform:Find("textbox/adapt/content") or arg_197_1.fswbg_.transform:Find("textbox/content")
				local var_200_4 = arg_197_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_200_5 = var_200_3:GetComponent("RectTransform")

				var_200_3:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_200_5.offsetMin = Vector2.New(0, 0)
				var_200_5.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.fswbg_:SetActive(true)
				arg_197_1.dialog_:SetActive(false)

				arg_197_1.fswtw_.percent = 0
				arg_197_1.fswt_.text = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(319681045).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.fswt_)

				arg_197_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_197_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_197_1.fswtw_:SetDirty()

				arg_197_1.typewritterCharCountI18N = 0

				SetActive(arg_197_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_197_1:ShowNextGo(false)
			end

			local var_200_6 = 0.533333333333333

			if 0.533333333333333 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.var_.oldValueTypewriter = arg_197_1.fswtw_.percent

				SetActive(arg_197_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_197_1:ShowNextGo(false)
			end

			local var_200_7 = 3
			local var_200_8 = 0.3
			local var_200_9, var_200_10 = arg_197_1:GetPercentByPara(arg_197_1:FormatText(arg_197_1:GetWordFromCfg(319681045).content), 1)

			if var_200_6 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0

				local var_200_11 = var_200_7 <= 0 and var_200_8 or var_200_8 * ((var_200_10 - arg_197_1.typewritterCharCountI18N) / var_200_7)

				if (var_200_7 <= 0 and var_200_8 or var_200_8 * ((var_200_10 - arg_197_1.typewritterCharCountI18N) / var_200_7)) > 0 and var_200_8 < var_200_11 then
					arg_197_1.talkMaxDuration = var_200_11

					if var_200_11 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_11 + var_200_6
					end
				end
			end

			local var_200_12 = math.max(0.3, arg_197_1.talkMaxDuration)

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_12 then
				arg_197_1.fswtw_.percent = Mathf.Lerp(arg_197_1.var_.oldValueTypewriter, var_200_9, (arg_197_1.time_ - var_200_6) / var_200_12)
				arg_197_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_197_1.fswtw_:SetDirty()
			end

			if arg_197_1.time_ >= var_200_6 + var_200_12 and arg_197_1.time_ < var_200_6 + var_200_12 + arg_200_0 then
				arg_197_1.fswtw_.percent = var_200_9

				arg_197_1.fswtw_:SetDirty()
				arg_197_1:ShowNextGo(true)

				arg_197_1.typewritterCharCountI18N = var_200_10
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				local var_200_13 = arg_197_1.bgs_.STblack

				arg_197_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_200_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_200_14 = var_200_13:GetComponent("SpriteRenderer")

				if var_200_14 and var_200_14.sprite then
					local var_200_15 = 2 * (var_200_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_200_13.transform.localScale = Vector3.New(var_200_15 / var_200_14.sprite.bounds.size.y < var_200_15 * manager.ui.mainCameraCom_.aspect / var_200_14.sprite.bounds.size.x and var_200_15 * manager.ui.mainCameraCom_.aspect / var_200_14.sprite.bounds.size.x or var_200_15 / var_200_14.sprite.bounds.size.y, var_200_15 / var_200_14.sprite.bounds.size.y < var_200_15 * manager.ui.mainCameraCom_.aspect / var_200_14.sprite.bounds.size.x and var_200_15 * manager.ui.mainCameraCom_.aspect / var_200_14.sprite.bounds.size.x or var_200_15 / var_200_14.sprite.bounds.size.y, 0)
				end

				for iter_200_0, iter_200_1 in pairs(arg_197_1.bgs_) do
					if iter_200_0 ~= "STblack" then
						iter_200_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_200_16 = 0.533333333333333
			local var_200_17 = manager.audio:GetVoiceLength("story_v_out_319681", "319681045", "story_v_out_319681.awb") / 1000

			if var_200_17 > 0 and 1 < var_200_17 and var_200_17 + var_200_16 > arg_197_1.duration_ then
				arg_197_1.duration_ = var_200_17 + var_200_16
			end

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 then
				arg_197_1:AudioAction("play", "voice", "story_v_out_319681", "319681045", "story_v_out_319681.awb")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.cswbg_:SetActive(true)

				local var_200_19 = arg_197_1.cswt_:GetComponent("RectTransform")

				arg_197_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_200_19.offsetMin = Vector2.New(410, 330)
				var_200_19.offsetMax = Vector2.New(-400, -175)
				arg_197_1.cswt_.text = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(419045).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.cswt_)

				arg_197_1.cswt_.fontSize = 180
				arg_197_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_197_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_197_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play319681046 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 319681046
		arg_201_1.duration_ = 1.03

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play319681047(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.fswbg_:SetActive(true)
				arg_201_1.dialog_:SetActive(false)

				arg_201_1.fswtw_.percent = 0
				arg_201_1.fswt_.text = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(319681046).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.fswt_)

				arg_201_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_201_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_201_1.fswtw_:SetDirty()

				arg_201_1.typewritterCharCountI18N = 0

				SetActive(arg_201_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_201_1:ShowNextGo(false)
			end

			local var_204_0 = 0.0333333333333333

			if 0.0333333333333333 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.var_.oldValueTypewriter = arg_201_1.fswtw_.percent

				SetActive(arg_201_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_201_1:ShowNextGo(false)
			end

			local var_204_1 = 5
			local var_204_2 = 0.333333333333333
			local var_204_3, var_204_4 = arg_201_1:GetPercentByPara(arg_201_1:FormatText(arg_201_1:GetWordFromCfg(319681046).content), 1)

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0

				local var_204_5 = var_204_1 <= 0 and var_204_2 or var_204_2 * ((var_204_4 - arg_201_1.typewritterCharCountI18N) / var_204_1)

				if (var_204_1 <= 0 and var_204_2 or var_204_2 * ((var_204_4 - arg_201_1.typewritterCharCountI18N) / var_204_1)) > 0 and var_204_2 < var_204_5 then
					arg_201_1.talkMaxDuration = var_204_5

					if var_204_5 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + var_204_0
					end
				end
			end

			local var_204_6 = math.max(0.333333333333333, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_6 then
				arg_201_1.fswtw_.percent = Mathf.Lerp(arg_201_1.var_.oldValueTypewriter, var_204_3, (arg_201_1.time_ - var_204_0) / var_204_6)
				arg_201_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_201_1.fswtw_:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_6 and arg_201_1.time_ < var_204_0 + var_204_6 + arg_204_0 then
				arg_201_1.fswtw_.percent = var_204_3

				arg_201_1.fswtw_:SetDirty()
				arg_201_1:ShowNextGo(true)

				arg_201_1.typewritterCharCountI18N = var_204_4
			end

			local var_204_7 = 0.0333333333333333
			local var_204_8 = manager.audio:GetVoiceLength("story_v_out_319681", "319681046", "story_v_out_319681.awb") / 1000

			if var_204_8 > 0 and 1 < var_204_8 and var_204_8 + var_204_7 > arg_201_1.duration_ then
				arg_201_1.duration_ = var_204_8 + var_204_7
			end

			if var_204_7 < arg_201_1.time_ and arg_201_1.time_ <= var_204_7 + arg_204_0 then
				arg_201_1:AudioAction("play", "voice", "story_v_out_319681", "319681046", "story_v_out_319681.awb")
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play319681047 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 319681047
		arg_205_1.duration_ = 1.03

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play319681048(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.fswbg_:SetActive(true)
				arg_205_1.dialog_:SetActive(false)

				arg_205_1.fswtw_.percent = 0
				arg_205_1.fswt_.text = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(319681047).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.fswt_)

				arg_205_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_205_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_205_1.fswtw_:SetDirty()

				arg_205_1.typewritterCharCountI18N = 0

				SetActive(arg_205_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_205_1:ShowNextGo(false)
			end

			local var_208_0 = 0.0333333333333333

			if 0.0333333333333333 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.var_.oldValueTypewriter = arg_205_1.fswtw_.percent

				SetActive(arg_205_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_205_1:ShowNextGo(false)
			end

			local var_208_1 = 12
			local var_208_2 = 0.8
			local var_208_3, var_208_4 = arg_205_1:GetPercentByPara(arg_205_1:FormatText(arg_205_1:GetWordFromCfg(319681047).content), 1)

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0

				local var_208_5 = var_208_1 <= 0 and var_208_2 or var_208_2 * ((var_208_4 - arg_205_1.typewritterCharCountI18N) / var_208_1)

				if (var_208_1 <= 0 and var_208_2 or var_208_2 * ((var_208_4 - arg_205_1.typewritterCharCountI18N) / var_208_1)) > 0 and var_208_2 < var_208_5 then
					arg_205_1.talkMaxDuration = var_208_5

					if var_208_5 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + var_208_0
					end
				end
			end

			local var_208_6 = math.max(0.8, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_6 then
				arg_205_1.fswtw_.percent = Mathf.Lerp(arg_205_1.var_.oldValueTypewriter, var_208_3, (arg_205_1.time_ - var_208_0) / var_208_6)
				arg_205_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_205_1.fswtw_:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_6 and arg_205_1.time_ < var_208_0 + var_208_6 + arg_208_0 then
				arg_205_1.fswtw_.percent = var_208_3

				arg_205_1.fswtw_:SetDirty()
				arg_205_1:ShowNextGo(true)

				arg_205_1.typewritterCharCountI18N = var_208_4
			end

			local var_208_7 = 0.0333333333333333
			local var_208_8 = manager.audio:GetVoiceLength("story_v_out_319681", "319681047", "story_v_out_319681.awb") / 1000

			if var_208_8 > 0 and 1 < var_208_8 and var_208_8 + var_208_7 > arg_205_1.duration_ then
				arg_205_1.duration_ = var_208_8 + var_208_7
			end

			if var_208_7 < arg_205_1.time_ and arg_205_1.time_ <= var_208_7 + arg_208_0 then
				arg_205_1:AudioAction("play", "voice", "story_v_out_319681", "319681047", "story_v_out_319681.awb")
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play319681048 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 319681048
		arg_209_1.duration_ = 1.03

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play319681049(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.fswbg_:SetActive(true)
				arg_209_1.dialog_:SetActive(false)

				arg_209_1.fswtw_.percent = 0
				arg_209_1.fswt_.text = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(319681048).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.fswt_)

				arg_209_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_209_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_209_1.fswtw_:SetDirty()

				arg_209_1.typewritterCharCountI18N = 0

				SetActive(arg_209_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_209_1:ShowNextGo(false)
			end

			local var_212_0 = 0.0333333333333333

			if 0.0333333333333333 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.var_.oldValueTypewriter = arg_209_1.fswtw_.percent

				SetActive(arg_209_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_209_1:ShowNextGo(false)
			end

			local var_212_1 = 3
			local var_212_2 = 0.2
			local var_212_3, var_212_4 = arg_209_1:GetPercentByPara(arg_209_1:FormatText(arg_209_1:GetWordFromCfg(319681048).content), 1)

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0

				local var_212_5 = var_212_1 <= 0 and var_212_2 or var_212_2 * ((var_212_4 - arg_209_1.typewritterCharCountI18N) / var_212_1)

				if (var_212_1 <= 0 and var_212_2 or var_212_2 * ((var_212_4 - arg_209_1.typewritterCharCountI18N) / var_212_1)) > 0 and var_212_2 < var_212_5 then
					arg_209_1.talkMaxDuration = var_212_5

					if var_212_5 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + var_212_0
					end
				end
			end

			local var_212_6 = math.max(0.2, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_6 then
				arg_209_1.fswtw_.percent = Mathf.Lerp(arg_209_1.var_.oldValueTypewriter, var_212_3, (arg_209_1.time_ - var_212_0) / var_212_6)
				arg_209_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_209_1.fswtw_:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_6 and arg_209_1.time_ < var_212_0 + var_212_6 + arg_212_0 then
				arg_209_1.fswtw_.percent = var_212_3

				arg_209_1.fswtw_:SetDirty()
				arg_209_1:ShowNextGo(true)

				arg_209_1.typewritterCharCountI18N = var_212_4
			end

			local var_212_7 = 0.0333333333333333
			local var_212_8 = manager.audio:GetVoiceLength("story_v_out_319681", "319681048", "story_v_out_319681.awb") / 1000

			if var_212_8 > 0 and 1 < var_212_8 and var_212_8 + var_212_7 > arg_209_1.duration_ then
				arg_209_1.duration_ = var_212_8 + var_212_7
			end

			if var_212_7 < arg_209_1.time_ and arg_209_1.time_ <= var_212_7 + arg_212_0 then
				arg_209_1:AudioAction("play", "voice", "story_v_out_319681", "319681048", "story_v_out_319681.awb")
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play319681049 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 319681049
		arg_213_1.duration_ = 1.03

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play319681050(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.fswbg_:SetActive(true)
				arg_213_1.dialog_:SetActive(false)

				arg_213_1.fswtw_.percent = 0
				arg_213_1.fswt_.text = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(319681049).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.fswt_)

				arg_213_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_213_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_213_1.fswtw_:SetDirty()

				arg_213_1.typewritterCharCountI18N = 0

				SetActive(arg_213_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_213_1:ShowNextGo(false)
			end

			local var_216_0 = 0.0333333333333333

			if 0.0333333333333333 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.var_.oldValueTypewriter = arg_213_1.fswtw_.percent

				SetActive(arg_213_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_213_1:ShowNextGo(false)
			end

			local var_216_1 = 6
			local var_216_2 = 0.466666666666667
			local var_216_3, var_216_4 = arg_213_1:GetPercentByPara(arg_213_1:FormatText(arg_213_1:GetWordFromCfg(319681049).content), 1)

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0

				local var_216_5 = var_216_1 <= 0 and var_216_2 or var_216_2 * ((var_216_4 - arg_213_1.typewritterCharCountI18N) / var_216_1)

				if (var_216_1 <= 0 and var_216_2 or var_216_2 * ((var_216_4 - arg_213_1.typewritterCharCountI18N) / var_216_1)) > 0 and var_216_2 < var_216_5 then
					arg_213_1.talkMaxDuration = var_216_5

					if var_216_5 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + var_216_0
					end
				end
			end

			local var_216_6 = math.max(0.466666666666667, arg_213_1.talkMaxDuration)

			if var_216_0 <= arg_213_1.time_ and arg_213_1.time_ < var_216_0 + var_216_6 then
				arg_213_1.fswtw_.percent = Mathf.Lerp(arg_213_1.var_.oldValueTypewriter, var_216_3, (arg_213_1.time_ - var_216_0) / var_216_6)
				arg_213_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_213_1.fswtw_:SetDirty()
			end

			if arg_213_1.time_ >= var_216_0 + var_216_6 and arg_213_1.time_ < var_216_0 + var_216_6 + arg_216_0 then
				arg_213_1.fswtw_.percent = var_216_3

				arg_213_1.fswtw_:SetDirty()
				arg_213_1:ShowNextGo(true)

				arg_213_1.typewritterCharCountI18N = var_216_4
			end

			local var_216_7 = 0.0333333333333333
			local var_216_8 = manager.audio:GetVoiceLength("story_v_out_319681", "319681049", "story_v_out_319681.awb") / 1000

			if var_216_8 > 0 and 1 < var_216_8 and var_216_8 + var_216_7 > arg_213_1.duration_ then
				arg_213_1.duration_ = var_216_8 + var_216_7
			end

			if var_216_7 < arg_213_1.time_ and arg_213_1.time_ <= var_216_7 + arg_216_0 then
				arg_213_1:AudioAction("play", "voice", "story_v_out_319681", "319681049", "story_v_out_319681.awb")
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play319681050 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 319681050
		arg_217_1.duration_ = 1.03

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play319681051(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.fswbg_:SetActive(true)
				arg_217_1.dialog_:SetActive(false)

				arg_217_1.fswtw_.percent = 0
				arg_217_1.fswt_.text = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(319681050).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.fswt_)

				arg_217_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_217_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_217_1.fswtw_:SetDirty()

				arg_217_1.typewritterCharCountI18N = 0

				SetActive(arg_217_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_217_1:ShowNextGo(false)
			end

			local var_220_0 = 0.0333333333333333

			if 0.0333333333333333 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.var_.oldValueTypewriter = arg_217_1.fswtw_.percent

				SetActive(arg_217_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_217_1:ShowNextGo(false)
			end

			local var_220_1 = 7
			local var_220_2 = 0.466666666666667
			local var_220_3, var_220_4 = arg_217_1:GetPercentByPara(arg_217_1:FormatText(arg_217_1:GetWordFromCfg(319681050).content), 1)

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0

				local var_220_5 = var_220_1 <= 0 and var_220_2 or var_220_2 * ((var_220_4 - arg_217_1.typewritterCharCountI18N) / var_220_1)

				if (var_220_1 <= 0 and var_220_2 or var_220_2 * ((var_220_4 - arg_217_1.typewritterCharCountI18N) / var_220_1)) > 0 and var_220_2 < var_220_5 then
					arg_217_1.talkMaxDuration = var_220_5

					if var_220_5 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + var_220_0
					end
				end
			end

			local var_220_6 = math.max(0.466666666666667, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_6 then
				arg_217_1.fswtw_.percent = Mathf.Lerp(arg_217_1.var_.oldValueTypewriter, var_220_3, (arg_217_1.time_ - var_220_0) / var_220_6)
				arg_217_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_217_1.fswtw_:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_6 and arg_217_1.time_ < var_220_0 + var_220_6 + arg_220_0 then
				arg_217_1.fswtw_.percent = var_220_3

				arg_217_1.fswtw_:SetDirty()
				arg_217_1:ShowNextGo(true)

				arg_217_1.typewritterCharCountI18N = var_220_4
			end

			local var_220_7 = 0.0333333333333333
			local var_220_8 = manager.audio:GetVoiceLength("story_v_out_319681", "319681050", "story_v_out_319681.awb") / 1000

			if var_220_8 > 0 and 1 < var_220_8 and var_220_8 + var_220_7 > arg_217_1.duration_ then
				arg_217_1.duration_ = var_220_8 + var_220_7
			end

			if var_220_7 < arg_217_1.time_ and arg_217_1.time_ <= var_220_7 + arg_220_0 then
				arg_217_1:AudioAction("play", "voice", "story_v_out_319681", "319681050", "story_v_out_319681.awb")
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play319681051 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 319681051
		arg_221_1.duration_ = 1.03

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play319681052(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.fswbg_:SetActive(true)
				arg_221_1.dialog_:SetActive(false)

				arg_221_1.fswtw_.percent = 0
				arg_221_1.fswt_.text = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(319681051).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.fswt_)

				arg_221_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_221_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_221_1.fswtw_:SetDirty()

				arg_221_1.typewritterCharCountI18N = 0

				SetActive(arg_221_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_221_1:ShowNextGo(false)
			end

			local var_224_0 = 0.0333333333333333

			if 0.0333333333333333 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.var_.oldValueTypewriter = arg_221_1.fswtw_.percent

				SetActive(arg_221_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_221_1:ShowNextGo(false)
			end

			local var_224_1 = 11
			local var_224_2 = 0.733333333333333
			local var_224_3, var_224_4 = arg_221_1:GetPercentByPara(arg_221_1:FormatText(arg_221_1:GetWordFromCfg(319681051).content), 1)

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0

				local var_224_5 = var_224_1 <= 0 and var_224_2 or var_224_2 * ((var_224_4 - arg_221_1.typewritterCharCountI18N) / var_224_1)

				if (var_224_1 <= 0 and var_224_2 or var_224_2 * ((var_224_4 - arg_221_1.typewritterCharCountI18N) / var_224_1)) > 0 and var_224_2 < var_224_5 then
					arg_221_1.talkMaxDuration = var_224_5

					if var_224_5 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + var_224_0
					end
				end
			end

			local var_224_6 = math.max(0.733333333333333, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_6 then
				arg_221_1.fswtw_.percent = Mathf.Lerp(arg_221_1.var_.oldValueTypewriter, var_224_3, (arg_221_1.time_ - var_224_0) / var_224_6)
				arg_221_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_221_1.fswtw_:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_6 and arg_221_1.time_ < var_224_0 + var_224_6 + arg_224_0 then
				arg_221_1.fswtw_.percent = var_224_3

				arg_221_1.fswtw_:SetDirty()
				arg_221_1:ShowNextGo(true)

				arg_221_1.typewritterCharCountI18N = var_224_4
			end

			local var_224_7 = 0.0333333333333333
			local var_224_8 = manager.audio:GetVoiceLength("story_v_out_319681", "319681051", "story_v_out_319681.awb") / 1000

			if var_224_8 > 0 and 1 < var_224_8 and var_224_8 + var_224_7 > arg_221_1.duration_ then
				arg_221_1.duration_ = var_224_8 + var_224_7
			end

			if var_224_7 < arg_221_1.time_ and arg_221_1.time_ <= var_224_7 + arg_224_0 then
				arg_221_1:AudioAction("play", "voice", "story_v_out_319681", "319681051", "story_v_out_319681.awb")
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play319681052 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 319681052
		arg_225_1.duration_ = 1.03

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play319681053(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.fswbg_:SetActive(true)
				arg_225_1.dialog_:SetActive(false)

				arg_225_1.fswtw_.percent = 0
				arg_225_1.fswt_.text = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(319681052).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.fswt_)

				arg_225_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_225_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_225_1.fswtw_:SetDirty()

				arg_225_1.typewritterCharCountI18N = 0

				SetActive(arg_225_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_225_1:ShowNextGo(false)
			end

			local var_228_0 = 0.0333333333333333

			if 0.0333333333333333 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.var_.oldValueTypewriter = arg_225_1.fswtw_.percent

				SetActive(arg_225_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_225_1:ShowNextGo(false)
			end

			local var_228_1 = 4
			local var_228_2 = 0.266666666666667
			local var_228_3, var_228_4 = arg_225_1:GetPercentByPara(arg_225_1:FormatText(arg_225_1:GetWordFromCfg(319681052).content), 1)

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0

				local var_228_5 = var_228_1 <= 0 and var_228_2 or var_228_2 * ((var_228_4 - arg_225_1.typewritterCharCountI18N) / var_228_1)

				if (var_228_1 <= 0 and var_228_2 or var_228_2 * ((var_228_4 - arg_225_1.typewritterCharCountI18N) / var_228_1)) > 0 and var_228_2 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_0
					end
				end
			end

			local var_228_6 = math.max(0.266666666666667, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_6 then
				arg_225_1.fswtw_.percent = Mathf.Lerp(arg_225_1.var_.oldValueTypewriter, var_228_3, (arg_225_1.time_ - var_228_0) / var_228_6)
				arg_225_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_225_1.fswtw_:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_6 and arg_225_1.time_ < var_228_0 + var_228_6 + arg_228_0 then
				arg_225_1.fswtw_.percent = var_228_3

				arg_225_1.fswtw_:SetDirty()
				arg_225_1:ShowNextGo(true)

				arg_225_1.typewritterCharCountI18N = var_228_4
			end

			local var_228_7 = 0.0333333333333333
			local var_228_8 = manager.audio:GetVoiceLength("story_v_out_319681", "319681052", "story_v_out_319681.awb") / 1000

			if var_228_8 > 0 and 1 < var_228_8 and var_228_8 + var_228_7 > arg_225_1.duration_ then
				arg_225_1.duration_ = var_228_8 + var_228_7
			end

			if var_228_7 < arg_225_1.time_ and arg_225_1.time_ <= var_228_7 + arg_228_0 then
				arg_225_1:AudioAction("play", "voice", "story_v_out_319681", "319681052", "story_v_out_319681.awb")
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play319681053 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 319681053
		arg_229_1.duration_ = 2.9

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play319681054(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				local var_232_0 = arg_229_1.bgs_.ST69

				arg_229_1.bgs_.ST69.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_232_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_232_1 = var_232_0:GetComponent("SpriteRenderer")

				if var_232_1 and var_232_1.sprite then
					local var_232_2 = 2 * (var_232_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_232_0.transform.localScale = Vector3.New(var_232_2 / var_232_1.sprite.bounds.size.y < var_232_2 * manager.ui.mainCameraCom_.aspect / var_232_1.sprite.bounds.size.x and var_232_2 * manager.ui.mainCameraCom_.aspect / var_232_1.sprite.bounds.size.x or var_232_2 / var_232_1.sprite.bounds.size.y, var_232_2 / var_232_1.sprite.bounds.size.y < var_232_2 * manager.ui.mainCameraCom_.aspect / var_232_1.sprite.bounds.size.x and var_232_2 * manager.ui.mainCameraCom_.aspect / var_232_1.sprite.bounds.size.x or var_232_2 / var_232_1.sprite.bounds.size.y, 0)
				end

				for iter_232_0, iter_232_1 in pairs(arg_229_1.bgs_) do
					if iter_232_0 ~= "ST69" then
						iter_232_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.cswbg_:SetActive(false)
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				local var_232_3 = arg_229_1.fswbg_.transform:Find("textbox/adapt/content") or arg_229_1.fswbg_.transform:Find("textbox/content")
				local var_232_4 = arg_229_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_232_5 = var_232_3:GetComponent("RectTransform")

				var_232_3:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_232_5.offsetMin = Vector2.New(0, 0)
				var_232_5.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.fswbg_:SetActive(false)
				arg_229_1.dialog_:SetActive(false)
				SetActive(arg_229_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_229_1:ShowNextGo(false)
			end

			if 0.075 < arg_229_1.time_ and arg_229_1.time_ <= 0.075 + arg_232_0 then
				arg_229_1.fswbg_:SetActive(false)
				arg_229_1.dialog_:SetActive(false)
				SetActive(arg_229_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_229_1:ShowNextGo(false)
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.cswbg_:SetActive(false)
			end

			if arg_229_1.frameCnt_ <= 1 then
				arg_229_1.dialog_:SetActive(false)
			end

			local var_232_6 = 0.266666666666667
			local var_232_7 = 0.125

			if 0.266666666666667 < arg_229_1.time_ and arg_229_1.time_ <= var_232_6 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				arg_229_1.dialog_:SetActive(true)

				arg_229_1.dialogCg_.alpha = 0

				local var_232_8 = LeanTween.value(arg_229_1.dialog_, 0, 1, 0.3)

				var_232_8:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_229_1.dialogCg_.alpha = arg_233_0
				end))
				var_232_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_229_1.dialog_)
					var_232_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_229_1.duration_ = arg_229_1.duration_ + 0.3

				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[722].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_9 = arg_229_1:GetWordFromCfg(319681053)
				local var_232_10 = arg_229_1:FormatText(var_232_9.content)

				arg_229_1.text_.text = var_232_10

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_12 = 5 <= 0 and var_232_7 or var_232_7 * (utf8.len(var_232_10) / 5)

				if (5 <= 0 and var_232_7 or var_232_7 * (utf8.len(var_232_10) / 5)) > 0 and var_232_7 < var_232_12 then
					arg_229_1.talkMaxDuration = var_232_12
					var_232_6 = var_232_6 + 0.3

					if var_232_12 + var_232_6 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_12 + var_232_6
					end
				end

				arg_229_1.text_.text = var_232_10
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681053", "story_v_out_319681.awb") ~= 0 then
					local var_232_13 = manager.audio:GetVoiceLength("story_v_out_319681", "319681053", "story_v_out_319681.awb") / 1000

					if var_232_13 + var_232_6 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_13 + var_232_6
					end

					if var_232_9.prefab_name ~= "" and arg_229_1.actors_[var_232_9.prefab_name] ~= nil then
						local var_232_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_9.prefab_name].transform, "story_v_out_319681", "319681053", "story_v_out_319681.awb")

						arg_229_1:RecordAudio("319681053", var_232_14)
						arg_229_1:RecordAudio("319681053", var_232_14)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_319681", "319681053", "story_v_out_319681.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_319681", "319681053", "story_v_out_319681.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_15 = var_232_6 + 0.3
			local var_232_16 = math.max(var_232_7, arg_229_1.talkMaxDuration)

			if var_232_6 + 0.3 <= arg_229_1.time_ and arg_229_1.time_ < var_232_15 + var_232_16 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_15) / var_232_16

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_15 + var_232_16 and arg_229_1.time_ < var_232_15 + var_232_16 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play319681054 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 319681054
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play319681055(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 1.275

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(319681054).content)

				arg_235_1.text_.text = var_238_1

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_3 = 51 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 51)

				if (51 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 51)) > 0 and var_238_0 < var_238_3 then
					arg_235_1.talkMaxDuration = var_238_3

					if var_238_3 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_3 + 0
					end
				end

				arg_235_1.text_.text = var_238_1
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_4 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_4

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play319681055 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 319681055
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play319681056(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.775

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(319681055).content)

				arg_239_1.text_.text = var_242_1

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_3 = 31 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 31)

				if (31 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 31)) > 0 and var_242_0 < var_242_3 then
					arg_239_1.talkMaxDuration = var_242_3

					if var_242_3 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_3 + 0
					end
				end

				arg_239_1.text_.text = var_242_1
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_4 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_4 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_4

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_4 and arg_239_1.time_ < 0 + var_242_4 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play319681056 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 319681056
		arg_243_1.duration_ = 2.6

		local var_243_0 = {
			zh = 2.6,
			ja = 1.166
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play319681057(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.275

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[722].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_1 = arg_243_1:GetWordFromCfg(319681056)
				local var_246_2 = arg_243_1:FormatText(var_246_1.content)

				arg_243_1.text_.text = var_246_2

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 11 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 11)

				if (11 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 11)) > 0 and var_246_0 < var_246_4 then
					arg_243_1.talkMaxDuration = var_246_4

					if var_246_4 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_4 + 0
					end
				end

				arg_243_1.text_.text = var_246_2
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681056", "story_v_out_319681.awb") ~= 0 then
					local var_246_5 = manager.audio:GetVoiceLength("story_v_out_319681", "319681056", "story_v_out_319681.awb") / 1000

					if var_246_5 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + 0
					end

					if var_246_1.prefab_name ~= "" and arg_243_1.actors_[var_246_1.prefab_name] ~= nil then
						local var_246_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_1.prefab_name].transform, "story_v_out_319681", "319681056", "story_v_out_319681.awb")

						arg_243_1:RecordAudio("319681056", var_246_6)
						arg_243_1:RecordAudio("319681056", var_246_6)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_319681", "319681056", "story_v_out_319681.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_319681", "319681056", "story_v_out_319681.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_7 and arg_243_1.time_ < 0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play319681057 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 319681057
		arg_247_1.duration_ = 4.43

		local var_247_0 = {
			zh = 2.23333333333333,
			ja = 4.43333333333333
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
				arg_247_0:Play319681058(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos10079ui_story = arg_247_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_250_0 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 then
				arg_247_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_247_1.time_ - 0) / var_250_0)
				arg_247_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10079ui_story"].transform.position).z)
				arg_247_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["10079ui_story"].transform.localEulerAngles = arg_247_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 then
				arg_247_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_247_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["10079ui_story"].transform.position).z)
				arg_247_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["10079ui_story"].transform.localEulerAngles = arg_247_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_250_1 = arg_247_1.actors_["10079ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect10079ui_story == nil then
				arg_247_1.var_.characterEffect10079ui_story = var_250_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_2 and not isNil(var_250_1) then
				if arg_247_1.var_.characterEffect10079ui_story and not isNil(var_250_1) then
					arg_247_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_2 and arg_247_1.time_ < 0 + var_250_2 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect10079ui_story then
				arg_247_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_247_1.frameCnt_ <= 1 then
				arg_247_1.dialog_:SetActive(false)
			end

			local var_250_4 = 0.633333333333333
			local var_250_5 = 0.175

			if 0.633333333333333 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0

				arg_247_1.dialog_:SetActive(true)

				arg_247_1.dialogCg_.alpha = 0

				local var_250_6 = LeanTween.value(arg_247_1.dialog_, 0, 1, 0.3)

				var_250_6:setOnUpdate(LuaHelper.FloatAction(function(arg_251_0)
					arg_247_1.dialogCg_.alpha = arg_251_0
				end))
				var_250_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_247_1.dialog_)
					var_250_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_247_1.duration_ = arg_247_1.duration_ + 0.3

				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_7 = arg_247_1:GetWordFromCfg(319681057)
				local var_250_8 = arg_247_1:FormatText(var_250_7.content)

				arg_247_1.text_.text = var_250_8

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_10 = 7 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_8) / 7)

				if (7 <= 0 and var_250_5 or var_250_5 * (utf8.len(var_250_8) / 7)) > 0 and var_250_5 < var_250_10 then
					arg_247_1.talkMaxDuration = var_250_10
					var_250_4 = var_250_4 + 0.3

					if var_250_10 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_10 + var_250_4
					end
				end

				arg_247_1.text_.text = var_250_8
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681057", "story_v_out_319681.awb") ~= 0 then
					local var_250_11 = manager.audio:GetVoiceLength("story_v_out_319681", "319681057", "story_v_out_319681.awb") / 1000

					if var_250_11 + var_250_4 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_11 + var_250_4
					end

					if var_250_7.prefab_name ~= "" and arg_247_1.actors_[var_250_7.prefab_name] ~= nil then
						local var_250_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_7.prefab_name].transform, "story_v_out_319681", "319681057", "story_v_out_319681.awb")

						arg_247_1:RecordAudio("319681057", var_250_12)
						arg_247_1:RecordAudio("319681057", var_250_12)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_319681", "319681057", "story_v_out_319681.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_319681", "319681057", "story_v_out_319681.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_13 = var_250_4 + 0.3
			local var_250_14 = math.max(var_250_5, arg_247_1.talkMaxDuration)

			if var_250_4 + 0.3 <= arg_247_1.time_ and arg_247_1.time_ < var_250_13 + var_250_14 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_13) / var_250_14

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_13 + var_250_14 and arg_247_1.time_ < var_250_13 + var_250_14 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play319681058 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 319681058
		arg_253_1.duration_ = 3.1

		local var_253_0 = {
			zh = 3.1,
			ja = 2.633
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play319681059(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["10079ui_story"]) and arg_253_1.var_.characterEffect10079ui_story == nil then
				arg_253_1.var_.characterEffect10079ui_story = arg_253_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["10079ui_story"]) then
				if arg_253_1.var_.characterEffect10079ui_story and not isNil(arg_253_1.actors_["10079ui_story"]) then
					arg_253_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_253_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_0)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["10079ui_story"]) and arg_253_1.var_.characterEffect10079ui_story then
				arg_253_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_253_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_256_1 = 0
			local var_256_2 = 0.325

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[722].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_3 = arg_253_1:GetWordFromCfg(319681058)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_6 = 13 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_4) / 13)

				if (13 <= 0 and var_256_2 or var_256_2 * (utf8.len(var_256_4) / 13)) > 0 and var_256_2 < var_256_6 then
					arg_253_1.talkMaxDuration = var_256_6

					if var_256_6 + var_256_1 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_6 + var_256_1
					end
				end

				arg_253_1.text_.text = var_256_4
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681058", "story_v_out_319681.awb") ~= 0 then
					local var_256_7 = manager.audio:GetVoiceLength("story_v_out_319681", "319681058", "story_v_out_319681.awb") / 1000

					if var_256_7 + var_256_1 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_1
					end

					if var_256_3.prefab_name ~= "" and arg_253_1.actors_[var_256_3.prefab_name] ~= nil then
						local var_256_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_3.prefab_name].transform, "story_v_out_319681", "319681058", "story_v_out_319681.awb")

						arg_253_1:RecordAudio("319681058", var_256_8)
						arg_253_1:RecordAudio("319681058", var_256_8)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_319681", "319681058", "story_v_out_319681.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_319681", "319681058", "story_v_out_319681.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_9 = math.max(var_256_2, arg_253_1.talkMaxDuration)

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_9 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_1) / var_256_9

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_1 + var_256_9 and arg_253_1.time_ < var_256_1 + var_256_9 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play319681059 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 319681059
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play319681060(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 1.05

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_1 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(319681059).content)

				arg_257_1.text_.text = var_260_1

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_3 = 42 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 42)

				if (42 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_1) / 42)) > 0 and var_260_0 < var_260_3 then
					arg_257_1.talkMaxDuration = var_260_3

					if var_260_3 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_3 + 0
					end
				end

				arg_257_1.text_.text = var_260_1
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_4 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_4 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_4

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_4 and arg_257_1.time_ < 0 + var_260_4 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play319681060 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 319681060
		arg_261_1.duration_ = 9.8

		local var_261_0 = {
			zh = 6.3,
			ja = 9.8
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
				arg_261_0:Play319681061(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.775

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[722].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_1 = arg_261_1:GetWordFromCfg(319681060)
				local var_264_2 = arg_261_1:FormatText(var_264_1.content)

				arg_261_1.text_.text = var_264_2

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_4 = 31 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 31)

				if (31 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 31)) > 0 and var_264_0 < var_264_4 then
					arg_261_1.talkMaxDuration = var_264_4

					if var_264_4 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_4 + 0
					end
				end

				arg_261_1.text_.text = var_264_2
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681060", "story_v_out_319681.awb") ~= 0 then
					local var_264_5 = manager.audio:GetVoiceLength("story_v_out_319681", "319681060", "story_v_out_319681.awb") / 1000

					if var_264_5 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + 0
					end

					if var_264_1.prefab_name ~= "" and arg_261_1.actors_[var_264_1.prefab_name] ~= nil then
						local var_264_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_1.prefab_name].transform, "story_v_out_319681", "319681060", "story_v_out_319681.awb")

						arg_261_1:RecordAudio("319681060", var_264_6)
						arg_261_1:RecordAudio("319681060", var_264_6)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_319681", "319681060", "story_v_out_319681.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_319681", "319681060", "story_v_out_319681.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_7 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_7 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_7

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_7 and arg_261_1.time_ < 0 + var_264_7 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play319681061 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 319681061
		arg_265_1.duration_ = 11.83

		local var_265_0 = {
			zh = 7.833,
			ja = 11.833
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
				arg_265_0:Play319681062(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 1.075

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[722].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_1 = arg_265_1:GetWordFromCfg(319681061)
				local var_268_2 = arg_265_1:FormatText(var_268_1.content)

				arg_265_1.text_.text = var_268_2

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_4 = 43 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 43)

				if (43 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 43)) > 0 and var_268_0 < var_268_4 then
					arg_265_1.talkMaxDuration = var_268_4

					if var_268_4 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_4 + 0
					end
				end

				arg_265_1.text_.text = var_268_2
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681061", "story_v_out_319681.awb") ~= 0 then
					local var_268_5 = manager.audio:GetVoiceLength("story_v_out_319681", "319681061", "story_v_out_319681.awb") / 1000

					if var_268_5 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + 0
					end

					if var_268_1.prefab_name ~= "" and arg_265_1.actors_[var_268_1.prefab_name] ~= nil then
						local var_268_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_1.prefab_name].transform, "story_v_out_319681", "319681061", "story_v_out_319681.awb")

						arg_265_1:RecordAudio("319681061", var_268_6)
						arg_265_1:RecordAudio("319681061", var_268_6)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_319681", "319681061", "story_v_out_319681.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_319681", "319681061", "story_v_out_319681.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_7 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_7 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_7

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_7 and arg_265_1.time_ < 0 + var_268_7 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play319681062 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 319681062
		arg_269_1.duration_ = 7.83

		local var_269_0 = {
			zh = 7.833,
			ja = 7.733
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
				arg_269_0:Play319681063(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0.95

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[722].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_1 = arg_269_1:GetWordFromCfg(319681062)
				local var_272_2 = arg_269_1:FormatText(var_272_1.content)

				arg_269_1.text_.text = var_272_2

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_4 = 38 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 38)

				if (38 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 38)) > 0 and var_272_0 < var_272_4 then
					arg_269_1.talkMaxDuration = var_272_4

					if var_272_4 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_4 + 0
					end
				end

				arg_269_1.text_.text = var_272_2
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681062", "story_v_out_319681.awb") ~= 0 then
					local var_272_5 = manager.audio:GetVoiceLength("story_v_out_319681", "319681062", "story_v_out_319681.awb") / 1000

					if var_272_5 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + 0
					end

					if var_272_1.prefab_name ~= "" and arg_269_1.actors_[var_272_1.prefab_name] ~= nil then
						local var_272_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_1.prefab_name].transform, "story_v_out_319681", "319681062", "story_v_out_319681.awb")

						arg_269_1:RecordAudio("319681062", var_272_6)
						arg_269_1:RecordAudio("319681062", var_272_6)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_319681", "319681062", "story_v_out_319681.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_319681", "319681062", "story_v_out_319681.awb")
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
	Play319681063 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 319681063
		arg_273_1.duration_ = 2

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play319681064(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos10079ui_story = arg_273_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10079ui_story"].transform.position).z)
				arg_273_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["10079ui_story"].transform.localEulerAngles = arg_273_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_273_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10079ui_story"].transform.position).z)
				arg_273_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["10079ui_story"].transform.localEulerAngles = arg_273_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_276_1 = arg_273_1.actors_["10079ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect10079ui_story == nil then
				arg_273_1.var_.characterEffect10079ui_story = var_276_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_2 and not isNil(var_276_1) then
				if arg_273_1.var_.characterEffect10079ui_story and not isNil(var_276_1) then
					arg_273_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_2 and arg_273_1.time_ < 0 + var_276_2 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect10079ui_story then
				arg_273_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_276_4 = 0
			local var_276_5 = 0.125

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_6 = arg_273_1:GetWordFromCfg(319681063)
				local var_276_7 = arg_273_1:FormatText(var_276_6.content)

				arg_273_1.text_.text = var_276_7

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_9 = 5 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 5)

				if (5 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 5)) > 0 and var_276_5 < var_276_9 then
					arg_273_1.talkMaxDuration = var_276_9

					if var_276_9 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_9 + var_276_4
					end
				end

				arg_273_1.text_.text = var_276_7
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681063", "story_v_out_319681.awb") ~= 0 then
					local var_276_10 = manager.audio:GetVoiceLength("story_v_out_319681", "319681063", "story_v_out_319681.awb") / 1000

					if var_276_10 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_4
					end

					if var_276_6.prefab_name ~= "" and arg_273_1.actors_[var_276_6.prefab_name] ~= nil then
						local var_276_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_6.prefab_name].transform, "story_v_out_319681", "319681063", "story_v_out_319681.awb")

						arg_273_1:RecordAudio("319681063", var_276_11)
						arg_273_1:RecordAudio("319681063", var_276_11)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_319681", "319681063", "story_v_out_319681.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_319681", "319681063", "story_v_out_319681.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_12 = math.max(var_276_5, arg_273_1.talkMaxDuration)

			if var_276_4 <= arg_273_1.time_ and arg_273_1.time_ < var_276_4 + var_276_12 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_4) / var_276_12

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_4 + var_276_12 and arg_273_1.time_ < var_276_4 + var_276_12 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319681064 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 319681064
		arg_277_1.duration_ = 9.07

		local var_277_0 = {
			zh = 7.2,
			ja = 9.066
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
				arg_277_0:Play319681065(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["10079ui_story"]) and arg_277_1.var_.characterEffect10079ui_story == nil then
				arg_277_1.var_.characterEffect10079ui_story = arg_277_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_0 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["10079ui_story"]) then
				if arg_277_1.var_.characterEffect10079ui_story and not isNil(arg_277_1.actors_["10079ui_story"]) then
					arg_277_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_277_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_0)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["10079ui_story"]) and arg_277_1.var_.characterEffect10079ui_story then
				arg_277_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_277_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_280_1 = 0
			local var_280_2 = 0.825

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[722].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officerw")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_3 = arg_277_1:GetWordFromCfg(319681064)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_6 = 33 <= 0 and var_280_2 or var_280_2 * (utf8.len(var_280_4) / 33)

				if (33 <= 0 and var_280_2 or var_280_2 * (utf8.len(var_280_4) / 33)) > 0 and var_280_2 < var_280_6 then
					arg_277_1.talkMaxDuration = var_280_6

					if var_280_6 + var_280_1 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_6 + var_280_1
					end
				end

				arg_277_1.text_.text = var_280_4
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681064", "story_v_out_319681.awb") ~= 0 then
					local var_280_7 = manager.audio:GetVoiceLength("story_v_out_319681", "319681064", "story_v_out_319681.awb") / 1000

					if var_280_7 + var_280_1 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_1
					end

					if var_280_3.prefab_name ~= "" and arg_277_1.actors_[var_280_3.prefab_name] ~= nil then
						local var_280_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_3.prefab_name].transform, "story_v_out_319681", "319681064", "story_v_out_319681.awb")

						arg_277_1:RecordAudio("319681064", var_280_8)
						arg_277_1:RecordAudio("319681064", var_280_8)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_319681", "319681064", "story_v_out_319681.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_319681", "319681064", "story_v_out_319681.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_9 = math.max(var_280_2, arg_277_1.talkMaxDuration)

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_9 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_1) / var_280_9

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_1 + var_280_9 and arg_277_1.time_ < var_280_1 + var_280_9 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play319681065 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 319681065
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play319681066(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos10079ui_story = arg_281_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_284_0 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 then
				arg_281_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_281_1.time_ - 0) / var_284_0)
				arg_281_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10079ui_story"].transform.position).z)
				arg_281_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["10079ui_story"].transform.localEulerAngles = arg_281_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 then
				arg_281_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_281_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_281_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_281_1.actors_["10079ui_story"].transform.position).z)
				arg_281_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_281_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_281_1.actors_["10079ui_story"].transform.localEulerAngles = arg_281_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_284_1 = 0
			local var_284_2 = 0.95

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_3 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(319681065).content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 38 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 38)

				if (38 <= 0 and var_284_2 or var_284_2 * (utf8.len(var_284_3) / 38)) > 0 and var_284_2 < var_284_5 then
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

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319681066 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 319681066
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play319681067(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.825

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_1 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(319681066).content)

				arg_285_1.text_.text = var_288_1

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_3 = 33 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 33)

				if (33 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 33)) > 0 and var_288_0 < var_288_3 then
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
	Play319681067 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 319681067
		arg_289_1.duration_ = 9.3

		local var_289_0 = {
			zh = 8.966,
			ja = 9.3
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
				arg_289_0:Play319681068(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos10079ui_story = arg_289_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_292_0 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 then
				arg_289_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_289_1.time_ - 0) / var_292_0)
				arg_289_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10079ui_story"].transform.position).z)
				arg_289_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["10079ui_story"].transform.localEulerAngles = arg_289_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 then
				arg_289_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_289_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10079ui_story"].transform.position).z)
				arg_289_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["10079ui_story"].transform.localEulerAngles = arg_289_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_292_1 = arg_289_1.actors_["10079ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect10079ui_story == nil then
				arg_289_1.var_.characterEffect10079ui_story = var_292_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_2 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_2 and not isNil(var_292_1) then
				if arg_289_1.var_.characterEffect10079ui_story and not isNil(var_292_1) then
					arg_289_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_2 and arg_289_1.time_ < 0 + var_292_2 + arg_292_0 and not isNil(var_292_1) and arg_289_1.var_.characterEffect10079ui_story then
				arg_289_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_292_4 = 0
			local var_292_5 = 1.075

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
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

				local var_292_6 = arg_289_1:GetWordFromCfg(319681067)
				local var_292_7 = arg_289_1:FormatText(var_292_6.content)

				arg_289_1.text_.text = var_292_7

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_9 = 43 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 43)

				if (43 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_7) / 43)) > 0 and var_292_5 < var_292_9 then
					arg_289_1.talkMaxDuration = var_292_9

					if var_292_9 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_9 + var_292_4
					end
				end

				arg_289_1.text_.text = var_292_7
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681067", "story_v_out_319681.awb") ~= 0 then
					local var_292_10 = manager.audio:GetVoiceLength("story_v_out_319681", "319681067", "story_v_out_319681.awb") / 1000

					if var_292_10 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_4
					end

					if var_292_6.prefab_name ~= "" and arg_289_1.actors_[var_292_6.prefab_name] ~= nil then
						local var_292_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_6.prefab_name].transform, "story_v_out_319681", "319681067", "story_v_out_319681.awb")

						arg_289_1:RecordAudio("319681067", var_292_11)
						arg_289_1:RecordAudio("319681067", var_292_11)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_319681", "319681067", "story_v_out_319681.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_319681", "319681067", "story_v_out_319681.awb")
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
				actorName = "10079ui_story",
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
	Play319681068 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 319681068
		arg_293_1.duration_ = 12.37

		local var_293_0 = {
			zh = 7.7,
			ja = 12.366
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
				arg_293_0:Play319681069(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1095ui_story = arg_293_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_296_0 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 then
				arg_293_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_293_1.time_ - 0) / var_296_0)
				arg_293_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1095ui_story"].transform.position).z)
				arg_293_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1095ui_story"].transform.localEulerAngles = arg_293_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 then
				arg_293_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_293_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_293_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_293_1.actors_["1095ui_story"].transform.position).z)
				arg_293_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_293_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_293_1.actors_["1095ui_story"].transform.localEulerAngles = arg_293_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_296_1 = arg_293_1.actors_["1095ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect1095ui_story == nil then
				arg_293_1.var_.characterEffect1095ui_story = var_296_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_2 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_2 and not isNil(var_296_1) then
				if arg_293_1.var_.characterEffect1095ui_story and not isNil(var_296_1) then
					arg_293_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_2 and arg_293_1.time_ < 0 + var_296_2 + arg_296_0 and not isNil(var_296_1) and arg_293_1.var_.characterEffect1095ui_story then
				arg_293_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_296_4 = arg_293_1.actors_["10079ui_story"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos10079ui_story = var_296_4.localPosition
			end

			local var_296_5 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_5 then
				var_296_4.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_293_1.time_ - 0) / var_296_5)
				var_296_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_4.position).x, (manager.ui.mainCamera.transform.position - var_296_4.position).y, (manager.ui.mainCamera.transform.position - var_296_4.position).z)
				var_296_4.localEulerAngles.z = 0
				var_296_4.localEulerAngles.x = 0
				var_296_4.localEulerAngles = var_296_4.localEulerAngles
			end

			if arg_293_1.time_ >= 0 + var_296_5 and arg_293_1.time_ < 0 + var_296_5 + arg_296_0 then
				var_296_4.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_296_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_296_4.position).x, (manager.ui.mainCamera.transform.position - var_296_4.position).y, (manager.ui.mainCamera.transform.position - var_296_4.position).z)
				var_296_4.localEulerAngles.z = 0
				var_296_4.localEulerAngles.x = 0
				var_296_4.localEulerAngles = var_296_4.localEulerAngles
			end

			local var_296_6 = arg_293_1.actors_["10079ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_6) and arg_293_1.var_.characterEffect10079ui_story == nil then
				arg_293_1.var_.characterEffect10079ui_story = var_296_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_7 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_7 and not isNil(var_296_6) then
				if arg_293_1.var_.characterEffect10079ui_story and not isNil(var_296_6) then
					arg_293_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_293_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_7)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_7 and arg_293_1.time_ < 0 + var_296_7 + arg_296_0 and not isNil(var_296_6) and arg_293_1.var_.characterEffect10079ui_story then
				arg_293_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_293_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_296_8 = 0
			local var_296_9 = 0.925

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_8 + arg_296_0 then
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

				local var_296_10 = arg_293_1:GetWordFromCfg(319681068)
				local var_296_11 = arg_293_1:FormatText(var_296_10.content)

				arg_293_1.text_.text = var_296_11

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_13 = 37 <= 0 and var_296_9 or var_296_9 * (utf8.len(var_296_11) / 37)

				if (37 <= 0 and var_296_9 or var_296_9 * (utf8.len(var_296_11) / 37)) > 0 and var_296_9 < var_296_13 then
					arg_293_1.talkMaxDuration = var_296_13

					if var_296_13 + var_296_8 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_13 + var_296_8
					end
				end

				arg_293_1.text_.text = var_296_11
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681068", "story_v_out_319681.awb") ~= 0 then
					local var_296_14 = manager.audio:GetVoiceLength("story_v_out_319681", "319681068", "story_v_out_319681.awb") / 1000

					if var_296_14 + var_296_8 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_14 + var_296_8
					end

					if var_296_10.prefab_name ~= "" and arg_293_1.actors_[var_296_10.prefab_name] ~= nil then
						local var_296_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_10.prefab_name].transform, "story_v_out_319681", "319681068", "story_v_out_319681.awb")

						arg_293_1:RecordAudio("319681068", var_296_15)
						arg_293_1:RecordAudio("319681068", var_296_15)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_319681", "319681068", "story_v_out_319681.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_319681", "319681068", "story_v_out_319681.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_16 = math.max(var_296_9, arg_293_1.talkMaxDuration)

			if var_296_8 <= arg_293_1.time_ and arg_293_1.time_ < var_296_8 + var_296_16 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_8) / var_296_16

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_8 + var_296_16 and arg_293_1.time_ < var_296_8 + var_296_16 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319681069 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 319681069
		arg_297_1.duration_ = 12.1

		local var_297_0 = {
			zh = 10.033,
			ja = 12.1
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
				arg_297_0:Play319681070(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 1.25

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

				local var_300_1 = arg_297_1:GetWordFromCfg(319681069)
				local var_300_2 = arg_297_1:FormatText(var_300_1.content)

				arg_297_1.text_.text = var_300_2

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_4 = 50 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_2) / 50)

				if (50 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_2) / 50)) > 0 and var_300_0 < var_300_4 then
					arg_297_1.talkMaxDuration = var_300_4

					if var_300_4 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_4 + 0
					end
				end

				arg_297_1.text_.text = var_300_2
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681069", "story_v_out_319681.awb") ~= 0 then
					local var_300_5 = manager.audio:GetVoiceLength("story_v_out_319681", "319681069", "story_v_out_319681.awb") / 1000

					if var_300_5 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_5 + 0
					end

					if var_300_1.prefab_name ~= "" and arg_297_1.actors_[var_300_1.prefab_name] ~= nil then
						local var_300_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_1.prefab_name].transform, "story_v_out_319681", "319681069", "story_v_out_319681.awb")

						arg_297_1:RecordAudio("319681069", var_300_6)
						arg_297_1:RecordAudio("319681069", var_300_6)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_319681", "319681069", "story_v_out_319681.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_319681", "319681069", "story_v_out_319681.awb")
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
	Play319681070 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 319681070
		arg_301_1.duration_ = 3.6

		local var_301_0 = {
			zh = 1.999999999999,
			ja = 3.6
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play319681071(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos10079ui_story = arg_301_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_304_0 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 then
				arg_301_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_301_1.time_ - 0) / var_304_0)
				arg_301_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["10079ui_story"].transform.position).z)
				arg_301_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["10079ui_story"].transform.localEulerAngles = arg_301_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 then
				arg_301_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_301_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_301_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_301_1.actors_["10079ui_story"].transform.position).z)
				arg_301_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_301_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_301_1.actors_["10079ui_story"].transform.localEulerAngles = arg_301_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_304_1 = arg_301_1.actors_["10079ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect10079ui_story == nil then
				arg_301_1.var_.characterEffect10079ui_story = var_304_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_2 and not isNil(var_304_1) then
				if arg_301_1.var_.characterEffect10079ui_story and not isNil(var_304_1) then
					arg_301_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_2 and arg_301_1.time_ < 0 + var_304_2 + arg_304_0 and not isNil(var_304_1) and arg_301_1.var_.characterEffect10079ui_story then
				arg_301_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_304_4 = arg_301_1.actors_["1095ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_4) and arg_301_1.var_.characterEffect1095ui_story == nil then
				arg_301_1.var_.characterEffect1095ui_story = var_304_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_5 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_5 and not isNil(var_304_4) then
				if arg_301_1.var_.characterEffect1095ui_story and not isNil(var_304_4) then
					arg_301_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_301_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_301_1.time_ - 0) / var_304_5)
				end
			end

			if arg_301_1.time_ >= 0 + var_304_5 and arg_301_1.time_ < 0 + var_304_5 + arg_304_0 and not isNil(var_304_4) and arg_301_1.var_.characterEffect1095ui_story then
				arg_301_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_301_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_304_6 = 0
			local var_304_7 = 0.125

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

				local var_304_8 = arg_301_1:GetWordFromCfg(319681070)
				local var_304_9 = arg_301_1:FormatText(var_304_8.content)

				arg_301_1.text_.text = var_304_9

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_11 = 5 <= 0 and var_304_7 or var_304_7 * (utf8.len(var_304_9) / 5)

				if (5 <= 0 and var_304_7 or var_304_7 * (utf8.len(var_304_9) / 5)) > 0 and var_304_7 < var_304_11 then
					arg_301_1.talkMaxDuration = var_304_11

					if var_304_11 + var_304_6 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_11 + var_304_6
					end
				end

				arg_301_1.text_.text = var_304_9
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681070", "story_v_out_319681.awb") ~= 0 then
					local var_304_12 = manager.audio:GetVoiceLength("story_v_out_319681", "319681070", "story_v_out_319681.awb") / 1000

					if var_304_12 + var_304_6 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_12 + var_304_6
					end

					if var_304_8.prefab_name ~= "" and arg_301_1.actors_[var_304_8.prefab_name] ~= nil then
						local var_304_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_8.prefab_name].transform, "story_v_out_319681", "319681070", "story_v_out_319681.awb")

						arg_301_1:RecordAudio("319681070", var_304_13)
						arg_301_1:RecordAudio("319681070", var_304_13)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_319681", "319681070", "story_v_out_319681.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_319681", "319681070", "story_v_out_319681.awb")
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
				actorName = "10079ui_story",
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
	Play319681071 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 319681071
		arg_305_1.duration_ = 9.43

		local var_305_0 = {
			zh = 9.1,
			ja = 9.433
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
				arg_305_0:Play319681072(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["10079ui_story"]) and arg_305_1.var_.characterEffect10079ui_story == nil then
				arg_305_1.var_.characterEffect10079ui_story = arg_305_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_0 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["10079ui_story"]) then
				if arg_305_1.var_.characterEffect10079ui_story and not isNil(arg_305_1.actors_["10079ui_story"]) then
					arg_305_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_305_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_0)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["10079ui_story"]) and arg_305_1.var_.characterEffect10079ui_story then
				arg_305_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_305_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_308_1 = arg_305_1.actors_["1095ui_story"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1095ui_story == nil then
				arg_305_1.var_.characterEffect1095ui_story = var_308_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_2 and not isNil(var_308_1) then
				if arg_305_1.var_.characterEffect1095ui_story and not isNil(var_308_1) then
					arg_305_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_305_1.time_ >= 0 + var_308_2 and arg_305_1.time_ < 0 + var_308_2 + arg_308_0 and not isNil(var_308_1) and arg_305_1.var_.characterEffect1095ui_story then
				arg_305_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_308_4 = 0
			local var_308_5 = 1.05

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

				local var_308_6 = arg_305_1:GetWordFromCfg(319681071)
				local var_308_7 = arg_305_1:FormatText(var_308_6.content)

				arg_305_1.text_.text = var_308_7

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_9 = 42 <= 0 and var_308_5 or var_308_5 * (utf8.len(var_308_7) / 42)

				if (42 <= 0 and var_308_5 or var_308_5 * (utf8.len(var_308_7) / 42)) > 0 and var_308_5 < var_308_9 then
					arg_305_1.talkMaxDuration = var_308_9

					if var_308_9 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_9 + var_308_4
					end
				end

				arg_305_1.text_.text = var_308_7
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681071", "story_v_out_319681.awb") ~= 0 then
					local var_308_10 = manager.audio:GetVoiceLength("story_v_out_319681", "319681071", "story_v_out_319681.awb") / 1000

					if var_308_10 + var_308_4 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_10 + var_308_4
					end

					if var_308_6.prefab_name ~= "" and arg_305_1.actors_[var_308_6.prefab_name] ~= nil then
						local var_308_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_6.prefab_name].transform, "story_v_out_319681", "319681071", "story_v_out_319681.awb")

						arg_305_1:RecordAudio("319681071", var_308_11)
						arg_305_1:RecordAudio("319681071", var_308_11)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_319681", "319681071", "story_v_out_319681.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_319681", "319681071", "story_v_out_319681.awb")
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
	Play319681072 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 319681072
		arg_309_1.duration_ = 5.3

		local var_309_0 = {
			zh = 3.433,
			ja = 5.3
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
				arg_309_0:Play319681073(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["10079ui_story"]) and arg_309_1.var_.characterEffect10079ui_story == nil then
				arg_309_1.var_.characterEffect10079ui_story = arg_309_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_0 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["10079ui_story"]) then
				if arg_309_1.var_.characterEffect10079ui_story and not isNil(arg_309_1.actors_["10079ui_story"]) then
					arg_309_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["10079ui_story"]) and arg_309_1.var_.characterEffect10079ui_story then
				arg_309_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_312_2 = arg_309_1.actors_["1095ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.characterEffect1095ui_story == nil then
				arg_309_1.var_.characterEffect1095ui_story = var_312_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_3 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_3 and not isNil(var_312_2) then
				if arg_309_1.var_.characterEffect1095ui_story and not isNil(var_312_2) then
					arg_309_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_309_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_309_1.time_ - 0) / var_312_3)
				end
			end

			if arg_309_1.time_ >= 0 + var_312_3 and arg_309_1.time_ < 0 + var_312_3 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.characterEffect1095ui_story then
				arg_309_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_309_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_312_4 = 0
			local var_312_5 = 0.45

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

				local var_312_6 = arg_309_1:GetWordFromCfg(319681072)
				local var_312_7 = arg_309_1:FormatText(var_312_6.content)

				arg_309_1.text_.text = var_312_7

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_9 = 18 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 18)

				if (18 <= 0 and var_312_5 or var_312_5 * (utf8.len(var_312_7) / 18)) > 0 and var_312_5 < var_312_9 then
					arg_309_1.talkMaxDuration = var_312_9

					if var_312_9 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_9 + var_312_4
					end
				end

				arg_309_1.text_.text = var_312_7
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681072", "story_v_out_319681.awb") ~= 0 then
					local var_312_10 = manager.audio:GetVoiceLength("story_v_out_319681", "319681072", "story_v_out_319681.awb") / 1000

					if var_312_10 + var_312_4 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_4
					end

					if var_312_6.prefab_name ~= "" and arg_309_1.actors_[var_312_6.prefab_name] ~= nil then
						local var_312_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_6.prefab_name].transform, "story_v_out_319681", "319681072", "story_v_out_319681.awb")

						arg_309_1:RecordAudio("319681072", var_312_11)
						arg_309_1:RecordAudio("319681072", var_312_11)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_319681", "319681072", "story_v_out_319681.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_319681", "319681072", "story_v_out_319681.awb")
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
	Play319681073 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 319681073
		arg_313_1.duration_ = 5.93

		local var_313_0 = {
			zh = 2.933,
			ja = 5.933
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
				arg_313_0:Play319681074(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0.375

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_1 = arg_313_1:GetWordFromCfg(319681073)
				local var_316_2 = arg_313_1:FormatText(var_316_1.content)

				arg_313_1.text_.text = var_316_2

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_4 = 15 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_2) / 15)

				if (15 <= 0 and var_316_0 or var_316_0 * (utf8.len(var_316_2) / 15)) > 0 and var_316_0 < var_316_4 then
					arg_313_1.talkMaxDuration = var_316_4

					if var_316_4 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_4 + 0
					end
				end

				arg_313_1.text_.text = var_316_2
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681073", "story_v_out_319681.awb") ~= 0 then
					local var_316_5 = manager.audio:GetVoiceLength("story_v_out_319681", "319681073", "story_v_out_319681.awb") / 1000

					if var_316_5 + 0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + 0
					end

					if var_316_1.prefab_name ~= "" and arg_313_1.actors_[var_316_1.prefab_name] ~= nil then
						local var_316_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_1.prefab_name].transform, "story_v_out_319681", "319681073", "story_v_out_319681.awb")

						arg_313_1:RecordAudio("319681073", var_316_6)
						arg_313_1:RecordAudio("319681073", var_316_6)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_319681", "319681073", "story_v_out_319681.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_319681", "319681073", "story_v_out_319681.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_7 = math.max(var_316_0, arg_313_1.talkMaxDuration)

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_7 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - 0) / var_316_7

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= 0 + var_316_7 and arg_313_1.time_ < 0 + var_316_7 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play319681074 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 319681074
		arg_317_1.duration_ = 8.8

		local var_317_0 = {
			zh = 4.866,
			ja = 8.8
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
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play319681075(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["10079ui_story"]) and arg_317_1.var_.characterEffect10079ui_story == nil then
				arg_317_1.var_.characterEffect10079ui_story = arg_317_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_0 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["10079ui_story"]) then
				if arg_317_1.var_.characterEffect10079ui_story and not isNil(arg_317_1.actors_["10079ui_story"]) then
					arg_317_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_317_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_0)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["10079ui_story"]) and arg_317_1.var_.characterEffect10079ui_story then
				arg_317_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_317_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_320_1 = arg_317_1.actors_["1095ui_story"]

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1095ui_story == nil then
				arg_317_1.var_.characterEffect1095ui_story = var_320_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_2 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_2 and not isNil(var_320_1) then
				if arg_317_1.var_.characterEffect1095ui_story and not isNil(var_320_1) then
					arg_317_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_2 and arg_317_1.time_ < 0 + var_320_2 + arg_320_0 and not isNil(var_320_1) and arg_317_1.var_.characterEffect1095ui_story then
				arg_317_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_320_4 = 0
			local var_320_5 = 0.6

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_4 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_6 = arg_317_1:GetWordFromCfg(319681074)
				local var_320_7 = arg_317_1:FormatText(var_320_6.content)

				arg_317_1.text_.text = var_320_7

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_9 = 24 <= 0 and var_320_5 or var_320_5 * (utf8.len(var_320_7) / 24)

				if (24 <= 0 and var_320_5 or var_320_5 * (utf8.len(var_320_7) / 24)) > 0 and var_320_5 < var_320_9 then
					arg_317_1.talkMaxDuration = var_320_9

					if var_320_9 + var_320_4 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_9 + var_320_4
					end
				end

				arg_317_1.text_.text = var_320_7
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681074", "story_v_out_319681.awb") ~= 0 then
					local var_320_10 = manager.audio:GetVoiceLength("story_v_out_319681", "319681074", "story_v_out_319681.awb") / 1000

					if var_320_10 + var_320_4 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_10 + var_320_4
					end

					if var_320_6.prefab_name ~= "" and arg_317_1.actors_[var_320_6.prefab_name] ~= nil then
						local var_320_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_6.prefab_name].transform, "story_v_out_319681", "319681074", "story_v_out_319681.awb")

						arg_317_1:RecordAudio("319681074", var_320_11)
						arg_317_1:RecordAudio("319681074", var_320_11)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_319681", "319681074", "story_v_out_319681.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_319681", "319681074", "story_v_out_319681.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_12 = math.max(var_320_5, arg_317_1.talkMaxDuration)

			if var_320_4 <= arg_317_1.time_ and arg_317_1.time_ < var_320_4 + var_320_12 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_4) / var_320_12

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_4 + var_320_12 and arg_317_1.time_ < var_320_4 + var_320_12 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play319681075 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 319681075
		arg_321_1.duration_ = 8.3

		local var_321_0 = {
			zh = 4.6,
			ja = 8.3
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
				arg_321_0:Play319681076(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.var_.moveOldPos10079ui_story = arg_321_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_324_0 = 0.001

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 then
				arg_321_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_321_1.time_ - 0) / var_324_0)
				arg_321_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10079ui_story"].transform.position).z)
				arg_321_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["10079ui_story"].transform.localEulerAngles = arg_321_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 then
				arg_321_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_321_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_321_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_321_1.actors_["10079ui_story"].transform.position).z)
				arg_321_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_321_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_321_1.actors_["10079ui_story"].transform.localEulerAngles = arg_321_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_324_1 = arg_321_1.actors_["10079ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect10079ui_story == nil then
				arg_321_1.var_.characterEffect10079ui_story = var_324_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_2 and not isNil(var_324_1) then
				if arg_321_1.var_.characterEffect10079ui_story and not isNil(var_324_1) then
					arg_321_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_2 and arg_321_1.time_ < 0 + var_324_2 + arg_324_0 and not isNil(var_324_1) and arg_321_1.var_.characterEffect10079ui_story then
				arg_321_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_324_4 = arg_321_1.actors_["1095ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_4) and arg_321_1.var_.characterEffect1095ui_story == nil then
				arg_321_1.var_.characterEffect1095ui_story = var_324_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_5 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_5 and not isNil(var_324_4) then
				if arg_321_1.var_.characterEffect1095ui_story and not isNil(var_324_4) then
					arg_321_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_5)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_5 and arg_321_1.time_ < 0 + var_324_5 + arg_324_0 and not isNil(var_324_4) and arg_321_1.var_.characterEffect1095ui_story then
				arg_321_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_324_6 = 0
			local var_324_7 = 0.45

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_6 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_8 = arg_321_1:GetWordFromCfg(319681075)
				local var_324_9 = arg_321_1:FormatText(var_324_8.content)

				arg_321_1.text_.text = var_324_9

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_11 = 18 <= 0 and var_324_7 or var_324_7 * (utf8.len(var_324_9) / 18)

				if (18 <= 0 and var_324_7 or var_324_7 * (utf8.len(var_324_9) / 18)) > 0 and var_324_7 < var_324_11 then
					arg_321_1.talkMaxDuration = var_324_11

					if var_324_11 + var_324_6 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_11 + var_324_6
					end
				end

				arg_321_1.text_.text = var_324_9
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681075", "story_v_out_319681.awb") ~= 0 then
					local var_324_12 = manager.audio:GetVoiceLength("story_v_out_319681", "319681075", "story_v_out_319681.awb") / 1000

					if var_324_12 + var_324_6 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_12 + var_324_6
					end

					if var_324_8.prefab_name ~= "" and arg_321_1.actors_[var_324_8.prefab_name] ~= nil then
						local var_324_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_8.prefab_name].transform, "story_v_out_319681", "319681075", "story_v_out_319681.awb")

						arg_321_1:RecordAudio("319681075", var_324_13)
						arg_321_1:RecordAudio("319681075", var_324_13)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_319681", "319681075", "story_v_out_319681.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_319681", "319681075", "story_v_out_319681.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_14 = math.max(var_324_7, arg_321_1.talkMaxDuration)

			if var_324_6 <= arg_321_1.time_ and arg_321_1.time_ < var_324_6 + var_324_14 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_6) / var_324_14

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_6 + var_324_14 and arg_321_1.time_ < var_324_6 + var_324_14 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
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
	Play319681076 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 319681076
		arg_325_1.duration_ = 10.63

		local var_325_0 = {
			zh = 7.2,
			ja = 10.633
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play319681077(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.var_.moveOldPos1095ui_story = arg_325_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_328_0 = 0.001

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 then
				arg_325_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_325_1.time_ - 0) / var_328_0)
				arg_325_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1095ui_story"].transform.position).z)
				arg_325_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1095ui_story"].transform.localEulerAngles = arg_325_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 then
				arg_325_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_325_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_325_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_325_1.actors_["1095ui_story"].transform.position).z)
				arg_325_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_325_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_325_1.actors_["1095ui_story"].transform.localEulerAngles = arg_325_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_328_1 = arg_325_1.actors_["1095ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1095ui_story == nil then
				arg_325_1.var_.characterEffect1095ui_story = var_328_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_2 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_2 and not isNil(var_328_1) then
				if arg_325_1.var_.characterEffect1095ui_story and not isNil(var_328_1) then
					arg_325_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_325_1.time_ >= 0 + var_328_2 and arg_325_1.time_ < 0 + var_328_2 + arg_328_0 and not isNil(var_328_1) and arg_325_1.var_.characterEffect1095ui_story then
				arg_325_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_328_4 = arg_325_1.actors_["10079ui_story"]

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(var_328_4) and arg_325_1.var_.characterEffect10079ui_story == nil then
				arg_325_1.var_.characterEffect10079ui_story = var_328_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_328_5 = 0.200000002980232

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_5 and not isNil(var_328_4) then
				if arg_325_1.var_.characterEffect10079ui_story and not isNil(var_328_4) then
					arg_325_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_325_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_325_1.time_ - 0) / var_328_5)
				end
			end

			if arg_325_1.time_ >= 0 + var_328_5 and arg_325_1.time_ < 0 + var_328_5 + arg_328_0 and not isNil(var_328_4) and arg_325_1.var_.characterEffect10079ui_story then
				arg_325_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_325_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_328_6 = 0
			local var_328_7 = 1

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_6 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_8 = arg_325_1:GetWordFromCfg(319681076)
				local var_328_9 = arg_325_1:FormatText(var_328_8.content)

				arg_325_1.text_.text = var_328_9

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_11 = 40 <= 0 and var_328_7 or var_328_7 * (utf8.len(var_328_9) / 40)

				if (40 <= 0 and var_328_7 or var_328_7 * (utf8.len(var_328_9) / 40)) > 0 and var_328_7 < var_328_11 then
					arg_325_1.talkMaxDuration = var_328_11

					if var_328_11 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_11 + var_328_6
					end
				end

				arg_325_1.text_.text = var_328_9
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681076", "story_v_out_319681.awb") ~= 0 then
					local var_328_12 = manager.audio:GetVoiceLength("story_v_out_319681", "319681076", "story_v_out_319681.awb") / 1000

					if var_328_12 + var_328_6 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_12 + var_328_6
					end

					if var_328_8.prefab_name ~= "" and arg_325_1.actors_[var_328_8.prefab_name] ~= nil then
						local var_328_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_8.prefab_name].transform, "story_v_out_319681", "319681076", "story_v_out_319681.awb")

						arg_325_1:RecordAudio("319681076", var_328_13)
						arg_325_1:RecordAudio("319681076", var_328_13)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_319681", "319681076", "story_v_out_319681.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_319681", "319681076", "story_v_out_319681.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_14 = math.max(var_328_7, arg_325_1.talkMaxDuration)

			if var_328_6 <= arg_325_1.time_ and arg_325_1.time_ < var_328_6 + var_328_14 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_6) / var_328_14

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_6 + var_328_14 and arg_325_1.time_ < var_328_6 + var_328_14 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_325_1:InitPlayNodeList()
	end,
	Play319681077 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 319681077
		arg_329_1.duration_ = 8.7

		local var_329_0 = {
			zh = 8.7,
			ja = 4.333
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
				arg_329_0:Play319681078(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_332_0 = 0
			local var_332_1 = 1.075

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_2 = arg_329_1:GetWordFromCfg(319681077)
				local var_332_3 = arg_329_1:FormatText(var_332_2.content)

				arg_329_1.text_.text = var_332_3

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 43 <= 0 and var_332_1 or var_332_1 * (utf8.len(var_332_3) / 43)

				if (43 <= 0 and var_332_1 or var_332_1 * (utf8.len(var_332_3) / 43)) > 0 and var_332_1 < var_332_5 then
					arg_329_1.talkMaxDuration = var_332_5

					if var_332_5 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + var_332_0
					end
				end

				arg_329_1.text_.text = var_332_3
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681077", "story_v_out_319681.awb") ~= 0 then
					local var_332_6 = manager.audio:GetVoiceLength("story_v_out_319681", "319681077", "story_v_out_319681.awb") / 1000

					if var_332_6 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_6 + var_332_0
					end

					if var_332_2.prefab_name ~= "" and arg_329_1.actors_[var_332_2.prefab_name] ~= nil then
						local var_332_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_2.prefab_name].transform, "story_v_out_319681", "319681077", "story_v_out_319681.awb")

						arg_329_1:RecordAudio("319681077", var_332_7)
						arg_329_1:RecordAudio("319681077", var_332_7)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_319681", "319681077", "story_v_out_319681.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_319681", "319681077", "story_v_out_319681.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_8 = math.max(var_332_1, arg_329_1.talkMaxDuration)

			if var_332_0 <= arg_329_1.time_ and arg_329_1.time_ < var_332_0 + var_332_8 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_0) / var_332_8

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_0 + var_332_8 and arg_329_1.time_ < var_332_0 + var_332_8 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play319681078 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 319681078
		arg_333_1.duration_ = 1.97

		local var_333_0 = {
			zh = 1.966,
			ja = 1.9
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
				arg_333_0:Play319681079(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["10079ui_story"]) and arg_333_1.var_.characterEffect10079ui_story == nil then
				arg_333_1.var_.characterEffect10079ui_story = arg_333_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["10079ui_story"]) then
				if arg_333_1.var_.characterEffect10079ui_story and not isNil(arg_333_1.actors_["10079ui_story"]) then
					arg_333_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["10079ui_story"]) and arg_333_1.var_.characterEffect10079ui_story then
				arg_333_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_336_2 = arg_333_1.actors_["1095ui_story"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.characterEffect1095ui_story == nil then
				arg_333_1.var_.characterEffect1095ui_story = var_336_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_3 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_3 and not isNil(var_336_2) then
				if arg_333_1.var_.characterEffect1095ui_story and not isNil(var_336_2) then
					arg_333_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_3)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_3 and arg_333_1.time_ < 0 + var_336_3 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.characterEffect1095ui_story then
				arg_333_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_336_4 = 0
			local var_336_5 = 0.2

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_4 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_6 = arg_333_1:GetWordFromCfg(319681078)
				local var_336_7 = arg_333_1:FormatText(var_336_6.content)

				arg_333_1.text_.text = var_336_7

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_9 = 8 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 8)

				if (8 <= 0 and var_336_5 or var_336_5 * (utf8.len(var_336_7) / 8)) > 0 and var_336_5 < var_336_9 then
					arg_333_1.talkMaxDuration = var_336_9

					if var_336_9 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_9 + var_336_4
					end
				end

				arg_333_1.text_.text = var_336_7
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681078", "story_v_out_319681.awb") ~= 0 then
					local var_336_10 = manager.audio:GetVoiceLength("story_v_out_319681", "319681078", "story_v_out_319681.awb") / 1000

					if var_336_10 + var_336_4 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_10 + var_336_4
					end

					if var_336_6.prefab_name ~= "" and arg_333_1.actors_[var_336_6.prefab_name] ~= nil then
						local var_336_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_6.prefab_name].transform, "story_v_out_319681", "319681078", "story_v_out_319681.awb")

						arg_333_1:RecordAudio("319681078", var_336_11)
						arg_333_1:RecordAudio("319681078", var_336_11)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_319681", "319681078", "story_v_out_319681.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_319681", "319681078", "story_v_out_319681.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_12 = math.max(var_336_5, arg_333_1.talkMaxDuration)

			if var_336_4 <= arg_333_1.time_ and arg_333_1.time_ < var_336_4 + var_336_12 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_4) / var_336_12

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_4 + var_336_12 and arg_333_1.time_ < var_336_4 + var_336_12 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play319681079 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 319681079
		arg_337_1.duration_ = 14.3

		local var_337_0 = {
			zh = 10.033,
			ja = 14.3
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
				arg_337_0:Play319681080(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1095ui_story"]) and arg_337_1.var_.characterEffect1095ui_story == nil then
				arg_337_1.var_.characterEffect1095ui_story = arg_337_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1095ui_story"]) then
				if arg_337_1.var_.characterEffect1095ui_story and not isNil(arg_337_1.actors_["1095ui_story"]) then
					arg_337_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1095ui_story"]) and arg_337_1.var_.characterEffect1095ui_story then
				arg_337_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_340_2 = arg_337_1.actors_["10079ui_story"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_2) and arg_337_1.var_.characterEffect10079ui_story == nil then
				arg_337_1.var_.characterEffect10079ui_story = var_340_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_3 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_3 and not isNil(var_340_2) then
				if arg_337_1.var_.characterEffect10079ui_story and not isNil(var_340_2) then
					arg_337_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_337_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_337_1.time_ - 0) / var_340_3)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_3 and arg_337_1.time_ < 0 + var_340_3 + arg_340_0 and not isNil(var_340_2) and arg_337_1.var_.characterEffect10079ui_story then
				arg_337_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_337_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_340_4 = 0
			local var_340_5 = 1.2

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_4 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_6 = arg_337_1:GetWordFromCfg(319681079)
				local var_340_7 = arg_337_1:FormatText(var_340_6.content)

				arg_337_1.text_.text = var_340_7

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_9 = 48 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_7) / 48)

				if (48 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_7) / 48)) > 0 and var_340_5 < var_340_9 then
					arg_337_1.talkMaxDuration = var_340_9

					if var_340_9 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_9 + var_340_4
					end
				end

				arg_337_1.text_.text = var_340_7
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681079", "story_v_out_319681.awb") ~= 0 then
					local var_340_10 = manager.audio:GetVoiceLength("story_v_out_319681", "319681079", "story_v_out_319681.awb") / 1000

					if var_340_10 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_10 + var_340_4
					end

					if var_340_6.prefab_name ~= "" and arg_337_1.actors_[var_340_6.prefab_name] ~= nil then
						local var_340_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_6.prefab_name].transform, "story_v_out_319681", "319681079", "story_v_out_319681.awb")

						arg_337_1:RecordAudio("319681079", var_340_11)
						arg_337_1:RecordAudio("319681079", var_340_11)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_319681", "319681079", "story_v_out_319681.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_319681", "319681079", "story_v_out_319681.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_12 = math.max(var_340_5, arg_337_1.talkMaxDuration)

			if var_340_4 <= arg_337_1.time_ and arg_337_1.time_ < var_340_4 + var_340_12 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_4) / var_340_12

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_4 + var_340_12 and arg_337_1.time_ < var_340_4 + var_340_12 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play319681080 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 319681080
		arg_341_1.duration_ = 7.4

		local var_341_0 = {
			zh = 7.4,
			ja = 7.3
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
				arg_341_0:Play319681081(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0.95

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_1 = arg_341_1:GetWordFromCfg(319681080)
				local var_344_2 = arg_341_1:FormatText(var_344_1.content)

				arg_341_1.text_.text = var_344_2

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_4 = 38 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_2) / 38)

				if (38 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_2) / 38)) > 0 and var_344_0 < var_344_4 then
					arg_341_1.talkMaxDuration = var_344_4

					if var_344_4 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_4 + 0
					end
				end

				arg_341_1.text_.text = var_344_2
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681080", "story_v_out_319681.awb") ~= 0 then
					local var_344_5 = manager.audio:GetVoiceLength("story_v_out_319681", "319681080", "story_v_out_319681.awb") / 1000

					if var_344_5 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_5 + 0
					end

					if var_344_1.prefab_name ~= "" and arg_341_1.actors_[var_344_1.prefab_name] ~= nil then
						local var_344_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_1.prefab_name].transform, "story_v_out_319681", "319681080", "story_v_out_319681.awb")

						arg_341_1:RecordAudio("319681080", var_344_6)
						arg_341_1:RecordAudio("319681080", var_344_6)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_319681", "319681080", "story_v_out_319681.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_319681", "319681080", "story_v_out_319681.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_7 = math.max(var_344_0, arg_341_1.talkMaxDuration)

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_7 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - 0) / var_344_7

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= 0 + var_344_7 and arg_341_1.time_ < 0 + var_344_7 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play319681081 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 319681081
		arg_345_1.duration_ = 11.07

		local var_345_0 = {
			zh = 7.3,
			ja = 11.066
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
				arg_345_0:Play319681082(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos10079ui_story = arg_345_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_348_0 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 then
				arg_345_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_345_1.time_ - 0) / var_348_0)
				arg_345_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["10079ui_story"].transform.position).z)
				arg_345_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["10079ui_story"].transform.localEulerAngles = arg_345_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 then
				arg_345_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_345_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["10079ui_story"].transform.position).z)
				arg_345_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["10079ui_story"].transform.localEulerAngles = arg_345_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_348_1 = arg_345_1.actors_["10079ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect10079ui_story == nil then
				arg_345_1.var_.characterEffect10079ui_story = var_348_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_2 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_2 and not isNil(var_348_1) then
				if arg_345_1.var_.characterEffect10079ui_story and not isNil(var_348_1) then
					arg_345_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 0 + var_348_2 and arg_345_1.time_ < 0 + var_348_2 + arg_348_0 and not isNil(var_348_1) and arg_345_1.var_.characterEffect10079ui_story then
				arg_345_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_348_4 = arg_345_1.actors_["1095ui_story"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_4) and arg_345_1.var_.characterEffect1095ui_story == nil then
				arg_345_1.var_.characterEffect1095ui_story = var_348_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_5 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_5 and not isNil(var_348_4) then
				if arg_345_1.var_.characterEffect1095ui_story and not isNil(var_348_4) then
					arg_345_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_345_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_345_1.time_ - 0) / var_348_5)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_5 and arg_345_1.time_ < 0 + var_348_5 + arg_348_0 and not isNil(var_348_4) and arg_345_1.var_.characterEffect1095ui_story then
				arg_345_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_345_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_348_6 = 0
			local var_348_7 = 0.75

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_6 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_8 = arg_345_1:GetWordFromCfg(319681081)
				local var_348_9 = arg_345_1:FormatText(var_348_8.content)

				arg_345_1.text_.text = var_348_9

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_11 = 30 <= 0 and var_348_7 or var_348_7 * (utf8.len(var_348_9) / 30)

				if (30 <= 0 and var_348_7 or var_348_7 * (utf8.len(var_348_9) / 30)) > 0 and var_348_7 < var_348_11 then
					arg_345_1.talkMaxDuration = var_348_11

					if var_348_11 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_11 + var_348_6
					end
				end

				arg_345_1.text_.text = var_348_9
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681081", "story_v_out_319681.awb") ~= 0 then
					local var_348_12 = manager.audio:GetVoiceLength("story_v_out_319681", "319681081", "story_v_out_319681.awb") / 1000

					if var_348_12 + var_348_6 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_12 + var_348_6
					end

					if var_348_8.prefab_name ~= "" and arg_345_1.actors_[var_348_8.prefab_name] ~= nil then
						local var_348_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_8.prefab_name].transform, "story_v_out_319681", "319681081", "story_v_out_319681.awb")

						arg_345_1:RecordAudio("319681081", var_348_13)
						arg_345_1:RecordAudio("319681081", var_348_13)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_319681", "319681081", "story_v_out_319681.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_319681", "319681081", "story_v_out_319681.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_14 = math.max(var_348_7, arg_345_1.talkMaxDuration)

			if var_348_6 <= arg_345_1.time_ and arg_345_1.time_ < var_348_6 + var_348_14 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_6) / var_348_14

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_6 + var_348_14 and arg_345_1.time_ < var_348_6 + var_348_14 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play319681082 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 319681082
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play319681083(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(arg_349_1.actors_["10079ui_story"]) and arg_349_1.var_.characterEffect10079ui_story == nil then
				arg_349_1.var_.characterEffect10079ui_story = arg_349_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_0 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 and not isNil(arg_349_1.actors_["10079ui_story"]) then
				if arg_349_1.var_.characterEffect10079ui_story and not isNil(arg_349_1.actors_["10079ui_story"]) then
					arg_349_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_349_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_349_1.time_ - 0) / var_352_0)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 and not isNil(arg_349_1.actors_["10079ui_story"]) and arg_349_1.var_.characterEffect10079ui_story then
				arg_349_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_349_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_352_1 = 0
			local var_352_2 = 1.125

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_3 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(319681082).content)

				arg_349_1.text_.text = var_352_3

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_5 = 45 <= 0 and var_352_2 or var_352_2 * (utf8.len(var_352_3) / 45)

				if (45 <= 0 and var_352_2 or var_352_2 * (utf8.len(var_352_3) / 45)) > 0 and var_352_2 < var_352_5 then
					arg_349_1.talkMaxDuration = var_352_5

					if var_352_5 + var_352_1 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_5 + var_352_1
					end
				end

				arg_349_1.text_.text = var_352_3
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_6 = math.max(var_352_2, arg_349_1.talkMaxDuration)

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_6 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_1) / var_352_6

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_1 + var_352_6 and arg_349_1.time_ < var_352_1 + var_352_6 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play319681083 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 319681083
		arg_353_1.duration_ = 3.7

		local var_353_0 = {
			zh = 2.566,
			ja = 3.7
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
				arg_353_0:Play319681084(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos1095ui_story = arg_353_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_356_0 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 then
				arg_353_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_353_1.time_ - 0) / var_356_0)
				arg_353_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1095ui_story"].transform.position).z)
				arg_353_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1095ui_story"].transform.localEulerAngles = arg_353_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 then
				arg_353_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_353_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1095ui_story"].transform.position).z)
				arg_353_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1095ui_story"].transform.localEulerAngles = arg_353_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_356_1 = arg_353_1.actors_["1095ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1095ui_story == nil then
				arg_353_1.var_.characterEffect1095ui_story = var_356_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_2 and not isNil(var_356_1) then
				if arg_353_1.var_.characterEffect1095ui_story and not isNil(var_356_1) then
					arg_353_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= 0 + var_356_2 and arg_353_1.time_ < 0 + var_356_2 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1095ui_story then
				arg_353_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_356_4 = 0
			local var_356_5 = 0.275

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_4 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_6 = arg_353_1:GetWordFromCfg(319681083)
				local var_356_7 = arg_353_1:FormatText(var_356_6.content)

				arg_353_1.text_.text = var_356_7

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_9 = 11 <= 0 and var_356_5 or var_356_5 * (utf8.len(var_356_7) / 11)

				if (11 <= 0 and var_356_5 or var_356_5 * (utf8.len(var_356_7) / 11)) > 0 and var_356_5 < var_356_9 then
					arg_353_1.talkMaxDuration = var_356_9

					if var_356_9 + var_356_4 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_9 + var_356_4
					end
				end

				arg_353_1.text_.text = var_356_7
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681083", "story_v_out_319681.awb") ~= 0 then
					local var_356_10 = manager.audio:GetVoiceLength("story_v_out_319681", "319681083", "story_v_out_319681.awb") / 1000

					if var_356_10 + var_356_4 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_10 + var_356_4
					end

					if var_356_6.prefab_name ~= "" and arg_353_1.actors_[var_356_6.prefab_name] ~= nil then
						local var_356_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_6.prefab_name].transform, "story_v_out_319681", "319681083", "story_v_out_319681.awb")

						arg_353_1:RecordAudio("319681083", var_356_11)
						arg_353_1:RecordAudio("319681083", var_356_11)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_319681", "319681083", "story_v_out_319681.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_319681", "319681083", "story_v_out_319681.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_12 = math.max(var_356_5, arg_353_1.talkMaxDuration)

			if var_356_4 <= arg_353_1.time_ and arg_353_1.time_ < var_356_4 + var_356_12 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_4) / var_356_12

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_4 + var_356_12 and arg_353_1.time_ < var_356_4 + var_356_12 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play319681084 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 319681084
		arg_357_1.duration_ = 4.97

		local var_357_0 = {
			zh = 3.966,
			ja = 4.966
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
			arg_357_1.auto_ = false
		end

		function arg_357_1.playNext_(arg_359_0)
			arg_357_1.onStoryFinished_()
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0.35

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_1 = arg_357_1:GetWordFromCfg(319681084)
				local var_360_2 = arg_357_1:FormatText(var_360_1.content)

				arg_357_1.text_.text = var_360_2

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_4 = 14 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_2) / 14)

				if (14 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_2) / 14)) > 0 and var_360_0 < var_360_4 then
					arg_357_1.talkMaxDuration = var_360_4

					if var_360_4 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_4 + 0
					end
				end

				arg_357_1.text_.text = var_360_2
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319681", "319681084", "story_v_out_319681.awb") ~= 0 then
					local var_360_5 = manager.audio:GetVoiceLength("story_v_out_319681", "319681084", "story_v_out_319681.awb") / 1000

					if var_360_5 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_5 + 0
					end

					if var_360_1.prefab_name ~= "" and arg_357_1.actors_[var_360_1.prefab_name] ~= nil then
						local var_360_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_1.prefab_name].transform, "story_v_out_319681", "319681084", "story_v_out_319681.awb")

						arg_357_1:RecordAudio("319681084", var_360_6)
						arg_357_1:RecordAudio("319681084", var_360_6)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_319681", "319681084", "story_v_out_319681.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_319681", "319681084", "story_v_out_319681.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_7 = math.max(var_360_0, arg_357_1.talkMaxDuration)

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_7 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - 0) / var_360_7

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= 0 + var_360_7 and arg_357_1.time_ < 0 + var_360_7 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/XH0407a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/D10",
		"TextureConfig/Background/ST69"
	},
	voices = {
		"story_v_out_319681.awb"
	}
}
