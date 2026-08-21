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
			local var_4_0 = "STblack"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.STblack

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_22 = 0

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_23 = arg_1_1:GetWordFromCfg(116091001)
				local var_4_24 = arg_1_1:FormatText(var_4_23.content)

				arg_1_1.fswt_.text = var_4_24

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_25 = 0.0166666666666666

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_26 = 29
			local var_4_27 = 1.93333333333333
			local var_4_28 = arg_1_1:GetWordFromCfg(116091001)
			local var_4_29 = arg_1_1:FormatText(var_4_28.content)
			local var_4_30, var_4_31 = arg_1_1:GetPercentByPara(var_4_29, 1)

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_32 = var_4_26 <= 0 and var_4_27 or var_4_27 * ((var_4_31 - arg_1_1.typewritterCharCountI18N) / var_4_26)

				if var_4_32 > 0 and var_4_27 < var_4_32 then
					arg_1_1.talkMaxDuration = var_4_32

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end
				end
			end

			local var_4_33 = 1.93333333333333
			local var_4_34 = math.max(var_4_33, arg_1_1.talkMaxDuration)

			if var_4_25 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_34 then
				local var_4_35 = (arg_1_1.time_ - var_4_25) / var_4_34

				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_30, var_4_35)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_25 + var_4_34 and arg_1_1.time_ < var_4_25 + var_4_34 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_30

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_31
			end

			local var_4_36 = 0

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_37 = arg_1_1.fswbg_.transform:Find("textbox/adapt/content") or arg_1_1.fswbg_.transform:Find("textbox/content")
				local var_4_38 = arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_4_39 = var_4_37:GetComponent("Text")
				local var_4_40 = var_4_37:GetComponent("RectTransform")

				var_4_39.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_4_40.offsetMin = Vector2.New(0, 0)
				var_4_40.offsetMax = Vector2.New(0, 0)
			end

			local var_4_41 = 0

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_42 = 2

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_43 = 0
			local var_4_44 = 1

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				local var_4_45 = "play"
				local var_4_46 = "music"

				arg_1_1:AudioAction(var_4_45, var_4_46, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_47 = ""
				local var_4_48 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_48 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_48 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_48

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_48
						arg_1_1.bgmTxt2_.text = var_4_48
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
			local var_9_0 = "SK0108"

			if arg_6_1.bgs_[var_9_0] == nil then
				local var_9_1 = Object.Instantiate(arg_6_1.paintGo_)

				var_9_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_9_0)
				var_9_1.name = var_9_0
				var_9_1.transform.parent = arg_6_1.stage_.transform
				var_9_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_6_1.bgs_[var_9_0] = var_9_1
			end

			local var_9_2 = 1

			if var_9_2 < arg_6_1.time_ and arg_6_1.time_ <= var_9_2 + arg_9_0 then
				local var_9_3 = manager.ui.mainCamera.transform.localPosition
				local var_9_4 = Vector3.New(0, 0, 10) + Vector3.New(var_9_3.x, var_9_3.y, 0)
				local var_9_5 = arg_6_1.bgs_.SK0108

				var_9_5.transform.localPosition = var_9_4
				var_9_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_9_6 = var_9_5:GetComponent("SpriteRenderer")

				if var_9_6 and var_9_6.sprite then
					local var_9_7 = (var_9_5.transform.localPosition - var_9_3).z
					local var_9_8 = manager.ui.mainCameraCom_
					local var_9_9 = 2 * var_9_7 * Mathf.Tan(var_9_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_9_10 = var_9_9 * var_9_8.aspect
					local var_9_11 = var_9_6.sprite.bounds.size.x
					local var_9_12 = var_9_6.sprite.bounds.size.y
					local var_9_13 = var_9_10 / var_9_11
					local var_9_14 = var_9_9 / var_9_12
					local var_9_15 = var_9_14 < var_9_13 and var_9_13 or var_9_14

					var_9_5.transform.localScale = Vector3.New(var_9_15, var_9_15, 0)
				end

				for iter_9_0, iter_9_1 in pairs(arg_6_1.bgs_) do
					if iter_9_0 ~= "SK0108" then
						iter_9_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_9_16 = 0

			if var_9_16 < arg_6_1.time_ and arg_6_1.time_ <= var_9_16 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = false

				arg_6_1:SetGaussion(false)
			end

			local var_9_17 = 1

			if var_9_16 <= arg_6_1.time_ and arg_6_1.time_ < var_9_16 + var_9_17 then
				local var_9_18 = (arg_6_1.time_ - var_9_16) / var_9_17
				local var_9_19 = Color.New(0, 0, 0)

				var_9_19.a = Mathf.Lerp(0, 1, var_9_18)
				arg_6_1.mask_.color = var_9_19
			end

			if arg_6_1.time_ >= var_9_16 + var_9_17 and arg_6_1.time_ < var_9_16 + var_9_17 + arg_9_0 then
				local var_9_20 = Color.New(0, 0, 0)

				var_9_20.a = 1
				arg_6_1.mask_.color = var_9_20
			end

			local var_9_21 = 1

			if var_9_21 < arg_6_1.time_ and arg_6_1.time_ <= var_9_21 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = false

				arg_6_1:SetGaussion(false)
			end

			local var_9_22 = 2

			if var_9_21 <= arg_6_1.time_ and arg_6_1.time_ < var_9_21 + var_9_22 then
				local var_9_23 = (arg_6_1.time_ - var_9_21) / var_9_22
				local var_9_24 = Color.New(0, 0, 0)

				var_9_24.a = Mathf.Lerp(1, 0, var_9_23)
				arg_6_1.mask_.color = var_9_24
			end

			if arg_6_1.time_ >= var_9_21 + var_9_22 and arg_6_1.time_ < var_9_21 + var_9_22 + arg_9_0 then
				local var_9_25 = Color.New(0, 0, 0)
				local var_9_26 = 0

				arg_6_1.mask_.enabled = false
				var_9_25.a = var_9_26
				arg_6_1.mask_.color = var_9_25
			end

			local var_9_27 = arg_6_1.bgs_.SK0108.transform
			local var_9_28 = 1

			if var_9_28 < arg_6_1.time_ and arg_6_1.time_ <= var_9_28 + arg_9_0 then
				arg_6_1.var_.moveOldPosSK0108 = var_9_27.localPosition
			end

			local var_9_29 = 0.001

			if var_9_28 <= arg_6_1.time_ and arg_6_1.time_ < var_9_28 + var_9_29 then
				local var_9_30 = (arg_6_1.time_ - var_9_28) / var_9_29
				local var_9_31 = Vector3.New(0, 0, 7)

				var_9_27.localPosition = Vector3.Lerp(arg_6_1.var_.moveOldPosSK0108, var_9_31, var_9_30)
			end

			if arg_6_1.time_ >= var_9_28 + var_9_29 and arg_6_1.time_ < var_9_28 + var_9_29 + arg_9_0 then
				var_9_27.localPosition = Vector3.New(0, 0, 7)
			end

			local var_9_32 = arg_6_1.bgs_.SK0108.transform
			local var_9_33 = 1.034

			if var_9_33 < arg_6_1.time_ and arg_6_1.time_ <= var_9_33 + arg_9_0 then
				arg_6_1.var_.moveOldPosSK0108 = var_9_32.localPosition
			end

			local var_9_34 = 2.466

			if var_9_33 <= arg_6_1.time_ and arg_6_1.time_ < var_9_33 + var_9_34 then
				local var_9_35 = (arg_6_1.time_ - var_9_33) / var_9_34
				local var_9_36 = Vector3.New(0, 0, 6.5)

				var_9_32.localPosition = Vector3.Lerp(arg_6_1.var_.moveOldPosSK0108, var_9_36, var_9_35)
			end

			if arg_6_1.time_ >= var_9_33 + var_9_34 and arg_6_1.time_ < var_9_33 + var_9_34 + arg_9_0 then
				var_9_32.localPosition = Vector3.New(0, 0, 6.5)
			end

			local var_9_37 = 1.034

			if var_9_37 < arg_6_1.time_ and arg_6_1.time_ <= var_9_37 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(true)
				arg_6_1.dialog_:SetActive(false)

				arg_6_1.fswtw_.percent = 0

				local var_9_38 = arg_6_1:GetWordFromCfg(116091002)
				local var_9_39 = arg_6_1:FormatText(var_9_38.content)

				arg_6_1.fswt_.text = var_9_39

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.fswt_)

				arg_6_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_6_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_6_1.fswtw_:SetDirty()

				arg_6_1.typewritterCharCountI18N = 0

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_40 = 1.068

			if var_9_40 < arg_6_1.time_ and arg_6_1.time_ <= var_9_40 + arg_9_0 then
				arg_6_1.var_.oldValueTypewriter = arg_6_1.fswtw_.percent

				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_41 = -11
			local var_9_42 = 1.23266666666667
			local var_9_43 = arg_6_1:GetWordFromCfg(116091002)
			local var_9_44 = arg_6_1:FormatText(var_9_43.content)
			local var_9_45, var_9_46 = arg_6_1:GetPercentByPara(var_9_44, 1)

			if var_9_40 < arg_6_1.time_ and arg_6_1.time_ <= var_9_40 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				local var_9_47 = var_9_41 <= 0 and var_9_42 or var_9_42 * ((var_9_46 - arg_6_1.typewritterCharCountI18N) / var_9_41)

				if var_9_47 > 0 and var_9_42 < var_9_47 then
					arg_6_1.talkMaxDuration = var_9_47

					if var_9_47 + var_9_40 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_47 + var_9_40
					end
				end
			end

			local var_9_48 = 1.23266666666667
			local var_9_49 = math.max(var_9_48, arg_6_1.talkMaxDuration)

			if var_9_40 <= arg_6_1.time_ and arg_6_1.time_ < var_9_40 + var_9_49 then
				local var_9_50 = (arg_6_1.time_ - var_9_40) / var_9_49

				arg_6_1.fswtw_.percent = Mathf.Lerp(arg_6_1.var_.oldValueTypewriter, var_9_45, var_9_50)
				arg_6_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_6_1.fswtw_:SetDirty()
			end

			if arg_6_1.time_ >= var_9_40 + var_9_49 and arg_6_1.time_ < var_9_40 + var_9_49 + arg_9_0 then
				arg_6_1.fswtw_.percent = var_9_45

				arg_6_1.fswtw_:SetDirty()
				arg_6_1:ShowNextGo(true)

				arg_6_1.typewritterCharCountI18N = var_9_46
			end

			local var_9_51 = 0

			if var_9_51 < arg_6_1.time_ and arg_6_1.time_ <= var_9_51 + arg_9_0 then
				arg_6_1.allBtn_.enabled = false
			end

			local var_9_52 = 3.5

			if arg_6_1.time_ >= var_9_51 + var_9_52 and arg_6_1.time_ < var_9_51 + var_9_52 + arg_9_0 then
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
			local var_13_0 = arg_10_1.bgs_.SK0108.transform
			local var_13_1 = 0

			if var_13_1 < arg_10_1.time_ and arg_10_1.time_ <= var_13_1 + arg_13_0 then
				arg_10_1.var_.moveOldPosSK0108 = var_13_0.localPosition
			end

			local var_13_2 = 4

			if var_13_1 <= arg_10_1.time_ and arg_10_1.time_ < var_13_1 + var_13_2 then
				local var_13_3 = (arg_10_1.time_ - var_13_1) / var_13_2
				local var_13_4 = Vector3.New(0, -2, 6.5)

				var_13_0.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPosSK0108, var_13_4, var_13_3)
			end

			if arg_10_1.time_ >= var_13_1 + var_13_2 and arg_10_1.time_ < var_13_1 + var_13_2 + arg_13_0 then
				var_13_0.localPosition = Vector3.New(0, -2, 6.5)
			end

			local var_13_5 = 0

			if var_13_5 < arg_10_1.time_ and arg_10_1.time_ <= var_13_5 + arg_13_0 then
				arg_10_1.fswbg_:SetActive(true)
				arg_10_1.dialog_:SetActive(false)

				arg_10_1.fswtw_.percent = 0

				local var_13_6 = arg_10_1:GetWordFromCfg(116091003)
				local var_13_7 = arg_10_1:FormatText(var_13_6.content)

				arg_10_1.fswt_.text = var_13_7

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.fswt_)

				arg_10_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_10_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_10_1.fswtw_:SetDirty()

				arg_10_1.typewritterCharCountI18N = 0

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_8 = 0.0339999999999999

			if var_13_8 < arg_10_1.time_ and arg_10_1.time_ <= var_13_8 + arg_13_0 then
				arg_10_1.var_.oldValueTypewriter = arg_10_1.fswtw_.percent

				SetActive(arg_10_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_10_1:ShowNextGo(false)
			end

			local var_13_9 = 27
			local var_13_10 = 1.8
			local var_13_11 = arg_10_1:GetWordFromCfg(116091003)
			local var_13_12 = arg_10_1:FormatText(var_13_11.content)
			local var_13_13, var_13_14 = arg_10_1:GetPercentByPara(var_13_12, 1)

			if var_13_8 < arg_10_1.time_ and arg_10_1.time_ <= var_13_8 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0

				local var_13_15 = var_13_9 <= 0 and var_13_10 or var_13_10 * ((var_13_14 - arg_10_1.typewritterCharCountI18N) / var_13_9)

				if var_13_15 > 0 and var_13_10 < var_13_15 then
					arg_10_1.talkMaxDuration = var_13_15

					if var_13_15 + var_13_8 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_15 + var_13_8
					end
				end
			end

			local var_13_16 = 1.8
			local var_13_17 = math.max(var_13_16, arg_10_1.talkMaxDuration)

			if var_13_8 <= arg_10_1.time_ and arg_10_1.time_ < var_13_8 + var_13_17 then
				local var_13_18 = (arg_10_1.time_ - var_13_8) / var_13_17

				arg_10_1.fswtw_.percent = Mathf.Lerp(arg_10_1.var_.oldValueTypewriter, var_13_13, var_13_18)
				arg_10_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_10_1.fswtw_:SetDirty()
			end

			if arg_10_1.time_ >= var_13_8 + var_13_17 and arg_10_1.time_ < var_13_8 + var_13_17 + arg_13_0 then
				arg_10_1.fswtw_.percent = var_13_13

				arg_10_1.fswtw_:SetDirty()
				arg_10_1:ShowNextGo(true)

				arg_10_1.typewritterCharCountI18N = var_13_14
			end

			local var_13_19 = 0

			if var_13_19 < arg_10_1.time_ and arg_10_1.time_ <= var_13_19 + arg_13_0 then
				arg_10_1.allBtn_.enabled = false
			end

			local var_13_20 = 4

			if arg_10_1.time_ >= var_13_19 + var_13_20 and arg_10_1.time_ < var_13_19 + var_13_20 + arg_13_0 then
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
			local var_17_0 = arg_14_1.bgs_.SK0108.transform
			local var_17_1 = 0

			if var_17_1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 then
				arg_14_1.var_.moveOldPosSK0108 = var_17_0.localPosition
			end

			local var_17_2 = 4

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_2 then
				local var_17_3 = (arg_14_1.time_ - var_17_1) / var_17_2
				local var_17_4 = Vector3.New(0, -4, 6.5)

				var_17_0.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPosSK0108, var_17_4, var_17_3)
			end

			if arg_14_1.time_ >= var_17_1 + var_17_2 and arg_14_1.time_ < var_17_1 + var_17_2 + arg_17_0 then
				var_17_0.localPosition = Vector3.New(0, -4, 6.5)
			end

			local var_17_5 = 0

			if var_17_5 < arg_14_1.time_ and arg_14_1.time_ <= var_17_5 + arg_17_0 then
				arg_14_1.fswbg_:SetActive(true)
				arg_14_1.dialog_:SetActive(false)

				arg_14_1.fswtw_.percent = 0

				local var_17_6 = arg_14_1:GetWordFromCfg(116091004)
				local var_17_7 = arg_14_1:FormatText(var_17_6.content)

				arg_14_1.fswt_.text = var_17_7

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.fswt_)

				arg_14_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_14_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_14_1.fswtw_:SetDirty()

				arg_14_1.typewritterCharCountI18N = 0

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_8 = 0.0339999999999999

			if var_17_8 < arg_14_1.time_ and arg_14_1.time_ <= var_17_8 + arg_17_0 then
				arg_14_1.var_.oldValueTypewriter = arg_14_1.fswtw_.percent

				SetActive(arg_14_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_14_1:ShowNextGo(false)
			end

			local var_17_9 = 41
			local var_17_10 = 2.73333333333333
			local var_17_11 = arg_14_1:GetWordFromCfg(116091004)
			local var_17_12 = arg_14_1:FormatText(var_17_11.content)
			local var_17_13, var_17_14 = arg_14_1:GetPercentByPara(var_17_12, 1)

			if var_17_8 < arg_14_1.time_ and arg_14_1.time_ <= var_17_8 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0

				local var_17_15 = var_17_9 <= 0 and var_17_10 or var_17_10 * ((var_17_14 - arg_14_1.typewritterCharCountI18N) / var_17_9)

				if var_17_15 > 0 and var_17_10 < var_17_15 then
					arg_14_1.talkMaxDuration = var_17_15

					if var_17_15 + var_17_8 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_15 + var_17_8
					end
				end
			end

			local var_17_16 = 2.73333333333333
			local var_17_17 = math.max(var_17_16, arg_14_1.talkMaxDuration)

			if var_17_8 <= arg_14_1.time_ and arg_14_1.time_ < var_17_8 + var_17_17 then
				local var_17_18 = (arg_14_1.time_ - var_17_8) / var_17_17

				arg_14_1.fswtw_.percent = Mathf.Lerp(arg_14_1.var_.oldValueTypewriter, var_17_13, var_17_18)
				arg_14_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_14_1.fswtw_:SetDirty()
			end

			if arg_14_1.time_ >= var_17_8 + var_17_17 and arg_14_1.time_ < var_17_8 + var_17_17 + arg_17_0 then
				arg_14_1.fswtw_.percent = var_17_13

				arg_14_1.fswtw_:SetDirty()
				arg_14_1:ShowNextGo(true)

				arg_14_1.typewritterCharCountI18N = var_17_14
			end

			local var_17_19 = 0

			if var_17_19 < arg_14_1.time_ and arg_14_1.time_ <= var_17_19 + arg_17_0 then
				arg_14_1.allBtn_.enabled = false
			end

			local var_17_20 = 4

			if arg_14_1.time_ >= var_17_19 + var_17_20 and arg_14_1.time_ < var_17_19 + var_17_20 + arg_17_0 then
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
			local var_21_0 = arg_18_1.bgs_.SK0108.transform
			local var_21_1 = 0

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 then
				arg_18_1.var_.moveOldPosSK0108 = var_21_0.localPosition
			end

			local var_21_2 = 4

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_2 then
				local var_21_3 = (arg_18_1.time_ - var_21_1) / var_21_2
				local var_21_4 = Vector3.New(0, -6, 6.5)

				var_21_0.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPosSK0108, var_21_4, var_21_3)
			end

			if arg_18_1.time_ >= var_21_1 + var_21_2 and arg_18_1.time_ < var_21_1 + var_21_2 + arg_21_0 then
				var_21_0.localPosition = Vector3.New(0, -6, 6.5)
			end

			local var_21_5 = 0

			if var_21_5 < arg_18_1.time_ and arg_18_1.time_ <= var_21_5 + arg_21_0 then
				arg_18_1.fswbg_:SetActive(true)
				arg_18_1.dialog_:SetActive(false)

				arg_18_1.fswtw_.percent = 0

				local var_21_6 = arg_18_1:GetWordFromCfg(116091005)
				local var_21_7 = arg_18_1:FormatText(var_21_6.content)

				arg_18_1.fswt_.text = var_21_7

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.fswt_)

				arg_18_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_18_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_18_1.fswtw_:SetDirty()

				arg_18_1.typewritterCharCountI18N = 0

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_8 = 0.0339999999999999

			if var_21_8 < arg_18_1.time_ and arg_18_1.time_ <= var_21_8 + arg_21_0 then
				arg_18_1.var_.oldValueTypewriter = arg_18_1.fswtw_.percent

				SetActive(arg_18_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_18_1:ShowNextGo(false)
			end

			local var_21_9 = 22
			local var_21_10 = 1.46666666666667
			local var_21_11 = arg_18_1:GetWordFromCfg(116091005)
			local var_21_12 = arg_18_1:FormatText(var_21_11.content)
			local var_21_13, var_21_14 = arg_18_1:GetPercentByPara(var_21_12, 1)

			if var_21_8 < arg_18_1.time_ and arg_18_1.time_ <= var_21_8 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				local var_21_15 = var_21_9 <= 0 and var_21_10 or var_21_10 * ((var_21_14 - arg_18_1.typewritterCharCountI18N) / var_21_9)

				if var_21_15 > 0 and var_21_10 < var_21_15 then
					arg_18_1.talkMaxDuration = var_21_15

					if var_21_15 + var_21_8 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_15 + var_21_8
					end
				end
			end

			local var_21_16 = 1.46666666666667
			local var_21_17 = math.max(var_21_16, arg_18_1.talkMaxDuration)

			if var_21_8 <= arg_18_1.time_ and arg_18_1.time_ < var_21_8 + var_21_17 then
				local var_21_18 = (arg_18_1.time_ - var_21_8) / var_21_17

				arg_18_1.fswtw_.percent = Mathf.Lerp(arg_18_1.var_.oldValueTypewriter, var_21_13, var_21_18)
				arg_18_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_18_1.fswtw_:SetDirty()
			end

			if arg_18_1.time_ >= var_21_8 + var_21_17 and arg_18_1.time_ < var_21_8 + var_21_17 + arg_21_0 then
				arg_18_1.fswtw_.percent = var_21_13

				arg_18_1.fswtw_:SetDirty()
				arg_18_1:ShowNextGo(true)

				arg_18_1.typewritterCharCountI18N = var_21_14
			end

			local var_21_19 = 0

			if var_21_19 < arg_18_1.time_ and arg_18_1.time_ <= var_21_19 + arg_21_0 then
				arg_18_1.allBtn_.enabled = false
			end

			local var_21_20 = 4

			if arg_18_1.time_ >= var_21_19 + var_21_20 and arg_18_1.time_ < var_21_19 + var_21_20 + arg_21_0 then
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
			local var_25_0 = arg_22_1.bgs_.SK0108.transform
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 then
				arg_22_1.var_.moveOldPosSK0108 = var_25_0.localPosition
			end

			local var_25_2 = 3.33333333333333

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2
				local var_25_4 = Vector3.New(0, -8, 6.5)

				var_25_0.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPosSK0108, var_25_4, var_25_3)
			end

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 then
				var_25_0.localPosition = Vector3.New(0, -8, 6.5)
			end

			local var_25_5 = 0

			if var_25_5 < arg_22_1.time_ and arg_22_1.time_ <= var_25_5 + arg_25_0 then
				arg_22_1.fswbg_:SetActive(true)
				arg_22_1.dialog_:SetActive(false)

				arg_22_1.fswtw_.percent = 0

				local var_25_6 = arg_22_1:GetWordFromCfg(116091006)
				local var_25_7 = arg_22_1:FormatText(var_25_6.content)

				arg_22_1.fswt_.text = var_25_7

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.fswt_)

				arg_22_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_22_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_22_1.fswtw_:SetDirty()

				arg_22_1.typewritterCharCountI18N = 0

				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_22_1:ShowNextGo(false)
			end

			local var_25_8 = 0.0339999999999999

			if var_25_8 < arg_22_1.time_ and arg_22_1.time_ <= var_25_8 + arg_25_0 then
				arg_22_1.var_.oldValueTypewriter = arg_22_1.fswtw_.percent

				SetActive(arg_22_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_22_1:ShowNextGo(false)
			end

			local var_25_9 = 32
			local var_25_10 = 1.46666666666667
			local var_25_11 = arg_22_1:GetWordFromCfg(116091006)
			local var_25_12 = arg_22_1:FormatText(var_25_11.content)
			local var_25_13, var_25_14 = arg_22_1:GetPercentByPara(var_25_12, 1)

			if var_25_8 < arg_22_1.time_ and arg_22_1.time_ <= var_25_8 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				local var_25_15 = var_25_9 <= 0 and var_25_10 or var_25_10 * ((var_25_14 - arg_22_1.typewritterCharCountI18N) / var_25_9)

				if var_25_15 > 0 and var_25_10 < var_25_15 then
					arg_22_1.talkMaxDuration = var_25_15

					if var_25_15 + var_25_8 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_15 + var_25_8
					end
				end
			end

			local var_25_16 = 1.46666666666667
			local var_25_17 = math.max(var_25_16, arg_22_1.talkMaxDuration)

			if var_25_8 <= arg_22_1.time_ and arg_22_1.time_ < var_25_8 + var_25_17 then
				local var_25_18 = (arg_22_1.time_ - var_25_8) / var_25_17

				arg_22_1.fswtw_.percent = Mathf.Lerp(arg_22_1.var_.oldValueTypewriter, var_25_13, var_25_18)
				arg_22_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_22_1.fswtw_:SetDirty()
			end

			if arg_22_1.time_ >= var_25_8 + var_25_17 and arg_22_1.time_ < var_25_8 + var_25_17 + arg_25_0 then
				arg_22_1.fswtw_.percent = var_25_13

				arg_22_1.fswtw_:SetDirty()
				arg_22_1:ShowNextGo(true)

				arg_22_1.typewritterCharCountI18N = var_25_14
			end

			local var_25_19 = 0

			if var_25_19 < arg_22_1.time_ and arg_22_1.time_ <= var_25_19 + arg_25_0 then
				arg_22_1.allBtn_.enabled = false
			end

			local var_25_20 = 3.33333333333333

			if arg_22_1.time_ >= var_25_19 + var_25_20 and arg_22_1.time_ < var_25_19 + var_25_20 + arg_25_0 then
				arg_22_1.allBtn_.enabled = true
			end

			local var_25_21 = 0
			local var_25_22 = 3.33333333333333

			if var_25_21 < arg_22_1.time_ and arg_22_1.time_ <= var_25_21 + arg_25_0 then
				local var_25_23 = "play"
				local var_25_24 = "effect"

				arg_22_1:AudioAction(var_25_23, var_25_24, "se_story_16", "se_story_16_thunder02", "")
			end

			local var_25_25 = 0
			local var_25_26 = 3.33333333333333

			if var_25_25 < arg_22_1.time_ and arg_22_1.time_ <= var_25_25 + arg_25_0 then
				local var_25_27 = "play"
				local var_25_28 = "effect"

				arg_22_1:AudioAction(var_25_27, var_25_28, "se_story_16", "se_story_16_wind02", "")
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
			local var_29_0 = 0.666666666666667

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				local var_29_1 = manager.ui.mainCamera.transform.localPosition
				local var_29_2 = Vector3.New(0, 0, 10) + Vector3.New(var_29_1.x, var_29_1.y, 0)
				local var_29_3 = arg_26_1.bgs_.SK0108

				var_29_3.transform.localPosition = var_29_2
				var_29_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_29_4 = var_29_3:GetComponent("SpriteRenderer")

				if var_29_4 and var_29_4.sprite then
					local var_29_5 = (var_29_3.transform.localPosition - var_29_1).z
					local var_29_6 = manager.ui.mainCameraCom_
					local var_29_7 = 2 * var_29_5 * Mathf.Tan(var_29_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_29_8 = var_29_7 * var_29_6.aspect
					local var_29_9 = var_29_4.sprite.bounds.size.x
					local var_29_10 = var_29_4.sprite.bounds.size.y
					local var_29_11 = var_29_8 / var_29_9
					local var_29_12 = var_29_7 / var_29_10
					local var_29_13 = var_29_12 < var_29_11 and var_29_11 or var_29_12

					var_29_3.transform.localScale = Vector3.New(var_29_13, var_29_13, 0)
				end

				for iter_29_0, iter_29_1 in pairs(arg_26_1.bgs_) do
					if iter_29_0 ~= "SK0108" then
						iter_29_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_29_14 = arg_26_1.bgs_.SK0108.transform
			local var_29_15 = 0.666666666666667

			if var_29_15 < arg_26_1.time_ and arg_26_1.time_ <= var_29_15 + arg_29_0 then
				arg_26_1.var_.moveOldPosSK0108 = var_29_14.localPosition
			end

			local var_29_16 = 0.001

			if var_29_15 <= arg_26_1.time_ and arg_26_1.time_ < var_29_15 + var_29_16 then
				local var_29_17 = (arg_26_1.time_ - var_29_15) / var_29_16
				local var_29_18 = Vector3.New(0, 5.21, 6)

				var_29_14.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPosSK0108, var_29_18, var_29_17)
			end

			if arg_26_1.time_ >= var_29_15 + var_29_16 and arg_26_1.time_ < var_29_15 + var_29_16 + arg_29_0 then
				var_29_14.localPosition = Vector3.New(0, 5.21, 6)
			end

			local var_29_19 = arg_26_1.bgs_.SK0108.transform
			local var_29_20 = 0.700666666666667

			if var_29_20 < arg_26_1.time_ and arg_26_1.time_ <= var_29_20 + arg_29_0 then
				arg_26_1.var_.moveOldPosSK0108 = var_29_19.localPosition
			end

			local var_29_21 = 2.30066666666667

			if var_29_20 <= arg_26_1.time_ and arg_26_1.time_ < var_29_20 + var_29_21 then
				local var_29_22 = (arg_26_1.time_ - var_29_20) / var_29_21
				local var_29_23 = Vector3.New(0, 5.21, 5.5)

				var_29_19.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPosSK0108, var_29_23, var_29_22)
			end

			if arg_26_1.time_ >= var_29_20 + var_29_21 and arg_26_1.time_ < var_29_20 + var_29_21 + arg_29_0 then
				var_29_19.localPosition = Vector3.New(0, 5.21, 5.5)
			end

			local var_29_24 = 0.700666666666667

			if var_29_24 < arg_26_1.time_ and arg_26_1.time_ <= var_29_24 + arg_29_0 then
				arg_26_1.fswbg_:SetActive(true)
				arg_26_1.dialog_:SetActive(false)

				arg_26_1.fswtw_.percent = 0

				local var_29_25 = arg_26_1:GetWordFromCfg(116091007)
				local var_29_26 = arg_26_1:FormatText(var_29_25.content)

				arg_26_1.fswt_.text = var_29_26

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.fswt_)

				arg_26_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_26_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_26_1.fswtw_:SetDirty()

				arg_26_1.typewritterCharCountI18N = 0

				SetActive(arg_26_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_26_1:ShowNextGo(false)
			end

			local var_29_27 = 0.734666666666666

			if var_29_27 < arg_26_1.time_ and arg_26_1.time_ <= var_29_27 + arg_29_0 then
				arg_26_1.var_.oldValueTypewriter = arg_26_1.fswtw_.percent

				SetActive(arg_26_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_26_1:ShowNextGo(false)
			end

			local var_29_28 = -8
			local var_29_29 = 1.6
			local var_29_30 = arg_26_1:GetWordFromCfg(116091007)
			local var_29_31 = arg_26_1:FormatText(var_29_30.content)
			local var_29_32, var_29_33 = arg_26_1:GetPercentByPara(var_29_31, 1)

			if var_29_27 < arg_26_1.time_ and arg_26_1.time_ <= var_29_27 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0

				local var_29_34 = var_29_28 <= 0 and var_29_29 or var_29_29 * ((var_29_33 - arg_26_1.typewritterCharCountI18N) / var_29_28)

				if var_29_34 > 0 and var_29_29 < var_29_34 then
					arg_26_1.talkMaxDuration = var_29_34

					if var_29_34 + var_29_27 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_34 + var_29_27
					end
				end
			end

			local var_29_35 = 1.6
			local var_29_36 = math.max(var_29_35, arg_26_1.talkMaxDuration)

			if var_29_27 <= arg_26_1.time_ and arg_26_1.time_ < var_29_27 + var_29_36 then
				local var_29_37 = (arg_26_1.time_ - var_29_27) / var_29_36

				arg_26_1.fswtw_.percent = Mathf.Lerp(arg_26_1.var_.oldValueTypewriter, var_29_32, var_29_37)
				arg_26_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_26_1.fswtw_:SetDirty()
			end

			if arg_26_1.time_ >= var_29_27 + var_29_36 and arg_26_1.time_ < var_29_27 + var_29_36 + arg_29_0 then
				arg_26_1.fswtw_.percent = var_29_32

				arg_26_1.fswtw_:SetDirty()
				arg_26_1:ShowNextGo(true)

				arg_26_1.typewritterCharCountI18N = var_29_33
			end

			local var_29_38 = 0

			if var_29_38 < arg_26_1.time_ and arg_26_1.time_ <= var_29_38 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = false

				arg_26_1:SetGaussion(false)
			end

			local var_29_39 = 0.666666666666667

			if var_29_38 <= arg_26_1.time_ and arg_26_1.time_ < var_29_38 + var_29_39 then
				local var_29_40 = (arg_26_1.time_ - var_29_38) / var_29_39
				local var_29_41 = Color.New(1, 1, 1)

				var_29_41.a = Mathf.Lerp(0, 1, var_29_40)
				arg_26_1.mask_.color = var_29_41
			end

			if arg_26_1.time_ >= var_29_38 + var_29_39 and arg_26_1.time_ < var_29_38 + var_29_39 + arg_29_0 then
				local var_29_42 = Color.New(1, 1, 1)

				var_29_42.a = 1
				arg_26_1.mask_.color = var_29_42
			end

			local var_29_43 = 0.666666666666667

			if var_29_43 < arg_26_1.time_ and arg_26_1.time_ <= var_29_43 + arg_29_0 then
				arg_26_1.mask_.enabled = true
				arg_26_1.mask_.raycastTarget = false

				arg_26_1:SetGaussion(false)
			end

			local var_29_44 = 0.700666666666667

			if var_29_43 <= arg_26_1.time_ and arg_26_1.time_ < var_29_43 + var_29_44 then
				local var_29_45 = (arg_26_1.time_ - var_29_43) / var_29_44
				local var_29_46 = Color.New(1, 1, 1)

				var_29_46.a = Mathf.Lerp(1, 0, var_29_45)
				arg_26_1.mask_.color = var_29_46
			end

			if arg_26_1.time_ >= var_29_43 + var_29_44 and arg_26_1.time_ < var_29_43 + var_29_44 + arg_29_0 then
				local var_29_47 = Color.New(1, 1, 1)
				local var_29_48 = 0

				arg_26_1.mask_.enabled = false
				var_29_47.a = var_29_48
				arg_26_1.mask_.color = var_29_47
			end

			local var_29_49 = 0

			if var_29_49 < arg_26_1.time_ and arg_26_1.time_ <= var_29_49 + arg_29_0 then
				arg_26_1.allBtn_.enabled = false
			end

			local var_29_50 = 3.00133333333333

			if arg_26_1.time_ >= var_29_49 + var_29_50 and arg_26_1.time_ < var_29_49 + var_29_50 + arg_29_0 then
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
			local var_33_0 = "ST01a"

			if arg_30_1.bgs_[var_33_0] == nil then
				local var_33_1 = Object.Instantiate(arg_30_1.paintGo_)

				var_33_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_33_0)
				var_33_1.name = var_33_0
				var_33_1.transform.parent = arg_30_1.stage_.transform
				var_33_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_30_1.bgs_[var_33_0] = var_33_1
			end

			local var_33_2 = 2

			if var_33_2 < arg_30_1.time_ and arg_30_1.time_ <= var_33_2 + arg_33_0 then
				local var_33_3 = manager.ui.mainCamera.transform.localPosition
				local var_33_4 = Vector3.New(0, 0, 10) + Vector3.New(var_33_3.x, var_33_3.y, 0)
				local var_33_5 = arg_30_1.bgs_.ST01a

				var_33_5.transform.localPosition = var_33_4
				var_33_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_33_6 = var_33_5:GetComponent("SpriteRenderer")

				if var_33_6 and var_33_6.sprite then
					local var_33_7 = (var_33_5.transform.localPosition - var_33_3).z
					local var_33_8 = manager.ui.mainCameraCom_
					local var_33_9 = 2 * var_33_7 * Mathf.Tan(var_33_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_33_10 = var_33_9 * var_33_8.aspect
					local var_33_11 = var_33_6.sprite.bounds.size.x
					local var_33_12 = var_33_6.sprite.bounds.size.y
					local var_33_13 = var_33_10 / var_33_11
					local var_33_14 = var_33_9 / var_33_12
					local var_33_15 = var_33_14 < var_33_13 and var_33_13 or var_33_14

					var_33_5.transform.localScale = Vector3.New(var_33_15, var_33_15, 0)
				end

				for iter_33_0, iter_33_1 in pairs(arg_30_1.bgs_) do
					if iter_33_0 ~= "ST01a" then
						iter_33_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_33_16 = 0

			if var_33_16 < arg_30_1.time_ and arg_30_1.time_ <= var_33_16 + arg_33_0 then
				arg_30_1.mask_.enabled = true
				arg_30_1.mask_.raycastTarget = false

				arg_30_1:SetGaussion(false)
			end

			local var_33_17 = 1.03333333333333

			if var_33_16 <= arg_30_1.time_ and arg_30_1.time_ < var_33_16 + var_33_17 then
				local var_33_18 = (arg_30_1.time_ - var_33_16) / var_33_17
				local var_33_19 = Color.New(0, 0, 0)

				var_33_19.a = Mathf.Lerp(0, 1, var_33_18)
				arg_30_1.mask_.color = var_33_19
			end

			if arg_30_1.time_ >= var_33_16 + var_33_17 and arg_30_1.time_ < var_33_16 + var_33_17 + arg_33_0 then
				local var_33_20 = Color.New(0, 0, 0)

				var_33_20.a = 1
				arg_30_1.mask_.color = var_33_20
			end

			local var_33_21 = 2

			if var_33_21 < arg_30_1.time_ and arg_30_1.time_ <= var_33_21 + arg_33_0 then
				arg_30_1.mask_.enabled = true
				arg_30_1.mask_.raycastTarget = false

				arg_30_1:SetGaussion(false)
			end

			local var_33_22 = 1.33333333333333

			if var_33_21 <= arg_30_1.time_ and arg_30_1.time_ < var_33_21 + var_33_22 then
				local var_33_23 = (arg_30_1.time_ - var_33_21) / var_33_22
				local var_33_24 = Color.New(0, 0, 0)

				var_33_24.a = Mathf.Lerp(1, 0, var_33_23)
				arg_30_1.mask_.color = var_33_24
			end

			if arg_30_1.time_ >= var_33_21 + var_33_22 and arg_30_1.time_ < var_33_21 + var_33_22 + arg_33_0 then
				local var_33_25 = Color.New(0, 0, 0)
				local var_33_26 = 0

				arg_30_1.mask_.enabled = false
				var_33_25.a = var_33_26
				arg_30_1.mask_.color = var_33_25
			end

			local var_33_27 = 1.01666666666667

			if var_33_27 < arg_30_1.time_ and arg_30_1.time_ <= var_33_27 + arg_33_0 then
				arg_30_1.fswbg_:SetActive(false)
				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_30_1:ShowNextGo(false)
			end

			if arg_30_1.frameCnt_ <= 1 then
				arg_30_1.dialog_:SetActive(false)
			end

			local var_33_28 = 3.33333333333333
			local var_33_29 = 0.275

			if var_33_28 < arg_30_1.time_ and arg_30_1.time_ <= var_33_28 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				arg_30_1.dialog_:SetActive(true)

				arg_30_1.dialogCg_.alpha = 0

				local var_33_30 = LeanTween.value(arg_30_1.dialog_, 0, 1, 0.3)

				var_33_30:setOnUpdate(LuaHelper.FloatAction(function(arg_34_0)
					arg_30_1.dialogCg_.alpha = arg_34_0
				end))
				var_33_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_30_1.dialog_)
					var_33_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_30_1.duration_ = arg_30_1.duration_ + 0.3

				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_31 = arg_30_1:FormatText(StoryNameCfg[7].name)

				arg_30_1.leftNameTxt_.text = var_33_31

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

				local var_33_32 = arg_30_1:GetWordFromCfg(116091008)
				local var_33_33 = arg_30_1:FormatText(var_33_32.content)

				arg_30_1.text_.text = var_33_33

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_34 = 11
				local var_33_35 = utf8.len(var_33_33)
				local var_33_36 = var_33_34 <= 0 and var_33_29 or var_33_29 * (var_33_35 / var_33_34)

				if var_33_36 > 0 and var_33_29 < var_33_36 then
					arg_30_1.talkMaxDuration = var_33_36
					var_33_28 = var_33_28 + 0.3

					if var_33_36 + var_33_28 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_36 + var_33_28
					end
				end

				arg_30_1.text_.text = var_33_33
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_37 = var_33_28 + 0.3
			local var_33_38 = math.max(var_33_29, arg_30_1.talkMaxDuration)

			if var_33_37 <= arg_30_1.time_ and arg_30_1.time_ < var_33_37 + var_33_38 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_37) / var_33_38

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_37 + var_33_38 and arg_30_1.time_ < var_33_37 + var_33_38 + arg_33_0 then
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
			local var_39_0 = 0
			local var_39_1 = 1

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				local var_39_2 = "play"
				local var_39_3 = "music"

				arg_36_1:AudioAction(var_39_2, var_39_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_39_4 = ""
				local var_39_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_39_5 ~= "" then
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

			local var_39_6 = 1.5
			local var_39_7 = 1.5

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				local var_39_8 = "play"
				local var_39_9 = "music"

				arg_36_1:AudioAction(var_39_8, var_39_9, "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_39_10 = ""
				local var_39_11 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if var_39_11 ~= "" then
					if arg_36_1.bgmTxt_.text ~= var_39_11 and arg_36_1.bgmTxt_.text ~= "" then
						if arg_36_1.bgmTxt2_.text ~= "" then
							arg_36_1.bgmTxt_.text = arg_36_1.bgmTxt2_.text
						end

						arg_36_1.bgmTxt2_.text = var_39_11

						arg_36_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_36_1.bgmTxt_.text = var_39_11
						arg_36_1.bgmTxt2_.text = var_39_11
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

			local var_39_12 = 0
			local var_39_13 = 1.325

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_14 = arg_36_1:GetWordFromCfg(116091009)
				local var_39_15 = arg_36_1:FormatText(var_39_14.content)

				arg_36_1.text_.text = var_39_15

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_16 = 53
				local var_39_17 = utf8.len(var_39_15)
				local var_39_18 = var_39_16 <= 0 and var_39_13 or var_39_13 * (var_39_17 / var_39_16)

				if var_39_18 > 0 and var_39_13 < var_39_18 then
					arg_36_1.talkMaxDuration = var_39_18

					if var_39_18 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_18 + var_39_12
					end
				end

				arg_36_1.text_.text = var_39_15
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_19 = math.max(var_39_13, arg_36_1.talkMaxDuration)

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_19 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_12) / var_39_19

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_12 + var_39_19 and arg_36_1.time_ < var_39_12 + var_39_19 + arg_39_0 then
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
			local var_45_0 = 0
			local var_45_1 = 0.375

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_2 = arg_42_1:FormatText(StoryNameCfg[7].name)

				arg_42_1.leftNameTxt_.text = var_45_2

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

				local var_45_3 = arg_42_1:GetWordFromCfg(116091010)
				local var_45_4 = arg_42_1:FormatText(var_45_3.content)

				arg_42_1.text_.text = var_45_4

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_5 = 15
				local var_45_6 = utf8.len(var_45_4)
				local var_45_7 = var_45_5 <= 0 and var_45_1 or var_45_1 * (var_45_6 / var_45_5)

				if var_45_7 > 0 and var_45_1 < var_45_7 then
					arg_42_1.talkMaxDuration = var_45_7

					if var_45_7 + var_45_0 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_7 + var_45_0
					end
				end

				arg_42_1.text_.text = var_45_4
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_8 = math.max(var_45_1, arg_42_1.talkMaxDuration)

			if var_45_0 <= arg_42_1.time_ and arg_42_1.time_ < var_45_0 + var_45_8 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_0) / var_45_8

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_0 + var_45_8 and arg_42_1.time_ < var_45_0 + var_45_8 + arg_45_0 then
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
			local var_49_0 = 0
			local var_49_1 = 0.7

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_2 = arg_46_1:FormatText(StoryNameCfg[10].name)

				arg_46_1.leftNameTxt_.text = var_49_2

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

				local var_49_3 = arg_46_1:GetWordFromCfg(116091011)
				local var_49_4 = arg_46_1:FormatText(var_49_3.content)

				arg_46_1.text_.text = var_49_4

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_5 = 28
				local var_49_6 = utf8.len(var_49_4)
				local var_49_7 = var_49_5 <= 0 and var_49_1 or var_49_1 * (var_49_6 / var_49_5)

				if var_49_7 > 0 and var_49_1 < var_49_7 then
					arg_46_1.talkMaxDuration = var_49_7

					if var_49_7 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_7 + var_49_0
					end
				end

				arg_46_1.text_.text = var_49_4
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091011", "story_v_out_116091.awb") ~= 0 then
					local var_49_8 = manager.audio:GetVoiceLength("story_v_out_116091", "116091011", "story_v_out_116091.awb") / 1000

					if var_49_8 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_8 + var_49_0
					end

					if var_49_3.prefab_name ~= "" and arg_46_1.actors_[var_49_3.prefab_name] ~= nil then
						local var_49_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_3.prefab_name].transform, "story_v_out_116091", "116091011", "story_v_out_116091.awb")

						arg_46_1:RecordAudio("116091011", var_49_9)
						arg_46_1:RecordAudio("116091011", var_49_9)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_116091", "116091011", "story_v_out_116091.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_116091", "116091011", "story_v_out_116091.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_10 = math.max(var_49_1, arg_46_1.talkMaxDuration)

			if var_49_0 <= arg_46_1.time_ and arg_46_1.time_ < var_49_0 + var_49_10 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_0) / var_49_10

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_0 + var_49_10 and arg_46_1.time_ < var_49_0 + var_49_10 + arg_49_0 then
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
			local var_53_0 = 0
			local var_53_1 = 0.275

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_2 = arg_50_1:FormatText(StoryNameCfg[7].name)

				arg_50_1.leftNameTxt_.text = var_53_2

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

				local var_53_3 = arg_50_1:GetWordFromCfg(116091012)
				local var_53_4 = arg_50_1:FormatText(var_53_3.content)

				arg_50_1.text_.text = var_53_4

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_5 = 11
				local var_53_6 = utf8.len(var_53_4)
				local var_53_7 = var_53_5 <= 0 and var_53_1 or var_53_1 * (var_53_6 / var_53_5)

				if var_53_7 > 0 and var_53_1 < var_53_7 then
					arg_50_1.talkMaxDuration = var_53_7

					if var_53_7 + var_53_0 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_7 + var_53_0
					end
				end

				arg_50_1.text_.text = var_53_4
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_8 = math.max(var_53_1, arg_50_1.talkMaxDuration)

			if var_53_0 <= arg_50_1.time_ and arg_50_1.time_ < var_53_0 + var_53_8 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_0) / var_53_8

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_0 + var_53_8 and arg_50_1.time_ < var_53_0 + var_53_8 + arg_53_0 then
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
			local var_57_0 = "B13a"

			if arg_54_1.bgs_[var_57_0] == nil then
				local var_57_1 = Object.Instantiate(arg_54_1.paintGo_)

				var_57_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_57_0)
				var_57_1.name = var_57_0
				var_57_1.transform.parent = arg_54_1.stage_.transform
				var_57_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_54_1.bgs_[var_57_0] = var_57_1
			end

			local var_57_2 = 2

			if var_57_2 < arg_54_1.time_ and arg_54_1.time_ <= var_57_2 + arg_57_0 then
				local var_57_3 = manager.ui.mainCamera.transform.localPosition
				local var_57_4 = Vector3.New(0, 0, 10) + Vector3.New(var_57_3.x, var_57_3.y, 0)
				local var_57_5 = arg_54_1.bgs_.B13a

				var_57_5.transform.localPosition = var_57_4
				var_57_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_57_6 = var_57_5:GetComponent("SpriteRenderer")

				if var_57_6 and var_57_6.sprite then
					local var_57_7 = (var_57_5.transform.localPosition - var_57_3).z
					local var_57_8 = manager.ui.mainCameraCom_
					local var_57_9 = 2 * var_57_7 * Mathf.Tan(var_57_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_57_10 = var_57_9 * var_57_8.aspect
					local var_57_11 = var_57_6.sprite.bounds.size.x
					local var_57_12 = var_57_6.sprite.bounds.size.y
					local var_57_13 = var_57_10 / var_57_11
					local var_57_14 = var_57_9 / var_57_12
					local var_57_15 = var_57_14 < var_57_13 and var_57_13 or var_57_14

					var_57_5.transform.localScale = Vector3.New(var_57_15, var_57_15, 0)
				end

				for iter_57_0, iter_57_1 in pairs(arg_54_1.bgs_) do
					if iter_57_0 ~= "B13a" then
						iter_57_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_57_16 = 0

			if var_57_16 < arg_54_1.time_ and arg_54_1.time_ <= var_57_16 + arg_57_0 then
				arg_54_1.mask_.enabled = true
				arg_54_1.mask_.raycastTarget = false

				arg_54_1:SetGaussion(false)
			end

			local var_57_17 = 2

			if var_57_16 <= arg_54_1.time_ and arg_54_1.time_ < var_57_16 + var_57_17 then
				local var_57_18 = (arg_54_1.time_ - var_57_16) / var_57_17
				local var_57_19 = Color.New(0, 0, 0)

				var_57_19.a = Mathf.Lerp(0, 1, var_57_18)
				arg_54_1.mask_.color = var_57_19
			end

			if arg_54_1.time_ >= var_57_16 + var_57_17 and arg_54_1.time_ < var_57_16 + var_57_17 + arg_57_0 then
				local var_57_20 = Color.New(0, 0, 0)

				var_57_20.a = 1
				arg_54_1.mask_.color = var_57_20
			end

			local var_57_21 = 2

			if var_57_21 < arg_54_1.time_ and arg_54_1.time_ <= var_57_21 + arg_57_0 then
				arg_54_1.mask_.enabled = true
				arg_54_1.mask_.raycastTarget = false

				arg_54_1:SetGaussion(false)
			end

			local var_57_22 = 2

			if var_57_21 <= arg_54_1.time_ and arg_54_1.time_ < var_57_21 + var_57_22 then
				local var_57_23 = (arg_54_1.time_ - var_57_21) / var_57_22
				local var_57_24 = Color.New(0, 0, 0)

				var_57_24.a = Mathf.Lerp(1, 0, var_57_23)
				arg_54_1.mask_.color = var_57_24
			end

			if arg_54_1.time_ >= var_57_21 + var_57_22 and arg_54_1.time_ < var_57_21 + var_57_22 + arg_57_0 then
				local var_57_25 = Color.New(0, 0, 0)
				local var_57_26 = 0

				arg_54_1.mask_.enabled = false
				var_57_25.a = var_57_26
				arg_54_1.mask_.color = var_57_25
			end

			if arg_54_1.frameCnt_ <= 1 then
				arg_54_1.dialog_:SetActive(false)
			end

			local var_57_27 = 4
			local var_57_28 = 0.375

			if var_57_27 < arg_54_1.time_ and arg_54_1.time_ <= var_57_27 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0

				arg_54_1.dialog_:SetActive(true)

				arg_54_1.dialogCg_.alpha = 0

				local var_57_29 = LeanTween.value(arg_54_1.dialog_, 0, 1, 0.3)

				var_57_29:setOnUpdate(LuaHelper.FloatAction(function(arg_58_0)
					arg_54_1.dialogCg_.alpha = arg_58_0
				end))
				var_57_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_54_1.dialog_)
					var_57_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_54_1.duration_ = arg_54_1.duration_ + 0.3

				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_30 = arg_54_1:GetWordFromCfg(116091013)
				local var_57_31 = arg_54_1:FormatText(var_57_30.content)

				arg_54_1.text_.text = var_57_31

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_32 = 15
				local var_57_33 = utf8.len(var_57_31)
				local var_57_34 = var_57_32 <= 0 and var_57_28 or var_57_28 * (var_57_33 / var_57_32)

				if var_57_34 > 0 and var_57_28 < var_57_34 then
					arg_54_1.talkMaxDuration = var_57_34
					var_57_27 = var_57_27 + 0.3

					if var_57_34 + var_57_27 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_34 + var_57_27
					end
				end

				arg_54_1.text_.text = var_57_31
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_35 = var_57_27 + 0.3
			local var_57_36 = math.max(var_57_28, arg_54_1.talkMaxDuration)

			if var_57_35 <= arg_54_1.time_ and arg_54_1.time_ < var_57_35 + var_57_36 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_35) / var_57_36

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_35 + var_57_36 and arg_54_1.time_ < var_57_35 + var_57_36 + arg_57_0 then
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
			local var_63_0 = "1084ui_story"

			if arg_60_1.actors_[var_63_0] == nil then
				local var_63_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_63_1) then
					local var_63_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_60_1.stage_.transform)

					var_63_2.name = var_63_0
					var_63_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_60_1.actors_[var_63_0] = var_63_2

					local var_63_3 = var_63_2:GetComponentInChildren(typeof(CharacterEffect))

					var_63_3.enabled = true

					local var_63_4 = GameObjectTools.GetOrAddComponent(var_63_2, typeof(DynamicBoneHelper))

					if var_63_4 then
						var_63_4:EnableDynamicBone(false)
					end

					arg_60_1:ShowWeapon(var_63_3.transform, false)

					arg_60_1.var_[var_63_0 .. "Animator"] = var_63_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_60_1.var_[var_63_0 .. "Animator"].applyRootMotion = true
					arg_60_1.var_[var_63_0 .. "LipSync"] = var_63_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_63_5 = arg_60_1.actors_["1084ui_story"].transform
			local var_63_6 = 0

			if var_63_6 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.var_.moveOldPos1084ui_story = var_63_5.localPosition
			end

			local var_63_7 = 0.001

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_7 then
				local var_63_8 = (arg_60_1.time_ - var_63_6) / var_63_7
				local var_63_9 = Vector3.New(0, -0.97, -6)

				var_63_5.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1084ui_story, var_63_9, var_63_8)

				local var_63_10 = manager.ui.mainCamera.transform.position - var_63_5.position

				var_63_5.forward = Vector3.New(var_63_10.x, var_63_10.y, var_63_10.z)

				local var_63_11 = var_63_5.localEulerAngles

				var_63_11.z = 0
				var_63_11.x = 0
				var_63_5.localEulerAngles = var_63_11
			end

			if arg_60_1.time_ >= var_63_6 + var_63_7 and arg_60_1.time_ < var_63_6 + var_63_7 + arg_63_0 then
				var_63_5.localPosition = Vector3.New(0, -0.97, -6)

				local var_63_12 = manager.ui.mainCamera.transform.position - var_63_5.position

				var_63_5.forward = Vector3.New(var_63_12.x, var_63_12.y, var_63_12.z)

				local var_63_13 = var_63_5.localEulerAngles

				var_63_13.z = 0
				var_63_13.x = 0
				var_63_5.localEulerAngles = var_63_13
			end

			local var_63_14 = 0

			if var_63_14 < arg_60_1.time_ and arg_60_1.time_ <= var_63_14 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_63_15 = 0

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_63_16 = 0
			local var_63_17 = 0.475

			if var_63_16 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_18 = arg_60_1:FormatText(StoryNameCfg[6].name)

				arg_60_1.leftNameTxt_.text = var_63_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_19 = arg_60_1:GetWordFromCfg(116091014)
				local var_63_20 = arg_60_1:FormatText(var_63_19.content)

				arg_60_1.text_.text = var_63_20

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_21 = 19
				local var_63_22 = utf8.len(var_63_20)
				local var_63_23 = var_63_21 <= 0 and var_63_17 or var_63_17 * (var_63_22 / var_63_21)

				if var_63_23 > 0 and var_63_17 < var_63_23 then
					arg_60_1.talkMaxDuration = var_63_23

					if var_63_23 + var_63_16 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_23 + var_63_16
					end
				end

				arg_60_1.text_.text = var_63_20
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091014", "story_v_out_116091.awb") ~= 0 then
					local var_63_24 = manager.audio:GetVoiceLength("story_v_out_116091", "116091014", "story_v_out_116091.awb") / 1000

					if var_63_24 + var_63_16 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_24 + var_63_16
					end

					if var_63_19.prefab_name ~= "" and arg_60_1.actors_[var_63_19.prefab_name] ~= nil then
						local var_63_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_19.prefab_name].transform, "story_v_out_116091", "116091014", "story_v_out_116091.awb")

						arg_60_1:RecordAudio("116091014", var_63_25)
						arg_60_1:RecordAudio("116091014", var_63_25)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_116091", "116091014", "story_v_out_116091.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_116091", "116091014", "story_v_out_116091.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_26 = math.max(var_63_17, arg_60_1.talkMaxDuration)

			if var_63_16 <= arg_60_1.time_ and arg_60_1.time_ < var_63_16 + var_63_26 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_16) / var_63_26

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_16 + var_63_26 and arg_60_1.time_ < var_63_16 + var_63_26 + arg_63_0 then
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
			local var_67_0 = arg_64_1.actors_["1084ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1084ui_story == nil then
				arg_64_1.var_.characterEffect1084ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.2

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1084ui_story and not isNil(var_67_0) then
					local var_67_4 = Mathf.Lerp(0, 0.5, var_67_3)

					arg_64_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1084ui_story.fillRatio = var_67_4
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1084ui_story then
				local var_67_5 = 0.5

				arg_64_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1084ui_story.fillRatio = var_67_5
			end

			local var_67_6 = 0
			local var_67_7 = 0.225

			if var_67_6 < arg_64_1.time_ and arg_64_1.time_ <= var_67_6 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_8 = arg_64_1:FormatText(StoryNameCfg[7].name)

				arg_64_1.leftNameTxt_.text = var_67_8

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

				local var_67_9 = arg_64_1:GetWordFromCfg(116091015)
				local var_67_10 = arg_64_1:FormatText(var_67_9.content)

				arg_64_1.text_.text = var_67_10

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_11 = 9
				local var_67_12 = utf8.len(var_67_10)
				local var_67_13 = var_67_11 <= 0 and var_67_7 or var_67_7 * (var_67_12 / var_67_11)

				if var_67_13 > 0 and var_67_7 < var_67_13 then
					arg_64_1.talkMaxDuration = var_67_13

					if var_67_13 + var_67_6 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_13 + var_67_6
					end
				end

				arg_64_1.text_.text = var_67_10
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_14 = math.max(var_67_7, arg_64_1.talkMaxDuration)

			if var_67_6 <= arg_64_1.time_ and arg_64_1.time_ < var_67_6 + var_67_14 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_6) / var_67_14

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_6 + var_67_14 and arg_64_1.time_ < var_67_6 + var_67_14 + arg_67_0 then
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
			local var_71_0 = arg_68_1.actors_["1084ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1084ui_story == nil then
				arg_68_1.var_.characterEffect1084ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.2

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect1084ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect1084ui_story then
				arg_68_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_71_4 = 0

			if var_71_4 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action463")
			end

			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_71_6 = 0
			local var_71_7 = 0.975

			if var_71_6 < arg_68_1.time_ and arg_68_1.time_ <= var_71_6 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_8 = arg_68_1:FormatText(StoryNameCfg[6].name)

				arg_68_1.leftNameTxt_.text = var_71_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_9 = arg_68_1:GetWordFromCfg(116091016)
				local var_71_10 = arg_68_1:FormatText(var_71_9.content)

				arg_68_1.text_.text = var_71_10

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_11 = 39
				local var_71_12 = utf8.len(var_71_10)
				local var_71_13 = var_71_11 <= 0 and var_71_7 or var_71_7 * (var_71_12 / var_71_11)

				if var_71_13 > 0 and var_71_7 < var_71_13 then
					arg_68_1.talkMaxDuration = var_71_13

					if var_71_13 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_13 + var_71_6
					end
				end

				arg_68_1.text_.text = var_71_10
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091016", "story_v_out_116091.awb") ~= 0 then
					local var_71_14 = manager.audio:GetVoiceLength("story_v_out_116091", "116091016", "story_v_out_116091.awb") / 1000

					if var_71_14 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_14 + var_71_6
					end

					if var_71_9.prefab_name ~= "" and arg_68_1.actors_[var_71_9.prefab_name] ~= nil then
						local var_71_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_9.prefab_name].transform, "story_v_out_116091", "116091016", "story_v_out_116091.awb")

						arg_68_1:RecordAudio("116091016", var_71_15)
						arg_68_1:RecordAudio("116091016", var_71_15)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_116091", "116091016", "story_v_out_116091.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_116091", "116091016", "story_v_out_116091.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_16 = math.max(var_71_7, arg_68_1.talkMaxDuration)

			if var_71_6 <= arg_68_1.time_ and arg_68_1.time_ < var_71_6 + var_71_16 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_6) / var_71_16

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_6 + var_71_16 and arg_68_1.time_ < var_71_6 + var_71_16 + arg_71_0 then
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
			local var_75_0 = arg_72_1.actors_["1084ui_story"].transform
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.var_.moveOldPos1084ui_story = var_75_0.localPosition
			end

			local var_75_2 = 0.001

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2
				local var_75_4 = Vector3.New(0, 100, 0)

				var_75_0.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1084ui_story, var_75_4, var_75_3)

				local var_75_5 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_5.x, var_75_5.y, var_75_5.z)

				local var_75_6 = var_75_0.localEulerAngles

				var_75_6.z = 0
				var_75_6.x = 0
				var_75_0.localEulerAngles = var_75_6
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 then
				var_75_0.localPosition = Vector3.New(0, 100, 0)

				local var_75_7 = manager.ui.mainCamera.transform.position - var_75_0.position

				var_75_0.forward = Vector3.New(var_75_7.x, var_75_7.y, var_75_7.z)

				local var_75_8 = var_75_0.localEulerAngles

				var_75_8.z = 0
				var_75_8.x = 0
				var_75_0.localEulerAngles = var_75_8
			end

			local var_75_9 = 0
			local var_75_10 = 1

			if var_75_9 < arg_72_1.time_ and arg_72_1.time_ <= var_75_9 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, false)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_11 = arg_72_1:GetWordFromCfg(116091017)
				local var_75_12 = arg_72_1:FormatText(var_75_11.content)

				arg_72_1.text_.text = var_75_12

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_13 = 40
				local var_75_14 = utf8.len(var_75_12)
				local var_75_15 = var_75_13 <= 0 and var_75_10 or var_75_10 * (var_75_14 / var_75_13)

				if var_75_15 > 0 and var_75_10 < var_75_15 then
					arg_72_1.talkMaxDuration = var_75_15

					if var_75_15 + var_75_9 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_15 + var_75_9
					end
				end

				arg_72_1.text_.text = var_75_12
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_16 = math.max(var_75_10, arg_72_1.talkMaxDuration)

			if var_75_9 <= arg_72_1.time_ and arg_72_1.time_ < var_75_9 + var_75_16 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_9) / var_75_16

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_9 + var_75_16 and arg_72_1.time_ < var_75_9 + var_75_16 + arg_75_0 then
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
			local var_79_0 = 0
			local var_79_1 = 0.3

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_2 = arg_76_1:FormatText(StoryNameCfg[7].name)

				arg_76_1.leftNameTxt_.text = var_79_2

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

				local var_79_3 = arg_76_1:GetWordFromCfg(116091018)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 13
				local var_79_6 = utf8.len(var_79_4)
				local var_79_7 = var_79_5 <= 0 and var_79_1 or var_79_1 * (var_79_6 / var_79_5)

				if var_79_7 > 0 and var_79_1 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_8 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_8 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_8

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_8 and arg_76_1.time_ < var_79_0 + var_79_8 + arg_79_0 then
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
			local var_83_0 = 0
			local var_83_1 = 1

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				local var_83_2 = "play"
				local var_83_3 = "effect"

				arg_80_1:AudioAction(var_83_2, var_83_3, "se_story_side_1026", "se_story_1026_alert", "")
			end

			local var_83_4 = 0
			local var_83_5 = 0.075

			if var_83_4 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_6 = arg_80_1:GetWordFromCfg(116091019)
				local var_83_7 = arg_80_1:FormatText(var_83_6.content)

				arg_80_1.text_.text = var_83_7

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_8 = 3
				local var_83_9 = utf8.len(var_83_7)
				local var_83_10 = var_83_8 <= 0 and var_83_5 or var_83_5 * (var_83_9 / var_83_8)

				if var_83_10 > 0 and var_83_5 < var_83_10 then
					arg_80_1.talkMaxDuration = var_83_10

					if var_83_10 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_4
					end
				end

				arg_80_1.text_.text = var_83_7
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_11 = math.max(var_83_5, arg_80_1.talkMaxDuration)

			if var_83_4 <= arg_80_1.time_ and arg_80_1.time_ < var_83_4 + var_83_11 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_4) / var_83_11

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_4 + var_83_11 and arg_80_1.time_ < var_83_4 + var_83_11 + arg_83_0 then
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
			local var_87_0 = 0
			local var_87_1 = 0.35

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_2 = arg_84_1:GetWordFromCfg(116091020)
				local var_87_3 = arg_84_1:FormatText(var_87_2.content)

				arg_84_1.text_.text = var_87_3

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 14
				local var_87_5 = utf8.len(var_87_3)
				local var_87_6 = var_87_4 <= 0 and var_87_1 or var_87_1 * (var_87_5 / var_87_4)

				if var_87_6 > 0 and var_87_1 < var_87_6 then
					arg_84_1.talkMaxDuration = var_87_6

					if var_87_6 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_6 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_3
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_7 and arg_84_1.time_ < var_87_0 + var_87_7 + arg_87_0 then
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
			local var_91_0 = arg_88_1.actors_["1084ui_story"].transform
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.var_.moveOldPos1084ui_story = var_91_0.localPosition
			end

			local var_91_2 = 0.001

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2
				local var_91_4 = Vector3.New(0, -0.97, -6)

				var_91_0.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1084ui_story, var_91_4, var_91_3)

				local var_91_5 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_5.x, var_91_5.y, var_91_5.z)

				local var_91_6 = var_91_0.localEulerAngles

				var_91_6.z = 0
				var_91_6.x = 0
				var_91_0.localEulerAngles = var_91_6
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 then
				var_91_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_91_7 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_7.x, var_91_7.y, var_91_7.z)

				local var_91_8 = var_91_0.localEulerAngles

				var_91_8.z = 0
				var_91_8.x = 0
				var_91_0.localEulerAngles = var_91_8
			end

			local var_91_9 = arg_88_1.actors_["1084ui_story"]
			local var_91_10 = 0

			if var_91_10 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 and not isNil(var_91_9) and arg_88_1.var_.characterEffect1084ui_story == nil then
				arg_88_1.var_.characterEffect1084ui_story = var_91_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_11 = 0.2

			if var_91_10 <= arg_88_1.time_ and arg_88_1.time_ < var_91_10 + var_91_11 and not isNil(var_91_9) then
				local var_91_12 = (arg_88_1.time_ - var_91_10) / var_91_11

				if arg_88_1.var_.characterEffect1084ui_story and not isNil(var_91_9) then
					arg_88_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_10 + var_91_11 and arg_88_1.time_ < var_91_10 + var_91_11 + arg_91_0 and not isNil(var_91_9) and arg_88_1.var_.characterEffect1084ui_story then
				arg_88_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_91_13 = 0

			if var_91_13 < arg_88_1.time_ and arg_88_1.time_ <= var_91_13 + arg_91_0 then
				arg_88_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_91_14 = 0

			if var_91_14 < arg_88_1.time_ and arg_88_1.time_ <= var_91_14 + arg_91_0 then
				arg_88_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_91_15 = 0
			local var_91_16 = 0.525

			if var_91_15 < arg_88_1.time_ and arg_88_1.time_ <= var_91_15 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_17 = arg_88_1:FormatText(StoryNameCfg[6].name)

				arg_88_1.leftNameTxt_.text = var_91_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_18 = arg_88_1:GetWordFromCfg(116091021)
				local var_91_19 = arg_88_1:FormatText(var_91_18.content)

				arg_88_1.text_.text = var_91_19

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_20 = 21
				local var_91_21 = utf8.len(var_91_19)
				local var_91_22 = var_91_20 <= 0 and var_91_16 or var_91_16 * (var_91_21 / var_91_20)

				if var_91_22 > 0 and var_91_16 < var_91_22 then
					arg_88_1.talkMaxDuration = var_91_22

					if var_91_22 + var_91_15 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_22 + var_91_15
					end
				end

				arg_88_1.text_.text = var_91_19
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091021", "story_v_out_116091.awb") ~= 0 then
					local var_91_23 = manager.audio:GetVoiceLength("story_v_out_116091", "116091021", "story_v_out_116091.awb") / 1000

					if var_91_23 + var_91_15 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_23 + var_91_15
					end

					if var_91_18.prefab_name ~= "" and arg_88_1.actors_[var_91_18.prefab_name] ~= nil then
						local var_91_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_18.prefab_name].transform, "story_v_out_116091", "116091021", "story_v_out_116091.awb")

						arg_88_1:RecordAudio("116091021", var_91_24)
						arg_88_1:RecordAudio("116091021", var_91_24)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_116091", "116091021", "story_v_out_116091.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_116091", "116091021", "story_v_out_116091.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_25 = math.max(var_91_16, arg_88_1.talkMaxDuration)

			if var_91_15 <= arg_88_1.time_ and arg_88_1.time_ < var_91_15 + var_91_25 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_15) / var_91_25

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_15 + var_91_25 and arg_88_1.time_ < var_91_15 + var_91_25 + arg_91_0 then
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
			local var_95_0 = arg_92_1.actors_["1084ui_story"].transform
			local var_95_1 = 1.466

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos1084ui_story = var_95_0.localPosition
			end

			local var_95_2 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2
				local var_95_4 = Vector3.New(0, 100, 0)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1084ui_story, var_95_4, var_95_3)

				local var_95_5 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_5.x, var_95_5.y, var_95_5.z)

				local var_95_6 = var_95_0.localEulerAngles

				var_95_6.z = 0
				var_95_6.x = 0
				var_95_0.localEulerAngles = var_95_6
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(0, 100, 0)

				local var_95_7 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_7.x, var_95_7.y, var_95_7.z)

				local var_95_8 = var_95_0.localEulerAngles

				var_95_8.z = 0
				var_95_8.x = 0
				var_95_0.localEulerAngles = var_95_8
			end

			local var_95_9 = manager.ui.mainCamera.transform
			local var_95_10 = 3

			if var_95_10 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 then
				arg_92_1.var_.shakeOldPos = var_95_9.localPosition
			end

			local var_95_11 = 0.333333333333333

			if var_95_10 <= arg_92_1.time_ and arg_92_1.time_ < var_95_10 + var_95_11 then
				local var_95_12 = (arg_92_1.time_ - var_95_10) / 0.066
				local var_95_13, var_95_14 = math.modf(var_95_12)

				var_95_9.localPosition = Vector3.New(var_95_14 * 0.13, var_95_14 * 0.13, var_95_14 * 0.13) + arg_92_1.var_.shakeOldPos
			end

			if arg_92_1.time_ >= var_95_10 + var_95_11 and arg_92_1.time_ < var_95_10 + var_95_11 + arg_95_0 then
				var_95_9.localPosition = arg_92_1.var_.shakeOldPos
			end

			local var_95_15 = 3
			local var_95_16 = 1

			if var_95_15 < arg_92_1.time_ and arg_92_1.time_ <= var_95_15 + arg_95_0 then
				local var_95_17 = "play"
				local var_95_18 = "effect"

				arg_92_1:AudioAction(var_95_17, var_95_18, "se_story_16", "se_story_16_foot02", "")
			end

			local var_95_19 = 0

			if var_95_19 < arg_92_1.time_ and arg_92_1.time_ <= var_95_19 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_20 = 1.5

			if var_95_19 <= arg_92_1.time_ and arg_92_1.time_ < var_95_19 + var_95_20 then
				local var_95_21 = (arg_92_1.time_ - var_95_19) / var_95_20
				local var_95_22 = Color.New(0, 0, 0)

				var_95_22.a = Mathf.Lerp(0, 1, var_95_21)
				arg_92_1.mask_.color = var_95_22
			end

			if arg_92_1.time_ >= var_95_19 + var_95_20 and arg_92_1.time_ < var_95_19 + var_95_20 + arg_95_0 then
				local var_95_23 = Color.New(0, 0, 0)

				var_95_23.a = 1
				arg_92_1.mask_.color = var_95_23
			end

			local var_95_24 = 1.5

			if var_95_24 < arg_92_1.time_ and arg_92_1.time_ <= var_95_24 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_25 = 1.5

			if var_95_24 <= arg_92_1.time_ and arg_92_1.time_ < var_95_24 + var_95_25 then
				local var_95_26 = (arg_92_1.time_ - var_95_24) / var_95_25
				local var_95_27 = Color.New(0, 0, 0)

				var_95_27.a = Mathf.Lerp(1, 0, var_95_26)
				arg_92_1.mask_.color = var_95_27
			end

			if arg_92_1.time_ >= var_95_24 + var_95_25 and arg_92_1.time_ < var_95_24 + var_95_25 + arg_95_0 then
				local var_95_28 = Color.New(0, 0, 0)
				local var_95_29 = 0

				arg_92_1.mask_.enabled = false
				var_95_28.a = var_95_29
				arg_92_1.mask_.color = var_95_28
			end

			if arg_92_1.frameCnt_ <= 1 then
				arg_92_1.dialog_:SetActive(false)
			end

			local var_95_30 = 3
			local var_95_31 = 0.2

			if var_95_30 < arg_92_1.time_ and arg_92_1.time_ <= var_95_30 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0

				arg_92_1.dialog_:SetActive(true)

				arg_92_1.dialogCg_.alpha = 0

				local var_95_32 = LeanTween.value(arg_92_1.dialog_, 0, 1, 0.3)

				var_95_32:setOnUpdate(LuaHelper.FloatAction(function(arg_96_0)
					arg_92_1.dialogCg_.alpha = arg_96_0
				end))
				var_95_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_92_1.dialog_)
					var_95_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_92_1.duration_ = arg_92_1.duration_ + 0.3

				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_33 = arg_92_1:GetWordFromCfg(116091022)
				local var_95_34 = arg_92_1:FormatText(var_95_33.content)

				arg_92_1.text_.text = var_95_34

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_35 = 8
				local var_95_36 = utf8.len(var_95_34)
				local var_95_37 = var_95_35 <= 0 and var_95_31 or var_95_31 * (var_95_36 / var_95_35)

				if var_95_37 > 0 and var_95_31 < var_95_37 then
					arg_92_1.talkMaxDuration = var_95_37
					var_95_30 = var_95_30 + 0.3

					if var_95_37 + var_95_30 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_37 + var_95_30
					end
				end

				arg_92_1.text_.text = var_95_34
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_38 = var_95_30 + 0.3
			local var_95_39 = math.max(var_95_31, arg_92_1.talkMaxDuration)

			if var_95_38 <= arg_92_1.time_ and arg_92_1.time_ < var_95_38 + var_95_39 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_38) / var_95_39

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_38 + var_95_39 and arg_92_1.time_ < var_95_38 + var_95_39 + arg_95_0 then
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
			local var_101_0 = 0
			local var_101_1 = 0.95

			if var_101_0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_2 = arg_98_1:GetWordFromCfg(116091023)
				local var_101_3 = arg_98_1:FormatText(var_101_2.content)

				arg_98_1.text_.text = var_101_3

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 38
				local var_101_5 = utf8.len(var_101_3)
				local var_101_6 = var_101_4 <= 0 and var_101_1 or var_101_1 * (var_101_5 / var_101_4)

				if var_101_6 > 0 and var_101_1 < var_101_6 then
					arg_98_1.talkMaxDuration = var_101_6

					if var_101_6 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_6 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_3
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_7 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_7 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_7

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_7 and arg_98_1.time_ < var_101_0 + var_101_7 + arg_101_0 then
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
			local var_105_0 = 0
			local var_105_1 = 1.175

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_2 = arg_102_1:GetWordFromCfg(116091024)
				local var_105_3 = arg_102_1:FormatText(var_105_2.content)

				arg_102_1.text_.text = var_105_3

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_4 = 47
				local var_105_5 = utf8.len(var_105_3)
				local var_105_6 = var_105_4 <= 0 and var_105_1 or var_105_1 * (var_105_5 / var_105_4)

				if var_105_6 > 0 and var_105_1 < var_105_6 then
					arg_102_1.talkMaxDuration = var_105_6

					if var_105_6 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_6 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_3
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_7 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_7 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_7

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_7 and arg_102_1.time_ < var_105_0 + var_105_7 + arg_105_0 then
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
			local var_109_0 = 0
			local var_109_1 = 0.2

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_2 = arg_106_1:FormatText(StoryNameCfg[6].name)

				arg_106_1.leftNameTxt_.text = var_109_2

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

				local var_109_3 = arg_106_1:GetWordFromCfg(116091025)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 8
				local var_109_6 = utf8.len(var_109_4)
				local var_109_7 = var_109_5 <= 0 and var_109_1 or var_109_1 * (var_109_6 / var_109_5)

				if var_109_7 > 0 and var_109_1 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_4
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091025", "story_v_out_116091.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_116091", "116091025", "story_v_out_116091.awb") / 1000

					if var_109_8 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_0
					end

					if var_109_3.prefab_name ~= "" and arg_106_1.actors_[var_109_3.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_3.prefab_name].transform, "story_v_out_116091", "116091025", "story_v_out_116091.awb")

						arg_106_1:RecordAudio("116091025", var_109_9)
						arg_106_1:RecordAudio("116091025", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_116091", "116091025", "story_v_out_116091.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_116091", "116091025", "story_v_out_116091.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_10 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_10 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_10

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_10 and arg_106_1.time_ < var_109_0 + var_109_10 + arg_109_0 then
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
			local var_113_0 = 0
			local var_113_1 = 0.75

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, false)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_2 = arg_110_1:GetWordFromCfg(116091026)
				local var_113_3 = arg_110_1:FormatText(var_113_2.content)

				arg_110_1.text_.text = var_113_3

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 30
				local var_113_5 = utf8.len(var_113_3)
				local var_113_6 = var_113_4 <= 0 and var_113_1 or var_113_1 * (var_113_5 / var_113_4)

				if var_113_6 > 0 and var_113_1 < var_113_6 then
					arg_110_1.talkMaxDuration = var_113_6

					if var_113_6 + var_113_0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_6 + var_113_0
					end
				end

				arg_110_1.text_.text = var_113_3
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_7 = math.max(var_113_1, arg_110_1.talkMaxDuration)

			if var_113_0 <= arg_110_1.time_ and arg_110_1.time_ < var_113_0 + var_113_7 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_0) / var_113_7

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_0 + var_113_7 and arg_110_1.time_ < var_113_0 + var_113_7 + arg_113_0 then
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
			local var_117_0 = 0
			local var_117_1 = 1.325

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_2 = arg_114_1:GetWordFromCfg(116091027)
				local var_117_3 = arg_114_1:FormatText(var_117_2.content)

				arg_114_1.text_.text = var_117_3

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 53
				local var_117_5 = utf8.len(var_117_3)
				local var_117_6 = var_117_4 <= 0 and var_117_1 or var_117_1 * (var_117_5 / var_117_4)

				if var_117_6 > 0 and var_117_1 < var_117_6 then
					arg_114_1.talkMaxDuration = var_117_6

					if var_117_6 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_6 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_3
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_7 and arg_114_1.time_ < var_117_0 + var_117_7 + arg_117_0 then
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
			local var_121_0 = arg_118_1.actors_["1084ui_story"].transform
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.var_.moveOldPos1084ui_story = var_121_0.localPosition
			end

			local var_121_2 = 0.001

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2
				local var_121_4 = Vector3.New(0, -0.97, -6)

				var_121_0.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1084ui_story, var_121_4, var_121_3)

				local var_121_5 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_5.x, var_121_5.y, var_121_5.z)

				local var_121_6 = var_121_0.localEulerAngles

				var_121_6.z = 0
				var_121_6.x = 0
				var_121_0.localEulerAngles = var_121_6
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 then
				var_121_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_121_7 = manager.ui.mainCamera.transform.position - var_121_0.position

				var_121_0.forward = Vector3.New(var_121_7.x, var_121_7.y, var_121_7.z)

				local var_121_8 = var_121_0.localEulerAngles

				var_121_8.z = 0
				var_121_8.x = 0
				var_121_0.localEulerAngles = var_121_8
			end

			local var_121_9 = arg_118_1.actors_["1084ui_story"]
			local var_121_10 = 0

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 and not isNil(var_121_9) and arg_118_1.var_.characterEffect1084ui_story == nil then
				arg_118_1.var_.characterEffect1084ui_story = var_121_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_11 = 0.2

			if var_121_10 <= arg_118_1.time_ and arg_118_1.time_ < var_121_10 + var_121_11 and not isNil(var_121_9) then
				local var_121_12 = (arg_118_1.time_ - var_121_10) / var_121_11

				if arg_118_1.var_.characterEffect1084ui_story and not isNil(var_121_9) then
					arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_10 + var_121_11 and arg_118_1.time_ < var_121_10 + var_121_11 + arg_121_0 and not isNil(var_121_9) and arg_118_1.var_.characterEffect1084ui_story then
				arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_121_13 = 0

			if var_121_13 < arg_118_1.time_ and arg_118_1.time_ <= var_121_13 + arg_121_0 then
				arg_118_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_121_14 = 0

			if var_121_14 < arg_118_1.time_ and arg_118_1.time_ <= var_121_14 + arg_121_0 then
				arg_118_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_121_15 = 0
			local var_121_16 = 0.725

			if var_121_15 < arg_118_1.time_ and arg_118_1.time_ <= var_121_15 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_17 = arg_118_1:FormatText(StoryNameCfg[6].name)

				arg_118_1.leftNameTxt_.text = var_121_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_18 = arg_118_1:GetWordFromCfg(116091028)
				local var_121_19 = arg_118_1:FormatText(var_121_18.content)

				arg_118_1.text_.text = var_121_19

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_20 = 29
				local var_121_21 = utf8.len(var_121_19)
				local var_121_22 = var_121_20 <= 0 and var_121_16 or var_121_16 * (var_121_21 / var_121_20)

				if var_121_22 > 0 and var_121_16 < var_121_22 then
					arg_118_1.talkMaxDuration = var_121_22

					if var_121_22 + var_121_15 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_22 + var_121_15
					end
				end

				arg_118_1.text_.text = var_121_19
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091028", "story_v_out_116091.awb") ~= 0 then
					local var_121_23 = manager.audio:GetVoiceLength("story_v_out_116091", "116091028", "story_v_out_116091.awb") / 1000

					if var_121_23 + var_121_15 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_23 + var_121_15
					end

					if var_121_18.prefab_name ~= "" and arg_118_1.actors_[var_121_18.prefab_name] ~= nil then
						local var_121_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_18.prefab_name].transform, "story_v_out_116091", "116091028", "story_v_out_116091.awb")

						arg_118_1:RecordAudio("116091028", var_121_24)
						arg_118_1:RecordAudio("116091028", var_121_24)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_116091", "116091028", "story_v_out_116091.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_116091", "116091028", "story_v_out_116091.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_25 = math.max(var_121_16, arg_118_1.talkMaxDuration)

			if var_121_15 <= arg_118_1.time_ and arg_118_1.time_ < var_121_15 + var_121_25 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_15) / var_121_25

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_15 + var_121_25 and arg_118_1.time_ < var_121_15 + var_121_25 + arg_121_0 then
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
			local var_125_0 = arg_122_1.actors_["1084ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1084ui_story == nil then
				arg_122_1.var_.characterEffect1084ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.2

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect1084ui_story and not isNil(var_125_0) then
					local var_125_4 = Mathf.Lerp(0, 0.5, var_125_3)

					arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1084ui_story.fillRatio = var_125_4
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1084ui_story then
				local var_125_5 = 0.5

				arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1084ui_story.fillRatio = var_125_5
			end

			local var_125_6 = 0
			local var_125_7 = 0.35

			if var_125_6 < arg_122_1.time_ and arg_122_1.time_ <= var_125_6 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_8 = arg_122_1:FormatText(StoryNameCfg[7].name)

				arg_122_1.leftNameTxt_.text = var_125_8

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

				local var_125_9 = arg_122_1:GetWordFromCfg(116091029)
				local var_125_10 = arg_122_1:FormatText(var_125_9.content)

				arg_122_1.text_.text = var_125_10

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_11 = 14
				local var_125_12 = utf8.len(var_125_10)
				local var_125_13 = var_125_11 <= 0 and var_125_7 or var_125_7 * (var_125_12 / var_125_11)

				if var_125_13 > 0 and var_125_7 < var_125_13 then
					arg_122_1.talkMaxDuration = var_125_13

					if var_125_13 + var_125_6 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_13 + var_125_6
					end
				end

				arg_122_1.text_.text = var_125_10
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_14 = math.max(var_125_7, arg_122_1.talkMaxDuration)

			if var_125_6 <= arg_122_1.time_ and arg_122_1.time_ < var_125_6 + var_125_14 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_6) / var_125_14

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_6 + var_125_14 and arg_122_1.time_ < var_125_6 + var_125_14 + arg_125_0 then
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
			local var_129_0 = 0

			if var_129_0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_0 + arg_129_0 then
				arg_126_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action474")
			end

			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_129_2 = 0
			local var_129_3 = 0.425

			if var_129_2 < arg_126_1.time_ and arg_126_1.time_ <= var_129_2 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_4 = arg_126_1:GetWordFromCfg(116091030)
				local var_129_5 = arg_126_1:FormatText(var_129_4.content)

				arg_126_1.text_.text = var_129_5

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_6 = 17
				local var_129_7 = utf8.len(var_129_5)
				local var_129_8 = var_129_6 <= 0 and var_129_3 or var_129_3 * (var_129_7 / var_129_6)

				if var_129_8 > 0 and var_129_3 < var_129_8 then
					arg_126_1.talkMaxDuration = var_129_8

					if var_129_8 + var_129_2 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_8 + var_129_2
					end
				end

				arg_126_1.text_.text = var_129_5
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_9 = math.max(var_129_3, arg_126_1.talkMaxDuration)

			if var_129_2 <= arg_126_1.time_ and arg_126_1.time_ < var_129_2 + var_129_9 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_2) / var_129_9

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_2 + var_129_9 and arg_126_1.time_ < var_129_2 + var_129_9 + arg_129_0 then
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
			local var_133_0 = arg_130_1.actors_["1084ui_story"].transform
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.var_.moveOldPos1084ui_story = var_133_0.localPosition
			end

			local var_133_2 = 0.001

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2
				local var_133_4 = Vector3.New(0, 100, 0)

				var_133_0.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1084ui_story, var_133_4, var_133_3)

				local var_133_5 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_5.x, var_133_5.y, var_133_5.z)

				local var_133_6 = var_133_0.localEulerAngles

				var_133_6.z = 0
				var_133_6.x = 0
				var_133_0.localEulerAngles = var_133_6
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 then
				var_133_0.localPosition = Vector3.New(0, 100, 0)

				local var_133_7 = manager.ui.mainCamera.transform.position - var_133_0.position

				var_133_0.forward = Vector3.New(var_133_7.x, var_133_7.y, var_133_7.z)

				local var_133_8 = var_133_0.localEulerAngles

				var_133_8.z = 0
				var_133_8.x = 0
				var_133_0.localEulerAngles = var_133_8
			end

			local var_133_9 = 0
			local var_133_10 = 1

			if var_133_9 < arg_130_1.time_ and arg_130_1.time_ <= var_133_9 + arg_133_0 then
				local var_133_11 = "play"
				local var_133_12 = "effect"

				arg_130_1:AudioAction(var_133_11, var_133_12, "se_story_16", "se_story_16_di", "")
			end

			local var_133_13 = 0
			local var_133_14 = 1

			if var_133_13 < arg_130_1.time_ and arg_130_1.time_ <= var_133_13 + arg_133_0 then
				local var_133_15 = "play"
				local var_133_16 = "music"

				arg_130_1:AudioAction(var_133_15, var_133_16, "ui_battle", "ui_battle_stopbgm", "")

				local var_133_17 = ""
				local var_133_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_133_18 ~= "" then
					if arg_130_1.bgmTxt_.text ~= var_133_18 and arg_130_1.bgmTxt_.text ~= "" then
						if arg_130_1.bgmTxt2_.text ~= "" then
							arg_130_1.bgmTxt_.text = arg_130_1.bgmTxt2_.text
						end

						arg_130_1.bgmTxt2_.text = var_133_18

						arg_130_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_130_1.bgmTxt_.text = var_133_18
						arg_130_1.bgmTxt2_.text = var_133_18
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

			local var_133_19 = 0
			local var_133_20 = 0.075

			if var_133_19 < arg_130_1.time_ and arg_130_1.time_ <= var_133_19 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_21 = arg_130_1:GetWordFromCfg(116091031)
				local var_133_22 = arg_130_1:FormatText(var_133_21.content)

				arg_130_1.text_.text = var_133_22

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_23 = 3
				local var_133_24 = utf8.len(var_133_22)
				local var_133_25 = var_133_23 <= 0 and var_133_20 or var_133_20 * (var_133_24 / var_133_23)

				if var_133_25 > 0 and var_133_20 < var_133_25 then
					arg_130_1.talkMaxDuration = var_133_25

					if var_133_25 + var_133_19 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_25 + var_133_19
					end
				end

				arg_130_1.text_.text = var_133_22
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_26 = math.max(var_133_20, arg_130_1.talkMaxDuration)

			if var_133_19 <= arg_130_1.time_ and arg_130_1.time_ < var_133_19 + var_133_26 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_19) / var_133_26

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_19 + var_133_26 and arg_130_1.time_ < var_133_19 + var_133_26 + arg_133_0 then
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
			local var_138_0 = 0
			local var_138_1 = 1.625

			if var_138_0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_2 = arg_135_1:GetWordFromCfg(116091032)
				local var_138_3 = arg_135_1:FormatText(var_138_2.content)

				arg_135_1.text_.text = var_138_3

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 65
				local var_138_5 = utf8.len(var_138_3)
				local var_138_6 = var_138_4 <= 0 and var_138_1 or var_138_1 * (var_138_5 / var_138_4)

				if var_138_6 > 0 and var_138_1 < var_138_6 then
					arg_135_1.talkMaxDuration = var_138_6

					if var_138_6 + var_138_0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_6 + var_138_0
					end
				end

				arg_135_1.text_.text = var_138_3
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_1, arg_135_1.talkMaxDuration)

			if var_138_0 <= arg_135_1.time_ and arg_135_1.time_ < var_138_0 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_0) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_0 + var_138_7 and arg_135_1.time_ < var_138_0 + var_138_7 + arg_138_0 then
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
			local var_142_0 = arg_139_1.actors_["1084ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos1084ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(0, -0.97, -6)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1084ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = arg_139_1.actors_["1084ui_story"]
			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1084ui_story == nil then
				arg_139_1.var_.characterEffect1084ui_story = var_142_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.2

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_11 and not isNil(var_142_9) then
				local var_142_12 = (arg_139_1.time_ - var_142_10) / var_142_11

				if arg_139_1.var_.characterEffect1084ui_story and not isNil(var_142_9) then
					arg_139_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1084ui_story then
				arg_139_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_142_13 = 0

			if var_142_13 < arg_139_1.time_ and arg_139_1.time_ <= var_142_13 + arg_142_0 then
				arg_139_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_142_14 = 0

			if var_142_14 < arg_139_1.time_ and arg_139_1.time_ <= var_142_14 + arg_142_0 then
				arg_139_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_142_15 = 0
			local var_142_16 = 0.2

			if var_142_15 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_17 = arg_139_1:FormatText(StoryNameCfg[6].name)

				arg_139_1.leftNameTxt_.text = var_142_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_18 = arg_139_1:GetWordFromCfg(116091033)
				local var_142_19 = arg_139_1:FormatText(var_142_18.content)

				arg_139_1.text_.text = var_142_19

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_20 = 8
				local var_142_21 = utf8.len(var_142_19)
				local var_142_22 = var_142_20 <= 0 and var_142_16 or var_142_16 * (var_142_21 / var_142_20)

				if var_142_22 > 0 and var_142_16 < var_142_22 then
					arg_139_1.talkMaxDuration = var_142_22

					if var_142_22 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_22 + var_142_15
					end
				end

				arg_139_1.text_.text = var_142_19
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091033", "story_v_out_116091.awb") ~= 0 then
					local var_142_23 = manager.audio:GetVoiceLength("story_v_out_116091", "116091033", "story_v_out_116091.awb") / 1000

					if var_142_23 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_23 + var_142_15
					end

					if var_142_18.prefab_name ~= "" and arg_139_1.actors_[var_142_18.prefab_name] ~= nil then
						local var_142_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_18.prefab_name].transform, "story_v_out_116091", "116091033", "story_v_out_116091.awb")

						arg_139_1:RecordAudio("116091033", var_142_24)
						arg_139_1:RecordAudio("116091033", var_142_24)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_116091", "116091033", "story_v_out_116091.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_116091", "116091033", "story_v_out_116091.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_25 = math.max(var_142_16, arg_139_1.talkMaxDuration)

			if var_142_15 <= arg_139_1.time_ and arg_139_1.time_ < var_142_15 + var_142_25 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_15) / var_142_25

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_15 + var_142_25 and arg_139_1.time_ < var_142_15 + var_142_25 + arg_142_0 then
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
			local var_146_0 = arg_143_1.actors_["1084ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1084ui_story == nil then
				arg_143_1.var_.characterEffect1084ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.2

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect1084ui_story and not isNil(var_146_0) then
					local var_146_4 = Mathf.Lerp(0, 0.5, var_146_3)

					arg_143_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1084ui_story.fillRatio = var_146_4
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1084ui_story then
				local var_146_5 = 0.5

				arg_143_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1084ui_story.fillRatio = var_146_5
			end

			local var_146_6 = 0
			local var_146_7 = 0.225

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				local var_146_8 = "play"
				local var_146_9 = "music"

				arg_143_1:AudioAction(var_146_8, var_146_9, "ui_battle", "ui_battle_stopbgm", "")

				local var_146_10 = ""
				local var_146_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_146_11 ~= "" then
					if arg_143_1.bgmTxt_.text ~= var_146_11 and arg_143_1.bgmTxt_.text ~= "" then
						if arg_143_1.bgmTxt2_.text ~= "" then
							arg_143_1.bgmTxt_.text = arg_143_1.bgmTxt2_.text
						end

						arg_143_1.bgmTxt2_.text = var_146_11

						arg_143_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_143_1.bgmTxt_.text = var_146_11
						arg_143_1.bgmTxt2_.text = var_146_11
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

			local var_146_12 = 0.366666666666667
			local var_146_13 = 0.633333333333333

			if var_146_12 < arg_143_1.time_ and arg_143_1.time_ <= var_146_12 + arg_146_0 then
				local var_146_14 = "play"
				local var_146_15 = "music"

				arg_143_1:AudioAction(var_146_14, var_146_15, "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense.awb")

				local var_146_16 = ""
				local var_146_17 = manager.audio:GetAudioName("bgm_activity_1_6_story_intense", "bgm_activity_1_6_story_intense")

				if var_146_17 ~= "" then
					if arg_143_1.bgmTxt_.text ~= var_146_17 and arg_143_1.bgmTxt_.text ~= "" then
						if arg_143_1.bgmTxt2_.text ~= "" then
							arg_143_1.bgmTxt_.text = arg_143_1.bgmTxt2_.text
						end

						arg_143_1.bgmTxt2_.text = var_146_17

						arg_143_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_143_1.bgmTxt_.text = var_146_17
						arg_143_1.bgmTxt2_.text = var_146_17
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

			local var_146_18 = 0.566666666666668
			local var_146_19 = 0.433333333333332

			if var_146_18 < arg_143_1.time_ and arg_143_1.time_ <= var_146_18 + arg_146_0 then
				local var_146_20 = "play"
				local var_146_21 = "music"

				arg_143_1:AudioAction(var_146_20, var_146_21, "bgm_activity_1_6_story_intense", "OG", "bgm_activity_1_6_story_intense.awb")

				local var_146_22 = ""
				local var_146_23 = manager.audio:GetAudioName("bgm_activity_1_6_story_intense", "OG")

				if var_146_23 ~= "" then
					if arg_143_1.bgmTxt_.text ~= var_146_23 and arg_143_1.bgmTxt_.text ~= "" then
						if arg_143_1.bgmTxt2_.text ~= "" then
							arg_143_1.bgmTxt_.text = arg_143_1.bgmTxt2_.text
						end

						arg_143_1.bgmTxt2_.text = var_146_23

						arg_143_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_143_1.bgmTxt_.text = var_146_23
						arg_143_1.bgmTxt2_.text = var_146_23
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

			local var_146_24 = 0
			local var_146_25 = 0.225

			if var_146_24 < arg_143_1.time_ and arg_143_1.time_ <= var_146_24 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_26 = arg_143_1:FormatText(StoryNameCfg[7].name)

				arg_143_1.leftNameTxt_.text = var_146_26

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

				local var_146_27 = arg_143_1:GetWordFromCfg(116091034)
				local var_146_28 = arg_143_1:FormatText(var_146_27.content)

				arg_143_1.text_.text = var_146_28

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_29 = 9
				local var_146_30 = utf8.len(var_146_28)
				local var_146_31 = var_146_29 <= 0 and var_146_25 or var_146_25 * (var_146_30 / var_146_29)

				if var_146_31 > 0 and var_146_25 < var_146_31 then
					arg_143_1.talkMaxDuration = var_146_31

					if var_146_31 + var_146_24 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_31 + var_146_24
					end
				end

				arg_143_1.text_.text = var_146_28
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_32 = math.max(var_146_25, arg_143_1.talkMaxDuration)

			if var_146_24 <= arg_143_1.time_ and arg_143_1.time_ < var_146_24 + var_146_32 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_24) / var_146_32

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_24 + var_146_32 and arg_143_1.time_ < var_146_24 + var_146_32 + arg_146_0 then
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
			local var_153_0 = 0

			if var_153_0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_0 + arg_153_0 then
				arg_150_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 then
				arg_150_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_153_2 = arg_150_1.actors_["1084ui_story"].transform
			local var_153_3 = 0

			if var_153_3 < arg_150_1.time_ and arg_150_1.time_ <= var_153_3 + arg_153_0 then
				arg_150_1.var_.moveOldPos1084ui_story = var_153_2.localPosition

				local var_153_4 = "1084ui_story"

				arg_150_1:ShowWeapon(arg_150_1.var_[var_153_4 .. "Animator"].transform, true)
			end

			local var_153_5 = 0.001

			if var_153_3 <= arg_150_1.time_ and arg_150_1.time_ < var_153_3 + var_153_5 then
				local var_153_6 = (arg_150_1.time_ - var_153_3) / var_153_5
				local var_153_7 = Vector3.New(0, -0.97, -6)

				var_153_2.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos1084ui_story, var_153_7, var_153_6)

				local var_153_8 = manager.ui.mainCamera.transform.position - var_153_2.position

				var_153_2.forward = Vector3.New(var_153_8.x, var_153_8.y, var_153_8.z)

				local var_153_9 = var_153_2.localEulerAngles

				var_153_9.z = 0
				var_153_9.x = 0
				var_153_2.localEulerAngles = var_153_9
			end

			if arg_150_1.time_ >= var_153_3 + var_153_5 and arg_150_1.time_ < var_153_3 + var_153_5 + arg_153_0 then
				var_153_2.localPosition = Vector3.New(0, -0.97, -6)

				local var_153_10 = manager.ui.mainCamera.transform.position - var_153_2.position

				var_153_2.forward = Vector3.New(var_153_10.x, var_153_10.y, var_153_10.z)

				local var_153_11 = var_153_2.localEulerAngles

				var_153_11.z = 0
				var_153_11.x = 0
				var_153_2.localEulerAngles = var_153_11
			end

			local var_153_12 = 0
			local var_153_13 = 1.15

			if var_153_12 < arg_150_1.time_ and arg_150_1.time_ <= var_153_12 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_14 = arg_150_1:GetWordFromCfg(116091035)
				local var_153_15 = arg_150_1:FormatText(var_153_14.content)

				arg_150_1.text_.text = var_153_15

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_16 = 46
				local var_153_17 = utf8.len(var_153_15)
				local var_153_18 = var_153_16 <= 0 and var_153_13 or var_153_13 * (var_153_17 / var_153_16)

				if var_153_18 > 0 and var_153_13 < var_153_18 then
					arg_150_1.talkMaxDuration = var_153_18

					if var_153_18 + var_153_12 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_18 + var_153_12
					end
				end

				arg_150_1.text_.text = var_153_15
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_19 = math.max(var_153_13, arg_150_1.talkMaxDuration)

			if var_153_12 <= arg_150_1.time_ and arg_150_1.time_ < var_153_12 + var_153_19 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_12) / var_153_19

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_12 + var_153_19 and arg_150_1.time_ < var_153_12 + var_153_19 + arg_153_0 then
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
			local var_157_0 = "STwhite"

			if arg_154_1.bgs_[var_157_0] == nil then
				local var_157_1 = Object.Instantiate(arg_154_1.paintGo_)

				var_157_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_157_0)
				var_157_1.name = var_157_0
				var_157_1.transform.parent = arg_154_1.stage_.transform
				var_157_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_154_1.bgs_[var_157_0] = var_157_1
			end

			local var_157_2 = 0

			if var_157_2 < arg_154_1.time_ and arg_154_1.time_ <= var_157_2 + arg_157_0 then
				local var_157_3 = manager.ui.mainCamera.transform.localPosition
				local var_157_4 = Vector3.New(0, 0, 10) + Vector3.New(var_157_3.x, var_157_3.y, 0)
				local var_157_5 = arg_154_1.bgs_.STwhite

				var_157_5.transform.localPosition = var_157_4
				var_157_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_157_6 = var_157_5:GetComponent("SpriteRenderer")

				if var_157_6 and var_157_6.sprite then
					local var_157_7 = (var_157_5.transform.localPosition - var_157_3).z
					local var_157_8 = manager.ui.mainCameraCom_
					local var_157_9 = 2 * var_157_7 * Mathf.Tan(var_157_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_157_10 = var_157_9 * var_157_8.aspect
					local var_157_11 = var_157_6.sprite.bounds.size.x
					local var_157_12 = var_157_6.sprite.bounds.size.y
					local var_157_13 = var_157_10 / var_157_11
					local var_157_14 = var_157_9 / var_157_12
					local var_157_15 = var_157_14 < var_157_13 and var_157_13 or var_157_14

					var_157_5.transform.localScale = Vector3.New(var_157_15, var_157_15, 0)
				end

				for iter_157_0, iter_157_1 in pairs(arg_154_1.bgs_) do
					if iter_157_0 ~= "STwhite" then
						iter_157_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_157_16 = 0

			if var_157_16 < arg_154_1.time_ and arg_154_1.time_ <= var_157_16 + arg_157_0 then
				arg_154_1.mask_.enabled = true
				arg_154_1.mask_.raycastTarget = true

				arg_154_1:SetGaussion(false)
			end

			local var_157_17 = 2

			if var_157_16 <= arg_154_1.time_ and arg_154_1.time_ < var_157_16 + var_157_17 then
				local var_157_18 = (arg_154_1.time_ - var_157_16) / var_157_17
				local var_157_19 = Color.New(1, 1, 1)

				var_157_19.a = Mathf.Lerp(1, 0, var_157_18)
				arg_154_1.mask_.color = var_157_19
			end

			if arg_154_1.time_ >= var_157_16 + var_157_17 and arg_154_1.time_ < var_157_16 + var_157_17 + arg_157_0 then
				local var_157_20 = Color.New(1, 1, 1)
				local var_157_21 = 0

				arg_154_1.mask_.enabled = false
				var_157_20.a = var_157_21
				arg_154_1.mask_.color = var_157_20
			end

			local var_157_22 = arg_154_1.bgs_.STwhite.transform
			local var_157_23 = 0

			if var_157_23 < arg_154_1.time_ and arg_154_1.time_ <= var_157_23 + arg_157_0 then
				arg_154_1.var_.moveOldPosSTwhite = var_157_22.localPosition
				var_157_22.localScale = Vector3.New(12, 12, 12)
			end

			local var_157_24 = 0.001

			if var_157_23 <= arg_154_1.time_ and arg_154_1.time_ < var_157_23 + var_157_24 then
				local var_157_25 = (arg_154_1.time_ - var_157_23) / var_157_24
				local var_157_26 = Vector3.New(0, 0, 0)

				var_157_22.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPosSTwhite, var_157_26, var_157_25)
			end

			if arg_154_1.time_ >= var_157_23 + var_157_24 and arg_154_1.time_ < var_157_23 + var_157_24 + arg_157_0 then
				var_157_22.localPosition = Vector3.New(0, 0, 0)
			end

			local var_157_27 = arg_154_1.actors_["1084ui_story"].transform
			local var_157_28 = 0

			if var_157_28 < arg_154_1.time_ and arg_154_1.time_ <= var_157_28 + arg_157_0 then
				arg_154_1.var_.moveOldPos1084ui_story = var_157_27.localPosition
			end

			local var_157_29 = 0.001

			if var_157_28 <= arg_154_1.time_ and arg_154_1.time_ < var_157_28 + var_157_29 then
				local var_157_30 = (arg_154_1.time_ - var_157_28) / var_157_29
				local var_157_31 = Vector3.New(0, 100, 0)

				var_157_27.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos1084ui_story, var_157_31, var_157_30)

				local var_157_32 = manager.ui.mainCamera.transform.position - var_157_27.position

				var_157_27.forward = Vector3.New(var_157_32.x, var_157_32.y, var_157_32.z)

				local var_157_33 = var_157_27.localEulerAngles

				var_157_33.z = 0
				var_157_33.x = 0
				var_157_27.localEulerAngles = var_157_33
			end

			if arg_154_1.time_ >= var_157_28 + var_157_29 and arg_154_1.time_ < var_157_28 + var_157_29 + arg_157_0 then
				var_157_27.localPosition = Vector3.New(0, 100, 0)

				local var_157_34 = manager.ui.mainCamera.transform.position - var_157_27.position

				var_157_27.forward = Vector3.New(var_157_34.x, var_157_34.y, var_157_34.z)

				local var_157_35 = var_157_27.localEulerAngles

				var_157_35.z = 0
				var_157_35.x = 0
				var_157_27.localEulerAngles = var_157_35
			end

			if arg_154_1.frameCnt_ <= 1 then
				arg_154_1.dialog_:SetActive(false)
			end

			local var_157_36 = 2
			local var_157_37 = 0.925

			if var_157_36 < arg_154_1.time_ and arg_154_1.time_ <= var_157_36 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0

				arg_154_1.dialog_:SetActive(true)

				arg_154_1.dialogCg_.alpha = 0

				local var_157_38 = LeanTween.value(arg_154_1.dialog_, 0, 1, 0.3)

				var_157_38:setOnUpdate(LuaHelper.FloatAction(function(arg_158_0)
					arg_154_1.dialogCg_.alpha = arg_158_0
				end))
				var_157_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_154_1.dialog_)
					var_157_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_154_1.duration_ = arg_154_1.duration_ + 0.3

				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_39 = arg_154_1:GetWordFromCfg(116091036)
				local var_157_40 = arg_154_1:FormatText(var_157_39.content)

				arg_154_1.text_.text = var_157_40

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_41 = 37
				local var_157_42 = utf8.len(var_157_40)
				local var_157_43 = var_157_41 <= 0 and var_157_37 or var_157_37 * (var_157_42 / var_157_41)

				if var_157_43 > 0 and var_157_37 < var_157_43 then
					arg_154_1.talkMaxDuration = var_157_43
					var_157_36 = var_157_36 + 0.3

					if var_157_43 + var_157_36 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_43 + var_157_36
					end
				end

				arg_154_1.text_.text = var_157_40
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_44 = var_157_36 + 0.3
			local var_157_45 = math.max(var_157_37, arg_154_1.talkMaxDuration)

			if var_157_44 <= arg_154_1.time_ and arg_154_1.time_ < var_157_44 + var_157_45 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_44) / var_157_45

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_44 + var_157_45 and arg_154_1.time_ < var_157_44 + var_157_45 + arg_157_0 then
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
			local var_163_0 = 0
			local var_163_1 = 0.875

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_2 = arg_160_1:GetWordFromCfg(116091037)
				local var_163_3 = arg_160_1:FormatText(var_163_2.content)

				arg_160_1.text_.text = var_163_3

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_4 = 35
				local var_163_5 = utf8.len(var_163_3)
				local var_163_6 = var_163_4 <= 0 and var_163_1 or var_163_1 * (var_163_5 / var_163_4)

				if var_163_6 > 0 and var_163_1 < var_163_6 then
					arg_160_1.talkMaxDuration = var_163_6

					if var_163_6 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_6 + var_163_0
					end
				end

				arg_160_1.text_.text = var_163_3
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_7 = math.max(var_163_1, arg_160_1.talkMaxDuration)

			if var_163_0 <= arg_160_1.time_ and arg_160_1.time_ < var_163_0 + var_163_7 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_0) / var_163_7

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_0 + var_163_7 and arg_160_1.time_ < var_163_0 + var_163_7 + arg_163_0 then
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
			local var_167_0 = "SK0103"

			if arg_164_1.bgs_[var_167_0] == nil then
				local var_167_1 = Object.Instantiate(arg_164_1.paintGo_)

				var_167_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_167_0)
				var_167_1.name = var_167_0
				var_167_1.transform.parent = arg_164_1.stage_.transform
				var_167_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_164_1.bgs_[var_167_0] = var_167_1
			end

			local var_167_2 = 1

			if var_167_2 < arg_164_1.time_ and arg_164_1.time_ <= var_167_2 + arg_167_0 then
				local var_167_3 = manager.ui.mainCamera.transform.localPosition
				local var_167_4 = Vector3.New(0, 0, 10) + Vector3.New(var_167_3.x, var_167_3.y, 0)
				local var_167_5 = arg_164_1.bgs_.SK0103

				var_167_5.transform.localPosition = var_167_4
				var_167_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_167_6 = var_167_5:GetComponent("SpriteRenderer")

				if var_167_6 and var_167_6.sprite then
					local var_167_7 = (var_167_5.transform.localPosition - var_167_3).z
					local var_167_8 = manager.ui.mainCameraCom_
					local var_167_9 = 2 * var_167_7 * Mathf.Tan(var_167_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_167_10 = var_167_9 * var_167_8.aspect
					local var_167_11 = var_167_6.sprite.bounds.size.x
					local var_167_12 = var_167_6.sprite.bounds.size.y
					local var_167_13 = var_167_10 / var_167_11
					local var_167_14 = var_167_9 / var_167_12
					local var_167_15 = var_167_14 < var_167_13 and var_167_13 or var_167_14

					var_167_5.transform.localScale = Vector3.New(var_167_15, var_167_15, 0)
				end

				for iter_167_0, iter_167_1 in pairs(arg_164_1.bgs_) do
					if iter_167_0 ~= "SK0103" then
						iter_167_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_167_16 = 0

			if var_167_16 < arg_164_1.time_ and arg_164_1.time_ <= var_167_16 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = false

				arg_164_1:SetGaussion(false)
			end

			local var_167_17 = 1

			if var_167_16 <= arg_164_1.time_ and arg_164_1.time_ < var_167_16 + var_167_17 then
				local var_167_18 = (arg_164_1.time_ - var_167_16) / var_167_17
				local var_167_19 = Color.New(1, 1, 1)

				var_167_19.a = Mathf.Lerp(0, 1, var_167_18)
				arg_164_1.mask_.color = var_167_19
			end

			if arg_164_1.time_ >= var_167_16 + var_167_17 and arg_164_1.time_ < var_167_16 + var_167_17 + arg_167_0 then
				local var_167_20 = Color.New(1, 1, 1)

				var_167_20.a = 1
				arg_164_1.mask_.color = var_167_20
			end

			local var_167_21 = 1

			if var_167_21 < arg_164_1.time_ and arg_164_1.time_ <= var_167_21 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = false

				arg_164_1:SetGaussion(false)
			end

			local var_167_22 = 1

			if var_167_21 <= arg_164_1.time_ and arg_164_1.time_ < var_167_21 + var_167_22 then
				local var_167_23 = (arg_164_1.time_ - var_167_21) / var_167_22
				local var_167_24 = Color.New(1, 1, 1)

				var_167_24.a = Mathf.Lerp(1, 0, var_167_23)
				arg_164_1.mask_.color = var_167_24
			end

			if arg_164_1.time_ >= var_167_21 + var_167_22 and arg_164_1.time_ < var_167_21 + var_167_22 + arg_167_0 then
				local var_167_25 = Color.New(1, 1, 1)
				local var_167_26 = 0

				arg_164_1.mask_.enabled = false
				var_167_25.a = var_167_26
				arg_164_1.mask_.color = var_167_25
			end

			local var_167_27 = arg_164_1.actors_["1084ui_story"].transform
			local var_167_28 = 1

			if var_167_28 < arg_164_1.time_ and arg_164_1.time_ <= var_167_28 + arg_167_0 then
				arg_164_1.var_.moveOldPos1084ui_story = var_167_27.localPosition
			end

			local var_167_29 = 0.001

			if var_167_28 <= arg_164_1.time_ and arg_164_1.time_ < var_167_28 + var_167_29 then
				local var_167_30 = (arg_164_1.time_ - var_167_28) / var_167_29
				local var_167_31 = Vector3.New(0, 100, 0)

				var_167_27.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1084ui_story, var_167_31, var_167_30)

				local var_167_32 = manager.ui.mainCamera.transform.position - var_167_27.position

				var_167_27.forward = Vector3.New(var_167_32.x, var_167_32.y, var_167_32.z)

				local var_167_33 = var_167_27.localEulerAngles

				var_167_33.z = 0
				var_167_33.x = 0
				var_167_27.localEulerAngles = var_167_33
			end

			if arg_164_1.time_ >= var_167_28 + var_167_29 and arg_164_1.time_ < var_167_28 + var_167_29 + arg_167_0 then
				var_167_27.localPosition = Vector3.New(0, 100, 0)

				local var_167_34 = manager.ui.mainCamera.transform.position - var_167_27.position

				var_167_27.forward = Vector3.New(var_167_34.x, var_167_34.y, var_167_34.z)

				local var_167_35 = var_167_27.localEulerAngles

				var_167_35.z = 0
				var_167_35.x = 0
				var_167_27.localEulerAngles = var_167_35
			end

			local var_167_36 = arg_164_1.bgs_.SK0103.transform
			local var_167_37 = 1

			if var_167_37 < arg_164_1.time_ and arg_164_1.time_ <= var_167_37 + arg_167_0 then
				arg_164_1.var_.moveOldPosSK0103 = var_167_36.localPosition
			end

			local var_167_38 = 0.001

			if var_167_37 <= arg_164_1.time_ and arg_164_1.time_ < var_167_37 + var_167_38 then
				local var_167_39 = (arg_164_1.time_ - var_167_37) / var_167_38
				local var_167_40 = Vector3.New(1.5, 0.5, 4.2)

				var_167_36.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPosSK0103, var_167_40, var_167_39)
			end

			if arg_164_1.time_ >= var_167_37 + var_167_38 and arg_164_1.time_ < var_167_37 + var_167_38 + arg_167_0 then
				var_167_36.localPosition = Vector3.New(1.5, 0.5, 4.2)
			end

			local var_167_41 = arg_164_1.bgs_.SK0103.transform
			local var_167_42 = 1.034

			if var_167_42 < arg_164_1.time_ and arg_164_1.time_ <= var_167_42 + arg_167_0 then
				arg_164_1.var_.moveOldPosSK0103 = var_167_41.localPosition
			end

			local var_167_43 = 5.5

			if var_167_42 <= arg_164_1.time_ and arg_164_1.time_ < var_167_42 + var_167_43 then
				local var_167_44 = (arg_164_1.time_ - var_167_42) / var_167_43
				local var_167_45 = Vector3.New(1.5, 0, 5.5)

				var_167_41.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPosSK0103, var_167_45, var_167_44)
			end

			if arg_164_1.time_ >= var_167_42 + var_167_43 and arg_164_1.time_ < var_167_42 + var_167_43 + arg_167_0 then
				var_167_41.localPosition = Vector3.New(1.5, 0, 5.5)
			end

			local var_167_46 = 2

			if var_167_46 < arg_164_1.time_ and arg_164_1.time_ <= var_167_46 + arg_167_0 then
				arg_164_1.allBtn_.enabled = false
			end

			local var_167_47 = 4.534

			if arg_164_1.time_ >= var_167_46 + var_167_47 and arg_164_1.time_ < var_167_46 + var_167_47 + arg_167_0 then
				arg_164_1.allBtn_.enabled = true
			end

			if arg_164_1.frameCnt_ <= 1 then
				arg_164_1.dialog_:SetActive(false)
			end

			local var_167_48 = 2
			local var_167_49 = 0.15

			if var_167_48 < arg_164_1.time_ and arg_164_1.time_ <= var_167_48 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0

				arg_164_1.dialog_:SetActive(true)

				arg_164_1.dialogCg_.alpha = 0

				local var_167_50 = LeanTween.value(arg_164_1.dialog_, 0, 1, 0.3)

				var_167_50:setOnUpdate(LuaHelper.FloatAction(function(arg_168_0)
					arg_164_1.dialogCg_.alpha = arg_168_0
				end))
				var_167_50:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_164_1.dialog_)
					var_167_50:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_164_1.duration_ = arg_164_1.duration_ + 0.3

				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_51 = arg_164_1:FormatText(StoryNameCfg[6].name)

				arg_164_1.leftNameTxt_.text = var_167_51

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

				local var_167_52 = arg_164_1:GetWordFromCfg(116091038)
				local var_167_53 = arg_164_1:FormatText(var_167_52.content)

				arg_164_1.text_.text = var_167_53

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_54 = 6
				local var_167_55 = utf8.len(var_167_53)
				local var_167_56 = var_167_54 <= 0 and var_167_49 or var_167_49 * (var_167_55 / var_167_54)

				if var_167_56 > 0 and var_167_49 < var_167_56 then
					arg_164_1.talkMaxDuration = var_167_56
					var_167_48 = var_167_48 + 0.3

					if var_167_56 + var_167_48 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_56 + var_167_48
					end
				end

				arg_164_1.text_.text = var_167_53
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091038", "story_v_out_116091.awb") ~= 0 then
					local var_167_57 = manager.audio:GetVoiceLength("story_v_out_116091", "116091038", "story_v_out_116091.awb") / 1000

					if var_167_57 + var_167_48 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_57 + var_167_48
					end

					if var_167_52.prefab_name ~= "" and arg_164_1.actors_[var_167_52.prefab_name] ~= nil then
						local var_167_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_52.prefab_name].transform, "story_v_out_116091", "116091038", "story_v_out_116091.awb")

						arg_164_1:RecordAudio("116091038", var_167_58)
						arg_164_1:RecordAudio("116091038", var_167_58)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_116091", "116091038", "story_v_out_116091.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_116091", "116091038", "story_v_out_116091.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_59 = var_167_48 + 0.3
			local var_167_60 = math.max(var_167_49, arg_164_1.talkMaxDuration)

			if var_167_59 <= arg_164_1.time_ and arg_164_1.time_ < var_167_59 + var_167_60 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_59) / var_167_60

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_59 + var_167_60 and arg_164_1.time_ < var_167_59 + var_167_60 + arg_167_0 then
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
			local var_173_0 = 0
			local var_173_1 = 0.775

			if var_173_0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_2 = arg_170_1:GetWordFromCfg(116091039)
				local var_173_3 = arg_170_1:FormatText(var_173_2.content)

				arg_170_1.text_.text = var_173_3

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_4 = 31
				local var_173_5 = utf8.len(var_173_3)
				local var_173_6 = var_173_4 <= 0 and var_173_1 or var_173_1 * (var_173_5 / var_173_4)

				if var_173_6 > 0 and var_173_1 < var_173_6 then
					arg_170_1.talkMaxDuration = var_173_6

					if var_173_6 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_6 + var_173_0
					end
				end

				arg_170_1.text_.text = var_173_3
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_7 = math.max(var_173_1, arg_170_1.talkMaxDuration)

			if var_173_0 <= arg_170_1.time_ and arg_170_1.time_ < var_173_0 + var_173_7 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_0) / var_173_7

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_0 + var_173_7 and arg_170_1.time_ < var_173_0 + var_173_7 + arg_173_0 then
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
			local var_177_0 = 0
			local var_177_1 = 1.325

			if var_177_0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, false)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_2 = arg_174_1:GetWordFromCfg(116091040)
				local var_177_3 = arg_174_1:FormatText(var_177_2.content)

				arg_174_1.text_.text = var_177_3

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_4 = 53
				local var_177_5 = utf8.len(var_177_3)
				local var_177_6 = var_177_4 <= 0 and var_177_1 or var_177_1 * (var_177_5 / var_177_4)

				if var_177_6 > 0 and var_177_1 < var_177_6 then
					arg_174_1.talkMaxDuration = var_177_6

					if var_177_6 + var_177_0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_6 + var_177_0
					end
				end

				arg_174_1.text_.text = var_177_3
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_7 = math.max(var_177_1, arg_174_1.talkMaxDuration)

			if var_177_0 <= arg_174_1.time_ and arg_174_1.time_ < var_177_0 + var_177_7 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_0) / var_177_7

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_0 + var_177_7 and arg_174_1.time_ < var_177_0 + var_177_7 + arg_177_0 then
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
			local var_181_0 = 0
			local var_181_1 = 1.1

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_2 = arg_178_1:GetWordFromCfg(116091041)
				local var_181_3 = arg_178_1:FormatText(var_181_2.content)

				arg_178_1.text_.text = var_181_3

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_4 = 44
				local var_181_5 = utf8.len(var_181_3)
				local var_181_6 = var_181_4 <= 0 and var_181_1 or var_181_1 * (var_181_5 / var_181_4)

				if var_181_6 > 0 and var_181_1 < var_181_6 then
					arg_178_1.talkMaxDuration = var_181_6

					if var_181_6 + var_181_0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_6 + var_181_0
					end
				end

				arg_178_1.text_.text = var_181_3
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_7 = math.max(var_181_1, arg_178_1.talkMaxDuration)

			if var_181_0 <= arg_178_1.time_ and arg_178_1.time_ < var_181_0 + var_181_7 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_0) / var_181_7

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_0 + var_181_7 and arg_178_1.time_ < var_181_0 + var_181_7 + arg_181_0 then
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
			local var_185_0 = 0

			if var_185_0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_0 + arg_185_0 then
				arg_182_1.mask_.enabled = true
				arg_182_1.mask_.raycastTarget = true

				arg_182_1:SetGaussion(false)
			end

			local var_185_1 = 2

			if var_185_0 <= arg_182_1.time_ and arg_182_1.time_ < var_185_0 + var_185_1 then
				local var_185_2 = (arg_182_1.time_ - var_185_0) / var_185_1
				local var_185_3 = Color.New(0, 0, 0)

				var_185_3.a = Mathf.Lerp(0, 1, var_185_2)
				arg_182_1.mask_.color = var_185_3
			end

			if arg_182_1.time_ >= var_185_0 + var_185_1 and arg_182_1.time_ < var_185_0 + var_185_1 + arg_185_0 then
				local var_185_4 = Color.New(0, 0, 0)

				var_185_4.a = 1
				arg_182_1.mask_.color = var_185_4
			end

			local var_185_5 = 2

			if var_185_5 < arg_182_1.time_ and arg_182_1.time_ <= var_185_5 + arg_185_0 then
				arg_182_1.mask_.enabled = true
				arg_182_1.mask_.raycastTarget = true

				arg_182_1:SetGaussion(false)
			end

			local var_185_6 = 2

			if var_185_5 <= arg_182_1.time_ and arg_182_1.time_ < var_185_5 + var_185_6 then
				local var_185_7 = (arg_182_1.time_ - var_185_5) / var_185_6
				local var_185_8 = Color.New(0, 0, 0)

				var_185_8.a = Mathf.Lerp(1, 0, var_185_7)
				arg_182_1.mask_.color = var_185_8
			end

			if arg_182_1.time_ >= var_185_5 + var_185_6 and arg_182_1.time_ < var_185_5 + var_185_6 + arg_185_0 then
				local var_185_9 = Color.New(0, 0, 0)
				local var_185_10 = 0

				arg_182_1.mask_.enabled = false
				var_185_9.a = var_185_10
				arg_182_1.mask_.color = var_185_9
			end

			local var_185_11 = arg_182_1.bgs_.SK0103.transform
			local var_185_12 = 2

			if var_185_12 < arg_182_1.time_ and arg_182_1.time_ <= var_185_12 + arg_185_0 then
				arg_182_1.var_.moveOldPosSK0103 = var_185_11.localPosition
			end

			local var_185_13 = 0.001

			if var_185_12 <= arg_182_1.time_ and arg_182_1.time_ < var_185_12 + var_185_13 then
				local var_185_14 = (arg_182_1.time_ - var_185_12) / var_185_13
				local var_185_15 = Vector3.New(0, 1, 9.5)

				var_185_11.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPosSK0103, var_185_15, var_185_14)
			end

			if arg_182_1.time_ >= var_185_12 + var_185_13 and arg_182_1.time_ < var_185_12 + var_185_13 + arg_185_0 then
				var_185_11.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_185_16 = arg_182_1.bgs_.SK0103.transform
			local var_185_17 = 2.034

			if var_185_17 < arg_182_1.time_ and arg_182_1.time_ <= var_185_17 + arg_185_0 then
				arg_182_1.var_.moveOldPosSK0103 = var_185_16.localPosition
			end

			local var_185_18 = 3.5

			if var_185_17 <= arg_182_1.time_ and arg_182_1.time_ < var_185_17 + var_185_18 then
				local var_185_19 = (arg_182_1.time_ - var_185_17) / var_185_18
				local var_185_20 = Vector3.New(0, 1, 10)

				var_185_16.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPosSK0103, var_185_20, var_185_19)
			end

			if arg_182_1.time_ >= var_185_17 + var_185_18 and arg_182_1.time_ < var_185_17 + var_185_18 + arg_185_0 then
				var_185_16.localPosition = Vector3.New(0, 1, 10)
			end

			local var_185_21 = 4

			if var_185_21 < arg_182_1.time_ and arg_182_1.time_ <= var_185_21 + arg_185_0 then
				arg_182_1.allBtn_.enabled = false
			end

			local var_185_22 = 1.534

			if arg_182_1.time_ >= var_185_21 + var_185_22 and arg_182_1.time_ < var_185_21 + var_185_22 + arg_185_0 then
				arg_182_1.allBtn_.enabled = true
			end

			if arg_182_1.frameCnt_ <= 1 then
				arg_182_1.dialog_:SetActive(false)
			end

			local var_185_23 = 4
			local var_185_24 = 0.1

			if var_185_23 < arg_182_1.time_ and arg_182_1.time_ <= var_185_23 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0

				arg_182_1.dialog_:SetActive(true)

				arg_182_1.dialogCg_.alpha = 0

				local var_185_25 = LeanTween.value(arg_182_1.dialog_, 0, 1, 0.3)

				var_185_25:setOnUpdate(LuaHelper.FloatAction(function(arg_186_0)
					arg_182_1.dialogCg_.alpha = arg_186_0
				end))
				var_185_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_182_1.dialog_)
					var_185_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_182_1.duration_ = arg_182_1.duration_ + 0.3

				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_26 = arg_182_1:FormatText(StoryNameCfg[36].name)

				arg_182_1.leftNameTxt_.text = var_185_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_27 = arg_182_1:GetWordFromCfg(116091042)
				local var_185_28 = arg_182_1:FormatText(var_185_27.content)

				arg_182_1.text_.text = var_185_28

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_29 = 4
				local var_185_30 = utf8.len(var_185_28)
				local var_185_31 = var_185_29 <= 0 and var_185_24 or var_185_24 * (var_185_30 / var_185_29)

				if var_185_31 > 0 and var_185_24 < var_185_31 then
					arg_182_1.talkMaxDuration = var_185_31
					var_185_23 = var_185_23 + 0.3

					if var_185_31 + var_185_23 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_31 + var_185_23
					end
				end

				arg_182_1.text_.text = var_185_28
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091042", "story_v_out_116091.awb") ~= 0 then
					local var_185_32 = manager.audio:GetVoiceLength("story_v_out_116091", "116091042", "story_v_out_116091.awb") / 1000

					if var_185_32 + var_185_23 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_32 + var_185_23
					end

					if var_185_27.prefab_name ~= "" and arg_182_1.actors_[var_185_27.prefab_name] ~= nil then
						local var_185_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_27.prefab_name].transform, "story_v_out_116091", "116091042", "story_v_out_116091.awb")

						arg_182_1:RecordAudio("116091042", var_185_33)
						arg_182_1:RecordAudio("116091042", var_185_33)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_116091", "116091042", "story_v_out_116091.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_116091", "116091042", "story_v_out_116091.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_34 = var_185_23 + 0.3
			local var_185_35 = math.max(var_185_24, arg_182_1.talkMaxDuration)

			if var_185_34 <= arg_182_1.time_ and arg_182_1.time_ < var_185_34 + var_185_35 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_34) / var_185_35

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_34 + var_185_35 and arg_182_1.time_ < var_185_34 + var_185_35 + arg_185_0 then
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
			local var_191_0 = 0
			local var_191_1 = 0.875

			if var_191_0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_2 = arg_188_1:GetWordFromCfg(116091043)
				local var_191_3 = arg_188_1:FormatText(var_191_2.content)

				arg_188_1.text_.text = var_191_3

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_4 = 35
				local var_191_5 = utf8.len(var_191_3)
				local var_191_6 = var_191_4 <= 0 and var_191_1 or var_191_1 * (var_191_5 / var_191_4)

				if var_191_6 > 0 and var_191_1 < var_191_6 then
					arg_188_1.talkMaxDuration = var_191_6

					if var_191_6 + var_191_0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_6 + var_191_0
					end
				end

				arg_188_1.text_.text = var_191_3
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_7 = math.max(var_191_1, arg_188_1.talkMaxDuration)

			if var_191_0 <= arg_188_1.time_ and arg_188_1.time_ < var_191_0 + var_191_7 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_0) / var_191_7

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_0 + var_191_7 and arg_188_1.time_ < var_191_0 + var_191_7 + arg_191_0 then
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
			local var_195_0 = 0
			local var_195_1 = 0.125

			if var_195_0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_2 = arg_192_1:FormatText(StoryNameCfg[6].name)

				arg_192_1.leftNameTxt_.text = var_195_2

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

				local var_195_3 = arg_192_1:GetWordFromCfg(116091044)
				local var_195_4 = arg_192_1:FormatText(var_195_3.content)

				arg_192_1.text_.text = var_195_4

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_5 = 5
				local var_195_6 = utf8.len(var_195_4)
				local var_195_7 = var_195_5 <= 0 and var_195_1 or var_195_1 * (var_195_6 / var_195_5)

				if var_195_7 > 0 and var_195_1 < var_195_7 then
					arg_192_1.talkMaxDuration = var_195_7

					if var_195_7 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_7 + var_195_0
					end
				end

				arg_192_1.text_.text = var_195_4
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091044", "story_v_out_116091.awb") ~= 0 then
					local var_195_8 = manager.audio:GetVoiceLength("story_v_out_116091", "116091044", "story_v_out_116091.awb") / 1000

					if var_195_8 + var_195_0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_8 + var_195_0
					end

					if var_195_3.prefab_name ~= "" and arg_192_1.actors_[var_195_3.prefab_name] ~= nil then
						local var_195_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_3.prefab_name].transform, "story_v_out_116091", "116091044", "story_v_out_116091.awb")

						arg_192_1:RecordAudio("116091044", var_195_9)
						arg_192_1:RecordAudio("116091044", var_195_9)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_116091", "116091044", "story_v_out_116091.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_116091", "116091044", "story_v_out_116091.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_10 = math.max(var_195_1, arg_192_1.talkMaxDuration)

			if var_195_0 <= arg_192_1.time_ and arg_192_1.time_ < var_195_0 + var_195_10 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_0) / var_195_10

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_0 + var_195_10 and arg_192_1.time_ < var_195_0 + var_195_10 + arg_195_0 then
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
			local var_199_0 = 0
			local var_199_1 = 0.675

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_2 = arg_196_1:GetWordFromCfg(116091045)
				local var_199_3 = arg_196_1:FormatText(var_199_2.content)

				arg_196_1.text_.text = var_199_3

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_4 = 27
				local var_199_5 = utf8.len(var_199_3)
				local var_199_6 = var_199_4 <= 0 and var_199_1 or var_199_1 * (var_199_5 / var_199_4)

				if var_199_6 > 0 and var_199_1 < var_199_6 then
					arg_196_1.talkMaxDuration = var_199_6

					if var_199_6 + var_199_0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_6 + var_199_0
					end
				end

				arg_196_1.text_.text = var_199_3
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_7 = math.max(var_199_1, arg_196_1.talkMaxDuration)

			if var_199_0 <= arg_196_1.time_ and arg_196_1.time_ < var_199_0 + var_199_7 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_0) / var_199_7

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_0 + var_199_7 and arg_196_1.time_ < var_199_0 + var_199_7 + arg_199_0 then
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
			local var_203_0 = 0
			local var_203_1 = 1.1

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_2 = arg_200_1:GetWordFromCfg(116091046)
				local var_203_3 = arg_200_1:FormatText(var_203_2.content)

				arg_200_1.text_.text = var_203_3

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_4 = 44
				local var_203_5 = utf8.len(var_203_3)
				local var_203_6 = var_203_4 <= 0 and var_203_1 or var_203_1 * (var_203_5 / var_203_4)

				if var_203_6 > 0 and var_203_1 < var_203_6 then
					arg_200_1.talkMaxDuration = var_203_6

					if var_203_6 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_6 + var_203_0
					end
				end

				arg_200_1.text_.text = var_203_3
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_7 = math.max(var_203_1, arg_200_1.talkMaxDuration)

			if var_203_0 <= arg_200_1.time_ and arg_200_1.time_ < var_203_0 + var_203_7 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_0) / var_203_7

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_0 + var_203_7 and arg_200_1.time_ < var_203_0 + var_203_7 + arg_203_0 then
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
			local var_207_0 = 0
			local var_207_1 = 0.275

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_2 = arg_204_1:FormatText(StoryNameCfg[6].name)

				arg_204_1.leftNameTxt_.text = var_207_2

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

				local var_207_3 = arg_204_1:GetWordFromCfg(116091047)
				local var_207_4 = arg_204_1:FormatText(var_207_3.content)

				arg_204_1.text_.text = var_207_4

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_5 = 11
				local var_207_6 = utf8.len(var_207_4)
				local var_207_7 = var_207_5 <= 0 and var_207_1 or var_207_1 * (var_207_6 / var_207_5)

				if var_207_7 > 0 and var_207_1 < var_207_7 then
					arg_204_1.talkMaxDuration = var_207_7

					if var_207_7 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_7 + var_207_0
					end
				end

				arg_204_1.text_.text = var_207_4
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091047", "story_v_out_116091.awb") ~= 0 then
					local var_207_8 = manager.audio:GetVoiceLength("story_v_out_116091", "116091047", "story_v_out_116091.awb") / 1000

					if var_207_8 + var_207_0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_8 + var_207_0
					end

					if var_207_3.prefab_name ~= "" and arg_204_1.actors_[var_207_3.prefab_name] ~= nil then
						local var_207_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_3.prefab_name].transform, "story_v_out_116091", "116091047", "story_v_out_116091.awb")

						arg_204_1:RecordAudio("116091047", var_207_9)
						arg_204_1:RecordAudio("116091047", var_207_9)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_116091", "116091047", "story_v_out_116091.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_116091", "116091047", "story_v_out_116091.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_10 = math.max(var_207_1, arg_204_1.talkMaxDuration)

			if var_207_0 <= arg_204_1.time_ and arg_204_1.time_ < var_207_0 + var_207_10 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_0) / var_207_10

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_0 + var_207_10 and arg_204_1.time_ < var_207_0 + var_207_10 + arg_207_0 then
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
			local var_211_0 = 0
			local var_211_1 = 0.3

			if var_211_0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_2 = arg_208_1:FormatText(StoryNameCfg[13].name)

				arg_208_1.leftNameTxt_.text = var_211_2

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

				local var_211_3 = arg_208_1:GetWordFromCfg(116091048)
				local var_211_4 = arg_208_1:FormatText(var_211_3.content)

				arg_208_1.text_.text = var_211_4

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_5 = 12
				local var_211_6 = utf8.len(var_211_4)
				local var_211_7 = var_211_5 <= 0 and var_211_1 or var_211_1 * (var_211_6 / var_211_5)

				if var_211_7 > 0 and var_211_1 < var_211_7 then
					arg_208_1.talkMaxDuration = var_211_7

					if var_211_7 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_7 + var_211_0
					end
				end

				arg_208_1.text_.text = var_211_4
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091048", "story_v_out_116091.awb") ~= 0 then
					local var_211_8 = manager.audio:GetVoiceLength("story_v_out_116091", "116091048", "story_v_out_116091.awb") / 1000

					if var_211_8 + var_211_0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_8 + var_211_0
					end

					if var_211_3.prefab_name ~= "" and arg_208_1.actors_[var_211_3.prefab_name] ~= nil then
						local var_211_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_3.prefab_name].transform, "story_v_out_116091", "116091048", "story_v_out_116091.awb")

						arg_208_1:RecordAudio("116091048", var_211_9)
						arg_208_1:RecordAudio("116091048", var_211_9)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_116091", "116091048", "story_v_out_116091.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_116091", "116091048", "story_v_out_116091.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_10 = math.max(var_211_1, arg_208_1.talkMaxDuration)

			if var_211_0 <= arg_208_1.time_ and arg_208_1.time_ < var_211_0 + var_211_10 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_0) / var_211_10

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_0 + var_211_10 and arg_208_1.time_ < var_211_0 + var_211_10 + arg_211_0 then
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
			local var_215_0 = 0
			local var_215_1 = 0.7

			if var_215_0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, false)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_2 = arg_212_1:GetWordFromCfg(116091049)
				local var_215_3 = arg_212_1:FormatText(var_215_2.content)

				arg_212_1.text_.text = var_215_3

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_4 = 28
				local var_215_5 = utf8.len(var_215_3)
				local var_215_6 = var_215_4 <= 0 and var_215_1 or var_215_1 * (var_215_5 / var_215_4)

				if var_215_6 > 0 and var_215_1 < var_215_6 then
					arg_212_1.talkMaxDuration = var_215_6

					if var_215_6 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_6 + var_215_0
					end
				end

				arg_212_1.text_.text = var_215_3
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_7 = math.max(var_215_1, arg_212_1.talkMaxDuration)

			if var_215_0 <= arg_212_1.time_ and arg_212_1.time_ < var_215_0 + var_215_7 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_0) / var_215_7

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_0 + var_215_7 and arg_212_1.time_ < var_215_0 + var_215_7 + arg_215_0 then
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
			local var_219_0 = 0
			local var_219_1 = 0.5

			if var_219_0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_2 = arg_216_1:FormatText(StoryNameCfg[6].name)

				arg_216_1.leftNameTxt_.text = var_219_2

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

				local var_219_3 = arg_216_1:GetWordFromCfg(116091050)
				local var_219_4 = arg_216_1:FormatText(var_219_3.content)

				arg_216_1.text_.text = var_219_4

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_5 = 20
				local var_219_6 = utf8.len(var_219_4)
				local var_219_7 = var_219_5 <= 0 and var_219_1 or var_219_1 * (var_219_6 / var_219_5)

				if var_219_7 > 0 and var_219_1 < var_219_7 then
					arg_216_1.talkMaxDuration = var_219_7

					if var_219_7 + var_219_0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_7 + var_219_0
					end
				end

				arg_216_1.text_.text = var_219_4
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091050", "story_v_out_116091.awb") ~= 0 then
					local var_219_8 = manager.audio:GetVoiceLength("story_v_out_116091", "116091050", "story_v_out_116091.awb") / 1000

					if var_219_8 + var_219_0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_8 + var_219_0
					end

					if var_219_3.prefab_name ~= "" and arg_216_1.actors_[var_219_3.prefab_name] ~= nil then
						local var_219_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_3.prefab_name].transform, "story_v_out_116091", "116091050", "story_v_out_116091.awb")

						arg_216_1:RecordAudio("116091050", var_219_9)
						arg_216_1:RecordAudio("116091050", var_219_9)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_116091", "116091050", "story_v_out_116091.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_116091", "116091050", "story_v_out_116091.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_10 = math.max(var_219_1, arg_216_1.talkMaxDuration)

			if var_219_0 <= arg_216_1.time_ and arg_216_1.time_ < var_219_0 + var_219_10 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_0) / var_219_10

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_0 + var_219_10 and arg_216_1.time_ < var_219_0 + var_219_10 + arg_219_0 then
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
			local var_223_0 = 0
			local var_223_1 = 0.85

			if var_223_0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, false)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_2 = arg_220_1:GetWordFromCfg(116091051)
				local var_223_3 = arg_220_1:FormatText(var_223_2.content)

				arg_220_1.text_.text = var_223_3

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_4 = 34
				local var_223_5 = utf8.len(var_223_3)
				local var_223_6 = var_223_4 <= 0 and var_223_1 or var_223_1 * (var_223_5 / var_223_4)

				if var_223_6 > 0 and var_223_1 < var_223_6 then
					arg_220_1.talkMaxDuration = var_223_6

					if var_223_6 + var_223_0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_6 + var_223_0
					end
				end

				arg_220_1.text_.text = var_223_3
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_7 = math.max(var_223_1, arg_220_1.talkMaxDuration)

			if var_223_0 <= arg_220_1.time_ and arg_220_1.time_ < var_223_0 + var_223_7 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_0) / var_223_7

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_0 + var_223_7 and arg_220_1.time_ < var_223_0 + var_223_7 + arg_223_0 then
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
			local var_227_0 = 0
			local var_227_1 = 1.3

			if var_227_0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, false)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_2 = arg_224_1:GetWordFromCfg(116091052)
				local var_227_3 = arg_224_1:FormatText(var_227_2.content)

				arg_224_1.text_.text = var_227_3

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_4 = 52
				local var_227_5 = utf8.len(var_227_3)
				local var_227_6 = var_227_4 <= 0 and var_227_1 or var_227_1 * (var_227_5 / var_227_4)

				if var_227_6 > 0 and var_227_1 < var_227_6 then
					arg_224_1.talkMaxDuration = var_227_6

					if var_227_6 + var_227_0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_6 + var_227_0
					end
				end

				arg_224_1.text_.text = var_227_3
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_7 = math.max(var_227_1, arg_224_1.talkMaxDuration)

			if var_227_0 <= arg_224_1.time_ and arg_224_1.time_ < var_227_0 + var_227_7 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_0) / var_227_7

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_0 + var_227_7 and arg_224_1.time_ < var_227_0 + var_227_7 + arg_227_0 then
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
			local var_231_0 = 0
			local var_231_1 = 0.35

			if var_231_0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_2 = arg_228_1:FormatText(StoryNameCfg[7].name)

				arg_228_1.leftNameTxt_.text = var_231_2

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

				local var_231_3 = arg_228_1:GetWordFromCfg(116091053)
				local var_231_4 = arg_228_1:FormatText(var_231_3.content)

				arg_228_1.text_.text = var_231_4

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_5 = 14
				local var_231_6 = utf8.len(var_231_4)
				local var_231_7 = var_231_5 <= 0 and var_231_1 or var_231_1 * (var_231_6 / var_231_5)

				if var_231_7 > 0 and var_231_1 < var_231_7 then
					arg_228_1.talkMaxDuration = var_231_7

					if var_231_7 + var_231_0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_7 + var_231_0
					end
				end

				arg_228_1.text_.text = var_231_4
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_8 = math.max(var_231_1, arg_228_1.talkMaxDuration)

			if var_231_0 <= arg_228_1.time_ and arg_228_1.time_ < var_231_0 + var_231_8 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_0) / var_231_8

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_0 + var_231_8 and arg_228_1.time_ < var_231_0 + var_231_8 + arg_231_0 then
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
			local var_235_0 = 0
			local var_235_1 = 1.325

			if var_235_0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_2 = arg_232_1:GetWordFromCfg(116091054)
				local var_235_3 = arg_232_1:FormatText(var_235_2.content)

				arg_232_1.text_.text = var_235_3

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_4 = 53
				local var_235_5 = utf8.len(var_235_3)
				local var_235_6 = var_235_4 <= 0 and var_235_1 or var_235_1 * (var_235_5 / var_235_4)

				if var_235_6 > 0 and var_235_1 < var_235_6 then
					arg_232_1.talkMaxDuration = var_235_6

					if var_235_6 + var_235_0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_6 + var_235_0
					end
				end

				arg_232_1.text_.text = var_235_3
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_7 = math.max(var_235_1, arg_232_1.talkMaxDuration)

			if var_235_0 <= arg_232_1.time_ and arg_232_1.time_ < var_235_0 + var_235_7 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_0) / var_235_7

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_0 + var_235_7 and arg_232_1.time_ < var_235_0 + var_235_7 + arg_235_0 then
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
			local var_239_0 = 0
			local var_239_1 = 0.5

			if var_239_0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_2 = arg_236_1:GetWordFromCfg(116091055)
				local var_239_3 = arg_236_1:FormatText(var_239_2.content)

				arg_236_1.text_.text = var_239_3

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_4 = 20
				local var_239_5 = utf8.len(var_239_3)
				local var_239_6 = var_239_4 <= 0 and var_239_1 or var_239_1 * (var_239_5 / var_239_4)

				if var_239_6 > 0 and var_239_1 < var_239_6 then
					arg_236_1.talkMaxDuration = var_239_6

					if var_239_6 + var_239_0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_6 + var_239_0
					end
				end

				arg_236_1.text_.text = var_239_3
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_7 = math.max(var_239_1, arg_236_1.talkMaxDuration)

			if var_239_0 <= arg_236_1.time_ and arg_236_1.time_ < var_239_0 + var_239_7 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_0) / var_239_7

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_0 + var_239_7 and arg_236_1.time_ < var_239_0 + var_239_7 + arg_239_0 then
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
			local var_243_0 = 0
			local var_243_1 = 1.425

			if var_243_0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, false)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_2 = arg_240_1:GetWordFromCfg(116091056)
				local var_243_3 = arg_240_1:FormatText(var_243_2.content)

				arg_240_1.text_.text = var_243_3

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_4 = 57
				local var_243_5 = utf8.len(var_243_3)
				local var_243_6 = var_243_4 <= 0 and var_243_1 or var_243_1 * (var_243_5 / var_243_4)

				if var_243_6 > 0 and var_243_1 < var_243_6 then
					arg_240_1.talkMaxDuration = var_243_6

					if var_243_6 + var_243_0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_6 + var_243_0
					end
				end

				arg_240_1.text_.text = var_243_3
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)
				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_7 = math.max(var_243_1, arg_240_1.talkMaxDuration)

			if var_243_0 <= arg_240_1.time_ and arg_240_1.time_ < var_243_0 + var_243_7 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_0) / var_243_7

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_0 + var_243_7 and arg_240_1.time_ < var_243_0 + var_243_7 + arg_243_0 then
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
			local var_247_0 = 0
			local var_247_1 = 0.2

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_2 = arg_244_1:FormatText(StoryNameCfg[13].name)

				arg_244_1.leftNameTxt_.text = var_247_2

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

				local var_247_3 = arg_244_1:GetWordFromCfg(116091057)
				local var_247_4 = arg_244_1:FormatText(var_247_3.content)

				arg_244_1.text_.text = var_247_4

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_5 = 8
				local var_247_6 = utf8.len(var_247_4)
				local var_247_7 = var_247_5 <= 0 and var_247_1 or var_247_1 * (var_247_6 / var_247_5)

				if var_247_7 > 0 and var_247_1 < var_247_7 then
					arg_244_1.talkMaxDuration = var_247_7

					if var_247_7 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_7 + var_247_0
					end
				end

				arg_244_1.text_.text = var_247_4
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091057", "story_v_out_116091.awb") ~= 0 then
					local var_247_8 = manager.audio:GetVoiceLength("story_v_out_116091", "116091057", "story_v_out_116091.awb") / 1000

					if var_247_8 + var_247_0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_8 + var_247_0
					end

					if var_247_3.prefab_name ~= "" and arg_244_1.actors_[var_247_3.prefab_name] ~= nil then
						local var_247_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_3.prefab_name].transform, "story_v_out_116091", "116091057", "story_v_out_116091.awb")

						arg_244_1:RecordAudio("116091057", var_247_9)
						arg_244_1:RecordAudio("116091057", var_247_9)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_116091", "116091057", "story_v_out_116091.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_116091", "116091057", "story_v_out_116091.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_10 = math.max(var_247_1, arg_244_1.talkMaxDuration)

			if var_247_0 <= arg_244_1.time_ and arg_244_1.time_ < var_247_0 + var_247_10 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_0) / var_247_10

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_0 + var_247_10 and arg_244_1.time_ < var_247_0 + var_247_10 + arg_247_0 then
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
			local var_251_0 = 0
			local var_251_1 = 0.575

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_2 = arg_248_1:GetWordFromCfg(116091058)
				local var_251_3 = arg_248_1:FormatText(var_251_2.content)

				arg_248_1.text_.text = var_251_3

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_4 = 23
				local var_251_5 = utf8.len(var_251_3)
				local var_251_6 = var_251_4 <= 0 and var_251_1 or var_251_1 * (var_251_5 / var_251_4)

				if var_251_6 > 0 and var_251_1 < var_251_6 then
					arg_248_1.talkMaxDuration = var_251_6

					if var_251_6 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_6 + var_251_0
					end
				end

				arg_248_1.text_.text = var_251_3
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_7 = math.max(var_251_1, arg_248_1.talkMaxDuration)

			if var_251_0 <= arg_248_1.time_ and arg_248_1.time_ < var_251_0 + var_251_7 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_0) / var_251_7

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_0 + var_251_7 and arg_248_1.time_ < var_251_0 + var_251_7 + arg_251_0 then
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
			local var_255_0 = 0
			local var_255_1 = 0.1

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_2 = arg_252_1:FormatText(StoryNameCfg[6].name)

				arg_252_1.leftNameTxt_.text = var_255_2

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

				local var_255_3 = arg_252_1:GetWordFromCfg(116091059)
				local var_255_4 = arg_252_1:FormatText(var_255_3.content)

				arg_252_1.text_.text = var_255_4

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_5 = 4
				local var_255_6 = utf8.len(var_255_4)
				local var_255_7 = var_255_5 <= 0 and var_255_1 or var_255_1 * (var_255_6 / var_255_5)

				if var_255_7 > 0 and var_255_1 < var_255_7 then
					arg_252_1.talkMaxDuration = var_255_7

					if var_255_7 + var_255_0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_7 + var_255_0
					end
				end

				arg_252_1.text_.text = var_255_4
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091059", "story_v_out_116091.awb") ~= 0 then
					local var_255_8 = manager.audio:GetVoiceLength("story_v_out_116091", "116091059", "story_v_out_116091.awb") / 1000

					if var_255_8 + var_255_0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_8 + var_255_0
					end

					if var_255_3.prefab_name ~= "" and arg_252_1.actors_[var_255_3.prefab_name] ~= nil then
						local var_255_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_3.prefab_name].transform, "story_v_out_116091", "116091059", "story_v_out_116091.awb")

						arg_252_1:RecordAudio("116091059", var_255_9)
						arg_252_1:RecordAudio("116091059", var_255_9)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_116091", "116091059", "story_v_out_116091.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_116091", "116091059", "story_v_out_116091.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_10 = math.max(var_255_1, arg_252_1.talkMaxDuration)

			if var_255_0 <= arg_252_1.time_ and arg_252_1.time_ < var_255_0 + var_255_10 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_0) / var_255_10

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_0 + var_255_10 and arg_252_1.time_ < var_255_0 + var_255_10 + arg_255_0 then
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
			local var_259_0 = manager.ui.mainCamera.transform
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
				arg_256_1.var_.shakeOldPos = var_259_0.localPosition
			end

			local var_259_2 = 0.6

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / 0.066
				local var_259_4, var_259_5 = math.modf(var_259_3)

				var_259_0.localPosition = Vector3.New(var_259_5 * 0.13, var_259_5 * 0.13, var_259_5 * 0.13) + arg_256_1.var_.shakeOldPos
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 then
				var_259_0.localPosition = arg_256_1.var_.shakeOldPos
			end

			local var_259_6 = 0

			if var_259_6 < arg_256_1.time_ and arg_256_1.time_ <= var_259_6 + arg_259_0 then
				arg_256_1.allBtn_.enabled = false
			end

			local var_259_7 = 0.6

			if arg_256_1.time_ >= var_259_6 + var_259_7 and arg_256_1.time_ < var_259_6 + var_259_7 + arg_259_0 then
				arg_256_1.allBtn_.enabled = true
			end

			local var_259_8 = 0
			local var_259_9 = 0.075

			if var_259_8 < arg_256_1.time_ and arg_256_1.time_ <= var_259_8 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_10 = arg_256_1:FormatText(StoryNameCfg[13].name)

				arg_256_1.leftNameTxt_.text = var_259_10

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

				local var_259_11 = arg_256_1:GetWordFromCfg(116091060)
				local var_259_12 = arg_256_1:FormatText(var_259_11.content)

				arg_256_1.text_.text = var_259_12

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_13 = 3
				local var_259_14 = utf8.len(var_259_12)
				local var_259_15 = var_259_13 <= 0 and var_259_9 or var_259_9 * (var_259_14 / var_259_13)

				if var_259_15 > 0 and var_259_9 < var_259_15 then
					arg_256_1.talkMaxDuration = var_259_15

					if var_259_15 + var_259_8 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_15 + var_259_8
					end
				end

				arg_256_1.text_.text = var_259_12
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091060", "story_v_out_116091.awb") ~= 0 then
					local var_259_16 = manager.audio:GetVoiceLength("story_v_out_116091", "116091060", "story_v_out_116091.awb") / 1000

					if var_259_16 + var_259_8 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_16 + var_259_8
					end

					if var_259_11.prefab_name ~= "" and arg_256_1.actors_[var_259_11.prefab_name] ~= nil then
						local var_259_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_11.prefab_name].transform, "story_v_out_116091", "116091060", "story_v_out_116091.awb")

						arg_256_1:RecordAudio("116091060", var_259_17)
						arg_256_1:RecordAudio("116091060", var_259_17)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_116091", "116091060", "story_v_out_116091.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_116091", "116091060", "story_v_out_116091.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_18 = math.max(var_259_9, arg_256_1.talkMaxDuration)

			if var_259_8 <= arg_256_1.time_ and arg_256_1.time_ < var_259_8 + var_259_18 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_8) / var_259_18

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_8 + var_259_18 and arg_256_1.time_ < var_259_8 + var_259_18 + arg_259_0 then
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
			local var_263_0 = "A00"

			if arg_260_1.bgs_[var_263_0] == nil then
				local var_263_1 = Object.Instantiate(arg_260_1.paintGo_)

				var_263_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_263_0)
				var_263_1.name = var_263_0
				var_263_1.transform.parent = arg_260_1.stage_.transform
				var_263_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_260_1.bgs_[var_263_0] = var_263_1
			end

			local var_263_2 = 2

			if var_263_2 < arg_260_1.time_ and arg_260_1.time_ <= var_263_2 + arg_263_0 then
				local var_263_3 = manager.ui.mainCamera.transform.localPosition
				local var_263_4 = Vector3.New(0, 0, 10) + Vector3.New(var_263_3.x, var_263_3.y, 0)
				local var_263_5 = arg_260_1.bgs_.A00

				var_263_5.transform.localPosition = var_263_4
				var_263_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_263_6 = var_263_5:GetComponent("SpriteRenderer")

				if var_263_6 and var_263_6.sprite then
					local var_263_7 = (var_263_5.transform.localPosition - var_263_3).z
					local var_263_8 = manager.ui.mainCameraCom_
					local var_263_9 = 2 * var_263_7 * Mathf.Tan(var_263_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_263_10 = var_263_9 * var_263_8.aspect
					local var_263_11 = var_263_6.sprite.bounds.size.x
					local var_263_12 = var_263_6.sprite.bounds.size.y
					local var_263_13 = var_263_10 / var_263_11
					local var_263_14 = var_263_9 / var_263_12
					local var_263_15 = var_263_14 < var_263_13 and var_263_13 or var_263_14

					var_263_5.transform.localScale = Vector3.New(var_263_15, var_263_15, 0)
				end

				for iter_263_0, iter_263_1 in pairs(arg_260_1.bgs_) do
					if iter_263_0 ~= "A00" then
						iter_263_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_263_16 = 0

			if var_263_16 < arg_260_1.time_ and arg_260_1.time_ <= var_263_16 + arg_263_0 then
				arg_260_1.mask_.enabled = true
				arg_260_1.mask_.raycastTarget = false

				arg_260_1:SetGaussion(false)
			end

			local var_263_17 = 2

			if var_263_16 <= arg_260_1.time_ and arg_260_1.time_ < var_263_16 + var_263_17 then
				local var_263_18 = (arg_260_1.time_ - var_263_16) / var_263_17
				local var_263_19 = Color.New(0, 0, 0)

				var_263_19.a = Mathf.Lerp(0, 1, var_263_18)
				arg_260_1.mask_.color = var_263_19
			end

			if arg_260_1.time_ >= var_263_16 + var_263_17 and arg_260_1.time_ < var_263_16 + var_263_17 + arg_263_0 then
				local var_263_20 = Color.New(0, 0, 0)

				var_263_20.a = 1
				arg_260_1.mask_.color = var_263_20
			end

			local var_263_21 = 2

			if var_263_21 < arg_260_1.time_ and arg_260_1.time_ <= var_263_21 + arg_263_0 then
				arg_260_1.mask_.enabled = true
				arg_260_1.mask_.raycastTarget = false

				arg_260_1:SetGaussion(false)
			end

			local var_263_22 = 2

			if var_263_21 <= arg_260_1.time_ and arg_260_1.time_ < var_263_21 + var_263_22 then
				local var_263_23 = (arg_260_1.time_ - var_263_21) / var_263_22
				local var_263_24 = Color.New(0, 0, 0)

				var_263_24.a = Mathf.Lerp(1, 0, var_263_23)
				arg_260_1.mask_.color = var_263_24
			end

			if arg_260_1.time_ >= var_263_21 + var_263_22 and arg_260_1.time_ < var_263_21 + var_263_22 + arg_263_0 then
				local var_263_25 = Color.New(0, 0, 0)
				local var_263_26 = 0

				arg_260_1.mask_.enabled = false
				var_263_25.a = var_263_26
				arg_260_1.mask_.color = var_263_25
			end

			if arg_260_1.frameCnt_ <= 1 then
				arg_260_1.dialog_:SetActive(false)
			end

			local var_263_27 = 4
			local var_263_28 = 0.65

			if var_263_27 < arg_260_1.time_ and arg_260_1.time_ <= var_263_27 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0

				arg_260_1.dialog_:SetActive(true)

				arg_260_1.dialogCg_.alpha = 0

				local var_263_29 = LeanTween.value(arg_260_1.dialog_, 0, 1, 0.3)

				var_263_29:setOnUpdate(LuaHelper.FloatAction(function(arg_264_0)
					arg_260_1.dialogCg_.alpha = arg_264_0
				end))
				var_263_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_260_1.dialog_)
					var_263_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_260_1.duration_ = arg_260_1.duration_ + 0.3

				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_30 = arg_260_1:GetWordFromCfg(116091061)
				local var_263_31 = arg_260_1:FormatText(var_263_30.content)

				arg_260_1.text_.text = var_263_31

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_32 = 26
				local var_263_33 = utf8.len(var_263_31)
				local var_263_34 = var_263_32 <= 0 and var_263_28 or var_263_28 * (var_263_33 / var_263_32)

				if var_263_34 > 0 and var_263_28 < var_263_34 then
					arg_260_1.talkMaxDuration = var_263_34
					var_263_27 = var_263_27 + 0.3

					if var_263_34 + var_263_27 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_34 + var_263_27
					end
				end

				arg_260_1.text_.text = var_263_31
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_35 = var_263_27 + 0.3
			local var_263_36 = math.max(var_263_28, arg_260_1.talkMaxDuration)

			if var_263_35 <= arg_260_1.time_ and arg_260_1.time_ < var_263_35 + var_263_36 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_35) / var_263_36

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_35 + var_263_36 and arg_260_1.time_ < var_263_35 + var_263_36 + arg_263_0 then
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
			local var_269_0 = manager.ui.mainCamera.transform
			local var_269_1 = 0

			if var_269_1 < arg_266_1.time_ and arg_266_1.time_ <= var_269_1 + arg_269_0 then
				arg_266_1.var_.shakeOldPos = var_269_0.localPosition
			end

			local var_269_2 = 1

			if var_269_1 <= arg_266_1.time_ and arg_266_1.time_ < var_269_1 + var_269_2 then
				local var_269_3 = (arg_266_1.time_ - var_269_1) / 0.066
				local var_269_4, var_269_5 = math.modf(var_269_3)

				var_269_0.localPosition = Vector3.New(var_269_5 * 0.13, var_269_5 * 0.13, var_269_5 * 0.13) + arg_266_1.var_.shakeOldPos
			end

			if arg_266_1.time_ >= var_269_1 + var_269_2 and arg_266_1.time_ < var_269_1 + var_269_2 + arg_269_0 then
				var_269_0.localPosition = arg_266_1.var_.shakeOldPos
			end

			local var_269_6 = 0
			local var_269_7 = 1

			if var_269_6 < arg_266_1.time_ and arg_266_1.time_ <= var_269_6 + arg_269_0 then
				local var_269_8 = "play"
				local var_269_9 = "effect"

				arg_266_1:AudioAction(var_269_8, var_269_9, "se_story_16", "se_story_16_fight", "")
			end

			local var_269_10 = 0

			if var_269_10 < arg_266_1.time_ and arg_266_1.time_ <= var_269_10 + arg_269_0 then
				arg_266_1.allBtn_.enabled = false
			end

			local var_269_11 = 1

			if arg_266_1.time_ >= var_269_10 + var_269_11 and arg_266_1.time_ < var_269_10 + var_269_11 + arg_269_0 then
				arg_266_1.allBtn_.enabled = true
			end

			local var_269_12 = 0
			local var_269_13 = 1.225

			if var_269_12 < arg_266_1.time_ and arg_266_1.time_ <= var_269_12 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_14 = arg_266_1:GetWordFromCfg(116091062)
				local var_269_15 = arg_266_1:FormatText(var_269_14.content)

				arg_266_1.text_.text = var_269_15

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_16 = 49
				local var_269_17 = utf8.len(var_269_15)
				local var_269_18 = var_269_16 <= 0 and var_269_13 or var_269_13 * (var_269_17 / var_269_16)

				if var_269_18 > 0 and var_269_13 < var_269_18 then
					arg_266_1.talkMaxDuration = var_269_18

					if var_269_18 + var_269_12 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_18 + var_269_12
					end
				end

				arg_266_1.text_.text = var_269_15
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_19 = math.max(var_269_13, arg_266_1.talkMaxDuration)

			if var_269_12 <= arg_266_1.time_ and arg_266_1.time_ < var_269_12 + var_269_19 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_12) / var_269_19

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_12 + var_269_19 and arg_266_1.time_ < var_269_12 + var_269_19 + arg_269_0 then
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
			local var_273_0 = arg_270_1.actors_["1084ui_story"].transform
			local var_273_1 = 0

			if var_273_1 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
				arg_270_1.var_.moveOldPos1084ui_story = var_273_0.localPosition

				local var_273_2 = "1084ui_story"

				arg_270_1:ShowWeapon(arg_270_1.var_[var_273_2 .. "Animator"].transform, true)
			end

			local var_273_3 = 0.001

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_3 then
				local var_273_4 = (arg_270_1.time_ - var_273_1) / var_273_3
				local var_273_5 = Vector3.New(0, -0.97, -6)

				var_273_0.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1084ui_story, var_273_5, var_273_4)

				local var_273_6 = manager.ui.mainCamera.transform.position - var_273_0.position

				var_273_0.forward = Vector3.New(var_273_6.x, var_273_6.y, var_273_6.z)

				local var_273_7 = var_273_0.localEulerAngles

				var_273_7.z = 0
				var_273_7.x = 0
				var_273_0.localEulerAngles = var_273_7
			end

			if arg_270_1.time_ >= var_273_1 + var_273_3 and arg_270_1.time_ < var_273_1 + var_273_3 + arg_273_0 then
				var_273_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_273_8 = manager.ui.mainCamera.transform.position - var_273_0.position

				var_273_0.forward = Vector3.New(var_273_8.x, var_273_8.y, var_273_8.z)

				local var_273_9 = var_273_0.localEulerAngles

				var_273_9.z = 0
				var_273_9.x = 0
				var_273_0.localEulerAngles = var_273_9
			end

			local var_273_10 = arg_270_1.actors_["1084ui_story"]
			local var_273_11 = 0

			if var_273_11 < arg_270_1.time_ and arg_270_1.time_ <= var_273_11 + arg_273_0 and not isNil(var_273_10) and arg_270_1.var_.characterEffect1084ui_story == nil then
				arg_270_1.var_.characterEffect1084ui_story = var_273_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_12 = 0.2

			if var_273_11 <= arg_270_1.time_ and arg_270_1.time_ < var_273_11 + var_273_12 and not isNil(var_273_10) then
				local var_273_13 = (arg_270_1.time_ - var_273_11) / var_273_12

				if arg_270_1.var_.characterEffect1084ui_story and not isNil(var_273_10) then
					arg_270_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= var_273_11 + var_273_12 and arg_270_1.time_ < var_273_11 + var_273_12 + arg_273_0 and not isNil(var_273_10) and arg_270_1.var_.characterEffect1084ui_story then
				arg_270_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_273_14 = 0

			if var_273_14 < arg_270_1.time_ and arg_270_1.time_ <= var_273_14 + arg_273_0 then
				arg_270_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_273_15 = 0

			if var_273_15 < arg_270_1.time_ and arg_270_1.time_ <= var_273_15 + arg_273_0 then
				arg_270_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_273_16 = 0
			local var_273_17 = 0.275

			if var_273_16 < arg_270_1.time_ and arg_270_1.time_ <= var_273_16 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_18 = arg_270_1:FormatText(StoryNameCfg[6].name)

				arg_270_1.leftNameTxt_.text = var_273_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_19 = arg_270_1:GetWordFromCfg(116091063)
				local var_273_20 = arg_270_1:FormatText(var_273_19.content)

				arg_270_1.text_.text = var_273_20

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_21 = 11
				local var_273_22 = utf8.len(var_273_20)
				local var_273_23 = var_273_21 <= 0 and var_273_17 or var_273_17 * (var_273_22 / var_273_21)

				if var_273_23 > 0 and var_273_17 < var_273_23 then
					arg_270_1.talkMaxDuration = var_273_23

					if var_273_23 + var_273_16 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_23 + var_273_16
					end
				end

				arg_270_1.text_.text = var_273_20
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091063", "story_v_out_116091.awb") ~= 0 then
					local var_273_24 = manager.audio:GetVoiceLength("story_v_out_116091", "116091063", "story_v_out_116091.awb") / 1000

					if var_273_24 + var_273_16 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_24 + var_273_16
					end

					if var_273_19.prefab_name ~= "" and arg_270_1.actors_[var_273_19.prefab_name] ~= nil then
						local var_273_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_19.prefab_name].transform, "story_v_out_116091", "116091063", "story_v_out_116091.awb")

						arg_270_1:RecordAudio("116091063", var_273_25)
						arg_270_1:RecordAudio("116091063", var_273_25)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_116091", "116091063", "story_v_out_116091.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_116091", "116091063", "story_v_out_116091.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_26 = math.max(var_273_17, arg_270_1.talkMaxDuration)

			if var_273_16 <= arg_270_1.time_ and arg_270_1.time_ < var_273_16 + var_273_26 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_16) / var_273_26

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_16 + var_273_26 and arg_270_1.time_ < var_273_16 + var_273_26 + arg_273_0 then
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
			local var_277_0 = arg_274_1.actors_["1084ui_story"].transform
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.var_.moveOldPos1084ui_story = var_277_0.localPosition
			end

			local var_277_2 = 0.001

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_2 then
				local var_277_3 = (arg_274_1.time_ - var_277_1) / var_277_2
				local var_277_4 = Vector3.New(0, 100, 0)

				var_277_0.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1084ui_story, var_277_4, var_277_3)

				local var_277_5 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_5.x, var_277_5.y, var_277_5.z)

				local var_277_6 = var_277_0.localEulerAngles

				var_277_6.z = 0
				var_277_6.x = 0
				var_277_0.localEulerAngles = var_277_6
			end

			if arg_274_1.time_ >= var_277_1 + var_277_2 and arg_274_1.time_ < var_277_1 + var_277_2 + arg_277_0 then
				var_277_0.localPosition = Vector3.New(0, 100, 0)

				local var_277_7 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_7.x, var_277_7.y, var_277_7.z)

				local var_277_8 = var_277_0.localEulerAngles

				var_277_8.z = 0
				var_277_8.x = 0
				var_277_0.localEulerAngles = var_277_8
			end

			local var_277_9 = manager.ui.mainCamera.transform
			local var_277_10 = 0.633333333333333

			if var_277_10 < arg_274_1.time_ and arg_274_1.time_ <= var_277_10 + arg_277_0 then
				arg_274_1.var_.shakeOldPos = var_277_9.localPosition
			end

			local var_277_11 = 0.5

			if var_277_10 <= arg_274_1.time_ and arg_274_1.time_ < var_277_10 + var_277_11 then
				local var_277_12 = (arg_274_1.time_ - var_277_10) / 0.066
				local var_277_13, var_277_14 = math.modf(var_277_12)

				var_277_9.localPosition = Vector3.New(var_277_14 * 0.13, var_277_14 * 0.13, var_277_14 * 0.13) + arg_274_1.var_.shakeOldPos
			end

			if arg_274_1.time_ >= var_277_10 + var_277_11 and arg_274_1.time_ < var_277_10 + var_277_11 + arg_277_0 then
				var_277_9.localPosition = arg_274_1.var_.shakeOldPos
			end

			local var_277_15 = 0.633333333333333
			local var_277_16 = 1

			if var_277_15 < arg_274_1.time_ and arg_274_1.time_ <= var_277_15 + arg_277_0 then
				local var_277_17 = "play"
				local var_277_18 = "effect"

				arg_274_1:AudioAction(var_277_17, var_277_18, "se_story_16", "se_story_16_fight02", "")
			end

			local var_277_19 = 0

			if var_277_19 < arg_274_1.time_ and arg_274_1.time_ <= var_277_19 + arg_277_0 then
				arg_274_1.mask_.enabled = true
				arg_274_1.mask_.raycastTarget = true

				arg_274_1:SetGaussion(false)
			end

			local var_277_20 = 1

			if var_277_19 <= arg_274_1.time_ and arg_274_1.time_ < var_277_19 + var_277_20 then
				local var_277_21 = (arg_274_1.time_ - var_277_19) / var_277_20
				local var_277_22 = Color.New(1, 1, 1)

				var_277_22.a = Mathf.Lerp(1, 0, var_277_21)
				arg_274_1.mask_.color = var_277_22
			end

			if arg_274_1.time_ >= var_277_19 + var_277_20 and arg_274_1.time_ < var_277_19 + var_277_20 + arg_277_0 then
				local var_277_23 = Color.New(1, 1, 1)
				local var_277_24 = 0

				arg_274_1.mask_.enabled = false
				var_277_23.a = var_277_24
				arg_274_1.mask_.color = var_277_23
			end

			local var_277_25 = 1

			if var_277_25 < arg_274_1.time_ and arg_274_1.time_ <= var_277_25 + arg_277_0 then
				arg_274_1.allBtn_.enabled = false
			end

			local var_277_26 = 0.633333333333333

			if arg_274_1.time_ >= var_277_25 + var_277_26 and arg_274_1.time_ < var_277_25 + var_277_26 + arg_277_0 then
				arg_274_1.allBtn_.enabled = true
			end

			if arg_274_1.frameCnt_ <= 1 then
				arg_274_1.dialog_:SetActive(false)
			end

			local var_277_27 = 1.13333333333333
			local var_277_28 = 1.15

			if var_277_27 < arg_274_1.time_ and arg_274_1.time_ <= var_277_27 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0

				arg_274_1.dialog_:SetActive(true)

				arg_274_1.dialogCg_.alpha = 0

				local var_277_29 = LeanTween.value(arg_274_1.dialog_, 0, 1, 0.3)

				var_277_29:setOnUpdate(LuaHelper.FloatAction(function(arg_278_0)
					arg_274_1.dialogCg_.alpha = arg_278_0
				end))
				var_277_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_274_1.dialog_)
					var_277_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_274_1.duration_ = arg_274_1.duration_ + 0.3

				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_30 = arg_274_1:GetWordFromCfg(116091064)
				local var_277_31 = arg_274_1:FormatText(var_277_30.content)

				arg_274_1.text_.text = var_277_31

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_32 = 46
				local var_277_33 = utf8.len(var_277_31)
				local var_277_34 = var_277_32 <= 0 and var_277_28 or var_277_28 * (var_277_33 / var_277_32)

				if var_277_34 > 0 and var_277_28 < var_277_34 then
					arg_274_1.talkMaxDuration = var_277_34
					var_277_27 = var_277_27 + 0.3

					if var_277_34 + var_277_27 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_34 + var_277_27
					end
				end

				arg_274_1.text_.text = var_277_31
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_35 = var_277_27 + 0.3
			local var_277_36 = math.max(var_277_28, arg_274_1.talkMaxDuration)

			if var_277_35 <= arg_274_1.time_ and arg_274_1.time_ < var_277_35 + var_277_36 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_35) / var_277_36

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_35 + var_277_36 and arg_274_1.time_ < var_277_35 + var_277_36 + arg_277_0 then
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
			local var_283_0 = 0
			local var_283_1 = 0.1

			if var_283_0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_2 = arg_280_1:FormatText(StoryNameCfg[7].name)

				arg_280_1.leftNameTxt_.text = var_283_2

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

				local var_283_3 = arg_280_1:GetWordFromCfg(116091065)
				local var_283_4 = arg_280_1:FormatText(var_283_3.content)

				arg_280_1.text_.text = var_283_4

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_5 = 4
				local var_283_6 = utf8.len(var_283_4)
				local var_283_7 = var_283_5 <= 0 and var_283_1 or var_283_1 * (var_283_6 / var_283_5)

				if var_283_7 > 0 and var_283_1 < var_283_7 then
					arg_280_1.talkMaxDuration = var_283_7

					if var_283_7 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_0
					end
				end

				arg_280_1.text_.text = var_283_4
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_8 = math.max(var_283_1, arg_280_1.talkMaxDuration)

			if var_283_0 <= arg_280_1.time_ and arg_280_1.time_ < var_283_0 + var_283_8 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_0) / var_283_8

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_0 + var_283_8 and arg_280_1.time_ < var_283_0 + var_283_8 + arg_283_0 then
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
			local var_287_0 = manager.ui.mainCamera.transform
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.var_.shakeOldPos = var_287_0.localPosition
			end

			local var_287_2 = 1

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / 0.066
				local var_287_4, var_287_5 = math.modf(var_287_3)

				var_287_0.localPosition = Vector3.New(var_287_5 * 0.13, var_287_5 * 0.13, var_287_5 * 0.13) + arg_284_1.var_.shakeOldPos
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 then
				var_287_0.localPosition = arg_284_1.var_.shakeOldPos
			end

			local var_287_6 = 0

			if var_287_6 < arg_284_1.time_ and arg_284_1.time_ <= var_287_6 + arg_287_0 then
				arg_284_1.allBtn_.enabled = false
			end

			local var_287_7 = 1

			if arg_284_1.time_ >= var_287_6 + var_287_7 and arg_284_1.time_ < var_287_6 + var_287_7 + arg_287_0 then
				arg_284_1.allBtn_.enabled = true
			end

			if arg_284_1.frameCnt_ <= 1 then
				arg_284_1.dialog_:SetActive(false)
			end

			local var_287_8 = 1
			local var_287_9 = 1.1

			if var_287_8 < arg_284_1.time_ and arg_284_1.time_ <= var_287_8 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0

				arg_284_1.dialog_:SetActive(true)

				arg_284_1.dialogCg_.alpha = 0

				local var_287_10 = LeanTween.value(arg_284_1.dialog_, 0, 1, 0.3)

				var_287_10:setOnUpdate(LuaHelper.FloatAction(function(arg_288_0)
					arg_284_1.dialogCg_.alpha = arg_288_0
				end))
				var_287_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_284_1.dialog_)
					var_287_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_284_1.duration_ = arg_284_1.duration_ + 0.3

				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_11 = arg_284_1:GetWordFromCfg(116091066)
				local var_287_12 = arg_284_1:FormatText(var_287_11.content)

				arg_284_1.text_.text = var_287_12

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_13 = 44
				local var_287_14 = utf8.len(var_287_12)
				local var_287_15 = var_287_13 <= 0 and var_287_9 or var_287_9 * (var_287_14 / var_287_13)

				if var_287_15 > 0 and var_287_9 < var_287_15 then
					arg_284_1.talkMaxDuration = var_287_15
					var_287_8 = var_287_8 + 0.3

					if var_287_15 + var_287_8 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_15 + var_287_8
					end
				end

				arg_284_1.text_.text = var_287_12
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_16 = var_287_8 + 0.3
			local var_287_17 = math.max(var_287_9, arg_284_1.talkMaxDuration)

			if var_287_16 <= arg_284_1.time_ and arg_284_1.time_ < var_287_16 + var_287_17 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_16) / var_287_17

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_16 + var_287_17 and arg_284_1.time_ < var_287_16 + var_287_17 + arg_287_0 then
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
			local var_293_0 = 0
			local var_293_1 = 0.95

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_2 = arg_290_1:GetWordFromCfg(116091067)
				local var_293_3 = arg_290_1:FormatText(var_293_2.content)

				arg_290_1.text_.text = var_293_3

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_4 = 36
				local var_293_5 = utf8.len(var_293_3)
				local var_293_6 = var_293_4 <= 0 and var_293_1 or var_293_1 * (var_293_5 / var_293_4)

				if var_293_6 > 0 and var_293_1 < var_293_6 then
					arg_290_1.talkMaxDuration = var_293_6

					if var_293_6 + var_293_0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_6 + var_293_0
					end
				end

				arg_290_1.text_.text = var_293_3
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_7 = math.max(var_293_1, arg_290_1.talkMaxDuration)

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_7 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_0) / var_293_7

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_0 + var_293_7 and arg_290_1.time_ < var_293_0 + var_293_7 + arg_293_0 then
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
			local var_297_0 = 0
			local var_297_1 = 0.95

			if var_297_0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_2 = arg_294_1:GetWordFromCfg(116091068)
				local var_297_3 = arg_294_1:FormatText(var_297_2.content)

				arg_294_1.text_.text = var_297_3

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_4 = 38
				local var_297_5 = utf8.len(var_297_3)
				local var_297_6 = var_297_4 <= 0 and var_297_1 or var_297_1 * (var_297_5 / var_297_4)

				if var_297_6 > 0 and var_297_1 < var_297_6 then
					arg_294_1.talkMaxDuration = var_297_6

					if var_297_6 + var_297_0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_6 + var_297_0
					end
				end

				arg_294_1.text_.text = var_297_3
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_7 = math.max(var_297_1, arg_294_1.talkMaxDuration)

			if var_297_0 <= arg_294_1.time_ and arg_294_1.time_ < var_297_0 + var_297_7 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_0) / var_297_7

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_0 + var_297_7 and arg_294_1.time_ < var_297_0 + var_297_7 + arg_297_0 then
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
			local var_301_0 = 0
			local var_301_1 = 0.75

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_2 = arg_298_1:GetWordFromCfg(116091069)
				local var_301_3 = arg_298_1:FormatText(var_301_2.content)

				arg_298_1.text_.text = var_301_3

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_4 = 30
				local var_301_5 = utf8.len(var_301_3)
				local var_301_6 = var_301_4 <= 0 and var_301_1 or var_301_1 * (var_301_5 / var_301_4)

				if var_301_6 > 0 and var_301_1 < var_301_6 then
					arg_298_1.talkMaxDuration = var_301_6

					if var_301_6 + var_301_0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_6 + var_301_0
					end
				end

				arg_298_1.text_.text = var_301_3
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_7 = math.max(var_301_1, arg_298_1.talkMaxDuration)

			if var_301_0 <= arg_298_1.time_ and arg_298_1.time_ < var_301_0 + var_301_7 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_0) / var_301_7

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_0 + var_301_7 and arg_298_1.time_ < var_301_0 + var_301_7 + arg_301_0 then
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
			local var_305_0 = "1028ui_story"

			if arg_302_1.actors_[var_305_0] == nil then
				local var_305_1 = Asset.Load("Char/" .. "1028ui_story")

				if not isNil(var_305_1) then
					local var_305_2 = Object.Instantiate(Asset.Load("Char/" .. "1028ui_story"), arg_302_1.stage_.transform)

					var_305_2.name = var_305_0
					var_305_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_302_1.actors_[var_305_0] = var_305_2

					local var_305_3 = var_305_2:GetComponentInChildren(typeof(CharacterEffect))

					var_305_3.enabled = true

					local var_305_4 = GameObjectTools.GetOrAddComponent(var_305_2, typeof(DynamicBoneHelper))

					if var_305_4 then
						var_305_4:EnableDynamicBone(false)
					end

					arg_302_1:ShowWeapon(var_305_3.transform, false)

					arg_302_1.var_[var_305_0 .. "Animator"] = var_305_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_302_1.var_[var_305_0 .. "Animator"].applyRootMotion = true
					arg_302_1.var_[var_305_0 .. "LipSync"] = var_305_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_305_5 = arg_302_1.actors_["1028ui_story"].transform
			local var_305_6 = 0

			if var_305_6 < arg_302_1.time_ and arg_302_1.time_ <= var_305_6 + arg_305_0 then
				arg_302_1.var_.moveOldPos1028ui_story = var_305_5.localPosition

				local var_305_7 = "1028ui_story"

				arg_302_1:ShowWeapon(arg_302_1.var_[var_305_7 .. "Animator"].transform, true)
			end

			local var_305_8 = 0.001

			if var_305_6 <= arg_302_1.time_ and arg_302_1.time_ < var_305_6 + var_305_8 then
				local var_305_9 = (arg_302_1.time_ - var_305_6) / var_305_8
				local var_305_10 = Vector3.New(0, -0.9, -5.9)

				var_305_5.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1028ui_story, var_305_10, var_305_9)

				local var_305_11 = manager.ui.mainCamera.transform.position - var_305_5.position

				var_305_5.forward = Vector3.New(var_305_11.x, var_305_11.y, var_305_11.z)

				local var_305_12 = var_305_5.localEulerAngles

				var_305_12.z = 0
				var_305_12.x = 0
				var_305_5.localEulerAngles = var_305_12
			end

			if arg_302_1.time_ >= var_305_6 + var_305_8 and arg_302_1.time_ < var_305_6 + var_305_8 + arg_305_0 then
				var_305_5.localPosition = Vector3.New(0, -0.9, -5.9)

				local var_305_13 = manager.ui.mainCamera.transform.position - var_305_5.position

				var_305_5.forward = Vector3.New(var_305_13.x, var_305_13.y, var_305_13.z)

				local var_305_14 = var_305_5.localEulerAngles

				var_305_14.z = 0
				var_305_14.x = 0
				var_305_5.localEulerAngles = var_305_14
			end

			local var_305_15 = arg_302_1.actors_["1028ui_story"]
			local var_305_16 = 0

			if var_305_16 < arg_302_1.time_ and arg_302_1.time_ <= var_305_16 + arg_305_0 and not isNil(var_305_15) and arg_302_1.var_.characterEffect1028ui_story == nil then
				arg_302_1.var_.characterEffect1028ui_story = var_305_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_17 = 0.2

			if var_305_16 <= arg_302_1.time_ and arg_302_1.time_ < var_305_16 + var_305_17 and not isNil(var_305_15) then
				local var_305_18 = (arg_302_1.time_ - var_305_16) / var_305_17

				if arg_302_1.var_.characterEffect1028ui_story and not isNil(var_305_15) then
					arg_302_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= var_305_16 + var_305_17 and arg_302_1.time_ < var_305_16 + var_305_17 + arg_305_0 and not isNil(var_305_15) and arg_302_1.var_.characterEffect1028ui_story then
				arg_302_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_305_19 = 0

			if var_305_19 < arg_302_1.time_ and arg_302_1.time_ <= var_305_19 + arg_305_0 then
				arg_302_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action2_1")
			end

			local var_305_20 = 0

			if var_305_20 < arg_302_1.time_ and arg_302_1.time_ <= var_305_20 + arg_305_0 then
				arg_302_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_305_21 = 0
			local var_305_22 = 0.275

			if var_305_21 < arg_302_1.time_ and arg_302_1.time_ <= var_305_21 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				local var_305_23 = arg_302_1:FormatText(StoryNameCfg[327].name)

				arg_302_1.leftNameTxt_.text = var_305_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_24 = arg_302_1:GetWordFromCfg(116091070)
				local var_305_25 = arg_302_1:FormatText(var_305_24.content)

				arg_302_1.text_.text = var_305_25

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_26 = 11
				local var_305_27 = utf8.len(var_305_25)
				local var_305_28 = var_305_26 <= 0 and var_305_22 or var_305_22 * (var_305_27 / var_305_26)

				if var_305_28 > 0 and var_305_22 < var_305_28 then
					arg_302_1.talkMaxDuration = var_305_28

					if var_305_28 + var_305_21 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_28 + var_305_21
					end
				end

				arg_302_1.text_.text = var_305_25
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091070", "story_v_out_116091.awb") ~= 0 then
					local var_305_29 = manager.audio:GetVoiceLength("story_v_out_116091", "116091070", "story_v_out_116091.awb") / 1000

					if var_305_29 + var_305_21 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_29 + var_305_21
					end

					if var_305_24.prefab_name ~= "" and arg_302_1.actors_[var_305_24.prefab_name] ~= nil then
						local var_305_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_24.prefab_name].transform, "story_v_out_116091", "116091070", "story_v_out_116091.awb")

						arg_302_1:RecordAudio("116091070", var_305_30)
						arg_302_1:RecordAudio("116091070", var_305_30)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_116091", "116091070", "story_v_out_116091.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_116091", "116091070", "story_v_out_116091.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_31 = math.max(var_305_22, arg_302_1.talkMaxDuration)

			if var_305_21 <= arg_302_1.time_ and arg_302_1.time_ < var_305_21 + var_305_31 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_21) / var_305_31

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_21 + var_305_31 and arg_302_1.time_ < var_305_21 + var_305_31 + arg_305_0 then
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
			local var_309_0 = arg_306_1.actors_["1028ui_story"]
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect1028ui_story == nil then
				arg_306_1.var_.characterEffect1028ui_story = var_309_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_2 = 0.2

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_2 and not isNil(var_309_0) then
				local var_309_3 = (arg_306_1.time_ - var_309_1) / var_309_2

				if arg_306_1.var_.characterEffect1028ui_story and not isNil(var_309_0) then
					local var_309_4 = Mathf.Lerp(0, 0.5, var_309_3)

					arg_306_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1028ui_story.fillRatio = var_309_4
				end
			end

			if arg_306_1.time_ >= var_309_1 + var_309_2 and arg_306_1.time_ < var_309_1 + var_309_2 + arg_309_0 and not isNil(var_309_0) and arg_306_1.var_.characterEffect1028ui_story then
				local var_309_5 = 0.5

				arg_306_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1028ui_story.fillRatio = var_309_5
			end

			local var_309_6 = 0
			local var_309_7 = 0.15

			if var_309_6 < arg_306_1.time_ and arg_306_1.time_ <= var_309_6 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_8 = arg_306_1:FormatText(StoryNameCfg[7].name)

				arg_306_1.leftNameTxt_.text = var_309_8

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

				local var_309_9 = arg_306_1:GetWordFromCfg(116091071)
				local var_309_10 = arg_306_1:FormatText(var_309_9.content)

				arg_306_1.text_.text = var_309_10

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_11 = 6
				local var_309_12 = utf8.len(var_309_10)
				local var_309_13 = var_309_11 <= 0 and var_309_7 or var_309_7 * (var_309_12 / var_309_11)

				if var_309_13 > 0 and var_309_7 < var_309_13 then
					arg_306_1.talkMaxDuration = var_309_13

					if var_309_13 + var_309_6 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_13 + var_309_6
					end
				end

				arg_306_1.text_.text = var_309_10
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_14 = math.max(var_309_7, arg_306_1.talkMaxDuration)

			if var_309_6 <= arg_306_1.time_ and arg_306_1.time_ < var_309_6 + var_309_14 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_6) / var_309_14

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_6 + var_309_14 and arg_306_1.time_ < var_309_6 + var_309_14 + arg_309_0 then
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
			local var_313_0 = arg_310_1.actors_["1028ui_story"].transform
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 then
				arg_310_1.var_.moveOldPos1028ui_story = var_313_0.localPosition
			end

			local var_313_2 = 0.001

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2
				local var_313_4 = Vector3.New(0, 100, 0)

				var_313_0.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos1028ui_story, var_313_4, var_313_3)

				local var_313_5 = manager.ui.mainCamera.transform.position - var_313_0.position

				var_313_0.forward = Vector3.New(var_313_5.x, var_313_5.y, var_313_5.z)

				local var_313_6 = var_313_0.localEulerAngles

				var_313_6.z = 0
				var_313_6.x = 0
				var_313_0.localEulerAngles = var_313_6
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 then
				var_313_0.localPosition = Vector3.New(0, 100, 0)

				local var_313_7 = manager.ui.mainCamera.transform.position - var_313_0.position

				var_313_0.forward = Vector3.New(var_313_7.x, var_313_7.y, var_313_7.z)

				local var_313_8 = var_313_0.localEulerAngles

				var_313_8.z = 0
				var_313_8.x = 0
				var_313_0.localEulerAngles = var_313_8
			end

			local var_313_9 = 0
			local var_313_10 = 1

			if var_313_9 < arg_310_1.time_ and arg_310_1.time_ <= var_313_9 + arg_313_0 then
				local var_313_11 = "play"
				local var_313_12 = "effect"

				arg_310_1:AudioAction(var_313_11, var_313_12, "se_story_16", "se_story_16_door06", "")
			end

			local var_313_13 = 0
			local var_313_14 = 1.375

			if var_313_13 < arg_310_1.time_ and arg_310_1.time_ <= var_313_13 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, false)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_15 = arg_310_1:GetWordFromCfg(116091072)
				local var_313_16 = arg_310_1:FormatText(var_313_15.content)

				arg_310_1.text_.text = var_313_16

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_17 = 55
				local var_313_18 = utf8.len(var_313_16)
				local var_313_19 = var_313_17 <= 0 and var_313_14 or var_313_14 * (var_313_18 / var_313_17)

				if var_313_19 > 0 and var_313_14 < var_313_19 then
					arg_310_1.talkMaxDuration = var_313_19

					if var_313_19 + var_313_13 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_19 + var_313_13
					end
				end

				arg_310_1.text_.text = var_313_16
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_20 = math.max(var_313_14, arg_310_1.talkMaxDuration)

			if var_313_13 <= arg_310_1.time_ and arg_310_1.time_ < var_313_13 + var_313_20 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_13) / var_313_20

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_13 + var_313_20 and arg_310_1.time_ < var_313_13 + var_313_20 + arg_313_0 then
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
			local var_317_0 = 0
			local var_317_1 = 1

			if var_317_0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, false)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_2 = arg_314_1:GetWordFromCfg(116091073)
				local var_317_3 = arg_314_1:FormatText(var_317_2.content)

				arg_314_1.text_.text = var_317_3

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_4 = 40
				local var_317_5 = utf8.len(var_317_3)
				local var_317_6 = var_317_4 <= 0 and var_317_1 or var_317_1 * (var_317_5 / var_317_4)

				if var_317_6 > 0 and var_317_1 < var_317_6 then
					arg_314_1.talkMaxDuration = var_317_6

					if var_317_6 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_6 + var_317_0
					end
				end

				arg_314_1.text_.text = var_317_3
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_7 = math.max(var_317_1, arg_314_1.talkMaxDuration)

			if var_317_0 <= arg_314_1.time_ and arg_314_1.time_ < var_317_0 + var_317_7 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_0) / var_317_7

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_0 + var_317_7 and arg_314_1.time_ < var_317_0 + var_317_7 + arg_317_0 then
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
			local var_321_0 = 0
			local var_321_1 = 0.325

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_2 = arg_318_1:FormatText(StoryNameCfg[7].name)

				arg_318_1.leftNameTxt_.text = var_321_2

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

				local var_321_3 = arg_318_1:GetWordFromCfg(116091074)
				local var_321_4 = arg_318_1:FormatText(var_321_3.content)

				arg_318_1.text_.text = var_321_4

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_5 = 13
				local var_321_6 = utf8.len(var_321_4)
				local var_321_7 = var_321_5 <= 0 and var_321_1 or var_321_1 * (var_321_6 / var_321_5)

				if var_321_7 > 0 and var_321_1 < var_321_7 then
					arg_318_1.talkMaxDuration = var_321_7

					if var_321_7 + var_321_0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_7 + var_321_0
					end
				end

				arg_318_1.text_.text = var_321_4
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_8 = math.max(var_321_1, arg_318_1.talkMaxDuration)

			if var_321_0 <= arg_318_1.time_ and arg_318_1.time_ < var_321_0 + var_321_8 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_0) / var_321_8

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_0 + var_321_8 and arg_318_1.time_ < var_321_0 + var_321_8 + arg_321_0 then
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
			local var_325_0 = manager.ui.mainCamera.transform
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 then
				arg_322_1.var_.shakeOldPos = var_325_0.localPosition
			end

			local var_325_2 = 1

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_2 then
				local var_325_3 = (arg_322_1.time_ - var_325_1) / 0.066
				local var_325_4, var_325_5 = math.modf(var_325_3)

				var_325_0.localPosition = Vector3.New(var_325_5 * 0.13, var_325_5 * 0.13, var_325_5 * 0.13) + arg_322_1.var_.shakeOldPos
			end

			if arg_322_1.time_ >= var_325_1 + var_325_2 and arg_322_1.time_ < var_325_1 + var_325_2 + arg_325_0 then
				var_325_0.localPosition = arg_322_1.var_.shakeOldPos
			end

			local var_325_6 = 0

			if var_325_6 < arg_322_1.time_ and arg_322_1.time_ <= var_325_6 + arg_325_0 then
				arg_322_1.allBtn_.enabled = false
			end

			local var_325_7 = 1

			if arg_322_1.time_ >= var_325_6 + var_325_7 and arg_322_1.time_ < var_325_6 + var_325_7 + arg_325_0 then
				arg_322_1.allBtn_.enabled = true
			end

			if arg_322_1.frameCnt_ <= 1 then
				arg_322_1.dialog_:SetActive(false)
			end

			local var_325_8 = 1
			local var_325_9 = 0.95

			if var_325_8 < arg_322_1.time_ and arg_322_1.time_ <= var_325_8 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0

				arg_322_1.dialog_:SetActive(true)

				arg_322_1.dialogCg_.alpha = 0

				local var_325_10 = LeanTween.value(arg_322_1.dialog_, 0, 1, 0.3)

				var_325_10:setOnUpdate(LuaHelper.FloatAction(function(arg_326_0)
					arg_322_1.dialogCg_.alpha = arg_326_0
				end))
				var_325_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_322_1.dialog_)
					var_325_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_322_1.duration_ = arg_322_1.duration_ + 0.3

				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_11 = arg_322_1:GetWordFromCfg(116091075)
				local var_325_12 = arg_322_1:FormatText(var_325_11.content)

				arg_322_1.text_.text = var_325_12

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_13 = 38
				local var_325_14 = utf8.len(var_325_12)
				local var_325_15 = var_325_13 <= 0 and var_325_9 or var_325_9 * (var_325_14 / var_325_13)

				if var_325_15 > 0 and var_325_9 < var_325_15 then
					arg_322_1.talkMaxDuration = var_325_15
					var_325_8 = var_325_8 + 0.3

					if var_325_15 + var_325_8 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_15 + var_325_8
					end
				end

				arg_322_1.text_.text = var_325_12
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_16 = var_325_8 + 0.3
			local var_325_17 = math.max(var_325_9, arg_322_1.talkMaxDuration)

			if var_325_16 <= arg_322_1.time_ and arg_322_1.time_ < var_325_16 + var_325_17 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_16) / var_325_17

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_16 + var_325_17 and arg_322_1.time_ < var_325_16 + var_325_17 + arg_325_0 then
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
			local var_331_0 = 0
			local var_331_1 = 1.15

			if var_331_0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, false)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_2 = arg_328_1:GetWordFromCfg(116091076)
				local var_331_3 = arg_328_1:FormatText(var_331_2.content)

				arg_328_1.text_.text = var_331_3

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_4 = 46
				local var_331_5 = utf8.len(var_331_3)
				local var_331_6 = var_331_4 <= 0 and var_331_1 or var_331_1 * (var_331_5 / var_331_4)

				if var_331_6 > 0 and var_331_1 < var_331_6 then
					arg_328_1.talkMaxDuration = var_331_6

					if var_331_6 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_6 + var_331_0
					end
				end

				arg_328_1.text_.text = var_331_3
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_7 = math.max(var_331_1, arg_328_1.talkMaxDuration)

			if var_331_0 <= arg_328_1.time_ and arg_328_1.time_ < var_331_0 + var_331_7 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_0) / var_331_7

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_0 + var_331_7 and arg_328_1.time_ < var_331_0 + var_331_7 + arg_331_0 then
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
			local var_335_0 = arg_332_1.actors_["1084ui_story"].transform
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 then
				arg_332_1.var_.moveOldPos1084ui_story = var_335_0.localPosition

				local var_335_2 = "1084ui_story"

				arg_332_1:ShowWeapon(arg_332_1.var_[var_335_2 .. "Animator"].transform, true)
			end

			local var_335_3 = 0.001

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_3 then
				local var_335_4 = (arg_332_1.time_ - var_335_1) / var_335_3
				local var_335_5 = Vector3.New(0, -0.97, -6)

				var_335_0.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos1084ui_story, var_335_5, var_335_4)

				local var_335_6 = manager.ui.mainCamera.transform.position - var_335_0.position

				var_335_0.forward = Vector3.New(var_335_6.x, var_335_6.y, var_335_6.z)

				local var_335_7 = var_335_0.localEulerAngles

				var_335_7.z = 0
				var_335_7.x = 0
				var_335_0.localEulerAngles = var_335_7
			end

			if arg_332_1.time_ >= var_335_1 + var_335_3 and arg_332_1.time_ < var_335_1 + var_335_3 + arg_335_0 then
				var_335_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_335_8 = manager.ui.mainCamera.transform.position - var_335_0.position

				var_335_0.forward = Vector3.New(var_335_8.x, var_335_8.y, var_335_8.z)

				local var_335_9 = var_335_0.localEulerAngles

				var_335_9.z = 0
				var_335_9.x = 0
				var_335_0.localEulerAngles = var_335_9
			end

			local var_335_10 = arg_332_1.actors_["1084ui_story"]
			local var_335_11 = 0

			if var_335_11 < arg_332_1.time_ and arg_332_1.time_ <= var_335_11 + arg_335_0 and not isNil(var_335_10) and arg_332_1.var_.characterEffect1084ui_story == nil then
				arg_332_1.var_.characterEffect1084ui_story = var_335_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_12 = 0.2

			if var_335_11 <= arg_332_1.time_ and arg_332_1.time_ < var_335_11 + var_335_12 and not isNil(var_335_10) then
				local var_335_13 = (arg_332_1.time_ - var_335_11) / var_335_12

				if arg_332_1.var_.characterEffect1084ui_story and not isNil(var_335_10) then
					arg_332_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= var_335_11 + var_335_12 and arg_332_1.time_ < var_335_11 + var_335_12 + arg_335_0 and not isNil(var_335_10) and arg_332_1.var_.characterEffect1084ui_story then
				arg_332_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_335_14 = 0

			if var_335_14 < arg_332_1.time_ and arg_332_1.time_ <= var_335_14 + arg_335_0 then
				arg_332_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_335_15 = 0

			if var_335_15 < arg_332_1.time_ and arg_332_1.time_ <= var_335_15 + arg_335_0 then
				arg_332_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_335_16 = 0
			local var_335_17 = 0.175

			if var_335_16 < arg_332_1.time_ and arg_332_1.time_ <= var_335_16 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_18 = arg_332_1:FormatText(StoryNameCfg[6].name)

				arg_332_1.leftNameTxt_.text = var_335_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_19 = arg_332_1:GetWordFromCfg(116091077)
				local var_335_20 = arg_332_1:FormatText(var_335_19.content)

				arg_332_1.text_.text = var_335_20

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_21 = 7
				local var_335_22 = utf8.len(var_335_20)
				local var_335_23 = var_335_21 <= 0 and var_335_17 or var_335_17 * (var_335_22 / var_335_21)

				if var_335_23 > 0 and var_335_17 < var_335_23 then
					arg_332_1.talkMaxDuration = var_335_23

					if var_335_23 + var_335_16 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_23 + var_335_16
					end
				end

				arg_332_1.text_.text = var_335_20
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091077", "story_v_out_116091.awb") ~= 0 then
					local var_335_24 = manager.audio:GetVoiceLength("story_v_out_116091", "116091077", "story_v_out_116091.awb") / 1000

					if var_335_24 + var_335_16 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_24 + var_335_16
					end

					if var_335_19.prefab_name ~= "" and arg_332_1.actors_[var_335_19.prefab_name] ~= nil then
						local var_335_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_19.prefab_name].transform, "story_v_out_116091", "116091077", "story_v_out_116091.awb")

						arg_332_1:RecordAudio("116091077", var_335_25)
						arg_332_1:RecordAudio("116091077", var_335_25)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_116091", "116091077", "story_v_out_116091.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_116091", "116091077", "story_v_out_116091.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_26 = math.max(var_335_17, arg_332_1.talkMaxDuration)

			if var_335_16 <= arg_332_1.time_ and arg_332_1.time_ < var_335_16 + var_335_26 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_16) / var_335_26

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_16 + var_335_26 and arg_332_1.time_ < var_335_16 + var_335_26 + arg_335_0 then
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
			local var_339_0 = arg_336_1.actors_["1084ui_story"].transform
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 then
				arg_336_1.var_.moveOldPos1084ui_story = var_339_0.localPosition
			end

			local var_339_2 = 0.001

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2
				local var_339_4 = Vector3.New(0, 100, 0)

				var_339_0.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1084ui_story, var_339_4, var_339_3)

				local var_339_5 = manager.ui.mainCamera.transform.position - var_339_0.position

				var_339_0.forward = Vector3.New(var_339_5.x, var_339_5.y, var_339_5.z)

				local var_339_6 = var_339_0.localEulerAngles

				var_339_6.z = 0
				var_339_6.x = 0
				var_339_0.localEulerAngles = var_339_6
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 then
				var_339_0.localPosition = Vector3.New(0, 100, 0)

				local var_339_7 = manager.ui.mainCamera.transform.position - var_339_0.position

				var_339_0.forward = Vector3.New(var_339_7.x, var_339_7.y, var_339_7.z)

				local var_339_8 = var_339_0.localEulerAngles

				var_339_8.z = 0
				var_339_8.x = 0
				var_339_0.localEulerAngles = var_339_8
			end

			local var_339_9 = 0
			local var_339_10 = 1

			if var_339_9 < arg_336_1.time_ and arg_336_1.time_ <= var_339_9 + arg_339_0 then
				local var_339_11 = "play"
				local var_339_12 = "effect"

				arg_336_1:AudioAction(var_339_11, var_339_12, "se_story_16", "se_story_16_thunder", "")
			end

			local var_339_13 = manager.ui.mainCamera.transform
			local var_339_14 = 0

			if var_339_14 < arg_336_1.time_ and arg_336_1.time_ <= var_339_14 + arg_339_0 then
				arg_336_1.var_.shakeOldPos = var_339_13.localPosition
			end

			local var_339_15 = 1

			if var_339_14 <= arg_336_1.time_ and arg_336_1.time_ < var_339_14 + var_339_15 then
				local var_339_16 = (arg_336_1.time_ - var_339_14) / 0.066
				local var_339_17, var_339_18 = math.modf(var_339_16)

				var_339_13.localPosition = Vector3.New(var_339_18 * 0.13, var_339_18 * 0.13, var_339_18 * 0.13) + arg_336_1.var_.shakeOldPos
			end

			if arg_336_1.time_ >= var_339_14 + var_339_15 and arg_336_1.time_ < var_339_14 + var_339_15 + arg_339_0 then
				var_339_13.localPosition = arg_336_1.var_.shakeOldPos
			end

			local var_339_19 = 0

			if var_339_19 < arg_336_1.time_ and arg_336_1.time_ <= var_339_19 + arg_339_0 then
				arg_336_1.allBtn_.enabled = false
			end

			local var_339_20 = 1

			if arg_336_1.time_ >= var_339_19 + var_339_20 and arg_336_1.time_ < var_339_19 + var_339_20 + arg_339_0 then
				arg_336_1.allBtn_.enabled = true
			end

			local var_339_21 = 0
			local var_339_22 = 0.9

			if var_339_21 < arg_336_1.time_ and arg_336_1.time_ <= var_339_21 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, false)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_23 = arg_336_1:GetWordFromCfg(116091078)
				local var_339_24 = arg_336_1:FormatText(var_339_23.content)

				arg_336_1.text_.text = var_339_24

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_25 = 36
				local var_339_26 = utf8.len(var_339_24)
				local var_339_27 = var_339_25 <= 0 and var_339_22 or var_339_22 * (var_339_26 / var_339_25)

				if var_339_27 > 0 and var_339_22 < var_339_27 then
					arg_336_1.talkMaxDuration = var_339_27

					if var_339_27 + var_339_21 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_27 + var_339_21
					end
				end

				arg_336_1.text_.text = var_339_24
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_28 = math.max(var_339_22, arg_336_1.talkMaxDuration)

			if var_339_21 <= arg_336_1.time_ and arg_336_1.time_ < var_339_21 + var_339_28 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_21) / var_339_28

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_21 + var_339_28 and arg_336_1.time_ < var_339_21 + var_339_28 + arg_339_0 then
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
			local var_343_0 = 0.5

			if var_343_0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_0 + arg_343_0 then
				local var_343_1 = manager.ui.mainCamera.transform.localPosition
				local var_343_2 = Vector3.New(0, 0, 10) + Vector3.New(var_343_1.x, var_343_1.y, 0)
				local var_343_3 = arg_340_1.bgs_.B13a

				var_343_3.transform.localPosition = var_343_2
				var_343_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_343_4 = var_343_3:GetComponent("SpriteRenderer")

				if var_343_4 and var_343_4.sprite then
					local var_343_5 = (var_343_3.transform.localPosition - var_343_1).z
					local var_343_6 = manager.ui.mainCameraCom_
					local var_343_7 = 2 * var_343_5 * Mathf.Tan(var_343_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_343_8 = var_343_7 * var_343_6.aspect
					local var_343_9 = var_343_4.sprite.bounds.size.x
					local var_343_10 = var_343_4.sprite.bounds.size.y
					local var_343_11 = var_343_8 / var_343_9
					local var_343_12 = var_343_7 / var_343_10
					local var_343_13 = var_343_12 < var_343_11 and var_343_11 or var_343_12

					var_343_3.transform.localScale = Vector3.New(var_343_13, var_343_13, 0)
				end

				for iter_343_0, iter_343_1 in pairs(arg_340_1.bgs_) do
					if iter_343_0 ~= "B13a" then
						iter_343_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_343_14 = 0

			if var_343_14 < arg_340_1.time_ and arg_340_1.time_ <= var_343_14 + arg_343_0 then
				arg_340_1.mask_.enabled = true
				arg_340_1.mask_.raycastTarget = true

				arg_340_1:SetGaussion(false)
			end

			local var_343_15 = 0.5

			if var_343_14 <= arg_340_1.time_ and arg_340_1.time_ < var_343_14 + var_343_15 then
				local var_343_16 = (arg_340_1.time_ - var_343_14) / var_343_15
				local var_343_17 = Color.New(1, 1, 1)

				var_343_17.a = Mathf.Lerp(0, 1, var_343_16)
				arg_340_1.mask_.color = var_343_17
			end

			if arg_340_1.time_ >= var_343_14 + var_343_15 and arg_340_1.time_ < var_343_14 + var_343_15 + arg_343_0 then
				local var_343_18 = Color.New(1, 1, 1)

				var_343_18.a = 1
				arg_340_1.mask_.color = var_343_18
			end

			local var_343_19 = 0.5

			if var_343_19 < arg_340_1.time_ and arg_340_1.time_ <= var_343_19 + arg_343_0 then
				arg_340_1.mask_.enabled = true
				arg_340_1.mask_.raycastTarget = true

				arg_340_1:SetGaussion(false)
			end

			local var_343_20 = 1.5

			if var_343_19 <= arg_340_1.time_ and arg_340_1.time_ < var_343_19 + var_343_20 then
				local var_343_21 = (arg_340_1.time_ - var_343_19) / var_343_20
				local var_343_22 = Color.New(1, 1, 1)

				var_343_22.a = Mathf.Lerp(1, 0, var_343_21)
				arg_340_1.mask_.color = var_343_22
			end

			if arg_340_1.time_ >= var_343_19 + var_343_20 and arg_340_1.time_ < var_343_19 + var_343_20 + arg_343_0 then
				local var_343_23 = Color.New(1, 1, 1)
				local var_343_24 = 0

				arg_340_1.mask_.enabled = false
				var_343_23.a = var_343_24
				arg_340_1.mask_.color = var_343_23
			end

			local var_343_25 = 0
			local var_343_26 = 1

			if var_343_25 < arg_340_1.time_ and arg_340_1.time_ <= var_343_25 + arg_343_0 then
				local var_343_27 = "play"
				local var_343_28 = "effect"

				arg_340_1:AudioAction(var_343_27, var_343_28, "se_story_16", "se_story_16_hit02", "")
			end

			if arg_340_1.frameCnt_ <= 1 then
				arg_340_1.dialog_:SetActive(false)
			end

			local var_343_29 = 2
			local var_343_30 = 1.275

			if var_343_29 < arg_340_1.time_ and arg_340_1.time_ <= var_343_29 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0

				arg_340_1.dialog_:SetActive(true)

				arg_340_1.dialogCg_.alpha = 0

				local var_343_31 = LeanTween.value(arg_340_1.dialog_, 0, 1, 0.3)

				var_343_31:setOnUpdate(LuaHelper.FloatAction(function(arg_344_0)
					arg_340_1.dialogCg_.alpha = arg_344_0
				end))
				var_343_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_340_1.dialog_)
					var_343_31:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_340_1.duration_ = arg_340_1.duration_ + 0.3

				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_32 = arg_340_1:GetWordFromCfg(116091079)
				local var_343_33 = arg_340_1:FormatText(var_343_32.content)

				arg_340_1.text_.text = var_343_33

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_34 = 51
				local var_343_35 = utf8.len(var_343_33)
				local var_343_36 = var_343_34 <= 0 and var_343_30 or var_343_30 * (var_343_35 / var_343_34)

				if var_343_36 > 0 and var_343_30 < var_343_36 then
					arg_340_1.talkMaxDuration = var_343_36
					var_343_29 = var_343_29 + 0.3

					if var_343_36 + var_343_29 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_36 + var_343_29
					end
				end

				arg_340_1.text_.text = var_343_33
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_37 = var_343_29 + 0.3
			local var_343_38 = math.max(var_343_30, arg_340_1.talkMaxDuration)

			if var_343_37 <= arg_340_1.time_ and arg_340_1.time_ < var_343_37 + var_343_38 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_37) / var_343_38

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_37 + var_343_38 and arg_340_1.time_ < var_343_37 + var_343_38 + arg_343_0 then
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
			local var_349_0 = 0
			local var_349_1 = 1

			if var_349_0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_2 = arg_346_1:GetWordFromCfg(116091080)
				local var_349_3 = arg_346_1:FormatText(var_349_2.content)

				arg_346_1.text_.text = var_349_3

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_4 = 40
				local var_349_5 = utf8.len(var_349_3)
				local var_349_6 = var_349_4 <= 0 and var_349_1 or var_349_1 * (var_349_5 / var_349_4)

				if var_349_6 > 0 and var_349_1 < var_349_6 then
					arg_346_1.talkMaxDuration = var_349_6

					if var_349_6 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_6 + var_349_0
					end
				end

				arg_346_1.text_.text = var_349_3
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_7 = math.max(var_349_1, arg_346_1.talkMaxDuration)

			if var_349_0 <= arg_346_1.time_ and arg_346_1.time_ < var_349_0 + var_349_7 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_0) / var_349_7

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_0 + var_349_7 and arg_346_1.time_ < var_349_0 + var_349_7 + arg_349_0 then
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
			local var_353_0 = 0
			local var_353_1 = 0.1

			if var_353_0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				local var_353_2 = arg_350_1:FormatText(StoryNameCfg[7].name)

				arg_350_1.leftNameTxt_.text = var_353_2

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

				local var_353_3 = arg_350_1:GetWordFromCfg(116091081)
				local var_353_4 = arg_350_1:FormatText(var_353_3.content)

				arg_350_1.text_.text = var_353_4

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_5 = 4
				local var_353_6 = utf8.len(var_353_4)
				local var_353_7 = var_353_5 <= 0 and var_353_1 or var_353_1 * (var_353_6 / var_353_5)

				if var_353_7 > 0 and var_353_1 < var_353_7 then
					arg_350_1.talkMaxDuration = var_353_7

					if var_353_7 + var_353_0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_7 + var_353_0
					end
				end

				arg_350_1.text_.text = var_353_4
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_8 = math.max(var_353_1, arg_350_1.talkMaxDuration)

			if var_353_0 <= arg_350_1.time_ and arg_350_1.time_ < var_353_0 + var_353_8 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_0) / var_353_8

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_0 + var_353_8 and arg_350_1.time_ < var_353_0 + var_353_8 + arg_353_0 then
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
			local var_357_0 = 0

			if var_357_0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_0 + arg_357_0 then
				arg_354_1.mask_.enabled = true
				arg_354_1.mask_.raycastTarget = true

				arg_354_1:SetGaussion(false)
			end

			local var_357_1 = 2

			if var_357_0 <= arg_354_1.time_ and arg_354_1.time_ < var_357_0 + var_357_1 then
				local var_357_2 = (arg_354_1.time_ - var_357_0) / var_357_1
				local var_357_3 = Color.New(0, 0, 0)

				var_357_3.a = Mathf.Lerp(0, 1, var_357_2)
				arg_354_1.mask_.color = var_357_3
			end

			if arg_354_1.time_ >= var_357_0 + var_357_1 and arg_354_1.time_ < var_357_0 + var_357_1 + arg_357_0 then
				local var_357_4 = Color.New(0, 0, 0)

				var_357_4.a = 1
				arg_354_1.mask_.color = var_357_4
			end

			local var_357_5 = 2

			if var_357_5 < arg_354_1.time_ and arg_354_1.time_ <= var_357_5 + arg_357_0 then
				arg_354_1.mask_.enabled = true
				arg_354_1.mask_.raycastTarget = true

				arg_354_1:SetGaussion(false)
			end

			local var_357_6 = 0.0166666666666667

			if var_357_5 <= arg_354_1.time_ and arg_354_1.time_ < var_357_5 + var_357_6 then
				local var_357_7 = (arg_354_1.time_ - var_357_5) / var_357_6
				local var_357_8 = Color.New(0, 0, 0)

				var_357_8.a = Mathf.Lerp(1, 0, var_357_7)
				arg_354_1.mask_.color = var_357_8
			end

			if arg_354_1.time_ >= var_357_5 + var_357_6 and arg_354_1.time_ < var_357_5 + var_357_6 + arg_357_0 then
				local var_357_9 = Color.New(0, 0, 0)
				local var_357_10 = 0

				arg_354_1.mask_.enabled = false
				var_357_9.a = var_357_10
				arg_354_1.mask_.color = var_357_9
			end

			local var_357_11 = 0
			local var_357_12 = 1

			if var_357_11 < arg_354_1.time_ and arg_354_1.time_ <= var_357_11 + arg_357_0 then
				local var_357_13 = "play"
				local var_357_14 = "effect"

				arg_354_1:AudioAction(var_357_13, var_357_14, "se_story_16", "se_story_16_wind", "")
			end

			local var_357_15 = 0
			local var_357_16 = 1

			if var_357_15 < arg_354_1.time_ and arg_354_1.time_ <= var_357_15 + arg_357_0 then
				local var_357_17 = "play"
				local var_357_18 = "effect"

				arg_354_1:AudioAction(var_357_17, var_357_18, "se_story_16", "se_story_16_fight03", "")
			end

			local var_357_19 = 2.01666666666667

			if var_357_19 < arg_354_1.time_ and arg_354_1.time_ <= var_357_19 + arg_357_0 then
				local var_357_20 = manager.ui.mainCamera.transform.localPosition
				local var_357_21 = Vector3.New(0, 0, 10) + Vector3.New(var_357_20.x, var_357_20.y, 0)
				local var_357_22 = arg_354_1.bgs_.STblack

				var_357_22.transform.localPosition = var_357_21
				var_357_22.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_357_23 = var_357_22:GetComponent("SpriteRenderer")

				if var_357_23 and var_357_23.sprite then
					local var_357_24 = (var_357_22.transform.localPosition - var_357_20).z
					local var_357_25 = manager.ui.mainCameraCom_
					local var_357_26 = 2 * var_357_24 * Mathf.Tan(var_357_25.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_357_27 = var_357_26 * var_357_25.aspect
					local var_357_28 = var_357_23.sprite.bounds.size.x
					local var_357_29 = var_357_23.sprite.bounds.size.y
					local var_357_30 = var_357_27 / var_357_28
					local var_357_31 = var_357_26 / var_357_29
					local var_357_32 = var_357_31 < var_357_30 and var_357_30 or var_357_31

					var_357_22.transform.localScale = Vector3.New(var_357_32, var_357_32, 0)
				end

				for iter_357_0, iter_357_1 in pairs(arg_354_1.bgs_) do
					if iter_357_0 ~= "STblack" then
						iter_357_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_357_33 = manager.ui.mainCamera.transform
			local var_357_34 = 0

			if var_357_34 < arg_354_1.time_ and arg_354_1.time_ <= var_357_34 + arg_357_0 then
				arg_354_1.var_.shakeOldPos = var_357_33.localPosition
			end

			local var_357_35 = 1

			if var_357_34 <= arg_354_1.time_ and arg_354_1.time_ < var_357_34 + var_357_35 then
				local var_357_36 = (arg_354_1.time_ - var_357_34) / 0.066
				local var_357_37, var_357_38 = math.modf(var_357_36)

				var_357_33.localPosition = Vector3.New(var_357_38 * 0.13, var_357_38 * 0.13, var_357_38 * 0.13) + arg_354_1.var_.shakeOldPos
			end

			if arg_354_1.time_ >= var_357_34 + var_357_35 and arg_354_1.time_ < var_357_34 + var_357_35 + arg_357_0 then
				var_357_33.localPosition = arg_354_1.var_.shakeOldPos
			end

			local var_357_39 = 0

			if var_357_39 < arg_354_1.time_ and arg_354_1.time_ <= var_357_39 + arg_357_0 then
				arg_354_1.allBtn_.enabled = false
			end

			local var_357_40 = 1

			if arg_354_1.time_ >= var_357_39 + var_357_40 and arg_354_1.time_ < var_357_39 + var_357_40 + arg_357_0 then
				arg_354_1.allBtn_.enabled = true
			end

			if arg_354_1.frameCnt_ <= 1 then
				arg_354_1.dialog_:SetActive(false)
			end

			local var_357_41 = 2
			local var_357_42 = 1.4

			if var_357_41 < arg_354_1.time_ and arg_354_1.time_ <= var_357_41 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0

				arg_354_1.dialog_:SetActive(true)

				arg_354_1.dialogCg_.alpha = 0

				local var_357_43 = LeanTween.value(arg_354_1.dialog_, 0, 1, 0.3)

				var_357_43:setOnUpdate(LuaHelper.FloatAction(function(arg_358_0)
					arg_354_1.dialogCg_.alpha = arg_358_0
				end))
				var_357_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_354_1.dialog_)
					var_357_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_354_1.duration_ = arg_354_1.duration_ + 0.3

				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_44 = arg_354_1:GetWordFromCfg(116091082)
				local var_357_45 = arg_354_1:FormatText(var_357_44.content)

				arg_354_1.text_.text = var_357_45

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_46 = 56
				local var_357_47 = utf8.len(var_357_45)
				local var_357_48 = var_357_46 <= 0 and var_357_42 or var_357_42 * (var_357_47 / var_357_46)

				if var_357_48 > 0 and var_357_42 < var_357_48 then
					arg_354_1.talkMaxDuration = var_357_48
					var_357_41 = var_357_41 + 0.3

					if var_357_48 + var_357_41 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_48 + var_357_41
					end
				end

				arg_354_1.text_.text = var_357_45
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_49 = var_357_41 + 0.3
			local var_357_50 = math.max(var_357_42, arg_354_1.talkMaxDuration)

			if var_357_49 <= arg_354_1.time_ and arg_354_1.time_ < var_357_49 + var_357_50 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_49) / var_357_50

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_49 + var_357_50 and arg_354_1.time_ < var_357_49 + var_357_50 + arg_357_0 then
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
			local var_363_0 = 0
			local var_363_1 = 1.3

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, false)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_2 = arg_360_1:GetWordFromCfg(116091083)
				local var_363_3 = arg_360_1:FormatText(var_363_2.content)

				arg_360_1.text_.text = var_363_3

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_4 = 52
				local var_363_5 = utf8.len(var_363_3)
				local var_363_6 = var_363_4 <= 0 and var_363_1 or var_363_1 * (var_363_5 / var_363_4)

				if var_363_6 > 0 and var_363_1 < var_363_6 then
					arg_360_1.talkMaxDuration = var_363_6

					if var_363_6 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_6 + var_363_0
					end
				end

				arg_360_1.text_.text = var_363_3
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_7 = math.max(var_363_1, arg_360_1.talkMaxDuration)

			if var_363_0 <= arg_360_1.time_ and arg_360_1.time_ < var_363_0 + var_363_7 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_0) / var_363_7

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_0 + var_363_7 and arg_360_1.time_ < var_363_0 + var_363_7 + arg_363_0 then
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
			local var_367_0 = 0
			local var_367_1 = 0.075

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_2 = arg_364_1:FormatText(StoryNameCfg[6].name)

				arg_364_1.leftNameTxt_.text = var_367_2

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

				local var_367_3 = arg_364_1:GetWordFromCfg(116091084)
				local var_367_4 = arg_364_1:FormatText(var_367_3.content)

				arg_364_1.text_.text = var_367_4

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_5 = 3
				local var_367_6 = utf8.len(var_367_4)
				local var_367_7 = var_367_5 <= 0 and var_367_1 or var_367_1 * (var_367_6 / var_367_5)

				if var_367_7 > 0 and var_367_1 < var_367_7 then
					arg_364_1.talkMaxDuration = var_367_7

					if var_367_7 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_7 + var_367_0
					end
				end

				arg_364_1.text_.text = var_367_4
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091084", "story_v_out_116091.awb") ~= 0 then
					local var_367_8 = manager.audio:GetVoiceLength("story_v_out_116091", "116091084", "story_v_out_116091.awb") / 1000

					if var_367_8 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_8 + var_367_0
					end

					if var_367_3.prefab_name ~= "" and arg_364_1.actors_[var_367_3.prefab_name] ~= nil then
						local var_367_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_3.prefab_name].transform, "story_v_out_116091", "116091084", "story_v_out_116091.awb")

						arg_364_1:RecordAudio("116091084", var_367_9)
						arg_364_1:RecordAudio("116091084", var_367_9)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_116091", "116091084", "story_v_out_116091.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_116091", "116091084", "story_v_out_116091.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_10 = math.max(var_367_1, arg_364_1.talkMaxDuration)

			if var_367_0 <= arg_364_1.time_ and arg_364_1.time_ < var_367_0 + var_367_10 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_0) / var_367_10

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_0 + var_367_10 and arg_364_1.time_ < var_367_0 + var_367_10 + arg_367_0 then
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
			local var_371_0 = 0
			local var_371_1 = 0.633333333333333

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				local var_371_2 = "play"
				local var_371_3 = "effect"

				arg_368_1:AudioAction(var_371_2, var_371_3, "se_story_16", "se_story_16_smash02", "")
			end

			local var_371_4 = 0.366666666666667
			local var_371_5 = 0.667333333333333

			if var_371_4 < arg_368_1.time_ and arg_368_1.time_ <= var_371_4 + arg_371_0 then
				local var_371_6 = "play"
				local var_371_7 = "effect"

				arg_368_1:AudioAction(var_371_6, var_371_7, "se_story_16", "se_story_16_smash02", "")
			end

			local var_371_8 = 0
			local var_371_9 = 0.2

			if var_371_8 < arg_368_1.time_ and arg_368_1.time_ <= var_371_8 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, false)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_10 = arg_368_1:GetWordFromCfg(116091085)
				local var_371_11 = arg_368_1:FormatText(var_371_10.content)

				arg_368_1.text_.text = var_371_11

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_12 = 7
				local var_371_13 = utf8.len(var_371_11)
				local var_371_14 = var_371_12 <= 0 and var_371_9 or var_371_9 * (var_371_13 / var_371_12)

				if var_371_14 > 0 and var_371_9 < var_371_14 then
					arg_368_1.talkMaxDuration = var_371_14

					if var_371_14 + var_371_8 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_14 + var_371_8
					end
				end

				arg_368_1.text_.text = var_371_11
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_15 = math.max(var_371_9, arg_368_1.talkMaxDuration)

			if var_371_8 <= arg_368_1.time_ and arg_368_1.time_ < var_371_8 + var_371_15 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_8) / var_371_15

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_8 + var_371_15 and arg_368_1.time_ < var_371_8 + var_371_15 + arg_371_0 then
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
			local var_375_0 = 0
			local var_375_1 = 1.425

			if var_375_0 < arg_372_1.time_ and arg_372_1.time_ <= var_375_0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, false)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_2 = arg_372_1:GetWordFromCfg(116091086)
				local var_375_3 = arg_372_1:FormatText(var_375_2.content)

				arg_372_1.text_.text = var_375_3

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_4 = 57
				local var_375_5 = utf8.len(var_375_3)
				local var_375_6 = var_375_4 <= 0 and var_375_1 or var_375_1 * (var_375_5 / var_375_4)

				if var_375_6 > 0 and var_375_1 < var_375_6 then
					arg_372_1.talkMaxDuration = var_375_6

					if var_375_6 + var_375_0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_6 + var_375_0
					end
				end

				arg_372_1.text_.text = var_375_3
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)
				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_7 = math.max(var_375_1, arg_372_1.talkMaxDuration)

			if var_375_0 <= arg_372_1.time_ and arg_372_1.time_ < var_375_0 + var_375_7 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_0) / var_375_7

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_0 + var_375_7 and arg_372_1.time_ < var_375_0 + var_375_7 + arg_375_0 then
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
			local var_379_0 = 0

			if var_379_0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_0 + arg_379_0 then
				arg_376_1.mask_.enabled = true
				arg_376_1.mask_.raycastTarget = true

				arg_376_1:SetGaussion(false)
			end

			local var_379_1 = 2

			if var_379_0 <= arg_376_1.time_ and arg_376_1.time_ < var_379_0 + var_379_1 then
				local var_379_2 = (arg_376_1.time_ - var_379_0) / var_379_1
				local var_379_3 = Color.New(0, 0, 0)

				var_379_3.a = Mathf.Lerp(1, 0, var_379_2)
				arg_376_1.mask_.color = var_379_3
			end

			if arg_376_1.time_ >= var_379_0 + var_379_1 and arg_376_1.time_ < var_379_0 + var_379_1 + arg_379_0 then
				local var_379_4 = Color.New(0, 0, 0)
				local var_379_5 = 0

				arg_376_1.mask_.enabled = false
				var_379_4.a = var_379_5
				arg_376_1.mask_.color = var_379_4
			end

			local var_379_6 = manager.ui.mainCamera.transform
			local var_379_7 = 1.49843910196796

			if var_379_7 < arg_376_1.time_ and arg_376_1.time_ <= var_379_7 + arg_379_0 then
				arg_376_1.var_.shakeOldPos = var_379_6.localPosition
			end

			local var_379_8 = 1.133333

			if var_379_7 <= arg_376_1.time_ and arg_376_1.time_ < var_379_7 + var_379_8 then
				local var_379_9 = (arg_376_1.time_ - var_379_7) / 0.066
				local var_379_10, var_379_11 = math.modf(var_379_9)

				var_379_6.localPosition = Vector3.New(var_379_11 * 0.13, var_379_11 * 0.13, var_379_11 * 0.13) + arg_376_1.var_.shakeOldPos
			end

			if arg_376_1.time_ >= var_379_7 + var_379_8 and arg_376_1.time_ < var_379_7 + var_379_8 + arg_379_0 then
				var_379_6.localPosition = arg_376_1.var_.shakeOldPos
			end

			local var_379_12 = 0

			if var_379_12 < arg_376_1.time_ and arg_376_1.time_ <= var_379_12 + arg_379_0 then
				local var_379_13 = manager.ui.mainCamera.transform.localPosition
				local var_379_14 = Vector3.New(0, 0, 10) + Vector3.New(var_379_13.x, var_379_13.y, 0)
				local var_379_15 = arg_376_1.bgs_.B13a

				var_379_15.transform.localPosition = var_379_14
				var_379_15.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_379_16 = var_379_15:GetComponent("SpriteRenderer")

				if var_379_16 and var_379_16.sprite then
					local var_379_17 = (var_379_15.transform.localPosition - var_379_13).z
					local var_379_18 = manager.ui.mainCameraCom_
					local var_379_19 = 2 * var_379_17 * Mathf.Tan(var_379_18.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_379_20 = var_379_19 * var_379_18.aspect
					local var_379_21 = var_379_16.sprite.bounds.size.x
					local var_379_22 = var_379_16.sprite.bounds.size.y
					local var_379_23 = var_379_20 / var_379_21
					local var_379_24 = var_379_19 / var_379_22
					local var_379_25 = var_379_24 < var_379_23 and var_379_23 or var_379_24

					var_379_15.transform.localScale = Vector3.New(var_379_25, var_379_25, 0)
				end

				for iter_379_0, iter_379_1 in pairs(arg_376_1.bgs_) do
					if iter_379_0 ~= "B13a" then
						iter_379_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_379_26 = arg_376_1.bgs_.B13a
			local var_379_27 = 0

			if var_379_27 < arg_376_1.time_ and arg_376_1.time_ <= var_379_27 + arg_379_0 then
				local var_379_28 = var_379_26:GetComponent("SpriteRenderer")

				if var_379_28 then
					arg_376_1.var_.alphaOldValueB13a = var_379_28.color.a
					arg_376_1.var_.alphaMatValueB13a = var_379_28
				end

				arg_376_1.var_.alphaOldValueB13a = 0
			end

			local var_379_29 = 0.0166666666666667

			if var_379_27 <= arg_376_1.time_ and arg_376_1.time_ < var_379_27 + var_379_29 then
				local var_379_30 = (arg_376_1.time_ - var_379_27) / var_379_29
				local var_379_31 = Mathf.Lerp(arg_376_1.var_.alphaOldValueB13a, 1, var_379_30)

				if arg_376_1.var_.alphaMatValueB13a then
					local var_379_32 = arg_376_1.var_.alphaMatValueB13a.color

					var_379_32.a = var_379_31
					arg_376_1.var_.alphaMatValueB13a.color = var_379_32
				end
			end

			if arg_376_1.time_ >= var_379_27 + var_379_29 and arg_376_1.time_ < var_379_27 + var_379_29 + arg_379_0 and arg_376_1.var_.alphaMatValueB13a then
				local var_379_33 = arg_376_1.var_.alphaMatValueB13a
				local var_379_34 = var_379_33.color

				var_379_34.a = 1
				var_379_33.color = var_379_34
			end

			local var_379_35 = 2

			if var_379_35 < arg_376_1.time_ and arg_376_1.time_ <= var_379_35 + arg_379_0 then
				arg_376_1.allBtn_.enabled = false
			end

			local var_379_36 = 0.631772101967961

			if arg_376_1.time_ >= var_379_35 + var_379_36 and arg_376_1.time_ < var_379_35 + var_379_36 + arg_379_0 then
				arg_376_1.allBtn_.enabled = true
			end

			if arg_376_1.frameCnt_ <= 1 then
				arg_376_1.dialog_:SetActive(false)
			end

			local var_379_37 = 2
			local var_379_38 = 0.775

			if var_379_37 < arg_376_1.time_ and arg_376_1.time_ <= var_379_37 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0

				arg_376_1.dialog_:SetActive(true)

				arg_376_1.dialogCg_.alpha = 0

				local var_379_39 = LeanTween.value(arg_376_1.dialog_, 0, 1, 0.3)

				var_379_39:setOnUpdate(LuaHelper.FloatAction(function(arg_380_0)
					arg_376_1.dialogCg_.alpha = arg_380_0
				end))
				var_379_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_376_1.dialog_)
					var_379_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_376_1.duration_ = arg_376_1.duration_ + 0.3

				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_40 = arg_376_1:GetWordFromCfg(116091087)
				local var_379_41 = arg_376_1:FormatText(var_379_40.content)

				arg_376_1.text_.text = var_379_41

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_42 = 31
				local var_379_43 = utf8.len(var_379_41)
				local var_379_44 = var_379_42 <= 0 and var_379_38 or var_379_38 * (var_379_43 / var_379_42)

				if var_379_44 > 0 and var_379_38 < var_379_44 then
					arg_376_1.talkMaxDuration = var_379_44
					var_379_37 = var_379_37 + 0.3

					if var_379_44 + var_379_37 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_44 + var_379_37
					end
				end

				arg_376_1.text_.text = var_379_41
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_45 = var_379_37 + 0.3
			local var_379_46 = math.max(var_379_38, arg_376_1.talkMaxDuration)

			if var_379_45 <= arg_376_1.time_ and arg_376_1.time_ < var_379_45 + var_379_46 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_45) / var_379_46

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_45 + var_379_46 and arg_376_1.time_ < var_379_45 + var_379_46 + arg_379_0 then
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
			local var_385_0 = 0
			local var_385_1 = 0.35

			if var_385_0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				local var_385_2 = arg_382_1:FormatText(StoryNameCfg[6].name)

				arg_382_1.leftNameTxt_.text = var_385_2

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

				local var_385_3 = arg_382_1:GetWordFromCfg(116091088)
				local var_385_4 = arg_382_1:FormatText(var_385_3.content)

				arg_382_1.text_.text = var_385_4

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_5 = 14
				local var_385_6 = utf8.len(var_385_4)
				local var_385_7 = var_385_5 <= 0 and var_385_1 or var_385_1 * (var_385_6 / var_385_5)

				if var_385_7 > 0 and var_385_1 < var_385_7 then
					arg_382_1.talkMaxDuration = var_385_7

					if var_385_7 + var_385_0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_7 + var_385_0
					end
				end

				arg_382_1.text_.text = var_385_4
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116091", "116091088", "story_v_out_116091.awb") ~= 0 then
					local var_385_8 = manager.audio:GetVoiceLength("story_v_out_116091", "116091088", "story_v_out_116091.awb") / 1000

					if var_385_8 + var_385_0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_8 + var_385_0
					end

					if var_385_3.prefab_name ~= "" and arg_382_1.actors_[var_385_3.prefab_name] ~= nil then
						local var_385_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_3.prefab_name].transform, "story_v_out_116091", "116091088", "story_v_out_116091.awb")

						arg_382_1:RecordAudio("116091088", var_385_9)
						arg_382_1:RecordAudio("116091088", var_385_9)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_116091", "116091088", "story_v_out_116091.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_116091", "116091088", "story_v_out_116091.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_10 = math.max(var_385_1, arg_382_1.talkMaxDuration)

			if var_385_0 <= arg_382_1.time_ and arg_382_1.time_ < var_385_0 + var_385_10 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_0) / var_385_10

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_0 + var_385_10 and arg_382_1.time_ < var_385_0 + var_385_10 + arg_385_0 then
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
			local var_389_0 = arg_386_1.actors_["1084ui_story"]
			local var_389_1 = 0

			if var_389_1 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.characterEffect1084ui_story == nil then
				arg_386_1.var_.characterEffect1084ui_story = var_389_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_2 = 0.2

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_2 and not isNil(var_389_0) then
				local var_389_3 = (arg_386_1.time_ - var_389_1) / var_389_2

				if arg_386_1.var_.characterEffect1084ui_story and not isNil(var_389_0) then
					local var_389_4 = Mathf.Lerp(0, 0.5, var_389_3)

					arg_386_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_386_1.var_.characterEffect1084ui_story.fillRatio = var_389_4
				end
			end

			if arg_386_1.time_ >= var_389_1 + var_389_2 and arg_386_1.time_ < var_389_1 + var_389_2 + arg_389_0 and not isNil(var_389_0) and arg_386_1.var_.characterEffect1084ui_story then
				local var_389_5 = 0.5

				arg_386_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_386_1.var_.characterEffect1084ui_story.fillRatio = var_389_5
			end

			local var_389_6 = 0
			local var_389_7 = 0.475

			if var_389_6 < arg_386_1.time_ and arg_386_1.time_ <= var_389_6 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				local var_389_8 = arg_386_1:FormatText(StoryNameCfg[7].name)

				arg_386_1.leftNameTxt_.text = var_389_8

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

				local var_389_9 = arg_386_1:GetWordFromCfg(116091089)
				local var_389_10 = arg_386_1:FormatText(var_389_9.content)

				arg_386_1.text_.text = var_389_10

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_11 = 19
				local var_389_12 = utf8.len(var_389_10)
				local var_389_13 = var_389_11 <= 0 and var_389_7 or var_389_7 * (var_389_12 / var_389_11)

				if var_389_13 > 0 and var_389_7 < var_389_13 then
					arg_386_1.talkMaxDuration = var_389_13

					if var_389_13 + var_389_6 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_13 + var_389_6
					end
				end

				arg_386_1.text_.text = var_389_10
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_14 = math.max(var_389_7, arg_386_1.talkMaxDuration)

			if var_389_6 <= arg_386_1.time_ and arg_386_1.time_ < var_389_6 + var_389_14 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_6) / var_389_14

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_6 + var_389_14 and arg_386_1.time_ < var_389_6 + var_389_14 + arg_389_0 then
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
			local var_393_0 = arg_390_1.actors_["1084ui_story"].transform
			local var_393_1 = 0

			if var_393_1 < arg_390_1.time_ and arg_390_1.time_ <= var_393_1 + arg_393_0 then
				arg_390_1.var_.moveOldPos1084ui_story = var_393_0.localPosition
			end

			local var_393_2 = 0.001

			if var_393_1 <= arg_390_1.time_ and arg_390_1.time_ < var_393_1 + var_393_2 then
				local var_393_3 = (arg_390_1.time_ - var_393_1) / var_393_2
				local var_393_4 = Vector3.New(0, 100, 0)

				var_393_0.localPosition = Vector3.Lerp(arg_390_1.var_.moveOldPos1084ui_story, var_393_4, var_393_3)

				local var_393_5 = manager.ui.mainCamera.transform.position - var_393_0.position

				var_393_0.forward = Vector3.New(var_393_5.x, var_393_5.y, var_393_5.z)

				local var_393_6 = var_393_0.localEulerAngles

				var_393_6.z = 0
				var_393_6.x = 0
				var_393_0.localEulerAngles = var_393_6
			end

			if arg_390_1.time_ >= var_393_1 + var_393_2 and arg_390_1.time_ < var_393_1 + var_393_2 + arg_393_0 then
				var_393_0.localPosition = Vector3.New(0, 100, 0)

				local var_393_7 = manager.ui.mainCamera.transform.position - var_393_0.position

				var_393_0.forward = Vector3.New(var_393_7.x, var_393_7.y, var_393_7.z)

				local var_393_8 = var_393_0.localEulerAngles

				var_393_8.z = 0
				var_393_8.x = 0
				var_393_0.localEulerAngles = var_393_8
			end

			local var_393_9 = 0
			local var_393_10 = 1

			if var_393_9 < arg_390_1.time_ and arg_390_1.time_ <= var_393_9 + arg_393_0 then
				local var_393_11 = "play"
				local var_393_12 = "effect"

				arg_390_1:AudioAction(var_393_11, var_393_12, "se_story_16", "se_story_16_hit02", "")
			end

			local var_393_13 = 0

			if var_393_13 < arg_390_1.time_ and arg_390_1.time_ <= var_393_13 + arg_393_0 then
				arg_390_1.mask_.enabled = true
				arg_390_1.mask_.raycastTarget = true

				arg_390_1:SetGaussion(false)
			end

			local var_393_14 = 2

			if var_393_13 <= arg_390_1.time_ and arg_390_1.time_ < var_393_13 + var_393_14 then
				local var_393_15 = (arg_390_1.time_ - var_393_13) / var_393_14
				local var_393_16 = Color.New(0, 0, 0)

				var_393_16.a = Mathf.Lerp(0, 1, var_393_15)
				arg_390_1.mask_.color = var_393_16
			end

			if arg_390_1.time_ >= var_393_13 + var_393_14 and arg_390_1.time_ < var_393_13 + var_393_14 + arg_393_0 then
				local var_393_17 = Color.New(0, 0, 0)

				var_393_17.a = 1
				arg_390_1.mask_.color = var_393_17
			end

			local var_393_18 = 2

			if var_393_18 < arg_390_1.time_ and arg_390_1.time_ <= var_393_18 + arg_393_0 then
				arg_390_1.mask_.enabled = true
				arg_390_1.mask_.raycastTarget = true

				arg_390_1:SetGaussion(false)
			end

			local var_393_19 = 0.0166666666666667

			if var_393_18 <= arg_390_1.time_ and arg_390_1.time_ < var_393_18 + var_393_19 then
				local var_393_20 = (arg_390_1.time_ - var_393_18) / var_393_19
				local var_393_21 = Color.New(0, 0, 0)

				var_393_21.a = Mathf.Lerp(1, 0, var_393_20)
				arg_390_1.mask_.color = var_393_21
			end

			if arg_390_1.time_ >= var_393_18 + var_393_19 and arg_390_1.time_ < var_393_18 + var_393_19 + arg_393_0 then
				local var_393_22 = Color.New(0, 0, 0)
				local var_393_23 = 0

				arg_390_1.mask_.enabled = false
				var_393_22.a = var_393_23
				arg_390_1.mask_.color = var_393_22
			end

			local var_393_24 = 2

			if var_393_24 < arg_390_1.time_ and arg_390_1.time_ <= var_393_24 + arg_393_0 then
				local var_393_25 = manager.ui.mainCamera.transform.localPosition
				local var_393_26 = Vector3.New(0, 0, 10) + Vector3.New(var_393_25.x, var_393_25.y, 0)
				local var_393_27 = arg_390_1.bgs_.STblack

				var_393_27.transform.localPosition = var_393_26
				var_393_27.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_393_28 = var_393_27:GetComponent("SpriteRenderer")

				if var_393_28 and var_393_28.sprite then
					local var_393_29 = (var_393_27.transform.localPosition - var_393_25).z
					local var_393_30 = manager.ui.mainCameraCom_
					local var_393_31 = 2 * var_393_29 * Mathf.Tan(var_393_30.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_393_32 = var_393_31 * var_393_30.aspect
					local var_393_33 = var_393_28.sprite.bounds.size.x
					local var_393_34 = var_393_28.sprite.bounds.size.y
					local var_393_35 = var_393_32 / var_393_33
					local var_393_36 = var_393_31 / var_393_34
					local var_393_37 = var_393_36 < var_393_35 and var_393_35 or var_393_36

					var_393_27.transform.localScale = Vector3.New(var_393_37, var_393_37, 0)
				end

				for iter_393_0, iter_393_1 in pairs(arg_390_1.bgs_) do
					if iter_393_0 ~= "STblack" then
						iter_393_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_393_38 = 2

			if var_393_38 < arg_390_1.time_ and arg_390_1.time_ <= var_393_38 + arg_393_0 then
				arg_390_1.fswbg_:SetActive(true)
				arg_390_1.dialog_:SetActive(false)

				arg_390_1.fswtw_.percent = 0

				local var_393_39 = arg_390_1:GetWordFromCfg(116091090)
				local var_393_40 = arg_390_1:FormatText(var_393_39.content)

				arg_390_1.fswt_.text = var_393_40

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.fswt_)

				arg_390_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_390_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_390_1.fswtw_:SetDirty()

				arg_390_1.typewritterCharCountI18N = 0

				SetActive(arg_390_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_390_1:ShowNextGo(false)
			end

			local var_393_41 = 2.01666666666667

			if var_393_41 < arg_390_1.time_ and arg_390_1.time_ <= var_393_41 + arg_393_0 then
				arg_390_1.var_.oldValueTypewriter = arg_390_1.fswtw_.percent

				SetActive(arg_390_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_390_1:ShowNextGo(false)
			end

			local var_393_42 = 61
			local var_393_43 = 4.2
			local var_393_44 = arg_390_1:GetWordFromCfg(116091090)
			local var_393_45 = arg_390_1:FormatText(var_393_44.content)
			local var_393_46, var_393_47 = arg_390_1:GetPercentByPara(var_393_45, 2)

			if var_393_41 < arg_390_1.time_ and arg_390_1.time_ <= var_393_41 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0

				local var_393_48 = var_393_42 <= 0 and var_393_43 or var_393_43 * ((var_393_47 - arg_390_1.typewritterCharCountI18N) / var_393_42)

				if var_393_48 > 0 and var_393_43 < var_393_48 then
					arg_390_1.talkMaxDuration = var_393_48

					if var_393_48 + var_393_41 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_48 + var_393_41
					end
				end
			end

			local var_393_49 = 4.2
			local var_393_50 = math.max(var_393_49, arg_390_1.talkMaxDuration)

			if var_393_41 <= arg_390_1.time_ and arg_390_1.time_ < var_393_41 + var_393_50 then
				local var_393_51 = (arg_390_1.time_ - var_393_41) / var_393_50

				arg_390_1.fswtw_.percent = Mathf.Lerp(arg_390_1.var_.oldValueTypewriter, var_393_46, var_393_51)
				arg_390_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_390_1.fswtw_:SetDirty()
			end

			if arg_390_1.time_ >= var_393_41 + var_393_50 and arg_390_1.time_ < var_393_41 + var_393_50 + arg_393_0 then
				arg_390_1.fswtw_.percent = var_393_46

				arg_390_1.fswtw_:SetDirty()
				arg_390_1:ShowNextGo(true)

				arg_390_1.typewritterCharCountI18N = var_393_47
			end

			local var_393_52 = 2.01666666666667

			if var_393_52 < arg_390_1.time_ and arg_390_1.time_ <= var_393_52 + arg_393_0 then
				local var_393_53 = arg_390_1.fswbg_.transform:Find("textbox/adapt/content") or arg_390_1.fswbg_.transform:Find("textbox/content")
				local var_393_54 = arg_390_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_393_55 = var_393_53:GetComponent("Text")
				local var_393_56 = var_393_53:GetComponent("RectTransform")

				var_393_55.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_393_56.offsetMin = Vector2.New(0, 0)
				var_393_56.offsetMax = Vector2.New(0, 0)
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
