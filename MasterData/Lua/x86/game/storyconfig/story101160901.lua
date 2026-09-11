return {
	Play116091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116091001
		arg_1_1.duration_ = 2

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play116091002(arg_1_1)
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

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

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
				arg_1_1.fswt_.text = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(116091001).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_8 = 0.0166666666666666

			if 0.0166666666666666 < arg_1_1.time_ and arg_1_1.time_ <= var_4_8 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_9 = 29
			local var_4_10 = 1.93333333333333
			local var_4_11, var_4_12 = arg_1_1:GetPercentByPara(arg_1_1:FormatText(arg_1_1:GetWordFromCfg(116091001).content), 1)

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

			local var_4_14 = math.max(1.93333333333333, arg_1_1.talkMaxDuration)

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_15 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_16 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_17 = var_4_15:GetComponent("RectTransform")

				var_4_15:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_17.offsetMin = Vector2.New(0, 0)
				var_4_17.offsetMax = Vector2.New(0, 0)
			end

			local var_4_18 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_18 + 2 and arg_1_1.time_ < var_4_18 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
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
	Play116091002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 116091002
		arg_6_1.duration_ = 3.5

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play116091003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			if arg_6_1.bgs_.SK0108 == nil then
				local var_9_0 = Object.Instantiate(arg_6_1.paintGo_)

				var_9_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0108")
				var_9_0.name = "SK0108"
				var_9_0.transform.parent = arg_6_1.stage_.transform
				var_9_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_6_1.bgs_.SK0108 = var_9_0
			end

			if 1 < arg_6_1.time_ and arg_6_1.time_ <= 1 + arg_9_0 then
				local var_9_1 = arg_6_1.bgs_.SK0108

				arg_6_1.bgs_.SK0108.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_9_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_9_2 = var_9_1:GetComponent("SpriteRenderer")

				if var_9_2 and var_9_2.sprite then
					local var_9_3 = 2 * (var_9_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_9_1.transform.localScale = Vector3.New(var_9_3 / var_9_2.sprite.bounds.size.y < var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x and var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x or var_9_3 / var_9_2.sprite.bounds.size.y, var_9_3 / var_9_2.sprite.bounds.size.y < var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x and var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x or var_9_3 / var_9_2.sprite.bounds.size.y, 0)
				end

				for iter_9_0, iter_9_1 in pairs(arg_6_1.bgs_) do
					if iter_9_0 ~= "SK0108" then
						iter_9_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_9_4 = 0

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_4 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = false

				arg_6_1:SetGaussion(false)
			end

			local var_9_5 = 1

			if var_9_4 <= arg_6_1.time_ and arg_6_1.time_ < var_9_4 + var_9_5 then
				local var_9_6 = Color.New(0, 0, 0)

				var_9_6.a = Mathf.Lerp(0, 1, (arg_6_1.time_ - var_9_4) / var_9_5)
				arg_6_1.mask_.color = var_9_6
			end

			if arg_6_1.time_ >= var_9_4 + var_9_5 and arg_6_1.time_ < var_9_4 + var_9_5 + arg_9_0 then
				local var_9_7 = Color.New(0, 0, 0)

				var_9_7.a = 1
				arg_6_1.mask_.color = var_9_7
			end

			local var_9_8 = 1

			if 1 < arg_6_1.time_ and arg_6_1.time_ <= var_9_8 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = false

				arg_6_1:SetGaussion(false)
			end

			local var_9_9 = 2

			if var_9_8 <= arg_6_1.time_ and arg_6_1.time_ < var_9_8 + var_9_9 then
				local var_9_10 = Color.New(0, 0, 0)

				var_9_10.a = Mathf.Lerp(1, 0, (arg_6_1.time_ - var_9_8) / var_9_9)
				arg_6_1.mask_.color = var_9_10
			end

			if arg_6_1.time_ >= var_9_8 + var_9_9 and arg_6_1.time_ < var_9_8 + var_9_9 + arg_9_0 then
				local var_9_11 = Color.New(0, 0, 0)

				arg_6_1.mask_.enabled = false
				var_9_11.a = 0
				arg_6_1.mask_.color = var_9_11
			end

			local var_9_12 = arg_6_1.bgs_.SK0108.transform

			if 1 < arg_6_1.time_ and arg_6_1.time_ <= 1 + arg_9_0 then
				arg_6_1.var_.moveOldPosSK0108 = var_9_12.localPosition
			end

			local var_9_13 = 0.001

			if 1 <= arg_6_1.time_ and arg_6_1.time_ < 1 + var_9_13 then
				var_9_12.localPosition = Vector3.Lerp(arg_6_1.var_.moveOldPosSK0108, Vector3.New(0, 0, 7), (arg_6_1.time_ - 1) / var_9_13)
			end

			if arg_6_1.time_ >= 1 + var_9_13 and arg_6_1.time_ < 1 + var_9_13 + arg_9_0 then
				var_9_12.localPosition = Vector3.New(0, 0, 7)
			end

			local var_9_14 = arg_6_1.bgs_.SK0108.transform

			if 1.034 < arg_6_1.time_ and arg_6_1.time_ <= 1.034 + arg_9_0 then
				arg_6_1.var_.moveOldPosSK0108 = var_9_14.localPosition
			end

			local var_9_15 = 2.466

			if 1.034 <= arg_6_1.time_ and arg_6_1.time_ < 1.034 + var_9_15 then
				var_9_14.localPosition = Vector3.Lerp(arg_6_1.var_.moveOldPosSK0108, Vector3.New(0, 0, 6.5), (arg_6_1.time_ - 1.034) / var_9_15)
			end

			if arg_6_1.time_ >= 1.034 + var_9_15 and arg_6_1.time_ < 1.034 + var_9_15 + arg_9_0 then
				var_9_14.localPosition = Vector3.New(0, 0, 6.5)
			end

			if 1.034 < arg_6_1.time_ and arg_6_1.time_ <= 1.034 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(true)
				arg_6_1.dialog_:SetActive(false)

				arg_6_1.fswtw_.percent = 0
				arg_6_1.fswt_.text = arg_6_1:FormatText(arg_6_1:GetWordFromCfg(116091002).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.fswt_)

				arg_6_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_6_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_6_1.fswtw_:SetDirty()

				arg_6_1.typewritterCharCountI18N = 0

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_16 = 1.068

			if 1.068 < arg_6_1.time_ and arg_6_1.time_ <= var_9_16 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_17 = -11
			local var_9_18 = 1.23266666666667
			local var_9_19, var_9_20 = arg_6_1:GetPercentByPara(arg_6_1:FormatText(arg_6_1:GetWordFromCfg(116091002).content), 1)

			if var_9_16 < arg_6_1.time_ and arg_6_1.time_ <= var_9_16 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				local var_9_21 = var_9_17 <= 0 and var_9_18 or var_9_18 * ((var_9_20 - arg_6_1.typewritterCharCountI18N) / var_9_17)

				if (var_9_17 <= 0 and var_9_18 or var_9_18 * ((var_9_20 - arg_6_1.typewritterCharCountI18N) / var_9_17)) > 0 and var_9_18 < var_9_21 then
					arg_6_1.talkMaxDuration = var_9_21

					if var_9_21 + var_9_16 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_21 + var_9_16
					end
				end
			end

			local var_9_22 = math.max(1.23266666666667, arg_6_1.talkMaxDuration)

			if var_9_16 <= arg_6_1.time_ and arg_6_1.time_ < var_9_16 + var_9_22 then
				arg_6_1.fswtw_.percent = Mathf.Lerp(arg_6_1.var_.oldValueTypewriter, var_9_19, (arg_6_1.time_ - var_9_16) / var_9_22)
				arg_6_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_6_1.fswtw_:SetDirty()
			end

			if arg_6_1.time_ >= var_9_16 + var_9_22 and arg_6_1.time_ < var_9_16 + var_9_22 + arg_9_0 then
				arg_6_1.fswtw_.percent = var_9_19

				arg_6_1.fswtw_:SetDirty()
				arg_6_1:ShowNextGo(true)

				arg_6_1.typewritterCharCountI18N = var_9_20
			end

			local var_9_23 = 0

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_23 + arg_9_0 then
				arg_6_1.allBtn_.enabled = false
			end

			if arg_6_1.time_ >= var_9_23 + 3.5 and arg_6_1.time_ < var_9_23 + 3.5 + arg_9_0 then
				arg_6_1.allBtn_.enabled = true
			end
		end

		arg_6_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SK0108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.466,
				className = "StoryMoveNode",
				startTime = 1.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_6_1:InitPlayNodeList()
	end,
	Play116091003 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 116091003
		arg_10_1.duration_ = 4

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play116091004(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.var_.moveOldPosSK0108 = arg_10_1.bgs_.SK0108.transform.localPosition
			end

			local var_13_0 = 4

			if 0 <= arg_10_1.time_ and arg_10_1.time_ < 0 + var_13_0 then
				arg_10_1.bgs_.SK0108.transform.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPosSK0108, Vector3.New(0, -2, 6.5), (arg_10_1.time_ - 0) / var_13_0)
			end

			if arg_10_1.time_ >= 0 + var_13_0 and arg_10_1.time_ < 0 + var_13_0 + arg_13_0 then
				arg_10_1.bgs_.SK0108.transform.localPosition = Vector3.New(0, -2, 6.5)
			end

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= 0 + arg_13_0 then
				arg_10_1.fswbg_:SetActive(true)
				arg_10_1.dialog_:SetActive(false)

				arg_10_1.fswtw_.percent = 0
				arg_10_1.fswt_.text = arg_10_1:FormatText(arg_10_1:GetWordFromCfg(116091003).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.fswt_)

				arg_10_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_10_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_10_1.fswtw_:SetDirty()

				arg_10_1.typewritterCharCountI18N = 0

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_1 = 0.0339999999999999

			if 0.0339999999999999 < arg_10_1.time_ and arg_10_1.time_ <= var_13_1 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_2 = 27
			local var_13_3 = 1.8
			local var_13_4, var_13_5 = arg_10_1:GetPercentByPara(arg_10_1:FormatText(arg_10_1:GetWordFromCfg(116091003).content), 1)

			if var_13_1 < arg_10_1.time_ and arg_10_1.time_ <= var_13_1 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0

				local var_13_6 = var_13_2 <= 0 and var_13_3 or var_13_3 * ((var_13_5 - arg_10_1.typewritterCharCountI18N) / var_13_2)

				if (var_13_2 <= 0 and var_13_3 or var_13_3 * ((var_13_5 - arg_10_1.typewritterCharCountI18N) / var_13_2)) > 0 and var_13_3 < var_13_6 then
					arg_10_1.talkMaxDuration = var_13_6

					if var_13_6 + var_13_1 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_6 + var_13_1
					end
				end
			end

			local var_13_7 = math.max(1.8, arg_10_1.talkMaxDuration)

			if var_13_1 <= arg_10_1.time_ and arg_10_1.time_ < var_13_1 + var_13_7 then
				arg_10_1.fswtw_.percent = Mathf.Lerp(arg_10_1.var_.oldValueTypewriter, var_13_4, (arg_10_1.time_ - var_13_1) / var_13_7)
				arg_10_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_10_1.fswtw_:SetDirty()
			end

			if arg_10_1.time_ >= var_13_1 + var_13_7 and arg_10_1.time_ < var_13_1 + var_13_7 + arg_13_0 then
				arg_10_1.fswtw_.percent = var_13_4

				arg_10_1.fswtw_:SetDirty()
				arg_10_1:ShowNextGo(true)

				arg_10_1.typewritterCharCountI18N = var_13_5
			end

			local var_13_8 = 0

			if 0 < arg_10_1.time_ and arg_10_1.time_ <= var_13_8 + arg_13_0 then
				arg_10_1.allBtn_.enabled = false
			end

			if arg_10_1.time_ >= var_13_8 + 4 and arg_10_1.time_ < var_13_8 + 4 + arg_13_0 then
				arg_10_1.allBtn_.enabled = true
			end
		end

		arg_10_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_10_1:InitPlayNodeList()
	end,
	Play116091004 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 116091004
		arg_14_1.duration_ = 4

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play116091005(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.var_.moveOldPosSK0108 = arg_14_1.bgs_.SK0108.transform.localPosition
			end

			local var_17_0 = 4

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_0 then
				arg_14_1.bgs_.SK0108.transform.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPosSK0108, Vector3.New(0, -4, 6.5), (arg_14_1.time_ - 0) / var_17_0)
			end

			if arg_14_1.time_ >= 0 + var_17_0 and arg_14_1.time_ < 0 + var_17_0 + arg_17_0 then
				arg_14_1.bgs_.SK0108.transform.localPosition = Vector3.New(0, -4, 6.5)
			end

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.fswbg_:SetActive(true)
				arg_14_1.dialog_:SetActive(false)

				arg_14_1.fswtw_.percent = 0
				arg_14_1.fswt_.text = arg_14_1:FormatText(arg_14_1:GetWordFromCfg(116091004).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.fswt_)

				arg_14_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_14_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_14_1.fswtw_:SetDirty()

				arg_14_1.typewritterCharCountI18N = 0

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_1 = 0.0339999999999999

			if 0.0339999999999999 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_2 = 41
			local var_17_3 = 2.73333333333333
			local var_17_4, var_17_5 = arg_14_1:GetPercentByPara(arg_14_1:FormatText(arg_14_1:GetWordFromCfg(116091004).content), 1)

			if var_17_1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				local var_17_6 = var_17_2 <= 0 and var_17_3 or var_17_3 * ((var_17_5 - arg_14_1.typewritterCharCountI18N) / var_17_2)

				if (var_17_2 <= 0 and var_17_3 or var_17_3 * ((var_17_5 - arg_14_1.typewritterCharCountI18N) / var_17_2)) > 0 and var_17_3 < var_17_6 then
					arg_14_1.talkMaxDuration = var_17_6

					if var_17_6 + var_17_1 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_6 + var_17_1
					end
				end
			end

			local var_17_7 = math.max(2.73333333333333, arg_14_1.talkMaxDuration)

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_7 then
				arg_14_1.fswtw_.percent = Mathf.Lerp(arg_14_1.var_.oldValueTypewriter, var_17_4, (arg_14_1.time_ - var_17_1) / var_17_7)
				arg_14_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_14_1.fswtw_:SetDirty()
			end

			if arg_14_1.time_ >= var_17_1 + var_17_7 and arg_14_1.time_ < var_17_1 + var_17_7 + arg_17_0 then
				arg_14_1.fswtw_.percent = var_17_4

				arg_14_1.fswtw_:SetDirty()
				arg_14_1:ShowNextGo(true)

				arg_14_1.typewritterCharCountI18N = var_17_5
			end

			local var_17_8 = 0

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_8 + arg_17_0 then
				arg_14_1.allBtn_.enabled = false
			end

			if arg_14_1.time_ >= var_17_8 + 4 and arg_14_1.time_ < var_17_8 + 4 + arg_17_0 then
				arg_14_1.allBtn_.enabled = true
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play116091005 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 116091005
		arg_18_1.duration_ = 4

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play116091006(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.var_.moveOldPosSK0108 = arg_18_1.bgs_.SK0108.transform.localPosition
			end

			local var_21_0 = 4

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_0 then
				arg_18_1.bgs_.SK0108.transform.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPosSK0108, Vector3.New(0, -6, 6.5), (arg_18_1.time_ - 0) / var_21_0)
			end

			if arg_18_1.time_ >= 0 + var_21_0 and arg_18_1.time_ < 0 + var_21_0 + arg_21_0 then
				arg_18_1.bgs_.SK0108.transform.localPosition = Vector3.New(0, -6, 6.5)
			end

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 then
				arg_18_1.fswbg_:SetActive(true)
				arg_18_1.dialog_:SetActive(false)

				arg_18_1.fswtw_.percent = 0
				arg_18_1.fswt_.text = arg_18_1:FormatText(arg_18_1:GetWordFromCfg(116091005).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.fswt_)

				arg_18_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_18_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_18_1.fswtw_:SetDirty()

				arg_18_1.typewritterCharCountI18N = 0

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_1 = 0.0339999999999999

			if 0.0339999999999999 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 then
				arg_18_1.var_.oldValueTypewriter = arg_18_1.fswtw_.percent

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_2 = 22
			local var_21_3 = 1.46666666666667
			local var_21_4, var_21_5 = arg_18_1:GetPercentByPara(arg_18_1:FormatText(arg_18_1:GetWordFromCfg(116091005).content), 1)

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				local var_21_6 = var_21_2 <= 0 and var_21_3 or var_21_3 * ((var_21_5 - arg_18_1.typewritterCharCountI18N) / var_21_2)

				if (var_21_2 <= 0 and var_21_3 or var_21_3 * ((var_21_5 - arg_18_1.typewritterCharCountI18N) / var_21_2)) > 0 and var_21_3 < var_21_6 then
					arg_18_1.talkMaxDuration = var_21_6

					if var_21_6 + var_21_1 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_6 + var_21_1
					end
				end
			end

			local var_21_7 = math.max(1.46666666666667, arg_18_1.talkMaxDuration)

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_7 then
				arg_18_1.fswtw_.percent = Mathf.Lerp(arg_18_1.var_.oldValueTypewriter, var_21_4, (arg_18_1.time_ - var_21_1) / var_21_7)
				arg_18_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_18_1.fswtw_:SetDirty()
			end

			if arg_18_1.time_ >= var_21_1 + var_21_7 and arg_18_1.time_ < var_21_1 + var_21_7 + arg_21_0 then
				arg_18_1.fswtw_.percent = var_21_4

				arg_18_1.fswtw_:SetDirty()
				arg_18_1:ShowNextGo(true)

				arg_18_1.typewritterCharCountI18N = var_21_5
			end

			local var_21_8 = 0

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_8 + arg_21_0 then
				arg_18_1.allBtn_.enabled = false
			end

			if arg_18_1.time_ >= var_21_8 + 4 and arg_18_1.time_ < var_21_8 + 4 + arg_21_0 then
				arg_18_1.allBtn_.enabled = true
			end
		end

		arg_18_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_18_1:InitPlayNodeList()
	end,
	Play116091006 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 116091006
		arg_22_1.duration_ = 3.33

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play116091007(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.var_.moveOldPosSK0108 = arg_22_1.bgs_.SK0108.transform.localPosition
			end

			local var_25_0 = 3.33333333333333

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_0 then
				arg_22_1.bgs_.SK0108.transform.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPosSK0108, Vector3.New(0, -8, 6.5), (arg_22_1.time_ - 0) / var_25_0)
			end

			if arg_22_1.time_ >= 0 + var_25_0 and arg_22_1.time_ < 0 + var_25_0 + arg_25_0 then
				arg_22_1.bgs_.SK0108.transform.localPosition = Vector3.New(0, -8, 6.5)
			end

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.fswbg_:SetActive(true)
				arg_22_1.dialog_:SetActive(false)

				arg_22_1.fswtw_.percent = 0
				arg_22_1.fswt_.text = arg_22_1:FormatText(arg_22_1:GetWordFromCfg(116091006).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.fswt_)

				arg_22_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_22_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_22_1.fswtw_:SetDirty()

				arg_22_1.typewritterCharCountI18N = 0

				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_22_1:ShowNextGo(false)
			end

			local var_25_1 = 0.0339999999999999

			if 0.0339999999999999 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 then
				arg_22_1.var_.oldValueTypewriter = arg_22_1.fswtw_.percent

				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_22_1:ShowNextGo(false)
			end

			local var_25_2 = 32
			local var_25_3 = 1.46666666666667
			local var_25_4, var_25_5 = arg_22_1:GetPercentByPara(arg_22_1:FormatText(arg_22_1:GetWordFromCfg(116091006).content), 1)

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				local var_25_6 = var_25_2 <= 0 and var_25_3 or var_25_3 * ((var_25_5 - arg_22_1.typewritterCharCountI18N) / var_25_2)

				if (var_25_2 <= 0 and var_25_3 or var_25_3 * ((var_25_5 - arg_22_1.typewritterCharCountI18N) / var_25_2)) > 0 and var_25_3 < var_25_6 then
					arg_22_1.talkMaxDuration = var_25_6

					if var_25_6 + var_25_1 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_6 + var_25_1
					end
				end
			end

			local var_25_7 = math.max(1.46666666666667, arg_22_1.talkMaxDuration)

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_7 then
				arg_22_1.fswtw_.percent = Mathf.Lerp(arg_22_1.var_.oldValueTypewriter, var_25_4, (arg_22_1.time_ - var_25_1) / var_25_7)
				arg_22_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_22_1.fswtw_:SetDirty()
			end

			if arg_22_1.time_ >= var_25_1 + var_25_7 and arg_22_1.time_ < var_25_1 + var_25_7 + arg_25_0 then
				arg_22_1.fswtw_.percent = var_25_4

				arg_22_1.fswtw_:SetDirty()
				arg_22_1:ShowNextGo(true)

				arg_22_1.typewritterCharCountI18N = var_25_5
			end

			local var_25_8 = 0

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_8 + arg_25_0 then
				arg_22_1.allBtn_.enabled = false
			end

			if arg_22_1.time_ >= var_25_8 + 3.33333333333333 and arg_22_1.time_ < var_25_8 + 3.33333333333333 + arg_25_0 then
				arg_22_1.allBtn_.enabled = true
			end

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1:AudioAction("play", "effect", "se_story_16", "se_story_16_thunder02", "")
			end

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1:AudioAction("play", "effect", "se_story_16", "se_story_16_wind02", "")
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.33333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play116091007 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 116091007
		arg_26_1.duration_ = 3

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play116091008(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0.666666666666667 < arg_26_1.time_ and arg_26_1.time_ <= 0.666666666666667 + arg_29_0 then
				local var_29_0 = arg_26_1.bgs_.SK0108

				arg_26_1.bgs_.SK0108.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_29_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_29_1 = var_29_0:GetComponent("SpriteRenderer")

				if var_29_1 and var_29_1.sprite then
					local var_29_2 = 2 * (var_29_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_29_0.transform.localScale = Vector3.New(var_29_2 / var_29_1.sprite.bounds.size.y < var_29_2 * manager.ui.mainCameraCom_.aspect / var_29_1.sprite.bounds.size.x and var_29_2 * manager.ui.mainCameraCom_.aspect / var_29_1.sprite.bounds.size.x or var_29_2 / var_29_1.sprite.bounds.size.y, var_29_2 / var_29_1.sprite.bounds.size.y < var_29_2 * manager.ui.mainCameraCom_.aspect / var_29_1.sprite.bounds.size.x and var_29_2 * manager.ui.mainCameraCom_.aspect / var_29_1.sprite.bounds.size.x or var_29_2 / var_29_1.sprite.bounds.size.y, 0)
				end

				for iter_29_0, iter_29_1 in pairs(arg_26_1.bgs_) do
					if iter_29_0 ~= "SK0108" then
						iter_29_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_29_3 = arg_26_1.bgs_.SK0108.transform

			if 0.666666666666667 < arg_26_1.time_ and arg_26_1.time_ <= 0.666666666666667 + arg_29_0 then
				arg_26_1.var_.moveOldPosSK0108 = var_29_3.localPosition
			end

			local var_29_4 = 0.001

			if 0.666666666666667 <= arg_26_1.time_ and arg_26_1.time_ < 0.666666666666667 + var_29_4 then
				var_29_3.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPosSK0108, Vector3.New(0, 5.21, 6), (arg_26_1.time_ - 0.666666666666667) / var_29_4)
			end

			if arg_26_1.time_ >= 0.666666666666667 + var_29_4 and arg_26_1.time_ < 0.666666666666667 + var_29_4 + arg_29_0 then
				var_29_3.localPosition = Vector3.New(0, 5.21, 6)
			end

			local var_29_5 = arg_26_1.bgs_.SK0108.transform

			if 0.700666666666667 < arg_26_1.time_ and arg_26_1.time_ <= 0.700666666666667 + arg_29_0 then
				arg_26_1.var_.moveOldPosSK0108 = var_29_5.localPosition
			end

			local var_29_6 = 2.30066666666667

			if 0.700666666666667 <= arg_26_1.time_ and arg_26_1.time_ < 0.700666666666667 + var_29_6 then
				var_29_5.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPosSK0108, Vector3.New(0, 5.21, 5.5), (arg_26_1.time_ - 0.700666666666667) / var_29_6)
			end

			if arg_26_1.time_ >= 0.700666666666667 + var_29_6 and arg_26_1.time_ < 0.700666666666667 + var_29_6 + arg_29_0 then
				var_29_5.localPosition = Vector3.New(0, 5.21, 5.5)
			end

			if 0.700666666666667 < arg_26_1.time_ and arg_26_1.time_ <= 0.700666666666667 + arg_29_0 then
				arg_26_1.fswbg_:SetActive(true)
				arg_26_1.dialog_:SetActive(false)

				arg_26_1.fswtw_.percent = 0
				arg_26_1.fswt_.text = arg_26_1:FormatText(arg_26_1:GetWordFromCfg(116091007).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.fswt_)

				arg_26_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_26_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_26_1.fswtw_:SetDirty()

				arg_26_1.typewritterCharCountI18N = 0

				SetActive(arg_26_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_26_1:ShowNextGo(false)
			end

			local var_29_7 = 0.734666666666666

			if 0.734666666666666 < arg_26_1.time_ and arg_26_1.time_ <= var_29_7 + arg_29_0 then
				arg_26_1.var_.oldValueTypewriter = arg_26_1.fswtw_.percent

				SetActive(arg_26_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_26_1:ShowNextGo(false)
			end

			local var_29_8 = -8
			local var_29_9 = 1.6
			local var_29_10, var_29_11 = arg_26_1:GetPercentByPara(arg_26_1:FormatText(arg_26_1:GetWordFromCfg(116091007).content), 1)

			if var_29_7 < arg_26_1.time_ and arg_26_1.time_ <= var_29_7 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0

				local var_29_12 = var_29_8 <= 0 and var_29_9 or var_29_9 * ((var_29_11 - arg_26_1.typewritterCharCountI18N) / var_29_8)

				if (var_29_8 <= 0 and var_29_9 or var_29_9 * ((var_29_11 - arg_26_1.typewritterCharCountI18N) / var_29_8)) > 0 and var_29_9 < var_29_12 then
					arg_26_1.talkMaxDuration = var_29_12

					if var_29_12 + var_29_7 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_12 + var_29_7
					end
				end
			end

			local var_29_13 = math.max(1.6, arg_26_1.talkMaxDuration)

			if var_29_7 <= arg_26_1.time_ and arg_26_1.time_ < var_29_7 + var_29_13 then
				arg_26_1.fswtw_.percent = Mathf.Lerp(arg_26_1.var_.oldValueTypewriter, var_29_10, (arg_26_1.time_ - var_29_7) / var_29_13)
				arg_26_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_26_1.fswtw_:SetDirty()
			end

			if arg_26_1.time_ >= var_29_7 + var_29_13 and arg_26_1.time_ < var_29_7 + var_29_13 + arg_29_0 then
				arg_26_1.fswtw_.percent = var_29_10

				arg_26_1.fswtw_:SetDirty()
				arg_26_1:ShowNextGo(true)

				arg_26_1.typewritterCharCountI18N = var_29_11
			end

			local var_29_14 = 0

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_14 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = false

				arg_26_1:SetGaussion(false)
			end

			local var_29_15 = 0.666666666666667

			if var_29_14 <= arg_26_1.time_ and arg_26_1.time_ < var_29_14 + var_29_15 then
				local var_29_16 = Color.New(1, 1, 1)

				var_29_16.a = Mathf.Lerp(0, 1, (arg_26_1.time_ - var_29_14) / var_29_15)
				arg_26_1.mask_.color = var_29_16
			end

			if arg_26_1.time_ >= var_29_14 + var_29_15 and arg_26_1.time_ < var_29_14 + var_29_15 + arg_29_0 then
				local var_29_17 = Color.New(1, 1, 1)

				var_29_17.a = 1
				arg_26_1.mask_.color = var_29_17
			end

			local var_29_18 = 0.666666666666667

			if 0.666666666666667 < arg_26_1.time_ and arg_26_1.time_ <= var_29_18 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = false

				arg_26_1:SetGaussion(false)
			end

			local var_29_19 = 0.700666666666667

			if var_29_18 <= arg_26_1.time_ and arg_26_1.time_ < var_29_18 + var_29_19 then
				local var_29_20 = Color.New(1, 1, 1)

				var_29_20.a = Mathf.Lerp(1, 0, (arg_26_1.time_ - var_29_18) / var_29_19)
				arg_26_1.mask_.color = var_29_20
			end

			if arg_26_1.time_ >= var_29_18 + var_29_19 and arg_26_1.time_ < var_29_18 + var_29_19 + arg_29_0 then
				local var_29_21 = Color.New(1, 1, 1)

				arg_26_1.mask_.enabled = false
				var_29_21.a = 0
				arg_26_1.mask_.color = var_29_21
			end

			local var_29_22 = 0

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_22 + arg_29_0 then
				arg_26_1.allBtn_.enabled = false
			end

			if arg_26_1.time_ >= var_29_22 + 3.00133333333333 and arg_26_1.time_ < var_29_22 + 3.00133333333333 + arg_29_0 then
				arg_26_1.allBtn_.enabled = true
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.666666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SK0108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.30066666666667,
				className = "StoryMoveNode",
				startTime = 0.700666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play116091008 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 116091008
		arg_30_1.duration_ = 8.33

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play116091009(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if arg_30_1.bgs_.ST01a == nil then
				local var_33_0 = Object.Instantiate(arg_30_1.paintGo_)

				var_33_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST01a")
				var_33_0.name = "ST01a"
				var_33_0.transform.parent = arg_30_1.stage_.transform
				var_33_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_30_1.bgs_.ST01a = var_33_0
			end

			if 2 < arg_30_1.time_ and arg_30_1.time_ <= 2 + arg_33_0 then
				local var_33_1 = arg_30_1.bgs_.ST01a

				arg_30_1.bgs_.ST01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_33_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_33_2 = var_33_1:GetComponent("SpriteRenderer")

				if var_33_2 and var_33_2.sprite then
					local var_33_3 = 2 * (var_33_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_33_1.transform.localScale = Vector3.New(var_33_3 / var_33_2.sprite.bounds.size.y < var_33_3 * manager.ui.mainCameraCom_.aspect / var_33_2.sprite.bounds.size.x and var_33_3 * manager.ui.mainCameraCom_.aspect / var_33_2.sprite.bounds.size.x or var_33_3 / var_33_2.sprite.bounds.size.y, var_33_3 / var_33_2.sprite.bounds.size.y < var_33_3 * manager.ui.mainCameraCom_.aspect / var_33_2.sprite.bounds.size.x and var_33_3 * manager.ui.mainCameraCom_.aspect / var_33_2.sprite.bounds.size.x or var_33_3 / var_33_2.sprite.bounds.size.y, 0)
				end

				for iter_33_0, iter_33_1 in pairs(arg_30_1.bgs_) do
					if iter_33_0 ~= "ST01a" then
						iter_33_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_33_4 = 0

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_4 + arg_33_0 then
				arg_30_1.mask_.enabled = true
				arg_30_1.mask_.raycastTarget = false

				arg_30_1:SetGaussion(false)
			end

			local var_33_5 = 1.03333333333333

			if var_33_4 <= arg_30_1.time_ and arg_30_1.time_ < var_33_4 + var_33_5 then
				local var_33_6 = Color.New(0, 0, 0)

				var_33_6.a = Mathf.Lerp(0, 1, (arg_30_1.time_ - var_33_4) / var_33_5)
				arg_30_1.mask_.color = var_33_6
			end

			if arg_30_1.time_ >= var_33_4 + var_33_5 and arg_30_1.time_ < var_33_4 + var_33_5 + arg_33_0 then
				local var_33_7 = Color.New(0, 0, 0)

				var_33_7.a = 1
				arg_30_1.mask_.color = var_33_7
			end

			local var_33_8 = 2

			if 2 < arg_30_1.time_ and arg_30_1.time_ <= var_33_8 + arg_33_0 then
				arg_30_1.mask_.enabled = true
				arg_30_1.mask_.raycastTarget = false

				arg_30_1:SetGaussion(false)
			end

			local var_33_9 = 1.33333333333333

			if var_33_8 <= arg_30_1.time_ and arg_30_1.time_ < var_33_8 + var_33_9 then
				local var_33_10 = Color.New(0, 0, 0)

				var_33_10.a = Mathf.Lerp(1, 0, (arg_30_1.time_ - var_33_8) / var_33_9)
				arg_30_1.mask_.color = var_33_10
			end

			if arg_30_1.time_ >= var_33_8 + var_33_9 and arg_30_1.time_ < var_33_8 + var_33_9 + arg_33_0 then
				local var_33_11 = Color.New(0, 0, 0)

				arg_30_1.mask_.enabled = false
				var_33_11.a = 0
				arg_30_1.mask_.color = var_33_11
			end

			if 1.01666666666667 < arg_30_1.time_ and arg_30_1.time_ <= 1.01666666666667 + arg_33_0 then
				arg_30_1.fswbg_:SetActive(false)
				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_30_1:ShowNextGo(false)
			end

			if arg_30_1.frameCnt_ <= 1 then
				arg_30_1.dialog_:SetActive(false)
			end

			local var_33_12 = 3.33333333333333
			local var_33_13 = 0.275

			if 3.33333333333333 < arg_30_1.time_ and arg_30_1.time_ <= var_33_12 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				arg_30_1.dialog_:SetActive(true)

				arg_30_1.dialogCg_.alpha = 0

				local var_33_14 = LeanTween.value(arg_30_1.dialog_, 0, 1, 0.3)

				var_33_14:setOnUpdate(LuaHelper.FloatAction(function(arg_34_0)
					arg_30_1.dialogCg_.alpha = arg_34_0
				end))
				var_33_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_30_1.dialog_)
					var_33_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_30_1.duration_ = arg_30_1.duration_ + 0.3

				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_15 = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(116091008).content)

				arg_30_1.text_.text = var_33_15

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_17 = 11 <= 0 and var_33_13 or var_33_13 * (utf8.len(var_33_15) / 11)

				if (11 <= 0 and var_33_13 or var_33_13 * (utf8.len(var_33_15) / 11)) > 0 and var_33_13 < var_33_17 then
					arg_30_1.talkMaxDuration = var_33_17
					var_33_12 = var_33_12 + 0.3

					if var_33_17 + var_33_12 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_17 + var_33_12
					end
				end

				arg_30_1.text_.text = var_33_15
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_18 = var_33_12 + 0.3
			local var_33_19 = math.max(var_33_13, arg_30_1.talkMaxDuration)

			if var_33_12 + 0.3 <= arg_30_1.time_ and arg_30_1.time_ < var_33_18 + var_33_19 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_18) / var_33_19

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_18 + var_33_19 and arg_30_1.time_ < var_33_18 + var_33_19 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play116091009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 116091009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play116091010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_39_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_36_1.bgmTxt_.text ~= var_39_2 and arg_36_1.bgmTxt_.text ~= "" then
						if arg_36_1.bgmTxt2_.text ~= "" then
							arg_36_1.bgmTxt_.text = arg_36_1.bgmTxt2_.text
						end

						arg_36_1.bgmTxt2_.text = var_39_2

						arg_36_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_36_1.bgmTxt_.text = var_39_2
						arg_36_1.bgmTxt2_.text = var_39_2
					end

					if arg_36_1.bgmTimer then
						arg_36_1.bgmTimer:Stop()

						arg_36_1.bgmTimer = nil
					end

					if arg_36_1.settingData.show_music_name == 1 then
						arg_36_1.musicController:SetSelectedState("show")
						arg_36_1.musicAnimator_:Play("open", 0, 0)

						if arg_36_1.settingData.music_time ~= 0 then
							arg_36_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_36_1.settingData.music_time), function()
								if arg_36_1 == nil or isNil(arg_36_1.bgmTxt_) then
									return
								end

								arg_36_1.musicController:SetSelectedState("hide")
								arg_36_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.5 < arg_36_1.time_ and arg_36_1.time_ <= 1.5 + arg_39_0 then
				arg_36_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_39_5 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if "" ~= "" then
					if arg_36_1.bgmTxt_.text ~= var_39_5 and arg_36_1.bgmTxt_.text ~= "" then
						if arg_36_1.bgmTxt2_.text ~= "" then
							arg_36_1.bgmTxt_.text = arg_36_1.bgmTxt2_.text
						end

						arg_36_1.bgmTxt2_.text = var_39_5

						arg_36_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_36_1.bgmTxt_.text = var_39_5
						arg_36_1.bgmTxt2_.text = var_39_5
					end

					if arg_36_1.bgmTimer then
						arg_36_1.bgmTimer:Stop()

						arg_36_1.bgmTimer = nil
					end

					if arg_36_1.settingData.show_music_name == 1 then
						arg_36_1.musicController:SetSelectedState("show")
						arg_36_1.musicAnimator_:Play("open", 0, 0)

						if arg_36_1.settingData.music_time ~= 0 then
							arg_36_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_36_1.settingData.music_time), function()
								if arg_36_1 == nil or isNil(arg_36_1.bgmTxt_) then
									return
								end

								arg_36_1.musicController:SetSelectedState("hide")
								arg_36_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_39_6 = 0
			local var_39_7 = 1.325

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_8 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(116091009).content)

				arg_36_1.text_.text = var_39_8

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_10 = 53 <= 0 and var_39_7 or var_39_7 * (utf8.len(var_39_8) / 53)

				if (53 <= 0 and var_39_7 or var_39_7 * (utf8.len(var_39_8) / 53)) > 0 and var_39_7 < var_39_10 then
					arg_36_1.talkMaxDuration = var_39_10

					if var_39_10 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_6
					end
				end

				arg_36_1.text_.text = var_39_8
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_11 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_11 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_11

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_11 and arg_36_1.time_ < var_39_6 + var_39_11 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play116091010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 116091010
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play116091011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0.375

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_1 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(116091010).content)

				arg_42_1.text_.text = var_45_1

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_3 = 15 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_1) / 15)

				if (15 <= 0 and var_45_0 or var_45_0 * (utf8.len(var_45_1) / 15)) > 0 and var_45_0 < var_45_3 then
					arg_42_1.talkMaxDuration = var_45_3

					if var_45_3 + 0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_3 + 0
					end
				end

				arg_42_1.text_.text = var_45_1
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_4 = math.max(var_45_0, arg_42_1.talkMaxDuration)

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - 0) / var_45_4

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play116091011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 116091011
		arg_46_1.duration_ = 6.2

		local var_46_0 = {
			zh = 5.333,
			ja = 6.2
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play116091012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0.7

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, true)
				arg_46_1.iconController_:SetSelectedState("hero")

				arg_46_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_46_1.callingController_:SetSelectedState("normal")

				arg_46_1.keyicon_.color = Color.New(1, 1, 1)
				arg_46_1.icon_.color = Color.New(1, 1, 1)

				local var_49_1 = arg_46_1:GetWordFromCfg(116091011)
				local var_49_2 = arg_46_1:FormatText(var_49_1.content)

				arg_46_1.text_.text = var_49_2

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_4 = 28 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 28)

				if (28 <= 0 and var_49_0 or var_49_0 * (utf8.len(var_49_2) / 28)) > 0 and var_49_0 < var_49_4 then
					arg_46_1.talkMaxDuration = var_49_4

					if var_49_4 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_4 + 0
					end
				end

				arg_46_1.text_.text = var_49_2
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091011", "story_v_out_116091.awb") ~= 0 then
					local var_49_5 = manager.audio:GetVoiceLength("story_v_out_116091", "116091011", "story_v_out_116091.awb") / 1000

					if var_49_5 + 0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + 0
					end

					if var_49_1.prefab_name ~= "" and arg_46_1.actors_[var_49_1.prefab_name] ~= nil then
						local var_49_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_1.prefab_name].transform, "story_v_out_116091", "116091011", "story_v_out_116091.awb")

						arg_46_1:RecordAudio("116091011", var_49_6)
						arg_46_1:RecordAudio("116091011", var_49_6)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_116091", "116091011", "story_v_out_116091.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_116091", "116091011", "story_v_out_116091.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_7 = math.max(var_49_0, arg_46_1.talkMaxDuration)

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_7 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - 0) / var_49_7

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= 0 + var_49_7 and arg_46_1.time_ < 0 + var_49_7 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play116091012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 116091012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play116091013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0.275

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, true)
				arg_50_1.iconController_:SetSelectedState("hero")

				arg_50_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_50_1.callingController_:SetSelectedState("normal")

				arg_50_1.keyicon_.color = Color.New(1, 1, 1)
				arg_50_1.icon_.color = Color.New(1, 1, 1)

				local var_53_1 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(116091012).content)

				arg_50_1.text_.text = var_53_1

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_3 = 11 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_1) / 11)

				if (11 <= 0 and var_53_0 or var_53_0 * (utf8.len(var_53_1) / 11)) > 0 and var_53_0 < var_53_3 then
					arg_50_1.talkMaxDuration = var_53_3

					if var_53_3 + 0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_3 + 0
					end
				end

				arg_50_1.text_.text = var_53_1
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_4 = math.max(var_53_0, arg_50_1.talkMaxDuration)

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_4 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - 0) / var_53_4

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= 0 + var_53_4 and arg_50_1.time_ < 0 + var_53_4 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play116091013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 116091013
		arg_54_1.duration_ = 9

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play116091014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if arg_54_1.bgs_.B13a == nil then
				local var_57_0 = Object.Instantiate(arg_54_1.paintGo_)

				var_57_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13a")
				var_57_0.name = "B13a"
				var_57_0.transform.parent = arg_54_1.stage_.transform
				var_57_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_54_1.bgs_.B13a = var_57_0
			end

			if 2 < arg_54_1.time_ and arg_54_1.time_ <= 2 + arg_57_0 then
				local var_57_1 = arg_54_1.bgs_.B13a

				arg_54_1.bgs_.B13a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_57_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_57_2 = var_57_1:GetComponent("SpriteRenderer")

				if var_57_2 and var_57_2.sprite then
					local var_57_3 = 2 * (var_57_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_57_1.transform.localScale = Vector3.New(var_57_3 / var_57_2.sprite.bounds.size.y < var_57_3 * manager.ui.mainCameraCom_.aspect / var_57_2.sprite.bounds.size.x and var_57_3 * manager.ui.mainCameraCom_.aspect / var_57_2.sprite.bounds.size.x or var_57_3 / var_57_2.sprite.bounds.size.y, var_57_3 / var_57_2.sprite.bounds.size.y < var_57_3 * manager.ui.mainCameraCom_.aspect / var_57_2.sprite.bounds.size.x and var_57_3 * manager.ui.mainCameraCom_.aspect / var_57_2.sprite.bounds.size.x or var_57_3 / var_57_2.sprite.bounds.size.y, 0)
				end

				for iter_57_0, iter_57_1 in pairs(arg_54_1.bgs_) do
					if iter_57_0 ~= "B13a" then
						iter_57_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_57_4 = 0

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_4 + arg_57_0 then
				arg_54_1.mask_.enabled = true
				arg_54_1.mask_.raycastTarget = false

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
				arg_54_1.mask_.raycastTarget = false

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
			local var_57_13 = 0.375

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

				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_15 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(116091013).content)

				arg_54_1.text_.text = var_57_15

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_17 = 15 <= 0 and var_57_13 or var_57_13 * (utf8.len(var_57_15) / 15)

				if (15 <= 0 and var_57_13 or var_57_13 * (utf8.len(var_57_15) / 15)) > 0 and var_57_13 < var_57_17 then
					arg_54_1.talkMaxDuration = var_57_17
					var_57_12 = var_57_12 + 0.3

					if var_57_17 + var_57_12 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_17 + var_57_12
					end
				end

				arg_54_1.text_.text = var_57_15
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_18 = var_57_12 + 0.3
			local var_57_19 = math.max(var_57_13, arg_54_1.talkMaxDuration)

			if var_57_12 + 0.3 <= arg_54_1.time_ and arg_54_1.time_ < var_57_18 + var_57_19 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_18) / var_57_19

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_18 + var_57_19 and arg_54_1.time_ < var_57_18 + var_57_19 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play116091014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 116091014
		arg_60_1.duration_ = 4

		local var_60_0 = {
			zh = 3.8,
			ja = 4
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
				arg_60_0:Play116091015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if arg_60_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_63_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_60_1.stage_.transform)

				var_63_0.name = "1084ui_story"
				var_63_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.actors_["1084ui_story"] = var_63_0

				local var_63_1 = var_63_0:GetComponentInChildren(typeof(CharacterEffect))

				var_63_1.enabled = true

				local var_63_2 = GameObjectTools.GetOrAddComponent(var_63_0, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(false)
				end

				arg_60_1:ShowWeapon(var_63_1.transform, false)

				arg_60_1.var_["1084ui_story" .. "Animator"] = var_63_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_60_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_60_1.var_["1084ui_story" .. "LipSync"] = var_63_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_63_3 = arg_60_1.actors_["1084ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1084ui_story = var_63_3.localPosition
			end

			local var_63_4 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 then
				var_63_3.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_60_1.time_ - 0) / var_63_4)
				var_63_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_3.position).x, (manager.ui.mainCamera.transform.position - var_63_3.position).y, (manager.ui.mainCamera.transform.position - var_63_3.position).z)
				var_63_3.localEulerAngles.z = 0
				var_63_3.localEulerAngles.x = 0
				var_63_3.localEulerAngles = var_63_3.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 then
				var_63_3.localPosition = Vector3.New(0, -0.97, -6)
				var_63_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_3.position).x, (manager.ui.mainCamera.transform.position - var_63_3.position).y, (manager.ui.mainCamera.transform.position - var_63_3.position).z)
				var_63_3.localEulerAngles.z = 0
				var_63_3.localEulerAngles.x = 0
				var_63_3.localEulerAngles = var_63_3.localEulerAngles
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_63_5 = 0
			local var_63_6 = 0.475

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_7 = arg_60_1:GetWordFromCfg(116091014)
				local var_63_8 = arg_60_1:FormatText(var_63_7.content)

				arg_60_1.text_.text = var_63_8

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_10 = 19 <= 0 and var_63_6 or var_63_6 * (utf8.len(var_63_8) / 19)

				if (19 <= 0 and var_63_6 or var_63_6 * (utf8.len(var_63_8) / 19)) > 0 and var_63_6 < var_63_10 then
					arg_60_1.talkMaxDuration = var_63_10

					if var_63_10 + var_63_5 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_5
					end
				end

				arg_60_1.text_.text = var_63_8
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091014", "story_v_out_116091.awb") ~= 0 then
					local var_63_11 = manager.audio:GetVoiceLength("story_v_out_116091", "116091014", "story_v_out_116091.awb") / 1000

					if var_63_11 + var_63_5 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_11 + var_63_5
					end

					if var_63_7.prefab_name ~= "" and arg_60_1.actors_[var_63_7.prefab_name] ~= nil then
						local var_63_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_7.prefab_name].transform, "story_v_out_116091", "116091014", "story_v_out_116091.awb")

						arg_60_1:RecordAudio("116091014", var_63_12)
						arg_60_1:RecordAudio("116091014", var_63_12)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_116091", "116091014", "story_v_out_116091.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_116091", "116091014", "story_v_out_116091.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_13 = math.max(var_63_6, arg_60_1.talkMaxDuration)

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_13 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_5) / var_63_13

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_5 + var_63_13 and arg_60_1.time_ < var_63_5 + var_63_13 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play116091015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 116091015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play116091016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1084ui_story"]) and arg_64_1.var_.characterEffect1084ui_story == nil then
				arg_64_1.var_.characterEffect1084ui_story = arg_64_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1084ui_story"]) then
				if arg_64_1.var_.characterEffect1084ui_story and not isNil(arg_64_1.actors_["1084ui_story"]) then
					arg_64_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_0)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1084ui_story"]) and arg_64_1.var_.characterEffect1084ui_story then
				arg_64_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_67_1 = 0
			local var_67_2 = 0.225

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(116091015).content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 9 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 9)

				if (9 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 9)) > 0 and var_67_2 < var_67_5 then
					arg_64_1.talkMaxDuration = var_67_5

					if var_67_5 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + var_67_1
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_6 = math.max(var_67_2, arg_64_1.talkMaxDuration)

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_6 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_1) / var_67_6

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_1 + var_67_6 and arg_64_1.time_ < var_67_1 + var_67_6 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play116091016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 116091016
		arg_68_1.duration_ = 10.2

		local var_68_0 = {
			zh = 10.2,
			ja = 9.233
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
				arg_68_0:Play116091017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1084ui_story"]) and arg_68_1.var_.characterEffect1084ui_story == nil then
				arg_68_1.var_.characterEffect1084ui_story = arg_68_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1084ui_story"]) then
				if arg_68_1.var_.characterEffect1084ui_story and not isNil(arg_68_1.actors_["1084ui_story"]) then
					arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1084ui_story"]) and arg_68_1.var_.characterEffect1084ui_story then
				arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action463")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_71_2 = 0
			local var_71_3 = 0.975

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_2 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_4 = arg_68_1:GetWordFromCfg(116091016)
				local var_71_5 = arg_68_1:FormatText(var_71_4.content)

				arg_68_1.text_.text = var_71_5

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_7 = 39 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_5) / 39)

				if (39 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_5) / 39)) > 0 and var_71_3 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_2
					end
				end

				arg_68_1.text_.text = var_71_5
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091016", "story_v_out_116091.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_116091", "116091016", "story_v_out_116091.awb") / 1000

					if var_71_8 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_2
					end

					if var_71_4.prefab_name ~= "" and arg_68_1.actors_[var_71_4.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_4.prefab_name].transform, "story_v_out_116091", "116091016", "story_v_out_116091.awb")

						arg_68_1:RecordAudio("116091016", var_71_9)
						arg_68_1:RecordAudio("116091016", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_116091", "116091016", "story_v_out_116091.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_116091", "116091016", "story_v_out_116091.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_10 = math.max(var_71_3, arg_68_1.talkMaxDuration)

			if var_71_2 <= arg_68_1.time_ and arg_68_1.time_ < var_71_2 + var_71_10 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_2) / var_71_10

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_2 + var_71_10 and arg_68_1.time_ < var_71_2 + var_71_10 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play116091017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 116091017
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play116091018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1084ui_story = arg_72_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_75_0 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 then
				arg_72_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_72_1.time_ - 0) / var_75_0)
				arg_72_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1084ui_story"].transform.position).z)
				arg_72_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1084ui_story"].transform.localEulerAngles = arg_72_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 then
				arg_72_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_72_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1084ui_story"].transform.position).z)
				arg_72_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1084ui_story"].transform.localEulerAngles = arg_72_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_75_1 = 0
			local var_75_2 = 1

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_3 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(116091017).content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 40 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 40)

				if (40 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 40)) > 0 and var_75_2 < var_75_5 then
					arg_72_1.talkMaxDuration = var_75_5

					if var_75_5 + var_75_1 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + var_75_1
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_6 = math.max(var_75_2, arg_72_1.talkMaxDuration)

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_6 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_1) / var_75_6

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_1 + var_75_6 and arg_72_1.time_ < var_75_1 + var_75_6 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play116091018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 116091018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play116091019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.3

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_1 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(116091018).content)

				arg_76_1.text_.text = var_79_1

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_3 = 13 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 13)

				if (13 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 13)) > 0 and var_79_0 < var_79_3 then
					arg_76_1.talkMaxDuration = var_79_3

					if var_79_3 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_3 + 0
					end
				end

				arg_76_1.text_.text = var_79_1
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_4 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_4

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play116091019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 116091019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play116091020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:AudioAction("play", "effect", "se_story_side_1026", "se_story_1026_alert", "")
			end

			local var_83_1 = 0
			local var_83_2 = 0.075

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_3 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(116091019).content)

				arg_80_1.text_.text = var_83_3

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_5 = 3 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 3)

				if (3 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_3) / 3)) > 0 and var_83_2 < var_83_5 then
					arg_80_1.talkMaxDuration = var_83_5

					if var_83_5 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_3
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_6 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_6 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_6

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_6 and arg_80_1.time_ < var_83_1 + var_83_6 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play116091020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 116091020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play116091021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.35

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_1 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(116091020).content)

				arg_84_1.text_.text = var_87_1

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_3 = 14 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 14)

				if (14 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 14)) > 0 and var_87_0 < var_87_3 then
					arg_84_1.talkMaxDuration = var_87_3

					if var_87_3 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_3 + 0
					end
				end

				arg_84_1.text_.text = var_87_1
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_4 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_4

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play116091021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 116091021
		arg_88_1.duration_ = 4.13

		local var_88_0 = {
			zh = 4.133,
			ja = 3.233
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
				arg_88_0:Play116091022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1084ui_story = arg_88_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_91_0 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 then
				arg_88_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_88_1.time_ - 0) / var_91_0)
				arg_88_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1084ui_story"].transform.position).z)
				arg_88_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["1084ui_story"].transform.localEulerAngles = arg_88_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 then
				arg_88_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_88_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1084ui_story"].transform.position).z)
				arg_88_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["1084ui_story"].transform.localEulerAngles = arg_88_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_91_1 = arg_88_1.actors_["1084ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_1) and arg_88_1.var_.characterEffect1084ui_story == nil then
				arg_88_1.var_.characterEffect1084ui_story = var_91_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.2

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_2 and not isNil(var_91_1) then
				if arg_88_1.var_.characterEffect1084ui_story and not isNil(var_91_1) then
					arg_88_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_2 and arg_88_1.time_ < 0 + var_91_2 + arg_91_0 and not isNil(var_91_1) and arg_88_1.var_.characterEffect1084ui_story then
				arg_88_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_91_4 = 0
			local var_91_5 = 0.525

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_6 = arg_88_1:GetWordFromCfg(116091021)
				local var_91_7 = arg_88_1:FormatText(var_91_6.content)

				arg_88_1.text_.text = var_91_7

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_9 = 21 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 21)

				if (21 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 21)) > 0 and var_91_5 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_4
					end
				end

				arg_88_1.text_.text = var_91_7
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091021", "story_v_out_116091.awb") ~= 0 then
					local var_91_10 = manager.audio:GetVoiceLength("story_v_out_116091", "116091021", "story_v_out_116091.awb") / 1000

					if var_91_10 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_4
					end

					if var_91_6.prefab_name ~= "" and arg_88_1.actors_[var_91_6.prefab_name] ~= nil then
						local var_91_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_6.prefab_name].transform, "story_v_out_116091", "116091021", "story_v_out_116091.awb")

						arg_88_1:RecordAudio("116091021", var_91_11)
						arg_88_1:RecordAudio("116091021", var_91_11)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_116091", "116091021", "story_v_out_116091.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_116091", "116091021", "story_v_out_116091.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_12 = math.max(var_91_5, arg_88_1.talkMaxDuration)

			if var_91_4 <= arg_88_1.time_ and arg_88_1.time_ < var_91_4 + var_91_12 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_4) / var_91_12

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_4 + var_91_12 and arg_88_1.time_ < var_91_4 + var_91_12 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play116091022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 116091022
		arg_92_1.duration_ = 8

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play116091023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 1.466 < arg_92_1.time_ and arg_92_1.time_ <= 1.466 + arg_95_0 then
				arg_92_1.var_.moveOldPos1084ui_story = arg_92_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_95_0 = 0.001

			if 1.466 <= arg_92_1.time_ and arg_92_1.time_ < 1.466 + var_95_0 then
				arg_92_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_92_1.time_ - 1.466) / var_95_0)
				arg_92_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1084ui_story"].transform.position).z)
				arg_92_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1084ui_story"].transform.localEulerAngles = arg_92_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_92_1.time_ >= 1.466 + var_95_0 and arg_92_1.time_ < 1.466 + var_95_0 + arg_95_0 then
				arg_92_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1084ui_story"].transform.position).z)
				arg_92_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1084ui_story"].transform.localEulerAngles = arg_92_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_95_1 = manager.ui.mainCamera.transform

			if 3 < arg_92_1.time_ and arg_92_1.time_ <= 3 + arg_95_0 then
				arg_92_1.var_.shakeOldPos = var_95_1.localPosition
			end

			local var_95_2 = 0.333333333333333

			if 3 <= arg_92_1.time_ and arg_92_1.time_ < 3 + var_95_2 then
				local var_95_3, var_95_4 = math.modf((arg_92_1.time_ - 3) / 0.066)

				var_95_1.localPosition = Vector3.New(var_95_4 * 0.13, var_95_4 * 0.13, var_95_4 * 0.13) + arg_92_1.var_.shakeOldPos
			end

			if arg_92_1.time_ >= 3 + var_95_2 and arg_92_1.time_ < 3 + var_95_2 + arg_95_0 then
				var_95_1.localPosition = arg_92_1.var_.shakeOldPos
			end

			if 3 < arg_92_1.time_ and arg_92_1.time_ <= 3 + arg_95_0 then
				arg_92_1:AudioAction("play", "effect", "se_story_16", "se_story_16_foot02", "")
			end

			local var_95_6 = 0

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_7 = 1.5

			if var_95_6 <= arg_92_1.time_ and arg_92_1.time_ < var_95_6 + var_95_7 then
				local var_95_8 = Color.New(0, 0, 0)

				var_95_8.a = Mathf.Lerp(0, 1, (arg_92_1.time_ - var_95_6) / var_95_7)
				arg_92_1.mask_.color = var_95_8
			end

			if arg_92_1.time_ >= var_95_6 + var_95_7 and arg_92_1.time_ < var_95_6 + var_95_7 + arg_95_0 then
				local var_95_9 = Color.New(0, 0, 0)

				var_95_9.a = 1
				arg_92_1.mask_.color = var_95_9
			end

			local var_95_10 = 1.5

			if 1.5 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_11 = 1.5

			if var_95_10 <= arg_92_1.time_ and arg_92_1.time_ < var_95_10 + var_95_11 then
				local var_95_12 = Color.New(0, 0, 0)

				var_95_12.a = Mathf.Lerp(1, 0, (arg_92_1.time_ - var_95_10) / var_95_11)
				arg_92_1.mask_.color = var_95_12
			end

			if arg_92_1.time_ >= var_95_10 + var_95_11 and arg_92_1.time_ < var_95_10 + var_95_11 + arg_95_0 then
				local var_95_13 = Color.New(0, 0, 0)

				arg_92_1.mask_.enabled = false
				var_95_13.a = 0
				arg_92_1.mask_.color = var_95_13
			end

			if arg_92_1.frameCnt_ <= 1 then
				arg_92_1.dialog_:SetActive(false)
			end

			local var_95_14 = 3
			local var_95_15 = 0.2

			if 3 < arg_92_1.time_ and arg_92_1.time_ <= var_95_14 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0

				arg_92_1.dialog_:SetActive(true)

				arg_92_1.dialogCg_.alpha = 0

				local var_95_16 = LeanTween.value(arg_92_1.dialog_, 0, 1, 0.3)

				var_95_16:setOnUpdate(LuaHelper.FloatAction(function(arg_96_0)
					arg_92_1.dialogCg_.alpha = arg_96_0
				end))
				var_95_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_92_1.dialog_)
					var_95_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_92_1.duration_ = arg_92_1.duration_ + 0.3

				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_17 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(116091022).content)

				arg_92_1.text_.text = var_95_17

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_19 = 8 <= 0 and var_95_15 or var_95_15 * (utf8.len(var_95_17) / 8)

				if (8 <= 0 and var_95_15 or var_95_15 * (utf8.len(var_95_17) / 8)) > 0 and var_95_15 < var_95_19 then
					arg_92_1.talkMaxDuration = var_95_19
					var_95_14 = var_95_14 + 0.3

					if var_95_19 + var_95_14 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_19 + var_95_14
					end
				end

				arg_92_1.text_.text = var_95_17
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_20 = var_95_14 + 0.3
			local var_95_21 = math.max(var_95_15, arg_92_1.talkMaxDuration)

			if var_95_14 + 0.3 <= arg_92_1.time_ and arg_92_1.time_ < var_95_20 + var_95_21 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_20) / var_95_21

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_20 + var_95_21 and arg_92_1.time_ < var_95_20 + var_95_21 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.466,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play116091023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 116091023
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play116091024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0.95

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_1 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(116091023).content)

				arg_98_1.text_.text = var_101_1

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_3 = 38 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_1) / 38)

				if (38 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_1) / 38)) > 0 and var_101_0 < var_101_3 then
					arg_98_1.talkMaxDuration = var_101_3

					if var_101_3 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_3 + 0
					end
				end

				arg_98_1.text_.text = var_101_1
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_4 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_4

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play116091024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 116091024
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play116091025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 1.175

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_1 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(116091024).content)

				arg_102_1.text_.text = var_105_1

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_3 = 47 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_1) / 47)

				if (47 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_1) / 47)) > 0 and var_105_0 < var_105_3 then
					arg_102_1.talkMaxDuration = var_105_3

					if var_105_3 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_3 + 0
					end
				end

				arg_102_1.text_.text = var_105_1
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_4 = math.max(var_105_0, arg_102_1.talkMaxDuration)

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_4 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - 0) / var_105_4

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= 0 + var_105_4 and arg_102_1.time_ < 0 + var_105_4 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play116091025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 116091025
		arg_106_1.duration_ = 4.67

		local var_106_0 = {
			zh = 3.6,
			ja = 4.666
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play116091026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0.2

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_1 = arg_106_1:GetWordFromCfg(116091025)
				local var_109_2 = arg_106_1:FormatText(var_109_1.content)

				arg_106_1.text_.text = var_109_2

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 8 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 8)

				if (8 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 8)) > 0 and var_109_0 < var_109_4 then
					arg_106_1.talkMaxDuration = var_109_4

					if var_109_4 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_4 + 0
					end
				end

				arg_106_1.text_.text = var_109_2
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091025", "story_v_out_116091.awb") ~= 0 then
					local var_109_5 = manager.audio:GetVoiceLength("story_v_out_116091", "116091025", "story_v_out_116091.awb") / 1000

					if var_109_5 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + 0
					end

					if var_109_1.prefab_name ~= "" and arg_106_1.actors_[var_109_1.prefab_name] ~= nil then
						local var_109_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_1.prefab_name].transform, "story_v_out_116091", "116091025", "story_v_out_116091.awb")

						arg_106_1:RecordAudio("116091025", var_109_6)
						arg_106_1:RecordAudio("116091025", var_109_6)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_116091", "116091025", "story_v_out_116091.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_116091", "116091025", "story_v_out_116091.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_7 = math.max(var_109_0, arg_106_1.talkMaxDuration)

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - 0) / var_109_7

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play116091026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 116091026
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play116091027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.75

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_1 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(116091026).content)

				arg_110_1.text_.text = var_113_1

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_3 = 30 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_1) / 30)

				if (30 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_1) / 30)) > 0 and var_113_0 < var_113_3 then
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
	Play116091027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 116091027
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play116091028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 1.325

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_1 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(116091027).content)

				arg_114_1.text_.text = var_117_1

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_3 = 53 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_1) / 53)

				if (53 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_1) / 53)) > 0 and var_117_0 < var_117_3 then
					arg_114_1.talkMaxDuration = var_117_3

					if var_117_3 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_3 + 0
					end
				end

				arg_114_1.text_.text = var_117_1
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_4 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_4 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_4

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_4 and arg_114_1.time_ < 0 + var_117_4 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play116091028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 116091028
		arg_118_1.duration_ = 14.03

		local var_118_0 = {
			zh = 9.7,
			ja = 14.033
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
				arg_118_0:Play116091029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1084ui_story = arg_118_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_121_0 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 then
				arg_118_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_118_1.time_ - 0) / var_121_0)
				arg_118_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1084ui_story"].transform.position).z)
				arg_118_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["1084ui_story"].transform.localEulerAngles = arg_118_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 then
				arg_118_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_118_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1084ui_story"].transform.position).z)
				arg_118_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["1084ui_story"].transform.localEulerAngles = arg_118_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_121_1 = arg_118_1.actors_["1084ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_1) and arg_118_1.var_.characterEffect1084ui_story == nil then
				arg_118_1.var_.characterEffect1084ui_story = var_121_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.2

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_2 and not isNil(var_121_1) then
				if arg_118_1.var_.characterEffect1084ui_story and not isNil(var_121_1) then
					arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_2 and arg_118_1.time_ < 0 + var_121_2 + arg_121_0 and not isNil(var_121_1) and arg_118_1.var_.characterEffect1084ui_story then
				arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_121_4 = 0
			local var_121_5 = 0.725

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_6 = arg_118_1:GetWordFromCfg(116091028)
				local var_121_7 = arg_118_1:FormatText(var_121_6.content)

				arg_118_1.text_.text = var_121_7

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_9 = 29 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 29)

				if (29 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 29)) > 0 and var_121_5 < var_121_9 then
					arg_118_1.talkMaxDuration = var_121_9

					if var_121_9 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_9 + var_121_4
					end
				end

				arg_118_1.text_.text = var_121_7
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091028", "story_v_out_116091.awb") ~= 0 then
					local var_121_10 = manager.audio:GetVoiceLength("story_v_out_116091", "116091028", "story_v_out_116091.awb") / 1000

					if var_121_10 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_10 + var_121_4
					end

					if var_121_6.prefab_name ~= "" and arg_118_1.actors_[var_121_6.prefab_name] ~= nil then
						local var_121_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_6.prefab_name].transform, "story_v_out_116091", "116091028", "story_v_out_116091.awb")

						arg_118_1:RecordAudio("116091028", var_121_11)
						arg_118_1:RecordAudio("116091028", var_121_11)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_116091", "116091028", "story_v_out_116091.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_116091", "116091028", "story_v_out_116091.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_12 = math.max(var_121_5, arg_118_1.talkMaxDuration)

			if var_121_4 <= arg_118_1.time_ and arg_118_1.time_ < var_121_4 + var_121_12 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_4) / var_121_12

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_4 + var_121_12 and arg_118_1.time_ < var_121_4 + var_121_12 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play116091029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 116091029
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play116091030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["1084ui_story"]) and arg_122_1.var_.characterEffect1084ui_story == nil then
				arg_122_1.var_.characterEffect1084ui_story = arg_122_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.2

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["1084ui_story"]) then
				if arg_122_1.var_.characterEffect1084ui_story and not isNil(arg_122_1.actors_["1084ui_story"]) then
					arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_0)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["1084ui_story"]) and arg_122_1.var_.characterEffect1084ui_story then
				arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_125_1 = 0
			local var_125_2 = 0.35

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_3 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(116091029).content)

				arg_122_1.text_.text = var_125_3

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 14 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_3) / 14)

				if (14 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_3) / 14)) > 0 and var_125_2 < var_125_5 then
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
	Play116091030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 116091030
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play116091031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action474")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_129_0 = 0
			local var_129_1 = 0.425

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_2 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(116091030).content)

				arg_126_1.text_.text = var_129_2

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_4 = 17 <= 0 and var_129_1 or var_129_1 * (utf8.len(var_129_2) / 17)

				if (17 <= 0 and var_129_1 or var_129_1 * (utf8.len(var_129_2) / 17)) > 0 and var_129_1 < var_129_4 then
					arg_126_1.talkMaxDuration = var_129_4

					if var_129_4 + var_129_0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_4 + var_129_0
					end
				end

				arg_126_1.text_.text = var_129_2
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_5 = math.max(var_129_1, arg_126_1.talkMaxDuration)

			if var_129_0 <= arg_126_1.time_ and arg_126_1.time_ < var_129_0 + var_129_5 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_0) / var_129_5

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_0 + var_129_5 and arg_126_1.time_ < var_129_0 + var_129_5 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play116091031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 116091031
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play116091032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1084ui_story = arg_130_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_133_0 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 then
				arg_130_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_130_1.time_ - 0) / var_133_0)
				arg_130_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1084ui_story"].transform.position).z)
				arg_130_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["1084ui_story"].transform.localEulerAngles = arg_130_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 then
				arg_130_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_130_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["1084ui_story"].transform.position).z)
				arg_130_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["1084ui_story"].transform.localEulerAngles = arg_130_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:AudioAction("play", "effect", "se_story_16", "se_story_16_di", "")
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_133_4 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_130_1.bgmTxt_.text ~= var_133_4 and arg_130_1.bgmTxt_.text ~= "" then
						if arg_130_1.bgmTxt2_.text ~= "" then
							arg_130_1.bgmTxt_.text = arg_130_1.bgmTxt2_.text
						end

						arg_130_1.bgmTxt2_.text = var_133_4

						arg_130_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_130_1.bgmTxt_.text = var_133_4
						arg_130_1.bgmTxt2_.text = var_133_4
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

			local var_133_5 = 0
			local var_133_6 = 0.075

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_7 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(116091031).content)

				arg_130_1.text_.text = var_133_7

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_9 = 3 <= 0 and var_133_6 or var_133_6 * (utf8.len(var_133_7) / 3)

				if (3 <= 0 and var_133_6 or var_133_6 * (utf8.len(var_133_7) / 3)) > 0 and var_133_6 < var_133_9 then
					arg_130_1.talkMaxDuration = var_133_9

					if var_133_9 + var_133_5 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_9 + var_133_5
					end
				end

				arg_130_1.text_.text = var_133_7
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_10 = math.max(var_133_6, arg_130_1.talkMaxDuration)

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_10 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_5) / var_133_10

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_5 + var_133_10 and arg_130_1.time_ < var_133_5 + var_133_10 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play116091032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 116091032
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play116091033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 1.625

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_1 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(116091032).content)

				arg_135_1.text_.text = var_138_1

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_3 = 65 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 65)

				if (65 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 65)) > 0 and var_138_0 < var_138_3 then
					arg_135_1.talkMaxDuration = var_138_3

					if var_138_3 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_3 + 0
					end
				end

				arg_135_1.text_.text = var_138_1
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_4 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_4

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play116091033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 116091033
		arg_139_1.duration_ = 2.67

		local var_139_0 = {
			zh = 1.999999999999,
			ja = 2.666
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play116091034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1084ui_story = arg_139_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1084ui_story"].transform.position).z)
				arg_139_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1084ui_story"].transform.localEulerAngles = arg_139_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_139_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1084ui_story"].transform.position).z)
				arg_139_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1084ui_story"].transform.localEulerAngles = arg_139_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["1084ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1084ui_story == nil then
				arg_139_1.var_.characterEffect1084ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect1084ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect1084ui_story then
				arg_139_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_142_4 = 0
			local var_142_5 = 0.2

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_6 = arg_139_1:GetWordFromCfg(116091033)
				local var_142_7 = arg_139_1:FormatText(var_142_6.content)

				arg_139_1.text_.text = var_142_7

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_9 = 8 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 8)

				if (8 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 8)) > 0 and var_142_5 < var_142_9 then
					arg_139_1.talkMaxDuration = var_142_9

					if var_142_9 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_9 + var_142_4
					end
				end

				arg_139_1.text_.text = var_142_7
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091033", "story_v_out_116091.awb") ~= 0 then
					local var_142_10 = manager.audio:GetVoiceLength("story_v_out_116091", "116091033", "story_v_out_116091.awb") / 1000

					if var_142_10 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_4
					end

					if var_142_6.prefab_name ~= "" and arg_139_1.actors_[var_142_6.prefab_name] ~= nil then
						local var_142_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_6.prefab_name].transform, "story_v_out_116091", "116091033", "story_v_out_116091.awb")

						arg_139_1:RecordAudio("116091033", var_142_11)
						arg_139_1:RecordAudio("116091033", var_142_11)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_116091", "116091033", "story_v_out_116091.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_116091", "116091033", "story_v_out_116091.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_12 = math.max(var_142_5, arg_139_1.talkMaxDuration)

			if var_142_4 <= arg_139_1.time_ and arg_139_1.time_ < var_142_4 + var_142_12 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_4) / var_142_12

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_4 + var_142_12 and arg_139_1.time_ < var_142_4 + var_142_12 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play116091034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 116091034
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play116091035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1084ui_story"]) and arg_143_1.var_.characterEffect1084ui_story == nil then
				arg_143_1.var_.characterEffect1084ui_story = arg_143_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1084ui_story"]) then
				if arg_143_1.var_.characterEffect1084ui_story and not isNil(arg_143_1.actors_["1084ui_story"]) then
					arg_143_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_0)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1084ui_story"]) and arg_143_1.var_.characterEffect1084ui_story then
				arg_143_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_146_3 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_143_1.bgmTxt_.text ~= var_146_3 and arg_143_1.bgmTxt_.text ~= "" then
						if arg_143_1.bgmTxt2_.text ~= "" then
							arg_143_1.bgmTxt_.text = arg_143_1.bgmTxt2_.text
						end

						arg_143_1.bgmTxt2_.text = var_146_3

						arg_143_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_143_1.bgmTxt_.text = var_146_3
						arg_143_1.bgmTxt2_.text = var_146_3
					end

					if arg_143_1.bgmTimer then
						arg_143_1.bgmTimer:Stop()

						arg_143_1.bgmTimer = nil
					end

					if arg_143_1.settingData.show_music_name == 1 then
						arg_143_1.musicController:SetSelectedState("show")
						arg_143_1.musicAnimator_:Play("open", 0, 0)

						if arg_143_1.settingData.music_time ~= 0 then
							arg_143_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_143_1.settingData.music_time), function()
								if arg_143_1 == nil or isNil(arg_143_1.bgmTxt_) then
									return
								end

								arg_143_1.musicController:SetSelectedState("hide")
								arg_143_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.366666666666667 < arg_143_1.time_ and arg_143_1.time_ <= 0.366666666666667 + arg_146_0 then
				arg_143_1:AudioAction("play", "music", "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense.awb")

				local var_146_6 = manager.audio:GetAudioName("bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense")

				if "" ~= "" then
					if arg_143_1.bgmTxt_.text ~= var_146_6 and arg_143_1.bgmTxt_.text ~= "" then
						if arg_143_1.bgmTxt2_.text ~= "" then
							arg_143_1.bgmTxt_.text = arg_143_1.bgmTxt2_.text
						end

						arg_143_1.bgmTxt2_.text = var_146_6

						arg_143_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_143_1.bgmTxt_.text = var_146_6
						arg_143_1.bgmTxt2_.text = var_146_6
					end

					if arg_143_1.bgmTimer then
						arg_143_1.bgmTimer:Stop()

						arg_143_1.bgmTimer = nil
					end

					if arg_143_1.settingData.show_music_name == 1 then
						arg_143_1.musicController:SetSelectedState("show")
						arg_143_1.musicAnimator_:Play("open", 0, 0)

						if arg_143_1.settingData.music_time ~= 0 then
							arg_143_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_143_1.settingData.music_time), function()
								if arg_143_1 == nil or isNil(arg_143_1.bgmTxt_) then
									return
								end

								arg_143_1.musicController:SetSelectedState("hide")
								arg_143_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.566666666666668 < arg_143_1.time_ and arg_143_1.time_ <= 0.566666666666668 + arg_146_0 then
				arg_143_1:AudioAction("play", "music", "bgm_activity_1_6_story_intense", "OG", "bgm_activity_1_6_story_intense.awb")

				local var_146_9 = manager.audio:GetAudioName("bgm_activity_1_6_story_intense", "OG")

				if "" ~= "" then
					if arg_143_1.bgmTxt_.text ~= var_146_9 and arg_143_1.bgmTxt_.text ~= "" then
						if arg_143_1.bgmTxt2_.text ~= "" then
							arg_143_1.bgmTxt_.text = arg_143_1.bgmTxt2_.text
						end

						arg_143_1.bgmTxt2_.text = var_146_9

						arg_143_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_143_1.bgmTxt_.text = var_146_9
						arg_143_1.bgmTxt2_.text = var_146_9
					end

					if arg_143_1.bgmTimer then
						arg_143_1.bgmTimer:Stop()

						arg_143_1.bgmTimer = nil
					end

					if arg_143_1.settingData.show_music_name == 1 then
						arg_143_1.musicController:SetSelectedState("show")
						arg_143_1.musicAnimator_:Play("open", 0, 0)

						if arg_143_1.settingData.music_time ~= 0 then
							arg_143_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_143_1.settingData.music_time), function()
								if arg_143_1 == nil or isNil(arg_143_1.bgmTxt_) then
									return
								end

								arg_143_1.musicController:SetSelectedState("hide")
								arg_143_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_146_10 = 0
			local var_146_11 = 0.225

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_10 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_12 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(116091034).content)

				arg_143_1.text_.text = var_146_12

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_14 = 9 <= 0 and var_146_11 or var_146_11 * (utf8.len(var_146_12) / 9)

				if (9 <= 0 and var_146_11 or var_146_11 * (utf8.len(var_146_12) / 9)) > 0 and var_146_11 < var_146_14 then
					arg_143_1.talkMaxDuration = var_146_14

					if var_146_14 + var_146_10 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_10
					end
				end

				arg_143_1.text_.text = var_146_12
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_15 = math.max(var_146_11, arg_143_1.talkMaxDuration)

			if var_146_10 <= arg_143_1.time_ and arg_143_1.time_ < var_146_10 + var_146_15 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_10) / var_146_15

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_10 + var_146_15 and arg_143_1.time_ < var_146_10 + var_146_15 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play116091035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 116091035
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play116091036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_153_0 = arg_150_1.actors_["1084ui_story"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos1084ui_story = var_153_0.localPosition

				arg_150_1:ShowWeapon(arg_150_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_153_1 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_1 then
				var_153_0.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_150_1.time_ - 0) / var_153_1)
				var_153_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_0.position).x, (manager.ui.mainCamera.transform.position - var_153_0.position).y, (manager.ui.mainCamera.transform.position - var_153_0.position).z)
				var_153_0.localEulerAngles.z = 0
				var_153_0.localEulerAngles.x = 0
				var_153_0.localEulerAngles = var_153_0.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_1 and arg_150_1.time_ < 0 + var_153_1 + arg_153_0 then
				var_153_0.localPosition = Vector3.New(0, -0.97, -6)
				var_153_0.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_0.position).x, (manager.ui.mainCamera.transform.position - var_153_0.position).y, (manager.ui.mainCamera.transform.position - var_153_0.position).z)
				var_153_0.localEulerAngles.z = 0
				var_153_0.localEulerAngles.x = 0
				var_153_0.localEulerAngles = var_153_0.localEulerAngles
			end

			local var_153_2 = 0
			local var_153_3 = 1.15

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_2 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_4 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(116091035).content)

				arg_150_1.text_.text = var_153_4

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_6 = 46 <= 0 and var_153_3 or var_153_3 * (utf8.len(var_153_4) / 46)

				if (46 <= 0 and var_153_3 or var_153_3 * (utf8.len(var_153_4) / 46)) > 0 and var_153_3 < var_153_6 then
					arg_150_1.talkMaxDuration = var_153_6

					if var_153_6 + var_153_2 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_6 + var_153_2
					end
				end

				arg_150_1.text_.text = var_153_4
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_7 = math.max(var_153_3, arg_150_1.talkMaxDuration)

			if var_153_2 <= arg_150_1.time_ and arg_150_1.time_ < var_153_2 + var_153_7 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_2) / var_153_7

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_2 + var_153_7 and arg_150_1.time_ < var_153_2 + var_153_7 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
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
	Play116091036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 116091036
		arg_154_1.duration_ = 7

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play116091037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if arg_154_1.bgs_.STwhite == nil then
				local var_157_0 = Object.Instantiate(arg_154_1.paintGo_)

				var_157_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_157_0.name = "STwhite"
				var_157_0.transform.parent = arg_154_1.stage_.transform
				var_157_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_154_1.bgs_.STwhite = var_157_0
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				local var_157_1 = arg_154_1.bgs_.STwhite

				arg_154_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_157_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_157_2 = var_157_1:GetComponent("SpriteRenderer")

				if var_157_2 and var_157_2.sprite then
					local var_157_3 = 2 * (var_157_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_157_1.transform.localScale = Vector3.New(var_157_3 / var_157_2.sprite.bounds.size.y < var_157_3 * manager.ui.mainCameraCom_.aspect / var_157_2.sprite.bounds.size.x and var_157_3 * manager.ui.mainCameraCom_.aspect / var_157_2.sprite.bounds.size.x or var_157_3 / var_157_2.sprite.bounds.size.y, var_157_3 / var_157_2.sprite.bounds.size.y < var_157_3 * manager.ui.mainCameraCom_.aspect / var_157_2.sprite.bounds.size.x and var_157_3 * manager.ui.mainCameraCom_.aspect / var_157_2.sprite.bounds.size.x or var_157_3 / var_157_2.sprite.bounds.size.y, 0)
				end

				for iter_157_0, iter_157_1 in pairs(arg_154_1.bgs_) do
					if iter_157_0 ~= "STwhite" then
						iter_157_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_157_4 = 0

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_4 + arg_157_0 then
				arg_154_1.mask_.enabled = true
				arg_154_1.mask_.raycastTarget = true

				arg_154_1:SetGaussion(false)
			end

			local var_157_5 = 2

			if var_157_4 <= arg_154_1.time_ and arg_154_1.time_ < var_157_4 + var_157_5 then
				local var_157_6 = Color.New(1, 1, 1)

				var_157_6.a = Mathf.Lerp(1, 0, (arg_154_1.time_ - var_157_4) / var_157_5)
				arg_154_1.mask_.color = var_157_6
			end

			if arg_154_1.time_ >= var_157_4 + var_157_5 and arg_154_1.time_ < var_157_4 + var_157_5 + arg_157_0 then
				local var_157_7 = Color.New(1, 1, 1)

				arg_154_1.mask_.enabled = false
				var_157_7.a = 0
				arg_154_1.mask_.color = var_157_7
			end

			local var_157_8 = arg_154_1.bgs_.STwhite.transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPosSTwhite = var_157_8.localPosition
				var_157_8.localScale = Vector3.New(12, 12, 12)
			end

			local var_157_9 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_9 then
				var_157_8.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPosSTwhite, Vector3.New(0, 0, 0), (arg_154_1.time_ - 0) / var_157_9)
			end

			if arg_154_1.time_ >= 0 + var_157_9 and arg_154_1.time_ < 0 + var_157_9 + arg_157_0 then
				var_157_8.localPosition = Vector3.New(0, 0, 0)
			end

			local var_157_10 = arg_154_1.actors_["1084ui_story"].transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos1084ui_story = var_157_10.localPosition
			end

			local var_157_11 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_11 then
				var_157_10.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_154_1.time_ - 0) / var_157_11)
				var_157_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_10.position).x, (manager.ui.mainCamera.transform.position - var_157_10.position).y, (manager.ui.mainCamera.transform.position - var_157_10.position).z)
				var_157_10.localEulerAngles.z = 0
				var_157_10.localEulerAngles.x = 0
				var_157_10.localEulerAngles = var_157_10.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_11 and arg_154_1.time_ < 0 + var_157_11 + arg_157_0 then
				var_157_10.localPosition = Vector3.New(0, 100, 0)
				var_157_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_10.position).x, (manager.ui.mainCamera.transform.position - var_157_10.position).y, (manager.ui.mainCamera.transform.position - var_157_10.position).z)
				var_157_10.localEulerAngles.z = 0
				var_157_10.localEulerAngles.x = 0
				var_157_10.localEulerAngles = var_157_10.localEulerAngles
			end

			if arg_154_1.frameCnt_ <= 1 then
				arg_154_1.dialog_:SetActive(false)
			end

			local var_157_12 = 2
			local var_157_13 = 0.925

			if 2 < arg_154_1.time_ and arg_154_1.time_ <= var_157_12 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0

				arg_154_1.dialog_:SetActive(true)

				arg_154_1.dialogCg_.alpha = 0

				local var_157_14 = LeanTween.value(arg_154_1.dialog_, 0, 1, 0.3)

				var_157_14:setOnUpdate(LuaHelper.FloatAction(function(arg_158_0)
					arg_154_1.dialogCg_.alpha = arg_158_0
				end))
				var_157_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_154_1.dialog_)
					var_157_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_154_1.duration_ = arg_154_1.duration_ + 0.3

				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_15 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(116091036).content)

				arg_154_1.text_.text = var_157_15

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_17 = 37 <= 0 and var_157_13 or var_157_13 * (utf8.len(var_157_15) / 37)

				if (37 <= 0 and var_157_13 or var_157_13 * (utf8.len(var_157_15) / 37)) > 0 and var_157_13 < var_157_17 then
					arg_154_1.talkMaxDuration = var_157_17
					var_157_12 = var_157_12 + 0.3

					if var_157_17 + var_157_12 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_17 + var_157_12
					end
				end

				arg_154_1.text_.text = var_157_15
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_18 = var_157_12 + 0.3
			local var_157_19 = math.max(var_157_13, arg_154_1.talkMaxDuration)

			if var_157_12 + 0.3 <= arg_154_1.time_ and arg_154_1.time_ < var_157_18 + var_157_19 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_18) / var_157_19

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_18 + var_157_19 and arg_154_1.time_ < var_157_18 + var_157_19 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "STwhite",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play116091037 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 116091037
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play116091038(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0.875

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_1 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(116091037).content)

				arg_160_1.text_.text = var_163_1

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_3 = 35 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_1) / 35)

				if (35 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_1) / 35)) > 0 and var_163_0 < var_163_3 then
					arg_160_1.talkMaxDuration = var_163_3

					if var_163_3 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_3 + 0
					end
				end

				arg_160_1.text_.text = var_163_1
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_4 = math.max(var_163_0, arg_160_1.talkMaxDuration)

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_4 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - 0) / var_163_4

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= 0 + var_163_4 and arg_160_1.time_ < 0 + var_163_4 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play116091038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 116091038
		arg_164_1.duration_ = 6.53

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play116091039(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if arg_164_1.bgs_.SK0103 == nil then
				local var_167_0 = Object.Instantiate(arg_164_1.paintGo_)

				var_167_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0103")
				var_167_0.name = "SK0103"
				var_167_0.transform.parent = arg_164_1.stage_.transform
				var_167_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_164_1.bgs_.SK0103 = var_167_0
			end

			if 1 < arg_164_1.time_ and arg_164_1.time_ <= 1 + arg_167_0 then
				local var_167_1 = arg_164_1.bgs_.SK0103

				arg_164_1.bgs_.SK0103.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_167_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_167_2 = var_167_1:GetComponent("SpriteRenderer")

				if var_167_2 and var_167_2.sprite then
					local var_167_3 = 2 * (var_167_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_167_1.transform.localScale = Vector3.New(var_167_3 / var_167_2.sprite.bounds.size.y < var_167_3 * manager.ui.mainCameraCom_.aspect / var_167_2.sprite.bounds.size.x and var_167_3 * manager.ui.mainCameraCom_.aspect / var_167_2.sprite.bounds.size.x or var_167_3 / var_167_2.sprite.bounds.size.y, var_167_3 / var_167_2.sprite.bounds.size.y < var_167_3 * manager.ui.mainCameraCom_.aspect / var_167_2.sprite.bounds.size.x and var_167_3 * manager.ui.mainCameraCom_.aspect / var_167_2.sprite.bounds.size.x or var_167_3 / var_167_2.sprite.bounds.size.y, 0)
				end

				for iter_167_0, iter_167_1 in pairs(arg_164_1.bgs_) do
					if iter_167_0 ~= "SK0103" then
						iter_167_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_167_4 = 0

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_4 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = false

				arg_164_1:SetGaussion(false)
			end

			local var_167_5 = 1

			if var_167_4 <= arg_164_1.time_ and arg_164_1.time_ < var_167_4 + var_167_5 then
				local var_167_6 = Color.New(1, 1, 1)

				var_167_6.a = Mathf.Lerp(0, 1, (arg_164_1.time_ - var_167_4) / var_167_5)
				arg_164_1.mask_.color = var_167_6
			end

			if arg_164_1.time_ >= var_167_4 + var_167_5 and arg_164_1.time_ < var_167_4 + var_167_5 + arg_167_0 then
				local var_167_7 = Color.New(1, 1, 1)

				var_167_7.a = 1
				arg_164_1.mask_.color = var_167_7
			end

			local var_167_8 = 1

			if 1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_8 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = false

				arg_164_1:SetGaussion(false)
			end

			local var_167_9 = 1

			if var_167_8 <= arg_164_1.time_ and arg_164_1.time_ < var_167_8 + var_167_9 then
				local var_167_10 = Color.New(1, 1, 1)

				var_167_10.a = Mathf.Lerp(1, 0, (arg_164_1.time_ - var_167_8) / var_167_9)
				arg_164_1.mask_.color = var_167_10
			end

			if arg_164_1.time_ >= var_167_8 + var_167_9 and arg_164_1.time_ < var_167_8 + var_167_9 + arg_167_0 then
				local var_167_11 = Color.New(1, 1, 1)

				arg_164_1.mask_.enabled = false
				var_167_11.a = 0
				arg_164_1.mask_.color = var_167_11
			end

			local var_167_12 = arg_164_1.actors_["1084ui_story"].transform

			if 1 < arg_164_1.time_ and arg_164_1.time_ <= 1 + arg_167_0 then
				arg_164_1.var_.moveOldPos1084ui_story = var_167_12.localPosition
			end

			local var_167_13 = 0.001

			if 1 <= arg_164_1.time_ and arg_164_1.time_ < 1 + var_167_13 then
				var_167_12.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_164_1.time_ - 1) / var_167_13)
				var_167_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_12.position).x, (manager.ui.mainCamera.transform.position - var_167_12.position).y, (manager.ui.mainCamera.transform.position - var_167_12.position).z)
				var_167_12.localEulerAngles.z = 0
				var_167_12.localEulerAngles.x = 0
				var_167_12.localEulerAngles = var_167_12.localEulerAngles
			end

			if arg_164_1.time_ >= 1 + var_167_13 and arg_164_1.time_ < 1 + var_167_13 + arg_167_0 then
				var_167_12.localPosition = Vector3.New(0, 100, 0)
				var_167_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_167_12.position).x, (manager.ui.mainCamera.transform.position - var_167_12.position).y, (manager.ui.mainCamera.transform.position - var_167_12.position).z)
				var_167_12.localEulerAngles.z = 0
				var_167_12.localEulerAngles.x = 0
				var_167_12.localEulerAngles = var_167_12.localEulerAngles
			end

			local var_167_14 = arg_164_1.bgs_.SK0103.transform

			if 1 < arg_164_1.time_ and arg_164_1.time_ <= 1 + arg_167_0 then
				arg_164_1.var_.moveOldPosSK0103 = var_167_14.localPosition
			end

			local var_167_15 = 0.001

			if 1 <= arg_164_1.time_ and arg_164_1.time_ < 1 + var_167_15 then
				var_167_14.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPosSK0103, Vector3.New(1.5, 0.5, 4.2), (arg_164_1.time_ - 1) / var_167_15)
			end

			if arg_164_1.time_ >= 1 + var_167_15 and arg_164_1.time_ < 1 + var_167_15 + arg_167_0 then
				var_167_14.localPosition = Vector3.New(1.5, 0.5, 4.2)
			end

			local var_167_16 = arg_164_1.bgs_.SK0103.transform

			if 1.034 < arg_164_1.time_ and arg_164_1.time_ <= 1.034 + arg_167_0 then
				arg_164_1.var_.moveOldPosSK0103 = var_167_16.localPosition
			end

			local var_167_17 = 5.5

			if 1.034 <= arg_164_1.time_ and arg_164_1.time_ < 1.034 + var_167_17 then
				var_167_16.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPosSK0103, Vector3.New(1.5, 0, 5.5), (arg_164_1.time_ - 1.034) / var_167_17)
			end

			if arg_164_1.time_ >= 1.034 + var_167_17 and arg_164_1.time_ < 1.034 + var_167_17 + arg_167_0 then
				var_167_16.localPosition = Vector3.New(1.5, 0, 5.5)
			end

			local var_167_18 = 2

			if 2 < arg_164_1.time_ and arg_164_1.time_ <= var_167_18 + arg_167_0 then
				arg_164_1.allBtn_.enabled = false
			end

			if arg_164_1.time_ >= var_167_18 + 4.534 and arg_164_1.time_ < var_167_18 + 4.534 + arg_167_0 then
				arg_164_1.allBtn_.enabled = true
			end

			if arg_164_1.frameCnt_ <= 1 then
				arg_164_1.dialog_:SetActive(false)
			end

			local var_167_19 = 2
			local var_167_20 = 0.15

			if 2 < arg_164_1.time_ and arg_164_1.time_ <= var_167_19 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0

				arg_164_1.dialog_:SetActive(true)

				arg_164_1.dialogCg_.alpha = 0

				local var_167_21 = LeanTween.value(arg_164_1.dialog_, 0, 1, 0.3)

				var_167_21:setOnUpdate(LuaHelper.FloatAction(function(arg_168_0)
					arg_164_1.dialogCg_.alpha = arg_168_0
				end))
				var_167_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_164_1.dialog_)
					var_167_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_164_1.duration_ = arg_164_1.duration_ + 0.3

				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_22 = arg_164_1:GetWordFromCfg(116091038)
				local var_167_23 = arg_164_1:FormatText(var_167_22.content)

				arg_164_1.text_.text = var_167_23

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_25 = 6 <= 0 and var_167_20 or var_167_20 * (utf8.len(var_167_23) / 6)

				if (6 <= 0 and var_167_20 or var_167_20 * (utf8.len(var_167_23) / 6)) > 0 and var_167_20 < var_167_25 then
					arg_164_1.talkMaxDuration = var_167_25
					var_167_19 = var_167_19 + 0.3

					if var_167_25 + var_167_19 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_25 + var_167_19
					end
				end

				arg_164_1.text_.text = var_167_23
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091038", "story_v_out_116091.awb") ~= 0 then
					local var_167_26 = manager.audio:GetVoiceLength("story_v_out_116091", "116091038", "story_v_out_116091.awb") / 1000

					if var_167_26 + var_167_19 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_26 + var_167_19
					end

					if var_167_22.prefab_name ~= "" and arg_164_1.actors_[var_167_22.prefab_name] ~= nil then
						local var_167_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_22.prefab_name].transform, "story_v_out_116091", "116091038", "story_v_out_116091.awb")

						arg_164_1:RecordAudio("116091038", var_167_27)
						arg_164_1:RecordAudio("116091038", var_167_27)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_116091", "116091038", "story_v_out_116091.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_116091", "116091038", "story_v_out_116091.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_28 = var_167_19 + 0.3
			local var_167_29 = math.max(var_167_20, arg_164_1.talkMaxDuration)

			if var_167_19 + 0.3 <= arg_164_1.time_ and arg_164_1.time_ < var_167_28 + var_167_29 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_28) / var_167_29

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_28 + var_167_29 and arg_164_1.time_ < var_167_28 + var_167_29 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "SK0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SK0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5.5,
				className = "StoryMoveNode",
				startTime = 1.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play116091039 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 116091039
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play116091040(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = 0.775

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_1 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(116091039).content)

				arg_170_1.text_.text = var_173_1

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_3 = 31 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_1) / 31)

				if (31 <= 0 and var_173_0 or var_173_0 * (utf8.len(var_173_1) / 31)) > 0 and var_173_0 < var_173_3 then
					arg_170_1.talkMaxDuration = var_173_3

					if var_173_3 + 0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_3 + 0
					end
				end

				arg_170_1.text_.text = var_173_1
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_4 = math.max(var_173_0, arg_170_1.talkMaxDuration)

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_4 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - 0) / var_173_4

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= 0 + var_173_4 and arg_170_1.time_ < 0 + var_173_4 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play116091040 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 116091040
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play116091041(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 1.325

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_1 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(116091040).content)

				arg_174_1.text_.text = var_177_1

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_3 = 53 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_1) / 53)

				if (53 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_1) / 53)) > 0 and var_177_0 < var_177_3 then
					arg_174_1.talkMaxDuration = var_177_3

					if var_177_3 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_3 + 0
					end
				end

				arg_174_1.text_.text = var_177_1
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_4 = math.max(var_177_0, arg_174_1.talkMaxDuration)

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_4 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - 0) / var_177_4

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= 0 + var_177_4 and arg_174_1.time_ < 0 + var_177_4 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play116091041 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 116091041
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play116091042(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 1.1

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

				local var_181_1 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(116091041).content)

				arg_178_1.text_.text = var_181_1

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_3 = 44 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 44)

				if (44 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_1) / 44)) > 0 and var_181_0 < var_181_3 then
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
	Play116091042 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 116091042
		arg_182_1.duration_ = 6.77

		local var_182_0 = {
			zh = 6.766,
			ja = 6.566
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
				arg_182_0:Play116091043(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.mask_.enabled = true
				arg_182_1.mask_.raycastTarget = true

				arg_182_1:SetGaussion(false)
			end

			local var_185_0 = 2

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 then
				local var_185_1 = Color.New(0, 0, 0)

				var_185_1.a = Mathf.Lerp(0, 1, (arg_182_1.time_ - 0) / var_185_0)
				arg_182_1.mask_.color = var_185_1
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 then
				local var_185_2 = Color.New(0, 0, 0)

				var_185_2.a = 1
				arg_182_1.mask_.color = var_185_2
			end

			local var_185_3 = 2

			if 2 < arg_182_1.time_ and arg_182_1.time_ <= var_185_3 + arg_185_0 then
				arg_182_1.mask_.enabled = true
				arg_182_1.mask_.raycastTarget = true

				arg_182_1:SetGaussion(false)
			end

			local var_185_4 = 2

			if var_185_3 <= arg_182_1.time_ and arg_182_1.time_ < var_185_3 + var_185_4 then
				local var_185_5 = Color.New(0, 0, 0)

				var_185_5.a = Mathf.Lerp(1, 0, (arg_182_1.time_ - var_185_3) / var_185_4)
				arg_182_1.mask_.color = var_185_5
			end

			if arg_182_1.time_ >= var_185_3 + var_185_4 and arg_182_1.time_ < var_185_3 + var_185_4 + arg_185_0 then
				local var_185_6 = Color.New(0, 0, 0)

				arg_182_1.mask_.enabled = false
				var_185_6.a = 0
				arg_182_1.mask_.color = var_185_6
			end

			local var_185_7 = arg_182_1.bgs_.SK0103.transform

			if 2 < arg_182_1.time_ and arg_182_1.time_ <= 2 + arg_185_0 then
				arg_182_1.var_.moveOldPosSK0103 = var_185_7.localPosition
			end

			local var_185_8 = 0.001

			if 2 <= arg_182_1.time_ and arg_182_1.time_ < 2 + var_185_8 then
				var_185_7.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPosSK0103, Vector3.New(0, 1, 9.5), (arg_182_1.time_ - 2) / var_185_8)
			end

			if arg_182_1.time_ >= 2 + var_185_8 and arg_182_1.time_ < 2 + var_185_8 + arg_185_0 then
				var_185_7.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_185_9 = arg_182_1.bgs_.SK0103.transform

			if 2.034 < arg_182_1.time_ and arg_182_1.time_ <= 2.034 + arg_185_0 then
				arg_182_1.var_.moveOldPosSK0103 = var_185_9.localPosition
			end

			local var_185_10 = 3.5

			if 2.034 <= arg_182_1.time_ and arg_182_1.time_ < 2.034 + var_185_10 then
				var_185_9.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPosSK0103, Vector3.New(0, 1, 10), (arg_182_1.time_ - 2.034) / var_185_10)
			end

			if arg_182_1.time_ >= 2.034 + var_185_10 and arg_182_1.time_ < 2.034 + var_185_10 + arg_185_0 then
				var_185_9.localPosition = Vector3.New(0, 1, 10)
			end

			local var_185_11 = 4

			if 4 < arg_182_1.time_ and arg_182_1.time_ <= var_185_11 + arg_185_0 then
				arg_182_1.allBtn_.enabled = false
			end

			if arg_182_1.time_ >= var_185_11 + 1.534 and arg_182_1.time_ < var_185_11 + 1.534 + arg_185_0 then
				arg_182_1.allBtn_.enabled = true
			end

			if arg_182_1.frameCnt_ <= 1 then
				arg_182_1.dialog_:SetActive(false)
			end

			local var_185_12 = 4
			local var_185_13 = 0.1

			if 4 < arg_182_1.time_ and arg_182_1.time_ <= var_185_12 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0

				arg_182_1.dialog_:SetActive(true)

				arg_182_1.dialogCg_.alpha = 0

				local var_185_14 = LeanTween.value(arg_182_1.dialog_, 0, 1, 0.3)

				var_185_14:setOnUpdate(LuaHelper.FloatAction(function(arg_186_0)
					arg_182_1.dialogCg_.alpha = arg_186_0
				end))
				var_185_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_182_1.dialog_)
					var_185_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_182_1.duration_ = arg_182_1.duration_ + 0.3

				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_15 = arg_182_1:GetWordFromCfg(116091042)
				local var_185_16 = arg_182_1:FormatText(var_185_15.content)

				arg_182_1.text_.text = var_185_16

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_18 = 4 <= 0 and var_185_13 or var_185_13 * (utf8.len(var_185_16) / 4)

				if (4 <= 0 and var_185_13 or var_185_13 * (utf8.len(var_185_16) / 4)) > 0 and var_185_13 < var_185_18 then
					arg_182_1.talkMaxDuration = var_185_18
					var_185_12 = var_185_12 + 0.3

					if var_185_18 + var_185_12 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_18 + var_185_12
					end
				end

				arg_182_1.text_.text = var_185_16
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091042", "story_v_out_116091.awb") ~= 0 then
					local var_185_19 = manager.audio:GetVoiceLength("story_v_out_116091", "116091042", "story_v_out_116091.awb") / 1000

					if var_185_19 + var_185_12 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_19 + var_185_12
					end

					if var_185_15.prefab_name ~= "" and arg_182_1.actors_[var_185_15.prefab_name] ~= nil then
						local var_185_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_15.prefab_name].transform, "story_v_out_116091", "116091042", "story_v_out_116091.awb")

						arg_182_1:RecordAudio("116091042", var_185_20)
						arg_182_1:RecordAudio("116091042", var_185_20)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_116091", "116091042", "story_v_out_116091.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_116091", "116091042", "story_v_out_116091.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_21 = var_185_12 + 0.3
			local var_185_22 = math.max(var_185_13, arg_182_1.talkMaxDuration)

			if var_185_12 + 0.3 <= arg_182_1.time_ and arg_182_1.time_ < var_185_21 + var_185_22 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_21) / var_185_22

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_21 + var_185_22 and arg_182_1.time_ < var_185_21 + var_185_22 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SK0103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_182_1:InitPlayNodeList()
	end,
	Play116091043 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 116091043
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play116091044(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 0.875

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_1 = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(116091043).content)

				arg_188_1.text_.text = var_191_1

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_3 = 35 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_1) / 35)

				if (35 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_1) / 35)) > 0 and var_191_0 < var_191_3 then
					arg_188_1.talkMaxDuration = var_191_3

					if var_191_3 + 0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_3 + 0
					end
				end

				arg_188_1.text_.text = var_191_1
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_4 = math.max(var_191_0, arg_188_1.talkMaxDuration)

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_4 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - 0) / var_191_4

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= 0 + var_191_4 and arg_188_1.time_ < 0 + var_191_4 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play116091044 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 116091044
		arg_192_1.duration_ = 4.3

		local var_192_0 = {
			zh = 2.433,
			ja = 4.3
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play116091045(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0.125

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_1 = arg_192_1:GetWordFromCfg(116091044)
				local var_195_2 = arg_192_1:FormatText(var_195_1.content)

				arg_192_1.text_.text = var_195_2

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_4 = 5 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_2) / 5)

				if (5 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_2) / 5)) > 0 and var_195_0 < var_195_4 then
					arg_192_1.talkMaxDuration = var_195_4

					if var_195_4 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_4 + 0
					end
				end

				arg_192_1.text_.text = var_195_2
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091044", "story_v_out_116091.awb") ~= 0 then
					local var_195_5 = manager.audio:GetVoiceLength("story_v_out_116091", "116091044", "story_v_out_116091.awb") / 1000

					if var_195_5 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_5 + 0
					end

					if var_195_1.prefab_name ~= "" and arg_192_1.actors_[var_195_1.prefab_name] ~= nil then
						local var_195_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_1.prefab_name].transform, "story_v_out_116091", "116091044", "story_v_out_116091.awb")

						arg_192_1:RecordAudio("116091044", var_195_6)
						arg_192_1:RecordAudio("116091044", var_195_6)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_116091", "116091044", "story_v_out_116091.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_116091", "116091044", "story_v_out_116091.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_7 = math.max(var_195_0, arg_192_1.talkMaxDuration)

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_7 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - 0) / var_195_7

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= 0 + var_195_7 and arg_192_1.time_ < 0 + var_195_7 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play116091045 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 116091045
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play116091046(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0.675

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_1 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(116091045).content)

				arg_196_1.text_.text = var_199_1

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_3 = 27 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_1) / 27)

				if (27 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_1) / 27)) > 0 and var_199_0 < var_199_3 then
					arg_196_1.talkMaxDuration = var_199_3

					if var_199_3 + 0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_3 + 0
					end
				end

				arg_196_1.text_.text = var_199_1
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_4 = math.max(var_199_0, arg_196_1.talkMaxDuration)

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_4 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - 0) / var_199_4

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= 0 + var_199_4 and arg_196_1.time_ < 0 + var_199_4 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play116091046 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 116091046
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play116091047(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 1.1

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_1 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(116091046).content)

				arg_200_1.text_.text = var_203_1

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_3 = 44 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_1) / 44)

				if (44 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_1) / 44)) > 0 and var_203_0 < var_203_3 then
					arg_200_1.talkMaxDuration = var_203_3

					if var_203_3 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_3 + 0
					end
				end

				arg_200_1.text_.text = var_203_1
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_4 = math.max(var_203_0, arg_200_1.talkMaxDuration)

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_4 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - 0) / var_203_4

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= 0 + var_203_4 and arg_200_1.time_ < 0 + var_203_4 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play116091047 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 116091047
		arg_204_1.duration_ = 2.9

		local var_204_0 = {
			zh = 2.9,
			ja = 1.6
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play116091048(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0.275

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_1 = arg_204_1:GetWordFromCfg(116091047)
				local var_207_2 = arg_204_1:FormatText(var_207_1.content)

				arg_204_1.text_.text = var_207_2

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_4 = 11 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 11)

				if (11 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 11)) > 0 and var_207_0 < var_207_4 then
					arg_204_1.talkMaxDuration = var_207_4

					if var_207_4 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_4 + 0
					end
				end

				arg_204_1.text_.text = var_207_2
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091047", "story_v_out_116091.awb") ~= 0 then
					local var_207_5 = manager.audio:GetVoiceLength("story_v_out_116091", "116091047", "story_v_out_116091.awb") / 1000

					if var_207_5 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_5 + 0
					end

					if var_207_1.prefab_name ~= "" and arg_204_1.actors_[var_207_1.prefab_name] ~= nil then
						local var_207_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_1.prefab_name].transform, "story_v_out_116091", "116091047", "story_v_out_116091.awb")

						arg_204_1:RecordAudio("116091047", var_207_6)
						arg_204_1:RecordAudio("116091047", var_207_6)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_116091", "116091047", "story_v_out_116091.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_116091", "116091047", "story_v_out_116091.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_7 = math.max(var_207_0, arg_204_1.talkMaxDuration)

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_7 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - 0) / var_207_7

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= 0 + var_207_7 and arg_204_1.time_ < 0 + var_207_7 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play116091048 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 116091048
		arg_208_1.duration_ = 4.27

		local var_208_0 = {
			zh = 4.266,
			ja = 2.466
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play116091049(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0.3

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_4")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_1 = arg_208_1:GetWordFromCfg(116091048)
				local var_211_2 = arg_208_1:FormatText(var_211_1.content)

				arg_208_1.text_.text = var_211_2

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_4 = 12 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_2) / 12)

				if (12 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_2) / 12)) > 0 and var_211_0 < var_211_4 then
					arg_208_1.talkMaxDuration = var_211_4

					if var_211_4 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_4 + 0
					end
				end

				arg_208_1.text_.text = var_211_2
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091048", "story_v_out_116091.awb") ~= 0 then
					local var_211_5 = manager.audio:GetVoiceLength("story_v_out_116091", "116091048", "story_v_out_116091.awb") / 1000

					if var_211_5 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_5 + 0
					end

					if var_211_1.prefab_name ~= "" and arg_208_1.actors_[var_211_1.prefab_name] ~= nil then
						local var_211_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_1.prefab_name].transform, "story_v_out_116091", "116091048", "story_v_out_116091.awb")

						arg_208_1:RecordAudio("116091048", var_211_6)
						arg_208_1:RecordAudio("116091048", var_211_6)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_116091", "116091048", "story_v_out_116091.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_116091", "116091048", "story_v_out_116091.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_7 = math.max(var_211_0, arg_208_1.talkMaxDuration)

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_7 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - 0) / var_211_7

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= 0 + var_211_7 and arg_208_1.time_ < 0 + var_211_7 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play116091049 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 116091049
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play116091050(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0.7

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, false)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_1 = arg_212_1:FormatText(arg_212_1:GetWordFromCfg(116091049).content)

				arg_212_1.text_.text = var_215_1

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_3 = 28 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_1) / 28)

				if (28 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_1) / 28)) > 0 and var_215_0 < var_215_3 then
					arg_212_1.talkMaxDuration = var_215_3

					if var_215_3 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_3 + 0
					end
				end

				arg_212_1.text_.text = var_215_1
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_4 = math.max(var_215_0, arg_212_1.talkMaxDuration)

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_4 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - 0) / var_215_4

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= 0 + var_215_4 and arg_212_1.time_ < 0 + var_215_4 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play116091050 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 116091050
		arg_216_1.duration_ = 5.1

		local var_216_0 = {
			zh = 4.2,
			ja = 5.1
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play116091051(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 0.5

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_1 = arg_216_1:GetWordFromCfg(116091050)
				local var_219_2 = arg_216_1:FormatText(var_219_1.content)

				arg_216_1.text_.text = var_219_2

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_4 = 20 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_2) / 20)

				if (20 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_2) / 20)) > 0 and var_219_0 < var_219_4 then
					arg_216_1.talkMaxDuration = var_219_4

					if var_219_4 + 0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_4 + 0
					end
				end

				arg_216_1.text_.text = var_219_2
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091050", "story_v_out_116091.awb") ~= 0 then
					local var_219_5 = manager.audio:GetVoiceLength("story_v_out_116091", "116091050", "story_v_out_116091.awb") / 1000

					if var_219_5 + 0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_5 + 0
					end

					if var_219_1.prefab_name ~= "" and arg_216_1.actors_[var_219_1.prefab_name] ~= nil then
						local var_219_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_1.prefab_name].transform, "story_v_out_116091", "116091050", "story_v_out_116091.awb")

						arg_216_1:RecordAudio("116091050", var_219_6)
						arg_216_1:RecordAudio("116091050", var_219_6)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_116091", "116091050", "story_v_out_116091.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_116091", "116091050", "story_v_out_116091.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_7 = math.max(var_219_0, arg_216_1.talkMaxDuration)

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_7 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - 0) / var_219_7

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= 0 + var_219_7 and arg_216_1.time_ < 0 + var_219_7 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play116091051 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 116091051
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play116091052(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0.85

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, false)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_1 = arg_220_1:FormatText(arg_220_1:GetWordFromCfg(116091051).content)

				arg_220_1.text_.text = var_223_1

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_3 = 34 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_1) / 34)

				if (34 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_1) / 34)) > 0 and var_223_0 < var_223_3 then
					arg_220_1.talkMaxDuration = var_223_3

					if var_223_3 + 0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_3 + 0
					end
				end

				arg_220_1.text_.text = var_223_1
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_4 = math.max(var_223_0, arg_220_1.talkMaxDuration)

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_4 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - 0) / var_223_4

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= 0 + var_223_4 and arg_220_1.time_ < 0 + var_223_4 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play116091052 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 116091052
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play116091053(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 1.3

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, false)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_1 = arg_224_1:FormatText(arg_224_1:GetWordFromCfg(116091052).content)

				arg_224_1.text_.text = var_227_1

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_3 = 52 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_1) / 52)

				if (52 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_1) / 52)) > 0 and var_227_0 < var_227_3 then
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
	Play116091053 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 116091053
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play116091054(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 0.35

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_1 = arg_228_1:FormatText(arg_228_1:GetWordFromCfg(116091053).content)

				arg_228_1.text_.text = var_231_1

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_3 = 14 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_1) / 14)

				if (14 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_1) / 14)) > 0 and var_231_0 < var_231_3 then
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
	Play116091054 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 116091054
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play116091055(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 1.325

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_1 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(116091054).content)

				arg_232_1.text_.text = var_235_1

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_3 = 53 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_1) / 53)

				if (53 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_1) / 53)) > 0 and var_235_0 < var_235_3 then
					arg_232_1.talkMaxDuration = var_235_3

					if var_235_3 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_3 + 0
					end
				end

				arg_232_1.text_.text = var_235_1
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_4 = math.max(var_235_0, arg_232_1.talkMaxDuration)

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_4 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - 0) / var_235_4

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= 0 + var_235_4 and arg_232_1.time_ < 0 + var_235_4 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play116091055 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 116091055
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play116091056(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0.5

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_1 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(116091055).content)

				arg_236_1.text_.text = var_239_1

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_3 = 20 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_1) / 20)

				if (20 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_1) / 20)) > 0 and var_239_0 < var_239_3 then
					arg_236_1.talkMaxDuration = var_239_3

					if var_239_3 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_3 + 0
					end
				end

				arg_236_1.text_.text = var_239_1
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_4 = math.max(var_239_0, arg_236_1.talkMaxDuration)

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_4 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - 0) / var_239_4

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= 0 + var_239_4 and arg_236_1.time_ < 0 + var_239_4 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play116091056 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 116091056
		arg_240_1.duration_ = 5

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play116091057(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 1.425

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_1 = arg_240_1:FormatText(arg_240_1:GetWordFromCfg(116091056).content)

				arg_240_1.text_.text = var_243_1

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_3 = 57 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 57)

				if (57 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_1) / 57)) > 0 and var_243_0 < var_243_3 then
					arg_240_1.talkMaxDuration = var_243_3

					if var_243_3 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_3 + 0
					end
				end

				arg_240_1.text_.text = var_243_1
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_4 = math.max(var_243_0, arg_240_1.talkMaxDuration)

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_4 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - 0) / var_243_4

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= 0 + var_243_4 and arg_240_1.time_ < 0 + var_243_4 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play116091057 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 116091057
		arg_244_1.duration_ = 4.1

		local var_244_0 = {
			zh = 4.1,
			ja = 3.7
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play116091058(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0.2

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019_split_4")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_1 = arg_244_1:GetWordFromCfg(116091057)
				local var_247_2 = arg_244_1:FormatText(var_247_1.content)

				arg_244_1.text_.text = var_247_2

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_4 = 8 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_2) / 8)

				if (8 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_2) / 8)) > 0 and var_247_0 < var_247_4 then
					arg_244_1.talkMaxDuration = var_247_4

					if var_247_4 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_4 + 0
					end
				end

				arg_244_1.text_.text = var_247_2
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091057", "story_v_out_116091.awb") ~= 0 then
					local var_247_5 = manager.audio:GetVoiceLength("story_v_out_116091", "116091057", "story_v_out_116091.awb") / 1000

					if var_247_5 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_5 + 0
					end

					if var_247_1.prefab_name ~= "" and arg_244_1.actors_[var_247_1.prefab_name] ~= nil then
						local var_247_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_1.prefab_name].transform, "story_v_out_116091", "116091057", "story_v_out_116091.awb")

						arg_244_1:RecordAudio("116091057", var_247_6)
						arg_244_1:RecordAudio("116091057", var_247_6)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_116091", "116091057", "story_v_out_116091.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_116091", "116091057", "story_v_out_116091.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_7 = math.max(var_247_0, arg_244_1.talkMaxDuration)

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_7 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - 0) / var_247_7

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= 0 + var_247_7 and arg_244_1.time_ < 0 + var_247_7 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play116091058 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 116091058
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play116091059(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0.575

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_1 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(116091058).content)

				arg_248_1.text_.text = var_251_1

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_3 = 23 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_1) / 23)

				if (23 <= 0 and var_251_0 or var_251_0 * (utf8.len(var_251_1) / 23)) > 0 and var_251_0 < var_251_3 then
					arg_248_1.talkMaxDuration = var_251_3

					if var_251_3 + 0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_3 + 0
					end
				end

				arg_248_1.text_.text = var_251_1
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_4 = math.max(var_251_0, arg_248_1.talkMaxDuration)

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_4 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - 0) / var_251_4

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= 0 + var_251_4 and arg_248_1.time_ < 0 + var_251_4 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play116091059 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 116091059
		arg_252_1.duration_ = 2.03

		local var_252_0 = {
			zh = 1.3,
			ja = 2.033
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play116091060(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0.1

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, true)
				arg_252_1.iconController_:SetSelectedState("hero")

				arg_252_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_252_1.callingController_:SetSelectedState("normal")

				arg_252_1.keyicon_.color = Color.New(1, 1, 1)
				arg_252_1.icon_.color = Color.New(1, 1, 1)

				local var_255_1 = arg_252_1:GetWordFromCfg(116091059)
				local var_255_2 = arg_252_1:FormatText(var_255_1.content)

				arg_252_1.text_.text = var_255_2

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_4 = 4 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_2) / 4)

				if (4 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_2) / 4)) > 0 and var_255_0 < var_255_4 then
					arg_252_1.talkMaxDuration = var_255_4

					if var_255_4 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_4 + 0
					end
				end

				arg_252_1.text_.text = var_255_2
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091059", "story_v_out_116091.awb") ~= 0 then
					local var_255_5 = manager.audio:GetVoiceLength("story_v_out_116091", "116091059", "story_v_out_116091.awb") / 1000

					if var_255_5 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_5 + 0
					end

					if var_255_1.prefab_name ~= "" and arg_252_1.actors_[var_255_1.prefab_name] ~= nil then
						local var_255_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_1.prefab_name].transform, "story_v_out_116091", "116091059", "story_v_out_116091.awb")

						arg_252_1:RecordAudio("116091059", var_255_6)
						arg_252_1:RecordAudio("116091059", var_255_6)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_116091", "116091059", "story_v_out_116091.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_116091", "116091059", "story_v_out_116091.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_7 = math.max(var_255_0, arg_252_1.talkMaxDuration)

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_7 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - 0) / var_255_7

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= 0 + var_255_7 and arg_252_1.time_ < 0 + var_255_7 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play116091060 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 116091060
		arg_256_1.duration_ = 3.03

		local var_256_0 = {
			zh = 2.7,
			ja = 3.033
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
				arg_256_0:Play116091061(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_259_0 = 0.6

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 then
				local var_259_1, var_259_2 = math.modf((arg_256_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_259_2 * 0.13, var_259_2 * 0.13, var_259_2 * 0.13) + arg_256_1.var_.shakeOldPos
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 then
				manager.ui.mainCamera.transform.localPosition = arg_256_1.var_.shakeOldPos
			end

			local var_259_3 = 0

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_3 + arg_259_0 then
				arg_256_1.allBtn_.enabled = false
			end

			if arg_256_1.time_ >= var_259_3 + 0.6 and arg_256_1.time_ < var_259_3 + 0.6 + arg_259_0 then
				arg_256_1.allBtn_.enabled = true
			end

			local var_259_4 = 0
			local var_259_5 = 0.075

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_4 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, true)
				arg_256_1.iconController_:SetSelectedState("hero")

				arg_256_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_256_1.callingController_:SetSelectedState("normal")

				arg_256_1.keyicon_.color = Color.New(1, 1, 1)
				arg_256_1.icon_.color = Color.New(1, 1, 1)

				local var_259_6 = arg_256_1:GetWordFromCfg(116091060)
				local var_259_7 = arg_256_1:FormatText(var_259_6.content)

				arg_256_1.text_.text = var_259_7

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_9 = 3 <= 0 and var_259_5 or var_259_5 * (utf8.len(var_259_7) / 3)

				if (3 <= 0 and var_259_5 or var_259_5 * (utf8.len(var_259_7) / 3)) > 0 and var_259_5 < var_259_9 then
					arg_256_1.talkMaxDuration = var_259_9

					if var_259_9 + var_259_4 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_9 + var_259_4
					end
				end

				arg_256_1.text_.text = var_259_7
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091060", "story_v_out_116091.awb") ~= 0 then
					local var_259_10 = manager.audio:GetVoiceLength("story_v_out_116091", "116091060", "story_v_out_116091.awb") / 1000

					if var_259_10 + var_259_4 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_10 + var_259_4
					end

					if var_259_6.prefab_name ~= "" and arg_256_1.actors_[var_259_6.prefab_name] ~= nil then
						local var_259_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_6.prefab_name].transform, "story_v_out_116091", "116091060", "story_v_out_116091.awb")

						arg_256_1:RecordAudio("116091060", var_259_11)
						arg_256_1:RecordAudio("116091060", var_259_11)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_116091", "116091060", "story_v_out_116091.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_116091", "116091060", "story_v_out_116091.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_12 = math.max(var_259_5, arg_256_1.talkMaxDuration)

			if var_259_4 <= arg_256_1.time_ and arg_256_1.time_ < var_259_4 + var_259_12 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_4) / var_259_12

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_4 + var_259_12 and arg_256_1.time_ < var_259_4 + var_259_12 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play116091061 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 116091061
		arg_260_1.duration_ = 9

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play116091062(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if arg_260_1.bgs_.A00 == nil then
				local var_263_0 = Object.Instantiate(arg_260_1.paintGo_)

				var_263_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A00")
				var_263_0.name = "A00"
				var_263_0.transform.parent = arg_260_1.stage_.transform
				var_263_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_260_1.bgs_.A00 = var_263_0
			end

			if 2 < arg_260_1.time_ and arg_260_1.time_ <= 2 + arg_263_0 then
				local var_263_1 = arg_260_1.bgs_.A00

				arg_260_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_263_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_263_2 = var_263_1:GetComponent("SpriteRenderer")

				if var_263_2 and var_263_2.sprite then
					local var_263_3 = 2 * (var_263_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_263_1.transform.localScale = Vector3.New(var_263_3 / var_263_2.sprite.bounds.size.y < var_263_3 * manager.ui.mainCameraCom_.aspect / var_263_2.sprite.bounds.size.x and var_263_3 * manager.ui.mainCameraCom_.aspect / var_263_2.sprite.bounds.size.x or var_263_3 / var_263_2.sprite.bounds.size.y, var_263_3 / var_263_2.sprite.bounds.size.y < var_263_3 * manager.ui.mainCameraCom_.aspect / var_263_2.sprite.bounds.size.x and var_263_3 * manager.ui.mainCameraCom_.aspect / var_263_2.sprite.bounds.size.x or var_263_3 / var_263_2.sprite.bounds.size.y, 0)
				end

				for iter_263_0, iter_263_1 in pairs(arg_260_1.bgs_) do
					if iter_263_0 ~= "A00" then
						iter_263_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_263_4 = 0

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_4 + arg_263_0 then
				arg_260_1.mask_.enabled = true
				arg_260_1.mask_.raycastTarget = false

				arg_260_1:SetGaussion(false)
			end

			local var_263_5 = 2

			if var_263_4 <= arg_260_1.time_ and arg_260_1.time_ < var_263_4 + var_263_5 then
				local var_263_6 = Color.New(0, 0, 0)

				var_263_6.a = Mathf.Lerp(0, 1, (arg_260_1.time_ - var_263_4) / var_263_5)
				arg_260_1.mask_.color = var_263_6
			end

			if arg_260_1.time_ >= var_263_4 + var_263_5 and arg_260_1.time_ < var_263_4 + var_263_5 + arg_263_0 then
				local var_263_7 = Color.New(0, 0, 0)

				var_263_7.a = 1
				arg_260_1.mask_.color = var_263_7
			end

			local var_263_8 = 2

			if 2 < arg_260_1.time_ and arg_260_1.time_ <= var_263_8 + arg_263_0 then
				arg_260_1.mask_.enabled = true
				arg_260_1.mask_.raycastTarget = false

				arg_260_1:SetGaussion(false)
			end

			local var_263_9 = 2

			if var_263_8 <= arg_260_1.time_ and arg_260_1.time_ < var_263_8 + var_263_9 then
				local var_263_10 = Color.New(0, 0, 0)

				var_263_10.a = Mathf.Lerp(1, 0, (arg_260_1.time_ - var_263_8) / var_263_9)
				arg_260_1.mask_.color = var_263_10
			end

			if arg_260_1.time_ >= var_263_8 + var_263_9 and arg_260_1.time_ < var_263_8 + var_263_9 + arg_263_0 then
				local var_263_11 = Color.New(0, 0, 0)

				arg_260_1.mask_.enabled = false
				var_263_11.a = 0
				arg_260_1.mask_.color = var_263_11
			end

			if arg_260_1.frameCnt_ <= 1 then
				arg_260_1.dialog_:SetActive(false)
			end

			local var_263_12 = 4
			local var_263_13 = 0.65

			if 4 < arg_260_1.time_ and arg_260_1.time_ <= var_263_12 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0

				arg_260_1.dialog_:SetActive(true)

				arg_260_1.dialogCg_.alpha = 0

				local var_263_14 = LeanTween.value(arg_260_1.dialog_, 0, 1, 0.3)

				var_263_14:setOnUpdate(LuaHelper.FloatAction(function(arg_264_0)
					arg_260_1.dialogCg_.alpha = arg_264_0
				end))
				var_263_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_260_1.dialog_)
					var_263_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_260_1.duration_ = arg_260_1.duration_ + 0.3

				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_15 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(116091061).content)

				arg_260_1.text_.text = var_263_15

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_17 = 26 <= 0 and var_263_13 or var_263_13 * (utf8.len(var_263_15) / 26)

				if (26 <= 0 and var_263_13 or var_263_13 * (utf8.len(var_263_15) / 26)) > 0 and var_263_13 < var_263_17 then
					arg_260_1.talkMaxDuration = var_263_17
					var_263_12 = var_263_12 + 0.3

					if var_263_17 + var_263_12 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_17 + var_263_12
					end
				end

				arg_260_1.text_.text = var_263_15
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_18 = var_263_12 + 0.3
			local var_263_19 = math.max(var_263_13, arg_260_1.talkMaxDuration)

			if var_263_12 + 0.3 <= arg_260_1.time_ and arg_260_1.time_ < var_263_18 + var_263_19 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_18) / var_263_19

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_18 + var_263_19 and arg_260_1.time_ < var_263_18 + var_263_19 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play116091062 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 116091062
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play116091063(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_269_0 = 1

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 then
				local var_269_1, var_269_2 = math.modf((arg_266_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_269_2 * 0.13, var_269_2 * 0.13, var_269_2 * 0.13) + arg_266_1.var_.shakeOldPos
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 then
				manager.ui.mainCamera.transform.localPosition = arg_266_1.var_.shakeOldPos
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:AudioAction("play", "effect", "se_story_16", "se_story_16_fight", "")
			end

			local var_269_4 = 0

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_4 + arg_269_0 then
				arg_266_1.allBtn_.enabled = false
			end

			if arg_266_1.time_ >= var_269_4 + 1 and arg_266_1.time_ < var_269_4 + 1 + arg_269_0 then
				arg_266_1.allBtn_.enabled = true
			end

			local var_269_5 = 0
			local var_269_6 = 1.225

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_5 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_7 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(116091062).content)

				arg_266_1.text_.text = var_269_7

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_9 = 49 <= 0 and var_269_6 or var_269_6 * (utf8.len(var_269_7) / 49)

				if (49 <= 0 and var_269_6 or var_269_6 * (utf8.len(var_269_7) / 49)) > 0 and var_269_6 < var_269_9 then
					arg_266_1.talkMaxDuration = var_269_9

					if var_269_9 + var_269_5 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_9 + var_269_5
					end
				end

				arg_266_1.text_.text = var_269_7
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_10 = math.max(var_269_6, arg_266_1.talkMaxDuration)

			if var_269_5 <= arg_266_1.time_ and arg_266_1.time_ < var_269_5 + var_269_10 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_5) / var_269_10

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_5 + var_269_10 and arg_266_1.time_ < var_269_5 + var_269_10 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play116091063 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 116091063
		arg_270_1.duration_ = 2.7

		local var_270_0 = {
			zh = 2.566,
			ja = 2.7
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play116091064(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1084ui_story = arg_270_1.actors_["1084ui_story"].transform.localPosition

				arg_270_1:ShowWeapon(arg_270_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_273_0 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 then
				arg_270_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_270_1.time_ - 0) / var_273_0)
				arg_270_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_270_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1084ui_story"].transform.position).z)
				arg_270_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_270_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_270_1.actors_["1084ui_story"].transform.localEulerAngles = arg_270_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 then
				arg_270_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_270_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_270_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_270_1.actors_["1084ui_story"].transform.position).z)
				arg_270_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_270_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_270_1.actors_["1084ui_story"].transform.localEulerAngles = arg_270_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_273_1 = arg_270_1.actors_["1084ui_story"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_1) and arg_270_1.var_.characterEffect1084ui_story == nil then
				arg_270_1.var_.characterEffect1084ui_story = var_273_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_2 = 0.2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_2 and not isNil(var_273_1) then
				if arg_270_1.var_.characterEffect1084ui_story and not isNil(var_273_1) then
					arg_270_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= 0 + var_273_2 and arg_270_1.time_ < 0 + var_273_2 + arg_273_0 and not isNil(var_273_1) and arg_270_1.var_.characterEffect1084ui_story then
				arg_270_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_273_4 = 0
			local var_273_5 = 0.275

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_4 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_6 = arg_270_1:GetWordFromCfg(116091063)
				local var_273_7 = arg_270_1:FormatText(var_273_6.content)

				arg_270_1.text_.text = var_273_7

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_9 = 11 <= 0 and var_273_5 or var_273_5 * (utf8.len(var_273_7) / 11)

				if (11 <= 0 and var_273_5 or var_273_5 * (utf8.len(var_273_7) / 11)) > 0 and var_273_5 < var_273_9 then
					arg_270_1.talkMaxDuration = var_273_9

					if var_273_9 + var_273_4 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_9 + var_273_4
					end
				end

				arg_270_1.text_.text = var_273_7
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091063", "story_v_out_116091.awb") ~= 0 then
					local var_273_10 = manager.audio:GetVoiceLength("story_v_out_116091", "116091063", "story_v_out_116091.awb") / 1000

					if var_273_10 + var_273_4 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_10 + var_273_4
					end

					if var_273_6.prefab_name ~= "" and arg_270_1.actors_[var_273_6.prefab_name] ~= nil then
						local var_273_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_6.prefab_name].transform, "story_v_out_116091", "116091063", "story_v_out_116091.awb")

						arg_270_1:RecordAudio("116091063", var_273_11)
						arg_270_1:RecordAudio("116091063", var_273_11)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_116091", "116091063", "story_v_out_116091.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_116091", "116091063", "story_v_out_116091.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_12 = math.max(var_273_5, arg_270_1.talkMaxDuration)

			if var_273_4 <= arg_270_1.time_ and arg_270_1.time_ < var_273_4 + var_273_12 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_4) / var_273_12

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_4 + var_273_12 and arg_270_1.time_ < var_273_4 + var_273_12 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play116091064 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 116091064
		arg_274_1.duration_ = 6.13

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play116091065(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos1084ui_story = arg_274_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_277_0 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 then
				arg_274_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_274_1.time_ - 0) / var_277_0)
				arg_274_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1084ui_story"].transform.position).z)
				arg_274_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["1084ui_story"].transform.localEulerAngles = arg_274_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 then
				arg_274_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_274_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1084ui_story"].transform.position).z)
				arg_274_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["1084ui_story"].transform.localEulerAngles = arg_274_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_277_1 = manager.ui.mainCamera.transform

			if 0.633333333333333 < arg_274_1.time_ and arg_274_1.time_ <= 0.633333333333333 + arg_277_0 then
				arg_274_1.var_.shakeOldPos = var_277_1.localPosition
			end

			local var_277_2 = 0.5

			if 0.633333333333333 <= arg_274_1.time_ and arg_274_1.time_ < 0.633333333333333 + var_277_2 then
				local var_277_3, var_277_4 = math.modf((arg_274_1.time_ - 0.633333333333333) / 0.066)

				var_277_1.localPosition = Vector3.New(var_277_4 * 0.13, var_277_4 * 0.13, var_277_4 * 0.13) + arg_274_1.var_.shakeOldPos
			end

			if arg_274_1.time_ >= 0.633333333333333 + var_277_2 and arg_274_1.time_ < 0.633333333333333 + var_277_2 + arg_277_0 then
				var_277_1.localPosition = arg_274_1.var_.shakeOldPos
			end

			if 0.633333333333333 < arg_274_1.time_ and arg_274_1.time_ <= 0.633333333333333 + arg_277_0 then
				arg_274_1:AudioAction("play", "effect", "se_story_16", "se_story_16_fight02", "")
			end

			local var_277_6 = 0

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_6 + arg_277_0 then
				arg_274_1.mask_.enabled = true
				arg_274_1.mask_.raycastTarget = true

				arg_274_1:SetGaussion(false)
			end

			local var_277_7 = 1

			if var_277_6 <= arg_274_1.time_ and arg_274_1.time_ < var_277_6 + var_277_7 then
				local var_277_8 = Color.New(1, 1, 1)

				var_277_8.a = Mathf.Lerp(1, 0, (arg_274_1.time_ - var_277_6) / var_277_7)
				arg_274_1.mask_.color = var_277_8
			end

			if arg_274_1.time_ >= var_277_6 + var_277_7 and arg_274_1.time_ < var_277_6 + var_277_7 + arg_277_0 then
				local var_277_9 = Color.New(1, 1, 1)

				arg_274_1.mask_.enabled = false
				var_277_9.a = 0
				arg_274_1.mask_.color = var_277_9
			end

			local var_277_10 = 1

			if 1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_10 + arg_277_0 then
				arg_274_1.allBtn_.enabled = false
			end

			if arg_274_1.time_ >= var_277_10 + 0.633333333333333 and arg_274_1.time_ < var_277_10 + 0.633333333333333 + arg_277_0 then
				arg_274_1.allBtn_.enabled = true
			end

			if arg_274_1.frameCnt_ <= 1 then
				arg_274_1.dialog_:SetActive(false)
			end

			local var_277_11 = 1.13333333333333
			local var_277_12 = 1.15

			if 1.13333333333333 < arg_274_1.time_ and arg_274_1.time_ <= var_277_11 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0

				arg_274_1.dialog_:SetActive(true)

				arg_274_1.dialogCg_.alpha = 0

				local var_277_13 = LeanTween.value(arg_274_1.dialog_, 0, 1, 0.3)

				var_277_13:setOnUpdate(LuaHelper.FloatAction(function(arg_278_0)
					arg_274_1.dialogCg_.alpha = arg_278_0
				end))
				var_277_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_274_1.dialog_)
					var_277_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_274_1.duration_ = arg_274_1.duration_ + 0.3

				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_14 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(116091064).content)

				arg_274_1.text_.text = var_277_14

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_16 = 46 <= 0 and var_277_12 or var_277_12 * (utf8.len(var_277_14) / 46)

				if (46 <= 0 and var_277_12 or var_277_12 * (utf8.len(var_277_14) / 46)) > 0 and var_277_12 < var_277_16 then
					arg_274_1.talkMaxDuration = var_277_16
					var_277_11 = var_277_11 + 0.3

					if var_277_16 + var_277_11 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_16 + var_277_11
					end
				end

				arg_274_1.text_.text = var_277_14
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_17 = var_277_11 + 0.3
			local var_277_18 = math.max(var_277_12, arg_274_1.talkMaxDuration)

			if var_277_11 + 0.3 <= arg_274_1.time_ and arg_274_1.time_ < var_277_17 + var_277_18 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_17) / var_277_18

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_17 + var_277_18 and arg_274_1.time_ < var_277_17 + var_277_18 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play116091065 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 116091065
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play116091066(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0.1

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_1 = arg_280_1:FormatText(arg_280_1:GetWordFromCfg(116091065).content)

				arg_280_1.text_.text = var_283_1

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_3 = 4 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_1) / 4)

				if (4 <= 0 and var_283_0 or var_283_0 * (utf8.len(var_283_1) / 4)) > 0 and var_283_0 < var_283_3 then
					arg_280_1.talkMaxDuration = var_283_3

					if var_283_3 + 0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_3 + 0
					end
				end

				arg_280_1.text_.text = var_283_1
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_4 = math.max(var_283_0, arg_280_1.talkMaxDuration)

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_4 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - 0) / var_283_4

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= 0 + var_283_4 and arg_280_1.time_ < 0 + var_283_4 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play116091066 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 116091066
		arg_284_1.duration_ = 6

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play116091067(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_287_0 = 1

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 then
				local var_287_1, var_287_2 = math.modf((arg_284_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_287_2 * 0.13, var_287_2 * 0.13, var_287_2 * 0.13) + arg_284_1.var_.shakeOldPos
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 then
				manager.ui.mainCamera.transform.localPosition = arg_284_1.var_.shakeOldPos
			end

			local var_287_3 = 0

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_3 + arg_287_0 then
				arg_284_1.allBtn_.enabled = false
			end

			if arg_284_1.time_ >= var_287_3 + 1 and arg_284_1.time_ < var_287_3 + 1 + arg_287_0 then
				arg_284_1.allBtn_.enabled = true
			end

			if arg_284_1.frameCnt_ <= 1 then
				arg_284_1.dialog_:SetActive(false)
			end

			local var_287_4 = 1
			local var_287_5 = 1.1

			if 1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_4 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0

				arg_284_1.dialog_:SetActive(true)

				arg_284_1.dialogCg_.alpha = 0

				local var_287_6 = LeanTween.value(arg_284_1.dialog_, 0, 1, 0.3)

				var_287_6:setOnUpdate(LuaHelper.FloatAction(function(arg_288_0)
					arg_284_1.dialogCg_.alpha = arg_288_0
				end))
				var_287_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_284_1.dialog_)
					var_287_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_284_1.duration_ = arg_284_1.duration_ + 0.3

				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_7 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(116091066).content)

				arg_284_1.text_.text = var_287_7

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_9 = 44 <= 0 and var_287_5 or var_287_5 * (utf8.len(var_287_7) / 44)

				if (44 <= 0 and var_287_5 or var_287_5 * (utf8.len(var_287_7) / 44)) > 0 and var_287_5 < var_287_9 then
					arg_284_1.talkMaxDuration = var_287_9
					var_287_4 = var_287_4 + 0.3

					if var_287_9 + var_287_4 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_9 + var_287_4
					end
				end

				arg_284_1.text_.text = var_287_7
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_10 = var_287_4 + 0.3
			local var_287_11 = math.max(var_287_5, arg_284_1.talkMaxDuration)

			if var_287_4 + 0.3 <= arg_284_1.time_ and arg_284_1.time_ < var_287_10 + var_287_11 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_10) / var_287_11

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_10 + var_287_11 and arg_284_1.time_ < var_287_10 + var_287_11 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play116091067 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 116091067
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play116091068(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0.95

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_1 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(116091067).content)

				arg_290_1.text_.text = var_293_1

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_3 = 36 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_1) / 36)

				if (36 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_1) / 36)) > 0 and var_293_0 < var_293_3 then
					arg_290_1.talkMaxDuration = var_293_3

					if var_293_3 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_3 + 0
					end
				end

				arg_290_1.text_.text = var_293_1
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_4 = math.max(var_293_0, arg_290_1.talkMaxDuration)

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_4 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - 0) / var_293_4

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= 0 + var_293_4 and arg_290_1.time_ < 0 + var_293_4 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play116091068 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 116091068
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play116091069(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0.95

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_1 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(116091068).content)

				arg_294_1.text_.text = var_297_1

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_3 = 38 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_1) / 38)

				if (38 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_1) / 38)) > 0 and var_297_0 < var_297_3 then
					arg_294_1.talkMaxDuration = var_297_3

					if var_297_3 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_3 + 0
					end
				end

				arg_294_1.text_.text = var_297_1
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_4 = math.max(var_297_0, arg_294_1.talkMaxDuration)

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_4 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - 0) / var_297_4

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= 0 + var_297_4 and arg_294_1.time_ < 0 + var_297_4 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play116091069 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 116091069
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play116091070(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0.75

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_1 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(116091069).content)

				arg_298_1.text_.text = var_301_1

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_3 = 30 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 30)

				if (30 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 30)) > 0 and var_301_0 < var_301_3 then
					arg_298_1.talkMaxDuration = var_301_3

					if var_301_3 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_3 + 0
					end
				end

				arg_298_1.text_.text = var_301_1
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_4 = math.max(var_301_0, arg_298_1.talkMaxDuration)

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_4 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - 0) / var_301_4

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= 0 + var_301_4 and arg_298_1.time_ < 0 + var_301_4 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play116091070 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 116091070
		arg_302_1.duration_ = 4.5

		local var_302_0 = {
			zh = 4.033,
			ja = 4.5
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play116091071(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if arg_302_1.actors_["1028ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1028ui_story"))) then
				local var_305_0 = Object.Instantiate(Asset.Load("Char/" .. "1028ui_story"), arg_302_1.stage_.transform)

				var_305_0.name = "1028ui_story"
				var_305_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_302_1.actors_["1028ui_story"] = var_305_0

				local var_305_1 = var_305_0:GetComponentInChildren(typeof(CharacterEffect))

				var_305_1.enabled = true

				local var_305_2 = GameObjectTools.GetOrAddComponent(var_305_0, typeof(DynamicBoneHelper))

				if var_305_2 then
					var_305_2:EnableDynamicBone(false)
				end

				arg_302_1:ShowWeapon(var_305_1.transform, false)

				arg_302_1.var_["1028ui_story" .. "Animator"] = var_305_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_302_1.var_["1028ui_story" .. "Animator"].applyRootMotion = true
				arg_302_1.var_["1028ui_story" .. "LipSync"] = var_305_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_305_3 = arg_302_1.actors_["1028ui_story"].transform

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos1028ui_story = var_305_3.localPosition

				arg_302_1:ShowWeapon(arg_302_1.var_["1028ui_story" .. "Animator"].transform, true)
			end

			local var_305_4 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_4 then
				var_305_3.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1028ui_story, Vector3.New(0, -0.9, -5.9), (arg_302_1.time_ - 0) / var_305_4)
				var_305_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_305_3.position).x, (manager.ui.mainCamera.transform.position - var_305_3.position).y, (manager.ui.mainCamera.transform.position - var_305_3.position).z)
				var_305_3.localEulerAngles.z = 0
				var_305_3.localEulerAngles.x = 0
				var_305_3.localEulerAngles = var_305_3.localEulerAngles
			end

			if arg_302_1.time_ >= 0 + var_305_4 and arg_302_1.time_ < 0 + var_305_4 + arg_305_0 then
				var_305_3.localPosition = Vector3.New(0, -0.9, -5.9)
				var_305_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_305_3.position).x, (manager.ui.mainCamera.transform.position - var_305_3.position).y, (manager.ui.mainCamera.transform.position - var_305_3.position).z)
				var_305_3.localEulerAngles.z = 0
				var_305_3.localEulerAngles.x = 0
				var_305_3.localEulerAngles = var_305_3.localEulerAngles
			end

			local var_305_5 = arg_302_1.actors_["1028ui_story"]

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(var_305_5) and arg_302_1.var_.characterEffect1028ui_story == nil then
				arg_302_1.var_.characterEffect1028ui_story = var_305_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_6 = 0.2

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_6 and not isNil(var_305_5) then
				if arg_302_1.var_.characterEffect1028ui_story and not isNil(var_305_5) then
					arg_302_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= 0 + var_305_6 and arg_302_1.time_ < 0 + var_305_6 + arg_305_0 and not isNil(var_305_5) and arg_302_1.var_.characterEffect1028ui_story then
				arg_302_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action2_1")
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_305_8 = 0
			local var_305_9 = 0.275

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_8 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_10 = arg_302_1:GetWordFromCfg(116091070)
				local var_305_11 = arg_302_1:FormatText(var_305_10.content)

				arg_302_1.text_.text = var_305_11

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_13 = 11 <= 0 and var_305_9 or var_305_9 * (utf8.len(var_305_11) / 11)

				if (11 <= 0 and var_305_9 or var_305_9 * (utf8.len(var_305_11) / 11)) > 0 and var_305_9 < var_305_13 then
					arg_302_1.talkMaxDuration = var_305_13

					if var_305_13 + var_305_8 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_13 + var_305_8
					end
				end

				arg_302_1.text_.text = var_305_11
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091070", "story_v_out_116091.awb") ~= 0 then
					local var_305_14 = manager.audio:GetVoiceLength("story_v_out_116091", "116091070", "story_v_out_116091.awb") / 1000

					if var_305_14 + var_305_8 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_14 + var_305_8
					end

					if var_305_10.prefab_name ~= "" and arg_302_1.actors_[var_305_10.prefab_name] ~= nil then
						local var_305_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_10.prefab_name].transform, "story_v_out_116091", "116091070", "story_v_out_116091.awb")

						arg_302_1:RecordAudio("116091070", var_305_15)
						arg_302_1:RecordAudio("116091070", var_305_15)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_116091", "116091070", "story_v_out_116091.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_116091", "116091070", "story_v_out_116091.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_16 = math.max(var_305_9, arg_302_1.talkMaxDuration)

			if var_305_8 <= arg_302_1.time_ and arg_302_1.time_ < var_305_8 + var_305_16 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_8) / var_305_16

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_8 + var_305_16 and arg_302_1.time_ < var_305_8 + var_305_16 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_302_1:InitPlayNodeList()
	end,
	Play116091071 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 116091071
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play116091072(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(arg_306_1.actors_["1028ui_story"]) and arg_306_1.var_.characterEffect1028ui_story == nil then
				arg_306_1.var_.characterEffect1028ui_story = arg_306_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_0 = 0.2

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 and not isNil(arg_306_1.actors_["1028ui_story"]) then
				if arg_306_1.var_.characterEffect1028ui_story and not isNil(arg_306_1.actors_["1028ui_story"]) then
					arg_306_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_306_1.time_ - 0) / var_309_0)
				end
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 and not isNil(arg_306_1.actors_["1028ui_story"]) and arg_306_1.var_.characterEffect1028ui_story then
				arg_306_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_309_1 = 0
			local var_309_2 = 0.15

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_3 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(116091071).content)

				arg_306_1.text_.text = var_309_3

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 6 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 6)

				if (6 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 6)) > 0 and var_309_2 < var_309_5 then
					arg_306_1.talkMaxDuration = var_309_5

					if var_309_5 + var_309_1 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_5 + var_309_1
					end
				end

				arg_306_1.text_.text = var_309_3
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_6 = math.max(var_309_2, arg_306_1.talkMaxDuration)

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_6 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_1) / var_309_6

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_1 + var_309_6 and arg_306_1.time_ < var_309_1 + var_309_6 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play116091072 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 116091072
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play116091073(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.var_.moveOldPos1028ui_story = arg_310_1.actors_["1028ui_story"].transform.localPosition
			end

			local var_313_0 = 0.001

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 then
				arg_310_1.actors_["1028ui_story"].transform.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos1028ui_story, Vector3.New(0, 100, 0), (arg_310_1.time_ - 0) / var_313_0)
				arg_310_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_310_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["1028ui_story"].transform.position).z)
				arg_310_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_310_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_310_1.actors_["1028ui_story"].transform.localEulerAngles = arg_310_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 then
				arg_310_1.actors_["1028ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_310_1.actors_["1028ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_310_1.actors_["1028ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["1028ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_310_1.actors_["1028ui_story"].transform.position).z)
				arg_310_1.actors_["1028ui_story"].transform.localEulerAngles.z = 0
				arg_310_1.actors_["1028ui_story"].transform.localEulerAngles.x = 0
				arg_310_1.actors_["1028ui_story"].transform.localEulerAngles = arg_310_1.actors_["1028ui_story"].transform.localEulerAngles
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:AudioAction("play", "effect", "se_story_16", "se_story_16_door06", "")
			end

			local var_313_2 = 0
			local var_313_3 = 1.375

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_2 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, false)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_4 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(116091072).content)

				arg_310_1.text_.text = var_313_4

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_6 = 55 <= 0 and var_313_3 or var_313_3 * (utf8.len(var_313_4) / 55)

				if (55 <= 0 and var_313_3 or var_313_3 * (utf8.len(var_313_4) / 55)) > 0 and var_313_3 < var_313_6 then
					arg_310_1.talkMaxDuration = var_313_6

					if var_313_6 + var_313_2 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_6 + var_313_2
					end
				end

				arg_310_1.text_.text = var_313_4
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_7 = math.max(var_313_3, arg_310_1.talkMaxDuration)

			if var_313_2 <= arg_310_1.time_ and arg_310_1.time_ < var_313_2 + var_313_7 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_2) / var_313_7

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_2 + var_313_7 and arg_310_1.time_ < var_313_2 + var_313_7 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_310_1:InitPlayNodeList()
	end,
	Play116091073 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 116091073
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play116091074(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 1

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_1 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(116091073).content)

				arg_314_1.text_.text = var_317_1

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_3 = 40 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_1) / 40)

				if (40 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_1) / 40)) > 0 and var_317_0 < var_317_3 then
					arg_314_1.talkMaxDuration = var_317_3

					if var_317_3 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_3 + 0
					end
				end

				arg_314_1.text_.text = var_317_1
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_4 = math.max(var_317_0, arg_314_1.talkMaxDuration)

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_4 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - 0) / var_317_4

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= 0 + var_317_4 and arg_314_1.time_ < 0 + var_317_4 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play116091074 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 116091074
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play116091075(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0.325

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_1 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(116091074).content)

				arg_318_1.text_.text = var_321_1

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_3 = 13 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_1) / 13)

				if (13 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_1) / 13)) > 0 and var_321_0 < var_321_3 then
					arg_318_1.talkMaxDuration = var_321_3

					if var_321_3 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_3 + 0
					end
				end

				arg_318_1.text_.text = var_321_1
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_4 = math.max(var_321_0, arg_318_1.talkMaxDuration)

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_4 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - 0) / var_321_4

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= 0 + var_321_4 and arg_318_1.time_ < 0 + var_321_4 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play116091075 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 116091075
		arg_322_1.duration_ = 6

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play116091076(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_325_0 = 1

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 then
				local var_325_1, var_325_2 = math.modf((arg_322_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_325_2 * 0.13, var_325_2 * 0.13, var_325_2 * 0.13) + arg_322_1.var_.shakeOldPos
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 then
				manager.ui.mainCamera.transform.localPosition = arg_322_1.var_.shakeOldPos
			end

			local var_325_3 = 0

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_3 + arg_325_0 then
				arg_322_1.allBtn_.enabled = false
			end

			if arg_322_1.time_ >= var_325_3 + 1 and arg_322_1.time_ < var_325_3 + 1 + arg_325_0 then
				arg_322_1.allBtn_.enabled = true
			end

			if arg_322_1.frameCnt_ <= 1 then
				arg_322_1.dialog_:SetActive(false)
			end

			local var_325_4 = 1
			local var_325_5 = 0.95

			if 1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_4 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0

				arg_322_1.dialog_:SetActive(true)

				arg_322_1.dialogCg_.alpha = 0

				local var_325_6 = LeanTween.value(arg_322_1.dialog_, 0, 1, 0.3)

				var_325_6:setOnUpdate(LuaHelper.FloatAction(function(arg_326_0)
					arg_322_1.dialogCg_.alpha = arg_326_0
				end))
				var_325_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_322_1.dialog_)
					var_325_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_322_1.duration_ = arg_322_1.duration_ + 0.3

				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_7 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(116091075).content)

				arg_322_1.text_.text = var_325_7

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_9 = 38 <= 0 and var_325_5 or var_325_5 * (utf8.len(var_325_7) / 38)

				if (38 <= 0 and var_325_5 or var_325_5 * (utf8.len(var_325_7) / 38)) > 0 and var_325_5 < var_325_9 then
					arg_322_1.talkMaxDuration = var_325_9
					var_325_4 = var_325_4 + 0.3

					if var_325_9 + var_325_4 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_9 + var_325_4
					end
				end

				arg_322_1.text_.text = var_325_7
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_10 = var_325_4 + 0.3
			local var_325_11 = math.max(var_325_5, arg_322_1.talkMaxDuration)

			if var_325_4 + 0.3 <= arg_322_1.time_ and arg_322_1.time_ < var_325_10 + var_325_11 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_10) / var_325_11

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_10 + var_325_11 and arg_322_1.time_ < var_325_10 + var_325_11 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play116091076 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 116091076
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play116091077(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 1.15

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, false)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_1 = arg_328_1:FormatText(arg_328_1:GetWordFromCfg(116091076).content)

				arg_328_1.text_.text = var_331_1

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_3 = 46 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_1) / 46)

				if (46 <= 0 and var_331_0 or var_331_0 * (utf8.len(var_331_1) / 46)) > 0 and var_331_0 < var_331_3 then
					arg_328_1.talkMaxDuration = var_331_3

					if var_331_3 + 0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_3 + 0
					end
				end

				arg_328_1.text_.text = var_331_1
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_4 = math.max(var_331_0, arg_328_1.talkMaxDuration)

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_4 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - 0) / var_331_4

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= 0 + var_331_4 and arg_328_1.time_ < 0 + var_331_4 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play116091077 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 116091077
		arg_332_1.duration_ = 2

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play116091078(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.var_.moveOldPos1084ui_story = arg_332_1.actors_["1084ui_story"].transform.localPosition

				arg_332_1:ShowWeapon(arg_332_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_335_0 = 0.001

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_0 then
				arg_332_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_332_1.time_ - 0) / var_335_0)
				arg_332_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_332_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["1084ui_story"].transform.position).z)
				arg_332_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_332_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_332_1.actors_["1084ui_story"].transform.localEulerAngles = arg_332_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_332_1.time_ >= 0 + var_335_0 and arg_332_1.time_ < 0 + var_335_0 + arg_335_0 then
				arg_332_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_332_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_332_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_332_1.actors_["1084ui_story"].transform.position).z)
				arg_332_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_332_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_332_1.actors_["1084ui_story"].transform.localEulerAngles = arg_332_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_335_1 = arg_332_1.actors_["1084ui_story"]

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(var_335_1) and arg_332_1.var_.characterEffect1084ui_story == nil then
				arg_332_1.var_.characterEffect1084ui_story = var_335_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_2 = 0.2

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_2 and not isNil(var_335_1) then
				if arg_332_1.var_.characterEffect1084ui_story and not isNil(var_335_1) then
					arg_332_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= 0 + var_335_2 and arg_332_1.time_ < 0 + var_335_2 + arg_335_0 and not isNil(var_335_1) and arg_332_1.var_.characterEffect1084ui_story then
				arg_332_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_335_4 = 0
			local var_335_5 = 0.175

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_4 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_6 = arg_332_1:GetWordFromCfg(116091077)
				local var_335_7 = arg_332_1:FormatText(var_335_6.content)

				arg_332_1.text_.text = var_335_7

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_9 = 7 <= 0 and var_335_5 or var_335_5 * (utf8.len(var_335_7) / 7)

				if (7 <= 0 and var_335_5 or var_335_5 * (utf8.len(var_335_7) / 7)) > 0 and var_335_5 < var_335_9 then
					arg_332_1.talkMaxDuration = var_335_9

					if var_335_9 + var_335_4 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_9 + var_335_4
					end
				end

				arg_332_1.text_.text = var_335_7
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091077", "story_v_out_116091.awb") ~= 0 then
					local var_335_10 = manager.audio:GetVoiceLength("story_v_out_116091", "116091077", "story_v_out_116091.awb") / 1000

					if var_335_10 + var_335_4 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_10 + var_335_4
					end

					if var_335_6.prefab_name ~= "" and arg_332_1.actors_[var_335_6.prefab_name] ~= nil then
						local var_335_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_6.prefab_name].transform, "story_v_out_116091", "116091077", "story_v_out_116091.awb")

						arg_332_1:RecordAudio("116091077", var_335_11)
						arg_332_1:RecordAudio("116091077", var_335_11)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_116091", "116091077", "story_v_out_116091.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_116091", "116091077", "story_v_out_116091.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_12 = math.max(var_335_5, arg_332_1.talkMaxDuration)

			if var_335_4 <= arg_332_1.time_ and arg_332_1.time_ < var_335_4 + var_335_12 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_4) / var_335_12

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_4 + var_335_12 and arg_332_1.time_ < var_335_4 + var_335_12 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play116091078 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 116091078
		arg_336_1.duration_ = 5

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play116091079(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.var_.moveOldPos1084ui_story = arg_336_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_339_0 = 0.001

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_0 then
				arg_336_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_336_1.time_ - 0) / var_339_0)
				arg_336_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_336_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1084ui_story"].transform.position).z)
				arg_336_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_336_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_336_1.actors_["1084ui_story"].transform.localEulerAngles = arg_336_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_336_1.time_ >= 0 + var_339_0 and arg_336_1.time_ < 0 + var_339_0 + arg_339_0 then
				arg_336_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_336_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_336_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_336_1.actors_["1084ui_story"].transform.position).z)
				arg_336_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_336_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_336_1.actors_["1084ui_story"].transform.localEulerAngles = arg_336_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:AudioAction("play", "effect", "se_story_16", "se_story_16_thunder", "")
			end

			local var_339_2 = manager.ui.mainCamera.transform

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.var_.shakeOldPos = var_339_2.localPosition
			end

			local var_339_3 = 1

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_3 then
				local var_339_4, var_339_5 = math.modf((arg_336_1.time_ - 0) / 0.066)

				var_339_2.localPosition = Vector3.New(var_339_5 * 0.13, var_339_5 * 0.13, var_339_5 * 0.13) + arg_336_1.var_.shakeOldPos
			end

			if arg_336_1.time_ >= 0 + var_339_3 and arg_336_1.time_ < 0 + var_339_3 + arg_339_0 then
				var_339_2.localPosition = arg_336_1.var_.shakeOldPos
			end

			local var_339_6 = 0

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_6 + arg_339_0 then
				arg_336_1.allBtn_.enabled = false
			end

			if arg_336_1.time_ >= var_339_6 + 1 and arg_336_1.time_ < var_339_6 + 1 + arg_339_0 then
				arg_336_1.allBtn_.enabled = true
			end

			local var_339_7 = 0
			local var_339_8 = 0.9

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_7 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, false)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_9 = arg_336_1:FormatText(arg_336_1:GetWordFromCfg(116091078).content)

				arg_336_1.text_.text = var_339_9

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_11 = 36 <= 0 and var_339_8 or var_339_8 * (utf8.len(var_339_9) / 36)

				if (36 <= 0 and var_339_8 or var_339_8 * (utf8.len(var_339_9) / 36)) > 0 and var_339_8 < var_339_11 then
					arg_336_1.talkMaxDuration = var_339_11

					if var_339_11 + var_339_7 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_11 + var_339_7
					end
				end

				arg_336_1.text_.text = var_339_9
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_12 = math.max(var_339_8, arg_336_1.talkMaxDuration)

			if var_339_7 <= arg_336_1.time_ and arg_336_1.time_ < var_339_7 + var_339_12 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_7) / var_339_12

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_7 + var_339_12 and arg_336_1.time_ < var_339_7 + var_339_12 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play116091079 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 116091079
		arg_340_1.duration_ = 7

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play116091080(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0.5 < arg_340_1.time_ and arg_340_1.time_ <= 0.5 + arg_343_0 then
				local var_343_0 = arg_340_1.bgs_.B13a

				arg_340_1.bgs_.B13a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_343_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_343_1 = var_343_0:GetComponent("SpriteRenderer")

				if var_343_1 and var_343_1.sprite then
					local var_343_2 = 2 * (var_343_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_343_0.transform.localScale = Vector3.New(var_343_2 / var_343_1.sprite.bounds.size.y < var_343_2 * manager.ui.mainCameraCom_.aspect / var_343_1.sprite.bounds.size.x and var_343_2 * manager.ui.mainCameraCom_.aspect / var_343_1.sprite.bounds.size.x or var_343_2 / var_343_1.sprite.bounds.size.y, var_343_2 / var_343_1.sprite.bounds.size.y < var_343_2 * manager.ui.mainCameraCom_.aspect / var_343_1.sprite.bounds.size.x and var_343_2 * manager.ui.mainCameraCom_.aspect / var_343_1.sprite.bounds.size.x or var_343_2 / var_343_1.sprite.bounds.size.y, 0)
				end

				for iter_343_0, iter_343_1 in pairs(arg_340_1.bgs_) do
					if iter_343_0 ~= "B13a" then
						iter_343_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_343_3 = 0

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_3 + arg_343_0 then
				arg_340_1.mask_.enabled = true
				arg_340_1.mask_.raycastTarget = true

				arg_340_1:SetGaussion(false)
			end

			local var_343_4 = 0.5

			if var_343_3 <= arg_340_1.time_ and arg_340_1.time_ < var_343_3 + var_343_4 then
				local var_343_5 = Color.New(1, 1, 1)

				var_343_5.a = Mathf.Lerp(0, 1, (arg_340_1.time_ - var_343_3) / var_343_4)
				arg_340_1.mask_.color = var_343_5
			end

			if arg_340_1.time_ >= var_343_3 + var_343_4 and arg_340_1.time_ < var_343_3 + var_343_4 + arg_343_0 then
				local var_343_6 = Color.New(1, 1, 1)

				var_343_6.a = 1
				arg_340_1.mask_.color = var_343_6
			end

			local var_343_7 = 0.5

			if 0.5 < arg_340_1.time_ and arg_340_1.time_ <= var_343_7 + arg_343_0 then
				arg_340_1.mask_.enabled = true
				arg_340_1.mask_.raycastTarget = true

				arg_340_1:SetGaussion(false)
			end

			local var_343_8 = 1.5

			if var_343_7 <= arg_340_1.time_ and arg_340_1.time_ < var_343_7 + var_343_8 then
				local var_343_9 = Color.New(1, 1, 1)

				var_343_9.a = Mathf.Lerp(1, 0, (arg_340_1.time_ - var_343_7) / var_343_8)
				arg_340_1.mask_.color = var_343_9
			end

			if arg_340_1.time_ >= var_343_7 + var_343_8 and arg_340_1.time_ < var_343_7 + var_343_8 + arg_343_0 then
				local var_343_10 = Color.New(1, 1, 1)

				arg_340_1.mask_.enabled = false
				var_343_10.a = 0
				arg_340_1.mask_.color = var_343_10
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:AudioAction("play", "effect", "se_story_16", "se_story_16_hit02", "")
			end

			if arg_340_1.frameCnt_ <= 1 then
				arg_340_1.dialog_:SetActive(false)
			end

			local var_343_12 = 2
			local var_343_13 = 1.275

			if 2 < arg_340_1.time_ and arg_340_1.time_ <= var_343_12 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0

				arg_340_1.dialog_:SetActive(true)

				arg_340_1.dialogCg_.alpha = 0

				local var_343_14 = LeanTween.value(arg_340_1.dialog_, 0, 1, 0.3)

				var_343_14:setOnUpdate(LuaHelper.FloatAction(function(arg_344_0)
					arg_340_1.dialogCg_.alpha = arg_344_0
				end))
				var_343_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_340_1.dialog_)
					var_343_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_340_1.duration_ = arg_340_1.duration_ + 0.3

				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_15 = arg_340_1:FormatText(arg_340_1:GetWordFromCfg(116091079).content)

				arg_340_1.text_.text = var_343_15

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_17 = 51 <= 0 and var_343_13 or var_343_13 * (utf8.len(var_343_15) / 51)

				if (51 <= 0 and var_343_13 or var_343_13 * (utf8.len(var_343_15) / 51)) > 0 and var_343_13 < var_343_17 then
					arg_340_1.talkMaxDuration = var_343_17
					var_343_12 = var_343_12 + 0.3

					if var_343_17 + var_343_12 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_17 + var_343_12
					end
				end

				arg_340_1.text_.text = var_343_15
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_18 = var_343_12 + 0.3
			local var_343_19 = math.max(var_343_13, arg_340_1.talkMaxDuration)

			if var_343_12 + 0.3 <= arg_340_1.time_ and arg_340_1.time_ < var_343_18 + var_343_19 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_18) / var_343_19

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_18 + var_343_19 and arg_340_1.time_ < var_343_18 + var_343_19 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play116091080 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 116091080
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play116091081(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 1

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_1 = arg_346_1:FormatText(arg_346_1:GetWordFromCfg(116091080).content)

				arg_346_1.text_.text = var_349_1

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_3 = 40 <= 0 and var_349_0 or var_349_0 * (utf8.len(var_349_1) / 40)

				if (40 <= 0 and var_349_0 or var_349_0 * (utf8.len(var_349_1) / 40)) > 0 and var_349_0 < var_349_3 then
					arg_346_1.talkMaxDuration = var_349_3

					if var_349_3 + 0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_3 + 0
					end
				end

				arg_346_1.text_.text = var_349_1
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_4 = math.max(var_349_0, arg_346_1.talkMaxDuration)

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_4 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - 0) / var_349_4

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= 0 + var_349_4 and arg_346_1.time_ < 0 + var_349_4 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play116091081 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 116091081
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play116091082(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0.1

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, true)
				arg_350_1.iconController_:SetSelectedState("hero")

				arg_350_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_350_1.callingController_:SetSelectedState("normal")

				arg_350_1.keyicon_.color = Color.New(1, 1, 1)
				arg_350_1.icon_.color = Color.New(1, 1, 1)

				local var_353_1 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(116091081).content)

				arg_350_1.text_.text = var_353_1

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_3 = 4 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_1) / 4)

				if (4 <= 0 and var_353_0 or var_353_0 * (utf8.len(var_353_1) / 4)) > 0 and var_353_0 < var_353_3 then
					arg_350_1.talkMaxDuration = var_353_3

					if var_353_3 + 0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_3 + 0
					end
				end

				arg_350_1.text_.text = var_353_1
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_4 = math.max(var_353_0, arg_350_1.talkMaxDuration)

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_4 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - 0) / var_353_4

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= 0 + var_353_4 and arg_350_1.time_ < 0 + var_353_4 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play116091082 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 116091082
		arg_354_1.duration_ = 7

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play116091083(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.mask_.enabled = true
				arg_354_1.mask_.raycastTarget = true

				arg_354_1:SetGaussion(false)
			end

			local var_357_0 = 2

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 then
				local var_357_1 = Color.New(0, 0, 0)

				var_357_1.a = Mathf.Lerp(0, 1, (arg_354_1.time_ - 0) / var_357_0)
				arg_354_1.mask_.color = var_357_1
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 then
				local var_357_2 = Color.New(0, 0, 0)

				var_357_2.a = 1
				arg_354_1.mask_.color = var_357_2
			end

			local var_357_3 = 2

			if 2 < arg_354_1.time_ and arg_354_1.time_ <= var_357_3 + arg_357_0 then
				arg_354_1.mask_.enabled = true
				arg_354_1.mask_.raycastTarget = true

				arg_354_1:SetGaussion(false)
			end

			local var_357_4 = 0.0166666666666667

			if var_357_3 <= arg_354_1.time_ and arg_354_1.time_ < var_357_3 + var_357_4 then
				local var_357_5 = Color.New(0, 0, 0)

				var_357_5.a = Mathf.Lerp(1, 0, (arg_354_1.time_ - var_357_3) / var_357_4)
				arg_354_1.mask_.color = var_357_5
			end

			if arg_354_1.time_ >= var_357_3 + var_357_4 and arg_354_1.time_ < var_357_3 + var_357_4 + arg_357_0 then
				local var_357_6 = Color.New(0, 0, 0)

				arg_354_1.mask_.enabled = false
				var_357_6.a = 0
				arg_354_1.mask_.color = var_357_6
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:AudioAction("play", "effect", "se_story_16", "se_story_16_wind", "")
			end

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1:AudioAction("play", "effect", "se_story_16", "se_story_16_fight03", "")
			end

			if 2.01666666666667 < arg_354_1.time_ and arg_354_1.time_ <= 2.01666666666667 + arg_357_0 then
				local var_357_9 = arg_354_1.bgs_.STblack

				arg_354_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_357_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_357_10 = var_357_9:GetComponent("SpriteRenderer")

				if var_357_10 and var_357_10.sprite then
					local var_357_11 = 2 * (var_357_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_357_9.transform.localScale = Vector3.New(var_357_11 / var_357_10.sprite.bounds.size.y < var_357_11 * manager.ui.mainCameraCom_.aspect / var_357_10.sprite.bounds.size.x and var_357_11 * manager.ui.mainCameraCom_.aspect / var_357_10.sprite.bounds.size.x or var_357_11 / var_357_10.sprite.bounds.size.y, var_357_11 / var_357_10.sprite.bounds.size.y < var_357_11 * manager.ui.mainCameraCom_.aspect / var_357_10.sprite.bounds.size.x and var_357_11 * manager.ui.mainCameraCom_.aspect / var_357_10.sprite.bounds.size.x or var_357_11 / var_357_10.sprite.bounds.size.y, 0)
				end

				for iter_357_0, iter_357_1 in pairs(arg_354_1.bgs_) do
					if iter_357_0 ~= "STblack" then
						iter_357_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_357_12 = manager.ui.mainCamera.transform

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.shakeOldPos = var_357_12.localPosition
			end

			local var_357_13 = 1

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_13 then
				local var_357_14, var_357_15 = math.modf((arg_354_1.time_ - 0) / 0.066)

				var_357_12.localPosition = Vector3.New(var_357_15 * 0.13, var_357_15 * 0.13, var_357_15 * 0.13) + arg_354_1.var_.shakeOldPos
			end

			if arg_354_1.time_ >= 0 + var_357_13 and arg_354_1.time_ < 0 + var_357_13 + arg_357_0 then
				var_357_12.localPosition = arg_354_1.var_.shakeOldPos
			end

			local var_357_16 = 0

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_16 + arg_357_0 then
				arg_354_1.allBtn_.enabled = false
			end

			if arg_354_1.time_ >= var_357_16 + 1 and arg_354_1.time_ < var_357_16 + 1 + arg_357_0 then
				arg_354_1.allBtn_.enabled = true
			end

			if arg_354_1.frameCnt_ <= 1 then
				arg_354_1.dialog_:SetActive(false)
			end

			local var_357_17 = 2
			local var_357_18 = 1.4

			if 2 < arg_354_1.time_ and arg_354_1.time_ <= var_357_17 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0

				arg_354_1.dialog_:SetActive(true)

				arg_354_1.dialogCg_.alpha = 0

				local var_357_19 = LeanTween.value(arg_354_1.dialog_, 0, 1, 0.3)

				var_357_19:setOnUpdate(LuaHelper.FloatAction(function(arg_358_0)
					arg_354_1.dialogCg_.alpha = arg_358_0
				end))
				var_357_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_354_1.dialog_)
					var_357_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_354_1.duration_ = arg_354_1.duration_ + 0.3

				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_20 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(116091082).content)

				arg_354_1.text_.text = var_357_20

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_22 = 56 <= 0 and var_357_18 or var_357_18 * (utf8.len(var_357_20) / 56)

				if (56 <= 0 and var_357_18 or var_357_18 * (utf8.len(var_357_20) / 56)) > 0 and var_357_18 < var_357_22 then
					arg_354_1.talkMaxDuration = var_357_22
					var_357_17 = var_357_17 + 0.3

					if var_357_22 + var_357_17 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_22 + var_357_17
					end
				end

				arg_354_1.text_.text = var_357_20
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_23 = var_357_17 + 0.3
			local var_357_24 = math.max(var_357_18, arg_354_1.talkMaxDuration)

			if var_357_17 + 0.3 <= arg_354_1.time_ and arg_354_1.time_ < var_357_23 + var_357_24 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_23) / var_357_24

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_23 + var_357_24 and arg_354_1.time_ < var_357_23 + var_357_24 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play116091083 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 116091083
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play116091084(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 1.3

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, false)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_1 = arg_360_1:FormatText(arg_360_1:GetWordFromCfg(116091083).content)

				arg_360_1.text_.text = var_363_1

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_3 = 52 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_1) / 52)

				if (52 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_1) / 52)) > 0 and var_363_0 < var_363_3 then
					arg_360_1.talkMaxDuration = var_363_3

					if var_363_3 + 0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_3 + 0
					end
				end

				arg_360_1.text_.text = var_363_1
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_4 = math.max(var_363_0, arg_360_1.talkMaxDuration)

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_4 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - 0) / var_363_4

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= 0 + var_363_4 and arg_360_1.time_ < 0 + var_363_4 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play116091084 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 116091084
		arg_364_1.duration_ = 2.5

		local var_364_0 = {
			zh = 1.3,
			ja = 2.5
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
				arg_364_0:Play116091085(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0.075

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_1 = arg_364_1:GetWordFromCfg(116091084)
				local var_367_2 = arg_364_1:FormatText(var_367_1.content)

				arg_364_1.text_.text = var_367_2

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_4 = 3 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_2) / 3)

				if (3 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_2) / 3)) > 0 and var_367_0 < var_367_4 then
					arg_364_1.talkMaxDuration = var_367_4

					if var_367_4 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_4 + 0
					end
				end

				arg_364_1.text_.text = var_367_2
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091084", "story_v_out_116091.awb") ~= 0 then
					local var_367_5 = manager.audio:GetVoiceLength("story_v_out_116091", "116091084", "story_v_out_116091.awb") / 1000

					if var_367_5 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_5 + 0
					end

					if var_367_1.prefab_name ~= "" and arg_364_1.actors_[var_367_1.prefab_name] ~= nil then
						local var_367_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_1.prefab_name].transform, "story_v_out_116091", "116091084", "story_v_out_116091.awb")

						arg_364_1:RecordAudio("116091084", var_367_6)
						arg_364_1:RecordAudio("116091084", var_367_6)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_116091", "116091084", "story_v_out_116091.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_116091", "116091084", "story_v_out_116091.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_7 = math.max(var_367_0, arg_364_1.talkMaxDuration)

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_7 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - 0) / var_367_7

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= 0 + var_367_7 and arg_364_1.time_ < 0 + var_367_7 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play116091085 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 116091085
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play116091086(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1:AudioAction("play", "effect", "se_story_16", "se_story_16_smash02", "")
			end

			if 0.366666666666667 < arg_368_1.time_ and arg_368_1.time_ <= 0.366666666666667 + arg_371_0 then
				arg_368_1:AudioAction("play", "effect", "se_story_16", "se_story_16_smash02", "")
			end

			local var_371_2 = 0
			local var_371_3 = 0.2

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

				local var_371_4 = arg_368_1:FormatText(arg_368_1:GetWordFromCfg(116091085).content)

				arg_368_1.text_.text = var_371_4

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_6 = 7 <= 0 and var_371_3 or var_371_3 * (utf8.len(var_371_4) / 7)

				if (7 <= 0 and var_371_3 or var_371_3 * (utf8.len(var_371_4) / 7)) > 0 and var_371_3 < var_371_6 then
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
	Play116091086 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 116091086
		arg_372_1.duration_ = 5

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play116091087(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 1.425

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, false)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_1 = arg_372_1:FormatText(arg_372_1:GetWordFromCfg(116091086).content)

				arg_372_1.text_.text = var_375_1

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_3 = 57 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_1) / 57)

				if (57 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_1) / 57)) > 0 and var_375_0 < var_375_3 then
					arg_372_1.talkMaxDuration = var_375_3

					if var_375_3 + 0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_3 + 0
					end
				end

				arg_372_1.text_.text = var_375_1
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_4 = math.max(var_375_0, arg_372_1.talkMaxDuration)

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_4 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - 0) / var_375_4

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= 0 + var_375_4 and arg_372_1.time_ < 0 + var_375_4 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play116091087 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 116091087
		arg_376_1.duration_ = 7

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play116091088(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.mask_.enabled = true
				arg_376_1.mask_.raycastTarget = true

				arg_376_1:SetGaussion(false)
			end

			local var_379_0 = 2

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_0 then
				local var_379_1 = Color.New(0, 0, 0)

				var_379_1.a = Mathf.Lerp(1, 0, (arg_376_1.time_ - 0) / var_379_0)
				arg_376_1.mask_.color = var_379_1
			end

			if arg_376_1.time_ >= 0 + var_379_0 and arg_376_1.time_ < 0 + var_379_0 + arg_379_0 then
				local var_379_2 = Color.New(0, 0, 0)

				arg_376_1.mask_.enabled = false
				var_379_2.a = 0
				arg_376_1.mask_.color = var_379_2
			end

			local var_379_3 = manager.ui.mainCamera.transform

			if 1.49843910196796 < arg_376_1.time_ and arg_376_1.time_ <= 1.49843910196796 + arg_379_0 then
				arg_376_1.var_.shakeOldPos = var_379_3.localPosition
			end

			local var_379_4 = 1.133333

			if 1.49843910196796 <= arg_376_1.time_ and arg_376_1.time_ < 1.49843910196796 + var_379_4 then
				local var_379_5, var_379_6 = math.modf((arg_376_1.time_ - 1.49843910196796) / 0.066)

				var_379_3.localPosition = Vector3.New(var_379_6 * 0.13, var_379_6 * 0.13, var_379_6 * 0.13) + arg_376_1.var_.shakeOldPos
			end

			if arg_376_1.time_ >= 1.49843910196796 + var_379_4 and arg_376_1.time_ < 1.49843910196796 + var_379_4 + arg_379_0 then
				var_379_3.localPosition = arg_376_1.var_.shakeOldPos
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				local var_379_7 = arg_376_1.bgs_.B13a

				arg_376_1.bgs_.B13a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_379_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_379_8 = var_379_7:GetComponent("SpriteRenderer")

				if var_379_8 and var_379_8.sprite then
					local var_379_9 = 2 * (var_379_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_379_7.transform.localScale = Vector3.New(var_379_9 / var_379_8.sprite.bounds.size.y < var_379_9 * manager.ui.mainCameraCom_.aspect / var_379_8.sprite.bounds.size.x and var_379_9 * manager.ui.mainCameraCom_.aspect / var_379_8.sprite.bounds.size.x or var_379_9 / var_379_8.sprite.bounds.size.y, var_379_9 / var_379_8.sprite.bounds.size.y < var_379_9 * manager.ui.mainCameraCom_.aspect / var_379_8.sprite.bounds.size.x and var_379_9 * manager.ui.mainCameraCom_.aspect / var_379_8.sprite.bounds.size.x or var_379_9 / var_379_8.sprite.bounds.size.y, 0)
				end

				for iter_379_0, iter_379_1 in pairs(arg_376_1.bgs_) do
					if iter_379_0 ~= "B13a" then
						iter_379_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				local var_379_10 = arg_376_1.bgs_.B13a:GetComponent("SpriteRenderer")

				if var_379_10 then
					arg_376_1.var_.alphaOldValueB13a = var_379_10.color.a
					arg_376_1.var_.alphaMatValueB13a = var_379_10
				end

				arg_376_1.var_.alphaOldValueB13a = 0
			end

			local var_379_11 = 0.0166666666666667

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_11 then
				if arg_376_1.var_.alphaMatValueB13a then
					arg_376_1.var_.alphaMatValueB13a.color.a = Mathf.Lerp(arg_376_1.var_.alphaOldValueB13a, 1, (arg_376_1.time_ - 0) / var_379_11)
					arg_376_1.var_.alphaMatValueB13a.color = arg_376_1.var_.alphaMatValueB13a.color
				end
			end

			if arg_376_1.time_ >= 0 + var_379_11 and arg_376_1.time_ < 0 + var_379_11 + arg_379_0 and arg_376_1.var_.alphaMatValueB13a then
				arg_376_1.var_.alphaMatValueB13a.color.a = 1
				arg_376_1.var_.alphaMatValueB13a.color = arg_376_1.var_.alphaMatValueB13a.color
			end

			local var_379_12 = 2

			if 2 < arg_376_1.time_ and arg_376_1.time_ <= var_379_12 + arg_379_0 then
				arg_376_1.allBtn_.enabled = false
			end

			if arg_376_1.time_ >= var_379_12 + 0.631772101967961 and arg_376_1.time_ < var_379_12 + 0.631772101967961 + arg_379_0 then
				arg_376_1.allBtn_.enabled = true
			end

			if arg_376_1.frameCnt_ <= 1 then
				arg_376_1.dialog_:SetActive(false)
			end

			local var_379_13 = 2
			local var_379_14 = 0.775

			if 2 < arg_376_1.time_ and arg_376_1.time_ <= var_379_13 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0

				arg_376_1.dialog_:SetActive(true)

				arg_376_1.dialogCg_.alpha = 0

				local var_379_15 = LeanTween.value(arg_376_1.dialog_, 0, 1, 0.3)

				var_379_15:setOnUpdate(LuaHelper.FloatAction(function(arg_380_0)
					arg_376_1.dialogCg_.alpha = arg_380_0
				end))
				var_379_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_376_1.dialog_)
					var_379_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_376_1.duration_ = arg_376_1.duration_ + 0.3

				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_16 = arg_376_1:FormatText(arg_376_1:GetWordFromCfg(116091087).content)

				arg_376_1.text_.text = var_379_16

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_18 = 31 <= 0 and var_379_14 or var_379_14 * (utf8.len(var_379_16) / 31)

				if (31 <= 0 and var_379_14 or var_379_14 * (utf8.len(var_379_16) / 31)) > 0 and var_379_14 < var_379_18 then
					arg_376_1.talkMaxDuration = var_379_18
					var_379_13 = var_379_13 + 0.3

					if var_379_18 + var_379_13 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_18 + var_379_13
					end
				end

				arg_376_1.text_.text = var_379_16
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_19 = var_379_13 + 0.3
			local var_379_20 = math.max(var_379_14, arg_376_1.talkMaxDuration)

			if var_379_13 + 0.3 <= arg_376_1.time_ and arg_376_1.time_ < var_379_19 + var_379_20 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_19) / var_379_20

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_19 + var_379_20 and arg_376_1.time_ < var_379_19 + var_379_20 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play116091088 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 116091088
		arg_382_1.duration_ = 4.6

		local var_382_0 = {
			zh = 3.4,
			ja = 4.6
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play116091089(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0.35

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, true)
				arg_382_1.iconController_:SetSelectedState("hero")

				arg_382_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_382_1.callingController_:SetSelectedState("normal")

				arg_382_1.keyicon_.color = Color.New(1, 1, 1)
				arg_382_1.icon_.color = Color.New(1, 1, 1)

				local var_385_1 = arg_382_1:GetWordFromCfg(116091088)
				local var_385_2 = arg_382_1:FormatText(var_385_1.content)

				arg_382_1.text_.text = var_385_2

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_4 = 14 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_2) / 14)

				if (14 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_2) / 14)) > 0 and var_385_0 < var_385_4 then
					arg_382_1.talkMaxDuration = var_385_4

					if var_385_4 + 0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_4 + 0
					end
				end

				arg_382_1.text_.text = var_385_2
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091088", "story_v_out_116091.awb") ~= 0 then
					local var_385_5 = manager.audio:GetVoiceLength("story_v_out_116091", "116091088", "story_v_out_116091.awb") / 1000

					if var_385_5 + 0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_5 + 0
					end

					if var_385_1.prefab_name ~= "" and arg_382_1.actors_[var_385_1.prefab_name] ~= nil then
						local var_385_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_1.prefab_name].transform, "story_v_out_116091", "116091088", "story_v_out_116091.awb")

						arg_382_1:RecordAudio("116091088", var_385_6)
						arg_382_1:RecordAudio("116091088", var_385_6)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_116091", "116091088", "story_v_out_116091.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_116091", "116091088", "story_v_out_116091.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_7 = math.max(var_385_0, arg_382_1.talkMaxDuration)

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_7 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - 0) / var_385_7

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= 0 + var_385_7 and arg_382_1.time_ < 0 + var_385_7 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play116091089 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 116091089
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play116091090(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(arg_386_1.actors_["1084ui_story"]) and arg_386_1.var_.characterEffect1084ui_story == nil then
				arg_386_1.var_.characterEffect1084ui_story = arg_386_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_0 = 0.2

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 and not isNil(arg_386_1.actors_["1084ui_story"]) then
				if arg_386_1.var_.characterEffect1084ui_story and not isNil(arg_386_1.actors_["1084ui_story"]) then
					arg_386_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_386_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_386_1.time_ - 0) / var_389_0)
				end
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 and not isNil(arg_386_1.actors_["1084ui_story"]) and arg_386_1.var_.characterEffect1084ui_story then
				arg_386_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_386_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_389_1 = 0
			local var_389_2 = 0.475

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, true)
				arg_386_1.iconController_:SetSelectedState("hero")

				arg_386_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_386_1.callingController_:SetSelectedState("normal")

				arg_386_1.keyicon_.color = Color.New(1, 1, 1)
				arg_386_1.icon_.color = Color.New(1, 1, 1)

				local var_389_3 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(116091089).content)

				arg_386_1.text_.text = var_389_3

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_5 = 19 <= 0 and var_389_2 or var_389_2 * (utf8.len(var_389_3) / 19)

				if (19 <= 0 and var_389_2 or var_389_2 * (utf8.len(var_389_3) / 19)) > 0 and var_389_2 < var_389_5 then
					arg_386_1.talkMaxDuration = var_389_5

					if var_389_5 + var_389_1 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_5 + var_389_1
					end
				end

				arg_386_1.text_.text = var_389_3
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_6 = math.max(var_389_2, arg_386_1.talkMaxDuration)

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_6 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_1) / var_389_6

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_1 + var_389_6 and arg_386_1.time_ < var_389_1 + var_389_6 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play116091090 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 116091090
		arg_390_1.duration_ = 6.77

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
			arg_390_1.auto_ = false
		end

		function arg_390_1.playNext_(arg_392_0)
			arg_390_1.onStoryFinished_()
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.var_.moveOldPos1084ui_story = arg_390_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_393_0 = 0.001

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 then
				arg_390_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_390_1.time_ - 0) / var_393_0)
				arg_390_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_390_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1084ui_story"].transform.position).z)
				arg_390_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_390_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_390_1.actors_["1084ui_story"].transform.localEulerAngles = arg_390_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 then
				arg_390_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_390_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_390_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_390_1.actors_["1084ui_story"].transform.position).z)
				arg_390_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_390_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_390_1.actors_["1084ui_story"].transform.localEulerAngles = arg_390_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:AudioAction("play", "effect", "se_story_16", "se_story_16_hit02", "")
			end

			local var_393_2 = 0

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_2 + arg_393_0 then
				arg_390_1.mask_.enabled = true
				arg_390_1.mask_.raycastTarget = true

				arg_390_1:SetGaussion(false)
			end

			local var_393_3 = 2

			if var_393_2 <= arg_390_1.time_ and arg_390_1.time_ < var_393_2 + var_393_3 then
				local var_393_4 = Color.New(0, 0, 0)

				var_393_4.a = Mathf.Lerp(0, 1, (arg_390_1.time_ - var_393_2) / var_393_3)
				arg_390_1.mask_.color = var_393_4
			end

			if arg_390_1.time_ >= var_393_2 + var_393_3 and arg_390_1.time_ < var_393_2 + var_393_3 + arg_393_0 then
				local var_393_5 = Color.New(0, 0, 0)

				var_393_5.a = 1
				arg_390_1.mask_.color = var_393_5
			end

			local var_393_6 = 2

			if 2 < arg_390_1.time_ and arg_390_1.time_ <= var_393_6 + arg_393_0 then
				arg_390_1.mask_.enabled = true
				arg_390_1.mask_.raycastTarget = true

				arg_390_1:SetGaussion(false)
			end

			local var_393_7 = 0.0166666666666667

			if var_393_6 <= arg_390_1.time_ and arg_390_1.time_ < var_393_6 + var_393_7 then
				local var_393_8 = Color.New(0, 0, 0)

				var_393_8.a = Mathf.Lerp(1, 0, (arg_390_1.time_ - var_393_6) / var_393_7)
				arg_390_1.mask_.color = var_393_8
			end

			if arg_390_1.time_ >= var_393_6 + var_393_7 and arg_390_1.time_ < var_393_6 + var_393_7 + arg_393_0 then
				local var_393_9 = Color.New(0, 0, 0)

				arg_390_1.mask_.enabled = false
				var_393_9.a = 0
				arg_390_1.mask_.color = var_393_9
			end

			if 2 < arg_390_1.time_ and arg_390_1.time_ <= 2 + arg_393_0 then
				local var_393_10 = arg_390_1.bgs_.STblack

				arg_390_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_393_10.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_393_11 = var_393_10:GetComponent("SpriteRenderer")

				if var_393_11 and var_393_11.sprite then
					local var_393_12 = 2 * (var_393_10.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_393_10.transform.localScale = Vector3.New(var_393_12 / var_393_11.sprite.bounds.size.y < var_393_12 * manager.ui.mainCameraCom_.aspect / var_393_11.sprite.bounds.size.x and var_393_12 * manager.ui.mainCameraCom_.aspect / var_393_11.sprite.bounds.size.x or var_393_12 / var_393_11.sprite.bounds.size.y, var_393_12 / var_393_11.sprite.bounds.size.y < var_393_12 * manager.ui.mainCameraCom_.aspect / var_393_11.sprite.bounds.size.x and var_393_12 * manager.ui.mainCameraCom_.aspect / var_393_11.sprite.bounds.size.x or var_393_12 / var_393_11.sprite.bounds.size.y, 0)
				end

				for iter_393_0, iter_393_1 in pairs(arg_390_1.bgs_) do
					if iter_393_0 ~= "STblack" then
						iter_393_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2 < arg_390_1.time_ and arg_390_1.time_ <= 2 + arg_393_0 then
				arg_390_1.fswbg_:SetActive(true)
				arg_390_1.dialog_:SetActive(false)

				arg_390_1.fswtw_.percent = 0
				arg_390_1.fswt_.text = arg_390_1:FormatText(arg_390_1:GetWordFromCfg(116091090).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.fswt_)

				arg_390_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_390_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_390_1.fswtw_:SetDirty()

				arg_390_1.typewritterCharCountI18N = 0

				SetActive(arg_390_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_390_1:ShowNextGo(false)
			end

			local var_393_13 = 2.01666666666667

			if 2.01666666666667 < arg_390_1.time_ and arg_390_1.time_ <= var_393_13 + arg_393_0 then
				arg_390_1.var_.oldValueTypewriter = arg_390_1.fswtw_.percent

				SetActive(arg_390_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_390_1:ShowNextGo(false)
			end

			local var_393_14 = 61
			local var_393_15 = 4.2
			local var_393_16, var_393_17 = arg_390_1:GetPercentByPara(arg_390_1:FormatText(arg_390_1:GetWordFromCfg(116091090).content), 2)

			if var_393_13 < arg_390_1.time_ and arg_390_1.time_ <= var_393_13 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0

				local var_393_18 = var_393_14 <= 0 and var_393_15 or var_393_15 * ((var_393_17 - arg_390_1.typewritterCharCountI18N) / var_393_14)

				if (var_393_14 <= 0 and var_393_15 or var_393_15 * ((var_393_17 - arg_390_1.typewritterCharCountI18N) / var_393_14)) > 0 and var_393_15 < var_393_18 then
					arg_390_1.talkMaxDuration = var_393_18

					if var_393_18 + var_393_13 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_18 + var_393_13
					end
				end
			end

			local var_393_19 = math.max(4.2, arg_390_1.talkMaxDuration)

			if var_393_13 <= arg_390_1.time_ and arg_390_1.time_ < var_393_13 + var_393_19 then
				arg_390_1.fswtw_.percent = Mathf.Lerp(arg_390_1.var_.oldValueTypewriter, var_393_16, (arg_390_1.time_ - var_393_13) / var_393_19)
				arg_390_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_390_1.fswtw_:SetDirty()
			end

			if arg_390_1.time_ >= var_393_13 + var_393_19 and arg_390_1.time_ < var_393_13 + var_393_19 + arg_393_0 then
				arg_390_1.fswtw_.percent = var_393_16

				arg_390_1.fswtw_:SetDirty()
				arg_390_1:ShowNextGo(true)

				arg_390_1.typewritterCharCountI18N = var_393_17
			end

			if 2.01666666666667 < arg_390_1.time_ and arg_390_1.time_ <= 2.01666666666667 + arg_393_0 then
				local var_393_20 = arg_390_1.fswbg_.transform:Find("textbox/adapt/content") or arg_390_1.fswbg_.transform:Find("textbox/content")
				local var_393_21 = arg_390_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_393_22 = var_393_20:GetComponent("RectTransform")

				var_393_20:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_393_22.offsetMin = Vector2.New(0, 0)
				var_393_22.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_390_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_390_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/SK0108",
		"TextureConfig/Background/ST01a",
		"TextureConfig/Background/B13a",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/SK0103",
		"TextureConfig/Background/A00"
	},
	voices = {
		"story_v_out_116091.awb"
	}
}
