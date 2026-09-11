return {
	Play1101101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1101101001
		arg_1_1.duration_ = 5.7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1101101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.A02d == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A02d")
				var_4_0.name = "A02d"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.A02d = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.A02d

				arg_1_1.bgs_.A02d.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "A02d" then
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

			local var_4_5 = 3.5

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
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0
				arg_1_1.fswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1101101001).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_8 = 3.5

			if 3.5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_9 = 33
			local var_4_10 = 2.2
			local var_4_11, var_4_12 = arg_1_1:GetPercentByPara(arg_1_1:FormatText(arg_1_1:GetWordFromCfg(1101101001).content), 1)

			if var_4_8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_13 = var_4_9 <= 0 and var_4_10 or var_4_10 * ((var_4_12 - arg_1_1.typewritterCharCountI18N) / var_4_9)

				if (var_4_9 <= 0 and var_4_10 or var_4_10 * ((var_4_12 - arg_1_1.typewritterCharCountI18N) / var_4_9)) > 0 and var_4_10 < var_4_13 then
					arg_1_1.talkMaxDuration = var_4_13

					if var_4_13 + var_4_8 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_13 + var_4_8
					end
				end
			end

			local var_4_14 = math.max(2.2, arg_1_1.talkMaxDuration)

			if var_4_8 <= arg_1_1.time_ and arg_1_1.time_ < var_4_8 + var_4_14 then
				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_11, (arg_1_1.time_ - var_4_8) / var_4_14)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_8 + var_4_14 and arg_1_1.time_ < var_4_8 + var_4_14 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_11

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_12
			end

			if 3.5 < arg_1_1.time_ and arg_1_1.time_ <= 3.5 + arg_4_0 then
				local var_4_15 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_16 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_17 = var_4_15:GetComponent("RectTransform")

				var_4_15:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_17.offsetMin = Vector2.New(0, 0)
				var_4_17.offsetMax = Vector2.New(0, 0)
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

			if 0.533333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.533333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily04", "bgm_side_daily04", "bgm_side_daily04.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_side_daily04", "bgm_side_daily04")

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
	Play1101101002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 1101101002
		arg_7_1.duration_ = 9.2

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play1101101003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if arg_7_1.bgs_.H03a == nil then
				local var_10_0 = Object.Instantiate(arg_7_1.paintGo_)

				var_10_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H03a")
				var_10_0.name = "H03a"
				var_10_0.transform.parent = arg_7_1.stage_.transform
				var_10_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.bgs_.H03a = var_10_0
			end

			if 3.5 < arg_7_1.time_ and arg_7_1.time_ <= 3.5 + arg_10_0 then
				local var_10_1 = arg_7_1.bgs_.H03a

				arg_7_1.bgs_.H03a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_10_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_10_2 = var_10_1:GetComponent("SpriteRenderer")

				if var_10_2 and var_10_2.sprite then
					local var_10_3 = 2 * (var_10_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_10_1.transform.localScale = Vector3.New(var_10_3 / var_10_2.sprite.bounds.size.y < var_10_3 * manager.ui.mainCameraCom_.aspect / var_10_2.sprite.bounds.size.x and var_10_3 * manager.ui.mainCameraCom_.aspect / var_10_2.sprite.bounds.size.x or var_10_3 / var_10_2.sprite.bounds.size.y, var_10_3 / var_10_2.sprite.bounds.size.y < var_10_3 * manager.ui.mainCameraCom_.aspect / var_10_2.sprite.bounds.size.x and var_10_3 * manager.ui.mainCameraCom_.aspect / var_10_2.sprite.bounds.size.x or var_10_3 / var_10_2.sprite.bounds.size.y, 0)
				end

				for iter_10_0, iter_10_1 in pairs(arg_7_1.bgs_) do
					if iter_10_0 ~= "H03a" then
						iter_10_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_10_4 = 0

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_4 + arg_10_0 then
				arg_7_1.mask_.enabled = true
				arg_7_1.mask_.raycastTarget = true

				arg_7_1:SetGaussion(false)
			end

			local var_10_5 = 3.5

			if var_10_4 <= arg_7_1.time_ and arg_7_1.time_ < var_10_4 + var_10_5 then
				local var_10_6 = Color.New(0, 0, 0)

				var_10_6.a = Mathf.Lerp(0, 1, (arg_7_1.time_ - var_10_4) / var_10_5)
				arg_7_1.mask_.color = var_10_6
			end

			if arg_7_1.time_ >= var_10_4 + var_10_5 and arg_7_1.time_ < var_10_4 + var_10_5 + arg_10_0 then
				local var_10_7 = Color.New(0, 0, 0)

				var_10_7.a = 1
				arg_7_1.mask_.color = var_10_7
			end

			local var_10_8 = 3.5

			if 3.5 < arg_7_1.time_ and arg_7_1.time_ <= var_10_8 + arg_10_0 then
				arg_7_1.mask_.enabled = true
				arg_7_1.mask_.raycastTarget = true

				arg_7_1:SetGaussion(false)
			end

			local var_10_9 = 3.5

			if var_10_8 <= arg_7_1.time_ and arg_7_1.time_ < var_10_8 + var_10_9 then
				local var_10_10 = Color.New(0, 0, 0)

				var_10_10.a = Mathf.Lerp(1, 0, (arg_7_1.time_ - var_10_8) / var_10_9)
				arg_7_1.mask_.color = var_10_10
			end

			if arg_7_1.time_ >= var_10_8 + var_10_9 and arg_7_1.time_ < var_10_8 + var_10_9 + arg_10_0 then
				local var_10_11 = Color.New(0, 0, 0)

				arg_7_1.mask_.enabled = false
				var_10_11.a = 0
				arg_7_1.mask_.color = var_10_11
			end

			if 3.5 < arg_7_1.time_ and arg_7_1.time_ <= 3.5 + arg_10_0 then
				arg_7_1.fswbg_:SetActive(false)
				arg_7_1.dialog_:SetActive(false)
				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_7_1:ShowNextGo(false)
			end

			if 3.51666666666667 < arg_7_1.time_ and arg_7_1.time_ <= 3.51666666666667 + arg_10_0 then
				arg_7_1.fswbg_:SetActive(true)
				arg_7_1.dialog_:SetActive(false)

				arg_7_1.fswtw_.percent = 0
				arg_7_1.fswt_.text = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(1101101002).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.fswt_)

				arg_7_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_7_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_7_1.fswtw_:SetDirty()

				arg_7_1.typewritterCharCountI18N = 0

				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_7_1:ShowNextGo(false)
			end

			local var_10_12 = 7

			if 7 < arg_7_1.time_ and arg_7_1.time_ <= var_10_12 + arg_10_0 then
				arg_7_1.var_.oldValueTypewriter = arg_7_1.fswtw_.percent

				SetActive(arg_7_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_7_1:ShowNextGo(false)
			end

			local var_10_13 = -11
			local var_10_14 = 2.2
			local var_10_15, var_10_16 = arg_7_1:GetPercentByPara(arg_7_1:FormatText(arg_7_1:GetWordFromCfg(1101101002).content), 1)

			if var_10_12 < arg_7_1.time_ and arg_7_1.time_ <= var_10_12 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0

				local var_10_17 = var_10_13 <= 0 and var_10_14 or var_10_14 * ((var_10_16 - arg_7_1.typewritterCharCountI18N) / var_10_13)

				if (var_10_13 <= 0 and var_10_14 or var_10_14 * ((var_10_16 - arg_7_1.typewritterCharCountI18N) / var_10_13)) > 0 and var_10_14 < var_10_17 then
					arg_7_1.talkMaxDuration = var_10_17

					if var_10_17 + var_10_12 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_17 + var_10_12
					end
				end
			end

			local var_10_18 = math.max(2.2, arg_7_1.talkMaxDuration)

			if var_10_12 <= arg_7_1.time_ and arg_7_1.time_ < var_10_12 + var_10_18 then
				arg_7_1.fswtw_.percent = Mathf.Lerp(arg_7_1.var_.oldValueTypewriter, var_10_15, (arg_7_1.time_ - var_10_12) / var_10_18)
				arg_7_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_7_1.fswtw_:SetDirty()
			end

			if arg_7_1.time_ >= var_10_12 + var_10_18 and arg_7_1.time_ < var_10_12 + var_10_18 + arg_10_0 then
				arg_7_1.fswtw_.percent = var_10_15

				arg_7_1.fswtw_:SetDirty()
				arg_7_1:ShowNextGo(true)

				arg_7_1.typewritterCharCountI18N = var_10_16
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play1101101003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 1101101003
		arg_11_1.duration_ = 8.47

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play1101101004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if arg_11_1.bgs_.D07 == nil then
				local var_14_0 = Object.Instantiate(arg_11_1.paintGo_)

				var_14_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D07")
				var_14_0.name = "D07"
				var_14_0.transform.parent = arg_11_1.stage_.transform
				var_14_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.bgs_.D07 = var_14_0
			end

			if 3.5 < arg_11_1.time_ and arg_11_1.time_ <= 3.5 + arg_14_0 then
				local var_14_1 = arg_11_1.bgs_.D07

				arg_11_1.bgs_.D07.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_14_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_14_2 = var_14_1:GetComponent("SpriteRenderer")

				if var_14_2 and var_14_2.sprite then
					local var_14_3 = 2 * (var_14_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_14_1.transform.localScale = Vector3.New(var_14_3 / var_14_2.sprite.bounds.size.y < var_14_3 * manager.ui.mainCameraCom_.aspect / var_14_2.sprite.bounds.size.x and var_14_3 * manager.ui.mainCameraCom_.aspect / var_14_2.sprite.bounds.size.x or var_14_3 / var_14_2.sprite.bounds.size.y, var_14_3 / var_14_2.sprite.bounds.size.y < var_14_3 * manager.ui.mainCameraCom_.aspect / var_14_2.sprite.bounds.size.x and var_14_3 * manager.ui.mainCameraCom_.aspect / var_14_2.sprite.bounds.size.x or var_14_3 / var_14_2.sprite.bounds.size.y, 0)
				end

				for iter_14_0, iter_14_1 in pairs(arg_11_1.bgs_) do
					if iter_14_0 ~= "D07" then
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

			local var_14_5 = 3.5

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

			local var_14_8 = 3.5

			if 3.5 < arg_11_1.time_ and arg_11_1.time_ <= var_14_8 + arg_14_0 then
				arg_11_1.mask_.enabled = true
				arg_11_1.mask_.raycastTarget = true

				arg_11_1:SetGaussion(false)
			end

			local var_14_9 = 3.5

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

			if 3.5 < arg_11_1.time_ and arg_11_1.time_ <= 3.5 + arg_14_0 then
				arg_11_1.fswbg_:SetActive(true)
				arg_11_1.dialog_:SetActive(false)

				arg_11_1.fswtw_.percent = 0
				arg_11_1.fswt_.text = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(1101101003).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.fswt_)

				arg_11_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_11_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_11_1.fswtw_:SetDirty()

				arg_11_1.typewritterCharCountI18N = 0

				SetActive(arg_11_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_11_1:ShowNextGo(false)
			end

			local var_14_12 = 7

			if 7 < arg_11_1.time_ and arg_11_1.time_ <= var_14_12 + arg_14_0 then
				arg_11_1.var_.oldValueTypewriter = arg_11_1.fswtw_.percent

				SetActive(arg_11_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_11_1:ShowNextGo(false)
			end

			local var_14_13 = 27
			local var_14_14 = 1.46666666666667
			local var_14_15, var_14_16 = arg_11_1:GetPercentByPara(arg_11_1:FormatText(arg_11_1:GetWordFromCfg(1101101003).content), 1)

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

			local var_14_18 = math.max(1.46666666666667, arg_11_1.talkMaxDuration)

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

			local var_14_19 = "3016_tpose"

			if arg_11_1.actors_["3016_tpose"] == nil and not isNil((Asset.Load("Char/" .. "3016_tpose"))) then
				local var_14_20 = Object.Instantiate(Asset.Load("Char/" .. "3016_tpose"), arg_11_1.stage_.transform)

				var_14_20.name = var_14_19
				var_14_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.actors_[var_14_19] = var_14_20

				local var_14_21 = var_14_20:GetComponentInChildren(typeof(CharacterEffect))

				var_14_21.enabled = true

				local var_14_22 = GameObjectTools.GetOrAddComponent(var_14_20, typeof(DynamicBoneHelper))

				if var_14_22 then
					var_14_22:EnableDynamicBone(false)
				end

				arg_11_1:ShowWeapon(var_14_21.transform, false)

				arg_11_1.var_[var_14_19 .. "Animator"] = var_14_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_11_1.var_[var_14_19 .. "Animator"].applyRootMotion = true
				arg_11_1.var_[var_14_19 .. "LipSync"] = var_14_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_14_23 = arg_11_1.actors_["3016_tpose"].transform

			if 3.5 < arg_11_1.time_ and arg_11_1.time_ <= 3.5 + arg_14_0 then
				arg_11_1.var_.moveOldPos3016_tpose = var_14_23.localPosition

				local var_14_24 = GameObjectTools.GetOrAddComponent(var_14_23.gameObject, typeof(DynamicBoneHelper))

				if var_14_24 then
					var_14_24:EnableDynamicBone(false)
				end
			end

			local var_14_25 = 0.001

			if 3.5 <= arg_11_1.time_ and arg_11_1.time_ < 3.5 + var_14_25 then
				var_14_23.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos3016_tpose, Vector3.New(0, -1.781746, -0.41), (arg_11_1.time_ - 3.5) / var_14_25)
				var_14_23.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_23.position).x, (manager.ui.mainCamera.transform.position - var_14_23.position).y, (manager.ui.mainCamera.transform.position - var_14_23.position).z)
				var_14_23.localEulerAngles.z = 0
				var_14_23.localEulerAngles.x = 0
				var_14_23.localEulerAngles = var_14_23.localEulerAngles
			end

			if arg_11_1.time_ >= 3.5 + var_14_25 and arg_11_1.time_ < 3.5 + var_14_25 + arg_14_0 then
				var_14_23.localPosition = Vector3.New(0, -1.781746, -0.41)
				var_14_23.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_23.position).x, (manager.ui.mainCamera.transform.position - var_14_23.position).y, (manager.ui.mainCamera.transform.position - var_14_23.position).z)
				var_14_23.localEulerAngles.z = 0
				var_14_23.localEulerAngles.x = 0
				var_14_23.localEulerAngles = var_14_23.localEulerAngles

				local var_14_26 = GameObjectTools.GetOrAddComponent(var_14_23.gameObject, typeof(DynamicBoneHelper))

				if var_14_26 then
					var_14_26:EnableDynamicBone(true)
				end
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3016_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_11_1:InitPlayNodeList()
	end,
	Play1101101004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 1101101004
		arg_15_1.duration_ = 5.8

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play1101101005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if arg_15_1.bgs_.STblack == nil then
				local var_18_0 = Object.Instantiate(arg_15_1.paintGo_)

				var_18_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_18_0.name = "STblack"
				var_18_0.transform.parent = arg_15_1.stage_.transform
				var_18_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_15_1.bgs_.STblack = var_18_0
			end

			if 2 < arg_15_1.time_ and arg_15_1.time_ <= 2 + arg_18_0 then
				local var_18_1 = arg_15_1.bgs_.STblack

				arg_15_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_18_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_18_2 = var_18_1:GetComponent("SpriteRenderer")

				if var_18_2 and var_18_2.sprite then
					local var_18_3 = 2 * (var_18_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_18_1.transform.localScale = Vector3.New(var_18_3 / var_18_2.sprite.bounds.size.y < var_18_3 * manager.ui.mainCameraCom_.aspect / var_18_2.sprite.bounds.size.x and var_18_3 * manager.ui.mainCameraCom_.aspect / var_18_2.sprite.bounds.size.x or var_18_3 / var_18_2.sprite.bounds.size.y, var_18_3 / var_18_2.sprite.bounds.size.y < var_18_3 * manager.ui.mainCameraCom_.aspect / var_18_2.sprite.bounds.size.x and var_18_3 * manager.ui.mainCameraCom_.aspect / var_18_2.sprite.bounds.size.x or var_18_3 / var_18_2.sprite.bounds.size.y, 0)
				end

				for iter_18_0, iter_18_1 in pairs(arg_15_1.bgs_) do
					if iter_18_0 ~= "STblack" then
						iter_18_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_18_4 = arg_15_1.actors_["3016_tpose"].transform

			if 2 < arg_15_1.time_ and arg_15_1.time_ <= 2 + arg_18_0 then
				arg_15_1.var_.moveOldPos3016_tpose = var_18_4.localPosition

				local var_18_5 = GameObjectTools.GetOrAddComponent(var_18_4.gameObject, typeof(DynamicBoneHelper))

				if var_18_5 then
					var_18_5:EnableDynamicBone(false)
				end
			end

			local var_18_6 = 0.001

			if 2 <= arg_15_1.time_ and arg_15_1.time_ < 2 + var_18_6 then
				var_18_4.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos3016_tpose, Vector3.New(0, 100, 0), (arg_15_1.time_ - 2) / var_18_6)
				var_18_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_4.position).x, (manager.ui.mainCamera.transform.position - var_18_4.position).y, (manager.ui.mainCamera.transform.position - var_18_4.position).z)
				var_18_4.localEulerAngles.z = 0
				var_18_4.localEulerAngles.x = 0
				var_18_4.localEulerAngles = var_18_4.localEulerAngles
			end

			if arg_15_1.time_ >= 2 + var_18_6 and arg_15_1.time_ < 2 + var_18_6 + arg_18_0 then
				var_18_4.localPosition = Vector3.New(0, 100, 0)
				var_18_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_4.position).x, (manager.ui.mainCamera.transform.position - var_18_4.position).y, (manager.ui.mainCamera.transform.position - var_18_4.position).z)
				var_18_4.localEulerAngles.z = 0
				var_18_4.localEulerAngles.x = 0
				var_18_4.localEulerAngles = var_18_4.localEulerAngles

				local var_18_7 = GameObjectTools.GetOrAddComponent(var_18_4.gameObject, typeof(DynamicBoneHelper))

				if var_18_7 then
					var_18_7:EnableDynamicBone(true)
				end
			end

			if 2 < arg_15_1.time_ and arg_15_1.time_ <= 2 + arg_18_0 then
				arg_15_1.fswbg_:SetActive(true)
				arg_15_1.dialog_:SetActive(false)

				arg_15_1.fswtw_.percent = 0
				arg_15_1.fswt_.text = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(1101101004).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.fswt_)

				arg_15_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_15_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_15_1.fswtw_:SetDirty()

				arg_15_1.typewritterCharCountI18N = 0

				SetActive(arg_15_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_15_1:ShowNextGo(false)
			end

			local var_18_8 = 4

			if 4 < arg_15_1.time_ and arg_15_1.time_ <= var_18_8 + arg_18_0 then
				arg_15_1.var_.oldValueTypewriter = arg_15_1.fswtw_.percent

				SetActive(arg_15_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_15_1:ShowNextGo(false)
			end

			local var_18_9 = 21
			local var_18_10 = 1.8
			local var_18_11, var_18_12 = arg_15_1:GetPercentByPara(arg_15_1:FormatText(arg_15_1:GetWordFromCfg(1101101004).content), 1)

			if var_18_8 < arg_15_1.time_ and arg_15_1.time_ <= var_18_8 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0

				local var_18_13 = var_18_9 <= 0 and var_18_10 or var_18_10 * ((var_18_12 - arg_15_1.typewritterCharCountI18N) / var_18_9)

				if (var_18_9 <= 0 and var_18_10 or var_18_10 * ((var_18_12 - arg_15_1.typewritterCharCountI18N) / var_18_9)) > 0 and var_18_10 < var_18_13 then
					arg_15_1.talkMaxDuration = var_18_13

					if var_18_13 + var_18_8 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_13 + var_18_8
					end
				end
			end

			local var_18_14 = math.max(1.8, arg_15_1.talkMaxDuration)

			if var_18_8 <= arg_15_1.time_ and arg_15_1.time_ < var_18_8 + var_18_14 then
				arg_15_1.fswtw_.percent = Mathf.Lerp(arg_15_1.var_.oldValueTypewriter, var_18_11, (arg_15_1.time_ - var_18_8) / var_18_14)
				arg_15_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_15_1.fswtw_:SetDirty()
			end

			if arg_15_1.time_ >= var_18_8 + var_18_14 and arg_15_1.time_ < var_18_8 + var_18_14 + arg_18_0 then
				arg_15_1.fswtw_.percent = var_18_11

				arg_15_1.fswtw_:SetDirty()
				arg_15_1:ShowNextGo(true)

				arg_15_1.typewritterCharCountI18N = var_18_12
			end

			local var_18_15 = 0

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_15 + arg_18_0 then
				arg_15_1.mask_.enabled = true
				arg_15_1.mask_.raycastTarget = true

				arg_15_1:SetGaussion(false)
			end

			local var_18_16 = 2

			if var_18_15 <= arg_15_1.time_ and arg_15_1.time_ < var_18_15 + var_18_16 then
				local var_18_17 = Color.New(0, 0, 0)

				var_18_17.a = Mathf.Lerp(0, 1, (arg_15_1.time_ - var_18_15) / var_18_16)
				arg_15_1.mask_.color = var_18_17
			end

			if arg_15_1.time_ >= var_18_15 + var_18_16 and arg_15_1.time_ < var_18_15 + var_18_16 + arg_18_0 then
				local var_18_18 = Color.New(0, 0, 0)

				var_18_18.a = 1
				arg_15_1.mask_.color = var_18_18
			end

			local var_18_19 = 2

			if 2 < arg_15_1.time_ and arg_15_1.time_ <= var_18_19 + arg_18_0 then
				arg_15_1.mask_.enabled = true
				arg_15_1.mask_.raycastTarget = true

				arg_15_1:SetGaussion(false)
			end

			local var_18_20 = 2

			if var_18_19 <= arg_15_1.time_ and arg_15_1.time_ < var_18_19 + var_18_20 then
				local var_18_21 = Color.New(0, 0, 0)

				var_18_21.a = Mathf.Lerp(1, 0, (arg_15_1.time_ - var_18_19) / var_18_20)
				arg_15_1.mask_.color = var_18_21
			end

			if arg_15_1.time_ >= var_18_19 + var_18_20 and arg_15_1.time_ < var_18_19 + var_18_20 + arg_18_0 then
				local var_18_22 = Color.New(0, 0, 0)

				arg_15_1.mask_.enabled = false
				var_18_22.a = 0
				arg_15_1.mask_.color = var_18_22
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3016_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play1101101005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 1101101005
		arg_19_1.duration_ = 9

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play1101101006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if arg_19_1.bgs_.A01a == nil then
				local var_22_0 = Object.Instantiate(arg_19_1.paintGo_)

				var_22_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A01a")
				var_22_0.name = "A01a"
				var_22_0.transform.parent = arg_19_1.stage_.transform
				var_22_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.bgs_.A01a = var_22_0
			end

			if 2 < arg_19_1.time_ and arg_19_1.time_ <= 2 + arg_22_0 then
				local var_22_1 = arg_19_1.bgs_.A01a

				arg_19_1.bgs_.A01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_22_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_22_2 = var_22_1:GetComponent("SpriteRenderer")

				if var_22_2 and var_22_2.sprite then
					local var_22_3 = 2 * (var_22_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_22_1.transform.localScale = Vector3.New(var_22_3 / var_22_2.sprite.bounds.size.y < var_22_3 * manager.ui.mainCameraCom_.aspect / var_22_2.sprite.bounds.size.x and var_22_3 * manager.ui.mainCameraCom_.aspect / var_22_2.sprite.bounds.size.x or var_22_3 / var_22_2.sprite.bounds.size.y, var_22_3 / var_22_2.sprite.bounds.size.y < var_22_3 * manager.ui.mainCameraCom_.aspect / var_22_2.sprite.bounds.size.x and var_22_3 * manager.ui.mainCameraCom_.aspect / var_22_2.sprite.bounds.size.x or var_22_3 / var_22_2.sprite.bounds.size.y, 0)
				end

				for iter_22_0, iter_22_1 in pairs(arg_19_1.bgs_) do
					if iter_22_0 ~= "A01a" then
						iter_22_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_22_4 = 0

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_4 + arg_22_0 then
				arg_19_1.mask_.enabled = true
				arg_19_1.mask_.raycastTarget = true

				arg_19_1:SetGaussion(false)
			end

			local var_22_5 = 2

			if var_22_4 <= arg_19_1.time_ and arg_19_1.time_ < var_22_4 + var_22_5 then
				local var_22_6 = Color.New(0, 0, 0)

				var_22_6.a = Mathf.Lerp(0, 1, (arg_19_1.time_ - var_22_4) / var_22_5)
				arg_19_1.mask_.color = var_22_6
			end

			if arg_19_1.time_ >= var_22_4 + var_22_5 and arg_19_1.time_ < var_22_4 + var_22_5 + arg_22_0 then
				local var_22_7 = Color.New(0, 0, 0)

				var_22_7.a = 1
				arg_19_1.mask_.color = var_22_7
			end

			local var_22_8 = 2

			if 2 < arg_19_1.time_ and arg_19_1.time_ <= var_22_8 + arg_22_0 then
				arg_19_1.mask_.enabled = true
				arg_19_1.mask_.raycastTarget = true

				arg_19_1:SetGaussion(false)
			end

			local var_22_9 = 2

			if var_22_8 <= arg_19_1.time_ and arg_19_1.time_ < var_22_8 + var_22_9 then
				local var_22_10 = Color.New(0, 0, 0)

				var_22_10.a = Mathf.Lerp(1, 0, (arg_19_1.time_ - var_22_8) / var_22_9)
				arg_19_1.mask_.color = var_22_10
			end

			if arg_19_1.time_ >= var_22_8 + var_22_9 and arg_19_1.time_ < var_22_8 + var_22_9 + arg_22_0 then
				local var_22_11 = Color.New(0, 0, 0)

				arg_19_1.mask_.enabled = false
				var_22_11.a = 0
				arg_19_1.mask_.color = var_22_11
			end

			if 2 < arg_19_1.time_ and arg_19_1.time_ <= 2 + arg_22_0 then
				arg_19_1.fswbg_:SetActive(false)
				arg_19_1.dialog_:SetActive(false)
				SetActive(arg_19_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_19_1:ShowNextGo(false)
			end

			if arg_19_1.frameCnt_ <= 1 then
				arg_19_1.dialog_:SetActive(false)
			end

			local var_22_12 = 4
			local var_22_13 = 0.075

			if 4 < arg_19_1.time_ and arg_19_1.time_ <= var_22_12 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0

				arg_19_1.dialog_:SetActive(true)

				arg_19_1.dialogCg_.alpha = 0

				local var_22_14 = LeanTween.value(arg_19_1.dialog_, 0, 1, 0.3)

				var_22_14:setOnUpdate(LuaHelper.FloatAction(function(arg_23_0)
					arg_19_1.dialogCg_.alpha = arg_23_0
				end))
				var_22_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_19_1.dialog_)
					var_22_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_19_1.duration_ = arg_19_1.duration_ + 0.3

				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, true)
				arg_19_1.iconController_:SetSelectedState("hero")

				arg_19_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_19_1.callingController_:SetSelectedState("normal")

				arg_19_1.keyicon_.color = Color.New(1, 1, 1)
				arg_19_1.icon_.color = Color.New(1, 1, 1)

				local var_22_15 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(1101101005).content)

				arg_19_1.text_.text = var_22_15

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_17 = 3 <= 0 and var_22_13 or var_22_13 * (utf8.len(var_22_15) / 3)

				if (3 <= 0 and var_22_13 or var_22_13 * (utf8.len(var_22_15) / 3)) > 0 and var_22_13 < var_22_17 then
					arg_19_1.talkMaxDuration = var_22_17
					var_22_12 = var_22_12 + 0.3

					if var_22_17 + var_22_12 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_17 + var_22_12
					end
				end

				arg_19_1.text_.text = var_22_15
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_18 = var_22_12 + 0.3
			local var_22_19 = math.max(var_22_13, arg_19_1.talkMaxDuration)

			if var_22_12 + 0.3 <= arg_19_1.time_ and arg_19_1.time_ < var_22_18 + var_22_19 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_18) / var_22_19

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_18 + var_22_19 and arg_19_1.time_ < var_22_18 + var_22_19 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play1101101006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1101101006
		arg_25_1.duration_ = 4.67

		local var_25_0 = {
			zh = 2.433,
			ja = 4.666
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
				arg_25_0:Play1101101007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.225

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:GetWordFromCfg(1101101006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 9 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 9)

				if (9 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 9)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101006", "story_v_side_new_1101101.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101006", "story_v_side_new_1101101.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_side_new_1101101", "1101101006", "story_v_side_new_1101101.awb")

						arg_25_1:RecordAudio("1101101006", var_28_6)
						arg_25_1:RecordAudio("1101101006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101006", "story_v_side_new_1101101.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101006", "story_v_side_new_1101101.awb")
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
	Play1101101007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1101101007
		arg_29_1.duration_ = 11.93

		local var_29_0 = {
			zh = 7.766,
			ja = 11.933
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
				arg_29_0:Play1101101008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 1.25

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[14].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6064")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:GetWordFromCfg(1101101007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 50 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 50)

				if (50 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 50)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101007", "story_v_side_new_1101101.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101007", "story_v_side_new_1101101.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_side_new_1101101", "1101101007", "story_v_side_new_1101101.awb")

						arg_29_1:RecordAudio("1101101007", var_32_6)
						arg_29_1:RecordAudio("1101101007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101007", "story_v_side_new_1101101.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101007", "story_v_side_new_1101101.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_7 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_7

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1101101008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1101101008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1101101009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.075

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(1101101008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 3 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 3)

				if (3 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 3)) > 0 and var_36_0 < var_36_3 then
					arg_33_1.talkMaxDuration = var_36_3

					if var_36_3 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_3 + 0
					end
				end

				arg_33_1.text_.text = var_36_1
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_4 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_4

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1101101009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1101101009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1101101010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 1.15

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(1101101009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 46 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 46)

				if (46 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 46)) > 0 and var_40_0 < var_40_3 then
					arg_37_1.talkMaxDuration = var_40_3

					if var_40_3 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_3 + 0
					end
				end

				arg_37_1.text_.text = var_40_1
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_4 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_4

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1101101010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1101101010
		arg_41_1.duration_ = 2.87

		local var_41_0 = {
			zh = 2.2,
			ja = 2.866
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
				arg_41_0:Play1101101011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0
			local var_44_1 = 0.225

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_2 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_2:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_3 = arg_41_1:GetWordFromCfg(1101101010)
				local var_44_4 = arg_41_1:FormatText(var_44_3.content)

				arg_41_1.text_.text = var_44_4

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_6 = 9 <= 0 and var_44_1 or var_44_1 * (utf8.len(var_44_4) / 9)

				if (9 <= 0 and var_44_1 or var_44_1 * (utf8.len(var_44_4) / 9)) > 0 and var_44_1 < var_44_6 then
					arg_41_1.talkMaxDuration = var_44_6
					var_44_0 = var_44_0 + 0.3

					if var_44_6 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_4
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101010", "story_v_side_new_1101101.awb") ~= 0 then
					local var_44_7 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101010", "story_v_side_new_1101101.awb") / 1000

					if var_44_7 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_0
					end

					if var_44_3.prefab_name ~= "" and arg_41_1.actors_[var_44_3.prefab_name] ~= nil then
						local var_44_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_3.prefab_name].transform, "story_v_side_new_1101101", "1101101010", "story_v_side_new_1101101.awb")

						arg_41_1:RecordAudio("1101101010", var_44_8)
						arg_41_1:RecordAudio("1101101010", var_44_8)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101010", "story_v_side_new_1101101.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101010", "story_v_side_new_1101101.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_9 = var_44_0 + 0.3
			local var_44_10 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 + 0.3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_9) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_9 + var_44_10 and arg_41_1.time_ < var_44_9 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1101101011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 1101101011
		arg_47_1.duration_ = 9

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play1101101012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if arg_47_1.bgs_.S0101 == nil then
				local var_50_0 = Object.Instantiate(arg_47_1.paintGo_)

				var_50_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0101")
				var_50_0.name = "S0101"
				var_50_0.transform.parent = arg_47_1.stage_.transform
				var_50_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.bgs_.S0101 = var_50_0
			end

			if 2 < arg_47_1.time_ and arg_47_1.time_ <= 2 + arg_50_0 then
				local var_50_1 = arg_47_1.bgs_.S0101

				arg_47_1.bgs_.S0101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_50_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_50_2 = var_50_1:GetComponent("SpriteRenderer")

				if var_50_2 and var_50_2.sprite then
					local var_50_3 = 2 * (var_50_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_50_1.transform.localScale = Vector3.New(var_50_3 / var_50_2.sprite.bounds.size.y < var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x and var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x or var_50_3 / var_50_2.sprite.bounds.size.y, var_50_3 / var_50_2.sprite.bounds.size.y < var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x and var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x or var_50_3 / var_50_2.sprite.bounds.size.y, 0)
				end

				for iter_50_0, iter_50_1 in pairs(arg_47_1.bgs_) do
					if iter_50_0 ~= "S0101" then
						iter_50_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_50_4 = 0

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_5 = 2

			if var_50_4 <= arg_47_1.time_ and arg_47_1.time_ < var_50_4 + var_50_5 then
				local var_50_6 = Color.New(0, 0, 0)

				var_50_6.a = Mathf.Lerp(0, 1, (arg_47_1.time_ - var_50_4) / var_50_5)
				arg_47_1.mask_.color = var_50_6
			end

			if arg_47_1.time_ >= var_50_4 + var_50_5 and arg_47_1.time_ < var_50_4 + var_50_5 + arg_50_0 then
				local var_50_7 = Color.New(0, 0, 0)

				var_50_7.a = 1
				arg_47_1.mask_.color = var_50_7
			end

			local var_50_8 = 2

			if 2 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_9 = 2

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_9 then
				local var_50_10 = Color.New(0, 0, 0)

				var_50_10.a = Mathf.Lerp(1, 0, (arg_47_1.time_ - var_50_8) / var_50_9)
				arg_47_1.mask_.color = var_50_10
			end

			if arg_47_1.time_ >= var_50_8 + var_50_9 and arg_47_1.time_ < var_50_8 + var_50_9 + arg_50_0 then
				local var_50_11 = Color.New(0, 0, 0)

				arg_47_1.mask_.enabled = false
				var_50_11.a = 0
				arg_47_1.mask_.color = var_50_11
			end

			local var_50_12 = arg_47_1.bgs_.S0101.transform

			if 2 < arg_47_1.time_ and arg_47_1.time_ <= 2 + arg_50_0 then
				arg_47_1.var_.moveOldPosS0101 = var_50_12.localPosition
			end

			local var_50_13 = 0.001

			if 2 <= arg_47_1.time_ and arg_47_1.time_ < 2 + var_50_13 then
				var_50_12.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPosS0101, Vector3.New(0, 1, 10.3), (arg_47_1.time_ - 2) / var_50_13)
			end

			if arg_47_1.time_ >= 2 + var_50_13 and arg_47_1.time_ < 2 + var_50_13 + arg_50_0 then
				var_50_12.localPosition = Vector3.New(0, 1, 10.3)
			end

			local var_50_14 = arg_47_1.bgs_.S0101.transform

			if 2.034 < arg_47_1.time_ and arg_47_1.time_ <= 2.034 + arg_50_0 then
				arg_47_1.var_.moveOldPosS0101 = var_50_14.localPosition
			end

			local var_50_15 = 2.716

			if 2.034 <= arg_47_1.time_ and arg_47_1.time_ < 2.034 + var_50_15 then
				var_50_14.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPosS0101, Vector3.New(0, 1, 10), (arg_47_1.time_ - 2.034) / var_50_15)
			end

			if arg_47_1.time_ >= 2.034 + var_50_15 and arg_47_1.time_ < 2.034 + var_50_15 + arg_50_0 then
				var_50_14.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_47_1.frameCnt_ <= 1 then
				arg_47_1.dialog_:SetActive(false)
			end

			local var_50_16 = 4
			local var_50_17 = 0.75

			if 4 < arg_47_1.time_ and arg_47_1.time_ <= var_50_16 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_18 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_18:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_19 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(1101101011).content)

				arg_47_1.text_.text = var_50_19

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_21 = 30 <= 0 and var_50_17 or var_50_17 * (utf8.len(var_50_19) / 30)

				if (30 <= 0 and var_50_17 or var_50_17 * (utf8.len(var_50_19) / 30)) > 0 and var_50_17 < var_50_21 then
					arg_47_1.talkMaxDuration = var_50_21
					var_50_16 = var_50_16 + 0.3

					if var_50_21 + var_50_16 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_21 + var_50_16
					end
				end

				arg_47_1.text_.text = var_50_19
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_22 = var_50_16 + 0.3
			local var_50_23 = math.max(var_50_17, arg_47_1.talkMaxDuration)

			if var_50_16 + 0.3 <= arg_47_1.time_ and arg_47_1.time_ < var_50_22 + var_50_23 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_22) / var_50_23

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_22 + var_50_23 and arg_47_1.time_ < var_50_22 + var_50_23 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "S0101",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.716,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play1101101012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1101101012
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1101101013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.6

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(1101101012).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 24 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 24)

				if (24 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 24)) > 0 and var_56_0 < var_56_3 then
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
	Play1101101013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1101101013
		arg_57_1.duration_ = 1

		SetActive(arg_57_1.tipsGo_, true)

		arg_57_1.tipsText_.text = StoryTipsCfg[101101].name

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"

			SetActive(arg_57_1.choicesGo_, true)

			for iter_58_0, iter_58_1 in ipairs(arg_57_1.choices_) do
				SetActive(iter_58_1.go, iter_58_0 <= 2)
			end

			arg_57_1.choices_[1].txt.text = arg_57_1:FormatText(StoryChoiceCfg[602].name)
			arg_57_1.choices_[2].txt.text = arg_57_1:FormatText(StoryChoiceCfg[603].name)
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				PlayerAction.UseStoryTrigger(1011011, 210110101, 1101101013, 1)
				arg_57_0:Play1101101014(arg_57_1)
			end

			if arg_59_0 == 2 then
				PlayerAction.UseStoryTrigger(1011011, 210110101, 1101101013, 2)
				arg_57_0:Play1101101015(arg_57_1)
			end

			arg_57_1:RecordChoiceLog(1101101013, 602, 603)
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			if arg_57_1.time_ >= 0 + 0.5 and arg_57_1.time_ < 0 + 0.5 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1101101014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1101101014
		arg_61_1.duration_ = 5.73

		local var_61_0 = {
			zh = 5.533,
			ja = 5.733
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
				arg_61_0:Play1101101016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0.575

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:GetWordFromCfg(1101101014)
				local var_64_2 = arg_61_1:FormatText(var_64_1.content)

				arg_61_1.text_.text = var_64_2

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 23 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 23)

				if (23 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_2) / 23)) > 0 and var_64_0 < var_64_4 then
					arg_61_1.talkMaxDuration = var_64_4

					if var_64_4 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_4 + 0
					end
				end

				arg_61_1.text_.text = var_64_2
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101014", "story_v_side_new_1101101.awb") ~= 0 then
					local var_64_5 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101014", "story_v_side_new_1101101.awb") / 1000

					if var_64_5 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_5 + 0
					end

					if var_64_1.prefab_name ~= "" and arg_61_1.actors_[var_64_1.prefab_name] ~= nil then
						local var_64_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_1.prefab_name].transform, "story_v_side_new_1101101", "1101101014", "story_v_side_new_1101101.awb")

						arg_61_1:RecordAudio("1101101014", var_64_6)
						arg_61_1:RecordAudio("1101101014", var_64_6)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101014", "story_v_side_new_1101101.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101014", "story_v_side_new_1101101.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1101101016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1101101016
		arg_65_1.duration_ = 7.23

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1101101017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 2 < arg_65_1.time_ and arg_65_1.time_ <= 2 + arg_68_0 then
				local var_68_0 = arg_65_1.bgs_.STblack

				arg_65_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_68_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_68_1 = var_68_0:GetComponent("SpriteRenderer")

				if var_68_1 and var_68_1.sprite then
					local var_68_2 = 2 * (var_68_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_68_0.transform.localScale = Vector3.New(var_68_2 / var_68_1.sprite.bounds.size.y < var_68_2 * manager.ui.mainCameraCom_.aspect / var_68_1.sprite.bounds.size.x and var_68_2 * manager.ui.mainCameraCom_.aspect / var_68_1.sprite.bounds.size.x or var_68_2 / var_68_1.sprite.bounds.size.y, var_68_2 / var_68_1.sprite.bounds.size.y < var_68_2 * manager.ui.mainCameraCom_.aspect / var_68_1.sprite.bounds.size.x and var_68_2 * manager.ui.mainCameraCom_.aspect / var_68_1.sprite.bounds.size.x or var_68_2 / var_68_1.sprite.bounds.size.y, 0)
				end

				for iter_68_0, iter_68_1 in pairs(arg_65_1.bgs_) do
					if iter_68_0 ~= "STblack" then
						iter_68_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_68_3 = 0

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_3 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_4 = 2

			if var_68_3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_3 + var_68_4 then
				local var_68_5 = Color.New(0, 0, 0)

				var_68_5.a = Mathf.Lerp(0, 1, (arg_65_1.time_ - var_68_3) / var_68_4)
				arg_65_1.mask_.color = var_68_5
			end

			if arg_65_1.time_ >= var_68_3 + var_68_4 and arg_65_1.time_ < var_68_3 + var_68_4 + arg_68_0 then
				local var_68_6 = Color.New(0, 0, 0)

				var_68_6.a = 1
				arg_65_1.mask_.color = var_68_6
			end

			local var_68_7 = 2

			if 2 < arg_65_1.time_ and arg_65_1.time_ <= var_68_7 + arg_68_0 then
				arg_65_1.mask_.enabled = true
				arg_65_1.mask_.raycastTarget = true

				arg_65_1:SetGaussion(false)
			end

			local var_68_8 = 0.233333333333333

			if var_68_7 <= arg_65_1.time_ and arg_65_1.time_ < var_68_7 + var_68_8 then
				local var_68_9 = Color.New(0, 0, 0)

				var_68_9.a = Mathf.Lerp(1, 0, (arg_65_1.time_ - var_68_7) / var_68_8)
				arg_65_1.mask_.color = var_68_9
			end

			if arg_65_1.time_ >= var_68_7 + var_68_8 and arg_65_1.time_ < var_68_7 + var_68_8 + arg_68_0 then
				local var_68_10 = Color.New(0, 0, 0)

				arg_65_1.mask_.enabled = false
				var_68_10.a = 0
				arg_65_1.mask_.color = var_68_10
			end

			if arg_65_1.frameCnt_ <= 1 then
				arg_65_1.dialog_:SetActive(false)
			end

			local var_68_11 = 2.23333333333333
			local var_68_12 = 0.775

			if 2.23333333333333 < arg_65_1.time_ and arg_65_1.time_ <= var_68_11 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0

				arg_65_1.dialog_:SetActive(true)

				arg_65_1.dialogCg_.alpha = 0

				local var_68_13 = LeanTween.value(arg_65_1.dialog_, 0, 1, 0.3)

				var_68_13:setOnUpdate(LuaHelper.FloatAction(function(arg_69_0)
					arg_65_1.dialogCg_.alpha = arg_69_0
				end))
				var_68_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_65_1.dialog_)
					var_68_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_65_1.duration_ = arg_65_1.duration_ + 0.3

				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_14 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(1101101016).content)

				arg_65_1.text_.text = var_68_14

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_16 = 31 <= 0 and var_68_12 or var_68_12 * (utf8.len(var_68_14) / 31)

				if (31 <= 0 and var_68_12 or var_68_12 * (utf8.len(var_68_14) / 31)) > 0 and var_68_12 < var_68_16 then
					arg_65_1.talkMaxDuration = var_68_16
					var_68_11 = var_68_11 + 0.3

					if var_68_16 + var_68_11 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_16 + var_68_11
					end
				end

				arg_65_1.text_.text = var_68_14
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_17 = var_68_11 + 0.3
			local var_68_18 = math.max(var_68_12, arg_65_1.talkMaxDuration)

			if var_68_11 + 0.3 <= arg_65_1.time_ and arg_65_1.time_ < var_68_17 + var_68_18 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_17) / var_68_18

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_17 + var_68_18 and arg_65_1.time_ < var_68_17 + var_68_18 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play1101101017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 1101101017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play1101101018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:AudioAction("play", "effect", "se_story_side_1011", "se_story_side_1011_spray", "")
			end

			local var_74_1 = 0
			local var_74_2 = 0.725

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(1101101017).content)

				arg_71_1.text_.text = var_74_3

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 29 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 29)

				if (29 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 29)) > 0 and var_74_2 < var_74_5 then
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
	Play1101101018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 1101101018
		arg_75_1.duration_ = 5.97

		local var_75_0 = {
			zh = 4.966,
			ja = 5.966
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
				arg_75_0:Play1101101019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if arg_75_1.bgs_.A00 == nil then
				local var_78_0 = Object.Instantiate(arg_75_1.paintGo_)

				var_78_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A00")
				var_78_0.name = "A00"
				var_78_0.transform.parent = arg_75_1.stage_.transform
				var_78_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.bgs_.A00 = var_78_0
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				local var_78_1 = arg_75_1.bgs_.A00

				arg_75_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_78_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_78_2 = var_78_1:GetComponent("SpriteRenderer")

				if var_78_2 and var_78_2.sprite then
					local var_78_3 = 2 * (var_78_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_78_1.transform.localScale = Vector3.New(var_78_3 / var_78_2.sprite.bounds.size.y < var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x and var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x or var_78_3 / var_78_2.sprite.bounds.size.y, var_78_3 / var_78_2.sprite.bounds.size.y < var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x and var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x or var_78_3 / var_78_2.sprite.bounds.size.y, 0)
				end

				for iter_78_0, iter_78_1 in pairs(arg_75_1.bgs_) do
					if iter_78_0 ~= "A00" then
						iter_78_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_78_4 = 0

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_4 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_5 = 2

			if var_78_4 <= arg_75_1.time_ and arg_75_1.time_ < var_78_4 + var_78_5 then
				local var_78_6 = Color.New(0, 0, 0)

				var_78_6.a = Mathf.Lerp(1, 0, (arg_75_1.time_ - var_78_4) / var_78_5)
				arg_75_1.mask_.color = var_78_6
			end

			if arg_75_1.time_ >= var_78_4 + var_78_5 and arg_75_1.time_ < var_78_4 + var_78_5 + arg_78_0 then
				local var_78_7 = Color.New(0, 0, 0)

				arg_75_1.mask_.enabled = false
				var_78_7.a = 0
				arg_75_1.mask_.color = var_78_7
			end

			local var_78_8 = "1011ui_story"

			if arg_75_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_78_9 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_75_1.stage_.transform)

				var_78_9.name = var_78_8
				var_78_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.actors_[var_78_8] = var_78_9

				local var_78_10 = var_78_9:GetComponentInChildren(typeof(CharacterEffect))

				var_78_10.enabled = true

				local var_78_11 = GameObjectTools.GetOrAddComponent(var_78_9, typeof(DynamicBoneHelper))

				if var_78_11 then
					var_78_11:EnableDynamicBone(false)
				end

				arg_75_1:ShowWeapon(var_78_10.transform, false)

				arg_75_1.var_[var_78_8 .. "Animator"] = var_78_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_75_1.var_[var_78_8 .. "Animator"].applyRootMotion = true
				arg_75_1.var_[var_78_8 .. "LipSync"] = var_78_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_78_12 = arg_75_1.actors_["1011ui_story"].transform

			if 2 < arg_75_1.time_ and arg_75_1.time_ <= 2 + arg_78_0 then
				arg_75_1.var_.moveOldPos1011ui_story = var_78_12.localPosition
			end

			local var_78_13 = 0.001

			if 2 <= arg_75_1.time_ and arg_75_1.time_ < 2 + var_78_13 then
				var_78_12.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_75_1.time_ - 2) / var_78_13)
				var_78_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_12.position).x, (manager.ui.mainCamera.transform.position - var_78_12.position).y, (manager.ui.mainCamera.transform.position - var_78_12.position).z)
				var_78_12.localEulerAngles.z = 0
				var_78_12.localEulerAngles.x = 0
				var_78_12.localEulerAngles = var_78_12.localEulerAngles
			end

			if arg_75_1.time_ >= 2 + var_78_13 and arg_75_1.time_ < 2 + var_78_13 + arg_78_0 then
				var_78_12.localPosition = Vector3.New(0, -0.71, -6)
				var_78_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_12.position).x, (manager.ui.mainCamera.transform.position - var_78_12.position).y, (manager.ui.mainCamera.transform.position - var_78_12.position).z)
				var_78_12.localEulerAngles.z = 0
				var_78_12.localEulerAngles.x = 0
				var_78_12.localEulerAngles = var_78_12.localEulerAngles
			end

			local var_78_14 = arg_75_1.actors_["1011ui_story"]

			if 2 < arg_75_1.time_ and arg_75_1.time_ <= 2 + arg_78_0 and not isNil(var_78_14) and arg_75_1.var_.characterEffect1011ui_story == nil then
				arg_75_1.var_.characterEffect1011ui_story = var_78_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_15 = 0.200000002980232

			if 2 <= arg_75_1.time_ and arg_75_1.time_ < 2 + var_78_15 and not isNil(var_78_14) then
				if arg_75_1.var_.characterEffect1011ui_story and not isNil(var_78_14) then
					arg_75_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 2 + var_78_15 and arg_75_1.time_ < 2 + var_78_15 + arg_78_0 and not isNil(var_78_14) and arg_75_1.var_.characterEffect1011ui_story then
				arg_75_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 2 < arg_75_1.time_ and arg_75_1.time_ <= 2 + arg_78_0 then
				arg_75_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 2 < arg_75_1.time_ and arg_75_1.time_ <= 2 + arg_78_0 then
				arg_75_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			if arg_75_1.frameCnt_ <= 1 then
				arg_75_1.dialog_:SetActive(false)
			end

			local var_78_17 = 2
			local var_78_18 = 0.375

			if 2 < arg_75_1.time_ and arg_75_1.time_ <= var_78_17 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				arg_75_1.dialog_:SetActive(true)

				arg_75_1.dialogCg_.alpha = 0

				local var_78_19 = LeanTween.value(arg_75_1.dialog_, 0, 1, 0.3)

				var_78_19:setOnUpdate(LuaHelper.FloatAction(function(arg_79_0)
					arg_75_1.dialogCg_.alpha = arg_79_0
				end))
				var_78_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_75_1.dialog_)
					var_78_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_75_1.duration_ = arg_75_1.duration_ + 0.3

				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_20 = arg_75_1:GetWordFromCfg(1101101018)
				local var_78_21 = arg_75_1:FormatText(var_78_20.content)

				arg_75_1.text_.text = var_78_21

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_23 = 15 <= 0 and var_78_18 or var_78_18 * (utf8.len(var_78_21) / 15)

				if (15 <= 0 and var_78_18 or var_78_18 * (utf8.len(var_78_21) / 15)) > 0 and var_78_18 < var_78_23 then
					arg_75_1.talkMaxDuration = var_78_23
					var_78_17 = var_78_17 + 0.3

					if var_78_23 + var_78_17 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_23 + var_78_17
					end
				end

				arg_75_1.text_.text = var_78_21
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101018", "story_v_side_new_1101101.awb") ~= 0 then
					local var_78_24 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101018", "story_v_side_new_1101101.awb") / 1000

					if var_78_24 + var_78_17 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_24 + var_78_17
					end

					if var_78_20.prefab_name ~= "" and arg_75_1.actors_[var_78_20.prefab_name] ~= nil then
						local var_78_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_20.prefab_name].transform, "story_v_side_new_1101101", "1101101018", "story_v_side_new_1101101.awb")

						arg_75_1:RecordAudio("1101101018", var_78_25)
						arg_75_1:RecordAudio("1101101018", var_78_25)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101018", "story_v_side_new_1101101.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101018", "story_v_side_new_1101101.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_26 = var_78_17 + 0.3
			local var_78_27 = math.max(var_78_18, arg_75_1.talkMaxDuration)

			if var_78_17 + 0.3 <= arg_75_1.time_ and arg_75_1.time_ < var_78_26 + var_78_27 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_26) / var_78_27

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_26 + var_78_27 and arg_75_1.time_ < var_78_26 + var_78_27 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play1101101019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1101101019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1101101020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1011ui_story"]) and arg_81_1.var_.characterEffect1011ui_story == nil then
				arg_81_1.var_.characterEffect1011ui_story = arg_81_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1011ui_story"]) then
				if arg_81_1.var_.characterEffect1011ui_story and not isNil(arg_81_1.actors_["1011ui_story"]) then
					arg_81_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1011ui_story"]) and arg_81_1.var_.characterEffect1011ui_story then
				arg_81_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_84_1 = 0
			local var_84_2 = 0.625

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(1101101019).content)

				arg_81_1.text_.text = var_84_3

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 25 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 25)

				if (25 <= 0 and var_84_2 or var_84_2 * (utf8.len(var_84_3) / 25)) > 0 and var_84_2 < var_84_5 then
					arg_81_1.talkMaxDuration = var_84_5

					if var_84_5 + var_84_1 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_5 + var_84_1
					end
				end

				arg_81_1.text_.text = var_84_3
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_6 = math.max(var_84_2, arg_81_1.talkMaxDuration)

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_6 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_1) / var_84_6

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_1 + var_84_6 and arg_81_1.time_ < var_84_1 + var_84_6 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1101101020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1101101020
		arg_85_1.duration_ = 7.53

		local var_85_0 = {
			zh = 3.8,
			ja = 7.533
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
				arg_85_0:Play1101101021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1011ui_story = arg_85_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1011ui_story"].transform.position).z)
				arg_85_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1011ui_story"].transform.localEulerAngles = arg_85_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_85_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["1011ui_story"].transform.position).z)
				arg_85_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["1011ui_story"].transform.localEulerAngles = arg_85_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["1011ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1011ui_story == nil then
				arg_85_1.var_.characterEffect1011ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect1011ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect1011ui_story then
				arg_85_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_88_4 = 0
			local var_88_5 = 0.425

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(1101101020)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 17 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 17)

				if (17 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 17)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101020", "story_v_side_new_1101101.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101020", "story_v_side_new_1101101.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_side_new_1101101", "1101101020", "story_v_side_new_1101101.awb")

						arg_85_1:RecordAudio("1101101020", var_88_11)
						arg_85_1:RecordAudio("1101101020", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101020", "story_v_side_new_1101101.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101020", "story_v_side_new_1101101.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_12 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_12 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_12

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_12 and arg_85_1.time_ < var_88_4 + var_88_12 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
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

		arg_85_1:InitPlayNodeList()
	end,
	Play1101101021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1101101021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1101101022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1011ui_story"]) and arg_89_1.var_.characterEffect1011ui_story == nil then
				arg_89_1.var_.characterEffect1011ui_story = arg_89_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1011ui_story"]) then
				if arg_89_1.var_.characterEffect1011ui_story and not isNil(arg_89_1.actors_["1011ui_story"]) then
					arg_89_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1011ui_story"]) and arg_89_1.var_.characterEffect1011ui_story then
				arg_89_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_92_1 = 0
			local var_92_2 = 0.325

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(1101101021).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 13 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 13)

				if (13 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 13)) > 0 and var_92_2 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_6 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_6 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_6

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_6 and arg_89_1.time_ < var_92_1 + var_92_6 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play1101101022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1101101022
		arg_93_1.duration_ = 8.67

		local var_93_0 = {
			zh = 8.666,
			ja = 8.5
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
				arg_93_0:Play1101101023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1011ui_story = arg_93_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1011ui_story"].transform.position).z)
				arg_93_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1011ui_story"].transform.localEulerAngles = arg_93_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_93_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1011ui_story"].transform.position).z)
				arg_93_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1011ui_story"].transform.localEulerAngles = arg_93_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["1011ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1011ui_story == nil then
				arg_93_1.var_.characterEffect1011ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect1011ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1011ui_story then
				arg_93_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action424")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_96_4 = 0
			local var_96_5 = 1.125

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_6 = arg_93_1:GetWordFromCfg(1101101022)
				local var_96_7 = arg_93_1:FormatText(var_96_6.content)

				arg_93_1.text_.text = var_96_7

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_9 = 45 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 45)

				if (45 <= 0 and var_96_5 or var_96_5 * (utf8.len(var_96_7) / 45)) > 0 and var_96_5 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_4
					end
				end

				arg_93_1.text_.text = var_96_7
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101022", "story_v_side_new_1101101.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101022", "story_v_side_new_1101101.awb") / 1000

					if var_96_10 + var_96_4 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_4
					end

					if var_96_6.prefab_name ~= "" and arg_93_1.actors_[var_96_6.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_6.prefab_name].transform, "story_v_side_new_1101101", "1101101022", "story_v_side_new_1101101.awb")

						arg_93_1:RecordAudio("1101101022", var_96_11)
						arg_93_1:RecordAudio("1101101022", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101022", "story_v_side_new_1101101.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101022", "story_v_side_new_1101101.awb")
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

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play1101101023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1101101023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1101101024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1011ui_story"]) and arg_97_1.var_.characterEffect1011ui_story == nil then
				arg_97_1.var_.characterEffect1011ui_story = arg_97_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1011ui_story"]) then
				if arg_97_1.var_.characterEffect1011ui_story and not isNil(arg_97_1.actors_["1011ui_story"]) then
					arg_97_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1011ui_story"]) and arg_97_1.var_.characterEffect1011ui_story then
				arg_97_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_100_1 = 0
			local var_100_2 = 0.9

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(1101101023).content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 36 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 36)

				if (36 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_3) / 36)) > 0 and var_100_2 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_6 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_6 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_6

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_6 and arg_97_1.time_ < var_100_1 + var_100_6 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1101101024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1101101024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1101101025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.275

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(1101101024).content)

				arg_101_1.text_.text = var_104_1

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_3 = 11 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 11)

				if (11 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_1) / 11)) > 0 and var_104_0 < var_104_3 then
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
	Play1101101025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1101101025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1101101026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.675

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(1101101025).content)

				arg_105_1.text_.text = var_108_1

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_3 = 29 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 29)

				if (29 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_1) / 29)) > 0 and var_108_0 < var_108_3 then
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
	Play1101101026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1101101026
		arg_109_1.duration_ = 11.73

		local var_109_0 = {
			zh = 11,
			ja = 11.733
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
				arg_109_0:Play1101101027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1011ui_story = arg_109_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1011ui_story"].transform.position).z)
				arg_109_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1011ui_story"].transform.localEulerAngles = arg_109_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_109_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1011ui_story"].transform.position).z)
				arg_109_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1011ui_story"].transform.localEulerAngles = arg_109_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1011ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1011ui_story == nil then
				arg_109_1.var_.characterEffect1011ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1011ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1011ui_story then
				arg_109_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_2")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_4 = 0
			local var_112_5 = 1.15

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(1101101026)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 46 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 46)

				if (46 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 46)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101026", "story_v_side_new_1101101.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101026", "story_v_side_new_1101101.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_side_new_1101101", "1101101026", "story_v_side_new_1101101.awb")

						arg_109_1:RecordAudio("1101101026", var_112_11)
						arg_109_1:RecordAudio("1101101026", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101026", "story_v_side_new_1101101.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101026", "story_v_side_new_1101101.awb")
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

		arg_109_1.nodeConfigList_ = {
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

		arg_109_1:InitPlayNodeList()
	end,
	Play1101101027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1101101027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1101101028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1011ui_story"]) and arg_113_1.var_.characterEffect1011ui_story == nil then
				arg_113_1.var_.characterEffect1011ui_story = arg_113_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1011ui_story"]) then
				if arg_113_1.var_.characterEffect1011ui_story and not isNil(arg_113_1.actors_["1011ui_story"]) then
					arg_113_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1011ui_story"]) and arg_113_1.var_.characterEffect1011ui_story then
				arg_113_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_116_1 = 0
			local var_116_2 = 0.625

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
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

				local var_116_3 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(1101101027).content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 25 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 25)

				if (25 <= 0 and var_116_2 or var_116_2 * (utf8.len(var_116_3) / 25)) > 0 and var_116_2 < var_116_5 then
					arg_113_1.talkMaxDuration = var_116_5

					if var_116_5 + var_116_1 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + var_116_1
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_6 = math.max(var_116_2, arg_113_1.talkMaxDuration)

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_6 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_1) / var_116_6

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_1 + var_116_6 and arg_113_1.time_ < var_116_1 + var_116_6 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play1101101028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1101101028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1101101029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.5

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_1 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(1101101028).content)

				arg_117_1.text_.text = var_120_1

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_3 = 20 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 20)

				if (20 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_1) / 20)) > 0 and var_120_0 < var_120_3 then
					arg_117_1.talkMaxDuration = var_120_3

					if var_120_3 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_3 + 0
					end
				end

				arg_117_1.text_.text = var_120_1
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_4 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_4

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play1101101029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1101101029
		arg_121_1.duration_ = 10.4

		local var_121_0 = {
			zh = 10.4,
			ja = 7
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
				arg_121_0:Play1101101030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1011ui_story = arg_121_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1011ui_story"].transform.position).z)
				arg_121_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1011ui_story"].transform.localEulerAngles = arg_121_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_121_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1011ui_story"].transform.position).z)
				arg_121_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1011ui_story"].transform.localEulerAngles = arg_121_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1011ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1011ui_story == nil then
				arg_121_1.var_.characterEffect1011ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1011ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1011ui_story then
				arg_121_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_124_4 = 0
			local var_124_5 = 1

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(1101101029)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 40 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 40)

				if (40 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 40)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101029", "story_v_side_new_1101101.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101029", "story_v_side_new_1101101.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_side_new_1101101", "1101101029", "story_v_side_new_1101101.awb")

						arg_121_1:RecordAudio("1101101029", var_124_11)
						arg_121_1:RecordAudio("1101101029", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101029", "story_v_side_new_1101101.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101029", "story_v_side_new_1101101.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
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

		arg_121_1:InitPlayNodeList()
	end,
	Play1101101030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1101101030
		arg_125_1.duration_ = 11.17

		local var_125_0 = {
			zh = 8.566,
			ja = 11.166
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
				arg_125_0:Play1101101031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_128_0 = 0
			local var_128_1 = 1.1

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_2 = arg_125_1:GetWordFromCfg(1101101030)
				local var_128_3 = arg_125_1:FormatText(var_128_2.content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 44 <= 0 and var_128_1 or var_128_1 * (utf8.len(var_128_3) / 44)

				if (44 <= 0 and var_128_1 or var_128_1 * (utf8.len(var_128_3) / 44)) > 0 and var_128_1 < var_128_5 then
					arg_125_1.talkMaxDuration = var_128_5

					if var_128_5 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101030", "story_v_side_new_1101101.awb") ~= 0 then
					local var_128_6 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101030", "story_v_side_new_1101101.awb") / 1000

					if var_128_6 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_6 + var_128_0
					end

					if var_128_2.prefab_name ~= "" and arg_125_1.actors_[var_128_2.prefab_name] ~= nil then
						local var_128_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_2.prefab_name].transform, "story_v_side_new_1101101", "1101101030", "story_v_side_new_1101101.awb")

						arg_125_1:RecordAudio("1101101030", var_128_7)
						arg_125_1:RecordAudio("1101101030", var_128_7)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101030", "story_v_side_new_1101101.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101030", "story_v_side_new_1101101.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_8 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_8 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_8

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_8 and arg_125_1.time_ < var_128_0 + var_128_8 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play1101101031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1101101031
		arg_129_1.duration_ = 6.3

		local var_129_0 = {
			zh = 6.3,
			ja = 4.133
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
				arg_129_0:Play1101101032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_132_0 = 0
			local var_132_1 = 0.7

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_2 = arg_129_1:GetWordFromCfg(1101101031)
				local var_132_3 = arg_129_1:FormatText(var_132_2.content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 28 <= 0 and var_132_1 or var_132_1 * (utf8.len(var_132_3) / 28)

				if (28 <= 0 and var_132_1 or var_132_1 * (utf8.len(var_132_3) / 28)) > 0 and var_132_1 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101031", "story_v_side_new_1101101.awb") ~= 0 then
					local var_132_6 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101031", "story_v_side_new_1101101.awb") / 1000

					if var_132_6 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_0
					end

					if var_132_2.prefab_name ~= "" and arg_129_1.actors_[var_132_2.prefab_name] ~= nil then
						local var_132_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_2.prefab_name].transform, "story_v_side_new_1101101", "1101101031", "story_v_side_new_1101101.awb")

						arg_129_1:RecordAudio("1101101031", var_132_7)
						arg_129_1:RecordAudio("1101101031", var_132_7)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101031", "story_v_side_new_1101101.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101031", "story_v_side_new_1101101.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_8 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_8 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_8

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_8 and arg_129_1.time_ < var_132_0 + var_132_8 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play1101101032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1101101032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1101101033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1011ui_story"]) and arg_133_1.var_.characterEffect1011ui_story == nil then
				arg_133_1.var_.characterEffect1011ui_story = arg_133_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1011ui_story"]) then
				if arg_133_1.var_.characterEffect1011ui_story and not isNil(arg_133_1.actors_["1011ui_story"]) then
					arg_133_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_0)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1011ui_story"]) and arg_133_1.var_.characterEffect1011ui_story then
				arg_133_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_136_1 = 0
			local var_136_2 = 0.525

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(1101101032).content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 21 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 21)

				if (21 <= 0 and var_136_2 or var_136_2 * (utf8.len(var_136_3) / 21)) > 0 and var_136_2 < var_136_5 then
					arg_133_1.talkMaxDuration = var_136_5

					if var_136_5 + var_136_1 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + var_136_1
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_6 = math.max(var_136_2, arg_133_1.talkMaxDuration)

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_6 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_1) / var_136_6

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_1 + var_136_6 and arg_133_1.time_ < var_136_1 + var_136_6 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play1101101033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 1101101033
		arg_137_1.duration_ = 1

		SetActive(arg_137_1.tipsGo_, true)

		arg_137_1.tipsText_.text = StoryTipsCfg[101101].name

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"

			SetActive(arg_137_1.choicesGo_, true)

			for iter_138_0, iter_138_1 in ipairs(arg_137_1.choices_) do
				SetActive(iter_138_1.go, iter_138_0 <= 2)
			end

			arg_137_1.choices_[1].txt.text = arg_137_1:FormatText(StoryChoiceCfg[604].name)
			arg_137_1.choices_[2].txt.text = arg_137_1:FormatText(StoryChoiceCfg[605].name)
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				PlayerAction.UseStoryTrigger(1011012, 210110101, 1101101033, 1)
				arg_137_0:Play1101101034(arg_137_1)
			end

			if arg_139_0 == 2 then
				PlayerAction.UseStoryTrigger(1011012, 210110101, 1101101033, 2)
				arg_137_0:Play1101101036(arg_137_1)
			end

			arg_137_1:RecordChoiceLog(1101101033, 604, 605)
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.allBtn_.enabled = false
			end

			if arg_137_1.time_ >= 0 + 0.5 and arg_137_1.time_ < 0 + 0.5 + arg_140_0 then
				arg_137_1.allBtn_.enabled = true
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play1101101034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 1101101034
		arg_141_1.duration_ = 2.83

		local var_141_0 = {
			zh = 1.999999999999,
			ja = 2.833
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
				arg_141_0:Play1101101035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1011ui_story = arg_141_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1011ui_story"].transform.position).z)
				arg_141_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1011ui_story"].transform.localEulerAngles = arg_141_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_141_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1011ui_story"].transform.position).z)
				arg_141_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1011ui_story"].transform.localEulerAngles = arg_141_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_144_1 = arg_141_1.actors_["1011ui_story"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1011ui_story == nil then
				arg_141_1.var_.characterEffect1011ui_story = var_144_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_2 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_2 and not isNil(var_144_1) then
				if arg_141_1.var_.characterEffect1011ui_story and not isNil(var_144_1) then
					arg_141_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= 0 + var_144_2 and arg_141_1.time_ < 0 + var_144_2 + arg_144_0 and not isNil(var_144_1) and arg_141_1.var_.characterEffect1011ui_story then
				arg_141_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_144_4 = 0
			local var_144_5 = 0.125

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_4 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_6 = arg_141_1:GetWordFromCfg(1101101034)
				local var_144_7 = arg_141_1:FormatText(var_144_6.content)

				arg_141_1.text_.text = var_144_7

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_9 = 5 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 5)

				if (5 <= 0 and var_144_5 or var_144_5 * (utf8.len(var_144_7) / 5)) > 0 and var_144_5 < var_144_9 then
					arg_141_1.talkMaxDuration = var_144_9

					if var_144_9 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_9 + var_144_4
					end
				end

				arg_141_1.text_.text = var_144_7
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101034", "story_v_side_new_1101101.awb") ~= 0 then
					local var_144_10 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101034", "story_v_side_new_1101101.awb") / 1000

					if var_144_10 + var_144_4 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_4
					end

					if var_144_6.prefab_name ~= "" and arg_141_1.actors_[var_144_6.prefab_name] ~= nil then
						local var_144_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_6.prefab_name].transform, "story_v_side_new_1101101", "1101101034", "story_v_side_new_1101101.awb")

						arg_141_1:RecordAudio("1101101034", var_144_11)
						arg_141_1:RecordAudio("1101101034", var_144_11)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101034", "story_v_side_new_1101101.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101034", "story_v_side_new_1101101.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_12 = math.max(var_144_5, arg_141_1.talkMaxDuration)

			if var_144_4 <= arg_141_1.time_ and arg_141_1.time_ < var_144_4 + var_144_12 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_4) / var_144_12

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_4 + var_144_12 and arg_141_1.time_ < var_144_4 + var_144_12 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
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

		arg_141_1:InitPlayNodeList()
	end,
	Play1101101035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 1101101035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play1101101038(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["1011ui_story"]) and arg_145_1.var_.characterEffect1011ui_story == nil then
				arg_145_1.var_.characterEffect1011ui_story = arg_145_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_0 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["1011ui_story"]) then
				if arg_145_1.var_.characterEffect1011ui_story and not isNil(arg_145_1.actors_["1011ui_story"]) then
					arg_145_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_0)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["1011ui_story"]) and arg_145_1.var_.characterEffect1011ui_story then
				arg_145_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_148_1 = 0
			local var_148_2 = 0.825

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(1101101035).content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 33 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 33)

				if (33 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 33)) > 0 and var_148_2 < var_148_5 then
					arg_145_1.talkMaxDuration = var_148_5

					if var_148_5 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + var_148_1
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_6 = math.max(var_148_2, arg_145_1.talkMaxDuration)

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_6 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_1) / var_148_6

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_1 + var_148_6 and arg_145_1.time_ < var_148_1 + var_148_6 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play1101101038 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 1101101038
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play1101101039(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.525

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

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(1101101038).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 21 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 21)

				if (21 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 21)) > 0 and var_152_0 < var_152_3 then
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
	Play1101101039 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 1101101039
		arg_153_1.duration_ = 2.53

		local var_153_0 = {
			zh = 1.999999999999,
			ja = 2.533
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
				arg_153_0:Play1101101040(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1011ui_story = arg_153_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).z)
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles = arg_153_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_153_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1011ui_story"].transform.position).z)
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1011ui_story"].transform.localEulerAngles = arg_153_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["1011ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1011ui_story == nil then
				arg_153_1.var_.characterEffect1011ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect1011ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1011ui_story then
				arg_153_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_2")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_156_4 = 0
			local var_156_5 = 0.125

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:GetWordFromCfg(1101101039)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 5 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 5)

				if (5 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 5)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101039", "story_v_side_new_1101101.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101039", "story_v_side_new_1101101.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_side_new_1101101", "1101101039", "story_v_side_new_1101101.awb")

						arg_153_1:RecordAudio("1101101039", var_156_11)
						arg_153_1:RecordAudio("1101101039", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101039", "story_v_side_new_1101101.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101039", "story_v_side_new_1101101.awb")
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
				actorName = "1011ui_story",
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
	Play1101101040 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 1101101040
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play1101101041(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["1011ui_story"]) and arg_157_1.var_.characterEffect1011ui_story == nil then
				arg_157_1.var_.characterEffect1011ui_story = arg_157_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["1011ui_story"]) then
				if arg_157_1.var_.characterEffect1011ui_story and not isNil(arg_157_1.actors_["1011ui_story"]) then
					arg_157_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_0)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["1011ui_story"]) and arg_157_1.var_.characterEffect1011ui_story then
				arg_157_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_160_1 = 0
			local var_160_2 = 1.125

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_3 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(1101101040).content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 45 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 45)

				if (45 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 45)) > 0 and var_160_2 < var_160_5 then
					arg_157_1.talkMaxDuration = var_160_5

					if var_160_5 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + var_160_1
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_6 = math.max(var_160_2, arg_157_1.talkMaxDuration)

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_6 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_1) / var_160_6

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_1 + var_160_6 and arg_157_1.time_ < var_160_1 + var_160_6 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play1101101041 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 1101101041
		arg_161_1.duration_ = 4.6

		local var_161_0 = {
			zh = 3.1,
			ja = 4.6
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play1101101042(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1011ui_story = arg_161_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1011ui_story"].transform.position).z)
				arg_161_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1011ui_story"].transform.localEulerAngles = arg_161_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_161_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1011ui_story"].transform.position).z)
				arg_161_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1011ui_story"].transform.localEulerAngles = arg_161_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["1011ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1011ui_story == nil then
				arg_161_1.var_.characterEffect1011ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect1011ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect1011ui_story then
				arg_161_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_164_4 = 0
			local var_164_5 = 0.3

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_6 = arg_161_1:GetWordFromCfg(1101101041)
				local var_164_7 = arg_161_1:FormatText(var_164_6.content)

				arg_161_1.text_.text = var_164_7

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_9 = 12 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 12)

				if (12 <= 0 and var_164_5 or var_164_5 * (utf8.len(var_164_7) / 12)) > 0 and var_164_5 < var_164_9 then
					arg_161_1.talkMaxDuration = var_164_9

					if var_164_9 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_4
					end
				end

				arg_161_1.text_.text = var_164_7
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101041", "story_v_side_new_1101101.awb") ~= 0 then
					local var_164_10 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101041", "story_v_side_new_1101101.awb") / 1000

					if var_164_10 + var_164_4 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_4
					end

					if var_164_6.prefab_name ~= "" and arg_161_1.actors_[var_164_6.prefab_name] ~= nil then
						local var_164_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_6.prefab_name].transform, "story_v_side_new_1101101", "1101101041", "story_v_side_new_1101101.awb")

						arg_161_1:RecordAudio("1101101041", var_164_11)
						arg_161_1:RecordAudio("1101101041", var_164_11)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101041", "story_v_side_new_1101101.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101041", "story_v_side_new_1101101.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_12 = math.max(var_164_5, arg_161_1.talkMaxDuration)

			if var_164_4 <= arg_161_1.time_ and arg_161_1.time_ < var_164_4 + var_164_12 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_4) / var_164_12

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_4 + var_164_12 and arg_161_1.time_ < var_164_4 + var_164_12 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
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

		arg_161_1:InitPlayNodeList()
	end,
	Play1101101042 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 1101101042
		arg_165_1.duration_ = 11

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play1101101043(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if arg_165_1.bgs_.D12b == nil then
				local var_168_0 = Object.Instantiate(arg_165_1.paintGo_)

				var_168_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D12b")
				var_168_0.name = "D12b"
				var_168_0.transform.parent = arg_165_1.stage_.transform
				var_168_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.bgs_.D12b = var_168_0
			end

			if 3 < arg_165_1.time_ and arg_165_1.time_ <= 3 + arg_168_0 then
				local var_168_1 = arg_165_1.bgs_.D12b

				arg_165_1.bgs_.D12b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_168_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_168_2 = var_168_1:GetComponent("SpriteRenderer")

				if var_168_2 and var_168_2.sprite then
					local var_168_3 = 2 * (var_168_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_168_1.transform.localScale = Vector3.New(var_168_3 / var_168_2.sprite.bounds.size.y < var_168_3 * manager.ui.mainCameraCom_.aspect / var_168_2.sprite.bounds.size.x and var_168_3 * manager.ui.mainCameraCom_.aspect / var_168_2.sprite.bounds.size.x or var_168_3 / var_168_2.sprite.bounds.size.y, var_168_3 / var_168_2.sprite.bounds.size.y < var_168_3 * manager.ui.mainCameraCom_.aspect / var_168_2.sprite.bounds.size.x and var_168_3 * manager.ui.mainCameraCom_.aspect / var_168_2.sprite.bounds.size.x or var_168_3 / var_168_2.sprite.bounds.size.y, 0)
				end

				for iter_168_0, iter_168_1 in pairs(arg_165_1.bgs_) do
					if iter_168_0 ~= "D12b" then
						iter_168_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_168_4 = 0

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_5 = 3

			if var_168_4 <= arg_165_1.time_ and arg_165_1.time_ < var_168_4 + var_168_5 then
				local var_168_6 = Color.New(0, 0, 0)

				var_168_6.a = Mathf.Lerp(0, 1, (arg_165_1.time_ - var_168_4) / var_168_5)
				arg_165_1.mask_.color = var_168_6
			end

			if arg_165_1.time_ >= var_168_4 + var_168_5 and arg_165_1.time_ < var_168_4 + var_168_5 + arg_168_0 then
				local var_168_7 = Color.New(0, 0, 0)

				var_168_7.a = 1
				arg_165_1.mask_.color = var_168_7
			end

			local var_168_8 = 3

			if 3 < arg_165_1.time_ and arg_165_1.time_ <= var_168_8 + arg_168_0 then
				arg_165_1.mask_.enabled = true
				arg_165_1.mask_.raycastTarget = true

				arg_165_1:SetGaussion(false)
			end

			local var_168_9 = 3

			if var_168_8 <= arg_165_1.time_ and arg_165_1.time_ < var_168_8 + var_168_9 then
				local var_168_10 = Color.New(0, 0, 0)

				var_168_10.a = Mathf.Lerp(1, 0, (arg_165_1.time_ - var_168_8) / var_168_9)
				arg_165_1.mask_.color = var_168_10
			end

			if arg_165_1.time_ >= var_168_8 + var_168_9 and arg_165_1.time_ < var_168_8 + var_168_9 + arg_168_0 then
				local var_168_11 = Color.New(0, 0, 0)

				arg_165_1.mask_.enabled = false
				var_168_11.a = 0
				arg_165_1.mask_.color = var_168_11
			end

			local var_168_12 = arg_165_1.actors_["1011ui_story"].transform

			if 3 < arg_165_1.time_ and arg_165_1.time_ <= 3 + arg_168_0 then
				arg_165_1.var_.moveOldPos1011ui_story = var_168_12.localPosition
			end

			local var_168_13 = 0.001

			if 3 <= arg_165_1.time_ and arg_165_1.time_ < 3 + var_168_13 then
				var_168_12.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 3) / var_168_13)
				var_168_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_12.position).x, (manager.ui.mainCamera.transform.position - var_168_12.position).y, (manager.ui.mainCamera.transform.position - var_168_12.position).z)
				var_168_12.localEulerAngles.z = 0
				var_168_12.localEulerAngles.x = 0
				var_168_12.localEulerAngles = var_168_12.localEulerAngles
			end

			if arg_165_1.time_ >= 3 + var_168_13 and arg_165_1.time_ < 3 + var_168_13 + arg_168_0 then
				var_168_12.localPosition = Vector3.New(0, 100, 0)
				var_168_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_168_12.position).x, (manager.ui.mainCamera.transform.position - var_168_12.position).y, (manager.ui.mainCamera.transform.position - var_168_12.position).z)
				var_168_12.localEulerAngles.z = 0
				var_168_12.localEulerAngles.x = 0
				var_168_12.localEulerAngles = var_168_12.localEulerAngles
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_168_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_165_1.bgmTxt_.text ~= var_168_16 and arg_165_1.bgmTxt_.text ~= "" then
						if arg_165_1.bgmTxt2_.text ~= "" then
							arg_165_1.bgmTxt_.text = arg_165_1.bgmTxt2_.text
						end

						arg_165_1.bgmTxt2_.text = var_168_16

						arg_165_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_165_1.bgmTxt_.text = var_168_16
						arg_165_1.bgmTxt2_.text = var_168_16
					end

					if arg_165_1.bgmTimer then
						arg_165_1.bgmTimer:Stop()

						arg_165_1.bgmTimer = nil
					end

					if arg_165_1.settingData.show_music_name == 1 then
						arg_165_1.musicController:SetSelectedState("show")
						arg_165_1.musicAnimator_:Play("open", 0, 0)

						if arg_165_1.settingData.music_time ~= 0 then
							arg_165_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_165_1.settingData.music_time), function()
								if arg_165_1 == nil or isNil(arg_165_1.bgmTxt_) then
									return
								end

								arg_165_1.musicController:SetSelectedState("hide")
								arg_165_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_165_1.frameCnt_ <= 1 then
				arg_165_1.dialog_:SetActive(false)
			end

			local var_168_17 = 6
			local var_168_18 = 0.875

			if 6 < arg_165_1.time_ and arg_165_1.time_ <= var_168_17 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				arg_165_1.dialog_:SetActive(true)

				arg_165_1.dialogCg_.alpha = 0

				local var_168_19 = LeanTween.value(arg_165_1.dialog_, 0, 1, 0.3)

				var_168_19:setOnUpdate(LuaHelper.FloatAction(function(arg_170_0)
					arg_165_1.dialogCg_.alpha = arg_170_0
				end))
				var_168_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_165_1.dialog_)
					var_168_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_165_1.duration_ = arg_165_1.duration_ + 0.3

				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_20 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(1101101042).content)

				arg_165_1.text_.text = var_168_20

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_22 = 35 <= 0 and var_168_18 or var_168_18 * (utf8.len(var_168_20) / 35)

				if (35 <= 0 and var_168_18 or var_168_18 * (utf8.len(var_168_20) / 35)) > 0 and var_168_18 < var_168_22 then
					arg_165_1.talkMaxDuration = var_168_22
					var_168_17 = var_168_17 + 0.3

					if var_168_22 + var_168_17 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_22 + var_168_17
					end
				end

				arg_165_1.text_.text = var_168_20
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_23 = var_168_17 + 0.3
			local var_168_24 = math.max(var_168_18, arg_165_1.talkMaxDuration)

			if var_168_17 + 0.3 <= arg_165_1.time_ and arg_165_1.time_ < var_168_23 + var_168_24 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_23) / var_168_24

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_23 + var_168_24 and arg_165_1.time_ < var_168_23 + var_168_24 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play1101101043 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 1101101043
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play1101101044(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0.825

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_1 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(1101101043).content)

				arg_172_1.text_.text = var_175_1

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_3 = 33 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_1) / 33)

				if (33 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_1) / 33)) > 0 and var_175_0 < var_175_3 then
					arg_172_1.talkMaxDuration = var_175_3

					if var_175_3 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_3 + 0
					end
				end

				arg_172_1.text_.text = var_175_1
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_4 = math.max(var_175_0, arg_172_1.talkMaxDuration)

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_4 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - 0) / var_175_4

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= 0 + var_175_4 and arg_172_1.time_ < 0 + var_175_4 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play1101101044 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 1101101044
		arg_176_1.duration_ = 9.97

		local var_176_0 = {
			zh = 6.3,
			ja = 9.966
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play1101101045(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos1011ui_story = arg_176_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_179_0 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 then
				arg_176_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_176_1.time_ - 0) / var_179_0)
				arg_176_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1011ui_story"].transform.position).z)
				arg_176_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["1011ui_story"].transform.localEulerAngles = arg_176_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 then
				arg_176_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_176_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1011ui_story"].transform.position).z)
				arg_176_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["1011ui_story"].transform.localEulerAngles = arg_176_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_179_1 = arg_176_1.actors_["1011ui_story"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_1) and arg_176_1.var_.characterEffect1011ui_story == nil then
				arg_176_1.var_.characterEffect1011ui_story = var_179_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_2 and not isNil(var_179_1) then
				if arg_176_1.var_.characterEffect1011ui_story and not isNil(var_179_1) then
					arg_176_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_2 and arg_176_1.time_ < 0 + var_179_2 + arg_179_0 and not isNil(var_179_1) and arg_176_1.var_.characterEffect1011ui_story then
				arg_176_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_179_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_176_1.bgmTxt_.text ~= var_179_6 and arg_176_1.bgmTxt_.text ~= "" then
						if arg_176_1.bgmTxt2_.text ~= "" then
							arg_176_1.bgmTxt_.text = arg_176_1.bgmTxt2_.text
						end

						arg_176_1.bgmTxt2_.text = var_179_6

						arg_176_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_176_1.bgmTxt_.text = var_179_6
						arg_176_1.bgmTxt2_.text = var_179_6
					end

					if arg_176_1.bgmTimer then
						arg_176_1.bgmTimer:Stop()

						arg_176_1.bgmTimer = nil
					end

					if arg_176_1.settingData.show_music_name == 1 then
						arg_176_1.musicController:SetSelectedState("show")
						arg_176_1.musicAnimator_:Play("open", 0, 0)

						if arg_176_1.settingData.music_time ~= 0 then
							arg_176_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_176_1.settingData.music_time), function()
								if arg_176_1 == nil or isNil(arg_176_1.bgmTxt_) then
									return
								end

								arg_176_1.musicController:SetSelectedState("hide")
								arg_176_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.266666666666667 < arg_176_1.time_ and arg_176_1.time_ <= 0.266666666666667 + arg_179_0 then
				arg_176_1:AudioAction("play", "music", "bgm_activity_1_5_battle_2", "bgm_activity_1_5_battle_2", "bgm_activity_1_5_battle_2.awb")

				local var_179_9 = manager.audio:GetAudioName("bgm_activity_1_5_battle_2", "bgm_activity_1_5_battle_2")

				if "" ~= "" then
					if arg_176_1.bgmTxt_.text ~= var_179_9 and arg_176_1.bgmTxt_.text ~= "" then
						if arg_176_1.bgmTxt2_.text ~= "" then
							arg_176_1.bgmTxt_.text = arg_176_1.bgmTxt2_.text
						end

						arg_176_1.bgmTxt2_.text = var_179_9

						arg_176_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_176_1.bgmTxt_.text = var_179_9
						arg_176_1.bgmTxt2_.text = var_179_9
					end

					if arg_176_1.bgmTimer then
						arg_176_1.bgmTimer:Stop()

						arg_176_1.bgmTimer = nil
					end

					if arg_176_1.settingData.show_music_name == 1 then
						arg_176_1.musicController:SetSelectedState("show")
						arg_176_1.musicAnimator_:Play("open", 0, 0)

						if arg_176_1.settingData.music_time ~= 0 then
							arg_176_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_176_1.settingData.music_time), function()
								if arg_176_1 == nil or isNil(arg_176_1.bgmTxt_) then
									return
								end

								arg_176_1.musicController:SetSelectedState("hide")
								arg_176_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_179_10 = 0
			local var_179_11 = 0.775

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_10 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_12 = arg_176_1:GetWordFromCfg(1101101044)
				local var_179_13 = arg_176_1:FormatText(var_179_12.content)

				arg_176_1.text_.text = var_179_13

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_15 = 31 <= 0 and var_179_11 or var_179_11 * (utf8.len(var_179_13) / 31)

				if (31 <= 0 and var_179_11 or var_179_11 * (utf8.len(var_179_13) / 31)) > 0 and var_179_11 < var_179_15 then
					arg_176_1.talkMaxDuration = var_179_15

					if var_179_15 + var_179_10 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_15 + var_179_10
					end
				end

				arg_176_1.text_.text = var_179_13
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101044", "story_v_side_new_1101101.awb") ~= 0 then
					local var_179_16 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101044", "story_v_side_new_1101101.awb") / 1000

					if var_179_16 + var_179_10 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_16 + var_179_10
					end

					if var_179_12.prefab_name ~= "" and arg_176_1.actors_[var_179_12.prefab_name] ~= nil then
						local var_179_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_12.prefab_name].transform, "story_v_side_new_1101101", "1101101044", "story_v_side_new_1101101.awb")

						arg_176_1:RecordAudio("1101101044", var_179_17)
						arg_176_1:RecordAudio("1101101044", var_179_17)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101044", "story_v_side_new_1101101.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101044", "story_v_side_new_1101101.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_18 = math.max(var_179_11, arg_176_1.talkMaxDuration)

			if var_179_10 <= arg_176_1.time_ and arg_176_1.time_ < var_179_10 + var_179_18 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_10) / var_179_18

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_10 + var_179_18 and arg_176_1.time_ < var_179_10 + var_179_18 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
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

		arg_176_1:InitPlayNodeList()
	end,
	Play1101101045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 1101101045
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play1101101046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["1011ui_story"]) and arg_182_1.var_.characterEffect1011ui_story == nil then
				arg_182_1.var_.characterEffect1011ui_story = arg_182_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_0 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["1011ui_story"]) then
				if arg_182_1.var_.characterEffect1011ui_story and not isNil(arg_182_1.actors_["1011ui_story"]) then
					arg_182_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_0)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["1011ui_story"]) and arg_182_1.var_.characterEffect1011ui_story then
				arg_182_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_185_1 = 0
			local var_185_2 = 0.575

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_3 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(1101101045).content)

				arg_182_1.text_.text = var_185_3

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_5 = 23 <= 0 and var_185_2 or var_185_2 * (utf8.len(var_185_3) / 23)

				if (23 <= 0 and var_185_2 or var_185_2 * (utf8.len(var_185_3) / 23)) > 0 and var_185_2 < var_185_5 then
					arg_182_1.talkMaxDuration = var_185_5

					if var_185_5 + var_185_1 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_5 + var_185_1
					end
				end

				arg_182_1.text_.text = var_185_3
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_6 = math.max(var_185_2, arg_182_1.talkMaxDuration)

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_6 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_1) / var_185_6

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_1 + var_185_6 and arg_182_1.time_ < var_185_1 + var_185_6 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play1101101046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 1101101046
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play1101101047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0.9

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_1 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(1101101046).content)

				arg_186_1.text_.text = var_189_1

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_3 = 36 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_1) / 36)

				if (36 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_1) / 36)) > 0 and var_189_0 < var_189_3 then
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
	Play1101101047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 1101101047
		arg_190_1.duration_ = 7.67

		local var_190_0 = {
			zh = 7.666,
			ja = 3.6
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
				arg_190_0:Play1101101048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos1011ui_story = arg_190_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_193_0 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 then
				arg_190_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_190_1.time_ - 0) / var_193_0)
				arg_190_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1011ui_story"].transform.position).z)
				arg_190_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1011ui_story"].transform.localEulerAngles = arg_190_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 then
				arg_190_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_190_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["1011ui_story"].transform.position).z)
				arg_190_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["1011ui_story"].transform.localEulerAngles = arg_190_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_193_1 = arg_190_1.actors_["1011ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1011ui_story == nil then
				arg_190_1.var_.characterEffect1011ui_story = var_193_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_2 and not isNil(var_193_1) then
				if arg_190_1.var_.characterEffect1011ui_story and not isNil(var_193_1) then
					arg_190_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_2 and arg_190_1.time_ < 0 + var_193_2 + arg_193_0 and not isNil(var_193_1) and arg_190_1.var_.characterEffect1011ui_story then
				arg_190_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_193_4 = 0
			local var_193_5 = 0.925

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_6 = arg_190_1:GetWordFromCfg(1101101047)
				local var_193_7 = arg_190_1:FormatText(var_193_6.content)

				arg_190_1.text_.text = var_193_7

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_9 = 37 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 37)

				if (37 <= 0 and var_193_5 or var_193_5 * (utf8.len(var_193_7) / 37)) > 0 and var_193_5 < var_193_9 then
					arg_190_1.talkMaxDuration = var_193_9

					if var_193_9 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_9 + var_193_4
					end
				end

				arg_190_1.text_.text = var_193_7
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101047", "story_v_side_new_1101101.awb") ~= 0 then
					local var_193_10 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101047", "story_v_side_new_1101101.awb") / 1000

					if var_193_10 + var_193_4 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_10 + var_193_4
					end

					if var_193_6.prefab_name ~= "" and arg_190_1.actors_[var_193_6.prefab_name] ~= nil then
						local var_193_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_6.prefab_name].transform, "story_v_side_new_1101101", "1101101047", "story_v_side_new_1101101.awb")

						arg_190_1:RecordAudio("1101101047", var_193_11)
						arg_190_1:RecordAudio("1101101047", var_193_11)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101047", "story_v_side_new_1101101.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101047", "story_v_side_new_1101101.awb")
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
				actorName = "1011ui_story",
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
	Play1101101048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 1101101048
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play1101101049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos1011ui_story = arg_194_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_197_0 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 then
				arg_194_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_194_1.time_ - 0) / var_197_0)
				arg_194_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_194_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["1011ui_story"].transform.position).z)
				arg_194_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_194_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_194_1.actors_["1011ui_story"].transform.localEulerAngles = arg_194_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 then
				arg_194_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_194_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_194_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["1011ui_story"].transform.position).z)
				arg_194_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_194_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_194_1.actors_["1011ui_story"].transform.localEulerAngles = arg_194_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_197_1 = 0
			local var_197_2 = 0.7

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, false)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_3 = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(1101101048).content)

				arg_194_1.text_.text = var_197_3

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_5 = 28 <= 0 and var_197_2 or var_197_2 * (utf8.len(var_197_3) / 28)

				if (28 <= 0 and var_197_2 or var_197_2 * (utf8.len(var_197_3) / 28)) > 0 and var_197_2 < var_197_5 then
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

		arg_194_1.nodeConfigList_ = {
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

		arg_194_1:InitPlayNodeList()
	end,
	Play1101101049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 1101101049
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play1101101050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:AudioAction("play", "effect", "se_story_222_00", "se_story_222_00_gun", "")
			end

			local var_201_1 = 0

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.mask_.enabled = true
				arg_198_1.mask_.raycastTarget = false

				arg_198_1:SetGaussion(false)
			end

			local var_201_2 = 0.166666666666667

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 then
				local var_201_3 = Color.New(1, 1, 1)

				var_201_3.a = Mathf.Lerp(1, 0, (arg_198_1.time_ - var_201_1) / var_201_2)
				arg_198_1.mask_.color = var_201_3
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 then
				local var_201_4 = Color.New(1, 1, 1)

				arg_198_1.mask_.enabled = false
				var_201_4.a = 0
				arg_198_1.mask_.color = var_201_4
			end

			local var_201_5 = 0.208333333333333

			if 0.208333333333333 < arg_198_1.time_ and arg_198_1.time_ <= var_201_5 + arg_201_0 then
				arg_198_1.mask_.enabled = true
				arg_198_1.mask_.raycastTarget = false

				arg_198_1:SetGaussion(false)
			end

			local var_201_6 = 0.158333333333333

			if var_201_5 <= arg_198_1.time_ and arg_198_1.time_ < var_201_5 + var_201_6 then
				local var_201_7 = Color.New(1, 1, 1)

				var_201_7.a = Mathf.Lerp(1, 0, (arg_198_1.time_ - var_201_5) / var_201_6)
				arg_198_1.mask_.color = var_201_7
			end

			if arg_198_1.time_ >= var_201_5 + var_201_6 and arg_198_1.time_ < var_201_5 + var_201_6 + arg_201_0 then
				local var_201_8 = Color.New(1, 1, 1)

				arg_198_1.mask_.enabled = false
				var_201_8.a = 0
				arg_198_1.mask_.color = var_201_8
			end

			local var_201_9 = 0.416666666666667

			if 0.416666666666667 < arg_198_1.time_ and arg_198_1.time_ <= var_201_9 + arg_201_0 then
				arg_198_1.mask_.enabled = true
				arg_198_1.mask_.raycastTarget = false

				arg_198_1:SetGaussion(false)
			end

			local var_201_10 = 0.158333333333333

			if var_201_9 <= arg_198_1.time_ and arg_198_1.time_ < var_201_9 + var_201_10 then
				local var_201_11 = Color.New(1, 1, 1)

				var_201_11.a = Mathf.Lerp(1, 0, (arg_198_1.time_ - var_201_9) / var_201_10)
				arg_198_1.mask_.color = var_201_11
			end

			if arg_198_1.time_ >= var_201_9 + var_201_10 and arg_198_1.time_ < var_201_9 + var_201_10 + arg_201_0 then
				local var_201_12 = Color.New(1, 1, 1)

				arg_198_1.mask_.enabled = false
				var_201_12.a = 0
				arg_198_1.mask_.color = var_201_12
			end

			local var_201_13 = 0.641666666666667

			if 0.641666666666667 < arg_198_1.time_ and arg_198_1.time_ <= var_201_13 + arg_201_0 then
				arg_198_1.mask_.enabled = true
				arg_198_1.mask_.raycastTarget = false

				arg_198_1:SetGaussion(false)
			end

			local var_201_14 = 0.158333333333333

			if var_201_13 <= arg_198_1.time_ and arg_198_1.time_ < var_201_13 + var_201_14 then
				local var_201_15 = Color.New(1, 1, 1)

				var_201_15.a = Mathf.Lerp(1, 0, (arg_198_1.time_ - var_201_13) / var_201_14)
				arg_198_1.mask_.color = var_201_15
			end

			if arg_198_1.time_ >= var_201_13 + var_201_14 and arg_198_1.time_ < var_201_13 + var_201_14 + arg_201_0 then
				local var_201_16 = Color.New(1, 1, 1)

				arg_198_1.mask_.enabled = false
				var_201_16.a = 0
				arg_198_1.mask_.color = var_201_16
			end

			local var_201_17 = 0.841666666666667

			if 0.841666666666667 < arg_198_1.time_ and arg_198_1.time_ <= var_201_17 + arg_201_0 then
				arg_198_1.mask_.enabled = true
				arg_198_1.mask_.raycastTarget = false

				arg_198_1:SetGaussion(false)
			end

			local var_201_18 = 0.158333333333333

			if var_201_17 <= arg_198_1.time_ and arg_198_1.time_ < var_201_17 + var_201_18 then
				local var_201_19 = Color.New(1, 1, 1)

				var_201_19.a = Mathf.Lerp(1, 0, (arg_198_1.time_ - var_201_17) / var_201_18)
				arg_198_1.mask_.color = var_201_19
			end

			if arg_198_1.time_ >= var_201_17 + var_201_18 and arg_198_1.time_ < var_201_17 + var_201_18 + arg_201_0 then
				local var_201_20 = Color.New(1, 1, 1)

				arg_198_1.mask_.enabled = false
				var_201_20.a = 0
				arg_198_1.mask_.color = var_201_20
			end

			local var_201_21 = 0
			local var_201_22 = 0.575

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_21 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0

				arg_198_1.dialog_:SetActive(true)

				arg_198_1.dialogCg_.alpha = 0

				local var_201_23 = LeanTween.value(arg_198_1.dialog_, 0, 1, 0.3)

				var_201_23:setOnUpdate(LuaHelper.FloatAction(function(arg_202_0)
					arg_198_1.dialogCg_.alpha = arg_202_0
				end))
				var_201_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_198_1.dialog_)
					var_201_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_198_1.duration_ = arg_198_1.duration_ + 0.3

				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_24 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(1101101049).content)

				arg_198_1.text_.text = var_201_24

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_26 = 23 <= 0 and var_201_22 or var_201_22 * (utf8.len(var_201_24) / 23)

				if (23 <= 0 and var_201_22 or var_201_22 * (utf8.len(var_201_24) / 23)) > 0 and var_201_22 < var_201_26 then
					arg_198_1.talkMaxDuration = var_201_26
					var_201_21 = var_201_21 + 0.3

					if var_201_26 + var_201_21 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_26 + var_201_21
					end
				end

				arg_198_1.text_.text = var_201_24
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_27 = var_201_21 + 0.3
			local var_201_28 = math.max(var_201_22, arg_198_1.talkMaxDuration)

			if var_201_21 + 0.3 <= arg_198_1.time_ and arg_198_1.time_ < var_201_27 + var_201_28 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_27) / var_201_28

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_27 + var_201_28 and arg_198_1.time_ < var_201_27 + var_201_28 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play1101101050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 1101101050
		arg_204_1.duration_ = 5

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play1101101051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if arg_204_1.actors_["2017_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2017_tpose"))) then
				local var_207_0 = Object.Instantiate(Asset.Load("Char/" .. "2017_tpose"), arg_204_1.stage_.transform)

				var_207_0.name = "2017_tpose"
				var_207_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_204_1.actors_["2017_tpose"] = var_207_0

				local var_207_1 = var_207_0:GetComponentInChildren(typeof(CharacterEffect))

				var_207_1.enabled = true

				local var_207_2 = GameObjectTools.GetOrAddComponent(var_207_0, typeof(DynamicBoneHelper))

				if var_207_2 then
					var_207_2:EnableDynamicBone(false)
				end

				arg_204_1:ShowWeapon(var_207_1.transform, false)

				arg_204_1.var_["2017_tpose" .. "Animator"] = var_207_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_204_1.var_["2017_tpose" .. "Animator"].applyRootMotion = true
				arg_204_1.var_["2017_tpose" .. "LipSync"] = var_207_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_207_3 = arg_204_1.actors_["2017_tpose"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_3) and arg_204_1.var_.characterEffect2017_tpose == nil then
				arg_204_1.var_.characterEffect2017_tpose = var_207_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_4 = 0.2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_4 and not isNil(var_207_3) then
				if arg_204_1.var_.characterEffect2017_tpose and not isNil(var_207_3) then
					arg_204_1.var_.characterEffect2017_tpose.fillFlat = true
					arg_204_1.var_.characterEffect2017_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_204_1.time_ - 0) / var_207_4)
				end
			end

			if arg_204_1.time_ >= 0 + var_207_4 and arg_204_1.time_ < 0 + var_207_4 + arg_207_0 and not isNil(var_207_3) and arg_204_1.var_.characterEffect2017_tpose then
				arg_204_1.var_.characterEffect2017_tpose.fillFlat = true
				arg_204_1.var_.characterEffect2017_tpose.fillRatio = 0.5
			end

			local var_207_5 = 0
			local var_207_6 = 0.425

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_5 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_7 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(1101101050).content)

				arg_204_1.text_.text = var_207_7

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_9 = 17 <= 0 and var_207_6 or var_207_6 * (utf8.len(var_207_7) / 17)

				if (17 <= 0 and var_207_6 or var_207_6 * (utf8.len(var_207_7) / 17)) > 0 and var_207_6 < var_207_9 then
					arg_204_1.talkMaxDuration = var_207_9

					if var_207_9 + var_207_5 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_9 + var_207_5
					end
				end

				arg_204_1.text_.text = var_207_7
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_10 = math.max(var_207_6, arg_204_1.talkMaxDuration)

			if var_207_5 <= arg_204_1.time_ and arg_204_1.time_ < var_207_5 + var_207_10 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_5) / var_207_10

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_5 + var_207_10 and arg_204_1.time_ < var_207_5 + var_207_10 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play1101101051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 1101101051
		arg_208_1.duration_ = 2

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play1101101052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos1011ui_story = arg_208_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_211_0 = 0.001

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 then
				arg_208_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_208_1.time_ - 0) / var_211_0)
				arg_208_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_208_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["1011ui_story"].transform.position).z)
				arg_208_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_208_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_208_1.actors_["1011ui_story"].transform.localEulerAngles = arg_208_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 then
				arg_208_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_208_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_208_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_208_1.actors_["1011ui_story"].transform.position).z)
				arg_208_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_208_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_208_1.actors_["1011ui_story"].transform.localEulerAngles = arg_208_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_211_1 = arg_208_1.actors_["1011ui_story"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_1) and arg_208_1.var_.characterEffect1011ui_story == nil then
				arg_208_1.var_.characterEffect1011ui_story = var_211_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_2 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_2 and not isNil(var_211_1) then
				if arg_208_1.var_.characterEffect1011ui_story and not isNil(var_211_1) then
					arg_208_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= 0 + var_211_2 and arg_208_1.time_ < 0 + var_211_2 + arg_211_0 and not isNil(var_211_1) and arg_208_1.var_.characterEffect1011ui_story then
				arg_208_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action426")
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_211_4 = arg_208_1.actors_["2017_tpose"].transform

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos2017_tpose = var_211_4.localPosition

				local var_211_5 = GameObjectTools.GetOrAddComponent(var_211_4.gameObject, typeof(DynamicBoneHelper))

				if var_211_5 then
					var_211_5:EnableDynamicBone(false)
				end
			end

			local var_211_6 = 0.001

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_6 then
				var_211_4.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos2017_tpose, Vector3.New(0, 100, 0), (arg_208_1.time_ - 0) / var_211_6)
				var_211_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_211_4.position).x, (manager.ui.mainCamera.transform.position - var_211_4.position).y, (manager.ui.mainCamera.transform.position - var_211_4.position).z)
				var_211_4.localEulerAngles.z = 0
				var_211_4.localEulerAngles.x = 0
				var_211_4.localEulerAngles = var_211_4.localEulerAngles
			end

			if arg_208_1.time_ >= 0 + var_211_6 and arg_208_1.time_ < 0 + var_211_6 + arg_211_0 then
				var_211_4.localPosition = Vector3.New(0, 100, 0)
				var_211_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_211_4.position).x, (manager.ui.mainCamera.transform.position - var_211_4.position).y, (manager.ui.mainCamera.transform.position - var_211_4.position).z)
				var_211_4.localEulerAngles.z = 0
				var_211_4.localEulerAngles.x = 0
				var_211_4.localEulerAngles = var_211_4.localEulerAngles

				local var_211_7 = GameObjectTools.GetOrAddComponent(var_211_4.gameObject, typeof(DynamicBoneHelper))

				if var_211_7 then
					var_211_7:EnableDynamicBone(true)
				end
			end

			local var_211_8 = 0
			local var_211_9 = 0.075

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_8 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_10 = arg_208_1:GetWordFromCfg(1101101051)
				local var_211_11 = arg_208_1:FormatText(var_211_10.content)

				arg_208_1.text_.text = var_211_11

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_13 = 3 <= 0 and var_211_9 or var_211_9 * (utf8.len(var_211_11) / 3)

				if (3 <= 0 and var_211_9 or var_211_9 * (utf8.len(var_211_11) / 3)) > 0 and var_211_9 < var_211_13 then
					arg_208_1.talkMaxDuration = var_211_13

					if var_211_13 + var_211_8 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_13 + var_211_8
					end
				end

				arg_208_1.text_.text = var_211_11
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101051", "story_v_side_new_1101101.awb") ~= 0 then
					local var_211_14 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101051", "story_v_side_new_1101101.awb") / 1000

					if var_211_14 + var_211_8 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_14 + var_211_8
					end

					if var_211_10.prefab_name ~= "" and arg_208_1.actors_[var_211_10.prefab_name] ~= nil then
						local var_211_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_10.prefab_name].transform, "story_v_side_new_1101101", "1101101051", "story_v_side_new_1101101.awb")

						arg_208_1:RecordAudio("1101101051", var_211_15)
						arg_208_1:RecordAudio("1101101051", var_211_15)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101051", "story_v_side_new_1101101.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101051", "story_v_side_new_1101101.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_16 = math.max(var_211_9, arg_208_1.talkMaxDuration)

			if var_211_8 <= arg_208_1.time_ and arg_208_1.time_ < var_211_8 + var_211_16 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_8) / var_211_16

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_8 + var_211_16 and arg_208_1.time_ < var_211_8 + var_211_16 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2017_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play1101101052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 1101101052
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play1101101053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(arg_212_1.actors_["1011ui_story"]) and arg_212_1.var_.characterEffect1011ui_story == nil then
				arg_212_1.var_.characterEffect1011ui_story = arg_212_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_0 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 and not isNil(arg_212_1.actors_["1011ui_story"]) then
				if arg_212_1.var_.characterEffect1011ui_story and not isNil(arg_212_1.actors_["1011ui_story"]) then
					arg_212_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_212_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_212_1.time_ - 0) / var_215_0)
				end
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 and not isNil(arg_212_1.actors_["1011ui_story"]) and arg_212_1.var_.characterEffect1011ui_story then
				arg_212_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_212_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:AudioAction("play", "effect", "se_story_10", "se_story_10_sword02", "")
			end

			local var_215_2 = arg_212_1.actors_["1011ui_story"].transform

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos1011ui_story = var_215_2.localPosition
			end

			local var_215_3 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_3 then
				var_215_2.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_212_1.time_ - 0) / var_215_3)
				var_215_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_2.position).x, (manager.ui.mainCamera.transform.position - var_215_2.position).y, (manager.ui.mainCamera.transform.position - var_215_2.position).z)
				var_215_2.localEulerAngles.z = 0
				var_215_2.localEulerAngles.x = 0
				var_215_2.localEulerAngles = var_215_2.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_3 and arg_212_1.time_ < 0 + var_215_3 + arg_215_0 then
				var_215_2.localPosition = Vector3.New(0, 100, 0)
				var_215_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_2.position).x, (manager.ui.mainCamera.transform.position - var_215_2.position).y, (manager.ui.mainCamera.transform.position - var_215_2.position).z)
				var_215_2.localEulerAngles.z = 0
				var_215_2.localEulerAngles.x = 0
				var_215_2.localEulerAngles = var_215_2.localEulerAngles
			end

			local var_215_4 = 0

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_4 + arg_215_0 then
				arg_212_1.mask_.enabled = true
				arg_212_1.mask_.raycastTarget = false

				arg_212_1:SetGaussion(false)
			end

			local var_215_5 = 1

			if var_215_4 <= arg_212_1.time_ and arg_212_1.time_ < var_215_4 + var_215_5 then
				local var_215_6 = Color.New(1, 1, 1)

				var_215_6.a = Mathf.Lerp(1, 0, (arg_212_1.time_ - var_215_4) / var_215_5)
				arg_212_1.mask_.color = var_215_6
			end

			if arg_212_1.time_ >= var_215_4 + var_215_5 and arg_212_1.time_ < var_215_4 + var_215_5 + arg_215_0 then
				local var_215_7 = Color.New(1, 1, 1)

				arg_212_1.mask_.enabled = false
				var_215_7.a = 0
				arg_212_1.mask_.color = var_215_7
			end

			local var_215_8 = 0
			local var_215_9 = 0.9

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_8 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0

				arg_212_1.dialog_:SetActive(true)

				arg_212_1.dialogCg_.alpha = 0

				local var_215_10 = LeanTween.value(arg_212_1.dialog_, 0, 1, 0.3)

				var_215_10:setOnUpdate(LuaHelper.FloatAction(function(arg_216_0)
					arg_212_1.dialogCg_.alpha = arg_216_0
				end))
				var_215_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_212_1.dialog_)
					var_215_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_212_1.duration_ = arg_212_1.duration_ + 0.3

				SetActive(arg_212_1.leftNameGo_, false)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_11 = arg_212_1:FormatText(arg_212_1:GetWordFromCfg(1101101052).content)

				arg_212_1.text_.text = var_215_11

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_13 = 34 <= 0 and var_215_9 or var_215_9 * (utf8.len(var_215_11) / 34)

				if (34 <= 0 and var_215_9 or var_215_9 * (utf8.len(var_215_11) / 34)) > 0 and var_215_9 < var_215_13 then
					arg_212_1.talkMaxDuration = var_215_13
					var_215_8 = var_215_8 + 0.3

					if var_215_13 + var_215_8 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_13 + var_215_8
					end
				end

				arg_212_1.text_.text = var_215_11
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_14 = var_215_8 + 0.3
			local var_215_15 = math.max(var_215_9, arg_212_1.talkMaxDuration)

			if var_215_8 + 0.3 <= arg_212_1.time_ and arg_212_1.time_ < var_215_14 + var_215_15 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_14) / var_215_15

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_14 + var_215_15 and arg_212_1.time_ < var_215_14 + var_215_15 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
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

		arg_212_1:InitPlayNodeList()
	end,
	Play1101101053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 1101101053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play1101101054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0.225

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_1 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(1101101053).content)

				arg_218_1.text_.text = var_221_1

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_3 = 9 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 9)

				if (9 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 9)) > 0 and var_221_0 < var_221_3 then
					arg_218_1.talkMaxDuration = var_221_3

					if var_221_3 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_3 + 0
					end
				end

				arg_218_1.text_.text = var_221_1
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_4 = math.max(var_221_0, arg_218_1.talkMaxDuration)

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_4 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - 0) / var_221_4

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play1101101054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 1101101054
		arg_222_1.duration_ = 9

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play1101101055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 2 < arg_222_1.time_ and arg_222_1.time_ <= 2 + arg_225_0 then
				local var_225_0 = arg_222_1.bgs_.D07

				arg_222_1.bgs_.D07.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_225_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_225_1 = var_225_0:GetComponent("SpriteRenderer")

				if var_225_1 and var_225_1.sprite then
					local var_225_2 = 2 * (var_225_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_225_0.transform.localScale = Vector3.New(var_225_2 / var_225_1.sprite.bounds.size.y < var_225_2 * manager.ui.mainCameraCom_.aspect / var_225_1.sprite.bounds.size.x and var_225_2 * manager.ui.mainCameraCom_.aspect / var_225_1.sprite.bounds.size.x or var_225_2 / var_225_1.sprite.bounds.size.y, var_225_2 / var_225_1.sprite.bounds.size.y < var_225_2 * manager.ui.mainCameraCom_.aspect / var_225_1.sprite.bounds.size.x and var_225_2 * manager.ui.mainCameraCom_.aspect / var_225_1.sprite.bounds.size.x or var_225_2 / var_225_1.sprite.bounds.size.y, 0)
				end

				for iter_225_0, iter_225_1 in pairs(arg_222_1.bgs_) do
					if iter_225_0 ~= "D07" then
						iter_225_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_225_3 = 0

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_3 + arg_225_0 then
				arg_222_1.mask_.enabled = true
				arg_222_1.mask_.raycastTarget = true

				arg_222_1:SetGaussion(false)
			end

			local var_225_4 = 2

			if var_225_3 <= arg_222_1.time_ and arg_222_1.time_ < var_225_3 + var_225_4 then
				local var_225_5 = Color.New(0, 0, 0)

				var_225_5.a = Mathf.Lerp(0, 1, (arg_222_1.time_ - var_225_3) / var_225_4)
				arg_222_1.mask_.color = var_225_5
			end

			if arg_222_1.time_ >= var_225_3 + var_225_4 and arg_222_1.time_ < var_225_3 + var_225_4 + arg_225_0 then
				local var_225_6 = Color.New(0, 0, 0)

				var_225_6.a = 1
				arg_222_1.mask_.color = var_225_6
			end

			local var_225_7 = 2

			if 2 < arg_222_1.time_ and arg_222_1.time_ <= var_225_7 + arg_225_0 then
				arg_222_1.mask_.enabled = true
				arg_222_1.mask_.raycastTarget = true

				arg_222_1:SetGaussion(false)
			end

			local var_225_8 = 2

			if var_225_7 <= arg_222_1.time_ and arg_222_1.time_ < var_225_7 + var_225_8 then
				local var_225_9 = Color.New(0, 0, 0)

				var_225_9.a = Mathf.Lerp(1, 0, (arg_222_1.time_ - var_225_7) / var_225_8)
				arg_222_1.mask_.color = var_225_9
			end

			if arg_222_1.time_ >= var_225_7 + var_225_8 and arg_222_1.time_ < var_225_7 + var_225_8 + arg_225_0 then
				local var_225_10 = Color.New(0, 0, 0)

				arg_222_1.mask_.enabled = false
				var_225_10.a = 0
				arg_222_1.mask_.color = var_225_10
			end

			if arg_222_1.frameCnt_ <= 1 then
				arg_222_1.dialog_:SetActive(false)
			end

			local var_225_11 = 4
			local var_225_12 = 0.525

			if 4 < arg_222_1.time_ and arg_222_1.time_ <= var_225_11 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0

				arg_222_1.dialog_:SetActive(true)

				arg_222_1.dialogCg_.alpha = 0

				local var_225_13 = LeanTween.value(arg_222_1.dialog_, 0, 1, 0.3)

				var_225_13:setOnUpdate(LuaHelper.FloatAction(function(arg_226_0)
					arg_222_1.dialogCg_.alpha = arg_226_0
				end))
				var_225_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_222_1.dialog_)
					var_225_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_222_1.duration_ = arg_222_1.duration_ + 0.3

				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_14 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(1101101054).content)

				arg_222_1.text_.text = var_225_14

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_16 = 21 <= 0 and var_225_12 or var_225_12 * (utf8.len(var_225_14) / 21)

				if (21 <= 0 and var_225_12 or var_225_12 * (utf8.len(var_225_14) / 21)) > 0 and var_225_12 < var_225_16 then
					arg_222_1.talkMaxDuration = var_225_16
					var_225_11 = var_225_11 + 0.3

					if var_225_16 + var_225_11 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_16 + var_225_11
					end
				end

				arg_222_1.text_.text = var_225_14
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_17 = var_225_11 + 0.3
			local var_225_18 = math.max(var_225_12, arg_222_1.talkMaxDuration)

			if var_225_11 + 0.3 <= arg_222_1.time_ and arg_222_1.time_ < var_225_17 + var_225_18 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_17) / var_225_18

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_17 + var_225_18 and arg_222_1.time_ < var_225_17 + var_225_18 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play1101101055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 1101101055
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play1101101056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0.925

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, false)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_1 = arg_228_1:FormatText(arg_228_1:GetWordFromCfg(1101101055).content)

				arg_228_1.text_.text = var_231_1

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_3 = 37 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_1) / 37)

				if (37 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_1) / 37)) > 0 and var_231_0 < var_231_3 then
					arg_228_1.talkMaxDuration = var_231_3

					if var_231_3 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_3 + 0
					end
				end

				arg_228_1.text_.text = var_231_1
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_4 = math.max(var_231_0, arg_228_1.talkMaxDuration)

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_4 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - 0) / var_231_4

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= 0 + var_231_4 and arg_228_1.time_ < 0 + var_231_4 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play1101101056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 1101101056
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play1101101057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos2017_tpose = arg_232_1.actors_["2017_tpose"].transform.localPosition

				local var_235_0 = GameObjectTools.GetOrAddComponent(arg_232_1.actors_["2017_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_235_0 then
					var_235_0:EnableDynamicBone(false)
				end
			end

			local var_235_1 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_1 then
				arg_232_1.actors_["2017_tpose"].transform.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos2017_tpose, Vector3.New(0, 100, 0), (arg_232_1.time_ - 0) / var_235_1)
				arg_232_1.actors_["2017_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["2017_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["2017_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["2017_tpose"].transform.position).z)
				arg_232_1.actors_["2017_tpose"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["2017_tpose"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["2017_tpose"].transform.localEulerAngles = arg_232_1.actors_["2017_tpose"].transform.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_1 and arg_232_1.time_ < 0 + var_235_1 + arg_235_0 then
				arg_232_1.actors_["2017_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_232_1.actors_["2017_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["2017_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["2017_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["2017_tpose"].transform.position).z)
				arg_232_1.actors_["2017_tpose"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["2017_tpose"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["2017_tpose"].transform.localEulerAngles = arg_232_1.actors_["2017_tpose"].transform.localEulerAngles

				local var_235_2 = GameObjectTools.GetOrAddComponent(arg_232_1.actors_["2017_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_235_2 then
					var_235_2:EnableDynamicBone(true)
				end
			end

			local var_235_3 = "2037_tpose"

			if arg_232_1.actors_["2037_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2037_tpose"))) then
				local var_235_4 = Object.Instantiate(Asset.Load("Char/" .. "2037_tpose"), arg_232_1.stage_.transform)

				var_235_4.name = var_235_3
				var_235_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_232_1.actors_[var_235_3] = var_235_4

				local var_235_5 = var_235_4:GetComponentInChildren(typeof(CharacterEffect))

				var_235_5.enabled = true

				local var_235_6 = GameObjectTools.GetOrAddComponent(var_235_4, typeof(DynamicBoneHelper))

				if var_235_6 then
					var_235_6:EnableDynamicBone(false)
				end

				arg_232_1:ShowWeapon(var_235_5.transform, false)

				arg_232_1.var_[var_235_3 .. "Animator"] = var_235_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_232_1.var_[var_235_3 .. "Animator"].applyRootMotion = true
				arg_232_1.var_[var_235_3 .. "LipSync"] = var_235_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_235_7 = arg_232_1.actors_["2037_tpose"].transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos2037_tpose = var_235_7.localPosition

				local var_235_8 = GameObjectTools.GetOrAddComponent(var_235_7.gameObject, typeof(DynamicBoneHelper))

				if var_235_8 then
					var_235_8:EnableDynamicBone(false)
				end
			end

			local var_235_9 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_9 then
				var_235_7.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos2037_tpose, Vector3.New(0, 100, 0), (arg_232_1.time_ - 0) / var_235_9)
				var_235_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_7.position).x, (manager.ui.mainCamera.transform.position - var_235_7.position).y, (manager.ui.mainCamera.transform.position - var_235_7.position).z)
				var_235_7.localEulerAngles.z = 0
				var_235_7.localEulerAngles.x = 0
				var_235_7.localEulerAngles = var_235_7.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_9 and arg_232_1.time_ < 0 + var_235_9 + arg_235_0 then
				var_235_7.localPosition = Vector3.New(0, 100, 0)
				var_235_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_7.position).x, (manager.ui.mainCamera.transform.position - var_235_7.position).y, (manager.ui.mainCamera.transform.position - var_235_7.position).z)
				var_235_7.localEulerAngles.z = 0
				var_235_7.localEulerAngles.x = 0
				var_235_7.localEulerAngles = var_235_7.localEulerAngles

				local var_235_10 = GameObjectTools.GetOrAddComponent(var_235_7.gameObject, typeof(DynamicBoneHelper))

				if var_235_10 then
					var_235_10:EnableDynamicBone(true)
				end
			end

			local var_235_11 = "2038_tpose"

			if arg_232_1.actors_["2038_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2038_tpose"))) then
				local var_235_12 = Object.Instantiate(Asset.Load("Char/" .. "2038_tpose"), arg_232_1.stage_.transform)

				var_235_12.name = var_235_11
				var_235_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_232_1.actors_[var_235_11] = var_235_12

				local var_235_13 = var_235_12:GetComponentInChildren(typeof(CharacterEffect))

				var_235_13.enabled = true

				local var_235_14 = GameObjectTools.GetOrAddComponent(var_235_12, typeof(DynamicBoneHelper))

				if var_235_14 then
					var_235_14:EnableDynamicBone(false)
				end

				arg_232_1:ShowWeapon(var_235_13.transform, false)

				arg_232_1.var_[var_235_11 .. "Animator"] = var_235_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_232_1.var_[var_235_11 .. "Animator"].applyRootMotion = true
				arg_232_1.var_[var_235_11 .. "LipSync"] = var_235_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_235_15 = arg_232_1.actors_["2038_tpose"].transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos2038_tpose = var_235_15.localPosition

				local var_235_16 = GameObjectTools.GetOrAddComponent(var_235_15.gameObject, typeof(DynamicBoneHelper))

				if var_235_16 then
					var_235_16:EnableDynamicBone(false)
				end
			end

			local var_235_17 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_17 then
				var_235_15.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos2038_tpose, Vector3.New(0, 100, 0), (arg_232_1.time_ - 0) / var_235_17)
				var_235_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_15.position).x, (manager.ui.mainCamera.transform.position - var_235_15.position).y, (manager.ui.mainCamera.transform.position - var_235_15.position).z)
				var_235_15.localEulerAngles.z = 0
				var_235_15.localEulerAngles.x = 0
				var_235_15.localEulerAngles = var_235_15.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_17 and arg_232_1.time_ < 0 + var_235_17 + arg_235_0 then
				var_235_15.localPosition = Vector3.New(0, 100, 0)
				var_235_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_15.position).x, (manager.ui.mainCamera.transform.position - var_235_15.position).y, (manager.ui.mainCamera.transform.position - var_235_15.position).z)
				var_235_15.localEulerAngles.z = 0
				var_235_15.localEulerAngles.x = 0
				var_235_15.localEulerAngles = var_235_15.localEulerAngles

				local var_235_18 = GameObjectTools.GetOrAddComponent(var_235_15.gameObject, typeof(DynamicBoneHelper))

				if var_235_18 then
					var_235_18:EnableDynamicBone(true)
				end
			end

			local var_235_19 = 0

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_19 + arg_235_0 then
				arg_232_1.mask_.enabled = true
				arg_232_1.mask_.raycastTarget = true

				arg_232_1:SetGaussion(false)
			end

			local var_235_20 = 1

			if var_235_19 <= arg_232_1.time_ and arg_232_1.time_ < var_235_19 + var_235_20 then
				local var_235_21 = Color.New(1, 1, 1)

				var_235_21.a = Mathf.Lerp(1, 0, (arg_232_1.time_ - var_235_19) / var_235_20)
				arg_232_1.mask_.color = var_235_21
			end

			if arg_232_1.time_ >= var_235_19 + var_235_20 and arg_232_1.time_ < var_235_19 + var_235_20 + arg_235_0 then
				local var_235_22 = Color.New(1, 1, 1)

				arg_232_1.mask_.enabled = false
				var_235_22.a = 0
				arg_232_1.mask_.color = var_235_22
			end

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1:AudioAction("play", "effect", "se_story_122_02", "se_story_122_02_hit", "")
			end

			local var_235_24 = 0
			local var_235_25 = 0.725

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_24 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_26 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(1101101056).content)

				arg_232_1.text_.text = var_235_26

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_28 = 29 <= 0 and var_235_25 or var_235_25 * (utf8.len(var_235_26) / 29)

				if (29 <= 0 and var_235_25 or var_235_25 * (utf8.len(var_235_26) / 29)) > 0 and var_235_25 < var_235_28 then
					arg_232_1.talkMaxDuration = var_235_28

					if var_235_28 + var_235_24 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_28 + var_235_24
					end
				end

				arg_232_1.text_.text = var_235_26
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_29 = math.max(var_235_25, arg_232_1.talkMaxDuration)

			if var_235_24 <= arg_232_1.time_ and arg_232_1.time_ < var_235_24 + var_235_29 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_24) / var_235_29

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_24 + var_235_29 and arg_232_1.time_ < var_235_24 + var_235_29 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2017_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2037_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2038_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play1101101057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 1101101057
		arg_236_1.duration_ = 4.53

		local var_236_0 = {
			zh = 4.533,
			ja = 4.2
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play1101101058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos1011ui_story = arg_236_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_239_0 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 then
				arg_236_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_236_1.time_ - 0) / var_239_0)
				arg_236_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1011ui_story"].transform.position).z)
				arg_236_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1011ui_story"].transform.localEulerAngles = arg_236_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 then
				arg_236_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_236_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1011ui_story"].transform.position).z)
				arg_236_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1011ui_story"].transform.localEulerAngles = arg_236_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_239_1 = arg_236_1.actors_["1011ui_story"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_1) and arg_236_1.var_.characterEffect1011ui_story == nil then
				arg_236_1.var_.characterEffect1011ui_story = var_239_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.200000002980232

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_2 and not isNil(var_239_1) then
				if arg_236_1.var_.characterEffect1011ui_story and not isNil(var_239_1) then
					arg_236_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= 0 + var_239_2 and arg_236_1.time_ < 0 + var_239_2 + arg_239_0 and not isNil(var_239_1) and arg_236_1.var_.characterEffect1011ui_story then
				arg_236_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_239_4 = 0
			local var_239_5 = 0.625

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_4 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_6 = arg_236_1:GetWordFromCfg(1101101057)
				local var_239_7 = arg_236_1:FormatText(var_239_6.content)

				arg_236_1.text_.text = var_239_7

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_9 = 25 <= 0 and var_239_5 or var_239_5 * (utf8.len(var_239_7) / 25)

				if (25 <= 0 and var_239_5 or var_239_5 * (utf8.len(var_239_7) / 25)) > 0 and var_239_5 < var_239_9 then
					arg_236_1.talkMaxDuration = var_239_9

					if var_239_9 + var_239_4 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_9 + var_239_4
					end
				end

				arg_236_1.text_.text = var_239_7
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101057", "story_v_side_new_1101101.awb") ~= 0 then
					local var_239_10 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101057", "story_v_side_new_1101101.awb") / 1000

					if var_239_10 + var_239_4 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_10 + var_239_4
					end

					if var_239_6.prefab_name ~= "" and arg_236_1.actors_[var_239_6.prefab_name] ~= nil then
						local var_239_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_6.prefab_name].transform, "story_v_side_new_1101101", "1101101057", "story_v_side_new_1101101.awb")

						arg_236_1:RecordAudio("1101101057", var_239_11)
						arg_236_1:RecordAudio("1101101057", var_239_11)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101057", "story_v_side_new_1101101.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101057", "story_v_side_new_1101101.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_12 = math.max(var_239_5, arg_236_1.talkMaxDuration)

			if var_239_4 <= arg_236_1.time_ and arg_236_1.time_ < var_239_4 + var_239_12 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_4) / var_239_12

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_4 + var_239_12 and arg_236_1.time_ < var_239_4 + var_239_12 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
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

		arg_236_1:InitPlayNodeList()
	end,
	Play1101101058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 1101101058
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play1101101059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos1011ui_story = arg_240_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_243_0 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 then
				arg_240_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_240_1.time_ - 0) / var_243_0)
				arg_240_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1011ui_story"].transform.position).z)
				arg_240_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["1011ui_story"].transform.localEulerAngles = arg_240_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 then
				arg_240_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_240_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1011ui_story"].transform.position).z)
				arg_240_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["1011ui_story"].transform.localEulerAngles = arg_240_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_243_1 = arg_240_1.bgs_.D07.transform

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPosD07 = var_243_1.localPosition
			end

			local var_243_2 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_2 then
				var_243_1.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPosD07, Vector3.New(0, 1, 10), (arg_240_1.time_ - 0) / var_243_2)
			end

			if arg_240_1.time_ >= 0 + var_243_2 and arg_240_1.time_ < 0 + var_243_2 + arg_243_0 then
				var_243_1.localPosition = Vector3.New(0, 1, 10)
			end

			local var_243_3 = arg_240_1.bgs_.D07.transform

			if 0.034 < arg_240_1.time_ and arg_240_1.time_ <= 0.034 + arg_243_0 then
				arg_240_1.var_.moveOldPosD07 = var_243_3.localPosition
			end

			local var_243_4 = 2

			if 0.034 <= arg_240_1.time_ and arg_240_1.time_ < 0.034 + var_243_4 then
				var_243_3.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPosD07, Vector3.New(0, 1, 7), (arg_240_1.time_ - 0.034) / var_243_4)
			end

			if arg_240_1.time_ >= 0.034 + var_243_4 and arg_240_1.time_ < 0.034 + var_243_4 + arg_243_0 then
				var_243_3.localPosition = Vector3.New(0, 1, 7)
			end

			local var_243_5 = 0
			local var_243_6 = 0.8

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_5 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_7 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(1101101058).content)

				arg_240_1.text_.text = var_243_7

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_9 = 32 <= 0 and var_243_6 or var_243_6 * (utf8.len(var_243_7) / 32)

				if (32 <= 0 and var_243_6 or var_243_6 * (utf8.len(var_243_7) / 32)) > 0 and var_243_6 < var_243_9 then
					arg_240_1.talkMaxDuration = var_243_9

					if var_243_9 + var_243_5 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_9 + var_243_5
					end
				end

				arg_240_1.text_.text = var_243_7
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_10 = math.max(var_243_6, arg_240_1.talkMaxDuration)

			if var_243_5 <= arg_240_1.time_ and arg_240_1.time_ < var_243_5 + var_243_10 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_5) / var_243_10

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_5 + var_243_10 and arg_240_1.time_ < var_243_5 + var_243_10 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "D07",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "D07",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play1101101059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 1101101059
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play1101101060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0.25

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_1 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(1101101059).content)

				arg_244_1.text_.text = var_247_1

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_3 = 10 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_1) / 10)

				if (10 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_1) / 10)) > 0 and var_247_0 < var_247_3 then
					arg_244_1.talkMaxDuration = var_247_3

					if var_247_3 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_3 + 0
					end
				end

				arg_244_1.text_.text = var_247_1
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_4 = math.max(var_247_0, arg_244_1.talkMaxDuration)

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_4 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - 0) / var_247_4

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= 0 + var_247_4 and arg_244_1.time_ < 0 + var_247_4 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play1101101060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 1101101060
		arg_248_1.duration_ = 2.07

		local var_248_0 = {
			zh = 2.066,
			ja = 1.999999999999
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play1101101061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos1011ui_story = arg_248_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_251_0 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 then
				arg_248_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_248_1.time_ - 0) / var_251_0)
				arg_248_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1011ui_story"].transform.position).z)
				arg_248_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1011ui_story"].transform.localEulerAngles = arg_248_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 then
				arg_248_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_248_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1011ui_story"].transform.position).z)
				arg_248_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1011ui_story"].transform.localEulerAngles = arg_248_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_251_1 = arg_248_1.actors_["1011ui_story"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_1) and arg_248_1.var_.characterEffect1011ui_story == nil then
				arg_248_1.var_.characterEffect1011ui_story = var_251_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_2 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_2 and not isNil(var_251_1) then
				if arg_248_1.var_.characterEffect1011ui_story and not isNil(var_251_1) then
					arg_248_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= 0 + var_251_2 and arg_248_1.time_ < 0 + var_251_2 + arg_251_0 and not isNil(var_251_1) and arg_248_1.var_.characterEffect1011ui_story then
				arg_248_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_251_4 = 0
			local var_251_5 = 0.25

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_4 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_6 = arg_248_1:GetWordFromCfg(1101101060)
				local var_251_7 = arg_248_1:FormatText(var_251_6.content)

				arg_248_1.text_.text = var_251_7

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_9 = 10 <= 0 and var_251_5 or var_251_5 * (utf8.len(var_251_7) / 10)

				if (10 <= 0 and var_251_5 or var_251_5 * (utf8.len(var_251_7) / 10)) > 0 and var_251_5 < var_251_9 then
					arg_248_1.talkMaxDuration = var_251_9

					if var_251_9 + var_251_4 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_9 + var_251_4
					end
				end

				arg_248_1.text_.text = var_251_7
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101060", "story_v_side_new_1101101.awb") ~= 0 then
					local var_251_10 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101060", "story_v_side_new_1101101.awb") / 1000

					if var_251_10 + var_251_4 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_10 + var_251_4
					end

					if var_251_6.prefab_name ~= "" and arg_248_1.actors_[var_251_6.prefab_name] ~= nil then
						local var_251_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_6.prefab_name].transform, "story_v_side_new_1101101", "1101101060", "story_v_side_new_1101101.awb")

						arg_248_1:RecordAudio("1101101060", var_251_11)
						arg_248_1:RecordAudio("1101101060", var_251_11)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101060", "story_v_side_new_1101101.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101060", "story_v_side_new_1101101.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_12 = math.max(var_251_5, arg_248_1.talkMaxDuration)

			if var_251_4 <= arg_248_1.time_ and arg_248_1.time_ < var_251_4 + var_251_12 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_4) / var_251_12

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_4 + var_251_12 and arg_248_1.time_ < var_251_4 + var_251_12 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
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

		arg_248_1:InitPlayNodeList()
	end,
	Play1101101061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 1101101061
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play1101101062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos1011ui_story = arg_252_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_255_0 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 then
				arg_252_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_252_1.time_ - 0) / var_255_0)
				arg_252_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1011ui_story"].transform.position).z)
				arg_252_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["1011ui_story"].transform.localEulerAngles = arg_252_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 then
				arg_252_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_252_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1011ui_story"].transform.position).z)
				arg_252_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["1011ui_story"].transform.localEulerAngles = arg_252_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_255_1 = 0
			local var_255_2 = 0.975

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_3 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(1101101061).content)

				arg_252_1.text_.text = var_255_3

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_5 = 39 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_3) / 39)

				if (39 <= 0 and var_255_2 or var_255_2 * (utf8.len(var_255_3) / 39)) > 0 and var_255_2 < var_255_5 then
					arg_252_1.talkMaxDuration = var_255_5

					if var_255_5 + var_255_1 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_5 + var_255_1
					end
				end

				arg_252_1.text_.text = var_255_3
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_6 = math.max(var_255_2, arg_252_1.talkMaxDuration)

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_6 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_1) / var_255_6

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_1 + var_255_6 and arg_252_1.time_ < var_255_1 + var_255_6 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
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

		arg_252_1:InitPlayNodeList()
	end,
	Play1101101062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 1101101062
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play1101101063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 0.975

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_1 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(1101101062).content)

				arg_256_1.text_.text = var_259_1

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_3 = 39 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_1) / 39)

				if (39 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_1) / 39)) > 0 and var_259_0 < var_259_3 then
					arg_256_1.talkMaxDuration = var_259_3

					if var_259_3 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_3 + 0
					end
				end

				arg_256_1.text_.text = var_259_1
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_4 = math.max(var_259_0, arg_256_1.talkMaxDuration)

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_4 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - 0) / var_259_4

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= 0 + var_259_4 and arg_256_1.time_ < 0 + var_259_4 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play1101101063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 1101101063
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play1101101064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0.625

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_1 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(1101101063).content)

				arg_260_1.text_.text = var_263_1

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_3 = 25 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_1) / 25)

				if (25 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_1) / 25)) > 0 and var_263_0 < var_263_3 then
					arg_260_1.talkMaxDuration = var_263_3

					if var_263_3 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_3 + 0
					end
				end

				arg_260_1.text_.text = var_263_1
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_4 = math.max(var_263_0, arg_260_1.talkMaxDuration)

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_4 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - 0) / var_263_4

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= 0 + var_263_4 and arg_260_1.time_ < 0 + var_263_4 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play1101101064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 1101101064
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play1101101065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 1.05

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, true)
				arg_264_1.iconController_:SetSelectedState("hero")

				arg_264_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_264_1.callingController_:SetSelectedState("normal")

				arg_264_1.keyicon_.color = Color.New(1, 1, 1)
				arg_264_1.icon_.color = Color.New(1, 1, 1)

				local var_267_1 = arg_264_1:FormatText(arg_264_1:GetWordFromCfg(1101101064).content)

				arg_264_1.text_.text = var_267_1

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_3 = 42 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_1) / 42)

				if (42 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_1) / 42)) > 0 and var_267_0 < var_267_3 then
					arg_264_1.talkMaxDuration = var_267_3

					if var_267_3 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_3 + 0
					end
				end

				arg_264_1.text_.text = var_267_1
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_4 = math.max(var_267_0, arg_264_1.talkMaxDuration)

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_4 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - 0) / var_267_4

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= 0 + var_267_4 and arg_264_1.time_ < 0 + var_267_4 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play1101101065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 1101101065
		arg_268_1.duration_ = 2.63

		local var_268_0 = {
			zh = 2.633,
			ja = 2.333
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
				arg_268_0:Play1101101066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.var_.moveOldPos1011ui_story = arg_268_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_271_0 = 0.001

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 then
				arg_268_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_268_1.time_ - 0) / var_271_0)
				arg_268_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_268_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1011ui_story"].transform.position).z)
				arg_268_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_268_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_268_1.actors_["1011ui_story"].transform.localEulerAngles = arg_268_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 then
				arg_268_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_268_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_268_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_268_1.actors_["1011ui_story"].transform.position).z)
				arg_268_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_268_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_268_1.actors_["1011ui_story"].transform.localEulerAngles = arg_268_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_271_1 = arg_268_1.actors_["1011ui_story"]

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(var_271_1) and arg_268_1.var_.characterEffect1011ui_story == nil then
				arg_268_1.var_.characterEffect1011ui_story = var_271_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_2 = 0.200000002980232

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_2 and not isNil(var_271_1) then
				if arg_268_1.var_.characterEffect1011ui_story and not isNil(var_271_1) then
					arg_268_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_268_1.time_ >= 0 + var_271_2 and arg_268_1.time_ < 0 + var_271_2 + arg_271_0 and not isNil(var_271_1) and arg_268_1.var_.characterEffect1011ui_story then
				arg_268_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_271_4 = 0
			local var_271_5 = 0.175

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_4 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_6 = arg_268_1:GetWordFromCfg(1101101065)
				local var_271_7 = arg_268_1:FormatText(var_271_6.content)

				arg_268_1.text_.text = var_271_7

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_9 = 7 <= 0 and var_271_5 or var_271_5 * (utf8.len(var_271_7) / 7)

				if (7 <= 0 and var_271_5 or var_271_5 * (utf8.len(var_271_7) / 7)) > 0 and var_271_5 < var_271_9 then
					arg_268_1.talkMaxDuration = var_271_9

					if var_271_9 + var_271_4 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_9 + var_271_4
					end
				end

				arg_268_1.text_.text = var_271_7
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101065", "story_v_side_new_1101101.awb") ~= 0 then
					local var_271_10 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101065", "story_v_side_new_1101101.awb") / 1000

					if var_271_10 + var_271_4 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_10 + var_271_4
					end

					if var_271_6.prefab_name ~= "" and arg_268_1.actors_[var_271_6.prefab_name] ~= nil then
						local var_271_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_6.prefab_name].transform, "story_v_side_new_1101101", "1101101065", "story_v_side_new_1101101.awb")

						arg_268_1:RecordAudio("1101101065", var_271_11)
						arg_268_1:RecordAudio("1101101065", var_271_11)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101065", "story_v_side_new_1101101.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101065", "story_v_side_new_1101101.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_12 = math.max(var_271_5, arg_268_1.talkMaxDuration)

			if var_271_4 <= arg_268_1.time_ and arg_268_1.time_ < var_271_4 + var_271_12 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_4) / var_271_12

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_4 + var_271_12 and arg_268_1.time_ < var_271_4 + var_271_12 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
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

		arg_268_1:InitPlayNodeList()
	end,
	Play1101101066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 1101101066
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play1101101067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.moveOldPos1011ui_story = arg_272_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_275_0 = 0.001

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 then
				arg_272_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_272_1.time_ - 0) / var_275_0)
				arg_272_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_272_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1011ui_story"].transform.position).z)
				arg_272_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_272_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_272_1.actors_["1011ui_story"].transform.localEulerAngles = arg_272_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 then
				arg_272_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_272_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_272_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1011ui_story"].transform.position).z)
				arg_272_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_272_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_272_1.actors_["1011ui_story"].transform.localEulerAngles = arg_272_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_275_1 = 0
			local var_275_2 = 0.925

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, false)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_3 = arg_272_1:FormatText(arg_272_1:GetWordFromCfg(1101101066).content)

				arg_272_1.text_.text = var_275_3

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_5 = 39 <= 0 and var_275_2 or var_275_2 * (utf8.len(var_275_3) / 39)

				if (39 <= 0 and var_275_2 or var_275_2 * (utf8.len(var_275_3) / 39)) > 0 and var_275_2 < var_275_5 then
					arg_272_1.talkMaxDuration = var_275_5

					if var_275_5 + var_275_1 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_5 + var_275_1
					end
				end

				arg_272_1.text_.text = var_275_3
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_6 = math.max(var_275_2, arg_272_1.talkMaxDuration)

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_6 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_1) / var_275_6

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_1 + var_275_6 and arg_272_1.time_ < var_275_1 + var_275_6 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
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

		arg_272_1:InitPlayNodeList()
	end,
	Play1101101067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 1101101067
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play1101101068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:AudioAction("play", "effect", "se_story_10", "se_story_10_sword04", "se_story_10.awb")
			end

			local var_279_1 = 0

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.mask_.enabled = true
				arg_276_1.mask_.raycastTarget = true

				arg_276_1:SetGaussion(false)
			end

			local var_279_2 = 1

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_2 then
				local var_279_3 = Color.New(1, 1, 1)

				var_279_3.a = Mathf.Lerp(1, 0, (arg_276_1.time_ - var_279_1) / var_279_2)
				arg_276_1.mask_.color = var_279_3
			end

			if arg_276_1.time_ >= var_279_1 + var_279_2 and arg_276_1.time_ < var_279_1 + var_279_2 + arg_279_0 then
				local var_279_4 = Color.New(1, 1, 1)

				arg_276_1.mask_.enabled = false
				var_279_4.a = 0
				arg_276_1.mask_.color = var_279_4
			end

			local var_279_5 = 0
			local var_279_6 = 0.05

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_5 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0

				arg_276_1.dialog_:SetActive(true)

				arg_276_1.dialogCg_.alpha = 0

				local var_279_7 = LeanTween.value(arg_276_1.dialog_, 0, 1, 0.3)

				var_279_7:setOnUpdate(LuaHelper.FloatAction(function(arg_280_0)
					arg_276_1.dialogCg_.alpha = arg_280_0
				end))
				var_279_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_276_1.dialog_)
					var_279_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_276_1.duration_ = arg_276_1.duration_ + 0.3

				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_8 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(1101101067).content)

				arg_276_1.text_.text = var_279_8

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_10 = 2 <= 0 and var_279_6 or var_279_6 * (utf8.len(var_279_8) / 2)

				if (2 <= 0 and var_279_6 or var_279_6 * (utf8.len(var_279_8) / 2)) > 0 and var_279_6 < var_279_10 then
					arg_276_1.talkMaxDuration = var_279_10
					var_279_5 = var_279_5 + 0.3

					if var_279_10 + var_279_5 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_10 + var_279_5
					end
				end

				arg_276_1.text_.text = var_279_8
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_11 = var_279_5 + 0.3
			local var_279_12 = math.max(var_279_6, arg_276_1.talkMaxDuration)

			if var_279_5 + 0.3 <= arg_276_1.time_ and arg_276_1.time_ < var_279_11 + var_279_12 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_11) / var_279_12

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_11 + var_279_12 and arg_276_1.time_ < var_279_11 + var_279_12 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play1101101068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 1101101068
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play1101101069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 1.125

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_1 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(1101101068).content)

				arg_282_1.text_.text = var_285_1

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_3 = 45 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 45)

				if (45 <= 0 and var_285_0 or var_285_0 * (utf8.len(var_285_1) / 45)) > 0 and var_285_0 < var_285_3 then
					arg_282_1.talkMaxDuration = var_285_3

					if var_285_3 + 0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_3 + 0
					end
				end

				arg_282_1.text_.text = var_285_1
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_4 = math.max(var_285_0, arg_282_1.talkMaxDuration)

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_4 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - 0) / var_285_4

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= 0 + var_285_4 and arg_282_1.time_ < 0 + var_285_4 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play1101101069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 1101101069
		arg_286_1.duration_ = 4.1

		local var_286_0 = {
			zh = 4.033,
			ja = 4.1
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play1101101070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0.5

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_1 = arg_286_1:GetWordFromCfg(1101101069)
				local var_289_2 = arg_286_1:FormatText(var_289_1.content)

				arg_286_1.text_.text = var_289_2

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_4 = 20 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_2) / 20)

				if (20 <= 0 and var_289_0 or var_289_0 * (utf8.len(var_289_2) / 20)) > 0 and var_289_0 < var_289_4 then
					arg_286_1.talkMaxDuration = var_289_4

					if var_289_4 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_4 + 0
					end
				end

				arg_286_1.text_.text = var_289_2
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101069", "story_v_side_new_1101101.awb") ~= 0 then
					local var_289_5 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101069", "story_v_side_new_1101101.awb") / 1000

					if var_289_5 + 0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_5 + 0
					end

					if var_289_1.prefab_name ~= "" and arg_286_1.actors_[var_289_1.prefab_name] ~= nil then
						local var_289_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_1.prefab_name].transform, "story_v_side_new_1101101", "1101101069", "story_v_side_new_1101101.awb")

						arg_286_1:RecordAudio("1101101069", var_289_6)
						arg_286_1:RecordAudio("1101101069", var_289_6)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101069", "story_v_side_new_1101101.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101069", "story_v_side_new_1101101.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_7 = math.max(var_289_0, arg_286_1.talkMaxDuration)

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_7 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - 0) / var_289_7

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= 0 + var_289_7 and arg_286_1.time_ < 0 + var_289_7 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play1101101070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 1101101070
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play1101101071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["1011ui_story"]) and arg_290_1.var_.characterEffect1011ui_story == nil then
				arg_290_1.var_.characterEffect1011ui_story = arg_290_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_0 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["1011ui_story"]) then
				if arg_290_1.var_.characterEffect1011ui_story and not isNil(arg_290_1.actors_["1011ui_story"]) then
					arg_290_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_290_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_290_1.time_ - 0) / var_293_0)
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["1011ui_story"]) and arg_290_1.var_.characterEffect1011ui_story then
				arg_290_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_290_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_293_1 = 0
			local var_293_2 = 0.1

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_3 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(1101101070).content)

				arg_290_1.text_.text = var_293_3

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_5 = 4 <= 0 and var_293_2 or var_293_2 * (utf8.len(var_293_3) / 4)

				if (4 <= 0 and var_293_2 or var_293_2 * (utf8.len(var_293_3) / 4)) > 0 and var_293_2 < var_293_5 then
					arg_290_1.talkMaxDuration = var_293_5

					if var_293_5 + var_293_1 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_5 + var_293_1
					end
				end

				arg_290_1.text_.text = var_293_3
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_6 = math.max(var_293_2, arg_290_1.talkMaxDuration)

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_6 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_1) / var_293_6

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_1 + var_293_6 and arg_290_1.time_ < var_293_1 + var_293_6 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play1101101071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 1101101071
		arg_294_1.duration_ = 11

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play1101101072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if arg_294_1.bgs_.D05 == nil then
				local var_297_0 = Object.Instantiate(arg_294_1.paintGo_)

				var_297_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "D05")
				var_297_0.name = "D05"
				var_297_0.transform.parent = arg_294_1.stage_.transform
				var_297_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_294_1.bgs_.D05 = var_297_0
			end

			if 3 < arg_294_1.time_ and arg_294_1.time_ <= 3 + arg_297_0 then
				local var_297_1 = arg_294_1.bgs_.D05

				arg_294_1.bgs_.D05.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_297_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_297_2 = var_297_1:GetComponent("SpriteRenderer")

				if var_297_2 and var_297_2.sprite then
					local var_297_3 = 2 * (var_297_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_297_1.transform.localScale = Vector3.New(var_297_3 / var_297_2.sprite.bounds.size.y < var_297_3 * manager.ui.mainCameraCom_.aspect / var_297_2.sprite.bounds.size.x and var_297_3 * manager.ui.mainCameraCom_.aspect / var_297_2.sprite.bounds.size.x or var_297_3 / var_297_2.sprite.bounds.size.y, var_297_3 / var_297_2.sprite.bounds.size.y < var_297_3 * manager.ui.mainCameraCom_.aspect / var_297_2.sprite.bounds.size.x and var_297_3 * manager.ui.mainCameraCom_.aspect / var_297_2.sprite.bounds.size.x or var_297_3 / var_297_2.sprite.bounds.size.y, 0)
				end

				for iter_297_0, iter_297_1 in pairs(arg_294_1.bgs_) do
					if iter_297_0 ~= "D05" then
						iter_297_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_297_4 = 0

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_4 + arg_297_0 then
				arg_294_1.mask_.enabled = true
				arg_294_1.mask_.raycastTarget = true

				arg_294_1:SetGaussion(false)
			end

			local var_297_5 = 3

			if var_297_4 <= arg_294_1.time_ and arg_294_1.time_ < var_297_4 + var_297_5 then
				local var_297_6 = Color.New(0, 0, 0)

				var_297_6.a = Mathf.Lerp(0, 1, (arg_294_1.time_ - var_297_4) / var_297_5)
				arg_294_1.mask_.color = var_297_6
			end

			if arg_294_1.time_ >= var_297_4 + var_297_5 and arg_294_1.time_ < var_297_4 + var_297_5 + arg_297_0 then
				local var_297_7 = Color.New(0, 0, 0)

				var_297_7.a = 1
				arg_294_1.mask_.color = var_297_7
			end

			local var_297_8 = 3

			if 3 < arg_294_1.time_ and arg_294_1.time_ <= var_297_8 + arg_297_0 then
				arg_294_1.mask_.enabled = true
				arg_294_1.mask_.raycastTarget = true

				arg_294_1:SetGaussion(false)
			end

			local var_297_9 = 3

			if var_297_8 <= arg_294_1.time_ and arg_294_1.time_ < var_297_8 + var_297_9 then
				local var_297_10 = Color.New(0, 0, 0)

				var_297_10.a = Mathf.Lerp(1, 0, (arg_294_1.time_ - var_297_8) / var_297_9)
				arg_294_1.mask_.color = var_297_10
			end

			if arg_294_1.time_ >= var_297_8 + var_297_9 and arg_294_1.time_ < var_297_8 + var_297_9 + arg_297_0 then
				local var_297_11 = Color.New(0, 0, 0)

				arg_294_1.mask_.enabled = false
				var_297_11.a = 0
				arg_294_1.mask_.color = var_297_11
			end

			if arg_294_1.frameCnt_ <= 1 then
				arg_294_1.dialog_:SetActive(false)
			end

			local var_297_12 = 6
			local var_297_13 = 0.75

			if 6 < arg_294_1.time_ and arg_294_1.time_ <= var_297_12 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0

				arg_294_1.dialog_:SetActive(true)

				arg_294_1.dialogCg_.alpha = 0

				local var_297_14 = LeanTween.value(arg_294_1.dialog_, 0, 1, 0.3)

				var_297_14:setOnUpdate(LuaHelper.FloatAction(function(arg_298_0)
					arg_294_1.dialogCg_.alpha = arg_298_0
				end))
				var_297_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_294_1.dialog_)
					var_297_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_294_1.duration_ = arg_294_1.duration_ + 0.3

				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_15 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(1101101071).content)

				arg_294_1.text_.text = var_297_15

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_17 = 30 <= 0 and var_297_13 or var_297_13 * (utf8.len(var_297_15) / 30)

				if (30 <= 0 and var_297_13 or var_297_13 * (utf8.len(var_297_15) / 30)) > 0 and var_297_13 < var_297_17 then
					arg_294_1.talkMaxDuration = var_297_17
					var_297_12 = var_297_12 + 0.3

					if var_297_17 + var_297_12 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_17 + var_297_12
					end
				end

				arg_294_1.text_.text = var_297_15
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_18 = var_297_12 + 0.3
			local var_297_19 = math.max(var_297_13, arg_294_1.talkMaxDuration)

			if var_297_12 + 0.3 <= arg_294_1.time_ and arg_294_1.time_ < var_297_18 + var_297_19 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_18) / var_297_19

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_18 + var_297_19 and arg_294_1.time_ < var_297_18 + var_297_19 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play1101101072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 1101101072
		arg_300_1.duration_ = 6.47

		local var_300_0 = {
			zh = 5.999999999999,
			ja = 6.466
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play1101101073(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 2 < arg_300_1.time_ and arg_300_1.time_ <= 2 + arg_303_0 then
				local var_303_0 = arg_300_1.bgs_.A00

				arg_300_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_303_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_303_1 = var_303_0:GetComponent("SpriteRenderer")

				if var_303_1 and var_303_1.sprite then
					local var_303_2 = 2 * (var_303_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_303_0.transform.localScale = Vector3.New(var_303_2 / var_303_1.sprite.bounds.size.y < var_303_2 * manager.ui.mainCameraCom_.aspect / var_303_1.sprite.bounds.size.x and var_303_2 * manager.ui.mainCameraCom_.aspect / var_303_1.sprite.bounds.size.x or var_303_2 / var_303_1.sprite.bounds.size.y, var_303_2 / var_303_1.sprite.bounds.size.y < var_303_2 * manager.ui.mainCameraCom_.aspect / var_303_1.sprite.bounds.size.x and var_303_2 * manager.ui.mainCameraCom_.aspect / var_303_1.sprite.bounds.size.x or var_303_2 / var_303_1.sprite.bounds.size.y, 0)
				end

				for iter_303_0, iter_303_1 in pairs(arg_300_1.bgs_) do
					if iter_303_0 ~= "A00" then
						iter_303_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_303_3 = 0

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_3 + arg_303_0 then
				arg_300_1.mask_.enabled = true
				arg_300_1.mask_.raycastTarget = true

				arg_300_1:SetGaussion(false)
			end

			local var_303_4 = 2

			if var_303_3 <= arg_300_1.time_ and arg_300_1.time_ < var_303_3 + var_303_4 then
				local var_303_5 = Color.New(0, 0, 0)

				var_303_5.a = Mathf.Lerp(0, 1, (arg_300_1.time_ - var_303_3) / var_303_4)
				arg_300_1.mask_.color = var_303_5
			end

			if arg_300_1.time_ >= var_303_3 + var_303_4 and arg_300_1.time_ < var_303_3 + var_303_4 + arg_303_0 then
				local var_303_6 = Color.New(0, 0, 0)

				var_303_6.a = 1
				arg_300_1.mask_.color = var_303_6
			end

			local var_303_7 = 2

			if 2 < arg_300_1.time_ and arg_300_1.time_ <= var_303_7 + arg_303_0 then
				arg_300_1.mask_.enabled = true
				arg_300_1.mask_.raycastTarget = true

				arg_300_1:SetGaussion(false)
			end

			local var_303_8 = 2

			if var_303_7 <= arg_300_1.time_ and arg_300_1.time_ < var_303_7 + var_303_8 then
				local var_303_9 = Color.New(0, 0, 0)

				var_303_9.a = Mathf.Lerp(1, 0, (arg_300_1.time_ - var_303_7) / var_303_8)
				arg_300_1.mask_.color = var_303_9
			end

			if arg_300_1.time_ >= var_303_7 + var_303_8 and arg_300_1.time_ < var_303_7 + var_303_8 + arg_303_0 then
				local var_303_10 = Color.New(0, 0, 0)

				arg_300_1.mask_.enabled = false
				var_303_10.a = 0
				arg_300_1.mask_.color = var_303_10
			end

			local var_303_11 = arg_300_1.actors_["1011ui_story"].transform

			if 4 < arg_300_1.time_ and arg_300_1.time_ <= 4 + arg_303_0 then
				arg_300_1.var_.moveOldPos1011ui_story = var_303_11.localPosition
			end

			local var_303_12 = 0.001

			if 4 <= arg_300_1.time_ and arg_300_1.time_ < 4 + var_303_12 then
				var_303_11.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_300_1.time_ - 4) / var_303_12)
				var_303_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_303_11.position).x, (manager.ui.mainCamera.transform.position - var_303_11.position).y, (manager.ui.mainCamera.transform.position - var_303_11.position).z)
				var_303_11.localEulerAngles.z = 0
				var_303_11.localEulerAngles.x = 0
				var_303_11.localEulerAngles = var_303_11.localEulerAngles
			end

			if arg_300_1.time_ >= 4 + var_303_12 and arg_300_1.time_ < 4 + var_303_12 + arg_303_0 then
				var_303_11.localPosition = Vector3.New(0, -0.71, -6)
				var_303_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_303_11.position).x, (manager.ui.mainCamera.transform.position - var_303_11.position).y, (manager.ui.mainCamera.transform.position - var_303_11.position).z)
				var_303_11.localEulerAngles.z = 0
				var_303_11.localEulerAngles.x = 0
				var_303_11.localEulerAngles = var_303_11.localEulerAngles
			end

			local var_303_13 = arg_300_1.actors_["1011ui_story"]

			if 4 < arg_300_1.time_ and arg_300_1.time_ <= 4 + arg_303_0 and not isNil(var_303_13) and arg_300_1.var_.characterEffect1011ui_story == nil then
				arg_300_1.var_.characterEffect1011ui_story = var_303_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_14 = 0.200000002980232

			if 4 <= arg_300_1.time_ and arg_300_1.time_ < 4 + var_303_14 and not isNil(var_303_13) then
				if arg_300_1.var_.characterEffect1011ui_story and not isNil(var_303_13) then
					arg_300_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= 4 + var_303_14 and arg_300_1.time_ < 4 + var_303_14 + arg_303_0 and not isNil(var_303_13) and arg_300_1.var_.characterEffect1011ui_story then
				arg_300_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 4 < arg_300_1.time_ and arg_300_1.time_ <= 4 + arg_303_0 then
				arg_300_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			if 4 < arg_300_1.time_ and arg_300_1.time_ <= 4 + arg_303_0 then
				arg_300_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_1")
			end

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_303_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_300_1.bgmTxt_.text ~= var_303_18 and arg_300_1.bgmTxt_.text ~= "" then
						if arg_300_1.bgmTxt2_.text ~= "" then
							arg_300_1.bgmTxt_.text = arg_300_1.bgmTxt2_.text
						end

						arg_300_1.bgmTxt2_.text = var_303_18

						arg_300_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_300_1.bgmTxt_.text = var_303_18
						arg_300_1.bgmTxt2_.text = var_303_18
					end

					if arg_300_1.bgmTimer then
						arg_300_1.bgmTimer:Stop()

						arg_300_1.bgmTimer = nil
					end

					if arg_300_1.settingData.show_music_name == 1 then
						arg_300_1.musicController:SetSelectedState("show")
						arg_300_1.musicAnimator_:Play("open", 0, 0)

						if arg_300_1.settingData.music_time ~= 0 then
							arg_300_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_300_1.settingData.music_time), function()
								if arg_300_1 == nil or isNil(arg_300_1.bgmTxt_) then
									return
								end

								arg_300_1.musicController:SetSelectedState("hide")
								arg_300_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_300_1.frameCnt_ <= 1 then
				arg_300_1.dialog_:SetActive(false)
			end

			local var_303_19 = 4
			local var_303_20 = 0.1

			if 4 < arg_300_1.time_ and arg_300_1.time_ <= var_303_19 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0

				arg_300_1.dialog_:SetActive(true)

				arg_300_1.dialogCg_.alpha = 0

				local var_303_21 = LeanTween.value(arg_300_1.dialog_, 0, 1, 0.3)

				var_303_21:setOnUpdate(LuaHelper.FloatAction(function(arg_305_0)
					arg_300_1.dialogCg_.alpha = arg_305_0
				end))
				var_303_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_300_1.dialog_)
					var_303_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_300_1.duration_ = arg_300_1.duration_ + 0.3

				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[580].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_22 = arg_300_1:GetWordFromCfg(1101101072)
				local var_303_23 = arg_300_1:FormatText(var_303_22.content)

				arg_300_1.text_.text = var_303_23

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_25 = 4 <= 0 and var_303_20 or var_303_20 * (utf8.len(var_303_23) / 4)

				if (4 <= 0 and var_303_20 or var_303_20 * (utf8.len(var_303_23) / 4)) > 0 and var_303_20 < var_303_25 then
					arg_300_1.talkMaxDuration = var_303_25
					var_303_19 = var_303_19 + 0.3

					if var_303_25 + var_303_19 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_25 + var_303_19
					end
				end

				arg_300_1.text_.text = var_303_23
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101072", "story_v_side_new_1101101.awb") ~= 0 then
					local var_303_26 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101072", "story_v_side_new_1101101.awb") / 1000

					if var_303_26 + var_303_19 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_26 + var_303_19
					end

					if var_303_22.prefab_name ~= "" and arg_300_1.actors_[var_303_22.prefab_name] ~= nil then
						local var_303_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_22.prefab_name].transform, "story_v_side_new_1101101", "1101101072", "story_v_side_new_1101101.awb")

						arg_300_1:RecordAudio("1101101072", var_303_27)
						arg_300_1:RecordAudio("1101101072", var_303_27)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101072", "story_v_side_new_1101101.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101072", "story_v_side_new_1101101.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_28 = var_303_19 + 0.3
			local var_303_29 = math.max(var_303_20, arg_300_1.talkMaxDuration)

			if var_303_19 + 0.3 <= arg_300_1.time_ and arg_300_1.time_ < var_303_28 + var_303_29 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_28) / var_303_29

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_28 + var_303_29 and arg_300_1.time_ < var_303_28 + var_303_29 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play1101101073 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 1101101073
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play1101101074(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["1011ui_story"]) and arg_307_1.var_.characterEffect1011ui_story == nil then
				arg_307_1.var_.characterEffect1011ui_story = arg_307_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["1011ui_story"]) then
				if arg_307_1.var_.characterEffect1011ui_story and not isNil(arg_307_1.actors_["1011ui_story"]) then
					arg_307_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_307_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_307_1.time_ - 0) / var_310_0)
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["1011ui_story"]) and arg_307_1.var_.characterEffect1011ui_story then
				arg_307_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_307_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:AudioAction("play", "effect", "bgm_side_daily01", "bgm_side_daily01", "bgm_side_daily01.awb")
			end

			local var_310_2 = 0
			local var_310_3 = 0.4

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_2 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_4 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(1101101073).content)

				arg_307_1.text_.text = var_310_4

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_6 = 16 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_4) / 16)

				if (16 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_4) / 16)) > 0 and var_310_3 < var_310_6 then
					arg_307_1.talkMaxDuration = var_310_6

					if var_310_6 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_6 + var_310_2
					end
				end

				arg_307_1.text_.text = var_310_4
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_7 = math.max(var_310_3, arg_307_1.talkMaxDuration)

			if var_310_2 <= arg_307_1.time_ and arg_307_1.time_ < var_310_2 + var_310_7 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_2) / var_310_7

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_2 + var_310_7 and arg_307_1.time_ < var_310_2 + var_310_7 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play1101101074 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 1101101074
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play1101101075(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.675

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_1 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(1101101074).content)

				arg_311_1.text_.text = var_314_1

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_3 = 27 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 27)

				if (27 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 27)) > 0 and var_314_0 < var_314_3 then
					arg_311_1.talkMaxDuration = var_314_3

					if var_314_3 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_3 + 0
					end
				end

				arg_311_1.text_.text = var_314_1
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_4 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_4 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_4

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_4 and arg_311_1.time_ < 0 + var_314_4 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play1101101075 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 1101101075
		arg_315_1.duration_ = 5.87

		local var_315_0 = {
			zh = 5.866,
			ja = 5.033
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
				arg_315_0:Play1101101076(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos1011ui_story = arg_315_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_318_0 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 then
				arg_315_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_315_1.time_ - 0) / var_318_0)
				arg_315_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1011ui_story"].transform.position).z)
				arg_315_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["1011ui_story"].transform.localEulerAngles = arg_315_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 then
				arg_315_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_315_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_315_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_315_1.actors_["1011ui_story"].transform.position).z)
				arg_315_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_315_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_315_1.actors_["1011ui_story"].transform.localEulerAngles = arg_315_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_318_1 = arg_315_1.actors_["1011ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect1011ui_story == nil then
				arg_315_1.var_.characterEffect1011ui_story = var_318_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_2 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_2 and not isNil(var_318_1) then
				if arg_315_1.var_.characterEffect1011ui_story and not isNil(var_318_1) then
					arg_315_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= 0 + var_318_2 and arg_315_1.time_ < 0 + var_318_2 + arg_318_0 and not isNil(var_318_1) and arg_315_1.var_.characterEffect1011ui_story then
				arg_315_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action4_2")
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_318_4 = 0
			local var_318_5 = 0.675

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_4 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_6 = arg_315_1:GetWordFromCfg(1101101075)
				local var_318_7 = arg_315_1:FormatText(var_318_6.content)

				arg_315_1.text_.text = var_318_7

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_9 = 27 <= 0 and var_318_5 or var_318_5 * (utf8.len(var_318_7) / 27)

				if (27 <= 0 and var_318_5 or var_318_5 * (utf8.len(var_318_7) / 27)) > 0 and var_318_5 < var_318_9 then
					arg_315_1.talkMaxDuration = var_318_9

					if var_318_9 + var_318_4 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_9 + var_318_4
					end
				end

				arg_315_1.text_.text = var_318_7
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101075", "story_v_side_new_1101101.awb") ~= 0 then
					local var_318_10 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101075", "story_v_side_new_1101101.awb") / 1000

					if var_318_10 + var_318_4 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_10 + var_318_4
					end

					if var_318_6.prefab_name ~= "" and arg_315_1.actors_[var_318_6.prefab_name] ~= nil then
						local var_318_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_6.prefab_name].transform, "story_v_side_new_1101101", "1101101075", "story_v_side_new_1101101.awb")

						arg_315_1:RecordAudio("1101101075", var_318_11)
						arg_315_1:RecordAudio("1101101075", var_318_11)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101075", "story_v_side_new_1101101.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101075", "story_v_side_new_1101101.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_12 = math.max(var_318_5, arg_315_1.talkMaxDuration)

			if var_318_4 <= arg_315_1.time_ and arg_315_1.time_ < var_318_4 + var_318_12 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_4) / var_318_12

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_4 + var_318_12 and arg_315_1.time_ < var_318_4 + var_318_12 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
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

		arg_315_1:InitPlayNodeList()
	end,
	Play1101101076 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 1101101076
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play1101101077(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["1011ui_story"]) and arg_319_1.var_.characterEffect1011ui_story == nil then
				arg_319_1.var_.characterEffect1011ui_story = arg_319_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_0 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["1011ui_story"]) then
				if arg_319_1.var_.characterEffect1011ui_story and not isNil(arg_319_1.actors_["1011ui_story"]) then
					arg_319_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_319_1.time_ - 0) / var_322_0)
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["1011ui_story"]) and arg_319_1.var_.characterEffect1011ui_story then
				arg_319_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_322_1 = 0
			local var_322_2 = 0.725

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_3 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(1101101076).content)

				arg_319_1.text_.text = var_322_3

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_5 = 29 <= 0 and var_322_2 or var_322_2 * (utf8.len(var_322_3) / 29)

				if (29 <= 0 and var_322_2 or var_322_2 * (utf8.len(var_322_3) / 29)) > 0 and var_322_2 < var_322_5 then
					arg_319_1.talkMaxDuration = var_322_5

					if var_322_5 + var_322_1 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + var_322_1
					end
				end

				arg_319_1.text_.text = var_322_3
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_6 = math.max(var_322_2, arg_319_1.talkMaxDuration)

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_6 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_1) / var_322_6

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_1 + var_322_6 and arg_319_1.time_ < var_322_1 + var_322_6 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play1101101077 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 1101101077
		arg_323_1.duration_ = 6.57

		local var_323_0 = {
			zh = 2.9,
			ja = 6.566
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play1101101078(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1011ui_story = arg_323_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_326_0 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 then
				arg_323_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_323_1.time_ - 0) / var_326_0)
				arg_323_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1011ui_story"].transform.position).z)
				arg_323_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["1011ui_story"].transform.localEulerAngles = arg_323_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 then
				arg_323_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_323_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["1011ui_story"].transform.position).z)
				arg_323_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["1011ui_story"].transform.localEulerAngles = arg_323_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_326_1 = arg_323_1.actors_["1011ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect1011ui_story == nil then
				arg_323_1.var_.characterEffect1011ui_story = var_326_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_2 and not isNil(var_326_1) then
				if arg_323_1.var_.characterEffect1011ui_story and not isNil(var_326_1) then
					arg_323_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_2 and arg_323_1.time_ < 0 + var_326_2 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect1011ui_story then
				arg_323_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_326_4 = 0
			local var_326_5 = 0.3

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_4 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_6 = arg_323_1:GetWordFromCfg(1101101077)
				local var_326_7 = arg_323_1:FormatText(var_326_6.content)

				arg_323_1.text_.text = var_326_7

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_9 = 12 <= 0 and var_326_5 or var_326_5 * (utf8.len(var_326_7) / 12)

				if (12 <= 0 and var_326_5 or var_326_5 * (utf8.len(var_326_7) / 12)) > 0 and var_326_5 < var_326_9 then
					arg_323_1.talkMaxDuration = var_326_9

					if var_326_9 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_9 + var_326_4
					end
				end

				arg_323_1.text_.text = var_326_7
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101077", "story_v_side_new_1101101.awb") ~= 0 then
					local var_326_10 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101077", "story_v_side_new_1101101.awb") / 1000

					if var_326_10 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_10 + var_326_4
					end

					if var_326_6.prefab_name ~= "" and arg_323_1.actors_[var_326_6.prefab_name] ~= nil then
						local var_326_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_6.prefab_name].transform, "story_v_side_new_1101101", "1101101077", "story_v_side_new_1101101.awb")

						arg_323_1:RecordAudio("1101101077", var_326_11)
						arg_323_1:RecordAudio("1101101077", var_326_11)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101077", "story_v_side_new_1101101.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101077", "story_v_side_new_1101101.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_12 = math.max(var_326_5, arg_323_1.talkMaxDuration)

			if var_326_4 <= arg_323_1.time_ and arg_323_1.time_ < var_326_4 + var_326_12 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_4) / var_326_12

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_4 + var_326_12 and arg_323_1.time_ < var_326_4 + var_326_12 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
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

		arg_323_1:InitPlayNodeList()
	end,
	Play1101101078 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 1101101078
		arg_327_1.duration_ = 5

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play1101101079(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["1011ui_story"]) and arg_327_1.var_.characterEffect1011ui_story == nil then
				arg_327_1.var_.characterEffect1011ui_story = arg_327_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["1011ui_story"]) then
				if arg_327_1.var_.characterEffect1011ui_story and not isNil(arg_327_1.actors_["1011ui_story"]) then
					arg_327_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_0)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["1011ui_story"]) and arg_327_1.var_.characterEffect1011ui_story then
				arg_327_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_330_1 = 0
			local var_330_2 = 0.3

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_3 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(1101101078).content)

				arg_327_1.text_.text = var_330_3

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_5 = 12 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 12)

				if (12 <= 0 and var_330_2 or var_330_2 * (utf8.len(var_330_3) / 12)) > 0 and var_330_2 < var_330_5 then
					arg_327_1.talkMaxDuration = var_330_5

					if var_330_5 + var_330_1 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + var_330_1
					end
				end

				arg_327_1.text_.text = var_330_3
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_6 = math.max(var_330_2, arg_327_1.talkMaxDuration)

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_6 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_1) / var_330_6

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_1 + var_330_6 and arg_327_1.time_ < var_330_1 + var_330_6 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play1101101079 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 1101101079
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play1101101080(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action465")
			end

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_334_0 = 0
			local var_334_1 = 0.625

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_2 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(1101101079).content)

				arg_331_1.text_.text = var_334_2

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_4 = 25 <= 0 and var_334_1 or var_334_1 * (utf8.len(var_334_2) / 25)

				if (25 <= 0 and var_334_1 or var_334_1 * (utf8.len(var_334_2) / 25)) > 0 and var_334_1 < var_334_4 then
					arg_331_1.talkMaxDuration = var_334_4

					if var_334_4 + var_334_0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_4 + var_334_0
					end
				end

				arg_331_1.text_.text = var_334_2
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_5 = math.max(var_334_1, arg_331_1.talkMaxDuration)

			if var_334_0 <= arg_331_1.time_ and arg_331_1.time_ < var_334_0 + var_334_5 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_0) / var_334_5

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_0 + var_334_5 and arg_331_1.time_ < var_334_0 + var_334_5 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play1101101080 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 1101101080
		arg_335_1.duration_ = 1

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"

			SetActive(arg_335_1.choicesGo_, true)

			for iter_336_0, iter_336_1 in ipairs(arg_335_1.choices_) do
				SetActive(iter_336_1.go, iter_336_0 <= 2)
			end

			arg_335_1.choices_[1].txt.text = arg_335_1:FormatText(StoryChoiceCfg[606].name)
			arg_335_1.choices_[2].txt.text = arg_335_1:FormatText(StoryChoiceCfg[607].name)
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play1101101081(arg_335_1)
			end

			if arg_337_0 == 2 then
				arg_335_0:Play1101101081(arg_335_1)
			end

			arg_335_1:RecordChoiceLog(1101101080, 606, 607)
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.allBtn_.enabled = false
			end

			if arg_335_1.time_ >= 0 + 0.5 and arg_335_1.time_ < 0 + 0.5 + arg_338_0 then
				arg_335_1.allBtn_.enabled = true
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play1101101081 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1101101081
		arg_339_1.duration_ = 2

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1101101082(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos1011ui_story = arg_339_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_342_0 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 then
				arg_339_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_339_1.time_ - 0) / var_342_0)
				arg_339_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1011ui_story"].transform.position).z)
				arg_339_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1011ui_story"].transform.localEulerAngles = arg_339_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 then
				arg_339_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_339_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["1011ui_story"].transform.position).z)
				arg_339_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["1011ui_story"].transform.localEulerAngles = arg_339_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_342_1 = arg_339_1.actors_["1011ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1011ui_story == nil then
				arg_339_1.var_.characterEffect1011ui_story = var_342_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_2 and not isNil(var_342_1) then
				if arg_339_1.var_.characterEffect1011ui_story and not isNil(var_342_1) then
					arg_339_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_2 and arg_339_1.time_ < 0 + var_342_2 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect1011ui_story then
				arg_339_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_342_4 = "1011ui_story"

			if arg_339_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_342_5 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_339_1.stage_.transform)

				var_342_5.name = var_342_4
				var_342_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_339_1.actors_[var_342_4] = var_342_5

				local var_342_6 = var_342_5:GetComponentInChildren(typeof(CharacterEffect))

				var_342_6.enabled = true

				local var_342_7 = GameObjectTools.GetOrAddComponent(var_342_5, typeof(DynamicBoneHelper))

				if var_342_7 then
					var_342_7:EnableDynamicBone(false)
				end

				arg_339_1:ShowWeapon(var_342_6.transform, false)

				arg_339_1.var_[var_342_4 .. "Animator"] = var_342_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_339_1.var_[var_342_4 .. "Animator"].applyRootMotion = true
				arg_339_1.var_[var_342_4 .. "LipSync"] = var_342_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action5_2")
			end

			local var_342_8 = "1011ui_story"

			if arg_339_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_342_9 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_339_1.stage_.transform)

				var_342_9.name = var_342_8
				var_342_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_339_1.actors_[var_342_8] = var_342_9

				local var_342_10 = var_342_9:GetComponentInChildren(typeof(CharacterEffect))

				var_342_10.enabled = true

				local var_342_11 = GameObjectTools.GetOrAddComponent(var_342_9, typeof(DynamicBoneHelper))

				if var_342_11 then
					var_342_11:EnableDynamicBone(false)
				end

				arg_339_1:ShowWeapon(var_342_10.transform, false)

				arg_339_1.var_[var_342_8 .. "Animator"] = var_342_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_339_1.var_[var_342_8 .. "Animator"].applyRootMotion = true
				arg_339_1.var_[var_342_8 .. "LipSync"] = var_342_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_342_12 = 0
			local var_342_13 = 0.125

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_12 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_14 = arg_339_1:GetWordFromCfg(1101101081)
				local var_342_15 = arg_339_1:FormatText(var_342_14.content)

				arg_339_1.text_.text = var_342_15

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_17 = 5 <= 0 and var_342_13 or var_342_13 * (utf8.len(var_342_15) / 5)

				if (5 <= 0 and var_342_13 or var_342_13 * (utf8.len(var_342_15) / 5)) > 0 and var_342_13 < var_342_17 then
					arg_339_1.talkMaxDuration = var_342_17

					if var_342_17 + var_342_12 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_17 + var_342_12
					end
				end

				arg_339_1.text_.text = var_342_15
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101081", "story_v_side_new_1101101.awb") ~= 0 then
					local var_342_18 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101081", "story_v_side_new_1101101.awb") / 1000

					if var_342_18 + var_342_12 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_18 + var_342_12
					end

					if var_342_14.prefab_name ~= "" and arg_339_1.actors_[var_342_14.prefab_name] ~= nil then
						local var_342_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_14.prefab_name].transform, "story_v_side_new_1101101", "1101101081", "story_v_side_new_1101101.awb")

						arg_339_1:RecordAudio("1101101081", var_342_19)
						arg_339_1:RecordAudio("1101101081", var_342_19)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101081", "story_v_side_new_1101101.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101081", "story_v_side_new_1101101.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_20 = math.max(var_342_13, arg_339_1.talkMaxDuration)

			if var_342_12 <= arg_339_1.time_ and arg_339_1.time_ < var_342_12 + var_342_20 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_12) / var_342_20

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_12 + var_342_20 and arg_339_1.time_ < var_342_12 + var_342_20 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
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

		arg_339_1:InitPlayNodeList()
	end,
	Play1101101082 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1101101082
		arg_343_1.duration_ = 4.67

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1101101083(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 2 < arg_343_1.time_ and arg_343_1.time_ <= 2 + arg_346_0 then
				local var_346_0 = arg_343_1.bgs_.STblack

				arg_343_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_346_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_346_1 = var_346_0:GetComponent("SpriteRenderer")

				if var_346_1 and var_346_1.sprite then
					local var_346_2 = 2 * (var_346_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_346_0.transform.localScale = Vector3.New(var_346_2 / var_346_1.sprite.bounds.size.y < var_346_2 * manager.ui.mainCameraCom_.aspect / var_346_1.sprite.bounds.size.x and var_346_2 * manager.ui.mainCameraCom_.aspect / var_346_1.sprite.bounds.size.x or var_346_2 / var_346_1.sprite.bounds.size.y, var_346_2 / var_346_1.sprite.bounds.size.y < var_346_2 * manager.ui.mainCameraCom_.aspect / var_346_1.sprite.bounds.size.x and var_346_2 * manager.ui.mainCameraCom_.aspect / var_346_1.sprite.bounds.size.x or var_346_2 / var_346_1.sprite.bounds.size.y, 0)
				end

				for iter_346_0, iter_346_1 in pairs(arg_343_1.bgs_) do
					if iter_346_0 ~= "STblack" then
						iter_346_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_346_3 = 0

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_3 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_4 = 2

			if var_346_3 <= arg_343_1.time_ and arg_343_1.time_ < var_346_3 + var_346_4 then
				local var_346_5 = Color.New(0, 0, 0)

				var_346_5.a = Mathf.Lerp(0, 1, (arg_343_1.time_ - var_346_3) / var_346_4)
				arg_343_1.mask_.color = var_346_5
			end

			if arg_343_1.time_ >= var_346_3 + var_346_4 and arg_343_1.time_ < var_346_3 + var_346_4 + arg_346_0 then
				local var_346_6 = Color.New(0, 0, 0)

				var_346_6.a = 1
				arg_343_1.mask_.color = var_346_6
			end

			local var_346_7 = 2

			if 2 < arg_343_1.time_ and arg_343_1.time_ <= var_346_7 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_8 = 0.333333333333333

			if var_346_7 <= arg_343_1.time_ and arg_343_1.time_ < var_346_7 + var_346_8 then
				local var_346_9 = Color.New(0, 0, 0)

				var_346_9.a = Mathf.Lerp(1, 0, (arg_343_1.time_ - var_346_7) / var_346_8)
				arg_343_1.mask_.color = var_346_9
			end

			if arg_343_1.time_ >= var_346_7 + var_346_8 and arg_343_1.time_ < var_346_7 + var_346_8 + arg_346_0 then
				local var_346_10 = Color.New(0, 0, 0)

				arg_343_1.mask_.enabled = false
				var_346_10.a = 0
				arg_343_1.mask_.color = var_346_10
			end

			local var_346_11 = arg_343_1.actors_["1011ui_story"].transform

			if 2 < arg_343_1.time_ and arg_343_1.time_ <= 2 + arg_346_0 then
				arg_343_1.var_.moveOldPos1011ui_story = var_346_11.localPosition
			end

			local var_346_12 = 0.001

			if 2 <= arg_343_1.time_ and arg_343_1.time_ < 2 + var_346_12 then
				var_346_11.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_343_1.time_ - 2) / var_346_12)
				var_346_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_346_11.position).x, (manager.ui.mainCamera.transform.position - var_346_11.position).y, (manager.ui.mainCamera.transform.position - var_346_11.position).z)
				var_346_11.localEulerAngles.z = 0
				var_346_11.localEulerAngles.x = 0
				var_346_11.localEulerAngles = var_346_11.localEulerAngles
			end

			if arg_343_1.time_ >= 2 + var_346_12 and arg_343_1.time_ < 2 + var_346_12 + arg_346_0 then
				var_346_11.localPosition = Vector3.New(0, 100, 0)
				var_346_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_346_11.position).x, (manager.ui.mainCamera.transform.position - var_346_11.position).y, (manager.ui.mainCamera.transform.position - var_346_11.position).z)
				var_346_11.localEulerAngles.z = 0
				var_346_11.localEulerAngles.x = 0
				var_346_11.localEulerAngles = var_346_11.localEulerAngles
			end

			if 2 < arg_343_1.time_ and arg_343_1.time_ <= 2 + arg_346_0 then
				arg_343_1.fswbg_:SetActive(true)
				arg_343_1.dialog_:SetActive(false)

				arg_343_1.fswtw_.percent = 0
				arg_343_1.fswt_.text = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(1101101082).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.fswt_)

				arg_343_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_343_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_343_1.fswtw_:SetDirty()

				arg_343_1.typewritterCharCountI18N = 0

				SetActive(arg_343_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_343_1:ShowNextGo(false)
			end

			local var_346_13 = 2.33333333333333

			if 2.33333333333333 < arg_343_1.time_ and arg_343_1.time_ <= var_346_13 + arg_346_0 then
				arg_343_1.var_.oldValueTypewriter = arg_343_1.fswtw_.percent

				SetActive(arg_343_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_343_1:ShowNextGo(false)
			end

			local var_346_14 = 35
			local var_346_15 = 2.33333333333333
			local var_346_16, var_346_17 = arg_343_1:GetPercentByPara(arg_343_1:FormatText(arg_343_1:GetWordFromCfg(1101101082).content), 1)

			if var_346_13 < arg_343_1.time_ and arg_343_1.time_ <= var_346_13 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0

				local var_346_18 = var_346_14 <= 0 and var_346_15 or var_346_15 * ((var_346_17 - arg_343_1.typewritterCharCountI18N) / var_346_14)

				if (var_346_14 <= 0 and var_346_15 or var_346_15 * ((var_346_17 - arg_343_1.typewritterCharCountI18N) / var_346_14)) > 0 and var_346_15 < var_346_18 then
					arg_343_1.talkMaxDuration = var_346_18

					if var_346_18 + var_346_13 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_18 + var_346_13
					end
				end
			end

			local var_346_19 = math.max(2.33333333333333, arg_343_1.talkMaxDuration)

			if var_346_13 <= arg_343_1.time_ and arg_343_1.time_ < var_346_13 + var_346_19 then
				arg_343_1.fswtw_.percent = Mathf.Lerp(arg_343_1.var_.oldValueTypewriter, var_346_16, (arg_343_1.time_ - var_346_13) / var_346_19)
				arg_343_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_343_1.fswtw_:SetDirty()
			end

			if arg_343_1.time_ >= var_346_13 + var_346_19 and arg_343_1.time_ < var_346_13 + var_346_19 + arg_346_0 then
				arg_343_1.fswtw_.percent = var_346_16

				arg_343_1.fswtw_:SetDirty()
				arg_343_1:ShowNextGo(true)

				arg_343_1.typewritterCharCountI18N = var_346_17
			end

			if 2.3 < arg_343_1.time_ and arg_343_1.time_ <= 2.3 + arg_346_0 then
				local var_346_20 = arg_343_1.fswbg_.transform:Find("textbox/adapt/content") or arg_343_1.fswbg_.transform:Find("textbox/content")
				local var_346_21 = arg_343_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_346_22 = var_346_20:GetComponent("RectTransform")

				var_346_20:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_346_22.offsetMin = Vector2.New(0, 0)
				var_346_22.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play1101101083 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1101101083
		arg_347_1.duration_ = 5

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1101101084(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.fswbg_:SetActive(false)
				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_347_1:ShowNextGo(false)
			end

			local var_350_0 = 0
			local var_350_1 = 0.675

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, false)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_2 = arg_347_1:FormatText(arg_347_1:GetWordFromCfg(1101101083).content)

				arg_347_1.text_.text = var_350_2

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_4 = 27 <= 0 and var_350_1 or var_350_1 * (utf8.len(var_350_2) / 27)

				if (27 <= 0 and var_350_1 or var_350_1 * (utf8.len(var_350_2) / 27)) > 0 and var_350_1 < var_350_4 then
					arg_347_1.talkMaxDuration = var_350_4

					if var_350_4 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_4 + var_350_0
					end
				end

				arg_347_1.text_.text = var_350_2
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)
				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_5 = math.max(var_350_1, arg_347_1.talkMaxDuration)

			if var_350_0 <= arg_347_1.time_ and arg_347_1.time_ < var_350_0 + var_350_5 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_0) / var_350_5

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_0 + var_350_5 and arg_347_1.time_ < var_350_0 + var_350_5 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play1101101084 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1101101084
		arg_351_1.duration_ = 7

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1101101085(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if arg_351_1.bgs_.B13g == nil then
				local var_354_0 = Object.Instantiate(arg_351_1.paintGo_)

				var_354_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13g")
				var_354_0.name = "B13g"
				var_354_0.transform.parent = arg_351_1.stage_.transform
				var_354_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_351_1.bgs_.B13g = var_354_0
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				local var_354_1 = arg_351_1.bgs_.B13g

				arg_351_1.bgs_.B13g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_354_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_354_2 = var_354_1:GetComponent("SpriteRenderer")

				if var_354_2 and var_354_2.sprite then
					local var_354_3 = 2 * (var_354_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_354_1.transform.localScale = Vector3.New(var_354_3 / var_354_2.sprite.bounds.size.y < var_354_3 * manager.ui.mainCameraCom_.aspect / var_354_2.sprite.bounds.size.x and var_354_3 * manager.ui.mainCameraCom_.aspect / var_354_2.sprite.bounds.size.x or var_354_3 / var_354_2.sprite.bounds.size.y, var_354_3 / var_354_2.sprite.bounds.size.y < var_354_3 * manager.ui.mainCameraCom_.aspect / var_354_2.sprite.bounds.size.x and var_354_3 * manager.ui.mainCameraCom_.aspect / var_354_2.sprite.bounds.size.x or var_354_3 / var_354_2.sprite.bounds.size.y, 0)
				end

				for iter_354_0, iter_354_1 in pairs(arg_351_1.bgs_) do
					if iter_354_0 ~= "B13g" then
						iter_354_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_354_4 = 0

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_4 + arg_354_0 then
				arg_351_1.mask_.enabled = true
				arg_351_1.mask_.raycastTarget = true

				arg_351_1:SetGaussion(false)
			end

			local var_354_5 = 2

			if var_354_4 <= arg_351_1.time_ and arg_351_1.time_ < var_354_4 + var_354_5 then
				local var_354_6 = Color.New(0, 0, 0)

				var_354_6.a = Mathf.Lerp(1, 0, (arg_351_1.time_ - var_354_4) / var_354_5)
				arg_351_1.mask_.color = var_354_6
			end

			if arg_351_1.time_ >= var_354_4 + var_354_5 and arg_351_1.time_ < var_354_4 + var_354_5 + arg_354_0 then
				local var_354_7 = Color.New(0, 0, 0)

				arg_351_1.mask_.enabled = false
				var_354_7.a = 0
				arg_351_1.mask_.color = var_354_7
			end

			if arg_351_1.frameCnt_ <= 1 then
				arg_351_1.dialog_:SetActive(false)
			end

			local var_354_8 = 2
			local var_354_9 = 0.625

			if 2 < arg_351_1.time_ and arg_351_1.time_ <= var_354_8 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0

				arg_351_1.dialog_:SetActive(true)

				arg_351_1.dialogCg_.alpha = 0

				local var_354_10 = LeanTween.value(arg_351_1.dialog_, 0, 1, 0.3)

				var_354_10:setOnUpdate(LuaHelper.FloatAction(function(arg_355_0)
					arg_351_1.dialogCg_.alpha = arg_355_0
				end))
				var_354_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_351_1.dialog_)
					var_354_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_351_1.duration_ = arg_351_1.duration_ + 0.3

				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_11 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(1101101084).content)

				arg_351_1.text_.text = var_354_11

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_13 = 25 <= 0 and var_354_9 or var_354_9 * (utf8.len(var_354_11) / 25)

				if (25 <= 0 and var_354_9 or var_354_9 * (utf8.len(var_354_11) / 25)) > 0 and var_354_9 < var_354_13 then
					arg_351_1.talkMaxDuration = var_354_13
					var_354_8 = var_354_8 + 0.3

					if var_354_13 + var_354_8 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_13 + var_354_8
					end
				end

				arg_351_1.text_.text = var_354_11
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_14 = var_354_8 + 0.3
			local var_354_15 = math.max(var_354_9, arg_351_1.talkMaxDuration)

			if var_354_8 + 0.3 <= arg_351_1.time_ and arg_351_1.time_ < var_354_14 + var_354_15 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_14) / var_354_15

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_14 + var_354_15 and arg_351_1.time_ < var_354_14 + var_354_15 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1101101085 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1101101085
		arg_357_1.duration_ = 9.8

		local var_357_0 = {
			zh = 5.433,
			ja = 9.8
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
				arg_357_0:Play1101101086(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1011ui_story = arg_357_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_360_0 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 then
				arg_357_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_357_1.time_ - 0) / var_360_0)
				arg_357_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1011ui_story"].transform.position).z)
				arg_357_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1011ui_story"].transform.localEulerAngles = arg_357_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 then
				arg_357_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_357_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1011ui_story"].transform.position).z)
				arg_357_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1011ui_story"].transform.localEulerAngles = arg_357_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_360_1 = arg_357_1.actors_["1011ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect1011ui_story == nil then
				arg_357_1.var_.characterEffect1011ui_story = var_360_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_2 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_2 and not isNil(var_360_1) then
				if arg_357_1.var_.characterEffect1011ui_story and not isNil(var_360_1) then
					arg_357_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_2 and arg_357_1.time_ < 0 + var_360_2 + arg_360_0 and not isNil(var_360_1) and arg_357_1.var_.characterEffect1011ui_story then
				arg_357_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_360_4 = 0
			local var_360_5 = 0.675

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_4 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_6 = arg_357_1:GetWordFromCfg(1101101085)
				local var_360_7 = arg_357_1:FormatText(var_360_6.content)

				arg_357_1.text_.text = var_360_7

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_9 = 27 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_7) / 27)

				if (27 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_7) / 27)) > 0 and var_360_5 < var_360_9 then
					arg_357_1.talkMaxDuration = var_360_9

					if var_360_9 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_9 + var_360_4
					end
				end

				arg_357_1.text_.text = var_360_7
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101085", "story_v_side_new_1101101.awb") ~= 0 then
					local var_360_10 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101085", "story_v_side_new_1101101.awb") / 1000

					if var_360_10 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_10 + var_360_4
					end

					if var_360_6.prefab_name ~= "" and arg_357_1.actors_[var_360_6.prefab_name] ~= nil then
						local var_360_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_6.prefab_name].transform, "story_v_side_new_1101101", "1101101085", "story_v_side_new_1101101.awb")

						arg_357_1:RecordAudio("1101101085", var_360_11)
						arg_357_1:RecordAudio("1101101085", var_360_11)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101085", "story_v_side_new_1101101.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101085", "story_v_side_new_1101101.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_12 = math.max(var_360_5, arg_357_1.talkMaxDuration)

			if var_360_4 <= arg_357_1.time_ and arg_357_1.time_ < var_360_4 + var_360_12 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_4) / var_360_12

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_4 + var_360_12 and arg_357_1.time_ < var_360_4 + var_360_12 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
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

		arg_357_1:InitPlayNodeList()
	end,
	Play1101101086 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1101101086
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play1101101087(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["1011ui_story"]) and arg_361_1.var_.characterEffect1011ui_story == nil then
				arg_361_1.var_.characterEffect1011ui_story = arg_361_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["1011ui_story"]) then
				if arg_361_1.var_.characterEffect1011ui_story and not isNil(arg_361_1.actors_["1011ui_story"]) then
					arg_361_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_0)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["1011ui_story"]) and arg_361_1.var_.characterEffect1011ui_story then
				arg_361_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_364_1 = 0
			local var_364_2 = 0.9

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_3 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(1101101086).content)

				arg_361_1.text_.text = var_364_3

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 36 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 36)

				if (36 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 36)) > 0 and var_364_2 < var_364_5 then
					arg_361_1.talkMaxDuration = var_364_5

					if var_364_5 + var_364_1 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_5 + var_364_1
					end
				end

				arg_361_1.text_.text = var_364_3
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_6 = math.max(var_364_2, arg_361_1.talkMaxDuration)

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_6 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_1) / var_364_6

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_1 + var_364_6 and arg_361_1.time_ < var_364_1 + var_364_6 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play1101101087 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1101101087
		arg_365_1.duration_ = 10.5

		local var_365_0 = {
			zh = 5.633,
			ja = 10.5
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
				arg_365_0:Play1101101088(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos1011ui_story = arg_365_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_368_0 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 then
				arg_365_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_365_1.time_ - 0) / var_368_0)
				arg_365_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_365_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1011ui_story"].transform.position).z)
				arg_365_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_365_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_365_1.actors_["1011ui_story"].transform.localEulerAngles = arg_365_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 then
				arg_365_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_365_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_365_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_365_1.actors_["1011ui_story"].transform.position).z)
				arg_365_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_365_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_365_1.actors_["1011ui_story"].transform.localEulerAngles = arg_365_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_368_1 = arg_365_1.actors_["1011ui_story"]

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(var_368_1) and arg_365_1.var_.characterEffect1011ui_story == nil then
				arg_365_1.var_.characterEffect1011ui_story = var_368_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_2 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_2 and not isNil(var_368_1) then
				if arg_365_1.var_.characterEffect1011ui_story and not isNil(var_368_1) then
					arg_365_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= 0 + var_368_2 and arg_365_1.time_ < 0 + var_368_2 + arg_368_0 and not isNil(var_368_1) and arg_365_1.var_.characterEffect1011ui_story then
				arg_365_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_368_4 = 0
			local var_368_5 = 0.625

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_4 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_6 = arg_365_1:GetWordFromCfg(1101101087)
				local var_368_7 = arg_365_1:FormatText(var_368_6.content)

				arg_365_1.text_.text = var_368_7

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_9 = 25 <= 0 and var_368_5 or var_368_5 * (utf8.len(var_368_7) / 25)

				if (25 <= 0 and var_368_5 or var_368_5 * (utf8.len(var_368_7) / 25)) > 0 and var_368_5 < var_368_9 then
					arg_365_1.talkMaxDuration = var_368_9

					if var_368_9 + var_368_4 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_9 + var_368_4
					end
				end

				arg_365_1.text_.text = var_368_7
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101087", "story_v_side_new_1101101.awb") ~= 0 then
					local var_368_10 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101087", "story_v_side_new_1101101.awb") / 1000

					if var_368_10 + var_368_4 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_10 + var_368_4
					end

					if var_368_6.prefab_name ~= "" and arg_365_1.actors_[var_368_6.prefab_name] ~= nil then
						local var_368_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_6.prefab_name].transform, "story_v_side_new_1101101", "1101101087", "story_v_side_new_1101101.awb")

						arg_365_1:RecordAudio("1101101087", var_368_11)
						arg_365_1:RecordAudio("1101101087", var_368_11)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101087", "story_v_side_new_1101101.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101087", "story_v_side_new_1101101.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_12 = math.max(var_368_5, arg_365_1.talkMaxDuration)

			if var_368_4 <= arg_365_1.time_ and arg_365_1.time_ < var_368_4 + var_368_12 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_4) / var_368_12

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_4 + var_368_12 and arg_365_1.time_ < var_368_4 + var_368_12 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
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

		arg_365_1:InitPlayNodeList()
	end,
	Play1101101088 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1101101088
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play1101101089(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["1011ui_story"]) and arg_369_1.var_.characterEffect1011ui_story == nil then
				arg_369_1.var_.characterEffect1011ui_story = arg_369_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_0 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["1011ui_story"]) then
				if arg_369_1.var_.characterEffect1011ui_story and not isNil(arg_369_1.actors_["1011ui_story"]) then
					arg_369_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_0)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["1011ui_story"]) and arg_369_1.var_.characterEffect1011ui_story then
				arg_369_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_372_1 = 0
			local var_372_2 = 0.4

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

				local var_372_3 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(1101101088).content)

				arg_369_1.text_.text = var_372_3

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_5 = 16 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 16)

				if (16 <= 0 and var_372_2 or var_372_2 * (utf8.len(var_372_3) / 16)) > 0 and var_372_2 < var_372_5 then
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
	Play1101101089 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 1101101089
		arg_373_1.duration_ = 9

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play1101101090(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if arg_373_1.bgs_.B13a == nil then
				local var_376_0 = Object.Instantiate(arg_373_1.paintGo_)

				var_376_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13a")
				var_376_0.name = "B13a"
				var_376_0.transform.parent = arg_373_1.stage_.transform
				var_376_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_373_1.bgs_.B13a = var_376_0
			end

			if 2 < arg_373_1.time_ and arg_373_1.time_ <= 2 + arg_376_0 then
				local var_376_1 = arg_373_1.bgs_.B13a

				arg_373_1.bgs_.B13a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_376_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_376_2 = var_376_1:GetComponent("SpriteRenderer")

				if var_376_2 and var_376_2.sprite then
					local var_376_3 = 2 * (var_376_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_376_1.transform.localScale = Vector3.New(var_376_3 / var_376_2.sprite.bounds.size.y < var_376_3 * manager.ui.mainCameraCom_.aspect / var_376_2.sprite.bounds.size.x and var_376_3 * manager.ui.mainCameraCom_.aspect / var_376_2.sprite.bounds.size.x or var_376_3 / var_376_2.sprite.bounds.size.y, var_376_3 / var_376_2.sprite.bounds.size.y < var_376_3 * manager.ui.mainCameraCom_.aspect / var_376_2.sprite.bounds.size.x and var_376_3 * manager.ui.mainCameraCom_.aspect / var_376_2.sprite.bounds.size.x or var_376_3 / var_376_2.sprite.bounds.size.y, 0)
				end

				for iter_376_0, iter_376_1 in pairs(arg_373_1.bgs_) do
					if iter_376_0 ~= "B13a" then
						iter_376_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_376_4 = arg_373_1.actors_["1011ui_story"].transform

			if 2 < arg_373_1.time_ and arg_373_1.time_ <= 2 + arg_376_0 then
				arg_373_1.var_.moveOldPos1011ui_story = var_376_4.localPosition
			end

			local var_376_5 = 0.001

			if 2 <= arg_373_1.time_ and arg_373_1.time_ < 2 + var_376_5 then
				var_376_4.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_373_1.time_ - 2) / var_376_5)
				var_376_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_376_4.position).x, (manager.ui.mainCamera.transform.position - var_376_4.position).y, (manager.ui.mainCamera.transform.position - var_376_4.position).z)
				var_376_4.localEulerAngles.z = 0
				var_376_4.localEulerAngles.x = 0
				var_376_4.localEulerAngles = var_376_4.localEulerAngles
			end

			if arg_373_1.time_ >= 2 + var_376_5 and arg_373_1.time_ < 2 + var_376_5 + arg_376_0 then
				var_376_4.localPosition = Vector3.New(0, 100, 0)
				var_376_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_376_4.position).x, (manager.ui.mainCamera.transform.position - var_376_4.position).y, (manager.ui.mainCamera.transform.position - var_376_4.position).z)
				var_376_4.localEulerAngles.z = 0
				var_376_4.localEulerAngles.x = 0
				var_376_4.localEulerAngles = var_376_4.localEulerAngles
			end

			local var_376_6 = 0

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_6 + arg_376_0 then
				arg_373_1.mask_.enabled = true
				arg_373_1.mask_.raycastTarget = true

				arg_373_1:SetGaussion(false)
			end

			local var_376_7 = 2

			if var_376_6 <= arg_373_1.time_ and arg_373_1.time_ < var_376_6 + var_376_7 then
				local var_376_8 = Color.New(0, 0, 0)

				var_376_8.a = Mathf.Lerp(0, 1, (arg_373_1.time_ - var_376_6) / var_376_7)
				arg_373_1.mask_.color = var_376_8
			end

			if arg_373_1.time_ >= var_376_6 + var_376_7 and arg_373_1.time_ < var_376_6 + var_376_7 + arg_376_0 then
				local var_376_9 = Color.New(0, 0, 0)

				var_376_9.a = 1
				arg_373_1.mask_.color = var_376_9
			end

			local var_376_10 = 2

			if 2 < arg_373_1.time_ and arg_373_1.time_ <= var_376_10 + arg_376_0 then
				arg_373_1.mask_.enabled = true
				arg_373_1.mask_.raycastTarget = true

				arg_373_1:SetGaussion(false)
			end

			local var_376_11 = 2

			if var_376_10 <= arg_373_1.time_ and arg_373_1.time_ < var_376_10 + var_376_11 then
				local var_376_12 = Color.New(0, 0, 0)

				var_376_12.a = Mathf.Lerp(1, 0, (arg_373_1.time_ - var_376_10) / var_376_11)
				arg_373_1.mask_.color = var_376_12
			end

			if arg_373_1.time_ >= var_376_10 + var_376_11 and arg_373_1.time_ < var_376_10 + var_376_11 + arg_376_0 then
				local var_376_13 = Color.New(0, 0, 0)

				arg_373_1.mask_.enabled = false
				var_376_13.a = 0
				arg_373_1.mask_.color = var_376_13
			end

			local var_376_14 = arg_373_1.actors_["1011ui_story"].transform

			if 3.8 < arg_373_1.time_ and arg_373_1.time_ <= 3.8 + arg_376_0 then
				arg_373_1.var_.moveOldPos1011ui_story = var_376_14.localPosition
			end

			local var_376_15 = 0.001

			if 3.8 <= arg_373_1.time_ and arg_373_1.time_ < 3.8 + var_376_15 then
				var_376_14.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_373_1.time_ - 3.8) / var_376_15)
				var_376_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_376_14.position).x, (manager.ui.mainCamera.transform.position - var_376_14.position).y, (manager.ui.mainCamera.transform.position - var_376_14.position).z)
				var_376_14.localEulerAngles.z = 0
				var_376_14.localEulerAngles.x = 0
				var_376_14.localEulerAngles = var_376_14.localEulerAngles
			end

			if arg_373_1.time_ >= 3.8 + var_376_15 and arg_373_1.time_ < 3.8 + var_376_15 + arg_376_0 then
				var_376_14.localPosition = Vector3.New(0, -0.71, -6)
				var_376_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_376_14.position).x, (manager.ui.mainCamera.transform.position - var_376_14.position).y, (manager.ui.mainCamera.transform.position - var_376_14.position).z)
				var_376_14.localEulerAngles.z = 0
				var_376_14.localEulerAngles.x = 0
				var_376_14.localEulerAngles = var_376_14.localEulerAngles
			end

			if 3.8 < arg_373_1.time_ and arg_373_1.time_ <= 3.8 + arg_376_0 then
				arg_373_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if arg_373_1.frameCnt_ <= 1 then
				arg_373_1.dialog_:SetActive(false)
			end

			local var_376_16 = 4
			local var_376_17 = 1.075

			if 4 < arg_373_1.time_ and arg_373_1.time_ <= var_376_16 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0

				arg_373_1.dialog_:SetActive(true)

				arg_373_1.dialogCg_.alpha = 0

				local var_376_18 = LeanTween.value(arg_373_1.dialog_, 0, 1, 0.3)

				var_376_18:setOnUpdate(LuaHelper.FloatAction(function(arg_377_0)
					arg_373_1.dialogCg_.alpha = arg_377_0
				end))
				var_376_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_373_1.dialog_)
					var_376_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_373_1.duration_ = arg_373_1.duration_ + 0.3

				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_19 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(1101101089).content)

				arg_373_1.text_.text = var_376_19

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_21 = 43 <= 0 and var_376_17 or var_376_17 * (utf8.len(var_376_19) / 43)

				if (43 <= 0 and var_376_17 or var_376_17 * (utf8.len(var_376_19) / 43)) > 0 and var_376_17 < var_376_21 then
					arg_373_1.talkMaxDuration = var_376_21
					var_376_16 = var_376_16 + 0.3

					if var_376_21 + var_376_16 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_21 + var_376_16
					end
				end

				arg_373_1.text_.text = var_376_19
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_22 = var_376_16 + 0.3
			local var_376_23 = math.max(var_376_17, arg_373_1.talkMaxDuration)

			if var_376_16 + 0.3 <= arg_373_1.time_ and arg_373_1.time_ < var_376_22 + var_376_23 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_22) / var_376_23

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_22 + var_376_23 and arg_373_1.time_ < var_376_22 + var_376_23 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	Play1101101090 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1101101090
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1101101091(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0.9

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, false)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_1 = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(1101101090).content)

				arg_379_1.text_.text = var_382_1

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_3 = 36 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_1) / 36)

				if (36 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_1) / 36)) > 0 and var_382_0 < var_382_3 then
					arg_379_1.talkMaxDuration = var_382_3

					if var_382_3 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_3 + 0
					end
				end

				arg_379_1.text_.text = var_382_1
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_4 = math.max(var_382_0, arg_379_1.talkMaxDuration)

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_4 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - 0) / var_382_4

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= 0 + var_382_4 and arg_379_1.time_ < 0 + var_382_4 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1101101091 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1101101091
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1101101092(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0.875

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_1 = arg_383_1:FormatText(arg_383_1:GetWordFromCfg(1101101091).content)

				arg_383_1.text_.text = var_386_1

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_3 = 35 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 35)

				if (35 <= 0 and var_386_0 or var_386_0 * (utf8.len(var_386_1) / 35)) > 0 and var_386_0 < var_386_3 then
					arg_383_1.talkMaxDuration = var_386_3

					if var_386_3 + 0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_3 + 0
					end
				end

				arg_383_1.text_.text = var_386_1
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_4 = math.max(var_386_0, arg_383_1.talkMaxDuration)

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_4 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - 0) / var_386_4

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= 0 + var_386_4 and arg_383_1.time_ < 0 + var_386_4 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1101101092 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1101101092
		arg_387_1.duration_ = 2.17

		local var_387_0 = {
			zh = 2.166,
			ja = 1.233
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
				arg_387_0:Play1101101093(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos1011ui_story = arg_387_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_390_0 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 then
				arg_387_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_387_1.time_ - 0) / var_390_0)
				arg_387_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1011ui_story"].transform.position).z)
				arg_387_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["1011ui_story"].transform.localEulerAngles = arg_387_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 then
				arg_387_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_387_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_387_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_387_1.actors_["1011ui_story"].transform.position).z)
				arg_387_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_387_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_387_1.actors_["1011ui_story"].transform.localEulerAngles = arg_387_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_390_1 = 0
			local var_390_2 = 0.175

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[580].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, true)
				arg_387_1.iconController_:SetSelectedState("hero")

				arg_387_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_387_1.callingController_:SetSelectedState("normal")

				arg_387_1.keyicon_.color = Color.New(1, 1, 1)
				arg_387_1.icon_.color = Color.New(1, 1, 1)

				local var_390_3 = arg_387_1:GetWordFromCfg(1101101092)
				local var_390_4 = arg_387_1:FormatText(var_390_3.content)

				arg_387_1.text_.text = var_390_4

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_6 = 7 <= 0 and var_390_2 or var_390_2 * (utf8.len(var_390_4) / 7)

				if (7 <= 0 and var_390_2 or var_390_2 * (utf8.len(var_390_4) / 7)) > 0 and var_390_2 < var_390_6 then
					arg_387_1.talkMaxDuration = var_390_6

					if var_390_6 + var_390_1 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_6 + var_390_1
					end
				end

				arg_387_1.text_.text = var_390_4
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101092", "story_v_side_new_1101101.awb") ~= 0 then
					local var_390_7 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101092", "story_v_side_new_1101101.awb") / 1000

					if var_390_7 + var_390_1 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_1
					end

					if var_390_3.prefab_name ~= "" and arg_387_1.actors_[var_390_3.prefab_name] ~= nil then
						local var_390_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_3.prefab_name].transform, "story_v_side_new_1101101", "1101101092", "story_v_side_new_1101101.awb")

						arg_387_1:RecordAudio("1101101092", var_390_8)
						arg_387_1:RecordAudio("1101101092", var_390_8)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101092", "story_v_side_new_1101101.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101092", "story_v_side_new_1101101.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_9 = math.max(var_390_2, arg_387_1.talkMaxDuration)

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_9 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_1) / var_390_9

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_1 + var_390_9 and arg_387_1.time_ < var_390_1 + var_390_9 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
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

		arg_387_1:InitPlayNodeList()
	end,
	Play1101101093 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1101101093
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1101101094(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0.625

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_1 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(1101101093).content)

				arg_391_1.text_.text = var_394_1

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_3 = 25 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_1) / 25)

				if (25 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_1) / 25)) > 0 and var_394_0 < var_394_3 then
					arg_391_1.talkMaxDuration = var_394_3

					if var_394_3 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_3 + 0
					end
				end

				arg_391_1.text_.text = var_394_1
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_4 = math.max(var_394_0, arg_391_1.talkMaxDuration)

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_4 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - 0) / var_394_4

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= 0 + var_394_4 and arg_391_1.time_ < 0 + var_394_4 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play1101101094 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 1101101094
		arg_395_1.duration_ = 3.07

		local var_395_0 = {
			zh = 1.999999999999,
			ja = 3.066
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
				arg_395_0:Play1101101095(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos1011ui_story = arg_395_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_398_0 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_0 then
				arg_395_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_395_1.time_ - 0) / var_398_0)
				arg_395_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1011ui_story"].transform.position).z)
				arg_395_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1011ui_story"].transform.localEulerAngles = arg_395_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_395_1.time_ >= 0 + var_398_0 and arg_395_1.time_ < 0 + var_398_0 + arg_398_0 then
				arg_395_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_395_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_395_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_395_1.actors_["1011ui_story"].transform.position).z)
				arg_395_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_395_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_395_1.actors_["1011ui_story"].transform.localEulerAngles = arg_395_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_398_1 = arg_395_1.actors_["1011ui_story"]

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect1011ui_story == nil then
				arg_395_1.var_.characterEffect1011ui_story = var_398_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_2 = 0.200000002980232

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_2 and not isNil(var_398_1) then
				if arg_395_1.var_.characterEffect1011ui_story and not isNil(var_398_1) then
					arg_395_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= 0 + var_398_2 and arg_395_1.time_ < 0 + var_398_2 + arg_398_0 and not isNil(var_398_1) and arg_395_1.var_.characterEffect1011ui_story then
				arg_395_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva")
			end

			local var_398_4 = 0
			local var_398_5 = 0.125

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_4 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_6 = arg_395_1:GetWordFromCfg(1101101094)
				local var_398_7 = arg_395_1:FormatText(var_398_6.content)

				arg_395_1.text_.text = var_398_7

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_9 = 5 <= 0 and var_398_5 or var_398_5 * (utf8.len(var_398_7) / 5)

				if (5 <= 0 and var_398_5 or var_398_5 * (utf8.len(var_398_7) / 5)) > 0 and var_398_5 < var_398_9 then
					arg_395_1.talkMaxDuration = var_398_9

					if var_398_9 + var_398_4 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_9 + var_398_4
					end
				end

				arg_395_1.text_.text = var_398_7
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101094", "story_v_side_new_1101101.awb") ~= 0 then
					local var_398_10 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101094", "story_v_side_new_1101101.awb") / 1000

					if var_398_10 + var_398_4 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_10 + var_398_4
					end

					if var_398_6.prefab_name ~= "" and arg_395_1.actors_[var_398_6.prefab_name] ~= nil then
						local var_398_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_6.prefab_name].transform, "story_v_side_new_1101101", "1101101094", "story_v_side_new_1101101.awb")

						arg_395_1:RecordAudio("1101101094", var_398_11)
						arg_395_1:RecordAudio("1101101094", var_398_11)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101094", "story_v_side_new_1101101.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101094", "story_v_side_new_1101101.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_12 = math.max(var_398_5, arg_395_1.talkMaxDuration)

			if var_398_4 <= arg_395_1.time_ and arg_395_1.time_ < var_398_4 + var_398_12 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_4) / var_398_12

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_4 + var_398_12 and arg_395_1.time_ < var_398_4 + var_398_12 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
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

		arg_395_1:InitPlayNodeList()
	end,
	Play1101101095 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 1101101095
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play1101101096(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(arg_399_1.actors_["1011ui_story"]) and arg_399_1.var_.characterEffect1011ui_story == nil then
				arg_399_1.var_.characterEffect1011ui_story = arg_399_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_0 = 0.200000002980232

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 and not isNil(arg_399_1.actors_["1011ui_story"]) then
				if arg_399_1.var_.characterEffect1011ui_story and not isNil(arg_399_1.actors_["1011ui_story"]) then
					arg_399_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_399_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_399_1.time_ - 0) / var_402_0)
				end
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 and not isNil(arg_399_1.actors_["1011ui_story"]) and arg_399_1.var_.characterEffect1011ui_story then
				arg_399_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_399_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_402_1 = 0
			local var_402_2 = 0.175

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, true)
				arg_399_1.iconController_:SetSelectedState("hero")

				arg_399_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_399_1.callingController_:SetSelectedState("normal")

				arg_399_1.keyicon_.color = Color.New(1, 1, 1)
				arg_399_1.icon_.color = Color.New(1, 1, 1)

				local var_402_3 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(1101101095).content)

				arg_399_1.text_.text = var_402_3

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 7 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 7)

				if (7 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 7)) > 0 and var_402_2 < var_402_5 then
					arg_399_1.talkMaxDuration = var_402_5

					if var_402_5 + var_402_1 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_5 + var_402_1
					end
				end

				arg_399_1.text_.text = var_402_3
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_6 = math.max(var_402_2, arg_399_1.talkMaxDuration)

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_6 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_1) / var_402_6

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_1 + var_402_6 and arg_399_1.time_ < var_402_1 + var_402_6 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play1101101096 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 1101101096
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play1101101097(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0.725

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, false)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_1 = arg_403_1:FormatText(arg_403_1:GetWordFromCfg(1101101096).content)

				arg_403_1.text_.text = var_406_1

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_3 = 29 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 29)

				if (29 <= 0 and var_406_0 or var_406_0 * (utf8.len(var_406_1) / 29)) > 0 and var_406_0 < var_406_3 then
					arg_403_1.talkMaxDuration = var_406_3

					if var_406_3 + 0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_3 + 0
					end
				end

				arg_403_1.text_.text = var_406_1
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_4 = math.max(var_406_0, arg_403_1.talkMaxDuration)

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_4 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - 0) / var_406_4

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= 0 + var_406_4 and arg_403_1.time_ < 0 + var_406_4 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play1101101097 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1101101097
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1101101098(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_410_0 = 0
			local var_410_1 = 0.85

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_2 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(1101101097).content)

				arg_407_1.text_.text = var_410_2

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_4 = 34 <= 0 and var_410_1 or var_410_1 * (utf8.len(var_410_2) / 34)

				if (34 <= 0 and var_410_1 or var_410_1 * (utf8.len(var_410_2) / 34)) > 0 and var_410_1 < var_410_4 then
					arg_407_1.talkMaxDuration = var_410_4

					if var_410_4 + var_410_0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_4 + var_410_0
					end
				end

				arg_407_1.text_.text = var_410_2
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_5 = math.max(var_410_1, arg_407_1.talkMaxDuration)

			if var_410_0 <= arg_407_1.time_ and arg_407_1.time_ < var_410_0 + var_410_5 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_0) / var_410_5

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_0 + var_410_5 and arg_407_1.time_ < var_410_0 + var_410_5 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play1101101098 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1101101098
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1101101099(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0.5

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_1 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(1101101098).content)

				arg_411_1.text_.text = var_414_1

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_3 = 20 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 20)

				if (20 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 20)) > 0 and var_414_0 < var_414_3 then
					arg_411_1.talkMaxDuration = var_414_3

					if var_414_3 + 0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_3 + 0
					end
				end

				arg_411_1.text_.text = var_414_1
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_4 = math.max(var_414_0, arg_411_1.talkMaxDuration)

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_4 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - 0) / var_414_4

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= 0 + var_414_4 and arg_411_1.time_ < 0 + var_414_4 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play1101101099 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1101101099
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1101101100(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 1.075

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, true)
				arg_415_1.iconController_:SetSelectedState("hero")

				arg_415_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_415_1.callingController_:SetSelectedState("normal")

				arg_415_1.keyicon_.color = Color.New(1, 1, 1)
				arg_415_1.icon_.color = Color.New(1, 1, 1)

				local var_418_1 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(1101101099).content)

				arg_415_1.text_.text = var_418_1

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_3 = 43 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_1) / 43)

				if (43 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_1) / 43)) > 0 and var_418_0 < var_418_3 then
					arg_415_1.talkMaxDuration = var_418_3

					if var_418_3 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_3 + 0
					end
				end

				arg_415_1.text_.text = var_418_1
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_4 = math.max(var_418_0, arg_415_1.talkMaxDuration)

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_4 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - 0) / var_418_4

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= 0 + var_418_4 and arg_415_1.time_ < 0 + var_418_4 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play1101101100 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1101101100
		arg_419_1.duration_ = 5.17

		local var_419_0 = {
			zh = 5,
			ja = 5.166
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play1101101101(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.moveOldPos1011ui_story = arg_419_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_422_0 = 0.001

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 then
				arg_419_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_419_1.time_ - 0) / var_422_0)
				arg_419_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1011ui_story"].transform.position).z)
				arg_419_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["1011ui_story"].transform.localEulerAngles = arg_419_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 then
				arg_419_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_419_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_419_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_419_1.actors_["1011ui_story"].transform.position).z)
				arg_419_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_419_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_419_1.actors_["1011ui_story"].transform.localEulerAngles = arg_419_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_422_1 = arg_419_1.actors_["1011ui_story"]

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(var_422_1) and arg_419_1.var_.characterEffect1011ui_story == nil then
				arg_419_1.var_.characterEffect1011ui_story = var_422_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_422_2 = 0.200000002980232

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_2 and not isNil(var_422_1) then
				if arg_419_1.var_.characterEffect1011ui_story and not isNil(var_422_1) then
					arg_419_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_419_1.time_ >= 0 + var_422_2 and arg_419_1.time_ < 0 + var_422_2 + arg_422_0 and not isNil(var_422_1) and arg_419_1.var_.characterEffect1011ui_story then
				arg_419_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_422_4 = 0
			local var_422_5 = 0.525

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_4 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_6 = arg_419_1:GetWordFromCfg(1101101100)
				local var_422_7 = arg_419_1:FormatText(var_422_6.content)

				arg_419_1.text_.text = var_422_7

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_9 = 21 <= 0 and var_422_5 or var_422_5 * (utf8.len(var_422_7) / 21)

				if (21 <= 0 and var_422_5 or var_422_5 * (utf8.len(var_422_7) / 21)) > 0 and var_422_5 < var_422_9 then
					arg_419_1.talkMaxDuration = var_422_9

					if var_422_9 + var_422_4 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_9 + var_422_4
					end
				end

				arg_419_1.text_.text = var_422_7
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101100", "story_v_side_new_1101101.awb") ~= 0 then
					local var_422_10 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101100", "story_v_side_new_1101101.awb") / 1000

					if var_422_10 + var_422_4 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_10 + var_422_4
					end

					if var_422_6.prefab_name ~= "" and arg_419_1.actors_[var_422_6.prefab_name] ~= nil then
						local var_422_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_6.prefab_name].transform, "story_v_side_new_1101101", "1101101100", "story_v_side_new_1101101.awb")

						arg_419_1:RecordAudio("1101101100", var_422_11)
						arg_419_1:RecordAudio("1101101100", var_422_11)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101100", "story_v_side_new_1101101.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101100", "story_v_side_new_1101101.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_12 = math.max(var_422_5, arg_419_1.talkMaxDuration)

			if var_422_4 <= arg_419_1.time_ and arg_419_1.time_ < var_422_4 + var_422_12 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_4) / var_422_12

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_4 + var_422_12 and arg_419_1.time_ < var_422_4 + var_422_12 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
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

		arg_419_1:InitPlayNodeList()
	end,
	Play1101101101 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1101101101
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1101101102(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(arg_423_1.actors_["1011ui_story"]) and arg_423_1.var_.characterEffect1011ui_story == nil then
				arg_423_1.var_.characterEffect1011ui_story = arg_423_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_0 = 0.200000002980232

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 and not isNil(arg_423_1.actors_["1011ui_story"]) then
				if arg_423_1.var_.characterEffect1011ui_story and not isNil(arg_423_1.actors_["1011ui_story"]) then
					arg_423_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_423_1.time_ - 0) / var_426_0)
				end
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 and not isNil(arg_423_1.actors_["1011ui_story"]) and arg_423_1.var_.characterEffect1011ui_story then
				arg_423_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_426_1 = 0
			local var_426_2 = 0.6

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 then
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

				local var_426_3 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(1101101101).content)

				arg_423_1.text_.text = var_426_3

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_5 = 24 <= 0 and var_426_2 or var_426_2 * (utf8.len(var_426_3) / 24)

				if (24 <= 0 and var_426_2 or var_426_2 * (utf8.len(var_426_3) / 24)) > 0 and var_426_2 < var_426_5 then
					arg_423_1.talkMaxDuration = var_426_5

					if var_426_5 + var_426_1 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_5 + var_426_1
					end
				end

				arg_423_1.text_.text = var_426_3
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_6 = math.max(var_426_2, arg_423_1.talkMaxDuration)

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_6 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_1) / var_426_6

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_1 + var_426_6 and arg_423_1.time_ < var_426_1 + var_426_6 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play1101101102 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 1101101102
		arg_427_1.duration_ = 4.9

		local var_427_0 = {
			zh = 3.4,
			ja = 4.9
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
				arg_427_0:Play1101101103(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.var_.moveOldPos1011ui_story = arg_427_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_430_0 = 0.001

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 then
				arg_427_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_427_1.time_ - 0) / var_430_0)
				arg_427_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_427_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1011ui_story"].transform.position).z)
				arg_427_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_427_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_427_1.actors_["1011ui_story"].transform.localEulerAngles = arg_427_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 then
				arg_427_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_427_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_427_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_427_1.actors_["1011ui_story"].transform.position).z)
				arg_427_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_427_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_427_1.actors_["1011ui_story"].transform.localEulerAngles = arg_427_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_430_1 = arg_427_1.actors_["1011ui_story"]

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(var_430_1) and arg_427_1.var_.characterEffect1011ui_story == nil then
				arg_427_1.var_.characterEffect1011ui_story = var_430_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_2 = 0.200000002980232

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_2 and not isNil(var_430_1) then
				if arg_427_1.var_.characterEffect1011ui_story and not isNil(var_430_1) then
					arg_427_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= 0 + var_430_2 and arg_427_1.time_ < 0 + var_430_2 + arg_430_0 and not isNil(var_430_1) and arg_427_1.var_.characterEffect1011ui_story then
				arg_427_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_430_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_427_1.bgmTxt_.text ~= var_430_6 and arg_427_1.bgmTxt_.text ~= "" then
						if arg_427_1.bgmTxt2_.text ~= "" then
							arg_427_1.bgmTxt_.text = arg_427_1.bgmTxt2_.text
						end

						arg_427_1.bgmTxt2_.text = var_430_6

						arg_427_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_427_1.bgmTxt_.text = var_430_6
						arg_427_1.bgmTxt2_.text = var_430_6
					end

					if arg_427_1.bgmTimer then
						arg_427_1.bgmTimer:Stop()

						arg_427_1.bgmTimer = nil
					end

					if arg_427_1.settingData.show_music_name == 1 then
						arg_427_1.musicController:SetSelectedState("show")
						arg_427_1.musicAnimator_:Play("open", 0, 0)

						if arg_427_1.settingData.music_time ~= 0 then
							arg_427_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_427_1.settingData.music_time), function()
								if arg_427_1 == nil or isNil(arg_427_1.bgmTxt_) then
									return
								end

								arg_427_1.musicController:SetSelectedState("hide")
								arg_427_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_430_7 = 0
			local var_430_8 = 0.15

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_7 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_9 = arg_427_1:GetWordFromCfg(1101101102)
				local var_430_10 = arg_427_1:FormatText(var_430_9.content)

				arg_427_1.text_.text = var_430_10

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_12 = 6 <= 0 and var_430_8 or var_430_8 * (utf8.len(var_430_10) / 6)

				if (6 <= 0 and var_430_8 or var_430_8 * (utf8.len(var_430_10) / 6)) > 0 and var_430_8 < var_430_12 then
					arg_427_1.talkMaxDuration = var_430_12

					if var_430_12 + var_430_7 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_12 + var_430_7
					end
				end

				arg_427_1.text_.text = var_430_10
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101102", "story_v_side_new_1101101.awb") ~= 0 then
					local var_430_13 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101102", "story_v_side_new_1101101.awb") / 1000

					if var_430_13 + var_430_7 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_13 + var_430_7
					end

					if var_430_9.prefab_name ~= "" and arg_427_1.actors_[var_430_9.prefab_name] ~= nil then
						local var_430_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_9.prefab_name].transform, "story_v_side_new_1101101", "1101101102", "story_v_side_new_1101101.awb")

						arg_427_1:RecordAudio("1101101102", var_430_14)
						arg_427_1:RecordAudio("1101101102", var_430_14)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101102", "story_v_side_new_1101101.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101102", "story_v_side_new_1101101.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_15 = math.max(var_430_8, arg_427_1.talkMaxDuration)

			if var_430_7 <= arg_427_1.time_ and arg_427_1.time_ < var_430_7 + var_430_15 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_7) / var_430_15

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_7 + var_430_15 and arg_427_1.time_ < var_430_7 + var_430_15 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
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

		arg_427_1:InitPlayNodeList()
	end,
	Play1101101103 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 1101101103
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play1101101104(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(arg_432_1.actors_["1011ui_story"]) and arg_432_1.var_.characterEffect1011ui_story == nil then
				arg_432_1.var_.characterEffect1011ui_story = arg_432_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_0 = 0.200000002980232

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_0 and not isNil(arg_432_1.actors_["1011ui_story"]) then
				if arg_432_1.var_.characterEffect1011ui_story and not isNil(arg_432_1.actors_["1011ui_story"]) then
					arg_432_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_432_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_432_1.time_ - 0) / var_435_0)
				end
			end

			if arg_432_1.time_ >= 0 + var_435_0 and arg_432_1.time_ < 0 + var_435_0 + arg_435_0 and not isNil(arg_432_1.actors_["1011ui_story"]) and arg_432_1.var_.characterEffect1011ui_story then
				arg_432_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_432_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_435_1 = 0
			local var_435_2 = 0.8

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, false)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_3 = arg_432_1:FormatText(arg_432_1:GetWordFromCfg(1101101103).content)

				arg_432_1.text_.text = var_435_3

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_5 = 32 <= 0 and var_435_2 or var_435_2 * (utf8.len(var_435_3) / 32)

				if (32 <= 0 and var_435_2 or var_435_2 * (utf8.len(var_435_3) / 32)) > 0 and var_435_2 < var_435_5 then
					arg_432_1.talkMaxDuration = var_435_5

					if var_435_5 + var_435_1 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_5 + var_435_1
					end
				end

				arg_432_1.text_.text = var_435_3
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_6 = math.max(var_435_2, arg_432_1.talkMaxDuration)

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_6 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_1) / var_435_6

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_1 + var_435_6 and arg_432_1.time_ < var_435_1 + var_435_6 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play1101101104 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 1101101104
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play1101101107(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = 0.075

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, true)
				arg_436_1.iconController_:SetSelectedState("hero")

				arg_436_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_436_1.callingController_:SetSelectedState("normal")

				arg_436_1.keyicon_.color = Color.New(1, 1, 1)
				arg_436_1.icon_.color = Color.New(1, 1, 1)

				local var_439_1 = arg_436_1:FormatText(arg_436_1:GetWordFromCfg(1101101104).content)

				arg_436_1.text_.text = var_439_1

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_3 = 3 <= 0 and var_439_0 or var_439_0 * (utf8.len(var_439_1) / 3)

				if (3 <= 0 and var_439_0 or var_439_0 * (utf8.len(var_439_1) / 3)) > 0 and var_439_0 < var_439_3 then
					arg_436_1.talkMaxDuration = var_439_3

					if var_439_3 + 0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_3 + 0
					end
				end

				arg_436_1.text_.text = var_439_1
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_4 = math.max(var_439_0, arg_436_1.talkMaxDuration)

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_4 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - 0) / var_439_4

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= 0 + var_439_4 and arg_436_1.time_ < 0 + var_439_4 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play1101101107 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 1101101107
		arg_440_1.duration_ = 8.83

		local var_440_0 = {
			zh = 5.133,
			ja = 8.833
		}
		local var_440_1 = manager.audio:GetLocalizationFlag()

		if var_440_0[var_440_1] ~= nil then
			arg_440_1.duration_ = var_440_0[var_440_1]
		end

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play1101101108(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_443_0 = 0
			local var_443_1 = 0.45

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_0 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_2 = arg_440_1:GetWordFromCfg(1101101107)
				local var_443_3 = arg_440_1:FormatText(var_443_2.content)

				arg_440_1.text_.text = var_443_3

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_5 = 18 <= 0 and var_443_1 or var_443_1 * (utf8.len(var_443_3) / 18)

				if (18 <= 0 and var_443_1 or var_443_1 * (utf8.len(var_443_3) / 18)) > 0 and var_443_1 < var_443_5 then
					arg_440_1.talkMaxDuration = var_443_5

					if var_443_5 + var_443_0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_5 + var_443_0
					end
				end

				arg_440_1.text_.text = var_443_3
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101107", "story_v_side_new_1101101.awb") ~= 0 then
					local var_443_6 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101107", "story_v_side_new_1101101.awb") / 1000

					if var_443_6 + var_443_0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_6 + var_443_0
					end

					if var_443_2.prefab_name ~= "" and arg_440_1.actors_[var_443_2.prefab_name] ~= nil then
						local var_443_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_2.prefab_name].transform, "story_v_side_new_1101101", "1101101107", "story_v_side_new_1101101.awb")

						arg_440_1:RecordAudio("1101101107", var_443_7)
						arg_440_1:RecordAudio("1101101107", var_443_7)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101107", "story_v_side_new_1101101.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101107", "story_v_side_new_1101101.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_8 = math.max(var_443_1, arg_440_1.talkMaxDuration)

			if var_443_0 <= arg_440_1.time_ and arg_440_1.time_ < var_443_0 + var_443_8 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_0) / var_443_8

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_0 + var_443_8 and arg_440_1.time_ < var_443_0 + var_443_8 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play1101101108 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 1101101108
		arg_444_1.duration_ = 1

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"

			SetActive(arg_444_1.choicesGo_, true)

			for iter_445_0, iter_445_1 in ipairs(arg_444_1.choices_) do
				SetActive(iter_445_1.go, iter_445_0 <= 1)
			end

			arg_444_1.choices_[1].txt.text = arg_444_1:FormatText(StoryChoiceCfg[608].name)
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play1101101109(arg_444_1)
			end

			arg_444_1:RecordChoiceLog(1101101108, 608)
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(arg_444_1.actors_["1011ui_story"]) and arg_444_1.var_.characterEffect1011ui_story == nil then
				arg_444_1.var_.characterEffect1011ui_story = arg_444_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_447_0 = 0.200000002980232

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_0 and not isNil(arg_444_1.actors_["1011ui_story"]) then
				if arg_444_1.var_.characterEffect1011ui_story and not isNil(arg_444_1.actors_["1011ui_story"]) then
					arg_444_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_444_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_444_1.time_ - 0) / var_447_0)
				end
			end

			if arg_444_1.time_ >= 0 + var_447_0 and arg_444_1.time_ < 0 + var_447_0 + arg_447_0 and not isNil(arg_444_1.actors_["1011ui_story"]) and arg_444_1.var_.characterEffect1011ui_story then
				arg_444_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_444_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_447_1 = 0

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 then
				arg_444_1.allBtn_.enabled = false
			end

			if arg_444_1.time_ >= var_447_1 + 0.5 and arg_444_1.time_ < var_447_1 + 0.5 + arg_447_0 then
				arg_444_1.allBtn_.enabled = true
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play1101101109 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 1101101109
		arg_448_1.duration_ = 3.17

		local var_448_0 = {
			zh = 2.066,
			ja = 3.166
		}
		local var_448_1 = manager.audio:GetLocalizationFlag()

		if var_448_0[var_448_1] ~= nil then
			arg_448_1.duration_ = var_448_0[var_448_1]
		end

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play1101101110(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.var_.moveOldPos1011ui_story = arg_448_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_451_0 = 0.001

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_0 then
				arg_448_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_448_1.time_ - 0) / var_451_0)
				arg_448_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_448_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_448_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_448_1.actors_["1011ui_story"].transform.position).z)
				arg_448_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_448_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_448_1.actors_["1011ui_story"].transform.localEulerAngles = arg_448_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_448_1.time_ >= 0 + var_451_0 and arg_448_1.time_ < 0 + var_451_0 + arg_451_0 then
				arg_448_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_448_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_448_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_448_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_448_1.actors_["1011ui_story"].transform.position).z)
				arg_448_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_448_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_448_1.actors_["1011ui_story"].transform.localEulerAngles = arg_448_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_451_1 = arg_448_1.actors_["1011ui_story"]

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 and not isNil(var_451_1) and arg_448_1.var_.characterEffect1011ui_story == nil then
				arg_448_1.var_.characterEffect1011ui_story = var_451_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_2 = 0.200000002980232

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_2 and not isNil(var_451_1) then
				if arg_448_1.var_.characterEffect1011ui_story and not isNil(var_451_1) then
					arg_448_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_448_1.time_ >= 0 + var_451_2 and arg_448_1.time_ < 0 + var_451_2 + arg_451_0 and not isNil(var_451_1) and arg_448_1.var_.characterEffect1011ui_story then
				arg_448_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_451_4 = 0
			local var_451_5 = 0.2

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_4 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_6 = arg_448_1:GetWordFromCfg(1101101109)
				local var_451_7 = arg_448_1:FormatText(var_451_6.content)

				arg_448_1.text_.text = var_451_7

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_9 = 8 <= 0 and var_451_5 or var_451_5 * (utf8.len(var_451_7) / 8)

				if (8 <= 0 and var_451_5 or var_451_5 * (utf8.len(var_451_7) / 8)) > 0 and var_451_5 < var_451_9 then
					arg_448_1.talkMaxDuration = var_451_9

					if var_451_9 + var_451_4 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_9 + var_451_4
					end
				end

				arg_448_1.text_.text = var_451_7
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101109", "story_v_side_new_1101101.awb") ~= 0 then
					local var_451_10 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101109", "story_v_side_new_1101101.awb") / 1000

					if var_451_10 + var_451_4 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_10 + var_451_4
					end

					if var_451_6.prefab_name ~= "" and arg_448_1.actors_[var_451_6.prefab_name] ~= nil then
						local var_451_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_6.prefab_name].transform, "story_v_side_new_1101101", "1101101109", "story_v_side_new_1101101.awb")

						arg_448_1:RecordAudio("1101101109", var_451_11)
						arg_448_1:RecordAudio("1101101109", var_451_11)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101109", "story_v_side_new_1101101.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101109", "story_v_side_new_1101101.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_12 = math.max(var_451_5, arg_448_1.talkMaxDuration)

			if var_451_4 <= arg_448_1.time_ and arg_448_1.time_ < var_451_4 + var_451_12 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_4) / var_451_12

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_4 + var_451_12 and arg_448_1.time_ < var_451_4 + var_451_12 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {
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

		arg_448_1:InitPlayNodeList()
	end,
	Play1101101110 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 1101101110
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play1101101111(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 and not isNil(arg_452_1.actors_["1011ui_story"]) and arg_452_1.var_.characterEffect1011ui_story == nil then
				arg_452_1.var_.characterEffect1011ui_story = arg_452_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_0 = 0.200000002980232

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_0 and not isNil(arg_452_1.actors_["1011ui_story"]) then
				if arg_452_1.var_.characterEffect1011ui_story and not isNil(arg_452_1.actors_["1011ui_story"]) then
					arg_452_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_452_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_452_1.time_ - 0) / var_455_0)
				end
			end

			if arg_452_1.time_ >= 0 + var_455_0 and arg_452_1.time_ < 0 + var_455_0 + arg_455_0 and not isNil(arg_452_1.actors_["1011ui_story"]) and arg_452_1.var_.characterEffect1011ui_story then
				arg_452_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_452_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_455_1 = 0
			local var_455_2 = 0.525

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, false)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_3 = arg_452_1:FormatText(arg_452_1:GetWordFromCfg(1101101110).content)

				arg_452_1.text_.text = var_455_3

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_5 = 21 <= 0 and var_455_2 or var_455_2 * (utf8.len(var_455_3) / 21)

				if (21 <= 0 and var_455_2 or var_455_2 * (utf8.len(var_455_3) / 21)) > 0 and var_455_2 < var_455_5 then
					arg_452_1.talkMaxDuration = var_455_5

					if var_455_5 + var_455_1 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_5 + var_455_1
					end
				end

				arg_452_1.text_.text = var_455_3
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_6 = math.max(var_455_2, arg_452_1.talkMaxDuration)

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_6 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_1) / var_455_6

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_1 + var_455_6 and arg_452_1.time_ < var_455_1 + var_455_6 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play1101101111 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 1101101111
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play1101101112(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = 0.825

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				arg_456_1.leftNameTxt_.text = arg_456_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, true)
				arg_456_1.iconController_:SetSelectedState("hero")

				arg_456_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_456_1.callingController_:SetSelectedState("normal")

				arg_456_1.keyicon_.color = Color.New(1, 1, 1)
				arg_456_1.icon_.color = Color.New(1, 1, 1)

				local var_459_1 = arg_456_1:FormatText(arg_456_1:GetWordFromCfg(1101101111).content)

				arg_456_1.text_.text = var_459_1

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_3 = 33 <= 0 and var_459_0 or var_459_0 * (utf8.len(var_459_1) / 33)

				if (33 <= 0 and var_459_0 or var_459_0 * (utf8.len(var_459_1) / 33)) > 0 and var_459_0 < var_459_3 then
					arg_456_1.talkMaxDuration = var_459_3

					if var_459_3 + 0 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_3 + 0
					end
				end

				arg_456_1.text_.text = var_459_1
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_4 = math.max(var_459_0, arg_456_1.talkMaxDuration)

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_4 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - 0) / var_459_4

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= 0 + var_459_4 and arg_456_1.time_ < 0 + var_459_4 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {}

		arg_456_1:InitPlayNodeList()
	end,
	Play1101101112 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 1101101112
		arg_460_1.duration_ = 3.53

		local var_460_0 = {
			zh = 2.366,
			ja = 3.533
		}
		local var_460_1 = manager.audio:GetLocalizationFlag()

		if var_460_0[var_460_1] ~= nil then
			arg_460_1.duration_ = var_460_0[var_460_1]
		end

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play1101101113(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1.var_.moveOldPos1011ui_story = arg_460_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_463_0 = 0.001

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_0 then
				arg_460_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_460_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_460_1.time_ - 0) / var_463_0)
				arg_460_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_460_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1011ui_story"].transform.position).z)
				arg_460_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_460_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_460_1.actors_["1011ui_story"].transform.localEulerAngles = arg_460_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_460_1.time_ >= 0 + var_463_0 and arg_460_1.time_ < 0 + var_463_0 + arg_463_0 then
				arg_460_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_460_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_460_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_460_1.actors_["1011ui_story"].transform.position).z)
				arg_460_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_460_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_460_1.actors_["1011ui_story"].transform.localEulerAngles = arg_460_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_463_1 = arg_460_1.actors_["1011ui_story"]

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 and not isNil(var_463_1) and arg_460_1.var_.characterEffect1011ui_story == nil then
				arg_460_1.var_.characterEffect1011ui_story = var_463_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_463_2 = 0.200000002980232

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_2 and not isNil(var_463_1) then
				if arg_460_1.var_.characterEffect1011ui_story and not isNil(var_463_1) then
					arg_460_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_460_1.time_ >= 0 + var_463_2 and arg_460_1.time_ < 0 + var_463_2 + arg_463_0 and not isNil(var_463_1) and arg_460_1.var_.characterEffect1011ui_story then
				arg_460_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 then
				arg_460_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_463_4 = 0
			local var_463_5 = 0.175

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_4 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_6 = arg_460_1:GetWordFromCfg(1101101112)
				local var_463_7 = arg_460_1:FormatText(var_463_6.content)

				arg_460_1.text_.text = var_463_7

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_9 = 7 <= 0 and var_463_5 or var_463_5 * (utf8.len(var_463_7) / 7)

				if (7 <= 0 and var_463_5 or var_463_5 * (utf8.len(var_463_7) / 7)) > 0 and var_463_5 < var_463_9 then
					arg_460_1.talkMaxDuration = var_463_9

					if var_463_9 + var_463_4 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_9 + var_463_4
					end
				end

				arg_460_1.text_.text = var_463_7
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101112", "story_v_side_new_1101101.awb") ~= 0 then
					local var_463_10 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101112", "story_v_side_new_1101101.awb") / 1000

					if var_463_10 + var_463_4 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_10 + var_463_4
					end

					if var_463_6.prefab_name ~= "" and arg_460_1.actors_[var_463_6.prefab_name] ~= nil then
						local var_463_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_460_1.actors_[var_463_6.prefab_name].transform, "story_v_side_new_1101101", "1101101112", "story_v_side_new_1101101.awb")

						arg_460_1:RecordAudio("1101101112", var_463_11)
						arg_460_1:RecordAudio("1101101112", var_463_11)
					else
						arg_460_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101112", "story_v_side_new_1101101.awb")
					end

					arg_460_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101112", "story_v_side_new_1101101.awb")
				end

				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_12 = math.max(var_463_5, arg_460_1.talkMaxDuration)

			if var_463_4 <= arg_460_1.time_ and arg_460_1.time_ < var_463_4 + var_463_12 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_4) / var_463_12

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_4 + var_463_12 and arg_460_1.time_ < var_463_4 + var_463_12 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {
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

		arg_460_1:InitPlayNodeList()
	end,
	Play1101101113 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 1101101113
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play1101101114(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(arg_464_1.actors_["1011ui_story"]) and arg_464_1.var_.characterEffect1011ui_story == nil then
				arg_464_1.var_.characterEffect1011ui_story = arg_464_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_467_0 = 0.200000002980232

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_0 and not isNil(arg_464_1.actors_["1011ui_story"]) then
				if arg_464_1.var_.characterEffect1011ui_story and not isNil(arg_464_1.actors_["1011ui_story"]) then
					arg_464_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_464_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_464_1.time_ - 0) / var_467_0)
				end
			end

			if arg_464_1.time_ >= 0 + var_467_0 and arg_464_1.time_ < 0 + var_467_0 + arg_467_0 and not isNil(arg_464_1.actors_["1011ui_story"]) and arg_464_1.var_.characterEffect1011ui_story then
				arg_464_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_464_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_467_1 = 0
			local var_467_2 = 0.15

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_1 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				arg_464_1.leftNameTxt_.text = arg_464_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, true)
				arg_464_1.iconController_:SetSelectedState("hero")

				arg_464_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_464_1.callingController_:SetSelectedState("normal")

				arg_464_1.keyicon_.color = Color.New(1, 1, 1)
				arg_464_1.icon_.color = Color.New(1, 1, 1)

				local var_467_3 = arg_464_1:FormatText(arg_464_1:GetWordFromCfg(1101101113).content)

				arg_464_1.text_.text = var_467_3

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_5 = 6 <= 0 and var_467_2 or var_467_2 * (utf8.len(var_467_3) / 6)

				if (6 <= 0 and var_467_2 or var_467_2 * (utf8.len(var_467_3) / 6)) > 0 and var_467_2 < var_467_5 then
					arg_464_1.talkMaxDuration = var_467_5

					if var_467_5 + var_467_1 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_5 + var_467_1
					end
				end

				arg_464_1.text_.text = var_467_3
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_6 = math.max(var_467_2, arg_464_1.talkMaxDuration)

			if var_467_1 <= arg_464_1.time_ and arg_464_1.time_ < var_467_1 + var_467_6 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_1) / var_467_6

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_1 + var_467_6 and arg_464_1.time_ < var_467_1 + var_467_6 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play1101101114 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 1101101114
		arg_468_1.duration_ = 2

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play1101101115(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1.var_.moveOldPos1011ui_story = arg_468_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_471_0 = 0.001

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_0 then
				arg_468_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_468_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_468_1.time_ - 0) / var_471_0)
				arg_468_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_468_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["1011ui_story"].transform.position).z)
				arg_468_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_468_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_468_1.actors_["1011ui_story"].transform.localEulerAngles = arg_468_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_468_1.time_ >= 0 + var_471_0 and arg_468_1.time_ < 0 + var_471_0 + arg_471_0 then
				arg_468_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_468_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_468_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_468_1.actors_["1011ui_story"].transform.position).z)
				arg_468_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_468_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_468_1.actors_["1011ui_story"].transform.localEulerAngles = arg_468_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_471_1 = arg_468_1.actors_["1011ui_story"]

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 and not isNil(var_471_1) and arg_468_1.var_.characterEffect1011ui_story == nil then
				arg_468_1.var_.characterEffect1011ui_story = var_471_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_471_2 = 0.200000002980232

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_2 and not isNil(var_471_1) then
				if arg_468_1.var_.characterEffect1011ui_story and not isNil(var_471_1) then
					arg_468_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_468_1.time_ >= 0 + var_471_2 and arg_468_1.time_ < 0 + var_471_2 + arg_471_0 and not isNil(var_471_1) and arg_468_1.var_.characterEffect1011ui_story then
				arg_468_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_471_4 = 0
			local var_471_5 = 0.05

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_4 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				arg_468_1.leftNameTxt_.text = arg_468_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_6 = arg_468_1:GetWordFromCfg(1101101114)
				local var_471_7 = arg_468_1:FormatText(var_471_6.content)

				arg_468_1.text_.text = var_471_7

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_9 = 2 <= 0 and var_471_5 or var_471_5 * (utf8.len(var_471_7) / 2)

				if (2 <= 0 and var_471_5 or var_471_5 * (utf8.len(var_471_7) / 2)) > 0 and var_471_5 < var_471_9 then
					arg_468_1.talkMaxDuration = var_471_9

					if var_471_9 + var_471_4 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_9 + var_471_4
					end
				end

				arg_468_1.text_.text = var_471_7
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101114", "story_v_side_new_1101101.awb") ~= 0 then
					local var_471_10 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101114", "story_v_side_new_1101101.awb") / 1000

					if var_471_10 + var_471_4 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_10 + var_471_4
					end

					if var_471_6.prefab_name ~= "" and arg_468_1.actors_[var_471_6.prefab_name] ~= nil then
						local var_471_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_468_1.actors_[var_471_6.prefab_name].transform, "story_v_side_new_1101101", "1101101114", "story_v_side_new_1101101.awb")

						arg_468_1:RecordAudio("1101101114", var_471_11)
						arg_468_1:RecordAudio("1101101114", var_471_11)
					else
						arg_468_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101114", "story_v_side_new_1101101.awb")
					end

					arg_468_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101114", "story_v_side_new_1101101.awb")
				end

				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_12 = math.max(var_471_5, arg_468_1.talkMaxDuration)

			if var_471_4 <= arg_468_1.time_ and arg_468_1.time_ < var_471_4 + var_471_12 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_4) / var_471_12

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_4 + var_471_12 and arg_468_1.time_ < var_471_4 + var_471_12 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {
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

		arg_468_1:InitPlayNodeList()
	end,
	Play1101101115 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 1101101115
		arg_472_1.duration_ = 9.57

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play1101101116(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			if arg_472_1.bgs_.ST01a == nil then
				local var_475_0 = Object.Instantiate(arg_472_1.paintGo_)

				var_475_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01a")
				var_475_0.name = "ST01a"
				var_475_0.transform.parent = arg_472_1.stage_.transform
				var_475_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_472_1.bgs_.ST01a = var_475_0
			end

			if 2 < arg_472_1.time_ and arg_472_1.time_ <= 2 + arg_475_0 then
				local var_475_1 = arg_472_1.bgs_.ST01a

				arg_472_1.bgs_.ST01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_475_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_475_2 = var_475_1:GetComponent("SpriteRenderer")

				if var_475_2 and var_475_2.sprite then
					local var_475_3 = 2 * (var_475_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_475_1.transform.localScale = Vector3.New(var_475_3 / var_475_2.sprite.bounds.size.y < var_475_3 * manager.ui.mainCameraCom_.aspect / var_475_2.sprite.bounds.size.x and var_475_3 * manager.ui.mainCameraCom_.aspect / var_475_2.sprite.bounds.size.x or var_475_3 / var_475_2.sprite.bounds.size.y, var_475_3 / var_475_2.sprite.bounds.size.y < var_475_3 * manager.ui.mainCameraCom_.aspect / var_475_2.sprite.bounds.size.x and var_475_3 * manager.ui.mainCameraCom_.aspect / var_475_2.sprite.bounds.size.x or var_475_3 / var_475_2.sprite.bounds.size.y, 0)
				end

				for iter_475_0, iter_475_1 in pairs(arg_472_1.bgs_) do
					if iter_475_0 ~= "ST01a" then
						iter_475_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_475_4 = 0

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_4 + arg_475_0 then
				arg_472_1.mask_.enabled = true
				arg_472_1.mask_.raycastTarget = true

				arg_472_1:SetGaussion(false)
			end

			local var_475_5 = 2

			if var_475_4 <= arg_472_1.time_ and arg_472_1.time_ < var_475_4 + var_475_5 then
				local var_475_6 = Color.New(0, 0, 0)

				var_475_6.a = Mathf.Lerp(0, 1, (arg_472_1.time_ - var_475_4) / var_475_5)
				arg_472_1.mask_.color = var_475_6
			end

			if arg_472_1.time_ >= var_475_4 + var_475_5 and arg_472_1.time_ < var_475_4 + var_475_5 + arg_475_0 then
				local var_475_7 = Color.New(0, 0, 0)

				var_475_7.a = 1
				arg_472_1.mask_.color = var_475_7
			end

			local var_475_8 = 2

			if 2 < arg_472_1.time_ and arg_472_1.time_ <= var_475_8 + arg_475_0 then
				arg_472_1.mask_.enabled = true
				arg_472_1.mask_.raycastTarget = true

				arg_472_1:SetGaussion(false)
			end

			local var_475_9 = 2

			if var_475_8 <= arg_472_1.time_ and arg_472_1.time_ < var_475_8 + var_475_9 then
				local var_475_10 = Color.New(0, 0, 0)

				var_475_10.a = Mathf.Lerp(1, 0, (arg_472_1.time_ - var_475_8) / var_475_9)
				arg_472_1.mask_.color = var_475_10
			end

			if arg_472_1.time_ >= var_475_8 + var_475_9 and arg_472_1.time_ < var_475_8 + var_475_9 + arg_475_0 then
				local var_475_11 = Color.New(0, 0, 0)

				arg_472_1.mask_.enabled = false
				var_475_11.a = 0
				arg_472_1.mask_.color = var_475_11
			end

			local var_475_12 = arg_472_1.actors_["1011ui_story"].transform

			if 2 < arg_472_1.time_ and arg_472_1.time_ <= 2 + arg_475_0 then
				arg_472_1.var_.moveOldPos1011ui_story = var_475_12.localPosition
			end

			local var_475_13 = 0.001

			if 2 <= arg_472_1.time_ and arg_472_1.time_ < 2 + var_475_13 then
				var_475_12.localPosition = Vector3.Lerp(arg_472_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_472_1.time_ - 2) / var_475_13)
				var_475_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_475_12.position).x, (manager.ui.mainCamera.transform.position - var_475_12.position).y, (manager.ui.mainCamera.transform.position - var_475_12.position).z)
				var_475_12.localEulerAngles.z = 0
				var_475_12.localEulerAngles.x = 0
				var_475_12.localEulerAngles = var_475_12.localEulerAngles
			end

			if arg_472_1.time_ >= 2 + var_475_13 and arg_472_1.time_ < 2 + var_475_13 + arg_475_0 then
				var_475_12.localPosition = Vector3.New(0, 100, 0)
				var_475_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_475_12.position).x, (manager.ui.mainCamera.transform.position - var_475_12.position).y, (manager.ui.mainCamera.transform.position - var_475_12.position).z)
				var_475_12.localEulerAngles.z = 0
				var_475_12.localEulerAngles.x = 0
				var_475_12.localEulerAngles = var_475_12.localEulerAngles
			end

			if 2 < arg_472_1.time_ and arg_472_1.time_ <= 2 + arg_475_0 then
				arg_472_1.fswbg_:SetActive(true)
				arg_472_1.dialog_:SetActive(false)

				arg_472_1.fswtw_.percent = 0
				arg_472_1.fswt_.text = arg_472_1:FormatText(arg_472_1:GetWordFromCfg(1101101115).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.fswt_)

				arg_472_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_472_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_472_1.fswtw_:SetDirty()

				arg_472_1.typewritterCharCountI18N = 0

				SetActive(arg_472_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_472_1:ShowNextGo(false)
			end

			local var_475_14 = 4

			if 4 < arg_472_1.time_ and arg_472_1.time_ <= var_475_14 + arg_475_0 then
				arg_472_1.var_.oldValueTypewriter = arg_472_1.fswtw_.percent

				SetActive(arg_472_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_472_1:ShowNextGo(false)
			end

			local var_475_15 = 20
			local var_475_16 = 1.33333333333333
			local var_475_17, var_475_18 = arg_472_1:GetPercentByPara(arg_472_1:FormatText(arg_472_1:GetWordFromCfg(1101101115).content), 1)

			if var_475_14 < arg_472_1.time_ and arg_472_1.time_ <= var_475_14 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0

				local var_475_19 = var_475_15 <= 0 and var_475_16 or var_475_16 * ((var_475_18 - arg_472_1.typewritterCharCountI18N) / var_475_15)

				if (var_475_15 <= 0 and var_475_16 or var_475_16 * ((var_475_18 - arg_472_1.typewritterCharCountI18N) / var_475_15)) > 0 and var_475_16 < var_475_19 then
					arg_472_1.talkMaxDuration = var_475_19

					if var_475_19 + var_475_14 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_19 + var_475_14
					end
				end
			end

			local var_475_20 = math.max(1.33333333333333, arg_472_1.talkMaxDuration)

			if var_475_14 <= arg_472_1.time_ and arg_472_1.time_ < var_475_14 + var_475_20 then
				arg_472_1.fswtw_.percent = Mathf.Lerp(arg_472_1.var_.oldValueTypewriter, var_475_17, (arg_472_1.time_ - var_475_14) / var_475_20)
				arg_472_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_472_1.fswtw_:SetDirty()
			end

			if arg_472_1.time_ >= var_475_14 + var_475_20 and arg_472_1.time_ < var_475_14 + var_475_20 + arg_475_0 then
				arg_472_1.fswtw_.percent = var_475_17

				arg_472_1.fswtw_:SetDirty()
				arg_472_1:ShowNextGo(true)

				arg_472_1.typewritterCharCountI18N = var_475_18
			end

			if 4 < arg_472_1.time_ and arg_472_1.time_ <= 4 + arg_475_0 then
				local var_475_21 = arg_472_1.fswbg_.transform:Find("textbox/adapt/content") or arg_472_1.fswbg_.transform:Find("textbox/content")
				local var_475_22 = arg_472_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_475_23 = var_475_21:GetComponent("RectTransform")

				var_475_21:GetComponent("Text").alignment = UnityEngine.TextAnchor.UpperLeft
				var_475_23.offsetMin = Vector2.New(0, 0)
				var_475_23.offsetMax = Vector2.New(0, 0)
			end

			local var_475_24 = 4
			local var_475_25 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101115", "story_v_side_new_1101101.awb") / 1000

			if var_475_25 > 0 and 5.566 < var_475_25 and var_475_25 + var_475_24 > arg_472_1.duration_ then
				arg_472_1.duration_ = var_475_25 + var_475_24
			end

			if var_475_24 < arg_472_1.time_ and arg_472_1.time_ <= var_475_24 + arg_475_0 then
				arg_472_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101115", "story_v_side_new_1101101.awb")
			end

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_475_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_472_1.bgmTxt_.text ~= var_475_29 and arg_472_1.bgmTxt_.text ~= "" then
						if arg_472_1.bgmTxt2_.text ~= "" then
							arg_472_1.bgmTxt_.text = arg_472_1.bgmTxt2_.text
						end

						arg_472_1.bgmTxt2_.text = var_475_29

						arg_472_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_472_1.bgmTxt_.text = var_475_29
						arg_472_1.bgmTxt2_.text = var_475_29
					end

					if arg_472_1.bgmTimer then
						arg_472_1.bgmTimer:Stop()

						arg_472_1.bgmTimer = nil
					end

					if arg_472_1.settingData.show_music_name == 1 then
						arg_472_1.musicController:SetSelectedState("show")
						arg_472_1.musicAnimator_:Play("open", 0, 0)

						if arg_472_1.settingData.music_time ~= 0 then
							arg_472_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_472_1.settingData.music_time), function()
								if arg_472_1 == nil or isNil(arg_472_1.bgmTxt_) then
									return
								end

								arg_472_1.musicController:SetSelectedState("hide")
								arg_472_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.533333333333333 < arg_472_1.time_ and arg_472_1.time_ <= 0.533333333333333 + arg_475_0 then
				arg_472_1:AudioAction("play", "music", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui.awb")

				local var_475_32 = manager.audio:GetAudioName("bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui")

				if "" ~= "" then
					if arg_472_1.bgmTxt_.text ~= var_475_32 and arg_472_1.bgmTxt_.text ~= "" then
						if arg_472_1.bgmTxt2_.text ~= "" then
							arg_472_1.bgmTxt_.text = arg_472_1.bgmTxt2_.text
						end

						arg_472_1.bgmTxt2_.text = var_475_32

						arg_472_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_472_1.bgmTxt_.text = var_475_32
						arg_472_1.bgmTxt2_.text = var_475_32
					end

					if arg_472_1.bgmTimer then
						arg_472_1.bgmTimer:Stop()

						arg_472_1.bgmTimer = nil
					end

					if arg_472_1.settingData.show_music_name == 1 then
						arg_472_1.musicController:SetSelectedState("show")
						arg_472_1.musicAnimator_:Play("open", 0, 0)

						if arg_472_1.settingData.music_time ~= 0 then
							arg_472_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_472_1.settingData.music_time), function()
								if arg_472_1 == nil or isNil(arg_472_1.bgmTxt_) then
									return
								end

								arg_472_1.musicController:SetSelectedState("hide")
								arg_472_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_472_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_472_1:InitPlayNodeList()
	end,
	Play1101101116 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 1101101116
		arg_478_1.duration_ = 4.73

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play1101101117(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1.var_.oldValueTypewriter = arg_478_1.fswtw_.percent

				SetActive(arg_478_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_478_1:ShowNextGo(false)
			end

			local var_481_0 = 20
			local var_481_1 = 1.33333333333333
			local var_481_2, var_481_3 = arg_478_1:GetPercentByPara(arg_478_1:FormatText(arg_478_1:GetWordFromCfg(1101101115).content), 2)

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0

				local var_481_4 = var_481_0 <= 0 and var_481_1 or var_481_1 * ((var_481_3 - arg_478_1.typewritterCharCountI18N) / var_481_0)

				if (var_481_0 <= 0 and var_481_1 or var_481_1 * ((var_481_3 - arg_478_1.typewritterCharCountI18N) / var_481_0)) > 0 and var_481_1 < var_481_4 then
					arg_478_1.talkMaxDuration = var_481_4

					if var_481_4 + 0 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_4 + 0
					end
				end
			end

			local var_481_5 = math.max(1.33333333333333, arg_478_1.talkMaxDuration)

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_5 then
				arg_478_1.fswtw_.percent = Mathf.Lerp(arg_478_1.var_.oldValueTypewriter, var_481_2, (arg_478_1.time_ - 0) / var_481_5)
				arg_478_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_478_1.fswtw_:SetDirty()
			end

			if arg_478_1.time_ >= 0 + var_481_5 and arg_478_1.time_ < 0 + var_481_5 + arg_481_0 then
				arg_478_1.fswtw_.percent = var_481_2

				arg_478_1.fswtw_:SetDirty()
				arg_478_1:ShowNextGo(true)

				arg_478_1.typewritterCharCountI18N = var_481_3
			end

			local var_481_6 = 0
			local var_481_7 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101116", "story_v_side_new_1101101.awb") / 1000

			if var_481_7 > 0 and 4.733 < var_481_7 and var_481_7 + var_481_6 > arg_478_1.duration_ then
				arg_478_1.duration_ = var_481_7 + var_481_6
			end

			if var_481_6 < arg_478_1.time_ and arg_478_1.time_ <= var_481_6 + arg_481_0 then
				arg_478_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101116", "story_v_side_new_1101101.awb")
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play1101101117 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 1101101117
		arg_482_1.duration_ = 3.37

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play1101101118(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1.var_.oldValueTypewriter = arg_482_1.fswtw_.percent

				SetActive(arg_482_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_482_1:ShowNextGo(false)
			end

			local var_485_0 = 12
			local var_485_1 = 0.8
			local var_485_2, var_485_3 = arg_482_1:GetPercentByPara(arg_482_1:FormatText(arg_482_1:GetWordFromCfg(1101101115).content), 3)

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0

				local var_485_4 = var_485_0 <= 0 and var_485_1 or var_485_1 * ((var_485_3 - arg_482_1.typewritterCharCountI18N) / var_485_0)

				if (var_485_0 <= 0 and var_485_1 or var_485_1 * ((var_485_3 - arg_482_1.typewritterCharCountI18N) / var_485_0)) > 0 and var_485_1 < var_485_4 then
					arg_482_1.talkMaxDuration = var_485_4

					if var_485_4 + 0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_4 + 0
					end
				end
			end

			local var_485_5 = math.max(0.8, arg_482_1.talkMaxDuration)

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_5 then
				arg_482_1.fswtw_.percent = Mathf.Lerp(arg_482_1.var_.oldValueTypewriter, var_485_2, (arg_482_1.time_ - 0) / var_485_5)
				arg_482_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_482_1.fswtw_:SetDirty()
			end

			if arg_482_1.time_ >= 0 + var_485_5 and arg_482_1.time_ < 0 + var_485_5 + arg_485_0 then
				arg_482_1.fswtw_.percent = var_485_2

				arg_482_1.fswtw_:SetDirty()
				arg_482_1:ShowNextGo(true)

				arg_482_1.typewritterCharCountI18N = var_485_3
			end

			local var_485_6 = 0
			local var_485_7 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101117", "story_v_side_new_1101101.awb") / 1000

			if var_485_7 > 0 and 3.366 < var_485_7 and var_485_7 + var_485_6 > arg_482_1.duration_ then
				arg_482_1.duration_ = var_485_7 + var_485_6
			end

			if var_485_6 < arg_482_1.time_ and arg_482_1.time_ <= var_485_6 + arg_485_0 then
				arg_482_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101117", "story_v_side_new_1101101.awb")
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play1101101118 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 1101101118
		arg_486_1.duration_ = 6.17

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play1101101119(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1.var_.oldValueTypewriter = arg_486_1.fswtw_.percent

				SetActive(arg_486_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_486_1:ShowNextGo(false)
			end

			local var_489_0 = 15
			local var_489_1 = 1
			local var_489_2, var_489_3 = arg_486_1:GetPercentByPara(arg_486_1:FormatText(arg_486_1:GetWordFromCfg(1101101115).content), 4)

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0

				local var_489_4 = var_489_0 <= 0 and var_489_1 or var_489_1 * ((var_489_3 - arg_486_1.typewritterCharCountI18N) / var_489_0)

				if (var_489_0 <= 0 and var_489_1 or var_489_1 * ((var_489_3 - arg_486_1.typewritterCharCountI18N) / var_489_0)) > 0 and var_489_1 < var_489_4 then
					arg_486_1.talkMaxDuration = var_489_4

					if var_489_4 + 0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_4 + 0
					end
				end
			end

			local var_489_5 = math.max(1, arg_486_1.talkMaxDuration)

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_5 then
				arg_486_1.fswtw_.percent = Mathf.Lerp(arg_486_1.var_.oldValueTypewriter, var_489_2, (arg_486_1.time_ - 0) / var_489_5)
				arg_486_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_486_1.fswtw_:SetDirty()
			end

			if arg_486_1.time_ >= 0 + var_489_5 and arg_486_1.time_ < 0 + var_489_5 + arg_489_0 then
				arg_486_1.fswtw_.percent = var_489_2

				arg_486_1.fswtw_:SetDirty()
				arg_486_1:ShowNextGo(true)

				arg_486_1.typewritterCharCountI18N = var_489_3
			end

			local var_489_6 = 0
			local var_489_7 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101118", "story_v_side_new_1101101.awb") / 1000

			if var_489_7 > 0 and 6.166 < var_489_7 and var_489_7 + var_489_6 > arg_486_1.duration_ then
				arg_486_1.duration_ = var_489_7 + var_489_6
			end

			if var_489_6 < arg_486_1.time_ and arg_486_1.time_ <= var_489_6 + arg_489_0 then
				arg_486_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101118", "story_v_side_new_1101101.awb")
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play1101101119 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 1101101119
		arg_490_1.duration_ = 1

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play1101101120(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1.var_.oldValueTypewriter = arg_490_1.fswtw_.percent

				SetActive(arg_490_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_490_1:ShowNextGo(false)
			end

			local var_493_0 = 2
			local var_493_1 = 0.133333333333333
			local var_493_2, var_493_3 = arg_490_1:GetPercentByPara(arg_490_1:FormatText(arg_490_1:GetWordFromCfg(1101101115).content), 5)

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0

				local var_493_4 = var_493_0 <= 0 and var_493_1 or var_493_1 * ((var_493_3 - arg_490_1.typewritterCharCountI18N) / var_493_0)

				if (var_493_0 <= 0 and var_493_1 or var_493_1 * ((var_493_3 - arg_490_1.typewritterCharCountI18N) / var_493_0)) > 0 and var_493_1 < var_493_4 then
					arg_490_1.talkMaxDuration = var_493_4

					if var_493_4 + 0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_4 + 0
					end
				end
			end

			local var_493_5 = math.max(0.133333333333333, arg_490_1.talkMaxDuration)

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_5 then
				arg_490_1.fswtw_.percent = Mathf.Lerp(arg_490_1.var_.oldValueTypewriter, var_493_2, (arg_490_1.time_ - 0) / var_493_5)
				arg_490_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_490_1.fswtw_:SetDirty()
			end

			if arg_490_1.time_ >= 0 + var_493_5 and arg_490_1.time_ < 0 + var_493_5 + arg_493_0 then
				arg_490_1.fswtw_.percent = var_493_2

				arg_490_1.fswtw_:SetDirty()
				arg_490_1:ShowNextGo(true)

				arg_490_1.typewritterCharCountI18N = var_493_3
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play1101101120 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 1101101120
		arg_494_1.duration_ = 5.73

		local var_494_0 = {
			zh = 5.733,
			ja = 0.999999999999
		}
		local var_494_1 = manager.audio:GetLocalizationFlag()

		if var_494_0[var_494_1] ~= nil then
			arg_494_1.duration_ = var_494_0[var_494_1]
		end

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play1101101121(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1.fswbg_:SetActive(false)
				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_494_1:ShowNextGo(false)
			end

			local var_497_0 = 0
			local var_497_1 = 0.05

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_0 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_2 = arg_494_1:GetWordFromCfg(1101101120)
				local var_497_3 = arg_494_1:FormatText(var_497_2.content)

				arg_494_1.text_.text = var_497_3

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_5 = 2 <= 0 and var_497_1 or var_497_1 * (utf8.len(var_497_3) / 2)

				if (2 <= 0 and var_497_1 or var_497_1 * (utf8.len(var_497_3) / 2)) > 0 and var_497_1 < var_497_5 then
					arg_494_1.talkMaxDuration = var_497_5

					if var_497_5 + var_497_0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_5 + var_497_0
					end
				end

				arg_494_1.text_.text = var_497_3
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101120", "story_v_side_new_1101101.awb") ~= 0 then
					local var_497_6 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101120", "story_v_side_new_1101101.awb") / 1000

					if var_497_6 + var_497_0 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_6 + var_497_0
					end

					if var_497_2.prefab_name ~= "" and arg_494_1.actors_[var_497_2.prefab_name] ~= nil then
						local var_497_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_2.prefab_name].transform, "story_v_side_new_1101101", "1101101120", "story_v_side_new_1101101.awb")

						arg_494_1:RecordAudio("1101101120", var_497_7)
						arg_494_1:RecordAudio("1101101120", var_497_7)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101120", "story_v_side_new_1101101.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101120", "story_v_side_new_1101101.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_8 = math.max(var_497_1, arg_494_1.talkMaxDuration)

			if var_497_0 <= arg_494_1.time_ and arg_494_1.time_ < var_497_0 + var_497_8 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_0) / var_497_8

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_0 + var_497_8 and arg_494_1.time_ < var_497_0 + var_497_8 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play1101101121 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 1101101121
		arg_498_1.duration_ = 3.77

		local var_498_0 = {
			zh = 2,
			ja = 3.766
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
			arg_498_1.auto_ = false
		end

		function arg_498_1.playNext_(arg_500_0)
			arg_498_1.onStoryFinished_()
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = 0.35

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				arg_498_1.leftNameTxt_.text = arg_498_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, true)
				arg_498_1.iconController_:SetSelectedState("hero")

				arg_498_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_498_1.callingController_:SetSelectedState("normal")

				arg_498_1.keyicon_.color = Color.New(1, 1, 1)
				arg_498_1.icon_.color = Color.New(1, 1, 1)

				local var_501_1 = arg_498_1:GetWordFromCfg(1101101121)
				local var_501_2 = arg_498_1:FormatText(var_501_1.content)

				arg_498_1.text_.text = var_501_2

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_4 = 14 <= 0 and var_501_0 or var_501_0 * (utf8.len(var_501_2) / 14)

				if (14 <= 0 and var_501_0 or var_501_0 * (utf8.len(var_501_2) / 14)) > 0 and var_501_0 < var_501_4 then
					arg_498_1.talkMaxDuration = var_501_4

					if var_501_4 + 0 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_4 + 0
					end
				end

				arg_498_1.text_.text = var_501_2
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101121", "story_v_side_new_1101101.awb") ~= 0 then
					local var_501_5 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101121", "story_v_side_new_1101101.awb") / 1000

					if var_501_5 + 0 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_5 + 0
					end

					if var_501_1.prefab_name ~= "" and arg_498_1.actors_[var_501_1.prefab_name] ~= nil then
						local var_501_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_1.prefab_name].transform, "story_v_side_new_1101101", "1101101121", "story_v_side_new_1101101.awb")

						arg_498_1:RecordAudio("1101101121", var_501_6)
						arg_498_1:RecordAudio("1101101121", var_501_6)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101121", "story_v_side_new_1101101.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101121", "story_v_side_new_1101101.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_7 = math.max(var_501_0, arg_498_1.talkMaxDuration)

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_7 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - 0) / var_501_7

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= 0 + var_501_7 and arg_498_1.time_ < 0 + var_501_7 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play1101101036 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 1101101036
		arg_502_1.duration_ = 2

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play1101101037(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1.var_.moveOldPos1011ui_story = arg_502_1.actors_["1011ui_story"].transform.localPosition
			end

			local var_505_0 = 0.001

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_0 then
				arg_502_1.actors_["1011ui_story"].transform.localPosition = Vector3.Lerp(arg_502_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_502_1.time_ - 0) / var_505_0)
				arg_502_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_502_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_502_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_502_1.actors_["1011ui_story"].transform.position).z)
				arg_502_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_502_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_502_1.actors_["1011ui_story"].transform.localEulerAngles = arg_502_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			if arg_502_1.time_ >= 0 + var_505_0 and arg_502_1.time_ < 0 + var_505_0 + arg_505_0 then
				arg_502_1.actors_["1011ui_story"].transform.localPosition = Vector3.New(0, -0.71, -6)
				arg_502_1.actors_["1011ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_502_1.actors_["1011ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_502_1.actors_["1011ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_502_1.actors_["1011ui_story"].transform.position).z)
				arg_502_1.actors_["1011ui_story"].transform.localEulerAngles.z = 0
				arg_502_1.actors_["1011ui_story"].transform.localEulerAngles.x = 0
				arg_502_1.actors_["1011ui_story"].transform.localEulerAngles = arg_502_1.actors_["1011ui_story"].transform.localEulerAngles
			end

			local var_505_1 = arg_502_1.actors_["1011ui_story"]

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 and not isNil(var_505_1) and arg_502_1.var_.characterEffect1011ui_story == nil then
				arg_502_1.var_.characterEffect1011ui_story = var_505_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_2 = 0.200000002980232

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_2 and not isNil(var_505_1) then
				if arg_502_1.var_.characterEffect1011ui_story and not isNil(var_505_1) then
					arg_502_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_502_1.time_ >= 0 + var_505_2 and arg_502_1.time_ < 0 + var_505_2 + arg_505_0 and not isNil(var_505_1) and arg_502_1.var_.characterEffect1011ui_story then
				arg_502_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_505_4 = "1011ui_story"

			if arg_502_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_505_5 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_502_1.stage_.transform)

				var_505_5.name = var_505_4
				var_505_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_502_1.actors_[var_505_4] = var_505_5

				local var_505_6 = var_505_5:GetComponentInChildren(typeof(CharacterEffect))

				var_505_6.enabled = true

				local var_505_7 = GameObjectTools.GetOrAddComponent(var_505_5, typeof(DynamicBoneHelper))

				if var_505_7 then
					var_505_7:EnableDynamicBone(false)
				end

				arg_502_1:ShowWeapon(var_505_6.transform, false)

				arg_502_1.var_[var_505_4 .. "Animator"] = var_505_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_502_1.var_[var_505_4 .. "Animator"].applyRootMotion = true
				arg_502_1.var_[var_505_4 .. "LipSync"] = var_505_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 then
				arg_502_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_505_8 = 0
			local var_505_9 = 0.125

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_8 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				arg_502_1.leftNameTxt_.text = arg_502_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_10 = arg_502_1:GetWordFromCfg(1101101036)
				local var_505_11 = arg_502_1:FormatText(var_505_10.content)

				arg_502_1.text_.text = var_505_11

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_13 = 5 <= 0 and var_505_9 or var_505_9 * (utf8.len(var_505_11) / 5)

				if (5 <= 0 and var_505_9 or var_505_9 * (utf8.len(var_505_11) / 5)) > 0 and var_505_9 < var_505_13 then
					arg_502_1.talkMaxDuration = var_505_13

					if var_505_13 + var_505_8 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_13 + var_505_8
					end
				end

				arg_502_1.text_.text = var_505_11
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101036", "story_v_side_new_1101101.awb") ~= 0 then
					local var_505_14 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101036", "story_v_side_new_1101101.awb") / 1000

					if var_505_14 + var_505_8 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_14 + var_505_8
					end

					if var_505_10.prefab_name ~= "" and arg_502_1.actors_[var_505_10.prefab_name] ~= nil then
						local var_505_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_10.prefab_name].transform, "story_v_side_new_1101101", "1101101036", "story_v_side_new_1101101.awb")

						arg_502_1:RecordAudio("1101101036", var_505_15)
						arg_502_1:RecordAudio("1101101036", var_505_15)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101036", "story_v_side_new_1101101.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101036", "story_v_side_new_1101101.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_16 = math.max(var_505_9, arg_502_1.talkMaxDuration)

			if var_505_8 <= arg_502_1.time_ and arg_502_1.time_ < var_505_8 + var_505_16 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_8) / var_505_16

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_8 + var_505_16 and arg_502_1.time_ < var_505_8 + var_505_16 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {
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

		arg_502_1:InitPlayNodeList()
	end,
	Play1101101037 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 1101101037
		arg_506_1.duration_ = 5

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play1101101038(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 and not isNil(arg_506_1.actors_["1011ui_story"]) and arg_506_1.var_.characterEffect1011ui_story == nil then
				arg_506_1.var_.characterEffect1011ui_story = arg_506_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_0 = 0.200000002980232

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_0 and not isNil(arg_506_1.actors_["1011ui_story"]) then
				if arg_506_1.var_.characterEffect1011ui_story and not isNil(arg_506_1.actors_["1011ui_story"]) then
					arg_506_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_506_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_506_1.time_ - 0) / var_509_0)
				end
			end

			if arg_506_1.time_ >= 0 + var_509_0 and arg_506_1.time_ < 0 + var_509_0 + arg_509_0 and not isNil(arg_506_1.actors_["1011ui_story"]) and arg_506_1.var_.characterEffect1011ui_story then
				arg_506_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_506_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_509_1 = 0
			local var_509_2 = 0.625

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_1 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, false)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_3 = arg_506_1:FormatText(arg_506_1:GetWordFromCfg(1101101037).content)

				arg_506_1.text_.text = var_509_3

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_5 = 25 <= 0 and var_509_2 or var_509_2 * (utf8.len(var_509_3) / 25)

				if (25 <= 0 and var_509_2 or var_509_2 * (utf8.len(var_509_3) / 25)) > 0 and var_509_2 < var_509_5 then
					arg_506_1.talkMaxDuration = var_509_5

					if var_509_5 + var_509_1 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_5 + var_509_1
					end
				end

				arg_506_1.text_.text = var_509_3
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)
				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_6 = math.max(var_509_2, arg_506_1.talkMaxDuration)

			if var_509_1 <= arg_506_1.time_ and arg_506_1.time_ < var_509_1 + var_509_6 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_1) / var_509_6

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_1 + var_509_6 and arg_506_1.time_ < var_509_1 + var_509_6 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play1101101015 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 1101101015
		arg_510_1.duration_ = 5.37

		local var_510_0 = {
			zh = 2.066,
			ja = 5.366
		}
		local var_510_1 = manager.audio:GetLocalizationFlag()

		if var_510_0[var_510_1] ~= nil then
			arg_510_1.duration_ = var_510_0[var_510_1]
		end

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play1101101016(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = 0.2

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				arg_510_1.leftNameTxt_.text = arg_510_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_1 = arg_510_1:GetWordFromCfg(1101101015)
				local var_513_2 = arg_510_1:FormatText(var_513_1.content)

				arg_510_1.text_.text = var_513_2

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_4 = 8 <= 0 and var_513_0 or var_513_0 * (utf8.len(var_513_2) / 8)

				if (8 <= 0 and var_513_0 or var_513_0 * (utf8.len(var_513_2) / 8)) > 0 and var_513_0 < var_513_4 then
					arg_510_1.talkMaxDuration = var_513_4

					if var_513_4 + 0 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_4 + 0
					end
				end

				arg_510_1.text_.text = var_513_2
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101015", "story_v_side_new_1101101.awb") ~= 0 then
					local var_513_5 = manager.audio:GetVoiceLength("story_v_side_new_1101101", "1101101015", "story_v_side_new_1101101.awb") / 1000

					if var_513_5 + 0 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_5 + 0
					end

					if var_513_1.prefab_name ~= "" and arg_510_1.actors_[var_513_1.prefab_name] ~= nil then
						local var_513_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_510_1.actors_[var_513_1.prefab_name].transform, "story_v_side_new_1101101", "1101101015", "story_v_side_new_1101101.awb")

						arg_510_1:RecordAudio("1101101015", var_513_6)
						arg_510_1:RecordAudio("1101101015", var_513_6)
					else
						arg_510_1:AudioAction("play", "voice", "story_v_side_new_1101101", "1101101015", "story_v_side_new_1101101.awb")
					end

					arg_510_1:RecordHistoryTalkVoice("story_v_side_new_1101101", "1101101015", "story_v_side_new_1101101.awb")
				end

				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_7 = math.max(var_513_0, arg_510_1.talkMaxDuration)

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_7 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - 0) / var_513_7

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= 0 + var_513_7 and arg_510_1.time_ < 0 + var_513_7 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A02d",
		"TextureConfig/Background/H03a",
		"TextureConfig/Background/D07",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/A01a",
		"TextureConfig/Background/S0101",
		"TextureConfig/Background/A00",
		"TextureConfig/Background/D12b",
		"TextureConfig/Background/D05",
		"TextureConfig/Background/B13g",
		"TextureConfig/Background/B13a",
		"TextureConfig/Background/ST01a"
	},
	voices = {
		"story_v_side_new_1101101.awb"
	}
}
