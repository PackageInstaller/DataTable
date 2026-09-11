return {
	Play921011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 921011001
		arg_1_1.duration_ = 5.47

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play921011002(arg_1_1)
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
				if arg_1_0.sceneSettingEffect_ then
					arg_1_1.sceneSettingEffect_.enabled = false
				end

				arg_1_1.sceneSettingGo_:SetActive(true)

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

			local var_4_6 = 1.16666666666667

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

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.466666666666667 + arg_4_0 then
				local var_4_12 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_13 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_14 = var_4_12:GetComponent("RectTransform")

				var_4_12:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_14.offsetMin = Vector2.New(0, -27.17)
				var_4_14.offsetMax = Vector2.New(0, -39.2)
			end

			local var_4_15 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_15 + 1.36666666666667 and arg_1_1.time_ < var_4_15 + 1.36666666666667 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0
				arg_1_1.fswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(921011001).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_16 = 0.466666666666667

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_17 = 40
			local var_4_18 = 2
			local var_4_19, var_4_20 = arg_1_1:GetPercentByPara(arg_1_1:FormatText(arg_1_1:GetWordFromCfg(921011001).content), 1)

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

			local var_4_22 = math.max(2, arg_1_1.talkMaxDuration)

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

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.466666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_137", "se_story_137_city", "")
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play921011002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 921011002
		arg_6_1.duration_ = 1.4

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play921011003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_0 = 28
			local var_9_1 = 1.4
			local var_9_2, var_9_3 = arg_6_1:GetPercentByPara(arg_6_1:FormatText(arg_6_1:GetWordFromCfg(921011001).content), 2)

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

			local var_9_5 = math.max(1.4, arg_6_1.talkMaxDuration)

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

			local var_9_6 = 0.466666666666667

			if 0.466666666666667 < arg_6_1.time_ and arg_6_1.time_ <= var_9_6 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_7 = 0
			local var_9_8 = 0
			local var_9_9, var_9_10 = arg_6_1:GetPercentByPara(arg_6_1:FormatText(arg_6_1:GetWordFromCfg(921011001).content), 1)

			if var_9_6 < arg_6_1.time_ and arg_6_1.time_ <= var_9_6 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				local var_9_11 = var_9_7 <= 0 and var_9_8 or var_9_8 * ((var_9_10 - arg_6_1.typewritterCharCountI18N) / var_9_7)

				if (var_9_7 <= 0 and var_9_8 or var_9_8 * ((var_9_10 - arg_6_1.typewritterCharCountI18N) / var_9_7)) > 0 and var_9_8 < var_9_11 then
					arg_6_1.talkMaxDuration = var_9_11

					if var_9_11 + var_9_6 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_11 + var_9_6
					end
				end
			end

			local var_9_12 = math.max(0, arg_6_1.talkMaxDuration)

			if var_9_6 <= arg_6_1.time_ and arg_6_1.time_ < var_9_6 + var_9_12 then
				arg_6_1.fswtw_.percent = Mathf.Lerp(arg_6_1.var_.oldValueTypewriter, var_9_9, (arg_6_1.time_ - var_9_6) / var_9_12)
				arg_6_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_6_1.fswtw_:SetDirty()
			end

			if arg_6_1.time_ >= var_9_6 + var_9_12 and arg_6_1.time_ < var_9_6 + var_9_12 + arg_9_0 then
				arg_6_1.fswtw_.percent = var_9_9

				arg_6_1.fswtw_:SetDirty()
				arg_6_1:ShowNextGo(true)

				arg_6_1.typewritterCharCountI18N = var_9_10
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play921011003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 921011003
		arg_10_1.duration_ = 1.44

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play921011004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_0 = 26
			local var_13_1 = 1.44444444444444
			local var_13_2, var_13_3 = arg_10_1:GetPercentByPara(arg_10_1:FormatText(arg_10_1:GetWordFromCfg(921011001).content), 3)

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

			local var_13_5 = math.max(1.44444444444444, arg_10_1.talkMaxDuration)

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

			local var_13_6 = 0.466666666666667

			if 0.466666666666667 < arg_10_1.time_ and arg_10_1.time_ <= var_13_6 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_7 = 0
			local var_13_8 = 0
			local var_13_9, var_13_10 = arg_10_1:GetPercentByPara(arg_10_1:FormatText(arg_10_1:GetWordFromCfg(921011001).content), 1)

			if var_13_6 < arg_10_1.time_ and arg_10_1.time_ <= var_13_6 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0

				local var_13_11 = var_13_7 <= 0 and var_13_8 or var_13_8 * ((var_13_10 - arg_10_1.typewritterCharCountI18N) / var_13_7)

				if (var_13_7 <= 0 and var_13_8 or var_13_8 * ((var_13_10 - arg_10_1.typewritterCharCountI18N) / var_13_7)) > 0 and var_13_8 < var_13_11 then
					arg_10_1.talkMaxDuration = var_13_11

					if var_13_11 + var_13_6 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_11 + var_13_6
					end
				end
			end

			local var_13_12 = math.max(0, arg_10_1.talkMaxDuration)

			if var_13_6 <= arg_10_1.time_ and arg_10_1.time_ < var_13_6 + var_13_12 then
				arg_10_1.fswtw_.percent = Mathf.Lerp(arg_10_1.var_.oldValueTypewriter, var_13_9, (arg_10_1.time_ - var_13_6) / var_13_12)
				arg_10_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_10_1.fswtw_:SetDirty()
			end

			if arg_10_1.time_ >= var_13_6 + var_13_12 and arg_10_1.time_ < var_13_6 + var_13_12 + arg_13_0 then
				arg_10_1.fswtw_.percent = var_13_9

				arg_10_1.fswtw_:SetDirty()
				arg_10_1:ShowNextGo(true)

				arg_10_1.typewritterCharCountI18N = var_13_10
			end
		end

		arg_10_1.nodeConfigList_ = {}

		arg_10_1:InitPlayNodeList()
	end,
	Play921011004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 921011004
		arg_14_1.duration_ = 1.72

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play921011005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_0 = 31
			local var_17_1 = 1.72222222222222
			local var_17_2, var_17_3 = arg_14_1:GetPercentByPara(arg_14_1:FormatText(arg_14_1:GetWordFromCfg(921011001).content), 4)

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

			local var_17_5 = math.max(1.72222222222222, arg_14_1.talkMaxDuration)

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

			local var_17_6 = 0.466666666666667

			if 0.466666666666667 < arg_14_1.time_ and arg_14_1.time_ <= var_17_6 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_7 = 0
			local var_17_8 = 0
			local var_17_9, var_17_10 = arg_14_1:GetPercentByPara(arg_14_1:FormatText(arg_14_1:GetWordFromCfg(921011001).content), 1)

			if var_17_6 < arg_14_1.time_ and arg_14_1.time_ <= var_17_6 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				local var_17_11 = var_17_7 <= 0 and var_17_8 or var_17_8 * ((var_17_10 - arg_14_1.typewritterCharCountI18N) / var_17_7)

				if (var_17_7 <= 0 and var_17_8 or var_17_8 * ((var_17_10 - arg_14_1.typewritterCharCountI18N) / var_17_7)) > 0 and var_17_8 < var_17_11 then
					arg_14_1.talkMaxDuration = var_17_11

					if var_17_11 + var_17_6 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_11 + var_17_6
					end
				end
			end

			local var_17_12 = math.max(0, arg_14_1.talkMaxDuration)

			if var_17_6 <= arg_14_1.time_ and arg_14_1.time_ < var_17_6 + var_17_12 then
				arg_14_1.fswtw_.percent = Mathf.Lerp(arg_14_1.var_.oldValueTypewriter, var_17_9, (arg_14_1.time_ - var_17_6) / var_17_12)
				arg_14_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_14_1.fswtw_:SetDirty()
			end

			if arg_14_1.time_ >= var_17_6 + var_17_12 and arg_14_1.time_ < var_17_6 + var_17_12 + arg_17_0 then
				arg_14_1.fswtw_.percent = var_17_9

				arg_14_1.fswtw_:SetDirty()
				arg_14_1:ShowNextGo(true)

				arg_14_1.typewritterCharCountI18N = var_17_10
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play921011005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 921011005
		arg_18_1.duration_ = 3.4

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play921011006(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.var_.oldValueTypewriter = arg_18_1.fswtw_.percent

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_0 = 68
			local var_21_1 = 3.4
			local var_21_2, var_21_3 = arg_18_1:GetPercentByPara(arg_18_1:FormatText(arg_18_1:GetWordFromCfg(921011001).content), 5)

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

			local var_21_5 = math.max(3.4, arg_18_1.talkMaxDuration)

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

			local var_21_6 = 0.466666666666667

			if 0.466666666666667 < arg_18_1.time_ and arg_18_1.time_ <= var_21_6 + arg_21_0 then
				arg_18_1.var_.oldValueTypewriter = arg_18_1.fswtw_.percent

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_7 = 0
			local var_21_8 = 0
			local var_21_9, var_21_10 = arg_18_1:GetPercentByPara(arg_18_1:FormatText(arg_18_1:GetWordFromCfg(921011001).content), 1)

			if var_21_6 < arg_18_1.time_ and arg_18_1.time_ <= var_21_6 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				local var_21_11 = var_21_7 <= 0 and var_21_8 or var_21_8 * ((var_21_10 - arg_18_1.typewritterCharCountI18N) / var_21_7)

				if (var_21_7 <= 0 and var_21_8 or var_21_8 * ((var_21_10 - arg_18_1.typewritterCharCountI18N) / var_21_7)) > 0 and var_21_8 < var_21_11 then
					arg_18_1.talkMaxDuration = var_21_11

					if var_21_11 + var_21_6 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_11 + var_21_6
					end
				end
			end

			local var_21_12 = math.max(0, arg_18_1.talkMaxDuration)

			if var_21_6 <= arg_18_1.time_ and arg_18_1.time_ < var_21_6 + var_21_12 then
				arg_18_1.fswtw_.percent = Mathf.Lerp(arg_18_1.var_.oldValueTypewriter, var_21_9, (arg_18_1.time_ - var_21_6) / var_21_12)
				arg_18_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_18_1.fswtw_:SetDirty()
			end

			if arg_18_1.time_ >= var_21_6 + var_21_12 and arg_18_1.time_ < var_21_6 + var_21_12 + arg_21_0 then
				arg_18_1.fswtw_.percent = var_21_9

				arg_18_1.fswtw_:SetDirty()
				arg_18_1:ShowNextGo(true)

				arg_18_1.typewritterCharCountI18N = var_21_10
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play921011006 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 921011006
		arg_22_1.duration_ = 8.43

		local var_22_0 = {
			zh = 8.433,
			ja = 7.1
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play921011007(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if arg_22_1.bgs_.ST60 == nil then
				local var_25_0 = Object.Instantiate(arg_22_1.paintGo_)

				var_25_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST60")
				var_25_0.name = "ST60"
				var_25_0.transform.parent = arg_22_1.stage_.transform
				var_25_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_22_1.bgs_.ST60 = var_25_0
			end

			if 1 < arg_22_1.time_ and arg_22_1.time_ <= 1 + arg_25_0 then
				if arg_22_0.sceneSettingEffect_ then
					arg_22_1.sceneSettingEffect_.enabled = false
				end

				arg_22_1.sceneSettingGo_:SetActive(true)

				local var_25_1 = arg_22_1.bgs_.ST60

				arg_22_1.bgs_.ST60.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_25_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_25_2 = var_25_1:GetComponent("SpriteRenderer")

				if var_25_2 and var_25_2.sprite then
					local var_25_3 = 2 * (var_25_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_25_1.transform.localScale = Vector3.New(var_25_3 / var_25_2.sprite.bounds.size.y < var_25_3 * manager.ui.mainCameraCom_.aspect / var_25_2.sprite.bounds.size.x and var_25_3 * manager.ui.mainCameraCom_.aspect / var_25_2.sprite.bounds.size.x or var_25_3 / var_25_2.sprite.bounds.size.y, var_25_3 / var_25_2.sprite.bounds.size.y < var_25_3 * manager.ui.mainCameraCom_.aspect / var_25_2.sprite.bounds.size.x and var_25_3 * manager.ui.mainCameraCom_.aspect / var_25_2.sprite.bounds.size.x or var_25_3 / var_25_2.sprite.bounds.size.y, 0)
				end

				for iter_25_0, iter_25_1 in pairs(arg_22_1.bgs_) do
					if iter_25_0 ~= "ST60" then
						iter_25_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_25_4 = 0

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_4 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_5 = 1

			if var_25_4 <= arg_22_1.time_ and arg_22_1.time_ < var_25_4 + var_25_5 then
				local var_25_6 = Color.New(0, 0, 0)

				var_25_6.a = Mathf.Lerp(0, 1, (arg_22_1.time_ - var_25_4) / var_25_5)
				arg_22_1.mask_.color = var_25_6
			end

			if arg_22_1.time_ >= var_25_4 + var_25_5 and arg_22_1.time_ < var_25_4 + var_25_5 + arg_25_0 then
				local var_25_7 = Color.New(0, 0, 0)

				var_25_7.a = 1
				arg_22_1.mask_.color = var_25_7
			end

			local var_25_8 = 1

			if 1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_8 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_9 = 2

			if var_25_8 <= arg_22_1.time_ and arg_22_1.time_ < var_25_8 + var_25_9 then
				local var_25_10 = Color.New(0, 0, 0)

				var_25_10.a = Mathf.Lerp(1, 0, (arg_22_1.time_ - var_25_8) / var_25_9)
				arg_22_1.mask_.color = var_25_10
			end

			if arg_22_1.time_ >= var_25_8 + var_25_9 and arg_22_1.time_ < var_25_8 + var_25_9 + arg_25_0 then
				local var_25_11 = Color.New(0, 0, 0)

				arg_22_1.mask_.enabled = false
				var_25_11.a = 0
				arg_22_1.mask_.color = var_25_11
			end

			local var_25_12 = "1066ui_story"

			if arg_22_1.actors_["1066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1066ui_story"))) then
				local var_25_13 = Object.Instantiate(Asset.Load("Char/" .. "1066ui_story"), arg_22_1.stage_.transform)

				var_25_13.name = var_25_12
				var_25_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_22_1.actors_[var_25_12] = var_25_13

				local var_25_14 = var_25_13:GetComponentInChildren(typeof(CharacterEffect))

				var_25_14.enabled = true

				local var_25_15 = GameObjectTools.GetOrAddComponent(var_25_13, typeof(DynamicBoneHelper))

				if var_25_15 then
					var_25_15:EnableDynamicBone(false)
				end

				arg_22_1:ShowWeapon(var_25_14.transform, false)

				arg_22_1.var_[var_25_12 .. "Animator"] = var_25_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_22_1.var_[var_25_12 .. "Animator"].applyRootMotion = true
				arg_22_1.var_[var_25_12 .. "LipSync"] = var_25_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_25_16 = arg_22_1.actors_["1066ui_story"].transform

			if 2.8 < arg_22_1.time_ and arg_22_1.time_ <= 2.8 + arg_25_0 then
				arg_22_1.var_.moveOldPos1066ui_story = var_25_16.localPosition

				arg_22_1:ShowWeapon(arg_22_1.var_["1066ui_story" .. "Animator"].transform, false)
			end

			local var_25_17 = 0.001

			if 2.8 <= arg_22_1.time_ and arg_22_1.time_ < 2.8 + var_25_17 then
				var_25_16.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_22_1.time_ - 2.8) / var_25_17)
				var_25_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_25_16.position).x, (manager.ui.mainCamera.transform.position - var_25_16.position).y, (manager.ui.mainCamera.transform.position - var_25_16.position).z)
				var_25_16.localEulerAngles.z = 0
				var_25_16.localEulerAngles.x = 0
				var_25_16.localEulerAngles = var_25_16.localEulerAngles
			end

			if arg_22_1.time_ >= 2.8 + var_25_17 and arg_22_1.time_ < 2.8 + var_25_17 + arg_25_0 then
				var_25_16.localPosition = Vector3.New(0, -0.77, -6.1)
				var_25_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_25_16.position).x, (manager.ui.mainCamera.transform.position - var_25_16.position).y, (manager.ui.mainCamera.transform.position - var_25_16.position).z)
				var_25_16.localEulerAngles.z = 0
				var_25_16.localEulerAngles.x = 0
				var_25_16.localEulerAngles = var_25_16.localEulerAngles
			end

			local var_25_18 = arg_22_1.actors_["1066ui_story"]

			if 2.8 < arg_22_1.time_ and arg_22_1.time_ <= 2.8 + arg_25_0 and not isNil(var_25_18) and arg_22_1.var_.characterEffect1066ui_story == nil then
				arg_22_1.var_.characterEffect1066ui_story = var_25_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_19 = 0.200000002980232

			if 2.8 <= arg_22_1.time_ and arg_22_1.time_ < 2.8 + var_25_19 and not isNil(var_25_18) then
				if arg_22_1.var_.characterEffect1066ui_story and not isNil(var_25_18) then
					arg_22_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_22_1.time_ >= 2.8 + var_25_19 and arg_22_1.time_ < 2.8 + var_25_19 + arg_25_0 and not isNil(var_25_18) and arg_22_1.var_.characterEffect1066ui_story then
				arg_22_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 2.8 < arg_22_1.time_ and arg_22_1.time_ <= 2.8 + arg_25_0 then
				arg_22_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			if 2.8 < arg_22_1.time_ and arg_22_1.time_ <= 2.8 + arg_25_0 then
				arg_22_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0.333333333333333 < arg_22_1.time_ and arg_22_1.time_ <= 0.333333333333333 + arg_25_0 then
				arg_22_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_25_23 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if "" ~= "" then
					if arg_22_1.bgmTxt_.text ~= var_25_23 and arg_22_1.bgmTxt_.text ~= "" then
						if arg_22_1.bgmTxt2_.text ~= "" then
							arg_22_1.bgmTxt_.text = arg_22_1.bgmTxt2_.text
						end

						arg_22_1.bgmTxt2_.text = var_25_23

						arg_22_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_22_1.bgmTxt_.text = var_25_23
						arg_22_1.bgmTxt2_.text = var_25_23
					end

					if arg_22_1.bgmTimer then
						arg_22_1.bgmTimer:Stop()

						arg_22_1.bgmTimer = nil
					end

					if arg_22_1.settingData.show_music_name == 1 then
						arg_22_1.musicController:SetSelectedState("show")
						arg_22_1.musicAnimator_:Play("open", 0, 0)

						if arg_22_1.settingData.music_time ~= 0 then
							arg_22_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_22_1.settingData.music_time), function()
								if arg_22_1 == nil or isNil(arg_22_1.bgmTxt_) then
									return
								end

								arg_22_1.musicController:SetSelectedState("hide")
								arg_22_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1 < arg_22_1.time_ and arg_22_1.time_ <= 1 + arg_25_0 then
				arg_22_1.fswbg_:SetActive(false)
				arg_22_1.dialog_:SetActive(false)
				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_22_1:ShowNextGo(false)
			end

			if 1.01666666666667 < arg_22_1.time_ and arg_22_1.time_ <= 1.01666666666667 + arg_25_0 then
				arg_22_1.fswbg_:SetActive(false)
				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_22_1:ShowNextGo(false)
			end

			if 0.633333333333333 < arg_22_1.time_ and arg_22_1.time_ <= 0.633333333333333 + arg_25_0 then
				arg_22_1:AudioAction("stop", "effect", "se_story_137", "se_story_137_city", "")
			end

			if arg_22_1.frameCnt_ <= 1 then
				arg_22_1.dialog_:SetActive(false)
			end

			local var_25_25 = 3
			local var_25_26 = 0.65

			if 3 < arg_22_1.time_ and arg_22_1.time_ <= var_25_25 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				arg_22_1.dialog_:SetActive(true)

				arg_22_1.dialogCg_.alpha = 0

				local var_25_27 = LeanTween.value(arg_22_1.dialog_, 0, 1, 0.3)

				var_25_27:setOnUpdate(LuaHelper.FloatAction(function(arg_27_0)
					arg_22_1.dialogCg_.alpha = arg_27_0
				end))
				var_25_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_22_1.dialog_)
					var_25_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_22_1.duration_ = arg_22_1.duration_ + 0.3

				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_28 = arg_22_1:GetWordFromCfg(921011006)
				local var_25_29 = arg_22_1:FormatText(var_25_28.content)

				arg_22_1.text_.text = var_25_29

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_31 = 26 <= 0 and var_25_26 or var_25_26 * (utf8.len(var_25_29) / 26)

				if (26 <= 0 and var_25_26 or var_25_26 * (utf8.len(var_25_29) / 26)) > 0 and var_25_26 < var_25_31 then
					arg_22_1.talkMaxDuration = var_25_31
					var_25_25 = var_25_25 + 0.3

					if var_25_31 + var_25_25 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_31 + var_25_25
					end
				end

				arg_22_1.text_.text = var_25_29
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011006", "story_v_side_old_921011.awb") ~= 0 then
					local var_25_32 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011006", "story_v_side_old_921011.awb") / 1000

					if var_25_32 + var_25_25 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_32 + var_25_25
					end

					if var_25_28.prefab_name ~= "" and arg_22_1.actors_[var_25_28.prefab_name] ~= nil then
						local var_25_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_28.prefab_name].transform, "story_v_side_old_921011", "921011006", "story_v_side_old_921011.awb")

						arg_22_1:RecordAudio("921011006", var_25_33)
						arg_22_1:RecordAudio("921011006", var_25_33)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011006", "story_v_side_old_921011.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011006", "story_v_side_old_921011.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_34 = var_25_25 + 0.3
			local var_25_35 = math.max(var_25_26, arg_22_1.talkMaxDuration)

			if var_25_25 + 0.3 <= arg_22_1.time_ and arg_22_1.time_ < var_25_34 + var_25_35 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_34) / var_25_35

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_34 + var_25_35 and arg_22_1.time_ < var_25_34 + var_25_35 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play921011007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 921011007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play921011008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1066ui_story"]) and arg_29_1.var_.characterEffect1066ui_story == nil then
				arg_29_1.var_.characterEffect1066ui_story = arg_29_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1066ui_story"]) then
				if arg_29_1.var_.characterEffect1066ui_story and not isNil(arg_29_1.actors_["1066ui_story"]) then
					arg_29_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1066ui_story"]) and arg_29_1.var_.characterEffect1066ui_story then
				arg_29_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_32_1 = 0
			local var_32_2 = 0.325

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(921011007).content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 13 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 13)

				if (13 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 13)) > 0 and var_32_2 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_6 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_6 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_6

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_6 and arg_29_1.time_ < var_32_1 + var_32_6 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play921011008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 921011008
		arg_33_1.duration_ = 7.2

		local var_33_0 = {
			zh = 6.766,
			ja = 7.2
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
				arg_33_0:Play921011009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos1066ui_story = arg_33_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1066ui_story"].transform.position).z)
				arg_33_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1066ui_story"].transform.localEulerAngles = arg_33_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, -0.77, -6.1)
				arg_33_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["1066ui_story"].transform.position).z)
				arg_33_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["1066ui_story"].transform.localEulerAngles = arg_33_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["1066ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1066ui_story == nil then
				arg_33_1.var_.characterEffect1066ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect1066ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect1066ui_story then
				arg_33_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_2")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_36_4 = 0
			local var_36_5 = 0.775

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(921011008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 31 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 31)

				if (31 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 31)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011008", "story_v_side_old_921011.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011008", "story_v_side_old_921011.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_side_old_921011", "921011008", "story_v_side_old_921011.awb")

						arg_33_1:RecordAudio("921011008", var_36_11)
						arg_33_1:RecordAudio("921011008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011008", "story_v_side_old_921011.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011008", "story_v_side_old_921011.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_12 and arg_33_1.time_ < var_36_4 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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

		arg_33_1:InitPlayNodeList()
	end,
	Play921011009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 921011009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play921011010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1066ui_story"]) and arg_37_1.var_.characterEffect1066ui_story == nil then
				arg_37_1.var_.characterEffect1066ui_story = arg_37_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1066ui_story"]) then
				if arg_37_1.var_.characterEffect1066ui_story and not isNil(arg_37_1.actors_["1066ui_story"]) then
					arg_37_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_0)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1066ui_story"]) and arg_37_1.var_.characterEffect1066ui_story then
				arg_37_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_40_1 = 0
			local var_40_2 = 1.15

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_3 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(921011009).content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 46 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 46)

				if (46 <= 0 and var_40_2 or var_40_2 * (utf8.len(var_40_3) / 46)) > 0 and var_40_2 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_1 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_1
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_6 = math.max(var_40_2, arg_37_1.talkMaxDuration)

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_6 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_1) / var_40_6

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_1 + var_40_6 and arg_37_1.time_ < var_40_1 + var_40_6 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play921011010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 921011010
		arg_41_1.duration_ = 2.33

		local var_41_0 = {
			zh = 2.333,
			ja = 2.3
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
				arg_41_0:Play921011011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1066ui_story"]) and arg_41_1.var_.characterEffect1066ui_story == nil then
				arg_41_1.var_.characterEffect1066ui_story = arg_41_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1066ui_story"]) then
				if arg_41_1.var_.characterEffect1066ui_story and not isNil(arg_41_1.actors_["1066ui_story"]) then
					arg_41_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1066ui_story"]) and arg_41_1.var_.characterEffect1066ui_story then
				arg_41_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			local var_44_2 = 0
			local var_44_3 = 0.25

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:GetWordFromCfg(921011010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 10 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 10)

				if (10 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 10)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011010", "story_v_side_old_921011.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011010", "story_v_side_old_921011.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_side_old_921011", "921011010", "story_v_side_old_921011.awb")

						arg_41_1:RecordAudio("921011010", var_44_9)
						arg_41_1:RecordAudio("921011010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011010", "story_v_side_old_921011.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011010", "story_v_side_old_921011.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_10 and arg_41_1.time_ < var_44_2 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play921011011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 921011011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play921011012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1066ui_story"]) and arg_45_1.var_.characterEffect1066ui_story == nil then
				arg_45_1.var_.characterEffect1066ui_story = arg_45_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1066ui_story"]) then
				if arg_45_1.var_.characterEffect1066ui_story and not isNil(arg_45_1.actors_["1066ui_story"]) then
					arg_45_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1066ui_story"]) and arg_45_1.var_.characterEffect1066ui_story then
				arg_45_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_48_1 = 0
			local var_48_2 = 0.275

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(921011011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 11 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 11)

				if (11 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 11)) > 0 and var_48_2 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_6 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_6 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_6

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_6 and arg_45_1.time_ < var_48_1 + var_48_6 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play921011012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 921011012
		arg_49_1.duration_ = 5.63

		local var_49_0 = {
			zh = 5.166,
			ja = 5.633
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
				arg_49_0:Play921011013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1066ui_story"]) and arg_49_1.var_.characterEffect1066ui_story == nil then
				arg_49_1.var_.characterEffect1066ui_story = arg_49_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1066ui_story"]) then
				if arg_49_1.var_.characterEffect1066ui_story and not isNil(arg_49_1.actors_["1066ui_story"]) then
					arg_49_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1066ui_story"]) and arg_49_1.var_.characterEffect1066ui_story then
				arg_49_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action3_1")
			end

			local var_52_2 = 0
			local var_52_3 = 0.55

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:GetWordFromCfg(921011012)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 22 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 22)

				if (22 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 22)) > 0 and var_52_3 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011012", "story_v_side_old_921011.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011012", "story_v_side_old_921011.awb") / 1000

					if var_52_8 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_2
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_side_old_921011", "921011012", "story_v_side_old_921011.awb")

						arg_49_1:RecordAudio("921011012", var_52_9)
						arg_49_1:RecordAudio("921011012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011012", "story_v_side_old_921011.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011012", "story_v_side_old_921011.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_10 and arg_49_1.time_ < var_52_2 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play921011013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 921011013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play921011014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1066ui_story"]) and arg_53_1.var_.characterEffect1066ui_story == nil then
				arg_53_1.var_.characterEffect1066ui_story = arg_53_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1066ui_story"]) then
				if arg_53_1.var_.characterEffect1066ui_story and not isNil(arg_53_1.actors_["1066ui_story"]) then
					arg_53_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_0)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1066ui_story"]) and arg_53_1.var_.characterEffect1066ui_story then
				arg_53_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_56_1 = 0
			local var_56_2 = 0.05

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(921011013).content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 2 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 2)

				if (2 <= 0 and var_56_2 or var_56_2 * (utf8.len(var_56_3) / 2)) > 0 and var_56_2 < var_56_5 then
					arg_53_1.talkMaxDuration = var_56_5

					if var_56_5 + var_56_1 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + var_56_1
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_6 = math.max(var_56_2, arg_53_1.talkMaxDuration)

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_6 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_1) / var_56_6

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_1 + var_56_6 and arg_53_1.time_ < var_56_1 + var_56_6 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play921011014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 921011014
		arg_57_1.duration_ = 13.17

		local var_57_0 = {
			zh = 13.166,
			ja = 12.733
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
				arg_57_0:Play921011015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if arg_57_1.bgs_.ST2201 == nil then
				local var_60_0 = Object.Instantiate(arg_57_1.paintGo_)

				var_60_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2201")
				var_60_0.name = "ST2201"
				var_60_0.transform.parent = arg_57_1.stage_.transform
				var_60_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.bgs_.ST2201 = var_60_0
			end

			if 2 < arg_57_1.time_ and arg_57_1.time_ <= 2 + arg_60_0 then
				local var_60_1 = arg_57_1.bgs_.ST2201

				arg_57_1.bgs_.ST2201.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_60_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_60_2 = var_60_1:GetComponent("SpriteRenderer")

				if var_60_2 and var_60_2.sprite then
					local var_60_3 = 2 * (var_60_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_60_1.transform.localScale = Vector3.New(var_60_3 / var_60_2.sprite.bounds.size.y < var_60_3 * manager.ui.mainCameraCom_.aspect / var_60_2.sprite.bounds.size.x and var_60_3 * manager.ui.mainCameraCom_.aspect / var_60_2.sprite.bounds.size.x or var_60_3 / var_60_2.sprite.bounds.size.y, var_60_3 / var_60_2.sprite.bounds.size.y < var_60_3 * manager.ui.mainCameraCom_.aspect / var_60_2.sprite.bounds.size.x and var_60_3 * manager.ui.mainCameraCom_.aspect / var_60_2.sprite.bounds.size.x or var_60_3 / var_60_2.sprite.bounds.size.y, 0)
				end

				for iter_60_0, iter_60_1 in pairs(arg_57_1.bgs_) do
					if iter_60_0 ~= "ST2201" then
						iter_60_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_60_4 = 0

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			if arg_57_1.time_ >= var_60_4 + 0.3 and arg_57_1.time_ < var_60_4 + 0.3 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end

			local var_60_5 = 0

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_6 = 2

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_6 then
				local var_60_7 = Color.New(0, 0, 0)

				var_60_7.a = Mathf.Lerp(0, 1, (arg_57_1.time_ - var_60_5) / var_60_6)
				arg_57_1.mask_.color = var_60_7
			end

			if arg_57_1.time_ >= var_60_5 + var_60_6 and arg_57_1.time_ < var_60_5 + var_60_6 + arg_60_0 then
				local var_60_8 = Color.New(0, 0, 0)

				var_60_8.a = 1
				arg_57_1.mask_.color = var_60_8
			end

			local var_60_9 = 2

			if 2 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 then
				arg_57_1.mask_.enabled = true
				arg_57_1.mask_.raycastTarget = true

				arg_57_1:SetGaussion(false)
			end

			local var_60_10 = 2

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_10 then
				local var_60_11 = Color.New(0, 0, 0)

				var_60_11.a = Mathf.Lerp(1, 0, (arg_57_1.time_ - var_60_9) / var_60_10)
				arg_57_1.mask_.color = var_60_11
			end

			if arg_57_1.time_ >= var_60_9 + var_60_10 and arg_57_1.time_ < var_60_9 + var_60_10 + arg_60_0 then
				local var_60_12 = Color.New(0, 0, 0)

				arg_57_1.mask_.enabled = false
				var_60_12.a = 0
				arg_57_1.mask_.color = var_60_12
			end

			local var_60_13 = arg_57_1.actors_["1066ui_story"].transform

			if 1.96666666666667 < arg_57_1.time_ and arg_57_1.time_ <= 1.96666666666667 + arg_60_0 then
				arg_57_1.var_.moveOldPos1066ui_story = var_60_13.localPosition
			end

			local var_60_14 = 0.001

			if 1.96666666666667 <= arg_57_1.time_ and arg_57_1.time_ < 1.96666666666667 + var_60_14 then
				var_60_13.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_57_1.time_ - 1.96666666666667) / var_60_14)
				var_60_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_13.position).x, (manager.ui.mainCamera.transform.position - var_60_13.position).y, (manager.ui.mainCamera.transform.position - var_60_13.position).z)
				var_60_13.localEulerAngles.z = 0
				var_60_13.localEulerAngles.x = 0
				var_60_13.localEulerAngles = var_60_13.localEulerAngles
			end

			if arg_57_1.time_ >= 1.96666666666667 + var_60_14 and arg_57_1.time_ < 1.96666666666667 + var_60_14 + arg_60_0 then
				var_60_13.localPosition = Vector3.New(0, 100, 0)
				var_60_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_13.position).x, (manager.ui.mainCamera.transform.position - var_60_13.position).y, (manager.ui.mainCamera.transform.position - var_60_13.position).z)
				var_60_13.localEulerAngles.z = 0
				var_60_13.localEulerAngles.x = 0
				var_60_13.localEulerAngles = var_60_13.localEulerAngles
			end

			local var_60_15 = "1033ui_story"

			if arg_57_1.actors_["1033ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1033ui_story"))) then
				local var_60_16 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_57_1.stage_.transform)

				var_60_16.name = var_60_15
				var_60_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_[var_60_15] = var_60_16

				local var_60_17 = var_60_16:GetComponentInChildren(typeof(CharacterEffect))

				var_60_17.enabled = true

				local var_60_18 = GameObjectTools.GetOrAddComponent(var_60_16, typeof(DynamicBoneHelper))

				if var_60_18 then
					var_60_18:EnableDynamicBone(false)
				end

				arg_57_1:ShowWeapon(var_60_17.transform, false)

				arg_57_1.var_[var_60_15 .. "Animator"] = var_60_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_57_1.var_[var_60_15 .. "Animator"].applyRootMotion = true
				arg_57_1.var_[var_60_15 .. "LipSync"] = var_60_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_60_19 = arg_57_1.actors_["1033ui_story"].transform

			if 3.90066666851441 < arg_57_1.time_ and arg_57_1.time_ <= 3.90066666851441 + arg_60_0 then
				arg_57_1.var_.moveOldPos1033ui_story = var_60_19.localPosition
			end

			local var_60_20 = 0.001

			if 3.90066666851441 <= arg_57_1.time_ and arg_57_1.time_ < 3.90066666851441 + var_60_20 then
				var_60_19.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_57_1.time_ - 3.90066666851441) / var_60_20)
				var_60_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_19.position).x, (manager.ui.mainCamera.transform.position - var_60_19.position).y, (manager.ui.mainCamera.transform.position - var_60_19.position).z)
				var_60_19.localEulerAngles.z = 0
				var_60_19.localEulerAngles.x = 0
				var_60_19.localEulerAngles = var_60_19.localEulerAngles
			end

			if arg_57_1.time_ >= 3.90066666851441 + var_60_20 and arg_57_1.time_ < 3.90066666851441 + var_60_20 + arg_60_0 then
				var_60_19.localPosition = Vector3.New(0.7, -1.01, -6.13)
				var_60_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_19.position).x, (manager.ui.mainCamera.transform.position - var_60_19.position).y, (manager.ui.mainCamera.transform.position - var_60_19.position).z)
				var_60_19.localEulerAngles.z = 0
				var_60_19.localEulerAngles.x = 0
				var_60_19.localEulerAngles = var_60_19.localEulerAngles
			end

			local var_60_21 = arg_57_1.actors_["1033ui_story"]

			if 3.90066666851441 < arg_57_1.time_ and arg_57_1.time_ <= 3.90066666851441 + arg_60_0 and not isNil(var_60_21) and arg_57_1.var_.characterEffect1033ui_story == nil then
				arg_57_1.var_.characterEffect1033ui_story = var_60_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_22 = 0.200000002980232

			if 3.90066666851441 <= arg_57_1.time_ and arg_57_1.time_ < 3.90066666851441 + var_60_22 and not isNil(var_60_21) then
				if arg_57_1.var_.characterEffect1033ui_story and not isNil(var_60_21) then
					arg_57_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 3.90066666851441 + var_60_22 and arg_57_1.time_ < 3.90066666851441 + var_60_22 + arg_60_0 and not isNil(var_60_21) and arg_57_1.var_.characterEffect1033ui_story then
				arg_57_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 3.90066666851441 < arg_57_1.time_ and arg_57_1.time_ <= 3.90066666851441 + arg_60_0 then
				arg_57_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action4_1")
			end

			if 3.90066666851441 < arg_57_1.time_ and arg_57_1.time_ <= 3.90066666851441 + arg_60_0 then
				arg_57_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_24 = 4
			local var_60_25 = 1.075

			if 4 < arg_57_1.time_ and arg_57_1.time_ <= var_60_24 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_26 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_26:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_27 = arg_57_1:GetWordFromCfg(921011014)
				local var_60_28 = arg_57_1:FormatText(var_60_27.content)

				arg_57_1.text_.text = var_60_28

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_30 = 43 <= 0 and var_60_25 or var_60_25 * (utf8.len(var_60_28) / 43)

				if (43 <= 0 and var_60_25 or var_60_25 * (utf8.len(var_60_28) / 43)) > 0 and var_60_25 < var_60_30 then
					arg_57_1.talkMaxDuration = var_60_30
					var_60_24 = var_60_24 + 0.3

					if var_60_30 + var_60_24 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_30 + var_60_24
					end
				end

				arg_57_1.text_.text = var_60_28
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011014", "story_v_side_old_921011.awb") ~= 0 then
					local var_60_31 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011014", "story_v_side_old_921011.awb") / 1000

					if var_60_31 + var_60_24 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_31 + var_60_24
					end

					if var_60_27.prefab_name ~= "" and arg_57_1.actors_[var_60_27.prefab_name] ~= nil then
						local var_60_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_27.prefab_name].transform, "story_v_side_old_921011", "921011014", "story_v_side_old_921011.awb")

						arg_57_1:RecordAudio("921011014", var_60_32)
						arg_57_1:RecordAudio("921011014", var_60_32)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011014", "story_v_side_old_921011.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011014", "story_v_side_old_921011.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_33 = var_60_24 + 0.3
			local var_60_34 = math.max(var_60_25, arg_57_1.talkMaxDuration)

			if var_60_24 + 0.3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_33 + var_60_34 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_33) / var_60_34

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_33 + var_60_34 and arg_57_1.time_ < var_60_33 + var_60_34 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1033ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.90066666851441,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play921011015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 921011015
		arg_63_1.duration_ = 6.03

		local var_63_0 = {
			zh = 5.533,
			ja = 6.033
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play921011016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos1066ui_story = arg_63_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_66_0 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 then
				arg_63_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_63_1.time_ - 0) / var_66_0)
				arg_63_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1066ui_story"].transform.position).z)
				arg_63_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1066ui_story"].transform.localEulerAngles = arg_63_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 then
				arg_63_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				arg_63_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["1066ui_story"].transform.position).z)
				arg_63_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["1066ui_story"].transform.localEulerAngles = arg_63_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_66_1 = arg_63_1.actors_["1066ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1066ui_story == nil then
				arg_63_1.var_.characterEffect1066ui_story = var_66_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 and not isNil(var_66_1) then
				if arg_63_1.var_.characterEffect1066ui_story and not isNil(var_66_1) then
					arg_63_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1066ui_story then
				arg_63_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action1_1")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_66_4 = arg_63_1.actors_["1033ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_4) and arg_63_1.var_.characterEffect1033ui_story == nil then
				arg_63_1.var_.characterEffect1033ui_story = var_66_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_5 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_5 and not isNil(var_66_4) then
				if arg_63_1.var_.characterEffect1033ui_story and not isNil(var_66_4) then
					arg_63_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_5)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_5 and arg_63_1.time_ < 0 + var_66_5 + arg_66_0 and not isNil(var_66_4) and arg_63_1.var_.characterEffect1033ui_story then
				arg_63_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_66_6 = 0
			local var_66_7 = 0.625

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_8 = arg_63_1:GetWordFromCfg(921011015)
				local var_66_9 = arg_63_1:FormatText(var_66_8.content)

				arg_63_1.text_.text = var_66_9

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_11 = 25 <= 0 and var_66_7 or var_66_7 * (utf8.len(var_66_9) / 25)

				if (25 <= 0 and var_66_7 or var_66_7 * (utf8.len(var_66_9) / 25)) > 0 and var_66_7 < var_66_11 then
					arg_63_1.talkMaxDuration = var_66_11

					if var_66_11 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_11 + var_66_6
					end
				end

				arg_63_1.text_.text = var_66_9
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011015", "story_v_side_old_921011.awb") ~= 0 then
					local var_66_12 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011015", "story_v_side_old_921011.awb") / 1000

					if var_66_12 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_12 + var_66_6
					end

					if var_66_8.prefab_name ~= "" and arg_63_1.actors_[var_66_8.prefab_name] ~= nil then
						local var_66_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_8.prefab_name].transform, "story_v_side_old_921011", "921011015", "story_v_side_old_921011.awb")

						arg_63_1:RecordAudio("921011015", var_66_13)
						arg_63_1:RecordAudio("921011015", var_66_13)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011015", "story_v_side_old_921011.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011015", "story_v_side_old_921011.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_14 = math.max(var_66_7, arg_63_1.talkMaxDuration)

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_14 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_6) / var_66_14

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_6 + var_66_14 and arg_63_1.time_ < var_66_6 + var_66_14 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
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

		arg_63_1:InitPlayNodeList()
	end,
	Play921011016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 921011016
		arg_67_1.duration_ = 7.67

		local var_67_0 = {
			zh = 7.666,
			ja = 6.966
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play921011017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1066ui_story"]) and arg_67_1.var_.characterEffect1066ui_story == nil then
				arg_67_1.var_.characterEffect1066ui_story = arg_67_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1066ui_story"]) then
				if arg_67_1.var_.characterEffect1066ui_story and not isNil(arg_67_1.actors_["1066ui_story"]) then
					arg_67_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_0)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1066ui_story"]) and arg_67_1.var_.characterEffect1066ui_story then
				arg_67_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_70_1 = arg_67_1.actors_["1033ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1033ui_story == nil then
				arg_67_1.var_.characterEffect1033ui_story = var_70_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 and not isNil(var_70_1) then
				if arg_67_1.var_.characterEffect1033ui_story and not isNil(var_70_1) then
					arg_67_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1033ui_story then
				arg_67_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			local var_70_4 = 0
			local var_70_5 = 1.025

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_6 = arg_67_1:GetWordFromCfg(921011016)
				local var_70_7 = arg_67_1:FormatText(var_70_6.content)

				arg_67_1.text_.text = var_70_7

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_9 = 41 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 41)

				if (41 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 41)) > 0 and var_70_5 < var_70_9 then
					arg_67_1.talkMaxDuration = var_70_9

					if var_70_9 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_9 + var_70_4
					end
				end

				arg_67_1.text_.text = var_70_7
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011016", "story_v_side_old_921011.awb") ~= 0 then
					local var_70_10 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011016", "story_v_side_old_921011.awb") / 1000

					if var_70_10 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_4
					end

					if var_70_6.prefab_name ~= "" and arg_67_1.actors_[var_70_6.prefab_name] ~= nil then
						local var_70_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_6.prefab_name].transform, "story_v_side_old_921011", "921011016", "story_v_side_old_921011.awb")

						arg_67_1:RecordAudio("921011016", var_70_11)
						arg_67_1:RecordAudio("921011016", var_70_11)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011016", "story_v_side_old_921011.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011016", "story_v_side_old_921011.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_12 = math.max(var_70_5, arg_67_1.talkMaxDuration)

			if var_70_4 <= arg_67_1.time_ and arg_67_1.time_ < var_70_4 + var_70_12 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_4) / var_70_12

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_4 + var_70_12 and arg_67_1.time_ < var_70_4 + var_70_12 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play921011017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 921011017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play921011018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["1033ui_story"]) and arg_71_1.var_.characterEffect1033ui_story == nil then
				arg_71_1.var_.characterEffect1033ui_story = arg_71_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["1033ui_story"]) then
				if arg_71_1.var_.characterEffect1033ui_story and not isNil(arg_71_1.actors_["1033ui_story"]) then
					arg_71_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_0)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["1033ui_story"]) and arg_71_1.var_.characterEffect1033ui_story then
				arg_71_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_74_1 = 0
			local var_74_2 = 0.375

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_3 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(921011017).content)

				arg_71_1.text_.text = var_74_3

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 15 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 15)

				if (15 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 15)) > 0 and var_74_2 < var_74_5 then
					arg_71_1.talkMaxDuration = var_74_5

					if var_74_5 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + var_74_1
					end
				end

				arg_71_1.text_.text = var_74_3
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_6 = math.max(var_74_2, arg_71_1.talkMaxDuration)

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_6 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_1) / var_74_6

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_1 + var_74_6 and arg_71_1.time_ < var_74_1 + var_74_6 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play921011018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 921011018
		arg_75_1.duration_ = 3.57

		local var_75_0 = {
			zh = 2.7,
			ja = 3.566
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play921011019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1033ui_story = arg_75_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_75_1.time_ - 0) / var_78_0)
				arg_75_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1033ui_story"].transform.position).z)
				arg_75_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1033ui_story"].transform.localEulerAngles = arg_75_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.13)
				arg_75_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1033ui_story"].transform.position).z)
				arg_75_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1033ui_story"].transform.localEulerAngles = arg_75_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_78_1 = arg_75_1.actors_["1033ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect1033ui_story == nil then
				arg_75_1.var_.characterEffect1033ui_story = var_78_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_2 and not isNil(var_78_1) then
				if arg_75_1.var_.characterEffect1033ui_story and not isNil(var_78_1) then
					arg_75_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_2 and arg_75_1.time_ < 0 + var_78_2 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect1033ui_story then
				arg_75_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action4_2")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_78_4 = 0
			local var_78_5 = 0.3

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_4 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_6 = arg_75_1:GetWordFromCfg(921011018)
				local var_78_7 = arg_75_1:FormatText(var_78_6.content)

				arg_75_1.text_.text = var_78_7

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_9 = 12 <= 0 and var_78_5 or var_78_5 * (utf8.len(var_78_7) / 12)

				if (12 <= 0 and var_78_5 or var_78_5 * (utf8.len(var_78_7) / 12)) > 0 and var_78_5 < var_78_9 then
					arg_75_1.talkMaxDuration = var_78_9

					if var_78_9 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_9 + var_78_4
					end
				end

				arg_75_1.text_.text = var_78_7
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011018", "story_v_side_old_921011.awb") ~= 0 then
					local var_78_10 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011018", "story_v_side_old_921011.awb") / 1000

					if var_78_10 + var_78_4 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_4
					end

					if var_78_6.prefab_name ~= "" and arg_75_1.actors_[var_78_6.prefab_name] ~= nil then
						local var_78_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_6.prefab_name].transform, "story_v_side_old_921011", "921011018", "story_v_side_old_921011.awb")

						arg_75_1:RecordAudio("921011018", var_78_11)
						arg_75_1:RecordAudio("921011018", var_78_11)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011018", "story_v_side_old_921011.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011018", "story_v_side_old_921011.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_12 = math.max(var_78_5, arg_75_1.talkMaxDuration)

			if var_78_4 <= arg_75_1.time_ and arg_75_1.time_ < var_78_4 + var_78_12 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_4) / var_78_12

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_4 + var_78_12 and arg_75_1.time_ < var_78_4 + var_78_12 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
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

		arg_75_1:InitPlayNodeList()
	end,
	Play921011019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 921011019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play921011020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1033ui_story"]) and arg_79_1.var_.characterEffect1033ui_story == nil then
				arg_79_1.var_.characterEffect1033ui_story = arg_79_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1033ui_story"]) then
				if arg_79_1.var_.characterEffect1033ui_story and not isNil(arg_79_1.actors_["1033ui_story"]) then
					arg_79_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_0)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1033ui_story"]) and arg_79_1.var_.characterEffect1033ui_story then
				arg_79_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_82_1 = 0
			local var_82_2 = 0.4

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_3 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(921011019).content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 16 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 16)

				if (16 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 16)) > 0 and var_82_2 < var_82_5 then
					arg_79_1.talkMaxDuration = var_82_5

					if var_82_5 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + var_82_1
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_6 = math.max(var_82_2, arg_79_1.talkMaxDuration)

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_6 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_1) / var_82_6

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_1 + var_82_6 and arg_79_1.time_ < var_82_1 + var_82_6 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play921011020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 921011020
		arg_83_1.duration_ = 6.2

		local var_83_0 = {
			zh = 6.2,
			ja = 4.9
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play921011021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1033ui_story"]) and arg_83_1.var_.characterEffect1033ui_story == nil then
				arg_83_1.var_.characterEffect1033ui_story = arg_83_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1033ui_story"]) then
				if arg_83_1.var_.characterEffect1033ui_story and not isNil(arg_83_1.actors_["1033ui_story"]) then
					arg_83_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1033ui_story"]) and arg_83_1.var_.characterEffect1033ui_story then
				arg_83_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_86_2 = 0
			local var_86_3 = 0.65

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_2 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_4 = arg_83_1:GetWordFromCfg(921011020)
				local var_86_5 = arg_83_1:FormatText(var_86_4.content)

				arg_83_1.text_.text = var_86_5

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_7 = 26 <= 0 and var_86_3 or var_86_3 * (utf8.len(var_86_5) / 26)

				if (26 <= 0 and var_86_3 or var_86_3 * (utf8.len(var_86_5) / 26)) > 0 and var_86_3 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_2 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_2
					end
				end

				arg_83_1.text_.text = var_86_5
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011020", "story_v_side_old_921011.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011020", "story_v_side_old_921011.awb") / 1000

					if var_86_8 + var_86_2 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_2
					end

					if var_86_4.prefab_name ~= "" and arg_83_1.actors_[var_86_4.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_4.prefab_name].transform, "story_v_side_old_921011", "921011020", "story_v_side_old_921011.awb")

						arg_83_1:RecordAudio("921011020", var_86_9)
						arg_83_1:RecordAudio("921011020", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011020", "story_v_side_old_921011.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011020", "story_v_side_old_921011.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_3, arg_83_1.talkMaxDuration)

			if var_86_2 <= arg_83_1.time_ and arg_83_1.time_ < var_86_2 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_2) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_2 + var_86_10 and arg_83_1.time_ < var_86_2 + var_86_10 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play921011021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 921011021
		arg_87_1.duration_ = 4.7

		local var_87_0 = {
			zh = 4.7,
			ja = 3.9
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play921011022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1066ui_story = arg_87_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1066ui_story"].transform.position).z)
				arg_87_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1066ui_story"].transform.localEulerAngles = arg_87_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				arg_87_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1066ui_story"].transform.position).z)
				arg_87_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1066ui_story"].transform.localEulerAngles = arg_87_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_90_1 = arg_87_1.actors_["1066ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1066ui_story == nil then
				arg_87_1.var_.characterEffect1066ui_story = var_90_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 and not isNil(var_90_1) then
				if arg_87_1.var_.characterEffect1066ui_story and not isNil(var_90_1) then
					arg_87_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1066ui_story then
				arg_87_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action4_1")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_90_4 = arg_87_1.actors_["1033ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_4) and arg_87_1.var_.characterEffect1033ui_story == nil then
				arg_87_1.var_.characterEffect1033ui_story = var_90_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_5 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_5 and not isNil(var_90_4) then
				if arg_87_1.var_.characterEffect1033ui_story and not isNil(var_90_4) then
					arg_87_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_5)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_5 and arg_87_1.time_ < 0 + var_90_5 + arg_90_0 and not isNil(var_90_4) and arg_87_1.var_.characterEffect1033ui_story then
				arg_87_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_90_6 = 0
			local var_90_7 = 0.575

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_6 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_8 = arg_87_1:GetWordFromCfg(921011021)
				local var_90_9 = arg_87_1:FormatText(var_90_8.content)

				arg_87_1.text_.text = var_90_9

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_11 = 23 <= 0 and var_90_7 or var_90_7 * (utf8.len(var_90_9) / 23)

				if (23 <= 0 and var_90_7 or var_90_7 * (utf8.len(var_90_9) / 23)) > 0 and var_90_7 < var_90_11 then
					arg_87_1.talkMaxDuration = var_90_11

					if var_90_11 + var_90_6 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_11 + var_90_6
					end
				end

				arg_87_1.text_.text = var_90_9
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011021", "story_v_side_old_921011.awb") ~= 0 then
					local var_90_12 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011021", "story_v_side_old_921011.awb") / 1000

					if var_90_12 + var_90_6 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_12 + var_90_6
					end

					if var_90_8.prefab_name ~= "" and arg_87_1.actors_[var_90_8.prefab_name] ~= nil then
						local var_90_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_8.prefab_name].transform, "story_v_side_old_921011", "921011021", "story_v_side_old_921011.awb")

						arg_87_1:RecordAudio("921011021", var_90_13)
						arg_87_1:RecordAudio("921011021", var_90_13)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011021", "story_v_side_old_921011.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011021", "story_v_side_old_921011.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_14 = math.max(var_90_7, arg_87_1.talkMaxDuration)

			if var_90_6 <= arg_87_1.time_ and arg_87_1.time_ < var_90_6 + var_90_14 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_6) / var_90_14

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_6 + var_90_14 and arg_87_1.time_ < var_90_6 + var_90_14 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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

		arg_87_1:InitPlayNodeList()
	end,
	Play921011022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 921011022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play921011023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1066ui_story"]) and arg_91_1.var_.characterEffect1066ui_story == nil then
				arg_91_1.var_.characterEffect1066ui_story = arg_91_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1066ui_story"]) then
				if arg_91_1.var_.characterEffect1066ui_story and not isNil(arg_91_1.actors_["1066ui_story"]) then
					arg_91_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_0)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1066ui_story"]) and arg_91_1.var_.characterEffect1066ui_story then
				arg_91_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_94_1 = 0
			local var_94_2 = 0.6

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_3 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(921011022).content)

				arg_91_1.text_.text = var_94_3

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 24 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_3) / 24)

				if (24 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_3) / 24)) > 0 and var_94_2 < var_94_5 then
					arg_91_1.talkMaxDuration = var_94_5

					if var_94_5 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + var_94_1
					end
				end

				arg_91_1.text_.text = var_94_3
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_6 = math.max(var_94_2, arg_91_1.talkMaxDuration)

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_6 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_1) / var_94_6

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_1 + var_94_6 and arg_91_1.time_ < var_94_1 + var_94_6 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play921011023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 921011023
		arg_95_1.duration_ = 3.77

		local var_95_0 = {
			zh = 2.7,
			ja = 3.766
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play921011024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1033ui_story = arg_95_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1033ui_story"].transform.position).z)
				arg_95_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1033ui_story"].transform.localEulerAngles = arg_95_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.13)
				arg_95_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["1033ui_story"].transform.position).z)
				arg_95_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["1033ui_story"].transform.localEulerAngles = arg_95_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_98_1 = arg_95_1.actors_["1033ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1033ui_story == nil then
				arg_95_1.var_.characterEffect1033ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect1033ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect1033ui_story then
				arg_95_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action7_1")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_98_4 = 0
			local var_98_5 = 0.25

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_6 = arg_95_1:GetWordFromCfg(921011023)
				local var_98_7 = arg_95_1:FormatText(var_98_6.content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 10 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 10)

				if (10 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 10)) > 0 and var_98_5 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011023", "story_v_side_old_921011.awb") ~= 0 then
					local var_98_10 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011023", "story_v_side_old_921011.awb") / 1000

					if var_98_10 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_4
					end

					if var_98_6.prefab_name ~= "" and arg_95_1.actors_[var_98_6.prefab_name] ~= nil then
						local var_98_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_6.prefab_name].transform, "story_v_side_old_921011", "921011023", "story_v_side_old_921011.awb")

						arg_95_1:RecordAudio("921011023", var_98_11)
						arg_95_1:RecordAudio("921011023", var_98_11)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011023", "story_v_side_old_921011.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011023", "story_v_side_old_921011.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_12 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_12 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_12

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_12 and arg_95_1.time_ < var_98_4 + var_98_12 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
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

		arg_95_1:InitPlayNodeList()
	end,
	Play921011024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 921011024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play921011025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1066ui_story = arg_99_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1066ui_story"].transform.position).z)
				arg_99_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1066ui_story"].transform.localEulerAngles = arg_99_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1066ui_story"].transform.position).z)
				arg_99_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1066ui_story"].transform.localEulerAngles = arg_99_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["1033ui_story"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1033ui_story = var_102_1.localPosition
			end

			local var_102_2 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 then
				var_102_1.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 0) / var_102_2)
				var_102_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_1.position).x, (manager.ui.mainCamera.transform.position - var_102_1.position).y, (manager.ui.mainCamera.transform.position - var_102_1.position).z)
				var_102_1.localEulerAngles.z = 0
				var_102_1.localEulerAngles.x = 0
				var_102_1.localEulerAngles = var_102_1.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 then
				var_102_1.localPosition = Vector3.New(0, 100, 0)
				var_102_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_1.position).x, (manager.ui.mainCamera.transform.position - var_102_1.position).y, (manager.ui.mainCamera.transform.position - var_102_1.position).z)
				var_102_1.localEulerAngles.z = 0
				var_102_1.localEulerAngles.x = 0
				var_102_1.localEulerAngles = var_102_1.localEulerAngles
			end

			local var_102_3 = 0
			local var_102_4 = 0.725

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_3 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_5 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(921011024).content)

				arg_99_1.text_.text = var_102_5

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_7 = 29 <= 0 and var_102_4 or var_102_4 * (utf8.len(var_102_5) / 29)

				if (29 <= 0 and var_102_4 or var_102_4 * (utf8.len(var_102_5) / 29)) > 0 and var_102_4 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_3 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_3
					end
				end

				arg_99_1.text_.text = var_102_5
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_8 = math.max(var_102_4, arg_99_1.talkMaxDuration)

			if var_102_3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_3 + var_102_8 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_3) / var_102_8

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_3 + var_102_8 and arg_99_1.time_ < var_102_3 + var_102_8 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
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

		arg_99_1:InitPlayNodeList()
	end,
	Play921011025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 921011025
		arg_103_1.duration_ = 3.33

		local var_103_0 = {
			zh = 3.333,
			ja = 1.999999999999
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play921011026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1066ui_story = arg_103_1.actors_["1066ui_story"].transform.localPosition

				arg_103_1:ShowWeapon(arg_103_1.var_["1066ui_story" .. "Animator"].transform, false)
			end

			local var_106_0 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 then
				arg_103_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_103_1.time_ - 0) / var_106_0)
				arg_103_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1066ui_story"].transform.position).z)
				arg_103_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1066ui_story"].transform.localEulerAngles = arg_103_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 then
				arg_103_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				arg_103_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1066ui_story"].transform.position).z)
				arg_103_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1066ui_story"].transform.localEulerAngles = arg_103_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_106_1 = arg_103_1.actors_["1066ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1066ui_story == nil then
				arg_103_1.var_.characterEffect1066ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 and not isNil(var_106_1) then
				if arg_103_1.var_.characterEffect1066ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1066ui_story then
				arg_103_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action447")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_106_4 = 0
			local var_106_5 = 0.15

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_6 = arg_103_1:GetWordFromCfg(921011025)
				local var_106_7 = arg_103_1:FormatText(var_106_6.content)

				arg_103_1.text_.text = var_106_7

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_9 = 6 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 6)

				if (6 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 6)) > 0 and var_106_5 < var_106_9 then
					arg_103_1.talkMaxDuration = var_106_9

					if var_106_9 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_4
					end
				end

				arg_103_1.text_.text = var_106_7
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011025", "story_v_side_old_921011.awb") ~= 0 then
					local var_106_10 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011025", "story_v_side_old_921011.awb") / 1000

					if var_106_10 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_4
					end

					if var_106_6.prefab_name ~= "" and arg_103_1.actors_[var_106_6.prefab_name] ~= nil then
						local var_106_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_6.prefab_name].transform, "story_v_side_old_921011", "921011025", "story_v_side_old_921011.awb")

						arg_103_1:RecordAudio("921011025", var_106_11)
						arg_103_1:RecordAudio("921011025", var_106_11)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011025", "story_v_side_old_921011.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011025", "story_v_side_old_921011.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_12 = math.max(var_106_5, arg_103_1.talkMaxDuration)

			if var_106_4 <= arg_103_1.time_ and arg_103_1.time_ < var_106_4 + var_106_12 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_4) / var_106_12

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_4 + var_106_12 and arg_103_1.time_ < var_106_4 + var_106_12 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
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

		arg_103_1:InitPlayNodeList()
	end,
	Play921011026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 921011026
		arg_107_1.duration_ = 5.23

		local var_107_0 = {
			zh = 2.8,
			ja = 5.233
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play921011027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1033ui_story = arg_107_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_110_0 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 then
				arg_107_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_107_1.time_ - 0) / var_110_0)
				arg_107_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1033ui_story"].transform.position).z)
				arg_107_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["1033ui_story"].transform.localEulerAngles = arg_107_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 then
				arg_107_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.13)
				arg_107_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_107_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_107_1.actors_["1033ui_story"].transform.position).z)
				arg_107_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_107_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_107_1.actors_["1033ui_story"].transform.localEulerAngles = arg_107_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_110_1 = arg_107_1.actors_["1033ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1033ui_story == nil then
				arg_107_1.var_.characterEffect1033ui_story = var_110_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 and not isNil(var_110_1) then
				if arg_107_1.var_.characterEffect1033ui_story and not isNil(var_110_1) then
					arg_107_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 and not isNil(var_110_1) and arg_107_1.var_.characterEffect1033ui_story then
				arg_107_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_110_4 = arg_107_1.actors_["1066ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_4) and arg_107_1.var_.characterEffect1066ui_story == nil then
				arg_107_1.var_.characterEffect1066ui_story = var_110_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_5 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_5 and not isNil(var_110_4) then
				if arg_107_1.var_.characterEffect1066ui_story and not isNil(var_110_4) then
					arg_107_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_5)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_5 and arg_107_1.time_ < 0 + var_110_5 + arg_110_0 and not isNil(var_110_4) and arg_107_1.var_.characterEffect1066ui_story then
				arg_107_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_110_6 = 0
			local var_110_7 = 0.425

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_8 = arg_107_1:GetWordFromCfg(921011026)
				local var_110_9 = arg_107_1:FormatText(var_110_8.content)

				arg_107_1.text_.text = var_110_9

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_11 = 17 <= 0 and var_110_7 or var_110_7 * (utf8.len(var_110_9) / 17)

				if (17 <= 0 and var_110_7 or var_110_7 * (utf8.len(var_110_9) / 17)) > 0 and var_110_7 < var_110_11 then
					arg_107_1.talkMaxDuration = var_110_11

					if var_110_11 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_11 + var_110_6
					end
				end

				arg_107_1.text_.text = var_110_9
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011026", "story_v_side_old_921011.awb") ~= 0 then
					local var_110_12 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011026", "story_v_side_old_921011.awb") / 1000

					if var_110_12 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_12 + var_110_6
					end

					if var_110_8.prefab_name ~= "" and arg_107_1.actors_[var_110_8.prefab_name] ~= nil then
						local var_110_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_8.prefab_name].transform, "story_v_side_old_921011", "921011026", "story_v_side_old_921011.awb")

						arg_107_1:RecordAudio("921011026", var_110_13)
						arg_107_1:RecordAudio("921011026", var_110_13)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011026", "story_v_side_old_921011.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011026", "story_v_side_old_921011.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_14 = math.max(var_110_7, arg_107_1.talkMaxDuration)

			if var_110_6 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_14 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_6) / var_110_14

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_6 + var_110_14 and arg_107_1.time_ < var_110_6 + var_110_14 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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

		arg_107_1:InitPlayNodeList()
	end,
	Play921011027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 921011027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play921011028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1033ui_story"]) and arg_111_1.var_.characterEffect1033ui_story == nil then
				arg_111_1.var_.characterEffect1033ui_story = arg_111_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1033ui_story"]) then
				if arg_111_1.var_.characterEffect1033ui_story and not isNil(arg_111_1.actors_["1033ui_story"]) then
					arg_111_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_0)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1033ui_story"]) and arg_111_1.var_.characterEffect1033ui_story then
				arg_111_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_114_1 = 0
			local var_114_2 = 0.15

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_3 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(921011027).content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 6 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 6)

				if (6 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 6)) > 0 and var_114_2 < var_114_5 then
					arg_111_1.talkMaxDuration = var_114_5

					if var_114_5 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + var_114_1
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_6 = math.max(var_114_2, arg_111_1.talkMaxDuration)

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_6 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_1) / var_114_6

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_1 + var_114_6 and arg_111_1.time_ < var_114_1 + var_114_6 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play921011028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 921011028
		arg_115_1.duration_ = 2.77

		local var_115_0 = {
			zh = 2.266,
			ja = 2.766
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play921011029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1066ui_story = arg_115_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_118_0 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 then
				arg_115_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_115_1.time_ - 0) / var_118_0)
				arg_115_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1066ui_story"].transform.position).z)
				arg_115_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1066ui_story"].transform.localEulerAngles = arg_115_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 then
				arg_115_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				arg_115_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_115_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_115_1.actors_["1066ui_story"].transform.position).z)
				arg_115_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_115_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_115_1.actors_["1066ui_story"].transform.localEulerAngles = arg_115_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_118_1 = arg_115_1.actors_["1066ui_story"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1066ui_story == nil then
				arg_115_1.var_.characterEffect1066ui_story = var_118_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_2 and not isNil(var_118_1) then
				if arg_115_1.var_.characterEffect1066ui_story and not isNil(var_118_1) then
					arg_115_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_2 and arg_115_1.time_ < 0 + var_118_2 + arg_118_0 and not isNil(var_118_1) and arg_115_1.var_.characterEffect1066ui_story then
				arg_115_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action478")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if arg_115_1.frameCnt_ <= 1 then
				arg_115_1.dialog_:SetActive(false)
			end

			local var_118_4 = 0.5
			local var_118_5 = 0.125

			if 0.5 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				arg_115_1.dialog_:SetActive(true)

				arg_115_1.dialogCg_.alpha = 0

				local var_118_6 = LeanTween.value(arg_115_1.dialog_, 0, 1, 0.3)

				var_118_6:setOnUpdate(LuaHelper.FloatAction(function(arg_119_0)
					arg_115_1.dialogCg_.alpha = arg_119_0
				end))
				var_118_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_115_1.dialog_)
					var_118_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_115_1.duration_ = arg_115_1.duration_ + 0.3

				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_7 = arg_115_1:GetWordFromCfg(921011028)
				local var_118_8 = arg_115_1:FormatText(var_118_7.content)

				arg_115_1.text_.text = var_118_8

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_10 = 5 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_8) / 5)

				if (5 <= 0 and var_118_5 or var_118_5 * (utf8.len(var_118_8) / 5)) > 0 and var_118_5 < var_118_10 then
					arg_115_1.talkMaxDuration = var_118_10
					var_118_4 = var_118_4 + 0.3

					if var_118_10 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_4
					end
				end

				arg_115_1.text_.text = var_118_8
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011028", "story_v_side_old_921011.awb") ~= 0 then
					local var_118_11 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011028", "story_v_side_old_921011.awb") / 1000

					if var_118_11 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_11 + var_118_4
					end

					if var_118_7.prefab_name ~= "" and arg_115_1.actors_[var_118_7.prefab_name] ~= nil then
						local var_118_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_7.prefab_name].transform, "story_v_side_old_921011", "921011028", "story_v_side_old_921011.awb")

						arg_115_1:RecordAudio("921011028", var_118_12)
						arg_115_1:RecordAudio("921011028", var_118_12)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011028", "story_v_side_old_921011.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011028", "story_v_side_old_921011.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_13 = var_118_4 + 0.3
			local var_118_14 = math.max(var_118_5, arg_115_1.talkMaxDuration)

			if var_118_4 + 0.3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_13 + var_118_14 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_13) / var_118_14

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_13 + var_118_14 and arg_115_1.time_ < var_118_13 + var_118_14 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
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

		arg_115_1:InitPlayNodeList()
	end,
	Play921011029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 921011029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play921011030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1066ui_story = arg_121_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1066ui_story"].transform.position).z)
				arg_121_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1066ui_story"].transform.localEulerAngles = arg_121_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1066ui_story"].transform.position).z)
				arg_121_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1066ui_story"].transform.localEulerAngles = arg_121_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1066ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1066ui_story == nil then
				arg_121_1.var_.characterEffect1066ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1066ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_2)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1066ui_story then
				arg_121_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_124_3 = arg_121_1.actors_["1033ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1033ui_story = var_124_3.localPosition
			end

			local var_124_4 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				var_124_3.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_4)
				var_124_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_3.position).x, (manager.ui.mainCamera.transform.position - var_124_3.position).y, (manager.ui.mainCamera.transform.position - var_124_3.position).z)
				var_124_3.localEulerAngles.z = 0
				var_124_3.localEulerAngles.x = 0
				var_124_3.localEulerAngles = var_124_3.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				var_124_3.localPosition = Vector3.New(0, 100, 0)
				var_124_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_3.position).x, (manager.ui.mainCamera.transform.position - var_124_3.position).y, (manager.ui.mainCamera.transform.position - var_124_3.position).z)
				var_124_3.localEulerAngles.z = 0
				var_124_3.localEulerAngles.x = 0
				var_124_3.localEulerAngles = var_124_3.localEulerAngles
			end

			local var_124_5 = 0
			local var_124_6 = 0.55

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_7 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(921011029).content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 22 <= 0 and var_124_6 or var_124_6 * (utf8.len(var_124_7) / 22)

				if (22 <= 0 and var_124_6 or var_124_6 * (utf8.len(var_124_7) / 22)) > 0 and var_124_6 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_5 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_5
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_10 = math.max(var_124_6, arg_121_1.talkMaxDuration)

			if var_124_5 <= arg_121_1.time_ and arg_121_1.time_ < var_124_5 + var_124_10 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_5) / var_124_10

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_5 + var_124_10 and arg_121_1.time_ < var_124_5 + var_124_10 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
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

		arg_121_1:InitPlayNodeList()
	end,
	Play921011030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 921011030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play921011031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.45

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(921011030).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 18 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 18)

				if (18 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 18)) > 0 and var_128_0 < var_128_3 then
					arg_125_1.talkMaxDuration = var_128_3

					if var_128_3 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_3 + 0
					end
				end

				arg_125_1.text_.text = var_128_1
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_4 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_4

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play921011031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 921011031
		arg_129_1.duration_ = 9.4

		local var_129_0 = {
			zh = 9.4,
			ja = 9.233
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
				arg_129_0:Play921011032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1033ui_story = arg_129_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1033ui_story, Vector3.New(0.7, -1.01, -6.13), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1033ui_story"].transform.position).z)
				arg_129_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1033ui_story"].transform.localEulerAngles = arg_129_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.13)
				arg_129_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1033ui_story"].transform.position).z)
				arg_129_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1033ui_story"].transform.localEulerAngles = arg_129_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1033ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1033ui_story == nil then
				arg_129_1.var_.characterEffect1033ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect1033ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1033ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1033ui_story then
				arg_129_1.var_.characterEffect1033ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/story1033/story1033action/1033action3_2")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_132_4 = 0
			local var_132_5 = 1.175

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:GetWordFromCfg(921011031)
				local var_132_7 = arg_129_1:FormatText(var_132_6.content)

				arg_129_1.text_.text = var_132_7

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_9 = 47 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 47)

				if (47 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_7) / 47)) > 0 and var_132_5 < var_132_9 then
					arg_129_1.talkMaxDuration = var_132_9

					if var_132_9 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_9 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_7
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011031", "story_v_side_old_921011.awb") ~= 0 then
					local var_132_10 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011031", "story_v_side_old_921011.awb") / 1000

					if var_132_10 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_4
					end

					if var_132_6.prefab_name ~= "" and arg_129_1.actors_[var_132_6.prefab_name] ~= nil then
						local var_132_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_6.prefab_name].transform, "story_v_side_old_921011", "921011031", "story_v_side_old_921011.awb")

						arg_129_1:RecordAudio("921011031", var_132_11)
						arg_129_1:RecordAudio("921011031", var_132_11)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011031", "story_v_side_old_921011.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011031", "story_v_side_old_921011.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_12 = math.max(var_132_5, arg_129_1.talkMaxDuration)

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_12 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_4) / var_132_12

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_4 + var_132_12 and arg_129_1.time_ < var_132_4 + var_132_12 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
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

		arg_129_1:InitPlayNodeList()
	end,
	Play921011032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 921011032
		arg_133_1.duration_ = 7.37

		local var_133_0 = {
			zh = 4.1,
			ja = 7.366
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
				arg_133_0:Play921011033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1033ui_story"]) and arg_133_1.var_.characterEffect1033ui_story == nil then
				arg_133_1.var_.characterEffect1033ui_story = arg_133_1.actors_["1033ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1033ui_story"]) then
				if arg_133_1.var_.characterEffect1033ui_story and not isNil(arg_133_1.actors_["1033ui_story"]) then
					arg_133_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1033ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1033ui_story"]) and arg_133_1.var_.characterEffect1033ui_story then
				arg_133_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1033ui_story.fillRatio = 0.5
			end

			local var_136_1 = arg_133_1.actors_["1066ui_story"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1066ui_story = var_136_1.localPosition
			end

			local var_136_2 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 then
				var_136_1.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_133_1.time_ - 0) / var_136_2)
				var_136_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_1.position).x, (manager.ui.mainCamera.transform.position - var_136_1.position).y, (manager.ui.mainCamera.transform.position - var_136_1.position).z)
				var_136_1.localEulerAngles.z = 0
				var_136_1.localEulerAngles.x = 0
				var_136_1.localEulerAngles = var_136_1.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 then
				var_136_1.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				var_136_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_1.position).x, (manager.ui.mainCamera.transform.position - var_136_1.position).y, (manager.ui.mainCamera.transform.position - var_136_1.position).z)
				var_136_1.localEulerAngles.z = 0
				var_136_1.localEulerAngles.x = 0
				var_136_1.localEulerAngles = var_136_1.localEulerAngles
			end

			local var_136_3 = arg_133_1.actors_["1066ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_3) and arg_133_1.var_.characterEffect1066ui_story == nil then
				arg_133_1.var_.characterEffect1066ui_story = var_136_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_4 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_4 and not isNil(var_136_3) then
				if arg_133_1.var_.characterEffect1066ui_story and not isNil(var_136_3) then
					arg_133_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_4 and arg_133_1.time_ < 0 + var_136_4 + arg_136_0 and not isNil(var_136_3) and arg_133_1.var_.characterEffect1066ui_story then
				arg_133_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066action/1066action2_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_136_6 = 0
			local var_136_7 = 0.525

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_8 = arg_133_1:GetWordFromCfg(921011032)
				local var_136_9 = arg_133_1:FormatText(var_136_8.content)

				arg_133_1.text_.text = var_136_9

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 21 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_9) / 21)

				if (21 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_9) / 21)) > 0 and var_136_7 < var_136_11 then
					arg_133_1.talkMaxDuration = var_136_11

					if var_136_11 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_11 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_9
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011032", "story_v_side_old_921011.awb") ~= 0 then
					local var_136_12 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011032", "story_v_side_old_921011.awb") / 1000

					if var_136_12 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_12 + var_136_6
					end

					if var_136_8.prefab_name ~= "" and arg_133_1.actors_[var_136_8.prefab_name] ~= nil then
						local var_136_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_8.prefab_name].transform, "story_v_side_old_921011", "921011032", "story_v_side_old_921011.awb")

						arg_133_1:RecordAudio("921011032", var_136_13)
						arg_133_1:RecordAudio("921011032", var_136_13)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011032", "story_v_side_old_921011.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011032", "story_v_side_old_921011.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_14 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_14 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_14

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_14 and arg_133_1.time_ < var_136_6 + var_136_14 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
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

		arg_133_1:InitPlayNodeList()
	end,
	Play921011033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 921011033
		arg_137_1.duration_ = 11.83

		local var_137_0 = {
			zh = 8.733,
			ja = 11.833
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
				arg_137_0:Play921011034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 1.075

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:GetWordFromCfg(921011033)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 43 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 43)

				if (43 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 43)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011033", "story_v_side_old_921011.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011033", "story_v_side_old_921011.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_side_old_921011", "921011033", "story_v_side_old_921011.awb")

						arg_137_1:RecordAudio("921011033", var_140_6)
						arg_137_1:RecordAudio("921011033", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011033", "story_v_side_old_921011.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011033", "story_v_side_old_921011.awb")
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
	Play921011034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 921011034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play921011035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1066ui_story"]) and arg_141_1.var_.characterEffect1066ui_story == nil then
				arg_141_1.var_.characterEffect1066ui_story = arg_141_1.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1066ui_story"]) then
				if arg_141_1.var_.characterEffect1066ui_story and not isNil(arg_141_1.actors_["1066ui_story"]) then
					arg_141_1.var_.characterEffect1066ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_0)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1066ui_story"]) and arg_141_1.var_.characterEffect1066ui_story then
				arg_141_1.var_.characterEffect1066ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			local var_144_1 = 0
			local var_144_2 = 0.4

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_3 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(921011034).content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 16 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 16)

				if (16 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 16)) > 0 and var_144_2 < var_144_5 then
					arg_141_1.talkMaxDuration = var_144_5

					if var_144_5 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + var_144_1
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_6 = math.max(var_144_2, arg_141_1.talkMaxDuration)

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_6 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_1) / var_144_6

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_1 + var_144_6 and arg_141_1.time_ < var_144_1 + var_144_6 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play921011035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 921011035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play921011036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("1033ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_148_0 = 0
			local var_148_1 = 0.7

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_2 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(921011035).content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 28 <= 0 and var_148_1 or var_148_1 * (utf8.len(var_148_2) / 28)

				if (28 <= 0 and var_148_1 or var_148_1 * (utf8.len(var_148_2) / 28)) > 0 and var_148_1 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_5 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_5 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_5

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_5 and arg_145_1.time_ < var_148_0 + var_148_5 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play921011036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 921011036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play921011037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.2

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(921011036).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 8 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 8)

				if (8 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 8)) > 0 and var_152_0 < var_152_3 then
					arg_149_1.talkMaxDuration = var_152_3

					if var_152_3 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_3 + 0
					end
				end

				arg_149_1.text_.text = var_152_1
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_4 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_4

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play921011037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 921011037
		arg_153_1.duration_ = 2.1

		local var_153_0 = {
			zh = 2.1,
			ja = 1.999999999999
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
				arg_153_0:Play921011038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1066ui_story = arg_153_1.actors_["1066ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1066ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1066ui_story, Vector3.New(-0.7, -0.77, -6.1), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1066ui_story"].transform.position).z)
				arg_153_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1066ui_story"].transform.localEulerAngles = arg_153_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.77, -6.1)
				arg_153_1.actors_["1066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1066ui_story"].transform.position).z)
				arg_153_1.actors_["1066ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1066ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1066ui_story"].transform.localEulerAngles = arg_153_1.actors_["1066ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["1066ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1066ui_story == nil then
				arg_153_1.var_.characterEffect1066ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect1066ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1066ui_story then
				arg_153_1.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/story1066/story1066actionlink/1066action425")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_156_4 = 0
			local var_156_5 = 0.225

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:GetWordFromCfg(921011037)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 9 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 9)

				if (9 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 9)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011037", "story_v_side_old_921011.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011037", "story_v_side_old_921011.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_side_old_921011", "921011037", "story_v_side_old_921011.awb")

						arg_153_1:RecordAudio("921011037", var_156_11)
						arg_153_1:RecordAudio("921011037", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011037", "story_v_side_old_921011.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011037", "story_v_side_old_921011.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_12 and arg_153_1.time_ < var_156_4 + var_156_12 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
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

		arg_153_1:InitPlayNodeList()
	end,
	Play921011038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 921011038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play921011039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1033ui_story = arg_157_1.actors_["1033ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1033ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1033ui_story, Vector3.New(0, 100, 0), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1033ui_story"].transform.position).z)
				arg_157_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1033ui_story"].transform.localEulerAngles = arg_157_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1033ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.actors_["1033ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1033ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1033ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1033ui_story"].transform.position).z)
				arg_157_1.actors_["1033ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1033ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1033ui_story"].transform.localEulerAngles = arg_157_1.actors_["1033ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["1066ui_story"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1066ui_story = var_160_1.localPosition
			end

			local var_160_2 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 then
				var_160_1.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (arg_157_1.time_ - 0) / var_160_2)
				var_160_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_1.position).x, (manager.ui.mainCamera.transform.position - var_160_1.position).y, (manager.ui.mainCamera.transform.position - var_160_1.position).z)
				var_160_1.localEulerAngles.z = 0
				var_160_1.localEulerAngles.x = 0
				var_160_1.localEulerAngles = var_160_1.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 then
				var_160_1.localPosition = Vector3.New(0, 100, 0)
				var_160_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_160_1.position).x, (manager.ui.mainCamera.transform.position - var_160_1.position).y, (manager.ui.mainCamera.transform.position - var_160_1.position).z)
				var_160_1.localEulerAngles.z = 0
				var_160_1.localEulerAngles.x = 0
				var_160_1.localEulerAngles = var_160_1.localEulerAngles
			end

			if 0.133333333333333 < arg_157_1.time_ and arg_157_1.time_ <= 0.133333333333333 + arg_160_0 then
				arg_157_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_1033_dormancy", "")
			end

			local var_160_4 = 0
			local var_160_5 = 0.625

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(921011038).content)

				arg_157_1.text_.text = var_160_6

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_8 = 25 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_6) / 25)

				if (25 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_6) / 25)) > 0 and var_160_5 < var_160_8 then
					arg_157_1.talkMaxDuration = var_160_8

					if var_160_8 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_6
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_9 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_9 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_9

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_9 and arg_157_1.time_ < var_160_4 + var_160_9 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
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

		arg_157_1:InitPlayNodeList()
	end,
	Play921011039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 921011039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play921011040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0.95

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(921011039).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 38 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 38)

				if (38 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 38)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play921011040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 921011040
		arg_165_1.duration_ = 10

		local var_165_0 = {
			zh = 10,
			ja = 9.233
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play921011041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_0 = 1.26666666666667

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				local var_168_1 = Color.New(0, 0, 0)

				var_168_1.a = Mathf.Lerp(1, 0, (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.mask_.color = var_168_1
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				local var_168_2 = Color.New(0, 0, 0)

				arg_165_1.mask_.enabled = false
				var_168_2.a = 0
				arg_165_1.mask_.color = var_168_2
			end

			local var_168_3 = arg_165_1.actors_["1233"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				local var_168_4 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_168_4 then
					var_168_4.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_168_4.radialBlurScale = 0
					var_168_4.radialBlurGradient = 1
					var_168_4.radialBlurIntensity = 0.391

					if var_168_3 then
						var_168_4.radialBlurTarget = var_168_3.transform
					end
				end
			end

			local var_168_5 = 0.6

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_5 then
				local var_168_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_168_6 then
					var_168_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_168_6.radialBlurScale = Mathf.Lerp(0, 0, (arg_165_1.time_ - 0) / var_168_5)
					var_168_6.radialBlurGradient = Mathf.Lerp(1, 0.325, (arg_165_1.time_ - 0) / var_168_5)
					var_168_6.radialBlurIntensity = Mathf.Lerp(0.391, 0.27, (arg_165_1.time_ - 0) / var_168_5)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_5 and arg_165_1.time_ < 0 + var_168_5 + arg_168_0 then
				local var_168_7 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_168_7 then
					var_168_7.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_168_7.radialBlurScale = 0
					var_168_7.radialBlurGradient = 0.325
					var_168_7.radialBlurIntensity = 0.27
				end
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				local var_168_8 = arg_165_1.bgs_.ST2201

				arg_165_1.bgs_.ST2201.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_168_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_168_9 = var_168_8:GetComponent("SpriteRenderer")

				if var_168_9 and var_168_9.sprite then
					local var_168_10 = 2 * (var_168_8.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_168_8.transform.localScale = Vector3.New(var_168_10 / var_168_9.sprite.bounds.size.y < var_168_10 * manager.ui.mainCameraCom_.aspect / var_168_9.sprite.bounds.size.x and var_168_10 * manager.ui.mainCameraCom_.aspect / var_168_9.sprite.bounds.size.x or var_168_10 / var_168_9.sprite.bounds.size.y, var_168_10 / var_168_9.sprite.bounds.size.y < var_168_10 * manager.ui.mainCameraCom_.aspect / var_168_9.sprite.bounds.size.x and var_168_10 * manager.ui.mainCameraCom_.aspect / var_168_9.sprite.bounds.size.x or var_168_10 / var_168_9.sprite.bounds.size.y, 0)
				end

				for iter_168_0, iter_168_1 in pairs(arg_165_1.bgs_) do
					if iter_168_0 ~= "ST2201" then
						iter_168_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if arg_165_1.frameCnt_ <= 1 then
				arg_165_1.dialog_:SetActive(false)
			end

			local var_168_11 = 1.4
			local var_168_12 = 0.775

			if 1.4 < arg_165_1.time_ and arg_165_1.time_ <= var_168_11 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				arg_165_1.dialog_:SetActive(true)

				arg_165_1.dialogCg_.alpha = 0

				local var_168_13 = LeanTween.value(arg_165_1.dialog_, 0, 1, 0.3)

				var_168_13:setOnUpdate(LuaHelper.FloatAction(function(arg_169_0)
					arg_165_1.dialogCg_.alpha = arg_169_0
				end))
				var_168_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_165_1.dialog_)
					var_168_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_165_1.duration_ = arg_165_1.duration_ + 0.3

				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, true)
				arg_165_1.iconController_:SetSelectedState("hero")

				arg_165_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066_split_1")

				arg_165_1.callingController_:SetSelectedState("normal")

				arg_165_1.keyicon_.color = Color.New(1, 1, 1)
				arg_165_1.icon_.color = Color.New(1, 1, 1)

				local var_168_14 = arg_165_1:GetWordFromCfg(921011040)
				local var_168_15 = arg_165_1:FormatText(var_168_14.content)

				arg_165_1.text_.text = var_168_15

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_17 = 31 <= 0 and var_168_12 or var_168_12 * (utf8.len(var_168_15) / 31)

				if (31 <= 0 and var_168_12 or var_168_12 * (utf8.len(var_168_15) / 31)) > 0 and var_168_12 < var_168_17 then
					arg_165_1.talkMaxDuration = var_168_17
					var_168_11 = var_168_11 + 0.3

					if var_168_17 + var_168_11 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_17 + var_168_11
					end
				end

				arg_165_1.text_.text = var_168_15
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011040", "story_v_side_old_921011.awb") ~= 0 then
					local var_168_18 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011040", "story_v_side_old_921011.awb") / 1000

					if var_168_18 + var_168_11 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_18 + var_168_11
					end

					if var_168_14.prefab_name ~= "" and arg_165_1.actors_[var_168_14.prefab_name] ~= nil then
						local var_168_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_14.prefab_name].transform, "story_v_side_old_921011", "921011040", "story_v_side_old_921011.awb")

						arg_165_1:RecordAudio("921011040", var_168_19)
						arg_165_1:RecordAudio("921011040", var_168_19)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011040", "story_v_side_old_921011.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011040", "story_v_side_old_921011.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_20 = var_168_11 + 0.3
			local var_168_21 = math.max(var_168_12, arg_165_1.talkMaxDuration)

			if var_168_11 + 0.3 <= arg_165_1.time_ and arg_165_1.time_ < var_168_20 + var_168_21 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_20) / var_168_21

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_20 + var_168_21 and arg_165_1.time_ < var_168_20 + var_168_21 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play921011041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 921011041
		arg_171_1.duration_ = 6.77

		local var_171_0 = {
			zh = 4.2,
			ja = 6.766
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
				arg_171_0:Play921011042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.55

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_1 = arg_171_1:GetWordFromCfg(921011041)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 22 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 22)

				if (22 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 22)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011041", "story_v_side_old_921011.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011041", "story_v_side_old_921011.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_side_old_921011", "921011041", "story_v_side_old_921011.awb")

						arg_171_1:RecordAudio("921011041", var_174_6)
						arg_171_1:RecordAudio("921011041", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011041", "story_v_side_old_921011.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011041", "story_v_side_old_921011.awb")
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
	Play921011042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 921011042
		arg_175_1.duration_ = 4.5

		local var_175_0 = {
			zh = 4.5,
			ja = 4.366
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
				arg_175_0:Play921011043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.45

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1066_split_3")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_1 = arg_175_1:GetWordFromCfg(921011042)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 18 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 18)

				if (18 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 18)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011042", "story_v_side_old_921011.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011042", "story_v_side_old_921011.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_side_old_921011", "921011042", "story_v_side_old_921011.awb")

						arg_175_1:RecordAudio("921011042", var_178_6)
						arg_175_1:RecordAudio("921011042", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011042", "story_v_side_old_921011.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011042", "story_v_side_old_921011.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play921011043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 921011043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play921011044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_182_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_179_1.bgmTxt_.text ~= var_182_2 and arg_179_1.bgmTxt_.text ~= "" then
						if arg_179_1.bgmTxt2_.text ~= "" then
							arg_179_1.bgmTxt_.text = arg_179_1.bgmTxt2_.text
						end

						arg_179_1.bgmTxt2_.text = var_182_2

						arg_179_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_179_1.bgmTxt_.text = var_182_2
						arg_179_1.bgmTxt2_.text = var_182_2
					end

					if arg_179_1.bgmTimer then
						arg_179_1.bgmTimer:Stop()

						arg_179_1.bgmTimer = nil
					end

					if arg_179_1.settingData.show_music_name == 1 then
						arg_179_1.musicController:SetSelectedState("show")
						arg_179_1.musicAnimator_:Play("open", 0, 0)

						if arg_179_1.settingData.music_time ~= 0 then
							arg_179_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_179_1.settingData.music_time), function()
								if arg_179_1 == nil or isNil(arg_179_1.bgmTxt_) then
									return
								end

								arg_179_1.musicController:SetSelectedState("hide")
								arg_179_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_182_3 = 0
			local var_182_4 = 1.225

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_3 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_5 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(921011043).content)

				arg_179_1.text_.text = var_182_5

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_7 = 49 <= 0 and var_182_4 or var_182_4 * (utf8.len(var_182_5) / 49)

				if (49 <= 0 and var_182_4 or var_182_4 * (utf8.len(var_182_5) / 49)) > 0 and var_182_4 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_3 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_3
					end
				end

				arg_179_1.text_.text = var_182_5
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_8 = math.max(var_182_4, arg_179_1.talkMaxDuration)

			if var_182_3 <= arg_179_1.time_ and arg_179_1.time_ < var_182_3 + var_182_8 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_3) / var_182_8

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_3 + var_182_8 and arg_179_1.time_ < var_182_3 + var_182_8 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play921011044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 921011044
		arg_184_1.duration_ = 3.57

		local var_184_0 = {
			zh = 3.13266666666667,
			ja = 3.56666666666667
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play921011045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0.824999999999333 < arg_184_1.time_ and arg_184_1.time_ <= 0.824999999999333 + arg_187_0 then
				local var_187_0 = arg_184_1.bgs_.STblack

				arg_184_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_187_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_187_1 = var_187_0:GetComponent("SpriteRenderer")

				if var_187_1 and var_187_1.sprite then
					local var_187_2 = 2 * (var_187_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_187_0.transform.localScale = Vector3.New(var_187_2 / var_187_1.sprite.bounds.size.y < var_187_2 * manager.ui.mainCameraCom_.aspect / var_187_1.sprite.bounds.size.x and var_187_2 * manager.ui.mainCameraCom_.aspect / var_187_1.sprite.bounds.size.x or var_187_2 / var_187_1.sprite.bounds.size.y, var_187_2 / var_187_1.sprite.bounds.size.y < var_187_2 * manager.ui.mainCameraCom_.aspect / var_187_1.sprite.bounds.size.x and var_187_2 * manager.ui.mainCameraCom_.aspect / var_187_1.sprite.bounds.size.x or var_187_2 / var_187_1.sprite.bounds.size.y, 0)
				end

				for iter_187_0, iter_187_1 in pairs(arg_184_1.bgs_) do
					if iter_187_0 ~= "STblack" then
						iter_187_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_187_3 = 0

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_3 + arg_187_0 then
				arg_184_1.allBtn_.enabled = false
			end

			if arg_184_1.time_ >= var_187_3 + 0.3 and arg_184_1.time_ < var_187_3 + 0.3 + arg_187_0 then
				arg_184_1.allBtn_.enabled = true
			end

			local var_187_4 = 0

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1.mask_.enabled = true
				arg_184_1.mask_.raycastTarget = true

				arg_184_1:SetGaussion(false)
			end

			local var_187_5 = 0.824999999999333

			if var_187_4 <= arg_184_1.time_ and arg_184_1.time_ < var_187_4 + var_187_5 then
				local var_187_6 = Color.New(0, 0, 0)

				var_187_6.a = Mathf.Lerp(0, 1, (arg_184_1.time_ - var_187_4) / var_187_5)
				arg_184_1.mask_.color = var_187_6
			end

			if arg_184_1.time_ >= var_187_4 + var_187_5 and arg_184_1.time_ < var_187_4 + var_187_5 + arg_187_0 then
				local var_187_7 = Color.New(0, 0, 0)

				var_187_7.a = 1
				arg_184_1.mask_.color = var_187_7
			end

			local var_187_8 = 0.824999999999333

			if 0.824999999999333 < arg_184_1.time_ and arg_184_1.time_ <= var_187_8 + arg_187_0 then
				arg_184_1.mask_.enabled = true
				arg_184_1.mask_.raycastTarget = true

				arg_184_1:SetGaussion(false)
			end

			local var_187_9 = 1.14166666666733

			if var_187_8 <= arg_184_1.time_ and arg_184_1.time_ < var_187_8 + var_187_9 then
				local var_187_10 = Color.New(0, 0, 0)

				var_187_10.a = Mathf.Lerp(1, 0, (arg_184_1.time_ - var_187_8) / var_187_9)
				arg_184_1.mask_.color = var_187_10
			end

			if arg_184_1.time_ >= var_187_8 + var_187_9 and arg_184_1.time_ < var_187_8 + var_187_9 + arg_187_0 then
				local var_187_11 = Color.New(0, 0, 0)

				arg_184_1.mask_.enabled = false
				var_187_11.a = 0
				arg_184_1.mask_.color = var_187_11
			end

			local var_187_12 = arg_184_1.actors_["1233"]

			if 0.824999999999333 < arg_184_1.time_ and arg_184_1.time_ <= 0.824999999999333 + arg_187_0 then
				local var_187_13 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_187_13 then
					var_187_13.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_187_13.radialBlurScale = 0
					var_187_13.radialBlurGradient = 1
					var_187_13.radialBlurIntensity = 0.391

					if var_187_12 then
						var_187_13.radialBlurTarget = var_187_12.transform
					end
				end
			end

			local var_187_14 = 0.175000000000667

			if 0.824999999999333 <= arg_184_1.time_ and arg_184_1.time_ < 0.824999999999333 + var_187_14 then
				local var_187_15 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_187_15 then
					var_187_15.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_187_15.radialBlurScale = Mathf.Lerp(0, 0, (arg_184_1.time_ - 0.824999999999333) / var_187_14)
					var_187_15.radialBlurGradient = Mathf.Lerp(1, 0.325, (arg_184_1.time_ - 0.824999999999333) / var_187_14)
					var_187_15.radialBlurIntensity = Mathf.Lerp(0.391, 0.27, (arg_184_1.time_ - 0.824999999999333) / var_187_14)
				end
			end

			if arg_184_1.time_ >= 0.824999999999333 + var_187_14 and arg_184_1.time_ < 0.824999999999333 + var_187_14 + arg_187_0 then
				local var_187_16 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_187_16 then
					var_187_16.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_187_16.radialBlurScale = 0
					var_187_16.radialBlurGradient = 0.325
					var_187_16.radialBlurIntensity = 0.27
				end
			end

			if arg_184_1.frameCnt_ <= 1 then
				arg_184_1.dialog_:SetActive(false)
			end

			local var_187_17 = 1.96666666666667
			local var_187_18 = 0.325

			if 1.96666666666667 < arg_184_1.time_ and arg_184_1.time_ <= var_187_17 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0

				arg_184_1.dialog_:SetActive(true)

				arg_184_1.dialogCg_.alpha = 0

				local var_187_19 = LeanTween.value(arg_184_1.dialog_, 0, 1, 0.3)

				var_187_19:setOnUpdate(LuaHelper.FloatAction(function(arg_188_0)
					arg_184_1.dialogCg_.alpha = arg_188_0
				end))
				var_187_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_184_1.dialog_)
					var_187_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_184_1.duration_ = arg_184_1.duration_ + 0.3

				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_20 = arg_184_1:GetWordFromCfg(921011044)
				local var_187_21 = arg_184_1:FormatText(var_187_20.content)

				arg_184_1.text_.text = var_187_21

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_23 = 13 <= 0 and var_187_18 or var_187_18 * (utf8.len(var_187_21) / 13)

				if (13 <= 0 and var_187_18 or var_187_18 * (utf8.len(var_187_21) / 13)) > 0 and var_187_18 < var_187_23 then
					arg_184_1.talkMaxDuration = var_187_23
					var_187_17 = var_187_17 + 0.3

					if var_187_23 + var_187_17 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_23 + var_187_17
					end
				end

				arg_184_1.text_.text = var_187_21
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011044", "story_v_side_old_921011.awb") ~= 0 then
					local var_187_24 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011044", "story_v_side_old_921011.awb") / 1000

					if var_187_24 + var_187_17 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_24 + var_187_17
					end

					if var_187_20.prefab_name ~= "" and arg_184_1.actors_[var_187_20.prefab_name] ~= nil then
						local var_187_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_20.prefab_name].transform, "story_v_side_old_921011", "921011044", "story_v_side_old_921011.awb")

						arg_184_1:RecordAudio("921011044", var_187_25)
						arg_184_1:RecordAudio("921011044", var_187_25)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011044", "story_v_side_old_921011.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011044", "story_v_side_old_921011.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_26 = var_187_17 + 0.3
			local var_187_27 = math.max(var_187_18, arg_184_1.talkMaxDuration)

			if var_187_17 + 0.3 <= arg_184_1.time_ and arg_184_1.time_ < var_187_26 + var_187_27 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_26) / var_187_27

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_26 + var_187_27 and arg_184_1.time_ < var_187_26 + var_187_27 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play921011045 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 921011045
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play921011046(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0.975

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

				local var_193_1 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(921011045).content)

				arg_190_1.text_.text = var_193_1

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_3 = 39 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_1) / 39)

				if (39 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_1) / 39)) > 0 and var_193_0 < var_193_3 then
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
	Play921011046 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 921011046
		arg_194_1.duration_ = 7.68

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play921011047(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0.733333333335334 < arg_194_1.time_ and arg_194_1.time_ <= 0.733333333335334 + arg_197_0 then
				local var_197_0 = arg_194_1.bgs_.ST60

				arg_194_1.bgs_.ST60.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_197_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_197_1 = var_197_0:GetComponent("SpriteRenderer")

				if var_197_1 and var_197_1.sprite then
					local var_197_2 = 2 * (var_197_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_197_0.transform.localScale = Vector3.New(var_197_2 / var_197_1.sprite.bounds.size.y < var_197_2 * manager.ui.mainCameraCom_.aspect / var_197_1.sprite.bounds.size.x and var_197_2 * manager.ui.mainCameraCom_.aspect / var_197_1.sprite.bounds.size.x or var_197_2 / var_197_1.sprite.bounds.size.y, var_197_2 / var_197_1.sprite.bounds.size.y < var_197_2 * manager.ui.mainCameraCom_.aspect / var_197_1.sprite.bounds.size.x and var_197_2 * manager.ui.mainCameraCom_.aspect / var_197_1.sprite.bounds.size.x or var_197_2 / var_197_1.sprite.bounds.size.y, 0)
				end

				for iter_197_0, iter_197_1 in pairs(arg_194_1.bgs_) do
					if iter_197_0 ~= "ST60" then
						iter_197_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_197_3 = 0

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_3 + arg_197_0 then
				arg_194_1.mask_.enabled = true
				arg_194_1.mask_.raycastTarget = true

				arg_194_1:SetGaussion(false)
			end

			local var_197_4 = 0.733333333334333

			if var_197_3 <= arg_194_1.time_ and arg_194_1.time_ < var_197_3 + var_197_4 then
				local var_197_5 = Color.New(0, 0, 0)

				var_197_5.a = Mathf.Lerp(0, 1, (arg_194_1.time_ - var_197_3) / var_197_4)
				arg_194_1.mask_.color = var_197_5
			end

			if arg_194_1.time_ >= var_197_3 + var_197_4 and arg_194_1.time_ < var_197_3 + var_197_4 + arg_197_0 then
				local var_197_6 = Color.New(0, 0, 0)

				var_197_6.a = 1
				arg_194_1.mask_.color = var_197_6
			end

			local var_197_7 = 0.733333333334333

			if 0.733333333334333 < arg_194_1.time_ and arg_194_1.time_ <= var_197_7 + arg_197_0 then
				arg_194_1.mask_.enabled = true
				arg_194_1.mask_.raycastTarget = true

				arg_194_1:SetGaussion(false)
			end

			local var_197_8 = 2

			if var_197_7 <= arg_194_1.time_ and arg_194_1.time_ < var_197_7 + var_197_8 then
				local var_197_9 = Color.New(0, 0, 0)

				var_197_9.a = Mathf.Lerp(1, 0, (arg_194_1.time_ - var_197_7) / var_197_8)
				arg_194_1.mask_.color = var_197_9
			end

			if arg_194_1.time_ >= var_197_7 + var_197_8 and arg_194_1.time_ < var_197_7 + var_197_8 + arg_197_0 then
				local var_197_10 = Color.New(0, 0, 0)

				arg_194_1.mask_.enabled = false
				var_197_10.a = 0
				arg_194_1.mask_.color = var_197_10
			end

			if 0.733333333334333 < arg_194_1.time_ and arg_194_1.time_ <= 0.733333333334333 + arg_197_0 then
				arg_194_1:AudioAction("play", "music", "bgm_activity_3_7_scene_109502_day", "bgm_activity_3_7_scene_109502_day", "bgm_activity_3_7_scene_109502_day.awb")

				local var_197_13 = manager.audio:GetAudioName("bgm_activity_3_7_scene_109502_day", "bgm_activity_3_7_scene_109502_day")

				if "" ~= "" then
					if arg_194_1.bgmTxt_.text ~= var_197_13 and arg_194_1.bgmTxt_.text ~= "" then
						if arg_194_1.bgmTxt2_.text ~= "" then
							arg_194_1.bgmTxt_.text = arg_194_1.bgmTxt2_.text
						end

						arg_194_1.bgmTxt2_.text = var_197_13

						arg_194_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_194_1.bgmTxt_.text = var_197_13
						arg_194_1.bgmTxt2_.text = var_197_13
					end

					if arg_194_1.bgmTimer then
						arg_194_1.bgmTimer:Stop()

						arg_194_1.bgmTimer = nil
					end

					if arg_194_1.settingData.show_music_name == 1 then
						arg_194_1.musicController:SetSelectedState("show")
						arg_194_1.musicAnimator_:Play("open", 0, 0)

						if arg_194_1.settingData.music_time ~= 0 then
							arg_194_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_194_1.settingData.music_time), function()
								if arg_194_1 == nil or isNil(arg_194_1.bgmTxt_) then
									return
								end

								arg_194_1.musicController:SetSelectedState("hide")
								arg_194_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_194_1.frameCnt_ <= 1 then
				arg_194_1.dialog_:SetActive(false)
			end

			local var_197_14 = 2.68333333333533
			local var_197_15 = 0.05

			if 2.68333333333533 < arg_194_1.time_ and arg_194_1.time_ <= var_197_14 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0

				arg_194_1.dialog_:SetActive(true)

				arg_194_1.dialogCg_.alpha = 0

				local var_197_16 = LeanTween.value(arg_194_1.dialog_, 0, 1, 0.3)

				var_197_16:setOnUpdate(LuaHelper.FloatAction(function(arg_199_0)
					arg_194_1.dialogCg_.alpha = arg_199_0
				end))
				var_197_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_194_1.dialog_)
					var_197_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_194_1.duration_ = arg_194_1.duration_ + 0.3

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

				local var_197_17 = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(921011046).content)

				arg_194_1.text_.text = var_197_17

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_19 = 2 <= 0 and var_197_15 or var_197_15 * (utf8.len(var_197_17) / 2)

				if (2 <= 0 and var_197_15 or var_197_15 * (utf8.len(var_197_17) / 2)) > 0 and var_197_15 < var_197_19 then
					arg_194_1.talkMaxDuration = var_197_19
					var_197_14 = var_197_14 + 0.3

					if var_197_19 + var_197_14 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_19 + var_197_14
					end
				end

				arg_194_1.text_.text = var_197_17
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_20 = var_197_14 + 0.3
			local var_197_21 = math.max(var_197_15, arg_194_1.talkMaxDuration)

			if var_197_14 + 0.3 <= arg_194_1.time_ and arg_194_1.time_ < var_197_20 + var_197_21 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_20) / var_197_21

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_20 + var_197_21 and arg_194_1.time_ < var_197_20 + var_197_21 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play921011047 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 921011047
		arg_201_1.duration_ = 3.07

		local var_201_0 = {
			zh = 3.066,
			ja = 1.999999999999
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
				arg_201_0:Play921011048(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if arg_201_1.actors_["10124ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10124ui_story"))) then
				local var_204_0 = Object.Instantiate(Asset.Load("Char/" .. "10124ui_story"), arg_201_1.stage_.transform)

				var_204_0.name = "10124ui_story"
				var_204_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_201_1.actors_["10124ui_story"] = var_204_0

				local var_204_1 = var_204_0:GetComponentInChildren(typeof(CharacterEffect))

				var_204_1.enabled = true

				local var_204_2 = GameObjectTools.GetOrAddComponent(var_204_0, typeof(DynamicBoneHelper))

				if var_204_2 then
					var_204_2:EnableDynamicBone(false)
				end

				arg_201_1:ShowWeapon(var_204_1.transform, false)

				arg_201_1.var_["10124ui_story" .. "Animator"] = var_204_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_201_1.var_["10124ui_story" .. "Animator"].applyRootMotion = true
				arg_201_1.var_["10124ui_story" .. "LipSync"] = var_204_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_204_3 = arg_201_1.actors_["10124ui_story"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos10124ui_story = var_204_3.localPosition
			end

			local var_204_4 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				var_204_3.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10124ui_story, Vector3.New(0, -0.98, -6.08), (arg_201_1.time_ - 0) / var_204_4)
				var_204_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_3.position).x, (manager.ui.mainCamera.transform.position - var_204_3.position).y, (manager.ui.mainCamera.transform.position - var_204_3.position).z)
				var_204_3.localEulerAngles.z = 0
				var_204_3.localEulerAngles.x = 0
				var_204_3.localEulerAngles = var_204_3.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				var_204_3.localPosition = Vector3.New(0, -0.98, -6.08)
				var_204_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_3.position).x, (manager.ui.mainCamera.transform.position - var_204_3.position).y, (manager.ui.mainCamera.transform.position - var_204_3.position).z)
				var_204_3.localEulerAngles.z = 0
				var_204_3.localEulerAngles.x = 0
				var_204_3.localEulerAngles = var_204_3.localEulerAngles
			end

			local var_204_5 = arg_201_1.actors_["10124ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_5) and arg_201_1.var_.characterEffect10124ui_story == nil then
				arg_201_1.var_.characterEffect10124ui_story = var_204_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_6 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_6 and not isNil(var_204_5) then
				if arg_201_1.var_.characterEffect10124ui_story and not isNil(var_204_5) then
					arg_201_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_6 and arg_201_1.time_ < 0 + var_204_6 + arg_204_0 and not isNil(var_204_5) and arg_201_1.var_.characterEffect10124ui_story then
				arg_201_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action1_1")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanL", "EmotionTimelineAnimator")
			end

			local var_204_8 = 0
			local var_204_9 = 0.05

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

				local var_204_10 = arg_201_1:GetWordFromCfg(921011047)
				local var_204_11 = arg_201_1:FormatText(var_204_10.content)

				arg_201_1.text_.text = var_204_11

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_13 = 2 <= 0 and var_204_9 or var_204_9 * (utf8.len(var_204_11) / 2)

				if (2 <= 0 and var_204_9 or var_204_9 * (utf8.len(var_204_11) / 2)) > 0 and var_204_9 < var_204_13 then
					arg_201_1.talkMaxDuration = var_204_13

					if var_204_13 + var_204_8 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_13 + var_204_8
					end
				end

				arg_201_1.text_.text = var_204_11
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011047", "story_v_side_old_921011.awb") ~= 0 then
					local var_204_14 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011047", "story_v_side_old_921011.awb") / 1000

					if var_204_14 + var_204_8 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_14 + var_204_8
					end

					if var_204_10.prefab_name ~= "" and arg_201_1.actors_[var_204_10.prefab_name] ~= nil then
						local var_204_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_10.prefab_name].transform, "story_v_side_old_921011", "921011047", "story_v_side_old_921011.awb")

						arg_201_1:RecordAudio("921011047", var_204_15)
						arg_201_1:RecordAudio("921011047", var_204_15)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011047", "story_v_side_old_921011.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011047", "story_v_side_old_921011.awb")
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
				actorName = "10124ui_story",
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
	Play921011048 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 921011048
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play921011049(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos10124ui_story = arg_205_1.actors_["10124ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["10124ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10124ui_story, Vector3.New(0, 100, 0), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["10124ui_story"].transform.position).z)
				arg_205_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["10124ui_story"].transform.localEulerAngles = arg_205_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["10124ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_205_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["10124ui_story"].transform.position).z)
				arg_205_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["10124ui_story"].transform.localEulerAngles = arg_205_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			local var_208_1 = 0
			local var_208_2 = 0.975

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_3 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(921011048).content)

				arg_205_1.text_.text = var_208_3

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 39 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 39)

				if (39 <= 0 and var_208_2 or var_208_2 * (utf8.len(var_208_3) / 39)) > 0 and var_208_2 < var_208_5 then
					arg_205_1.talkMaxDuration = var_208_5

					if var_208_5 + var_208_1 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + var_208_1
					end
				end

				arg_205_1.text_.text = var_208_3
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_6 = math.max(var_208_2, arg_205_1.talkMaxDuration)

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_6 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_1) / var_208_6

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_1 + var_208_6 and arg_205_1.time_ < var_208_1 + var_208_6 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10124ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play921011049 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 921011049
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play921011050(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 1.075

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_1 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(921011049).content)

				arg_209_1.text_.text = var_212_1

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_3 = 43 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 43)

				if (43 <= 0 and var_212_0 or var_212_0 * (utf8.len(var_212_1) / 43)) > 0 and var_212_0 < var_212_3 then
					arg_209_1.talkMaxDuration = var_212_3

					if var_212_3 + 0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_3 + 0
					end
				end

				arg_209_1.text_.text = var_212_1
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_4 = math.max(var_212_0, arg_209_1.talkMaxDuration)

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - 0) / var_212_4

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play921011050 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 921011050
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play921011051(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.85

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(921011050).content)

				arg_213_1.text_.text = var_216_1

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_3 = 34 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 34)

				if (34 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_1) / 34)) > 0 and var_216_0 < var_216_3 then
					arg_213_1.talkMaxDuration = var_216_3

					if var_216_3 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_3 + 0
					end
				end

				arg_213_1.text_.text = var_216_1
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_4 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_4

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play921011051 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 921011051
		arg_217_1.duration_ = 5.27

		local var_217_0 = {
			zh = 3.066,
			ja = 5.266
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
				arg_217_0:Play921011052(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos10124ui_story = arg_217_1.actors_["10124ui_story"].transform.localPosition
			end

			local var_220_0 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 then
				arg_217_1.actors_["10124ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10124ui_story, Vector3.New(0, -0.98, -6.08), (arg_217_1.time_ - 0) / var_220_0)
				arg_217_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["10124ui_story"].transform.position).z)
				arg_217_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["10124ui_story"].transform.localEulerAngles = arg_217_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 then
				arg_217_1.actors_["10124ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.08)
				arg_217_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["10124ui_story"].transform.position).z)
				arg_217_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["10124ui_story"].transform.localEulerAngles = arg_217_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			local var_220_1 = arg_217_1.actors_["10124ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect10124ui_story == nil then
				arg_217_1.var_.characterEffect10124ui_story = var_220_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_2 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_2 and not isNil(var_220_1) then
				if arg_217_1.var_.characterEffect10124ui_story and not isNil(var_220_1) then
					arg_217_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_2 and arg_217_1.time_ < 0 + var_220_2 + arg_220_0 and not isNil(var_220_1) and arg_217_1.var_.characterEffect10124ui_story then
				arg_217_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action3_1")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_220_4 = 0
			local var_220_5 = 0.3

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_4 + arg_220_0 then
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

				local var_220_6 = arg_217_1:GetWordFromCfg(921011051)
				local var_220_7 = arg_217_1:FormatText(var_220_6.content)

				arg_217_1.text_.text = var_220_7

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_9 = 12 <= 0 and var_220_5 or var_220_5 * (utf8.len(var_220_7) / 12)

				if (12 <= 0 and var_220_5 or var_220_5 * (utf8.len(var_220_7) / 12)) > 0 and var_220_5 < var_220_9 then
					arg_217_1.talkMaxDuration = var_220_9

					if var_220_9 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_9 + var_220_4
					end
				end

				arg_217_1.text_.text = var_220_7
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011051", "story_v_side_old_921011.awb") ~= 0 then
					local var_220_10 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011051", "story_v_side_old_921011.awb") / 1000

					if var_220_10 + var_220_4 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_10 + var_220_4
					end

					if var_220_6.prefab_name ~= "" and arg_217_1.actors_[var_220_6.prefab_name] ~= nil then
						local var_220_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_6.prefab_name].transform, "story_v_side_old_921011", "921011051", "story_v_side_old_921011.awb")

						arg_217_1:RecordAudio("921011051", var_220_11)
						arg_217_1:RecordAudio("921011051", var_220_11)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011051", "story_v_side_old_921011.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011051", "story_v_side_old_921011.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_12 = math.max(var_220_5, arg_217_1.talkMaxDuration)

			if var_220_4 <= arg_217_1.time_ and arg_217_1.time_ < var_220_4 + var_220_12 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_4) / var_220_12

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_4 + var_220_12 and arg_217_1.time_ < var_220_4 + var_220_12 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10124ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play921011052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 921011052
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play921011053(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["10124ui_story"]) and arg_221_1.var_.characterEffect10124ui_story == nil then
				arg_221_1.var_.characterEffect10124ui_story = arg_221_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["10124ui_story"]) then
				if arg_221_1.var_.characterEffect10124ui_story and not isNil(arg_221_1.actors_["10124ui_story"]) then
					arg_221_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_221_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_0)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["10124ui_story"]) and arg_221_1.var_.characterEffect10124ui_story then
				arg_221_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_221_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_224_1 = 0
			local var_224_2 = 0.3

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_3 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(921011052).content)

				arg_221_1.text_.text = var_224_3

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 12 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_3) / 12)

				if (12 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_3) / 12)) > 0 and var_224_2 < var_224_5 then
					arg_221_1.talkMaxDuration = var_224_5

					if var_224_5 + var_224_1 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + var_224_1
					end
				end

				arg_221_1.text_.text = var_224_3
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_6 = math.max(var_224_2, arg_221_1.talkMaxDuration)

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_6 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_1) / var_224_6

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_1 + var_224_6 and arg_221_1.time_ < var_224_1 + var_224_6 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play921011053 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 921011053
		arg_225_1.duration_ = 2.73

		local var_225_0 = {
			zh = 2.466,
			ja = 2.733
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play921011054(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["10124ui_story"]) and arg_225_1.var_.characterEffect10124ui_story == nil then
				arg_225_1.var_.characterEffect10124ui_story = arg_225_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["10124ui_story"]) then
				if arg_225_1.var_.characterEffect10124ui_story and not isNil(arg_225_1.actors_["10124ui_story"]) then
					arg_225_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["10124ui_story"]) and arg_225_1.var_.characterEffect10124ui_story then
				arg_225_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			local var_228_2 = 0
			local var_228_3 = 0.2

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_2 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_4 = arg_225_1:GetWordFromCfg(921011053)
				local var_228_5 = arg_225_1:FormatText(var_228_4.content)

				arg_225_1.text_.text = var_228_5

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_7 = 8 <= 0 and var_228_3 or var_228_3 * (utf8.len(var_228_5) / 8)

				if (8 <= 0 and var_228_3 or var_228_3 * (utf8.len(var_228_5) / 8)) > 0 and var_228_3 < var_228_7 then
					arg_225_1.talkMaxDuration = var_228_7

					if var_228_7 + var_228_2 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_7 + var_228_2
					end
				end

				arg_225_1.text_.text = var_228_5
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011053", "story_v_side_old_921011.awb") ~= 0 then
					local var_228_8 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011053", "story_v_side_old_921011.awb") / 1000

					if var_228_8 + var_228_2 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_2
					end

					if var_228_4.prefab_name ~= "" and arg_225_1.actors_[var_228_4.prefab_name] ~= nil then
						local var_228_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_4.prefab_name].transform, "story_v_side_old_921011", "921011053", "story_v_side_old_921011.awb")

						arg_225_1:RecordAudio("921011053", var_228_9)
						arg_225_1:RecordAudio("921011053", var_228_9)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011053", "story_v_side_old_921011.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011053", "story_v_side_old_921011.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_10 = math.max(var_228_3, arg_225_1.talkMaxDuration)

			if var_228_2 <= arg_225_1.time_ and arg_225_1.time_ < var_228_2 + var_228_10 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_2) / var_228_10

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_2 + var_228_10 and arg_225_1.time_ < var_228_2 + var_228_10 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play921011054 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 921011054
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play921011055(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["10124ui_story"]) and arg_229_1.var_.characterEffect10124ui_story == nil then
				arg_229_1.var_.characterEffect10124ui_story = arg_229_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["10124ui_story"]) then
				if arg_229_1.var_.characterEffect10124ui_story and not isNil(arg_229_1.actors_["10124ui_story"]) then
					arg_229_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_229_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_0)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["10124ui_story"]) and arg_229_1.var_.characterEffect10124ui_story then
				arg_229_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_229_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_232_1 = 0
			local var_232_2 = 0.125

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(921011054).content)

				arg_229_1.text_.text = var_232_3

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 5 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 5)

				if (5 <= 0 and var_232_2 or var_232_2 * (utf8.len(var_232_3) / 5)) > 0 and var_232_2 < var_232_5 then
					arg_229_1.talkMaxDuration = var_232_5

					if var_232_5 + var_232_1 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_5 + var_232_1
					end
				end

				arg_229_1.text_.text = var_232_3
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_6 = math.max(var_232_2, arg_229_1.talkMaxDuration)

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_6 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_1) / var_232_6

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_1 + var_232_6 and arg_229_1.time_ < var_232_1 + var_232_6 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play921011055 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 921011055
		arg_233_1.duration_ = 3.47

		local var_233_0 = {
			zh = 2.4,
			ja = 3.466
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play921011056(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos10124ui_story = arg_233_1.actors_["10124ui_story"].transform.localPosition
			end

			local var_236_0 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 then
				arg_233_1.actors_["10124ui_story"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10124ui_story, Vector3.New(0, -0.98, -6.08), (arg_233_1.time_ - 0) / var_236_0)
				arg_233_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["10124ui_story"].transform.position).z)
				arg_233_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["10124ui_story"].transform.localEulerAngles = arg_233_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 then
				arg_233_1.actors_["10124ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.08)
				arg_233_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_233_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_233_1.actors_["10124ui_story"].transform.position).z)
				arg_233_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_233_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_233_1.actors_["10124ui_story"].transform.localEulerAngles = arg_233_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			local var_236_1 = arg_233_1.actors_["10124ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect10124ui_story == nil then
				arg_233_1.var_.characterEffect10124ui_story = var_236_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_2 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_2 and not isNil(var_236_1) then
				if arg_233_1.var_.characterEffect10124ui_story and not isNil(var_236_1) then
					arg_233_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_2 and arg_233_1.time_ < 0 + var_236_2 + arg_236_0 and not isNil(var_236_1) and arg_233_1.var_.characterEffect10124ui_story then
				arg_233_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action3_2")
			end

			local var_236_4 = 0
			local var_236_5 = 0.275

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_6 = arg_233_1:GetWordFromCfg(921011055)
				local var_236_7 = arg_233_1:FormatText(var_236_6.content)

				arg_233_1.text_.text = var_236_7

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_9 = 11 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 11)

				if (11 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_7) / 11)) > 0 and var_236_5 < var_236_9 then
					arg_233_1.talkMaxDuration = var_236_9

					if var_236_9 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_9 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_7
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011055", "story_v_side_old_921011.awb") ~= 0 then
					local var_236_10 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011055", "story_v_side_old_921011.awb") / 1000

					if var_236_10 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_10 + var_236_4
					end

					if var_236_6.prefab_name ~= "" and arg_233_1.actors_[var_236_6.prefab_name] ~= nil then
						local var_236_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_6.prefab_name].transform, "story_v_side_old_921011", "921011055", "story_v_side_old_921011.awb")

						arg_233_1:RecordAudio("921011055", var_236_11)
						arg_233_1:RecordAudio("921011055", var_236_11)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011055", "story_v_side_old_921011.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011055", "story_v_side_old_921011.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_12 = math.max(var_236_5, arg_233_1.talkMaxDuration)

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_12 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_4) / var_236_12

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_4 + var_236_12 and arg_233_1.time_ < var_236_4 + var_236_12 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10124ui_story",
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
	Play921011056 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 921011056
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play921011057(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["10124ui_story"]) and arg_237_1.var_.characterEffect10124ui_story == nil then
				arg_237_1.var_.characterEffect10124ui_story = arg_237_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["10124ui_story"]) then
				if arg_237_1.var_.characterEffect10124ui_story and not isNil(arg_237_1.actors_["10124ui_story"]) then
					arg_237_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_237_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_0)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["10124ui_story"]) and arg_237_1.var_.characterEffect10124ui_story then
				arg_237_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_237_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_240_1 = 0
			local var_240_2 = 0.65

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, true)
				arg_237_1.iconController_:SetSelectedState("hero")

				arg_237_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_237_1.callingController_:SetSelectedState("normal")

				arg_237_1.keyicon_.color = Color.New(1, 1, 1)
				arg_237_1.icon_.color = Color.New(1, 1, 1)

				local var_240_3 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(921011056).content)

				arg_237_1.text_.text = var_240_3

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 26 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 26)

				if (26 <= 0 and var_240_2 or var_240_2 * (utf8.len(var_240_3) / 26)) > 0 and var_240_2 < var_240_5 then
					arg_237_1.talkMaxDuration = var_240_5

					if var_240_5 + var_240_1 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_5 + var_240_1
					end
				end

				arg_237_1.text_.text = var_240_3
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_6 = math.max(var_240_2, arg_237_1.talkMaxDuration)

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_6 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_1) / var_240_6

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_1 + var_240_6 and arg_237_1.time_ < var_240_1 + var_240_6 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play921011057 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 921011057
		arg_241_1.duration_ = 9.9

		local var_241_0 = {
			zh = 7.5,
			ja = 9.9
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play921011058(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["10124ui_story"]) and arg_241_1.var_.characterEffect10124ui_story == nil then
				arg_241_1.var_.characterEffect10124ui_story = arg_241_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["10124ui_story"]) then
				if arg_241_1.var_.characterEffect10124ui_story and not isNil(arg_241_1.actors_["10124ui_story"]) then
					arg_241_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["10124ui_story"]) and arg_241_1.var_.characterEffect10124ui_story then
				arg_241_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			local var_244_2 = 0
			local var_244_3 = 0.6

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_2 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_4 = arg_241_1:GetWordFromCfg(921011057)
				local var_244_5 = arg_241_1:FormatText(var_244_4.content)

				arg_241_1.text_.text = var_244_5

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_7 = 24 <= 0 and var_244_3 or var_244_3 * (utf8.len(var_244_5) / 24)

				if (24 <= 0 and var_244_3 or var_244_3 * (utf8.len(var_244_5) / 24)) > 0 and var_244_3 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_2 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_2
					end
				end

				arg_241_1.text_.text = var_244_5
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011057", "story_v_side_old_921011.awb") ~= 0 then
					local var_244_8 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011057", "story_v_side_old_921011.awb") / 1000

					if var_244_8 + var_244_2 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_2
					end

					if var_244_4.prefab_name ~= "" and arg_241_1.actors_[var_244_4.prefab_name] ~= nil then
						local var_244_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_4.prefab_name].transform, "story_v_side_old_921011", "921011057", "story_v_side_old_921011.awb")

						arg_241_1:RecordAudio("921011057", var_244_9)
						arg_241_1:RecordAudio("921011057", var_244_9)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011057", "story_v_side_old_921011.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011057", "story_v_side_old_921011.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_10 = math.max(var_244_3, arg_241_1.talkMaxDuration)

			if var_244_2 <= arg_241_1.time_ and arg_241_1.time_ < var_244_2 + var_244_10 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_2) / var_244_10

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_2 + var_244_10 and arg_241_1.time_ < var_244_2 + var_244_10 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play921011058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 921011058
		arg_245_1.duration_ = 7.6

		local var_245_0 = {
			zh = 4.933,
			ja = 7.6
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
				arg_245_0:Play921011059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.var_.moveOldPos10124ui_story = arg_245_1.actors_["10124ui_story"].transform.localPosition
			end

			local var_248_0 = 0.001

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 then
				arg_245_1.actors_["10124ui_story"].transform.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos10124ui_story, Vector3.New(0, -0.98, -6.08), (arg_245_1.time_ - 0) / var_248_0)
				arg_245_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["10124ui_story"].transform.position).z)
				arg_245_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["10124ui_story"].transform.localEulerAngles = arg_245_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 then
				arg_245_1.actors_["10124ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.08)
				arg_245_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_245_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_245_1.actors_["10124ui_story"].transform.position).z)
				arg_245_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_245_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_245_1.actors_["10124ui_story"].transform.localEulerAngles = arg_245_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action2_1")
			end

			local var_248_1 = 0
			local var_248_2 = 0.65

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_3 = arg_245_1:GetWordFromCfg(921011058)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_6 = 26 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_4) / 26)

				if (26 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_4) / 26)) > 0 and var_248_2 < var_248_6 then
					arg_245_1.talkMaxDuration = var_248_6

					if var_248_6 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_1
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011058", "story_v_side_old_921011.awb") ~= 0 then
					local var_248_7 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011058", "story_v_side_old_921011.awb") / 1000

					if var_248_7 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_1
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_side_old_921011", "921011058", "story_v_side_old_921011.awb")

						arg_245_1:RecordAudio("921011058", var_248_8)
						arg_245_1:RecordAudio("921011058", var_248_8)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011058", "story_v_side_old_921011.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011058", "story_v_side_old_921011.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_9 = math.max(var_248_2, arg_245_1.talkMaxDuration)

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_9 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_1) / var_248_9

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_1 + var_248_9 and arg_245_1.time_ < var_248_1 + var_248_9 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10124ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play921011059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 921011059
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play921011060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["10124ui_story"]) and arg_249_1.var_.characterEffect10124ui_story == nil then
				arg_249_1.var_.characterEffect10124ui_story = arg_249_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["10124ui_story"]) then
				if arg_249_1.var_.characterEffect10124ui_story and not isNil(arg_249_1.actors_["10124ui_story"]) then
					arg_249_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_249_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_249_1.time_ - 0) / var_252_0)
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["10124ui_story"]) and arg_249_1.var_.characterEffect10124ui_story then
				arg_249_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_249_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_252_1 = 0
			local var_252_2 = 0.3

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_3 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(921011059).content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_5 = 12 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 12)

				if (12 <= 0 and var_252_2 or var_252_2 * (utf8.len(var_252_3) / 12)) > 0 and var_252_2 < var_252_5 then
					arg_249_1.talkMaxDuration = var_252_5

					if var_252_5 + var_252_1 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + var_252_1
					end
				end

				arg_249_1.text_.text = var_252_3
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_6 = math.max(var_252_2, arg_249_1.talkMaxDuration)

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_6 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_1) / var_252_6

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_1 + var_252_6 and arg_249_1.time_ < var_252_1 + var_252_6 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play921011060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 921011060
		arg_253_1.duration_ = 9.07

		local var_253_0 = {
			zh = 9.066,
			ja = 6.233
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
				arg_253_0:Play921011061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["10124ui_story"]) and arg_253_1.var_.characterEffect10124ui_story == nil then
				arg_253_1.var_.characterEffect10124ui_story = arg_253_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_0 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["10124ui_story"]) then
				if arg_253_1.var_.characterEffect10124ui_story and not isNil(arg_253_1.actors_["10124ui_story"]) then
					arg_253_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["10124ui_story"]) and arg_253_1.var_.characterEffect10124ui_story then
				arg_253_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			local var_256_2 = 0
			local var_256_3 = 0.875

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_2 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_4 = arg_253_1:GetWordFromCfg(921011060)
				local var_256_5 = arg_253_1:FormatText(var_256_4.content)

				arg_253_1.text_.text = var_256_5

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_7 = 35 <= 0 and var_256_3 or var_256_3 * (utf8.len(var_256_5) / 35)

				if (35 <= 0 and var_256_3 or var_256_3 * (utf8.len(var_256_5) / 35)) > 0 and var_256_3 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_2 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_2
					end
				end

				arg_253_1.text_.text = var_256_5
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011060", "story_v_side_old_921011.awb") ~= 0 then
					local var_256_8 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011060", "story_v_side_old_921011.awb") / 1000

					if var_256_8 + var_256_2 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_8 + var_256_2
					end

					if var_256_4.prefab_name ~= "" and arg_253_1.actors_[var_256_4.prefab_name] ~= nil then
						local var_256_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_4.prefab_name].transform, "story_v_side_old_921011", "921011060", "story_v_side_old_921011.awb")

						arg_253_1:RecordAudio("921011060", var_256_9)
						arg_253_1:RecordAudio("921011060", var_256_9)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011060", "story_v_side_old_921011.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011060", "story_v_side_old_921011.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_10 = math.max(var_256_3, arg_253_1.talkMaxDuration)

			if var_256_2 <= arg_253_1.time_ and arg_253_1.time_ < var_256_2 + var_256_10 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_2) / var_256_10

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_2 + var_256_10 and arg_253_1.time_ < var_256_2 + var_256_10 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play921011061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 921011061
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play921011062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos10124ui_story = arg_257_1.actors_["10124ui_story"].transform.localPosition
			end

			local var_260_0 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 then
				arg_257_1.actors_["10124ui_story"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10124ui_story, Vector3.New(0, 100, 0), (arg_257_1.time_ - 0) / var_260_0)
				arg_257_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10124ui_story"].transform.position).z)
				arg_257_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["10124ui_story"].transform.localEulerAngles = arg_257_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 then
				arg_257_1.actors_["10124ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_257_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_257_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_257_1.actors_["10124ui_story"].transform.position).z)
				arg_257_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_257_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_257_1.actors_["10124ui_story"].transform.localEulerAngles = arg_257_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			local var_260_1 = 0
			local var_260_2 = 1.075

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

				local var_260_3 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(921011061).content)

				arg_257_1.text_.text = var_260_3

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 43 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_3) / 43)

				if (43 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_3) / 43)) > 0 and var_260_2 < var_260_5 then
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

		arg_257_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10124ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_257_1:InitPlayNodeList()
	end,
	Play921011062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 921011062
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play921011063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.7

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_1 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(921011062).content)

				arg_261_1.text_.text = var_264_1

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_3 = 28 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 28)

				if (28 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 28)) > 0 and var_264_0 < var_264_3 then
					arg_261_1.talkMaxDuration = var_264_3

					if var_264_3 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_3 + 0
					end
				end

				arg_261_1.text_.text = var_264_1
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_4 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_4

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play921011063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 921011063
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play921011064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.1

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
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

				local var_268_1 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(921011063).content)

				arg_265_1.text_.text = var_268_1

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_3 = 4 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 4)

				if (4 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 4)) > 0 and var_268_0 < var_268_3 then
					arg_265_1.talkMaxDuration = var_268_3

					if var_268_3 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_3 + 0
					end
				end

				arg_265_1.text_.text = var_268_1
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_4 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_4

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play921011064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 921011064
		arg_269_1.duration_ = 6.2

		local var_269_0 = {
			zh = 2.733,
			ja = 6.2
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
				arg_269_0:Play921011065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos10124ui_story = arg_269_1.actors_["10124ui_story"].transform.localPosition
			end

			local var_272_0 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 then
				arg_269_1.actors_["10124ui_story"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10124ui_story, Vector3.New(0, -0.98, -6.08), (arg_269_1.time_ - 0) / var_272_0)
				arg_269_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10124ui_story"].transform.position).z)
				arg_269_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["10124ui_story"].transform.localEulerAngles = arg_269_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 then
				arg_269_1.actors_["10124ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.08)
				arg_269_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_269_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_269_1.actors_["10124ui_story"].transform.position).z)
				arg_269_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_269_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_269_1.actors_["10124ui_story"].transform.localEulerAngles = arg_269_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			local var_272_1 = arg_269_1.actors_["10124ui_story"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect10124ui_story == nil then
				arg_269_1.var_.characterEffect10124ui_story = var_272_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_2 and not isNil(var_272_1) then
				if arg_269_1.var_.characterEffect10124ui_story and not isNil(var_272_1) then
					arg_269_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= 0 + var_272_2 and arg_269_1.time_ < 0 + var_272_2 + arg_272_0 and not isNil(var_272_1) and arg_269_1.var_.characterEffect10124ui_story then
				arg_269_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/story109502/story109502actionlink/109502action424")
			end

			local var_272_4 = 0
			local var_272_5 = 0.325

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_4 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_6 = arg_269_1:GetWordFromCfg(921011064)
				local var_272_7 = arg_269_1:FormatText(var_272_6.content)

				arg_269_1.text_.text = var_272_7

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_9 = 13 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 13)

				if (13 <= 0 and var_272_5 or var_272_5 * (utf8.len(var_272_7) / 13)) > 0 and var_272_5 < var_272_9 then
					arg_269_1.talkMaxDuration = var_272_9

					if var_272_9 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_9 + var_272_4
					end
				end

				arg_269_1.text_.text = var_272_7
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011064", "story_v_side_old_921011.awb") ~= 0 then
					local var_272_10 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011064", "story_v_side_old_921011.awb") / 1000

					if var_272_10 + var_272_4 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_4
					end

					if var_272_6.prefab_name ~= "" and arg_269_1.actors_[var_272_6.prefab_name] ~= nil then
						local var_272_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_6.prefab_name].transform, "story_v_side_old_921011", "921011064", "story_v_side_old_921011.awb")

						arg_269_1:RecordAudio("921011064", var_272_11)
						arg_269_1:RecordAudio("921011064", var_272_11)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011064", "story_v_side_old_921011.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011064", "story_v_side_old_921011.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_12 = math.max(var_272_5, arg_269_1.talkMaxDuration)

			if var_272_4 <= arg_269_1.time_ and arg_269_1.time_ < var_272_4 + var_272_12 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_4) / var_272_12

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_4 + var_272_12 and arg_269_1.time_ < var_272_4 + var_272_12 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10124ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play921011065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 921011065
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play921011066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["10124ui_story"]) and arg_273_1.var_.characterEffect10124ui_story == nil then
				arg_273_1.var_.characterEffect10124ui_story = arg_273_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["10124ui_story"]) then
				if arg_273_1.var_.characterEffect10124ui_story and not isNil(arg_273_1.actors_["10124ui_story"]) then
					arg_273_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_273_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_0)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["10124ui_story"]) and arg_273_1.var_.characterEffect10124ui_story then
				arg_273_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_273_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_276_1 = 0
			local var_276_2 = 0.225

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_3 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(921011065).content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 9 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 9)

				if (9 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 9)) > 0 and var_276_2 < var_276_5 then
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

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play921011066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 921011066
		arg_277_1.duration_ = 1.7

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play921011067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["10124ui_story"]) and arg_277_1.var_.characterEffect10124ui_story == nil then
				arg_277_1.var_.characterEffect10124ui_story = arg_277_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_0 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["10124ui_story"]) then
				if arg_277_1.var_.characterEffect10124ui_story and not isNil(arg_277_1.actors_["10124ui_story"]) then
					arg_277_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["10124ui_story"]) and arg_277_1.var_.characterEffect10124ui_story then
				arg_277_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			local var_280_2 = 0
			local var_280_3 = 0.225

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_2 + arg_280_0 then
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

				local var_280_4 = arg_277_1:GetWordFromCfg(921011066)
				local var_280_5 = arg_277_1:FormatText(var_280_4.content)

				arg_277_1.text_.text = var_280_5

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_7 = 9 <= 0 and var_280_3 or var_280_3 * (utf8.len(var_280_5) / 9)

				if (9 <= 0 and var_280_3 or var_280_3 * (utf8.len(var_280_5) / 9)) > 0 and var_280_3 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_2 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_2
					end
				end

				arg_277_1.text_.text = var_280_5
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011066", "story_v_side_old_921011.awb") ~= 0 then
					local var_280_8 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011066", "story_v_side_old_921011.awb") / 1000

					if var_280_8 + var_280_2 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_8 + var_280_2
					end

					if var_280_4.prefab_name ~= "" and arg_277_1.actors_[var_280_4.prefab_name] ~= nil then
						local var_280_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_4.prefab_name].transform, "story_v_side_old_921011", "921011066", "story_v_side_old_921011.awb")

						arg_277_1:RecordAudio("921011066", var_280_9)
						arg_277_1:RecordAudio("921011066", var_280_9)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011066", "story_v_side_old_921011.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011066", "story_v_side_old_921011.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_10 = math.max(var_280_3, arg_277_1.talkMaxDuration)

			if var_280_2 <= arg_277_1.time_ and arg_277_1.time_ < var_280_2 + var_280_10 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_2) / var_280_10

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_2 + var_280_10 and arg_277_1.time_ < var_280_2 + var_280_10 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play921011067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 921011067
		arg_281_1.duration_ = 6.9

		local var_281_0 = {
			zh = 3.733,
			ja = 6.9
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
				arg_281_0:Play921011068(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action4_2")
			end

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_284_0 = 0
			local var_284_1 = 0.35

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_2 = arg_281_1:GetWordFromCfg(921011067)
				local var_284_3 = arg_281_1:FormatText(var_284_2.content)

				arg_281_1.text_.text = var_284_3

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_5 = 14 <= 0 and var_284_1 or var_284_1 * (utf8.len(var_284_3) / 14)

				if (14 <= 0 and var_284_1 or var_284_1 * (utf8.len(var_284_3) / 14)) > 0 and var_284_1 < var_284_5 then
					arg_281_1.talkMaxDuration = var_284_5

					if var_284_5 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + var_284_0
					end
				end

				arg_281_1.text_.text = var_284_3
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011067", "story_v_side_old_921011.awb") ~= 0 then
					local var_284_6 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011067", "story_v_side_old_921011.awb") / 1000

					if var_284_6 + var_284_0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_6 + var_284_0
					end

					if var_284_2.prefab_name ~= "" and arg_281_1.actors_[var_284_2.prefab_name] ~= nil then
						local var_284_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_2.prefab_name].transform, "story_v_side_old_921011", "921011067", "story_v_side_old_921011.awb")

						arg_281_1:RecordAudio("921011067", var_284_7)
						arg_281_1:RecordAudio("921011067", var_284_7)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011067", "story_v_side_old_921011.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011067", "story_v_side_old_921011.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_8 = math.max(var_284_1, arg_281_1.talkMaxDuration)

			if var_284_0 <= arg_281_1.time_ and arg_281_1.time_ < var_284_0 + var_284_8 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_0) / var_284_8

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_0 + var_284_8 and arg_281_1.time_ < var_284_0 + var_284_8 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play921011068 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 921011068
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play921011069(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["10124ui_story"]) and arg_285_1.var_.characterEffect10124ui_story == nil then
				arg_285_1.var_.characterEffect10124ui_story = arg_285_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["10124ui_story"]) then
				if arg_285_1.var_.characterEffect10124ui_story and not isNil(arg_285_1.actors_["10124ui_story"]) then
					arg_285_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_285_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_0)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["10124ui_story"]) and arg_285_1.var_.characterEffect10124ui_story then
				arg_285_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_285_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_288_1 = 0
			local var_288_2 = 0.225

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
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

				local var_288_3 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(921011068).content)

				arg_285_1.text_.text = var_288_3

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_5 = 9 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 9)

				if (9 <= 0 and var_288_2 or var_288_2 * (utf8.len(var_288_3) / 9)) > 0 and var_288_2 < var_288_5 then
					arg_285_1.talkMaxDuration = var_288_5

					if var_288_5 + var_288_1 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + var_288_1
					end
				end

				arg_285_1.text_.text = var_288_3
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_6 = math.max(var_288_2, arg_285_1.talkMaxDuration)

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_6 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_1) / var_288_6

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_1 + var_288_6 and arg_285_1.time_ < var_288_1 + var_288_6 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play921011069 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 921011069
		arg_289_1.duration_ = 2.67

		local var_289_0 = {
			zh = 2.433,
			ja = 2.666
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
				arg_289_0:Play921011070(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["10124ui_story"]) and arg_289_1.var_.characterEffect10124ui_story == nil then
				arg_289_1.var_.characterEffect10124ui_story = arg_289_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_0 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["10124ui_story"]) then
				if arg_289_1.var_.characterEffect10124ui_story and not isNil(arg_289_1.actors_["10124ui_story"]) then
					arg_289_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["10124ui_story"]) and arg_289_1.var_.characterEffect10124ui_story then
				arg_289_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			local var_292_2 = 0
			local var_292_3 = 0.3

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_2 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_4 = arg_289_1:GetWordFromCfg(921011069)
				local var_292_5 = arg_289_1:FormatText(var_292_4.content)

				arg_289_1.text_.text = var_292_5

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_7 = 12 <= 0 and var_292_3 or var_292_3 * (utf8.len(var_292_5) / 12)

				if (12 <= 0 and var_292_3 or var_292_3 * (utf8.len(var_292_5) / 12)) > 0 and var_292_3 < var_292_7 then
					arg_289_1.talkMaxDuration = var_292_7

					if var_292_7 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_2
					end
				end

				arg_289_1.text_.text = var_292_5
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011069", "story_v_side_old_921011.awb") ~= 0 then
					local var_292_8 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011069", "story_v_side_old_921011.awb") / 1000

					if var_292_8 + var_292_2 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_2
					end

					if var_292_4.prefab_name ~= "" and arg_289_1.actors_[var_292_4.prefab_name] ~= nil then
						local var_292_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_4.prefab_name].transform, "story_v_side_old_921011", "921011069", "story_v_side_old_921011.awb")

						arg_289_1:RecordAudio("921011069", var_292_9)
						arg_289_1:RecordAudio("921011069", var_292_9)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011069", "story_v_side_old_921011.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011069", "story_v_side_old_921011.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_10 = math.max(var_292_3, arg_289_1.talkMaxDuration)

			if var_292_2 <= arg_289_1.time_ and arg_289_1.time_ < var_292_2 + var_292_10 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_2) / var_292_10

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_2 + var_292_10 and arg_289_1.time_ < var_292_2 + var_292_10 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play921011070 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 921011070
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play921011071(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["10124ui_story"]) and arg_293_1.var_.characterEffect10124ui_story == nil then
				arg_293_1.var_.characterEffect10124ui_story = arg_293_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_0 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["10124ui_story"]) then
				if arg_293_1.var_.characterEffect10124ui_story and not isNil(arg_293_1.actors_["10124ui_story"]) then
					arg_293_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_293_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_0)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["10124ui_story"]) and arg_293_1.var_.characterEffect10124ui_story then
				arg_293_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_293_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_296_1 = 0
			local var_296_2 = 0.45

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

				local var_296_3 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(921011070).content)

				arg_293_1.text_.text = var_296_3

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_5 = 18 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_3) / 18)

				if (18 <= 0 and var_296_2 or var_296_2 * (utf8.len(var_296_3) / 18)) > 0 and var_296_2 < var_296_5 then
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
	Play921011071 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 921011071
		arg_297_1.duration_ = 9.1

		local var_297_0 = {
			zh = 4.433,
			ja = 9.1
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
				arg_297_0:Play921011072(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["10124ui_story"]) and arg_297_1.var_.characterEffect10124ui_story == nil then
				arg_297_1.var_.characterEffect10124ui_story = arg_297_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["10124ui_story"]) then
				if arg_297_1.var_.characterEffect10124ui_story and not isNil(arg_297_1.actors_["10124ui_story"]) then
					arg_297_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["10124ui_story"]) and arg_297_1.var_.characterEffect10124ui_story then
				arg_297_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action5_1")
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_300_2 = 0
			local var_300_3 = 0.5

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_2 + arg_300_0 then
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

				local var_300_4 = arg_297_1:GetWordFromCfg(921011071)
				local var_300_5 = arg_297_1:FormatText(var_300_4.content)

				arg_297_1.text_.text = var_300_5

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_7 = 20 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_5) / 20)

				if (20 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_5) / 20)) > 0 and var_300_3 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_2
					end
				end

				arg_297_1.text_.text = var_300_5
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011071", "story_v_side_old_921011.awb") ~= 0 then
					local var_300_8 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011071", "story_v_side_old_921011.awb") / 1000

					if var_300_8 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_2
					end

					if var_300_4.prefab_name ~= "" and arg_297_1.actors_[var_300_4.prefab_name] ~= nil then
						local var_300_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_4.prefab_name].transform, "story_v_side_old_921011", "921011071", "story_v_side_old_921011.awb")

						arg_297_1:RecordAudio("921011071", var_300_9)
						arg_297_1:RecordAudio("921011071", var_300_9)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011071", "story_v_side_old_921011.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011071", "story_v_side_old_921011.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_10 = math.max(var_300_3, arg_297_1.talkMaxDuration)

			if var_300_2 <= arg_297_1.time_ and arg_297_1.time_ < var_300_2 + var_300_10 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_2) / var_300_10

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_2 + var_300_10 and arg_297_1.time_ < var_300_2 + var_300_10 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play921011072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 921011072
		arg_301_1.duration_ = 3.83

		local var_301_0 = {
			zh = 3.833,
			ja = 3.633
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
				arg_301_0:Play921011073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = 0.5

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_1 = arg_301_1:GetWordFromCfg(921011072)
				local var_304_2 = arg_301_1:FormatText(var_304_1.content)

				arg_301_1.text_.text = var_304_2

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_4 = 20 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 20)

				if (20 <= 0 and var_304_0 or var_304_0 * (utf8.len(var_304_2) / 20)) > 0 and var_304_0 < var_304_4 then
					arg_301_1.talkMaxDuration = var_304_4

					if var_304_4 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_4 + 0
					end
				end

				arg_301_1.text_.text = var_304_2
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011072", "story_v_side_old_921011.awb") ~= 0 then
					local var_304_5 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011072", "story_v_side_old_921011.awb") / 1000

					if var_304_5 + 0 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_5 + 0
					end

					if var_304_1.prefab_name ~= "" and arg_301_1.actors_[var_304_1.prefab_name] ~= nil then
						local var_304_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_1.prefab_name].transform, "story_v_side_old_921011", "921011072", "story_v_side_old_921011.awb")

						arg_301_1:RecordAudio("921011072", var_304_6)
						arg_301_1:RecordAudio("921011072", var_304_6)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011072", "story_v_side_old_921011.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011072", "story_v_side_old_921011.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_7 = math.max(var_304_0, arg_301_1.talkMaxDuration)

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_7 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - 0) / var_304_7

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= 0 + var_304_7 and arg_301_1.time_ < 0 + var_304_7 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play921011073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 921011073
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play921011074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["10124ui_story"]) and arg_305_1.var_.characterEffect10124ui_story == nil then
				arg_305_1.var_.characterEffect10124ui_story = arg_305_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_0 = 0.200000002980232

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["10124ui_story"]) then
				if arg_305_1.var_.characterEffect10124ui_story and not isNil(arg_305_1.actors_["10124ui_story"]) then
					arg_305_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_305_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_305_1.time_ - 0) / var_308_0)
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["10124ui_story"]) and arg_305_1.var_.characterEffect10124ui_story then
				arg_305_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_305_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_308_1 = 0
			local var_308_2 = 0.275

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_3 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(921011073).content)

				arg_305_1.text_.text = var_308_3

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_5 = 11 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 11)

				if (11 <= 0 and var_308_2 or var_308_2 * (utf8.len(var_308_3) / 11)) > 0 and var_308_2 < var_308_5 then
					arg_305_1.talkMaxDuration = var_308_5

					if var_308_5 + var_308_1 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_5 + var_308_1
					end
				end

				arg_305_1.text_.text = var_308_3
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_6 = math.max(var_308_2, arg_305_1.talkMaxDuration)

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_6 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_1) / var_308_6

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_1 + var_308_6 and arg_305_1.time_ < var_308_1 + var_308_6 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play921011074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 921011074
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play921011075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1.var_.moveOldPos10124ui_story = arg_309_1.actors_["10124ui_story"].transform.localPosition
			end

			local var_312_0 = 0.001

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 then
				arg_309_1.actors_["10124ui_story"].transform.localPosition = Vector3.Lerp(arg_309_1.var_.moveOldPos10124ui_story, Vector3.New(0, 100, 0), (arg_309_1.time_ - 0) / var_312_0)
				arg_309_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["10124ui_story"].transform.position).z)
				arg_309_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["10124ui_story"].transform.localEulerAngles = arg_309_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 then
				arg_309_1.actors_["10124ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_309_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_309_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_309_1.actors_["10124ui_story"].transform.position).z)
				arg_309_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_309_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_309_1.actors_["10124ui_story"].transform.localEulerAngles = arg_309_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			local var_312_1 = arg_309_1.actors_["10124ui_story"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect10124ui_story == nil then
				arg_309_1.var_.characterEffect10124ui_story = var_312_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_312_2 = 0.200000002980232

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_2 and not isNil(var_312_1) then
				if arg_309_1.var_.characterEffect10124ui_story and not isNil(var_312_1) then
					arg_309_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_309_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_309_1.time_ - 0) / var_312_2)
				end
			end

			if arg_309_1.time_ >= 0 + var_312_2 and arg_309_1.time_ < 0 + var_312_2 + arg_312_0 and not isNil(var_312_1) and arg_309_1.var_.characterEffect10124ui_story then
				arg_309_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_309_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_312_3 = 0
			local var_312_4 = 0.75

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_3 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, false)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_5 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(921011074).content)

				arg_309_1.text_.text = var_312_5

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_7 = 30 <= 0 and var_312_4 or var_312_4 * (utf8.len(var_312_5) / 30)

				if (30 <= 0 and var_312_4 or var_312_4 * (utf8.len(var_312_5) / 30)) > 0 and var_312_4 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_3 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_3
					end
				end

				arg_309_1.text_.text = var_312_5
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_8 = math.max(var_312_4, arg_309_1.talkMaxDuration)

			if var_312_3 <= arg_309_1.time_ and arg_309_1.time_ < var_312_3 + var_312_8 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_3) / var_312_8

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_3 + var_312_8 and arg_309_1.time_ < var_312_3 + var_312_8 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10124ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_309_1:InitPlayNodeList()
	end,
	Play921011075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 921011075
		arg_313_1.duration_ = 6.77

		local var_313_0 = {
			zh = 3.866,
			ja = 6.766
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
				arg_313_0:Play921011076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1.var_.moveOldPos10124ui_story = arg_313_1.actors_["10124ui_story"].transform.localPosition
			end

			local var_316_0 = 0.001

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 then
				arg_313_1.actors_["10124ui_story"].transform.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos10124ui_story, Vector3.New(0, -0.98, -6.08), (arg_313_1.time_ - 0) / var_316_0)
				arg_313_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["10124ui_story"].transform.position).z)
				arg_313_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["10124ui_story"].transform.localEulerAngles = arg_313_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 then
				arg_313_1.actors_["10124ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.08)
				arg_313_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_313_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_313_1.actors_["10124ui_story"].transform.position).z)
				arg_313_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_313_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_313_1.actors_["10124ui_story"].transform.localEulerAngles = arg_313_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			local var_316_1 = arg_313_1.actors_["10124ui_story"]

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect10124ui_story == nil then
				arg_313_1.var_.characterEffect10124ui_story = var_316_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_2 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_2 and not isNil(var_316_1) then
				if arg_313_1.var_.characterEffect10124ui_story and not isNil(var_316_1) then
					arg_313_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= 0 + var_316_2 and arg_313_1.time_ < 0 + var_316_2 + arg_316_0 and not isNil(var_316_1) and arg_313_1.var_.characterEffect10124ui_story then
				arg_313_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 then
				arg_313_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action5_2")
			end

			local var_316_4 = 0
			local var_316_5 = 0.375

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_4 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				arg_313_1.leftNameTxt_.text = arg_313_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_6 = arg_313_1:GetWordFromCfg(921011075)
				local var_316_7 = arg_313_1:FormatText(var_316_6.content)

				arg_313_1.text_.text = var_316_7

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_9 = 15 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 15)

				if (15 <= 0 and var_316_5 or var_316_5 * (utf8.len(var_316_7) / 15)) > 0 and var_316_5 < var_316_9 then
					arg_313_1.talkMaxDuration = var_316_9

					if var_316_9 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_9 + var_316_4
					end
				end

				arg_313_1.text_.text = var_316_7
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011075", "story_v_side_old_921011.awb") ~= 0 then
					local var_316_10 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011075", "story_v_side_old_921011.awb") / 1000

					if var_316_10 + var_316_4 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_10 + var_316_4
					end

					if var_316_6.prefab_name ~= "" and arg_313_1.actors_[var_316_6.prefab_name] ~= nil then
						local var_316_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_6.prefab_name].transform, "story_v_side_old_921011", "921011075", "story_v_side_old_921011.awb")

						arg_313_1:RecordAudio("921011075", var_316_11)
						arg_313_1:RecordAudio("921011075", var_316_11)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011075", "story_v_side_old_921011.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011075", "story_v_side_old_921011.awb")
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
				actorName = "10124ui_story",
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
	Play921011076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 921011076
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play921011077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["10124ui_story"]) and arg_317_1.var_.characterEffect10124ui_story == nil then
				arg_317_1.var_.characterEffect10124ui_story = arg_317_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_0 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["10124ui_story"]) then
				if arg_317_1.var_.characterEffect10124ui_story and not isNil(arg_317_1.actors_["10124ui_story"]) then
					arg_317_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_317_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_317_1.time_ - 0) / var_320_0)
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["10124ui_story"]) and arg_317_1.var_.characterEffect10124ui_story then
				arg_317_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_317_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_320_1 = 0
			local var_320_2 = 0.225

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

				local var_320_3 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(921011076).content)

				arg_317_1.text_.text = var_320_3

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 9 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 9)

				if (9 <= 0 and var_320_2 or var_320_2 * (utf8.len(var_320_3) / 9)) > 0 and var_320_2 < var_320_5 then
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
	Play921011077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 921011077
		arg_321_1.duration_ = 8.53

		local var_321_0 = {
			zh = 6.2,
			ja = 8.533
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
				arg_321_0:Play921011078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["10124ui_story"]) and arg_321_1.var_.characterEffect10124ui_story == nil then
				arg_321_1.var_.characterEffect10124ui_story = arg_321_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["10124ui_story"]) then
				if arg_321_1.var_.characterEffect10124ui_story and not isNil(arg_321_1.actors_["10124ui_story"]) then
					arg_321_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["10124ui_story"]) and arg_321_1.var_.characterEffect10124ui_story then
				arg_321_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action1_1")
			end

			local var_324_2 = 0
			local var_324_3 = 0.65

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_2 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_4 = arg_321_1:GetWordFromCfg(921011077)
				local var_324_5 = arg_321_1:FormatText(var_324_4.content)

				arg_321_1.text_.text = var_324_5

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_7 = 26 <= 0 and var_324_3 or var_324_3 * (utf8.len(var_324_5) / 26)

				if (26 <= 0 and var_324_3 or var_324_3 * (utf8.len(var_324_5) / 26)) > 0 and var_324_3 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_2 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_2
					end
				end

				arg_321_1.text_.text = var_324_5
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011077", "story_v_side_old_921011.awb") ~= 0 then
					local var_324_8 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011077", "story_v_side_old_921011.awb") / 1000

					if var_324_8 + var_324_2 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_2
					end

					if var_324_4.prefab_name ~= "" and arg_321_1.actors_[var_324_4.prefab_name] ~= nil then
						local var_324_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_4.prefab_name].transform, "story_v_side_old_921011", "921011077", "story_v_side_old_921011.awb")

						arg_321_1:RecordAudio("921011077", var_324_9)
						arg_321_1:RecordAudio("921011077", var_324_9)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011077", "story_v_side_old_921011.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011077", "story_v_side_old_921011.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_10 = math.max(var_324_3, arg_321_1.talkMaxDuration)

			if var_324_2 <= arg_321_1.time_ and arg_321_1.time_ < var_324_2 + var_324_10 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_2) / var_324_10

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_2 + var_324_10 and arg_321_1.time_ < var_324_2 + var_324_10 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play921011078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 921011078
		arg_325_1.duration_ = 8.1

		local var_325_0 = {
			zh = 4.266,
			ja = 8.1
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
				arg_325_0:Play921011079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0.525

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
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

				local var_328_1 = arg_325_1:GetWordFromCfg(921011078)
				local var_328_2 = arg_325_1:FormatText(var_328_1.content)

				arg_325_1.text_.text = var_328_2

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_4 = 21 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 21)

				if (21 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 21)) > 0 and var_328_0 < var_328_4 then
					arg_325_1.talkMaxDuration = var_328_4

					if var_328_4 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_4 + 0
					end
				end

				arg_325_1.text_.text = var_328_2
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011078", "story_v_side_old_921011.awb") ~= 0 then
					local var_328_5 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011078", "story_v_side_old_921011.awb") / 1000

					if var_328_5 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + 0
					end

					if var_328_1.prefab_name ~= "" and arg_325_1.actors_[var_328_1.prefab_name] ~= nil then
						local var_328_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_1.prefab_name].transform, "story_v_side_old_921011", "921011078", "story_v_side_old_921011.awb")

						arg_325_1:RecordAudio("921011078", var_328_6)
						arg_325_1:RecordAudio("921011078", var_328_6)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011078", "story_v_side_old_921011.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011078", "story_v_side_old_921011.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_0, arg_325_1.talkMaxDuration)

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - 0) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= 0 + var_328_7 and arg_325_1.time_ < 0 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play921011079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 921011079
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play921011080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["10124ui_story"]) and arg_329_1.var_.characterEffect10124ui_story == nil then
				arg_329_1.var_.characterEffect10124ui_story = arg_329_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_0 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["10124ui_story"]) then
				if arg_329_1.var_.characterEffect10124ui_story and not isNil(arg_329_1.actors_["10124ui_story"]) then
					arg_329_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_329_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_0)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["10124ui_story"]) and arg_329_1.var_.characterEffect10124ui_story then
				arg_329_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_329_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_332_1 = 0
			local var_332_2 = 0.125

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_3 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(921011079).content)

				arg_329_1.text_.text = var_332_3

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 5 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 5)

				if (5 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 5)) > 0 and var_332_2 < var_332_5 then
					arg_329_1.talkMaxDuration = var_332_5

					if var_332_5 + var_332_1 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + var_332_1
					end
				end

				arg_329_1.text_.text = var_332_3
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_6 = math.max(var_332_2, arg_329_1.talkMaxDuration)

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_6 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_1) / var_332_6

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_1 + var_332_6 and arg_329_1.time_ < var_332_1 + var_332_6 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play921011080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 921011080
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play921011081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos10124ui_story = arg_333_1.actors_["10124ui_story"].transform.localPosition
			end

			local var_336_0 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 then
				arg_333_1.actors_["10124ui_story"].transform.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos10124ui_story, Vector3.New(0, 100, 0), (arg_333_1.time_ - 0) / var_336_0)
				arg_333_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["10124ui_story"].transform.position).z)
				arg_333_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["10124ui_story"].transform.localEulerAngles = arg_333_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 then
				arg_333_1.actors_["10124ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_333_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_333_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_333_1.actors_["10124ui_story"].transform.position).z)
				arg_333_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_333_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_333_1.actors_["10124ui_story"].transform.localEulerAngles = arg_333_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			local var_336_1 = 0
			local var_336_2 = 0.875

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_3 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(921011080).content)

				arg_333_1.text_.text = var_336_3

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 35 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 35)

				if (35 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 35)) > 0 and var_336_2 < var_336_5 then
					arg_333_1.talkMaxDuration = var_336_5

					if var_336_5 + var_336_1 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + var_336_1
					end
				end

				arg_333_1.text_.text = var_336_3
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_6 = math.max(var_336_2, arg_333_1.talkMaxDuration)

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_6 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_1) / var_336_6

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_1 + var_336_6 and arg_333_1.time_ < var_336_1 + var_336_6 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10124ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play921011081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 921011081
		arg_337_1.duration_ = 5.47

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play921011082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if arg_337_1.frameCnt_ <= 1 then
				arg_337_1.dialog_:SetActive(false)
			end

			local var_340_0 = 0.466666666666667
			local var_340_1 = 0.375

			if 0.466666666666667 < arg_337_1.time_ and arg_337_1.time_ <= var_340_0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0

				arg_337_1.dialog_:SetActive(true)

				arg_337_1.dialogCg_.alpha = 0

				local var_340_2 = LeanTween.value(arg_337_1.dialog_, 0, 1, 0.3)

				var_340_2:setOnUpdate(LuaHelper.FloatAction(function(arg_341_0)
					arg_337_1.dialogCg_.alpha = arg_341_0
				end))
				var_340_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_337_1.dialog_)
					var_340_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_337_1.duration_ = arg_337_1.duration_ + 0.3

				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_3 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(921011081).content)

				arg_337_1.text_.text = var_340_3

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_5 = 15 <= 0 and var_340_1 or var_340_1 * (utf8.len(var_340_3) / 15)

				if (15 <= 0 and var_340_1 or var_340_1 * (utf8.len(var_340_3) / 15)) > 0 and var_340_1 < var_340_5 then
					arg_337_1.talkMaxDuration = var_340_5
					var_340_0 = var_340_0 + 0.3

					if var_340_5 + var_340_0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_5 + var_340_0
					end
				end

				arg_337_1.text_.text = var_340_3
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_6 = var_340_0 + 0.3
			local var_340_7 = math.max(var_340_1, arg_337_1.talkMaxDuration)

			if var_340_0 + 0.3 <= arg_337_1.time_ and arg_337_1.time_ < var_340_6 + var_340_7 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_6) / var_340_7

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_6 + var_340_7 and arg_337_1.time_ < var_340_6 + var_340_7 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play921011082 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 921011082
		arg_343_1.duration_ = 2.17

		local var_343_0 = {
			zh = 1.999999999999,
			ja = 2.166
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play921011083(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos10124ui_story = arg_343_1.actors_["10124ui_story"].transform.localPosition
			end

			local var_346_0 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 then
				arg_343_1.actors_["10124ui_story"].transform.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10124ui_story, Vector3.New(0, -0.98, -6.08), (arg_343_1.time_ - 0) / var_346_0)
				arg_343_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["10124ui_story"].transform.position).z)
				arg_343_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["10124ui_story"].transform.localEulerAngles = arg_343_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 then
				arg_343_1.actors_["10124ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.08)
				arg_343_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_343_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_343_1.actors_["10124ui_story"].transform.position).z)
				arg_343_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_343_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_343_1.actors_["10124ui_story"].transform.localEulerAngles = arg_343_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			local var_346_1 = arg_343_1.actors_["10124ui_story"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_1) and arg_343_1.var_.characterEffect10124ui_story == nil then
				arg_343_1.var_.characterEffect10124ui_story = var_346_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_346_2 = 0.200000002980232

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_2 and not isNil(var_346_1) then
				if arg_343_1.var_.characterEffect10124ui_story and not isNil(var_346_1) then
					arg_343_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_343_1.time_ >= 0 + var_346_2 and arg_343_1.time_ < 0 + var_346_2 + arg_346_0 and not isNil(var_346_1) and arg_343_1.var_.characterEffect10124ui_story then
				arg_343_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action7_1")
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_346_4 = 0
			local var_346_5 = 0.375

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_4 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_6 = arg_343_1:GetWordFromCfg(921011082)
				local var_346_7 = arg_343_1:FormatText(var_346_6.content)

				arg_343_1.text_.text = var_346_7

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_9 = 15 <= 0 and var_346_5 or var_346_5 * (utf8.len(var_346_7) / 15)

				if (15 <= 0 and var_346_5 or var_346_5 * (utf8.len(var_346_7) / 15)) > 0 and var_346_5 < var_346_9 then
					arg_343_1.talkMaxDuration = var_346_9

					if var_346_9 + var_346_4 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_9 + var_346_4
					end
				end

				arg_343_1.text_.text = var_346_7
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011082", "story_v_side_old_921011.awb") ~= 0 then
					local var_346_10 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011082", "story_v_side_old_921011.awb") / 1000

					if var_346_10 + var_346_4 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_10 + var_346_4
					end

					if var_346_6.prefab_name ~= "" and arg_343_1.actors_[var_346_6.prefab_name] ~= nil then
						local var_346_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_6.prefab_name].transform, "story_v_side_old_921011", "921011082", "story_v_side_old_921011.awb")

						arg_343_1:RecordAudio("921011082", var_346_11)
						arg_343_1:RecordAudio("921011082", var_346_11)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011082", "story_v_side_old_921011.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011082", "story_v_side_old_921011.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_12 = math.max(var_346_5, arg_343_1.talkMaxDuration)

			if var_346_4 <= arg_343_1.time_ and arg_343_1.time_ < var_346_4 + var_346_12 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_4) / var_346_12

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_4 + var_346_12 and arg_343_1.time_ < var_346_4 + var_346_12 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10124ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play921011083 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 921011083
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play921011084(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["10124ui_story"]) and arg_347_1.var_.characterEffect10124ui_story == nil then
				arg_347_1.var_.characterEffect10124ui_story = arg_347_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_0 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["10124ui_story"]) then
				if arg_347_1.var_.characterEffect10124ui_story and not isNil(arg_347_1.actors_["10124ui_story"]) then
					arg_347_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_347_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_347_1.time_ - 0) / var_350_0)
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["10124ui_story"]) and arg_347_1.var_.characterEffect10124ui_story then
				arg_347_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_347_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_350_1 = 0
			local var_350_2 = 0.375

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_3 = arg_347_1:FormatText(arg_347_1:GetWordFromCfg(921011083).content)

				arg_347_1.text_.text = var_350_3

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_5 = 15 <= 0 and var_350_2 or var_350_2 * (utf8.len(var_350_3) / 15)

				if (15 <= 0 and var_350_2 or var_350_2 * (utf8.len(var_350_3) / 15)) > 0 and var_350_2 < var_350_5 then
					arg_347_1.talkMaxDuration = var_350_5

					if var_350_5 + var_350_1 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_5 + var_350_1
					end
				end

				arg_347_1.text_.text = var_350_3
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_6 = math.max(var_350_2, arg_347_1.talkMaxDuration)

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_6 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_1) / var_350_6

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_1 + var_350_6 and arg_347_1.time_ < var_350_1 + var_350_6 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play921011084 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 921011084
		arg_351_1.duration_ = 2.9

		local var_351_0 = {
			zh = 2.066,
			ja = 2.9
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play921011085(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["10124ui_story"]) and arg_351_1.var_.characterEffect10124ui_story == nil then
				arg_351_1.var_.characterEffect10124ui_story = arg_351_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_0 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["10124ui_story"]) then
				if arg_351_1.var_.characterEffect10124ui_story and not isNil(arg_351_1.actors_["10124ui_story"]) then
					arg_351_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["10124ui_story"]) and arg_351_1.var_.characterEffect10124ui_story then
				arg_351_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			local var_354_2 = 0
			local var_354_3 = 0.275

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_2 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_4 = arg_351_1:GetWordFromCfg(921011084)
				local var_354_5 = arg_351_1:FormatText(var_354_4.content)

				arg_351_1.text_.text = var_354_5

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_7 = 11 <= 0 and var_354_3 or var_354_3 * (utf8.len(var_354_5) / 11)

				if (11 <= 0 and var_354_3 or var_354_3 * (utf8.len(var_354_5) / 11)) > 0 and var_354_3 < var_354_7 then
					arg_351_1.talkMaxDuration = var_354_7

					if var_354_7 + var_354_2 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_7 + var_354_2
					end
				end

				arg_351_1.text_.text = var_354_5
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011084", "story_v_side_old_921011.awb") ~= 0 then
					local var_354_8 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011084", "story_v_side_old_921011.awb") / 1000

					if var_354_8 + var_354_2 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_8 + var_354_2
					end

					if var_354_4.prefab_name ~= "" and arg_351_1.actors_[var_354_4.prefab_name] ~= nil then
						local var_354_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_4.prefab_name].transform, "story_v_side_old_921011", "921011084", "story_v_side_old_921011.awb")

						arg_351_1:RecordAudio("921011084", var_354_9)
						arg_351_1:RecordAudio("921011084", var_354_9)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011084", "story_v_side_old_921011.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011084", "story_v_side_old_921011.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_10 = math.max(var_354_3, arg_351_1.talkMaxDuration)

			if var_354_2 <= arg_351_1.time_ and arg_351_1.time_ < var_354_2 + var_354_10 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_2) / var_354_10

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_2 + var_354_10 and arg_351_1.time_ < var_354_2 + var_354_10 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play921011085 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 921011085
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play921011086(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(arg_355_1.actors_["10124ui_story"]) and arg_355_1.var_.characterEffect10124ui_story == nil then
				arg_355_1.var_.characterEffect10124ui_story = arg_355_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_0 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 and not isNil(arg_355_1.actors_["10124ui_story"]) then
				if arg_355_1.var_.characterEffect10124ui_story and not isNil(arg_355_1.actors_["10124ui_story"]) then
					arg_355_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_355_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_355_1.time_ - 0) / var_358_0)
				end
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 and not isNil(arg_355_1.actors_["10124ui_story"]) and arg_355_1.var_.characterEffect10124ui_story then
				arg_355_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_355_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_358_1 = 0
			local var_358_2 = 0.65

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_355_1.callingController_:SetSelectedState("normal")

				arg_355_1.keyicon_.color = Color.New(1, 1, 1)
				arg_355_1.icon_.color = Color.New(1, 1, 1)

				local var_358_3 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(921011085).content)

				arg_355_1.text_.text = var_358_3

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 26 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 26)

				if (26 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 26)) > 0 and var_358_2 < var_358_5 then
					arg_355_1.talkMaxDuration = var_358_5

					if var_358_5 + var_358_1 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + var_358_1
					end
				end

				arg_355_1.text_.text = var_358_3
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_6 = math.max(var_358_2, arg_355_1.talkMaxDuration)

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_6 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_1) / var_358_6

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_1 + var_358_6 and arg_355_1.time_ < var_358_1 + var_358_6 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play921011086 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 921011086
		arg_359_1.duration_ = 9.7

		local var_359_0 = {
			zh = 7.3,
			ja = 9.7
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play921011087(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(arg_359_1.actors_["10124ui_story"]) and arg_359_1.var_.characterEffect10124ui_story == nil then
				arg_359_1.var_.characterEffect10124ui_story = arg_359_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_0 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 and not isNil(arg_359_1.actors_["10124ui_story"]) then
				if arg_359_1.var_.characterEffect10124ui_story and not isNil(arg_359_1.actors_["10124ui_story"]) then
					arg_359_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 and not isNil(arg_359_1.actors_["10124ui_story"]) and arg_359_1.var_.characterEffect10124ui_story then
				arg_359_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action7_2")
			end

			local var_362_2 = 0
			local var_362_3 = 1.075

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_2 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_4 = arg_359_1:GetWordFromCfg(921011086)
				local var_362_5 = arg_359_1:FormatText(var_362_4.content)

				arg_359_1.text_.text = var_362_5

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_7 = 43 <= 0 and var_362_3 or var_362_3 * (utf8.len(var_362_5) / 43)

				if (43 <= 0 and var_362_3 or var_362_3 * (utf8.len(var_362_5) / 43)) > 0 and var_362_3 < var_362_7 then
					arg_359_1.talkMaxDuration = var_362_7

					if var_362_7 + var_362_2 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_7 + var_362_2
					end
				end

				arg_359_1.text_.text = var_362_5
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011086", "story_v_side_old_921011.awb") ~= 0 then
					local var_362_8 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011086", "story_v_side_old_921011.awb") / 1000

					if var_362_8 + var_362_2 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_8 + var_362_2
					end

					if var_362_4.prefab_name ~= "" and arg_359_1.actors_[var_362_4.prefab_name] ~= nil then
						local var_362_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_4.prefab_name].transform, "story_v_side_old_921011", "921011086", "story_v_side_old_921011.awb")

						arg_359_1:RecordAudio("921011086", var_362_9)
						arg_359_1:RecordAudio("921011086", var_362_9)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011086", "story_v_side_old_921011.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011086", "story_v_side_old_921011.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_10 = math.max(var_362_3, arg_359_1.talkMaxDuration)

			if var_362_2 <= arg_359_1.time_ and arg_359_1.time_ < var_362_2 + var_362_10 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_2) / var_362_10

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_2 + var_362_10 and arg_359_1.time_ < var_362_2 + var_362_10 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play921011087 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 921011087
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play921011088(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["10124ui_story"]) and arg_363_1.var_.characterEffect10124ui_story == nil then
				arg_363_1.var_.characterEffect10124ui_story = arg_363_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_0 = 0.200000002980232

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["10124ui_story"]) then
				if arg_363_1.var_.characterEffect10124ui_story and not isNil(arg_363_1.actors_["10124ui_story"]) then
					arg_363_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_363_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_363_1.time_ - 0) / var_366_0)
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["10124ui_story"]) and arg_363_1.var_.characterEffect10124ui_story then
				arg_363_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_363_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_366_1 = 0
			local var_366_2 = 0.6

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_363_1.callingController_:SetSelectedState("normal")

				arg_363_1.keyicon_.color = Color.New(1, 1, 1)
				arg_363_1.icon_.color = Color.New(1, 1, 1)

				local var_366_3 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(921011087).content)

				arg_363_1.text_.text = var_366_3

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_5 = 24 <= 0 and var_366_2 or var_366_2 * (utf8.len(var_366_3) / 24)

				if (24 <= 0 and var_366_2 or var_366_2 * (utf8.len(var_366_3) / 24)) > 0 and var_366_2 < var_366_5 then
					arg_363_1.talkMaxDuration = var_366_5

					if var_366_5 + var_366_1 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_5 + var_366_1
					end
				end

				arg_363_1.text_.text = var_366_3
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_6 = math.max(var_366_2, arg_363_1.talkMaxDuration)

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_6 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_1) / var_366_6

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_1 + var_366_6 and arg_363_1.time_ < var_366_1 + var_366_6 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play921011088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 921011088
		arg_367_1.duration_ = 8.53

		local var_367_0 = {
			zh = 6.9,
			ja = 8.533
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play921011089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos10124ui_story = arg_367_1.actors_["10124ui_story"].transform.localPosition
			end

			local var_370_0 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 then
				arg_367_1.actors_["10124ui_story"].transform.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos10124ui_story, Vector3.New(0, -0.98, -6.08), (arg_367_1.time_ - 0) / var_370_0)
				arg_367_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["10124ui_story"].transform.position).z)
				arg_367_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["10124ui_story"].transform.localEulerAngles = arg_367_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 then
				arg_367_1.actors_["10124ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.08)
				arg_367_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_367_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_367_1.actors_["10124ui_story"].transform.position).z)
				arg_367_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_367_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_367_1.actors_["10124ui_story"].transform.localEulerAngles = arg_367_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			local var_370_1 = arg_367_1.actors_["10124ui_story"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect10124ui_story == nil then
				arg_367_1.var_.characterEffect10124ui_story = var_370_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.200000002980232

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_2 and not isNil(var_370_1) then
				if arg_367_1.var_.characterEffect10124ui_story and not isNil(var_370_1) then
					arg_367_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= 0 + var_370_2 and arg_367_1.time_ < 0 + var_370_2 + arg_370_0 and not isNil(var_370_1) and arg_367_1.var_.characterEffect10124ui_story then
				arg_367_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action1_1")
			end

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_370_4 = 0
			local var_370_5 = 0.55

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_4 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_6 = arg_367_1:GetWordFromCfg(921011088)
				local var_370_7 = arg_367_1:FormatText(var_370_6.content)

				arg_367_1.text_.text = var_370_7

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_9 = 22 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 22)

				if (22 <= 0 and var_370_5 or var_370_5 * (utf8.len(var_370_7) / 22)) > 0 and var_370_5 < var_370_9 then
					arg_367_1.talkMaxDuration = var_370_9

					if var_370_9 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_9 + var_370_4
					end
				end

				arg_367_1.text_.text = var_370_7
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011088", "story_v_side_old_921011.awb") ~= 0 then
					local var_370_10 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011088", "story_v_side_old_921011.awb") / 1000

					if var_370_10 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_10 + var_370_4
					end

					if var_370_6.prefab_name ~= "" and arg_367_1.actors_[var_370_6.prefab_name] ~= nil then
						local var_370_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_6.prefab_name].transform, "story_v_side_old_921011", "921011088", "story_v_side_old_921011.awb")

						arg_367_1:RecordAudio("921011088", var_370_11)
						arg_367_1:RecordAudio("921011088", var_370_11)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011088", "story_v_side_old_921011.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011088", "story_v_side_old_921011.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_12 = math.max(var_370_5, arg_367_1.talkMaxDuration)

			if var_370_4 <= arg_367_1.time_ and arg_367_1.time_ < var_370_4 + var_370_12 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_4) / var_370_12

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_4 + var_370_12 and arg_367_1.time_ < var_370_4 + var_370_12 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10124ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play921011089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 921011089
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play921011090(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(arg_371_1.actors_["10124ui_story"]) and arg_371_1.var_.characterEffect10124ui_story == nil then
				arg_371_1.var_.characterEffect10124ui_story = arg_371_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_0 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 and not isNil(arg_371_1.actors_["10124ui_story"]) then
				if arg_371_1.var_.characterEffect10124ui_story and not isNil(arg_371_1.actors_["10124ui_story"]) then
					arg_371_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_371_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_371_1.time_ - 0) / var_374_0)
				end
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 and not isNil(arg_371_1.actors_["10124ui_story"]) and arg_371_1.var_.characterEffect10124ui_story then
				arg_371_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_371_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_374_1 = 0
			local var_374_2 = 0.15

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_371_1.callingController_:SetSelectedState("normal")

				arg_371_1.keyicon_.color = Color.New(1, 1, 1)
				arg_371_1.icon_.color = Color.New(1, 1, 1)

				local var_374_3 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(921011089).content)

				arg_371_1.text_.text = var_374_3

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_5 = 6 <= 0 and var_374_2 or var_374_2 * (utf8.len(var_374_3) / 6)

				if (6 <= 0 and var_374_2 or var_374_2 * (utf8.len(var_374_3) / 6)) > 0 and var_374_2 < var_374_5 then
					arg_371_1.talkMaxDuration = var_374_5

					if var_374_5 + var_374_1 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_5 + var_374_1
					end
				end

				arg_371_1.text_.text = var_374_3
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_6 = math.max(var_374_2, arg_371_1.talkMaxDuration)

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_6 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_1) / var_374_6

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_1 + var_374_6 and arg_371_1.time_ < var_374_1 + var_374_6 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play921011090 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 921011090
		arg_375_1.duration_ = 7.97

		local var_375_0 = {
			zh = 5.966,
			ja = 7.966
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play921011091(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(arg_375_1.actors_["10124ui_story"]) and arg_375_1.var_.characterEffect10124ui_story == nil then
				arg_375_1.var_.characterEffect10124ui_story = arg_375_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_0 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 and not isNil(arg_375_1.actors_["10124ui_story"]) then
				if arg_375_1.var_.characterEffect10124ui_story and not isNil(arg_375_1.actors_["10124ui_story"]) then
					arg_375_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 and not isNil(arg_375_1.actors_["10124ui_story"]) and arg_375_1.var_.characterEffect10124ui_story then
				arg_375_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			local var_378_2 = 0
			local var_378_3 = 0.7

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_2 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_4 = arg_375_1:GetWordFromCfg(921011090)
				local var_378_5 = arg_375_1:FormatText(var_378_4.content)

				arg_375_1.text_.text = var_378_5

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_7 = 28 <= 0 and var_378_3 or var_378_3 * (utf8.len(var_378_5) / 28)

				if (28 <= 0 and var_378_3 or var_378_3 * (utf8.len(var_378_5) / 28)) > 0 and var_378_3 < var_378_7 then
					arg_375_1.talkMaxDuration = var_378_7

					if var_378_7 + var_378_2 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_7 + var_378_2
					end
				end

				arg_375_1.text_.text = var_378_5
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011090", "story_v_side_old_921011.awb") ~= 0 then
					local var_378_8 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011090", "story_v_side_old_921011.awb") / 1000

					if var_378_8 + var_378_2 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_8 + var_378_2
					end

					if var_378_4.prefab_name ~= "" and arg_375_1.actors_[var_378_4.prefab_name] ~= nil then
						local var_378_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_4.prefab_name].transform, "story_v_side_old_921011", "921011090", "story_v_side_old_921011.awb")

						arg_375_1:RecordAudio("921011090", var_378_9)
						arg_375_1:RecordAudio("921011090", var_378_9)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011090", "story_v_side_old_921011.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011090", "story_v_side_old_921011.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_10 = math.max(var_378_3, arg_375_1.talkMaxDuration)

			if var_378_2 <= arg_375_1.time_ and arg_375_1.time_ < var_378_2 + var_378_10 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_2) / var_378_10

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_2 + var_378_10 and arg_375_1.time_ < var_378_2 + var_378_10 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play921011091 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 921011091
		arg_379_1.duration_ = 7.57

		local var_379_0 = {
			zh = 6.033,
			ja = 7.566
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play921011092(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0.725

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_1 = arg_379_1:GetWordFromCfg(921011091)
				local var_382_2 = arg_379_1:FormatText(var_382_1.content)

				arg_379_1.text_.text = var_382_2

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_4 = 29 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_2) / 29)

				if (29 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_2) / 29)) > 0 and var_382_0 < var_382_4 then
					arg_379_1.talkMaxDuration = var_382_4

					if var_382_4 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_4 + 0
					end
				end

				arg_379_1.text_.text = var_382_2
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011091", "story_v_side_old_921011.awb") ~= 0 then
					local var_382_5 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011091", "story_v_side_old_921011.awb") / 1000

					if var_382_5 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_5 + 0
					end

					if var_382_1.prefab_name ~= "" and arg_379_1.actors_[var_382_1.prefab_name] ~= nil then
						local var_382_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_1.prefab_name].transform, "story_v_side_old_921011", "921011091", "story_v_side_old_921011.awb")

						arg_379_1:RecordAudio("921011091", var_382_6)
						arg_379_1:RecordAudio("921011091", var_382_6)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011091", "story_v_side_old_921011.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011091", "story_v_side_old_921011.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_7 = math.max(var_382_0, arg_379_1.talkMaxDuration)

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_7 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - 0) / var_382_7

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= 0 + var_382_7 and arg_379_1.time_ < 0 + var_382_7 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play921011092 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 921011092
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play921011093(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["10124ui_story"]) and arg_383_1.var_.characterEffect10124ui_story == nil then
				arg_383_1.var_.characterEffect10124ui_story = arg_383_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_0 = 0.200000002980232

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["10124ui_story"]) then
				if arg_383_1.var_.characterEffect10124ui_story and not isNil(arg_383_1.actors_["10124ui_story"]) then
					arg_383_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_383_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_383_1.time_ - 0) / var_386_0)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["10124ui_story"]) and arg_383_1.var_.characterEffect10124ui_story then
				arg_383_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_383_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_386_1 = 0
			local var_386_2 = 0.4

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_3 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(921011092).content)

				arg_383_1.text_.text = var_386_3

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_5 = 16 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 16)

				if (16 <= 0 and var_386_2 or var_386_2 * (utf8.len(var_386_3) / 16)) > 0 and var_386_2 < var_386_5 then
					arg_383_1.talkMaxDuration = var_386_5

					if var_386_5 + var_386_1 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_5 + var_386_1
					end
				end

				arg_383_1.text_.text = var_386_3
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_6 = math.max(var_386_2, arg_383_1.talkMaxDuration)

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_6 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_1) / var_386_6

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_1 + var_386_6 and arg_383_1.time_ < var_386_1 + var_386_6 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play921011093 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 921011093
		arg_387_1.duration_ = 8.9

		local var_387_0 = {
			zh = 7.866,
			ja = 8.9
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play921011094(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(arg_387_1.actors_["10124ui_story"]) and arg_387_1.var_.characterEffect10124ui_story == nil then
				arg_387_1.var_.characterEffect10124ui_story = arg_387_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_0 = 0.200000002980232

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 and not isNil(arg_387_1.actors_["10124ui_story"]) then
				if arg_387_1.var_.characterEffect10124ui_story and not isNil(arg_387_1.actors_["10124ui_story"]) then
					arg_387_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 and not isNil(arg_387_1.actors_["10124ui_story"]) and arg_387_1.var_.characterEffect10124ui_story then
				arg_387_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action2_1")
			end

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_390_2 = 0
			local var_390_3 = 0.6

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_2 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_4 = arg_387_1:GetWordFromCfg(921011093)
				local var_390_5 = arg_387_1:FormatText(var_390_4.content)

				arg_387_1.text_.text = var_390_5

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_7 = 24 <= 0 and var_390_3 or var_390_3 * (utf8.len(var_390_5) / 24)

				if (24 <= 0 and var_390_3 or var_390_3 * (utf8.len(var_390_5) / 24)) > 0 and var_390_3 < var_390_7 then
					arg_387_1.talkMaxDuration = var_390_7

					if var_390_7 + var_390_2 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_2
					end
				end

				arg_387_1.text_.text = var_390_5
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011093", "story_v_side_old_921011.awb") ~= 0 then
					local var_390_8 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011093", "story_v_side_old_921011.awb") / 1000

					if var_390_8 + var_390_2 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_8 + var_390_2
					end

					if var_390_4.prefab_name ~= "" and arg_387_1.actors_[var_390_4.prefab_name] ~= nil then
						local var_390_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_4.prefab_name].transform, "story_v_side_old_921011", "921011093", "story_v_side_old_921011.awb")

						arg_387_1:RecordAudio("921011093", var_390_9)
						arg_387_1:RecordAudio("921011093", var_390_9)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011093", "story_v_side_old_921011.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011093", "story_v_side_old_921011.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_10 = math.max(var_390_3, arg_387_1.talkMaxDuration)

			if var_390_2 <= arg_387_1.time_ and arg_387_1.time_ < var_390_2 + var_390_10 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_2) / var_390_10

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_2 + var_390_10 and arg_387_1.time_ < var_390_2 + var_390_10 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play921011094 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 921011094
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play921011095(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(arg_391_1.actors_["10124ui_story"]) and arg_391_1.var_.characterEffect10124ui_story == nil then
				arg_391_1.var_.characterEffect10124ui_story = arg_391_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_0 = 0.200000002980232

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_0 and not isNil(arg_391_1.actors_["10124ui_story"]) then
				if arg_391_1.var_.characterEffect10124ui_story and not isNil(arg_391_1.actors_["10124ui_story"]) then
					arg_391_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_391_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_391_1.time_ - 0) / var_394_0)
				end
			end

			if arg_391_1.time_ >= 0 + var_394_0 and arg_391_1.time_ < 0 + var_394_0 + arg_394_0 and not isNil(arg_391_1.actors_["10124ui_story"]) and arg_391_1.var_.characterEffect10124ui_story then
				arg_391_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_391_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_394_1 = 0
			local var_394_2 = 0.75

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_3 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(921011094).content)

				arg_391_1.text_.text = var_394_3

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_5 = 30 <= 0 and var_394_2 or var_394_2 * (utf8.len(var_394_3) / 30)

				if (30 <= 0 and var_394_2 or var_394_2 * (utf8.len(var_394_3) / 30)) > 0 and var_394_2 < var_394_5 then
					arg_391_1.talkMaxDuration = var_394_5

					if var_394_5 + var_394_1 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_5 + var_394_1
					end
				end

				arg_391_1.text_.text = var_394_3
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_6 = math.max(var_394_2, arg_391_1.talkMaxDuration)

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_6 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_1) / var_394_6

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_1 + var_394_6 and arg_391_1.time_ < var_394_1 + var_394_6 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play921011095 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 921011095
		arg_395_1.duration_ = 6.6

		local var_395_0 = {
			zh = 6.6,
			ja = 3.3
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play921011096(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(arg_395_1.actors_["10124ui_story"]) and arg_395_1.var_.characterEffect10124ui_story == nil then
				arg_395_1.var_.characterEffect10124ui_story = arg_395_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_0 = 0.200000002980232

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 and not isNil(arg_395_1.actors_["10124ui_story"]) then
				if arg_395_1.var_.characterEffect10124ui_story and not isNil(arg_395_1.actors_["10124ui_story"]) then
					arg_395_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 and not isNil(arg_395_1.actors_["10124ui_story"]) and arg_395_1.var_.characterEffect10124ui_story then
				arg_395_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/story109502/story109502actionlink/109502action425")
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_398_2 = 0
			local var_398_3 = 0.575

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_2 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_4 = arg_395_1:GetWordFromCfg(921011095)
				local var_398_5 = arg_395_1:FormatText(var_398_4.content)

				arg_395_1.text_.text = var_398_5

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_7 = 23 <= 0 and var_398_3 or var_398_3 * (utf8.len(var_398_5) / 23)

				if (23 <= 0 and var_398_3 or var_398_3 * (utf8.len(var_398_5) / 23)) > 0 and var_398_3 < var_398_7 then
					arg_395_1.talkMaxDuration = var_398_7

					if var_398_7 + var_398_2 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_7 + var_398_2
					end
				end

				arg_395_1.text_.text = var_398_5
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011095", "story_v_side_old_921011.awb") ~= 0 then
					local var_398_8 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011095", "story_v_side_old_921011.awb") / 1000

					if var_398_8 + var_398_2 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_8 + var_398_2
					end

					if var_398_4.prefab_name ~= "" and arg_395_1.actors_[var_398_4.prefab_name] ~= nil then
						local var_398_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_4.prefab_name].transform, "story_v_side_old_921011", "921011095", "story_v_side_old_921011.awb")

						arg_395_1:RecordAudio("921011095", var_398_9)
						arg_395_1:RecordAudio("921011095", var_398_9)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011095", "story_v_side_old_921011.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011095", "story_v_side_old_921011.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_10 = math.max(var_398_3, arg_395_1.talkMaxDuration)

			if var_398_2 <= arg_395_1.time_ and arg_395_1.time_ < var_398_2 + var_398_10 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_2) / var_398_10

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_2 + var_398_10 and arg_395_1.time_ < var_398_2 + var_398_10 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play921011096 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 921011096
		arg_399_1.duration_ = 8

		local var_399_0 = {
			zh = 4.133,
			ja = 8
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play921011097(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0.5

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_1 = arg_399_1:GetWordFromCfg(921011096)
				local var_402_2 = arg_399_1:FormatText(var_402_1.content)

				arg_399_1.text_.text = var_402_2

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_4 = 20 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_2) / 20)

				if (20 <= 0 and var_402_0 or var_402_0 * (utf8.len(var_402_2) / 20)) > 0 and var_402_0 < var_402_4 then
					arg_399_1.talkMaxDuration = var_402_4

					if var_402_4 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_4 + 0
					end
				end

				arg_399_1.text_.text = var_402_2
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011096", "story_v_side_old_921011.awb") ~= 0 then
					local var_402_5 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011096", "story_v_side_old_921011.awb") / 1000

					if var_402_5 + 0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_5 + 0
					end

					if var_402_1.prefab_name ~= "" and arg_399_1.actors_[var_402_1.prefab_name] ~= nil then
						local var_402_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_1.prefab_name].transform, "story_v_side_old_921011", "921011096", "story_v_side_old_921011.awb")

						arg_399_1:RecordAudio("921011096", var_402_6)
						arg_399_1:RecordAudio("921011096", var_402_6)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011096", "story_v_side_old_921011.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011096", "story_v_side_old_921011.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_7 = math.max(var_402_0, arg_399_1.talkMaxDuration)

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_7 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - 0) / var_402_7

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= 0 + var_402_7 and arg_399_1.time_ < 0 + var_402_7 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play921011097 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 921011097
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play921011098(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(arg_403_1.actors_["10124ui_story"]) and arg_403_1.var_.characterEffect10124ui_story == nil then
				arg_403_1.var_.characterEffect10124ui_story = arg_403_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_0 = 0.200000002980232

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 and not isNil(arg_403_1.actors_["10124ui_story"]) then
				if arg_403_1.var_.characterEffect10124ui_story and not isNil(arg_403_1.actors_["10124ui_story"]) then
					arg_403_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_403_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_403_1.time_ - 0) / var_406_0)
				end
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 and not isNil(arg_403_1.actors_["10124ui_story"]) and arg_403_1.var_.characterEffect10124ui_story then
				arg_403_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_403_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_406_1 = 0
			local var_406_2 = 0.25

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, true)
				arg_403_1.iconController_:SetSelectedState("hero")

				arg_403_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_403_1.callingController_:SetSelectedState("normal")

				arg_403_1.keyicon_.color = Color.New(1, 1, 1)
				arg_403_1.icon_.color = Color.New(1, 1, 1)

				local var_406_3 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(921011097).content)

				arg_403_1.text_.text = var_406_3

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_5 = 10 <= 0 and var_406_2 or var_406_2 * (utf8.len(var_406_3) / 10)

				if (10 <= 0 and var_406_2 or var_406_2 * (utf8.len(var_406_3) / 10)) > 0 and var_406_2 < var_406_5 then
					arg_403_1.talkMaxDuration = var_406_5

					if var_406_5 + var_406_1 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_5 + var_406_1
					end
				end

				arg_403_1.text_.text = var_406_3
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_6 = math.max(var_406_2, arg_403_1.talkMaxDuration)

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_6 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_1) / var_406_6

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_1 + var_406_6 and arg_403_1.time_ < var_406_1 + var_406_6 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play921011098 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 921011098
		arg_407_1.duration_ = 9.67

		local var_407_0 = {
			zh = 8.266,
			ja = 9.666
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play921011099(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(arg_407_1.actors_["10124ui_story"]) and arg_407_1.var_.characterEffect10124ui_story == nil then
				arg_407_1.var_.characterEffect10124ui_story = arg_407_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_0 = 0.200000002980232

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 and not isNil(arg_407_1.actors_["10124ui_story"]) then
				if arg_407_1.var_.characterEffect10124ui_story and not isNil(arg_407_1.actors_["10124ui_story"]) then
					arg_407_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 and not isNil(arg_407_1.actors_["10124ui_story"]) and arg_407_1.var_.characterEffect10124ui_story then
				arg_407_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action5_2")
			end

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_410_2 = 0
			local var_410_3 = 0.775

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_2 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_4 = arg_407_1:GetWordFromCfg(921011098)
				local var_410_5 = arg_407_1:FormatText(var_410_4.content)

				arg_407_1.text_.text = var_410_5

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_7 = 31 <= 0 and var_410_3 or var_410_3 * (utf8.len(var_410_5) / 31)

				if (31 <= 0 and var_410_3 or var_410_3 * (utf8.len(var_410_5) / 31)) > 0 and var_410_3 < var_410_7 then
					arg_407_1.talkMaxDuration = var_410_7

					if var_410_7 + var_410_2 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_7 + var_410_2
					end
				end

				arg_407_1.text_.text = var_410_5
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011098", "story_v_side_old_921011.awb") ~= 0 then
					local var_410_8 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011098", "story_v_side_old_921011.awb") / 1000

					if var_410_8 + var_410_2 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_8 + var_410_2
					end

					if var_410_4.prefab_name ~= "" and arg_407_1.actors_[var_410_4.prefab_name] ~= nil then
						local var_410_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_4.prefab_name].transform, "story_v_side_old_921011", "921011098", "story_v_side_old_921011.awb")

						arg_407_1:RecordAudio("921011098", var_410_9)
						arg_407_1:RecordAudio("921011098", var_410_9)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011098", "story_v_side_old_921011.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011098", "story_v_side_old_921011.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_10 = math.max(var_410_3, arg_407_1.talkMaxDuration)

			if var_410_2 <= arg_407_1.time_ and arg_407_1.time_ < var_410_2 + var_410_10 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_2) / var_410_10

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_2 + var_410_10 and arg_407_1.time_ < var_410_2 + var_410_10 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play921011099 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 921011099
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play921011100(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(arg_411_1.actors_["10124ui_story"]) and arg_411_1.var_.characterEffect10124ui_story == nil then
				arg_411_1.var_.characterEffect10124ui_story = arg_411_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_0 = 0.200000002980232

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 and not isNil(arg_411_1.actors_["10124ui_story"]) then
				if arg_411_1.var_.characterEffect10124ui_story and not isNil(arg_411_1.actors_["10124ui_story"]) then
					arg_411_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_411_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_411_1.time_ - 0) / var_414_0)
				end
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 and not isNil(arg_411_1.actors_["10124ui_story"]) and arg_411_1.var_.characterEffect10124ui_story then
				arg_411_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_411_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_414_1 = 0
			local var_414_2 = 0.125

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_3 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(921011099).content)

				arg_411_1.text_.text = var_414_3

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_5 = 5 <= 0 and var_414_2 or var_414_2 * (utf8.len(var_414_3) / 5)

				if (5 <= 0 and var_414_2 or var_414_2 * (utf8.len(var_414_3) / 5)) > 0 and var_414_2 < var_414_5 then
					arg_411_1.talkMaxDuration = var_414_5

					if var_414_5 + var_414_1 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_5 + var_414_1
					end
				end

				arg_411_1.text_.text = var_414_3
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_6 = math.max(var_414_2, arg_411_1.talkMaxDuration)

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_6 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_1) / var_414_6

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_1 + var_414_6 and arg_411_1.time_ < var_414_1 + var_414_6 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play921011100 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 921011100
		arg_415_1.duration_ = 5.43

		local var_415_0 = {
			zh = 2.7,
			ja = 5.433
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play921011101(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(arg_415_1.actors_["10124ui_story"]) and arg_415_1.var_.characterEffect10124ui_story == nil then
				arg_415_1.var_.characterEffect10124ui_story = arg_415_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_0 = 0.200000002980232

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 and not isNil(arg_415_1.actors_["10124ui_story"]) then
				if arg_415_1.var_.characterEffect10124ui_story and not isNil(arg_415_1.actors_["10124ui_story"]) then
					arg_415_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 and not isNil(arg_415_1.actors_["10124ui_story"]) and arg_415_1.var_.characterEffect10124ui_story then
				arg_415_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			local var_418_2 = 0
			local var_418_3 = 0.25

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_2 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_4 = arg_415_1:GetWordFromCfg(921011100)
				local var_418_5 = arg_415_1:FormatText(var_418_4.content)

				arg_415_1.text_.text = var_418_5

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_7 = 10 <= 0 and var_418_3 or var_418_3 * (utf8.len(var_418_5) / 10)

				if (10 <= 0 and var_418_3 or var_418_3 * (utf8.len(var_418_5) / 10)) > 0 and var_418_3 < var_418_7 then
					arg_415_1.talkMaxDuration = var_418_7

					if var_418_7 + var_418_2 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_7 + var_418_2
					end
				end

				arg_415_1.text_.text = var_418_5
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011100", "story_v_side_old_921011.awb") ~= 0 then
					local var_418_8 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011100", "story_v_side_old_921011.awb") / 1000

					if var_418_8 + var_418_2 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_8 + var_418_2
					end

					if var_418_4.prefab_name ~= "" and arg_415_1.actors_[var_418_4.prefab_name] ~= nil then
						local var_418_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_4.prefab_name].transform, "story_v_side_old_921011", "921011100", "story_v_side_old_921011.awb")

						arg_415_1:RecordAudio("921011100", var_418_9)
						arg_415_1:RecordAudio("921011100", var_418_9)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011100", "story_v_side_old_921011.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011100", "story_v_side_old_921011.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_10 = math.max(var_418_3, arg_415_1.talkMaxDuration)

			if var_418_2 <= arg_415_1.time_ and arg_415_1.time_ < var_418_2 + var_418_10 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_2) / var_418_10

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_2 + var_418_10 and arg_415_1.time_ < var_418_2 + var_418_10 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play921011101 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 921011101
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play921011102(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.moveOldPos10124ui_story = arg_419_1.actors_["10124ui_story"].transform.localPosition
			end

			local var_422_0 = 0.001

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 then
				arg_419_1.actors_["10124ui_story"].transform.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos10124ui_story, Vector3.New(0, 100, 0), (arg_419_1.time_ - 0) / var_422_0)
				arg_419_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["10124ui_story"].transform.position).z)
				arg_419_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["10124ui_story"].transform.localEulerAngles = arg_419_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 then
				arg_419_1.actors_["10124ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_419_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["10124ui_story"].transform.position).z)
				arg_419_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["10124ui_story"].transform.localEulerAngles = arg_419_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			local var_422_1 = arg_419_1.actors_["10124ui_story"]

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(var_422_1) and arg_419_1.var_.characterEffect10124ui_story == nil then
				arg_419_1.var_.characterEffect10124ui_story = var_422_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_2 = 0.200000002980232

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_2 and not isNil(var_422_1) then
				if arg_419_1.var_.characterEffect10124ui_story and not isNil(var_422_1) then
					arg_419_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_419_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_419_1.time_ - 0) / var_422_2)
				end
			end

			if arg_419_1.time_ >= 0 + var_422_2 and arg_419_1.time_ < 0 + var_422_2 + arg_422_0 and not isNil(var_422_1) and arg_419_1.var_.characterEffect10124ui_story then
				arg_419_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_419_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_422_3 = 0
			local var_422_4 = 0.8

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_3 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_5 = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(921011101).content)

				arg_419_1.text_.text = var_422_5

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_7 = 32 <= 0 and var_422_4 or var_422_4 * (utf8.len(var_422_5) / 32)

				if (32 <= 0 and var_422_4 or var_422_4 * (utf8.len(var_422_5) / 32)) > 0 and var_422_4 < var_422_7 then
					arg_419_1.talkMaxDuration = var_422_7

					if var_422_7 + var_422_3 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_7 + var_422_3
					end
				end

				arg_419_1.text_.text = var_422_5
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_8 = math.max(var_422_4, arg_419_1.talkMaxDuration)

			if var_422_3 <= arg_419_1.time_ and arg_419_1.time_ < var_422_3 + var_422_8 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_3) / var_422_8

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_3 + var_422_8 and arg_419_1.time_ < var_422_3 + var_422_8 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10124ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play921011102 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 921011102
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play921011103(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0.3

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_1 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(921011102).content)

				arg_423_1.text_.text = var_426_1

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_3 = 12 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_1) / 12)

				if (12 <= 0 and var_426_0 or var_426_0 * (utf8.len(var_426_1) / 12)) > 0 and var_426_0 < var_426_3 then
					arg_423_1.talkMaxDuration = var_426_3

					if var_426_3 + 0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_3 + 0
					end
				end

				arg_423_1.text_.text = var_426_1
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_4 = math.max(var_426_0, arg_423_1.talkMaxDuration)

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_4 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - 0) / var_426_4

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= 0 + var_426_4 and arg_423_1.time_ < 0 + var_426_4 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play921011103 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 921011103
		arg_427_1.duration_ = 5.47

		local var_427_0 = {
			zh = 5.466,
			ja = 4.966
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play921011104(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(arg_427_1.actors_["10124ui_story"]) and arg_427_1.var_.characterEffect10124ui_story == nil then
				arg_427_1.var_.characterEffect10124ui_story = arg_427_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_0 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 and not isNil(arg_427_1.actors_["10124ui_story"]) then
				if arg_427_1.var_.characterEffect10124ui_story and not isNil(arg_427_1.actors_["10124ui_story"]) then
					arg_427_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 and not isNil(arg_427_1.actors_["10124ui_story"]) and arg_427_1.var_.characterEffect10124ui_story then
				arg_427_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action3_1")
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_430_2 = arg_427_1.actors_["10124ui_story"].transform

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.var_.moveOldPos10124ui_story = var_430_2.localPosition
			end

			local var_430_3 = 0.001

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_3 then
				var_430_2.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos10124ui_story, Vector3.New(0, -0.98, -6.08), (arg_427_1.time_ - 0) / var_430_3)
				var_430_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_430_2.position).x, (manager.ui.mainCamera.transform.position - var_430_2.position).y, (manager.ui.mainCamera.transform.position - var_430_2.position).z)
				var_430_2.localEulerAngles.z = 0
				var_430_2.localEulerAngles.x = 0
				var_430_2.localEulerAngles = var_430_2.localEulerAngles
			end

			if arg_427_1.time_ >= 0 + var_430_3 and arg_427_1.time_ < 0 + var_430_3 + arg_430_0 then
				var_430_2.localPosition = Vector3.New(0, -0.98, -6.08)
				var_430_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_430_2.position).x, (manager.ui.mainCamera.transform.position - var_430_2.position).y, (manager.ui.mainCamera.transform.position - var_430_2.position).z)
				var_430_2.localEulerAngles.z = 0
				var_430_2.localEulerAngles.x = 0
				var_430_2.localEulerAngles = var_430_2.localEulerAngles
			end

			local var_430_4 = 0
			local var_430_5 = 0.5

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_4 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_6 = arg_427_1:GetWordFromCfg(921011103)
				local var_430_7 = arg_427_1:FormatText(var_430_6.content)

				arg_427_1.text_.text = var_430_7

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_9 = 20 <= 0 and var_430_5 or var_430_5 * (utf8.len(var_430_7) / 20)

				if (20 <= 0 and var_430_5 or var_430_5 * (utf8.len(var_430_7) / 20)) > 0 and var_430_5 < var_430_9 then
					arg_427_1.talkMaxDuration = var_430_9

					if var_430_9 + var_430_4 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_9 + var_430_4
					end
				end

				arg_427_1.text_.text = var_430_7
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011103", "story_v_side_old_921011.awb") ~= 0 then
					local var_430_10 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011103", "story_v_side_old_921011.awb") / 1000

					if var_430_10 + var_430_4 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_10 + var_430_4
					end

					if var_430_6.prefab_name ~= "" and arg_427_1.actors_[var_430_6.prefab_name] ~= nil then
						local var_430_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_6.prefab_name].transform, "story_v_side_old_921011", "921011103", "story_v_side_old_921011.awb")

						arg_427_1:RecordAudio("921011103", var_430_11)
						arg_427_1:RecordAudio("921011103", var_430_11)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011103", "story_v_side_old_921011.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011103", "story_v_side_old_921011.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_12 = math.max(var_430_5, arg_427_1.talkMaxDuration)

			if var_430_4 <= arg_427_1.time_ and arg_427_1.time_ < var_430_4 + var_430_12 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_4) / var_430_12

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_4 + var_430_12 and arg_427_1.time_ < var_430_4 + var_430_12 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10124ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play921011104 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 921011104
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play921011105(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(arg_431_1.actors_["10124ui_story"]) and arg_431_1.var_.characterEffect10124ui_story == nil then
				arg_431_1.var_.characterEffect10124ui_story = arg_431_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_0 = 0.200000002980232

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 and not isNil(arg_431_1.actors_["10124ui_story"]) then
				if arg_431_1.var_.characterEffect10124ui_story and not isNil(arg_431_1.actors_["10124ui_story"]) then
					arg_431_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_431_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_431_1.time_ - 0) / var_434_0)
				end
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 and not isNil(arg_431_1.actors_["10124ui_story"]) and arg_431_1.var_.characterEffect10124ui_story then
				arg_431_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_431_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_434_1 = 0
			local var_434_2 = 0.575

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_3 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(921011104).content)

				arg_431_1.text_.text = var_434_3

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_5 = 23 <= 0 and var_434_2 or var_434_2 * (utf8.len(var_434_3) / 23)

				if (23 <= 0 and var_434_2 or var_434_2 * (utf8.len(var_434_3) / 23)) > 0 and var_434_2 < var_434_5 then
					arg_431_1.talkMaxDuration = var_434_5

					if var_434_5 + var_434_1 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_5 + var_434_1
					end
				end

				arg_431_1.text_.text = var_434_3
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_6 = math.max(var_434_2, arg_431_1.talkMaxDuration)

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_6 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_1) / var_434_6

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_1 + var_434_6 and arg_431_1.time_ < var_434_1 + var_434_6 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play921011105 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 921011105
		arg_435_1.duration_ = 9.93

		local var_435_0 = {
			zh = 9.933,
			ja = 7.5
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
				arg_435_0:Play921011106(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["10124ui_story"]) and arg_435_1.var_.characterEffect10124ui_story == nil then
				arg_435_1.var_.characterEffect10124ui_story = arg_435_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_438_0 = 0.200000002980232

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 and not isNil(arg_435_1.actors_["10124ui_story"]) then
				if arg_435_1.var_.characterEffect10124ui_story and not isNil(arg_435_1.actors_["10124ui_story"]) then
					arg_435_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 and not isNil(arg_435_1.actors_["10124ui_story"]) and arg_435_1.var_.characterEffect10124ui_story then
				arg_435_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			local var_438_2 = 0
			local var_438_3 = 1.025

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_2 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_4 = arg_435_1:GetWordFromCfg(921011105)
				local var_438_5 = arg_435_1:FormatText(var_438_4.content)

				arg_435_1.text_.text = var_438_5

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_7 = 41 <= 0 and var_438_3 or var_438_3 * (utf8.len(var_438_5) / 41)

				if (41 <= 0 and var_438_3 or var_438_3 * (utf8.len(var_438_5) / 41)) > 0 and var_438_3 < var_438_7 then
					arg_435_1.talkMaxDuration = var_438_7

					if var_438_7 + var_438_2 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_7 + var_438_2
					end
				end

				arg_435_1.text_.text = var_438_5
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011105", "story_v_side_old_921011.awb") ~= 0 then
					local var_438_8 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011105", "story_v_side_old_921011.awb") / 1000

					if var_438_8 + var_438_2 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_8 + var_438_2
					end

					if var_438_4.prefab_name ~= "" and arg_435_1.actors_[var_438_4.prefab_name] ~= nil then
						local var_438_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_4.prefab_name].transform, "story_v_side_old_921011", "921011105", "story_v_side_old_921011.awb")

						arg_435_1:RecordAudio("921011105", var_438_9)
						arg_435_1:RecordAudio("921011105", var_438_9)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011105", "story_v_side_old_921011.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011105", "story_v_side_old_921011.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_10 = math.max(var_438_3, arg_435_1.talkMaxDuration)

			if var_438_2 <= arg_435_1.time_ and arg_435_1.time_ < var_438_2 + var_438_10 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_2) / var_438_10

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_2 + var_438_10 and arg_435_1.time_ < var_438_2 + var_438_10 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play921011106 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 921011106
		arg_439_1.duration_ = 5

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play921011107(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(arg_439_1.actors_["10124ui_story"]) and arg_439_1.var_.characterEffect10124ui_story == nil then
				arg_439_1.var_.characterEffect10124ui_story = arg_439_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_0 = 0.200000002980232

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 and not isNil(arg_439_1.actors_["10124ui_story"]) then
				if arg_439_1.var_.characterEffect10124ui_story and not isNil(arg_439_1.actors_["10124ui_story"]) then
					arg_439_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_439_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_439_1.time_ - 0) / var_442_0)
				end
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 and not isNil(arg_439_1.actors_["10124ui_story"]) and arg_439_1.var_.characterEffect10124ui_story then
				arg_439_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_439_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_442_1 = 0
			local var_442_2 = 0.175

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_1 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_439_1.callingController_:SetSelectedState("normal")

				arg_439_1.keyicon_.color = Color.New(1, 1, 1)
				arg_439_1.icon_.color = Color.New(1, 1, 1)

				local var_442_3 = arg_439_1:FormatText(arg_439_1:GetWordFromCfg(921011106).content)

				arg_439_1.text_.text = var_442_3

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_5 = 7 <= 0 and var_442_2 or var_442_2 * (utf8.len(var_442_3) / 7)

				if (7 <= 0 and var_442_2 or var_442_2 * (utf8.len(var_442_3) / 7)) > 0 and var_442_2 < var_442_5 then
					arg_439_1.talkMaxDuration = var_442_5

					if var_442_5 + var_442_1 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_5 + var_442_1
					end
				end

				arg_439_1.text_.text = var_442_3
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_6 = math.max(var_442_2, arg_439_1.talkMaxDuration)

			if var_442_1 <= arg_439_1.time_ and arg_439_1.time_ < var_442_1 + var_442_6 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_1) / var_442_6

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_1 + var_442_6 and arg_439_1.time_ < var_442_1 + var_442_6 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {}

		arg_439_1:InitPlayNodeList()
	end,
	Play921011107 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 921011107
		arg_443_1.duration_ = 6.67

		local var_443_0 = {
			zh = 6.666,
			ja = 4.066
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
				arg_443_0:Play921011108(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(arg_443_1.actors_["10124ui_story"]) and arg_443_1.var_.characterEffect10124ui_story == nil then
				arg_443_1.var_.characterEffect10124ui_story = arg_443_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_446_0 = 0.200000002980232

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_0 and not isNil(arg_443_1.actors_["10124ui_story"]) then
				if arg_443_1.var_.characterEffect10124ui_story and not isNil(arg_443_1.actors_["10124ui_story"]) then
					arg_443_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_443_1.time_ >= 0 + var_446_0 and arg_443_1.time_ < 0 + var_446_0 + arg_446_0 and not isNil(arg_443_1.actors_["10124ui_story"]) and arg_443_1.var_.characterEffect10124ui_story then
				arg_443_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			local var_446_2 = 0
			local var_446_3 = 0.9

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_2 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, false)
				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_4 = arg_443_1:GetWordFromCfg(921011107)
				local var_446_5 = arg_443_1:FormatText(var_446_4.content)

				arg_443_1.text_.text = var_446_5

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_7 = 38 <= 0 and var_446_3 or var_446_3 * (utf8.len(var_446_5) / 38)

				if (38 <= 0 and var_446_3 or var_446_3 * (utf8.len(var_446_5) / 38)) > 0 and var_446_3 < var_446_7 then
					arg_443_1.talkMaxDuration = var_446_7

					if var_446_7 + var_446_2 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_7 + var_446_2
					end
				end

				arg_443_1.text_.text = var_446_5
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011107", "story_v_side_old_921011.awb") ~= 0 then
					local var_446_8 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011107", "story_v_side_old_921011.awb") / 1000

					if var_446_8 + var_446_2 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_8 + var_446_2
					end

					if var_446_4.prefab_name ~= "" and arg_443_1.actors_[var_446_4.prefab_name] ~= nil then
						local var_446_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_4.prefab_name].transform, "story_v_side_old_921011", "921011107", "story_v_side_old_921011.awb")

						arg_443_1:RecordAudio("921011107", var_446_9)
						arg_443_1:RecordAudio("921011107", var_446_9)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011107", "story_v_side_old_921011.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011107", "story_v_side_old_921011.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_10 = math.max(var_446_3, arg_443_1.talkMaxDuration)

			if var_446_2 <= arg_443_1.time_ and arg_443_1.time_ < var_446_2 + var_446_10 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_2) / var_446_10

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_2 + var_446_10 and arg_443_1.time_ < var_446_2 + var_446_10 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play921011108 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 921011108
		arg_447_1.duration_ = 5

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play921011109(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			if 0 < arg_447_1.time_ and arg_447_1.time_ <= 0 + arg_450_0 and not isNil(arg_447_1.actors_["10124ui_story"]) and arg_447_1.var_.characterEffect10124ui_story == nil then
				arg_447_1.var_.characterEffect10124ui_story = arg_447_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_450_0 = 0.200000002980232

			if 0 <= arg_447_1.time_ and arg_447_1.time_ < 0 + var_450_0 and not isNil(arg_447_1.actors_["10124ui_story"]) then
				if arg_447_1.var_.characterEffect10124ui_story and not isNil(arg_447_1.actors_["10124ui_story"]) then
					arg_447_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_447_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_447_1.time_ - 0) / var_450_0)
				end
			end

			if arg_447_1.time_ >= 0 + var_450_0 and arg_447_1.time_ < 0 + var_450_0 + arg_450_0 and not isNil(arg_447_1.actors_["10124ui_story"]) and arg_447_1.var_.characterEffect10124ui_story then
				arg_447_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_447_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_450_1 = 0
			local var_450_2 = 0.35

			if 0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_1 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				arg_447_1.leftNameTxt_.text = arg_447_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, true)
				arg_447_1.iconController_:SetSelectedState("hero")

				arg_447_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_447_1.callingController_:SetSelectedState("normal")

				arg_447_1.keyicon_.color = Color.New(1, 1, 1)
				arg_447_1.icon_.color = Color.New(1, 1, 1)

				local var_450_3 = arg_447_1:FormatText(arg_447_1:GetWordFromCfg(921011108).content)

				arg_447_1.text_.text = var_450_3

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_5 = 14 <= 0 and var_450_2 or var_450_2 * (utf8.len(var_450_3) / 14)

				if (14 <= 0 and var_450_2 or var_450_2 * (utf8.len(var_450_3) / 14)) > 0 and var_450_2 < var_450_5 then
					arg_447_1.talkMaxDuration = var_450_5

					if var_450_5 + var_450_1 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_5 + var_450_1
					end
				end

				arg_447_1.text_.text = var_450_3
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)
				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_6 = math.max(var_450_2, arg_447_1.talkMaxDuration)

			if var_450_1 <= arg_447_1.time_ and arg_447_1.time_ < var_450_1 + var_450_6 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_1) / var_450_6

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_1 + var_450_6 and arg_447_1.time_ < var_450_1 + var_450_6 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end

		arg_447_1.nodeConfigList_ = {}

		arg_447_1:InitPlayNodeList()
	end,
	Play921011109 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 921011109
		arg_451_1.duration_ = 9.2

		local var_451_0 = {
			zh = 8.9,
			ja = 9.2
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
				arg_451_0:Play921011110(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1.var_.moveOldPos10124ui_story = arg_451_1.actors_["10124ui_story"].transform.localPosition
			end

			local var_454_0 = 0.001

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_0 then
				arg_451_1.actors_["10124ui_story"].transform.localPosition = Vector3.Lerp(arg_451_1.var_.moveOldPos10124ui_story, Vector3.New(0, -0.98, -6.08), (arg_451_1.time_ - 0) / var_454_0)
				arg_451_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_451_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["10124ui_story"].transform.position).z)
				arg_451_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_451_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_451_1.actors_["10124ui_story"].transform.localEulerAngles = arg_451_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			if arg_451_1.time_ >= 0 + var_454_0 and arg_451_1.time_ < 0 + var_454_0 + arg_454_0 then
				arg_451_1.actors_["10124ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.08)
				arg_451_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_451_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_451_1.actors_["10124ui_story"].transform.position).z)
				arg_451_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_451_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_451_1.actors_["10124ui_story"].transform.localEulerAngles = arg_451_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			local var_454_1 = arg_451_1.actors_["10124ui_story"]

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 and not isNil(var_454_1) and arg_451_1.var_.characterEffect10124ui_story == nil then
				arg_451_1.var_.characterEffect10124ui_story = var_454_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_2 = 0.200000002980232

			if 0 <= arg_451_1.time_ and arg_451_1.time_ < 0 + var_454_2 and not isNil(var_454_1) then
				if arg_451_1.var_.characterEffect10124ui_story and not isNil(var_454_1) then
					arg_451_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_451_1.time_ >= 0 + var_454_2 and arg_451_1.time_ < 0 + var_454_2 + arg_454_0 and not isNil(var_454_1) and arg_451_1.var_.characterEffect10124ui_story then
				arg_451_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/story109502/story109502action/109502action3_2")
			end

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= 0 + arg_454_0 then
				arg_451_1:PlayTimeline("10124ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_454_4 = 0
			local var_454_5 = 0.85

			if 0 < arg_451_1.time_ and arg_451_1.time_ <= var_454_4 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				arg_451_1.leftNameTxt_.text = arg_451_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_6 = arg_451_1:GetWordFromCfg(921011109)
				local var_454_7 = arg_451_1:FormatText(var_454_6.content)

				arg_451_1.text_.text = var_454_7

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_9 = 34 <= 0 and var_454_5 or var_454_5 * (utf8.len(var_454_7) / 34)

				if (34 <= 0 and var_454_5 or var_454_5 * (utf8.len(var_454_7) / 34)) > 0 and var_454_5 < var_454_9 then
					arg_451_1.talkMaxDuration = var_454_9

					if var_454_9 + var_454_4 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_9 + var_454_4
					end
				end

				arg_451_1.text_.text = var_454_7
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011109", "story_v_side_old_921011.awb") ~= 0 then
					local var_454_10 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011109", "story_v_side_old_921011.awb") / 1000

					if var_454_10 + var_454_4 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_10 + var_454_4
					end

					if var_454_6.prefab_name ~= "" and arg_451_1.actors_[var_454_6.prefab_name] ~= nil then
						local var_454_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_6.prefab_name].transform, "story_v_side_old_921011", "921011109", "story_v_side_old_921011.awb")

						arg_451_1:RecordAudio("921011109", var_454_11)
						arg_451_1:RecordAudio("921011109", var_454_11)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011109", "story_v_side_old_921011.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011109", "story_v_side_old_921011.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_12 = math.max(var_454_5, arg_451_1.talkMaxDuration)

			if var_454_4 <= arg_451_1.time_ and arg_451_1.time_ < var_454_4 + var_454_12 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_4) / var_454_12

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_4 + var_454_12 and arg_451_1.time_ < var_454_4 + var_454_12 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end

		arg_451_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10124ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_451_1:InitPlayNodeList()
	end,
	Play921011110 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 921011110
		arg_455_1.duration_ = 5

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play921011111(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 and not isNil(arg_455_1.actors_["10124ui_story"]) and arg_455_1.var_.characterEffect10124ui_story == nil then
				arg_455_1.var_.characterEffect10124ui_story = arg_455_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_0 = 0.200000002980232

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_0 and not isNil(arg_455_1.actors_["10124ui_story"]) then
				if arg_455_1.var_.characterEffect10124ui_story and not isNil(arg_455_1.actors_["10124ui_story"]) then
					arg_455_1.var_.characterEffect10124ui_story.fillFlat = true
					arg_455_1.var_.characterEffect10124ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_455_1.time_ - 0) / var_458_0)
				end
			end

			if arg_455_1.time_ >= 0 + var_458_0 and arg_455_1.time_ < 0 + var_458_0 + arg_458_0 and not isNil(arg_455_1.actors_["10124ui_story"]) and arg_455_1.var_.characterEffect10124ui_story then
				arg_455_1.var_.characterEffect10124ui_story.fillFlat = true
				arg_455_1.var_.characterEffect10124ui_story.fillRatio = 0.5
			end

			local var_458_1 = 0
			local var_458_2 = 0.4

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, true)
				arg_455_1.iconController_:SetSelectedState("hero")

				arg_455_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_455_1.callingController_:SetSelectedState("normal")

				arg_455_1.keyicon_.color = Color.New(1, 1, 1)
				arg_455_1.icon_.color = Color.New(1, 1, 1)

				local var_458_3 = arg_455_1:FormatText(arg_455_1:GetWordFromCfg(921011110).content)

				arg_455_1.text_.text = var_458_3

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_5 = 16 <= 0 and var_458_2 or var_458_2 * (utf8.len(var_458_3) / 16)

				if (16 <= 0 and var_458_2 or var_458_2 * (utf8.len(var_458_3) / 16)) > 0 and var_458_2 < var_458_5 then
					arg_455_1.talkMaxDuration = var_458_5

					if var_458_5 + var_458_1 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_5 + var_458_1
					end
				end

				arg_455_1.text_.text = var_458_3
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)
				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_6 = math.max(var_458_2, arg_455_1.talkMaxDuration)

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_6 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_1) / var_458_6

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_1 + var_458_6 and arg_455_1.time_ < var_458_1 + var_458_6 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {}

		arg_455_1:InitPlayNodeList()
	end,
	Play921011111 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 921011111
		arg_459_1.duration_ = 5

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play921011112(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 then
				arg_459_1.var_.moveOldPos10124ui_story = arg_459_1.actors_["10124ui_story"].transform.localPosition
			end

			local var_462_0 = 0.001

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_0 then
				arg_459_1.actors_["10124ui_story"].transform.localPosition = Vector3.Lerp(arg_459_1.var_.moveOldPos10124ui_story, Vector3.New(0, 100, 0), (arg_459_1.time_ - 0) / var_462_0)
				arg_459_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_459_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["10124ui_story"].transform.position).z)
				arg_459_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_459_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_459_1.actors_["10124ui_story"].transform.localEulerAngles = arg_459_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			if arg_459_1.time_ >= 0 + var_462_0 and arg_459_1.time_ < 0 + var_462_0 + arg_462_0 then
				arg_459_1.actors_["10124ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_459_1.actors_["10124ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_459_1.actors_["10124ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["10124ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_459_1.actors_["10124ui_story"].transform.position).z)
				arg_459_1.actors_["10124ui_story"].transform.localEulerAngles.z = 0
				arg_459_1.actors_["10124ui_story"].transform.localEulerAngles.x = 0
				arg_459_1.actors_["10124ui_story"].transform.localEulerAngles = arg_459_1.actors_["10124ui_story"].transform.localEulerAngles
			end

			local var_462_1 = 0
			local var_462_2 = 1.125

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_1 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, false)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_3 = arg_459_1:FormatText(arg_459_1:GetWordFromCfg(921011111).content)

				arg_459_1.text_.text = var_462_3

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_5 = 37 <= 0 and var_462_2 or var_462_2 * (utf8.len(var_462_3) / 37)

				if (37 <= 0 and var_462_2 or var_462_2 * (utf8.len(var_462_3) / 37)) > 0 and var_462_2 < var_462_5 then
					arg_459_1.talkMaxDuration = var_462_5

					if var_462_5 + var_462_1 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_5 + var_462_1
					end
				end

				arg_459_1.text_.text = var_462_3
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)
				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_6 = math.max(var_462_2, arg_459_1.talkMaxDuration)

			if var_462_1 <= arg_459_1.time_ and arg_459_1.time_ < var_462_1 + var_462_6 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_1) / var_462_6

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_1 + var_462_6 and arg_459_1.time_ < var_462_1 + var_462_6 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10124ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_459_1:InitPlayNodeList()
	end,
	Play921011112 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 921011112
		arg_463_1.duration_ = 4.69

		local var_463_0 = {
			zh = 3.15833333631257,
			ja = 4.69133333631257
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
				arg_463_0:Play921011113(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			if 2.03333333333177 < arg_463_1.time_ and arg_463_1.time_ <= 2.03333333333177 + arg_466_0 and not isNil(arg_463_1.actors_["10124ui_story"]) and arg_463_1.var_.characterEffect10124ui_story == nil then
				arg_463_1.var_.characterEffect10124ui_story = arg_463_1.actors_["10124ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_0 = 0.200000002980232

			if 2.03333333333177 <= arg_463_1.time_ and arg_463_1.time_ < 2.03333333333177 + var_466_0 and not isNil(arg_463_1.actors_["10124ui_story"]) then
				if arg_463_1.var_.characterEffect10124ui_story and not isNil(arg_463_1.actors_["10124ui_story"]) then
					arg_463_1.var_.characterEffect10124ui_story.fillFlat = false
				end
			end

			if arg_463_1.time_ >= 2.03333333333177 + var_466_0 and arg_463_1.time_ < 2.03333333333177 + var_466_0 + arg_466_0 and not isNil(arg_463_1.actors_["10124ui_story"]) and arg_463_1.var_.characterEffect10124ui_story then
				arg_463_1.var_.characterEffect10124ui_story.fillFlat = false
			end

			if 1 < arg_463_1.time_ and arg_463_1.time_ <= 1 + arg_466_0 then
				local var_466_2 = arg_463_1.bgs_.STblack

				arg_463_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_466_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_466_3 = var_466_2:GetComponent("SpriteRenderer")

				if var_466_3 and var_466_3.sprite then
					local var_466_4 = 2 * (var_466_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_466_2.transform.localScale = Vector3.New(var_466_4 / var_466_3.sprite.bounds.size.y < var_466_4 * manager.ui.mainCameraCom_.aspect / var_466_3.sprite.bounds.size.x and var_466_4 * manager.ui.mainCameraCom_.aspect / var_466_3.sprite.bounds.size.x or var_466_4 / var_466_3.sprite.bounds.size.y, var_466_4 / var_466_3.sprite.bounds.size.y < var_466_4 * manager.ui.mainCameraCom_.aspect / var_466_3.sprite.bounds.size.x and var_466_4 * manager.ui.mainCameraCom_.aspect / var_466_3.sprite.bounds.size.x or var_466_4 / var_466_3.sprite.bounds.size.y, 0)
				end

				for iter_466_0, iter_466_1 in pairs(arg_463_1.bgs_) do
					if iter_466_0 ~= "STblack" then
						iter_466_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_466_5 = 0

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_5 + arg_466_0 then
				arg_463_1.mask_.enabled = true
				arg_463_1.mask_.raycastTarget = true

				arg_463_1:SetGaussion(false)
			end

			local var_466_6 = 1

			if var_466_5 <= arg_463_1.time_ and arg_463_1.time_ < var_466_5 + var_466_6 then
				local var_466_7 = Color.New(0, 0, 0)

				var_466_7.a = Mathf.Lerp(0, 1, (arg_463_1.time_ - var_466_5) / var_466_6)
				arg_463_1.mask_.color = var_466_7
			end

			if arg_463_1.time_ >= var_466_5 + var_466_6 and arg_463_1.time_ < var_466_5 + var_466_6 + arg_466_0 then
				local var_466_8 = Color.New(0, 0, 0)

				var_466_8.a = 1
				arg_463_1.mask_.color = var_466_8
			end

			local var_466_9 = 1

			if 1 < arg_463_1.time_ and arg_463_1.time_ <= var_466_9 + arg_466_0 then
				arg_463_1.mask_.enabled = true
				arg_463_1.mask_.raycastTarget = true

				arg_463_1:SetGaussion(false)
			end

			local var_466_10 = 1.099999999999

			if var_466_9 <= arg_463_1.time_ and arg_463_1.time_ < var_466_9 + var_466_10 then
				local var_466_11 = Color.New(0, 0, 0)

				var_466_11.a = Mathf.Lerp(1, 0, (arg_463_1.time_ - var_466_9) / var_466_10)
				arg_463_1.mask_.color = var_466_11
			end

			if arg_463_1.time_ >= var_466_9 + var_466_10 and arg_463_1.time_ < var_466_9 + var_466_10 + arg_466_0 then
				local var_466_12 = Color.New(0, 0, 0)

				arg_463_1.mask_.enabled = false
				var_466_12.a = 0
				arg_463_1.mask_.color = var_466_12
			end

			if arg_463_1.frameCnt_ <= 1 then
				arg_463_1.dialog_:SetActive(false)
			end

			local var_466_13 = 2.15833333631257
			local var_466_14 = 0.075

			if 2.15833333631257 < arg_463_1.time_ and arg_463_1.time_ <= var_466_13 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0

				arg_463_1.dialog_:SetActive(true)

				arg_463_1.dialogCg_.alpha = 0

				local var_466_15 = LeanTween.value(arg_463_1.dialog_, 0, 1, 0.3)

				var_466_15:setOnUpdate(LuaHelper.FloatAction(function(arg_467_0)
					arg_463_1.dialogCg_.alpha = arg_467_0
				end))
				var_466_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_463_1.dialog_)
					var_466_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_463_1.duration_ = arg_463_1.duration_ + 0.3

				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, true)
				arg_463_1.iconController_:SetSelectedState("hero")

				arg_463_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10124")

				arg_463_1.callingController_:SetSelectedState("normal")

				arg_463_1.keyicon_.color = Color.New(1, 1, 1)
				arg_463_1.icon_.color = Color.New(1, 1, 1)

				local var_466_16 = arg_463_1:GetWordFromCfg(921011112)
				local var_466_17 = arg_463_1:FormatText(var_466_16.content)

				arg_463_1.text_.text = var_466_17

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_19 = 3 <= 0 and var_466_14 or var_466_14 * (utf8.len(var_466_17) / 3)

				if (3 <= 0 and var_466_14 or var_466_14 * (utf8.len(var_466_17) / 3)) > 0 and var_466_14 < var_466_19 then
					arg_463_1.talkMaxDuration = var_466_19
					var_466_13 = var_466_13 + 0.3

					if var_466_19 + var_466_13 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_19 + var_466_13
					end
				end

				arg_463_1.text_.text = var_466_17
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011112", "story_v_side_old_921011.awb") ~= 0 then
					local var_466_20 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011112", "story_v_side_old_921011.awb") / 1000

					if var_466_20 + var_466_13 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_20 + var_466_13
					end

					if var_466_16.prefab_name ~= "" and arg_463_1.actors_[var_466_16.prefab_name] ~= nil then
						local var_466_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_16.prefab_name].transform, "story_v_side_old_921011", "921011112", "story_v_side_old_921011.awb")

						arg_463_1:RecordAudio("921011112", var_466_21)
						arg_463_1:RecordAudio("921011112", var_466_21)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011112", "story_v_side_old_921011.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011112", "story_v_side_old_921011.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_22 = var_466_13 + 0.3
			local var_466_23 = math.max(var_466_14, arg_463_1.talkMaxDuration)

			if var_466_13 + 0.3 <= arg_463_1.time_ and arg_463_1.time_ < var_466_22 + var_466_23 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_22) / var_466_23

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_22 + var_466_23 and arg_463_1.time_ < var_466_22 + var_466_23 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play921011113 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 921011113
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play921011114(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = 0.3

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
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

				local var_472_1 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(921011113).content)

				arg_469_1.text_.text = var_472_1

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_3 = 12 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_1) / 12)

				if (12 <= 0 and var_472_0 or var_472_0 * (utf8.len(var_472_1) / 12)) > 0 and var_472_0 < var_472_3 then
					arg_469_1.talkMaxDuration = var_472_3

					if var_472_3 + 0 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_3 + 0
					end
				end

				arg_469_1.text_.text = var_472_1
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_4 = math.max(var_472_0, arg_469_1.talkMaxDuration)

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_4 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - 0) / var_472_4

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= 0 + var_472_4 and arg_469_1.time_ < 0 + var_472_4 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {}

		arg_469_1:InitPlayNodeList()
	end,
	Play921011114 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 921011114
		arg_473_1.duration_ = 5.67

		local var_473_0 = {
			zh = 5.666,
			ja = 4.366
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
				arg_473_0:Play921011115(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0.575

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, true)
				arg_473_1.iconController_:SetSelectedState("hero")

				arg_473_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10124")

				arg_473_1.callingController_:SetSelectedState("normal")

				arg_473_1.keyicon_.color = Color.New(1, 1, 1)
				arg_473_1.icon_.color = Color.New(1, 1, 1)

				local var_476_1 = arg_473_1:GetWordFromCfg(921011114)
				local var_476_2 = arg_473_1:FormatText(var_476_1.content)

				arg_473_1.text_.text = var_476_2

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_4 = 23 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_2) / 23)

				if (23 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_2) / 23)) > 0 and var_476_0 < var_476_4 then
					arg_473_1.talkMaxDuration = var_476_4

					if var_476_4 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_4 + 0
					end
				end

				arg_473_1.text_.text = var_476_2
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011114", "story_v_side_old_921011.awb") ~= 0 then
					local var_476_5 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011114", "story_v_side_old_921011.awb") / 1000

					if var_476_5 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_5 + 0
					end

					if var_476_1.prefab_name ~= "" and arg_473_1.actors_[var_476_1.prefab_name] ~= nil then
						local var_476_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_1.prefab_name].transform, "story_v_side_old_921011", "921011114", "story_v_side_old_921011.awb")

						arg_473_1:RecordAudio("921011114", var_476_6)
						arg_473_1:RecordAudio("921011114", var_476_6)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011114", "story_v_side_old_921011.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011114", "story_v_side_old_921011.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_7 = math.max(var_476_0, arg_473_1.talkMaxDuration)

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_7 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - 0) / var_476_7

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= 0 + var_476_7 and arg_473_1.time_ < 0 + var_476_7 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play921011115 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 921011115
		arg_477_1.duration_ = 6.73

		local var_477_0 = {
			zh = 3.766,
			ja = 6.733
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play921011116(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0.3

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10124")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_1 = arg_477_1:GetWordFromCfg(921011115)
				local var_480_2 = arg_477_1:FormatText(var_480_1.content)

				arg_477_1.text_.text = var_480_2

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_4 = 12 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_2) / 12)

				if (12 <= 0 and var_480_0 or var_480_0 * (utf8.len(var_480_2) / 12)) > 0 and var_480_0 < var_480_4 then
					arg_477_1.talkMaxDuration = var_480_4

					if var_480_4 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_4 + 0
					end
				end

				arg_477_1.text_.text = var_480_2
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_921011", "921011115", "story_v_side_old_921011.awb") ~= 0 then
					local var_480_5 = manager.audio:GetVoiceLength("story_v_side_old_921011", "921011115", "story_v_side_old_921011.awb") / 1000

					if var_480_5 + 0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_5 + 0
					end

					if var_480_1.prefab_name ~= "" and arg_477_1.actors_[var_480_1.prefab_name] ~= nil then
						local var_480_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_1.prefab_name].transform, "story_v_side_old_921011", "921011115", "story_v_side_old_921011.awb")

						arg_477_1:RecordAudio("921011115", var_480_6)
						arg_477_1:RecordAudio("921011115", var_480_6)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_side_old_921011", "921011115", "story_v_side_old_921011.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_side_old_921011", "921011115", "story_v_side_old_921011.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_7 = math.max(var_480_0, arg_477_1.talkMaxDuration)

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_7 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - 0) / var_480_7

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= 0 + var_480_7 and arg_477_1.time_ < 0 + var_480_7 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play921011116 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 921011116
		arg_481_1.duration_ = 5

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
			arg_481_1.auto_ = false
		end

		function arg_481_1.playNext_(arg_483_0)
			arg_481_1.onStoryFinished_()
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0.05

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

				local var_484_1 = arg_481_1:FormatText(arg_481_1:GetWordFromCfg(921011116).content)

				arg_481_1.text_.text = var_484_1

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_3 = 2 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_1) / 2)

				if (2 <= 0 and var_484_0 or var_484_0 * (utf8.len(var_484_1) / 2)) > 0 and var_484_0 < var_484_3 then
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
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST60",
		"TextureConfig/Background/ST2201"
	},
	voices = {
		"story_v_side_old_921011.awb"
	}
}
