return {
	Play323501001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 323501001
		arg_1_1.duration_ = 2.3

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play323501002(arg_1_1)
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
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_17 = 0.3

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_19 = 2

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_18) / var_4_19
				local var_4_21 = Color.New(0, 0, 0)

				var_4_21.a = Mathf.Lerp(1, 0, var_4_20)
				arg_1_1.mask_.color = var_4_21
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				local var_4_22 = Color.New(0, 0, 0)
				local var_4_23 = 0

				arg_1_1.mask_.enabled = false
				var_4_22.a = var_4_23
				arg_1_1.mask_.color = var_4_22
			end

			local var_4_24 = 0

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.fswbg_:SetActive(true)
				arg_1_1.dialog_:SetActive(false)

				arg_1_1.fswtw_.percent = 0

				local var_4_25 = arg_1_1:GetWordFromCfg(102)
				local var_4_26 = arg_1_1:FormatText(var_4_25.content)

				arg_1_1.fswt_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.fswt_)

				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_1_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_1_1.fswtw_:SetDirty()

				arg_1_1.typewritterCharCountI18N = 0

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_27 = 1.35

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.var_.oldValueTypewriter = arg_1_1.fswtw_.percent

				SetActive(arg_1_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_1_1:ShowNextGo(false)
			end

			local var_4_28 = 0
			local var_4_29 = 0.65
			local var_4_30 = arg_1_1:GetWordFromCfg(102)
			local var_4_31 = arg_1_1:FormatText(var_4_30.content)
			local var_4_32, var_4_33 = arg_1_1:GetPercentByPara(var_4_31, 1)

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				local var_4_34 = var_4_28 <= 0 and var_4_29 or var_4_29 * ((var_4_33 - arg_1_1.typewritterCharCountI18N) / var_4_28)

				if var_4_34 > 0 and var_4_29 < var_4_34 then
					arg_1_1.talkMaxDuration = var_4_34

					if var_4_34 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_34 + var_4_27
					end
				end
			end

			local var_4_35 = 0.65
			local var_4_36 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_27 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_36 then
				local var_4_37 = (arg_1_1.time_ - var_4_27) / var_4_36

				arg_1_1.fswtw_.percent = Mathf.Lerp(arg_1_1.var_.oldValueTypewriter, var_4_32, var_4_37)
				arg_1_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_1_1.fswtw_:SetDirty()
			end

			if arg_1_1.time_ >= var_4_27 + var_4_36 and arg_1_1.time_ < var_4_27 + var_4_36 + arg_4_0 then
				arg_1_1.fswtw_.percent = var_4_32

				arg_1_1.fswtw_:SetDirty()
				arg_1_1:ShowNextGo(true)

				arg_1_1.typewritterCharCountI18N = var_4_33
			end

			local var_4_38 = manager.ui.mainCamera.transform
			local var_4_39 = 0

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				local var_4_40 = arg_1_1.var_.effect444212
				local var_4_41
				local var_4_42 = var_4_38

				if not var_4_40 then
					var_4_40 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_starheart"), var_4_42)
					var_4_40.name = "444212"
					arg_1_1.var_.effect444212 = var_4_40
				else
					var_4_40.transform:SetParent(var_4_42)
				end

				var_4_40.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_40.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_4_43 = 0
			local var_4_44 = 0.3

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

			local var_4_49 = 0.166666666666667
			local var_4_50 = 1

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "effect"

				arg_1_1:AudioAction(var_4_51, var_4_52, "se_story_148", "se_story_148_amb_breath01", "")
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play323501002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 323501002
		arg_6_1.duration_ = 7

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play323501003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			local var_9_0 = "ST03"

			if arg_6_1.bgs_[var_9_0] == nil then
				local var_9_1 = Object.Instantiate(arg_6_1.paintGo_)

				var_9_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_9_0)
				var_9_1.name = var_9_0
				var_9_1.transform.parent = arg_6_1.stage_.transform
				var_9_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_6_1.bgs_[var_9_0] = var_9_1
			end

			local var_9_2 = 0.533333333333333

			if var_9_2 < arg_6_1.time_ and arg_6_1.time_ <= var_9_2 + arg_9_0 then
				local var_9_3 = manager.ui.mainCamera.transform.localPosition
				local var_9_4 = Vector3.New(0, 0, 10) + Vector3.New(var_9_3.x, var_9_3.y, 0)
				local var_9_5 = arg_6_1.bgs_.ST03

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
					if iter_9_0 ~= "ST03" then
						iter_9_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_9_16 = 0

			if var_9_16 < arg_6_1.time_ and arg_6_1.time_ <= var_9_16 + arg_9_0 then
				arg_6_1.allBtn_.enabled = false
			end

			local var_9_17 = 0.3

			if arg_6_1.time_ >= var_9_16 + var_9_17 and arg_6_1.time_ < var_9_16 + var_9_17 + arg_9_0 then
				arg_6_1.allBtn_.enabled = true
			end

			local var_9_18 = 0

			if var_9_18 < arg_6_1.time_ and arg_6_1.time_ <= var_9_18 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = true

				arg_6_1:SetGaussion(false)
			end

			local var_9_19 = 0.533333333333333

			if var_9_18 <= arg_6_1.time_ and arg_6_1.time_ < var_9_18 + var_9_19 then
				local var_9_20 = (arg_6_1.time_ - var_9_18) / var_9_19
				local var_9_21 = Color.New(0, 0, 0)

				var_9_21.a = Mathf.Lerp(0, 1, var_9_20)
				arg_6_1.mask_.color = var_9_21
			end

			if arg_6_1.time_ >= var_9_18 + var_9_19 and arg_6_1.time_ < var_9_18 + var_9_19 + arg_9_0 then
				local var_9_22 = Color.New(0, 0, 0)

				var_9_22.a = 1
				arg_6_1.mask_.color = var_9_22
			end

			local var_9_23 = 0.533333333333333

			if var_9_23 < arg_6_1.time_ and arg_6_1.time_ <= var_9_23 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = true

				arg_6_1:SetGaussion(false)
			end

			local var_9_24 = 1.46666666666567

			if var_9_23 <= arg_6_1.time_ and arg_6_1.time_ < var_9_23 + var_9_24 then
				local var_9_25 = (arg_6_1.time_ - var_9_23) / var_9_24
				local var_9_26 = Color.New(0, 0, 0)

				var_9_26.a = Mathf.Lerp(1, 0, var_9_25)
				arg_6_1.mask_.color = var_9_26
			end

			if arg_6_1.time_ >= var_9_23 + var_9_24 and arg_6_1.time_ < var_9_23 + var_9_24 + arg_9_0 then
				local var_9_27 = Color.New(0, 0, 0)
				local var_9_28 = 0

				arg_6_1.mask_.enabled = false
				var_9_27.a = var_9_28
				arg_6_1.mask_.color = var_9_27
			end

			local var_9_29 = 0.533333333333333

			if var_9_29 < arg_6_1.time_ and arg_6_1.time_ <= var_9_29 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(false)
				arg_6_1.dialog_:SetActive(false)
				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_30 = 0.55

			if var_9_30 < arg_6_1.time_ and arg_6_1.time_ <= var_9_30 + arg_9_0 then
				arg_6_1.fswbg_:SetActive(false)
				arg_6_1.dialog_:SetActive(false)
				SetActive(arg_6_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_6_1:ShowNextGo(false)
			end

			local var_9_31 = 0.533333333333333

			arg_6_1.isInRecall_ = false

			if var_9_31 < arg_6_1.time_ and arg_6_1.time_ <= var_9_31 + arg_9_0 then
				arg_6_1.screenFilterGo_:SetActive(true)

				arg_6_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_grey.asset")

				for iter_9_2, iter_9_3 in pairs(arg_6_1.actors_) do
					local var_9_32 = iter_9_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_9_4, iter_9_5 in ipairs(var_9_32) do
						if iter_9_5.color.r > 0.51 then
							iter_9_5.color = Color.New(1, 1, 1)
						else
							iter_9_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_9_33 = 0.666666666666667

			if var_9_31 <= arg_6_1.time_ and arg_6_1.time_ < var_9_31 + var_9_33 then
				local var_9_34 = (arg_6_1.time_ - var_9_31) / var_9_33

				arg_6_1.screenFilterEffect_.weight = Mathf.Lerp(0, 0.432, var_9_34)
			end

			if arg_6_1.time_ >= var_9_31 + var_9_33 and arg_6_1.time_ < var_9_31 + var_9_33 + arg_9_0 then
				arg_6_1.screenFilterEffect_.weight = 0.432
			end

			if arg_6_1.frameCnt_ <= 1 then
				arg_6_1.dialog_:SetActive(false)
			end

			local var_9_35 = 1.999999999999
			local var_9_36 = 0.3

			if var_9_35 < arg_6_1.time_ and arg_6_1.time_ <= var_9_35 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				arg_6_1.dialog_:SetActive(true)

				arg_6_1.dialogCg_.alpha = 0

				local var_9_37 = LeanTween.value(arg_6_1.dialog_, 0, 1, 0.3)

				var_9_37:setOnUpdate(LuaHelper.FloatAction(function(arg_10_0)
					arg_6_1.dialogCg_.alpha = arg_10_0
				end))
				var_9_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_6_1.dialog_)
					var_9_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_6_1.duration_ = arg_6_1.duration_ + 0.3

				SetActive(arg_6_1.leftNameGo_, false)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_6_1.iconTrs_.gameObject, false)
				arg_6_1.callingController_:SetSelectedState("normal")

				local var_9_38 = arg_6_1:GetWordFromCfg(323501002)
				local var_9_39 = arg_6_1:FormatText(var_9_38.content)

				arg_6_1.text_.text = var_9_39

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_40 = 12
				local var_9_41 = utf8.len(var_9_39)
				local var_9_42 = var_9_40 <= 0 and var_9_36 or var_9_36 * (var_9_41 / var_9_40)

				if var_9_42 > 0 and var_9_36 < var_9_42 then
					arg_6_1.talkMaxDuration = var_9_42
					var_9_35 = var_9_35 + 0.3

					if var_9_42 + var_9_35 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_42 + var_9_35
					end
				end

				arg_6_1.text_.text = var_9_39
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)
				arg_6_1:RecordContent(arg_6_1.text_.text)
			end

			local var_9_43 = var_9_35 + 0.3
			local var_9_44 = math.max(var_9_36, arg_6_1.talkMaxDuration)

			if var_9_43 <= arg_6_1.time_ and arg_6_1.time_ < var_9_43 + var_9_44 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - var_9_43) / var_9_44

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= var_9_43 + var_9_44 and arg_6_1.time_ < var_9_43 + var_9_44 + arg_9_0 then
				arg_6_1.typewritter.percent = 1

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(true)
			end
		end

		arg_6_1.nodeConfigList_ = {}

		arg_6_1:InitPlayNodeList()
	end,
	Play323501003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 323501003
		arg_12_1.duration_ = 6.77

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play323501004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "ST22"

			if arg_12_1.bgs_[var_15_0] == nil then
				local var_15_1 = Object.Instantiate(arg_12_1.paintGo_)

				var_15_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_15_0)
				var_15_1.name = var_15_0
				var_15_1.transform.parent = arg_12_1.stage_.transform
				var_15_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.bgs_[var_15_0] = var_15_1
			end

			local var_15_2 = 0

			if var_15_2 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				local var_15_3 = manager.ui.mainCamera.transform.localPosition
				local var_15_4 = Vector3.New(0, 0, 10) + Vector3.New(var_15_3.x, var_15_3.y, 0)
				local var_15_5 = arg_12_1.bgs_.ST22

				var_15_5.transform.localPosition = var_15_4
				var_15_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_15_6 = var_15_5:GetComponent("SpriteRenderer")

				if var_15_6 and var_15_6.sprite then
					local var_15_7 = (var_15_5.transform.localPosition - var_15_3).z
					local var_15_8 = manager.ui.mainCameraCom_
					local var_15_9 = 2 * var_15_7 * Mathf.Tan(var_15_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_15_10 = var_15_9 * var_15_8.aspect
					local var_15_11 = var_15_6.sprite.bounds.size.x
					local var_15_12 = var_15_6.sprite.bounds.size.y
					local var_15_13 = var_15_10 / var_15_11
					local var_15_14 = var_15_9 / var_15_12
					local var_15_15 = var_15_14 < var_15_13 and var_15_13 or var_15_14

					var_15_5.transform.localScale = Vector3.New(var_15_15, var_15_15, 0)
				end

				for iter_15_0, iter_15_1 in pairs(arg_12_1.bgs_) do
					if iter_15_0 ~= "ST22" then
						iter_15_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_15_16 = 0

			if var_15_16 < arg_12_1.time_ and arg_12_1.time_ <= var_15_16 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			local var_15_17 = 0.3

			if arg_12_1.time_ >= var_15_16 + var_15_17 and arg_12_1.time_ < var_15_16 + var_15_17 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			local var_15_18 = 0

			if var_15_18 < arg_12_1.time_ and arg_12_1.time_ <= var_15_18 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_19 = 2

			if var_15_18 <= arg_12_1.time_ and arg_12_1.time_ < var_15_18 + var_15_19 then
				local var_15_20 = (arg_12_1.time_ - var_15_18) / var_15_19
				local var_15_21 = Color.New(0, 0, 0)

				var_15_21.a = Mathf.Lerp(1, 0, var_15_20)
				arg_12_1.mask_.color = var_15_21
			end

			if arg_12_1.time_ >= var_15_18 + var_15_19 and arg_12_1.time_ < var_15_18 + var_15_19 + arg_15_0 then
				local var_15_22 = Color.New(0, 0, 0)
				local var_15_23 = 0

				arg_12_1.mask_.enabled = false
				var_15_22.a = var_15_23
				arg_12_1.mask_.color = var_15_22
			end

			local var_15_24 = 0.166666666666667
			local var_15_25 = 1

			if var_15_24 < arg_12_1.time_ and arg_12_1.time_ <= var_15_24 + arg_15_0 then
				local var_15_26 = "play"
				local var_15_27 = "effect"

				arg_12_1:AudioAction(var_15_26, var_15_27, "se_story_148", "se_story_148_amb_breath02", "")
			end

			local var_15_28 = 0
			local var_15_29 = 1

			if var_15_28 < arg_12_1.time_ and arg_12_1.time_ <= var_15_28 + arg_15_0 then
				local var_15_30 = "stop"
				local var_15_31 = "effect"

				arg_12_1:AudioAction(var_15_30, var_15_31, "se_story_148", "se_story_148_amb_breath01", "")
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_32 = 1.76666666666667
			local var_15_33 = 0.65

			if var_15_32 < arg_12_1.time_ and arg_12_1.time_ <= var_15_32 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_34 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_34:setOnUpdate(LuaHelper.FloatAction(function(arg_16_0)
					arg_12_1.dialogCg_.alpha = arg_16_0
				end))
				var_15_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_35 = arg_12_1:GetWordFromCfg(323501003)
				local var_15_36 = arg_12_1:FormatText(var_15_35.content)

				arg_12_1.text_.text = var_15_36

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_37 = 26
				local var_15_38 = utf8.len(var_15_36)
				local var_15_39 = var_15_37 <= 0 and var_15_33 or var_15_33 * (var_15_38 / var_15_37)

				if var_15_39 > 0 and var_15_33 < var_15_39 then
					arg_12_1.talkMaxDuration = var_15_39
					var_15_32 = var_15_32 + 0.3

					if var_15_39 + var_15_32 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_39 + var_15_32
					end
				end

				arg_12_1.text_.text = var_15_36
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_40 = var_15_32 + 0.3
			local var_15_41 = math.max(var_15_33, arg_12_1.talkMaxDuration)

			if var_15_40 <= arg_12_1.time_ and arg_12_1.time_ < var_15_40 + var_15_41 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_40) / var_15_41

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_40 + var_15_41 and arg_12_1.time_ < var_15_40 + var_15_41 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play323501004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 323501004
		arg_18_1.duration_ = 6.5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play323501005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = "ST59"

			if arg_18_1.bgs_[var_21_0] == nil then
				local var_21_1 = Object.Instantiate(arg_18_1.paintGo_)

				var_21_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_21_0)
				var_21_1.name = var_21_0
				var_21_1.transform.parent = arg_18_1.stage_.transform
				var_21_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_18_1.bgs_[var_21_0] = var_21_1
			end

			local var_21_2 = 0

			if var_21_2 < arg_18_1.time_ and arg_18_1.time_ <= var_21_2 + arg_21_0 then
				local var_21_3 = manager.ui.mainCamera.transform.localPosition
				local var_21_4 = Vector3.New(0, 0, 10) + Vector3.New(var_21_3.x, var_21_3.y, 0)
				local var_21_5 = arg_18_1.bgs_.ST59

				var_21_5.transform.localPosition = var_21_4
				var_21_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_21_6 = var_21_5:GetComponent("SpriteRenderer")

				if var_21_6 and var_21_6.sprite then
					local var_21_7 = (var_21_5.transform.localPosition - var_21_3).z
					local var_21_8 = manager.ui.mainCameraCom_
					local var_21_9 = 2 * var_21_7 * Mathf.Tan(var_21_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_21_10 = var_21_9 * var_21_8.aspect
					local var_21_11 = var_21_6.sprite.bounds.size.x
					local var_21_12 = var_21_6.sprite.bounds.size.y
					local var_21_13 = var_21_10 / var_21_11
					local var_21_14 = var_21_9 / var_21_12
					local var_21_15 = var_21_14 < var_21_13 and var_21_13 or var_21_14

					var_21_5.transform.localScale = Vector3.New(var_21_15, var_21_15, 0)
				end

				for iter_21_0, iter_21_1 in pairs(arg_18_1.bgs_) do
					if iter_21_0 ~= "ST59" then
						iter_21_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_21_16 = 0

			if var_21_16 < arg_18_1.time_ and arg_18_1.time_ <= var_21_16 + arg_21_0 then
				arg_18_1.allBtn_.enabled = false
			end

			local var_21_17 = 0.3

			if arg_18_1.time_ >= var_21_16 + var_21_17 and arg_18_1.time_ < var_21_16 + var_21_17 + arg_21_0 then
				arg_18_1.allBtn_.enabled = true
			end

			local var_21_18 = 0

			if var_21_18 < arg_18_1.time_ and arg_18_1.time_ <= var_21_18 + arg_21_0 then
				arg_18_1.mask_.enabled = true
				arg_18_1.mask_.raycastTarget = true

				arg_18_1:SetGaussion(false)
			end

			local var_21_19 = 2

			if var_21_18 <= arg_18_1.time_ and arg_18_1.time_ < var_21_18 + var_21_19 then
				local var_21_20 = (arg_18_1.time_ - var_21_18) / var_21_19
				local var_21_21 = Color.New(0, 0, 0)

				var_21_21.a = Mathf.Lerp(1, 0, var_21_20)
				arg_18_1.mask_.color = var_21_21
			end

			if arg_18_1.time_ >= var_21_18 + var_21_19 and arg_18_1.time_ < var_21_18 + var_21_19 + arg_21_0 then
				local var_21_22 = Color.New(0, 0, 0)
				local var_21_23 = 0

				arg_18_1.mask_.enabled = false
				var_21_22.a = var_21_23
				arg_18_1.mask_.color = var_21_22
			end

			if arg_18_1.frameCnt_ <= 1 then
				arg_18_1.dialog_:SetActive(false)
			end

			local var_21_24 = 1.5
			local var_21_25 = 0.7

			if var_21_24 < arg_18_1.time_ and arg_18_1.time_ <= var_21_24 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0

				arg_18_1.dialog_:SetActive(true)

				arg_18_1.dialogCg_.alpha = 0

				local var_21_26 = LeanTween.value(arg_18_1.dialog_, 0, 1, 0.3)

				var_21_26:setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
					arg_18_1.dialogCg_.alpha = arg_22_0
				end))
				var_21_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_18_1.dialog_)
					var_21_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_18_1.duration_ = arg_18_1.duration_ + 0.3

				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_27 = arg_18_1:GetWordFromCfg(323501004)
				local var_21_28 = arg_18_1:FormatText(var_21_27.content)

				arg_18_1.text_.text = var_21_28

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_29 = 28
				local var_21_30 = utf8.len(var_21_28)
				local var_21_31 = var_21_29 <= 0 and var_21_25 or var_21_25 * (var_21_30 / var_21_29)

				if var_21_31 > 0 and var_21_25 < var_21_31 then
					arg_18_1.talkMaxDuration = var_21_31
					var_21_24 = var_21_24 + 0.3

					if var_21_31 + var_21_24 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_31 + var_21_24
					end
				end

				arg_18_1.text_.text = var_21_28
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_32 = var_21_24 + 0.3
			local var_21_33 = math.max(var_21_25, arg_18_1.talkMaxDuration)

			if var_21_32 <= arg_18_1.time_ and arg_18_1.time_ < var_21_32 + var_21_33 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_32) / var_21_33

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_32 + var_21_33 and arg_18_1.time_ < var_21_32 + var_21_33 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play323501005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 323501005
		arg_24_1.duration_ = 6.45

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play323501006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = "ST47"

			if arg_24_1.bgs_[var_27_0] == nil then
				local var_27_1 = Object.Instantiate(arg_24_1.paintGo_)

				var_27_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_27_0)
				var_27_1.name = var_27_0
				var_27_1.transform.parent = arg_24_1.stage_.transform
				var_27_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.bgs_[var_27_0] = var_27_1
			end

			local var_27_2 = 0

			if var_27_2 < arg_24_1.time_ and arg_24_1.time_ <= var_27_2 + arg_27_0 then
				local var_27_3 = manager.ui.mainCamera.transform.localPosition
				local var_27_4 = Vector3.New(0, 0, 10) + Vector3.New(var_27_3.x, var_27_3.y, 0)
				local var_27_5 = arg_24_1.bgs_.ST47

				var_27_5.transform.localPosition = var_27_4
				var_27_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_27_6 = var_27_5:GetComponent("SpriteRenderer")

				if var_27_6 and var_27_6.sprite then
					local var_27_7 = (var_27_5.transform.localPosition - var_27_3).z
					local var_27_8 = manager.ui.mainCameraCom_
					local var_27_9 = 2 * var_27_7 * Mathf.Tan(var_27_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_27_10 = var_27_9 * var_27_8.aspect
					local var_27_11 = var_27_6.sprite.bounds.size.x
					local var_27_12 = var_27_6.sprite.bounds.size.y
					local var_27_13 = var_27_10 / var_27_11
					local var_27_14 = var_27_9 / var_27_12
					local var_27_15 = var_27_14 < var_27_13 and var_27_13 or var_27_14

					var_27_5.transform.localScale = Vector3.New(var_27_15, var_27_15, 0)
				end

				for iter_27_0, iter_27_1 in pairs(arg_24_1.bgs_) do
					if iter_27_0 ~= "ST47" then
						iter_27_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_27_16 = 0

			if var_27_16 < arg_24_1.time_ and arg_24_1.time_ <= var_27_16 + arg_27_0 then
				arg_24_1.allBtn_.enabled = false
			end

			local var_27_17 = 0.3

			if arg_24_1.time_ >= var_27_16 + var_27_17 and arg_24_1.time_ < var_27_16 + var_27_17 + arg_27_0 then
				arg_24_1.allBtn_.enabled = true
			end

			local var_27_18 = 0

			if var_27_18 < arg_24_1.time_ and arg_24_1.time_ <= var_27_18 + arg_27_0 then
				arg_24_1.mask_.enabled = true
				arg_24_1.mask_.raycastTarget = true

				arg_24_1:SetGaussion(false)
			end

			local var_27_19 = 2

			if var_27_18 <= arg_24_1.time_ and arg_24_1.time_ < var_27_18 + var_27_19 then
				local var_27_20 = (arg_24_1.time_ - var_27_18) / var_27_19
				local var_27_21 = Color.New(0, 0, 0)

				var_27_21.a = Mathf.Lerp(1, 0, var_27_20)
				arg_24_1.mask_.color = var_27_21
			end

			if arg_24_1.time_ >= var_27_18 + var_27_19 and arg_24_1.time_ < var_27_18 + var_27_19 + arg_27_0 then
				local var_27_22 = Color.New(0, 0, 0)
				local var_27_23 = 0

				arg_24_1.mask_.enabled = false
				var_27_22.a = var_27_23
				arg_24_1.mask_.color = var_27_22
			end

			if arg_24_1.frameCnt_ <= 1 then
				arg_24_1.dialog_:SetActive(false)
			end

			local var_27_24 = 1.44592430489138
			local var_27_25 = 0.5

			if var_27_24 < arg_24_1.time_ and arg_24_1.time_ <= var_27_24 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0

				arg_24_1.dialog_:SetActive(true)

				arg_24_1.dialogCg_.alpha = 0

				local var_27_26 = LeanTween.value(arg_24_1.dialog_, 0, 1, 0.3)

				var_27_26:setOnUpdate(LuaHelper.FloatAction(function(arg_28_0)
					arg_24_1.dialogCg_.alpha = arg_28_0
				end))
				var_27_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_24_1.dialog_)
					var_27_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_24_1.duration_ = arg_24_1.duration_ + 0.3

				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_27 = arg_24_1:GetWordFromCfg(323501005)
				local var_27_28 = arg_24_1:FormatText(var_27_27.content)

				arg_24_1.text_.text = var_27_28

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_29 = 20
				local var_27_30 = utf8.len(var_27_28)
				local var_27_31 = var_27_29 <= 0 and var_27_25 or var_27_25 * (var_27_30 / var_27_29)

				if var_27_31 > 0 and var_27_25 < var_27_31 then
					arg_24_1.talkMaxDuration = var_27_31
					var_27_24 = var_27_24 + 0.3

					if var_27_31 + var_27_24 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_31 + var_27_24
					end
				end

				arg_24_1.text_.text = var_27_28
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_32 = var_27_24 + 0.3
			local var_27_33 = math.max(var_27_25, arg_24_1.talkMaxDuration)

			if var_27_32 <= arg_24_1.time_ and arg_24_1.time_ < var_27_32 + var_27_33 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_32) / var_27_33

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_32 + var_27_33 and arg_24_1.time_ < var_27_32 + var_27_33 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play323501006 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 323501006
		arg_30_1.duration_ = 6.87

		local var_30_0 = {
			zh = 6.76666666666667,
			ja = 6.86666666666667
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
				arg_30_0:Play323501007(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = "J21f"

			if arg_30_1.bgs_[var_33_0] == nil then
				local var_33_1 = Object.Instantiate(arg_30_1.paintGo_)

				var_33_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_33_0)
				var_33_1.name = var_33_0
				var_33_1.transform.parent = arg_30_1.stage_.transform
				var_33_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_30_1.bgs_[var_33_0] = var_33_1
			end

			local var_33_2 = 0

			if var_33_2 < arg_30_1.time_ and arg_30_1.time_ <= var_33_2 + arg_33_0 then
				local var_33_3 = manager.ui.mainCamera.transform.localPosition
				local var_33_4 = Vector3.New(0, 0, 10) + Vector3.New(var_33_3.x, var_33_3.y, 0)
				local var_33_5 = arg_30_1.bgs_.J21f

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
					if iter_33_0 ~= "J21f" then
						iter_33_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_33_16 = 0

			if var_33_16 < arg_30_1.time_ and arg_30_1.time_ <= var_33_16 + arg_33_0 then
				arg_30_1.allBtn_.enabled = false
			end

			local var_33_17 = 0.3

			if arg_30_1.time_ >= var_33_16 + var_33_17 and arg_30_1.time_ < var_33_16 + var_33_17 + arg_33_0 then
				arg_30_1.allBtn_.enabled = true
			end

			local var_33_18 = 0

			if var_33_18 < arg_30_1.time_ and arg_30_1.time_ <= var_33_18 + arg_33_0 then
				arg_30_1.mask_.enabled = true
				arg_30_1.mask_.raycastTarget = true

				arg_30_1:SetGaussion(false)
			end

			local var_33_19 = 1.699999999999

			if var_33_18 <= arg_30_1.time_ and arg_30_1.time_ < var_33_18 + var_33_19 then
				local var_33_20 = (arg_30_1.time_ - var_33_18) / var_33_19
				local var_33_21 = Color.New(1, 1, 1)

				var_33_21.a = Mathf.Lerp(1, 0, var_33_20)
				arg_30_1.mask_.color = var_33_21
			end

			if arg_30_1.time_ >= var_33_18 + var_33_19 and arg_30_1.time_ < var_33_18 + var_33_19 + arg_33_0 then
				local var_33_22 = Color.New(1, 1, 1)
				local var_33_23 = 0

				arg_30_1.mask_.enabled = false
				var_33_22.a = var_33_23
				arg_30_1.mask_.color = var_33_22
			end

			local var_33_24 = "1067ui_story"

			if arg_30_1.actors_[var_33_24] == nil then
				local var_33_25 = Asset.Load("Char/" .. "1067ui_story")

				if not isNil(var_33_25) then
					local var_33_26 = Object.Instantiate(Asset.Load("Char/" .. "1067ui_story"), arg_30_1.stage_.transform)

					var_33_26.name = var_33_24
					var_33_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_30_1.actors_[var_33_24] = var_33_26

					local var_33_27 = var_33_26:GetComponentInChildren(typeof(CharacterEffect))

					var_33_27.enabled = true

					local var_33_28 = GameObjectTools.GetOrAddComponent(var_33_26, typeof(DynamicBoneHelper))

					if var_33_28 then
						var_33_28:EnableDynamicBone(false)
					end

					arg_30_1:ShowWeapon(var_33_27.transform, false)

					arg_30_1.var_[var_33_24 .. "Animator"] = var_33_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_30_1.var_[var_33_24 .. "Animator"].applyRootMotion = true
					arg_30_1.var_[var_33_24 .. "LipSync"] = var_33_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_33_29 = arg_30_1.actors_["1067ui_story"]
			local var_33_30 = 0

			if var_33_30 < arg_30_1.time_ and arg_30_1.time_ <= var_33_30 + arg_33_0 and not isNil(var_33_29) and arg_30_1.var_.characterEffect1067ui_story == nil then
				arg_30_1.var_.characterEffect1067ui_story = var_33_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_31 = 0.200000002980232

			if var_33_30 <= arg_30_1.time_ and arg_30_1.time_ < var_33_30 + var_33_31 and not isNil(var_33_29) then
				local var_33_32 = (arg_30_1.time_ - var_33_30) / var_33_31

				if arg_30_1.var_.characterEffect1067ui_story and not isNil(var_33_29) then
					arg_30_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= var_33_30 + var_33_31 and arg_30_1.time_ < var_33_30 + var_33_31 + arg_33_0 and not isNil(var_33_29) and arg_30_1.var_.characterEffect1067ui_story then
				arg_30_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_33_33 = manager.ui.mainCamera.transform
			local var_33_34 = 0

			if var_33_34 < arg_30_1.time_ and arg_30_1.time_ <= var_33_34 + arg_33_0 then
				local var_33_35 = arg_30_1.var_.effect444212

				if var_33_35 then
					Object.Destroy(var_33_35)

					arg_30_1.var_.effect444212 = nil
				end
			end

			local var_33_36 = 0
			local var_33_37 = 1

			if var_33_36 < arg_30_1.time_ and arg_30_1.time_ <= var_33_36 + arg_33_0 then
				local var_33_38 = "play"
				local var_33_39 = "effect"

				arg_30_1:AudioAction(var_33_38, var_33_39, "se_story_148", "se_story_148_amb_breath03", "")
			end

			local var_33_40 = 1.55326400073245
			local var_33_41 = 1

			if var_33_40 < arg_30_1.time_ and arg_30_1.time_ <= var_33_40 + arg_33_0 then
				local var_33_42 = "play"
				local var_33_43 = "effect"

				arg_30_1:AudioAction(var_33_42, var_33_43, "se_story_148", "se_story_148_motorcycle", "")
			end

			local var_33_44 = 0.866666666666667
			local var_33_45 = 1

			if var_33_44 < arg_30_1.time_ and arg_30_1.time_ <= var_33_44 + arg_33_0 then
				local var_33_46 = "play"
				local var_33_47 = "effect"

				arg_30_1:AudioAction(var_33_46, var_33_47, "se_story_148", "se_story_148_amb_wind", "")
			end

			local var_33_48 = 0
			local var_33_49 = 0.3

			if var_33_48 < arg_30_1.time_ and arg_30_1.time_ <= var_33_48 + arg_33_0 then
				local var_33_50 = "play"
				local var_33_51 = "music"

				arg_30_1:AudioAction(var_33_50, var_33_51, "ui_battle", "ui_battle_stopbgm", "")

				local var_33_52 = ""
				local var_33_53 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_33_53 ~= "" then
					if arg_30_1.bgmTxt_.text ~= var_33_53 and arg_30_1.bgmTxt_.text ~= "" then
						if arg_30_1.bgmTxt2_.text ~= "" then
							arg_30_1.bgmTxt_.text = arg_30_1.bgmTxt2_.text
						end

						arg_30_1.bgmTxt2_.text = var_33_53

						arg_30_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_30_1.bgmTxt_.text = var_33_53
						arg_30_1.bgmTxt2_.text = var_33_53
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

			local var_33_54 = 0.433333333333333
			local var_33_55 = 1

			if var_33_54 < arg_30_1.time_ and arg_30_1.time_ <= var_33_54 + arg_33_0 then
				local var_33_56 = "play"
				local var_33_57 = "music"

				arg_30_1:AudioAction(var_33_56, var_33_57, "bgm_activity_4_8_story_dahuang_pingyuan", "bgm_activity_4_8_story_dahuang_pingyuan", "bgm_activity_4_8_story_dahuang_pingyuan.awb")

				local var_33_58 = ""
				local var_33_59 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_pingyuan", "bgm_activity_4_8_story_dahuang_pingyuan")

				if var_33_59 ~= "" then
					if arg_30_1.bgmTxt_.text ~= var_33_59 and arg_30_1.bgmTxt_.text ~= "" then
						if arg_30_1.bgmTxt2_.text ~= "" then
							arg_30_1.bgmTxt_.text = arg_30_1.bgmTxt2_.text
						end

						arg_30_1.bgmTxt2_.text = var_33_59

						arg_30_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_30_1.bgmTxt_.text = var_33_59
						arg_30_1.bgmTxt2_.text = var_33_59
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

			local var_33_60 = 0.466666666666667
			local var_33_61 = 1

			if var_33_60 < arg_30_1.time_ and arg_30_1.time_ <= var_33_60 + arg_33_0 then
				local var_33_62 = "play"
				local var_33_63 = "music"

				arg_30_1:AudioAction(var_33_62, var_33_63, "bgm_activity_4_8_story_dahuang_pingyuan", "init_battle", "bgm_activity_4_8_story_dahuang_pingyuan.awb")

				local var_33_64 = ""
				local var_33_65 = manager.audio:GetAudioName("bgm_activity_4_8_story_dahuang_pingyuan", "init_battle")

				if var_33_65 ~= "" then
					if arg_30_1.bgmTxt_.text ~= var_33_65 and arg_30_1.bgmTxt_.text ~= "" then
						if arg_30_1.bgmTxt2_.text ~= "" then
							arg_30_1.bgmTxt_.text = arg_30_1.bgmTxt2_.text
						end

						arg_30_1.bgmTxt2_.text = var_33_65

						arg_30_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_30_1.bgmTxt_.text = var_33_65
						arg_30_1.bgmTxt2_.text = var_33_65
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

			local var_33_66 = 0

			arg_30_1.isInRecall_ = false

			if var_33_66 < arg_30_1.time_ and arg_30_1.time_ <= var_33_66 + arg_33_0 then
				arg_30_1.screenFilterGo_:SetActive(false)

				for iter_33_2, iter_33_3 in pairs(arg_30_1.actors_) do
					local var_33_67 = iter_33_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_33_4, iter_33_5 in ipairs(var_33_67) do
						if iter_33_5.color.r > 0.51 then
							iter_33_5.color = Color.New(1, 1, 1)
						else
							iter_33_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_33_68 = 0.0166666666666667

			if var_33_66 <= arg_30_1.time_ and arg_30_1.time_ < var_33_66 + var_33_68 then
				local var_33_69 = (arg_30_1.time_ - var_33_66) / var_33_68

				arg_30_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_33_69)
			end

			if arg_30_1.time_ >= var_33_66 + var_33_68 and arg_30_1.time_ < var_33_66 + var_33_68 + arg_33_0 then
				arg_30_1.screenFilterEffect_.weight = 0
			end

			if arg_30_1.frameCnt_ <= 1 then
				arg_30_1.dialog_:SetActive(false)
			end

			local var_33_70 = 1.86666666666667
			local var_33_71 = 0.575

			if var_33_70 < arg_30_1.time_ and arg_30_1.time_ <= var_33_70 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				arg_30_1.dialog_:SetActive(true)

				arg_30_1.dialogCg_.alpha = 0

				local var_33_72 = LeanTween.value(arg_30_1.dialog_, 0, 1, 0.3)

				var_33_72:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_30_1.dialogCg_.alpha = arg_37_0
				end))
				var_33_72:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_30_1.dialog_)
					var_33_72:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_30_1.duration_ = arg_30_1.duration_ + 0.3

				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_73 = arg_30_1:FormatText(StoryNameCfg[1459].name)

				arg_30_1.leftNameTxt_.text = var_33_73

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, true)
				arg_30_1.iconController_:SetSelectedState("hero")

				arg_30_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10162")

				arg_30_1.callingController_:SetSelectedState("normal")

				arg_30_1.keyicon_.color = Color.New(1, 1, 1)
				arg_30_1.icon_.color = Color.New(1, 1, 1)

				local var_33_74 = arg_30_1:GetWordFromCfg(323501006)
				local var_33_75 = arg_30_1:FormatText(var_33_74.content)

				arg_30_1.text_.text = var_33_75

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_76 = 23
				local var_33_77 = utf8.len(var_33_75)
				local var_33_78 = var_33_76 <= 0 and var_33_71 or var_33_71 * (var_33_77 / var_33_76)

				if var_33_78 > 0 and var_33_71 < var_33_78 then
					arg_30_1.talkMaxDuration = var_33_78
					var_33_70 = var_33_70 + 0.3

					if var_33_78 + var_33_70 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_78 + var_33_70
					end
				end

				arg_30_1.text_.text = var_33_75
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323501", "323501006", "story_v_out_323501.awb") ~= 0 then
					local var_33_79 = manager.audio:GetVoiceLength("story_v_out_323501", "323501006", "story_v_out_323501.awb") / 1000

					if var_33_79 + var_33_70 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_79 + var_33_70
					end

					if var_33_74.prefab_name ~= "" and arg_30_1.actors_[var_33_74.prefab_name] ~= nil then
						local var_33_80 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_74.prefab_name].transform, "story_v_out_323501", "323501006", "story_v_out_323501.awb")

						arg_30_1:RecordAudio("323501006", var_33_80)
						arg_30_1:RecordAudio("323501006", var_33_80)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_323501", "323501006", "story_v_out_323501.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_323501", "323501006", "story_v_out_323501.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_81 = var_33_70 + 0.3
			local var_33_82 = math.max(var_33_71, arg_30_1.talkMaxDuration)

			if var_33_81 <= arg_30_1.time_ and arg_30_1.time_ < var_33_81 + var_33_82 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_81) / var_33_82

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_81 + var_33_82 and arg_30_1.time_ < var_33_81 + var_33_82 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play323501007 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 323501007
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play323501008(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1067ui_story"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1067ui_story == nil then
				arg_39_1.var_.characterEffect1067ui_story = var_42_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.200000002980232

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 and not isNil(var_42_0) then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2

				if arg_39_1.var_.characterEffect1067ui_story and not isNil(var_42_0) then
					local var_42_4 = Mathf.Lerp(0, 0.5, var_42_3)

					arg_39_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1067ui_story.fillRatio = var_42_4
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1067ui_story then
				local var_42_5 = 0.5

				arg_39_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1067ui_story.fillRatio = var_42_5
			end

			local var_42_6 = 0
			local var_42_7 = 1.25

			if var_42_6 < arg_39_1.time_ and arg_39_1.time_ <= var_42_6 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_8 = arg_39_1:GetWordFromCfg(323501007)
				local var_42_9 = arg_39_1:FormatText(var_42_8.content)

				arg_39_1.text_.text = var_42_9

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_10 = 50
				local var_42_11 = utf8.len(var_42_9)
				local var_42_12 = var_42_10 <= 0 and var_42_7 or var_42_7 * (var_42_11 / var_42_10)

				if var_42_12 > 0 and var_42_7 < var_42_12 then
					arg_39_1.talkMaxDuration = var_42_12

					if var_42_12 + var_42_6 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_12 + var_42_6
					end
				end

				arg_39_1.text_.text = var_42_9
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_13 = math.max(var_42_7, arg_39_1.talkMaxDuration)

			if var_42_6 <= arg_39_1.time_ and arg_39_1.time_ < var_42_6 + var_42_13 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_6) / var_42_13

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_6 + var_42_13 and arg_39_1.time_ < var_42_6 + var_42_13 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play323501008 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 323501008
		arg_43_1.duration_ = 5.63

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play323501009(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = manager.ui.mainCamera.transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				local var_46_2 = arg_43_1.var_.effect444233
				local var_46_3
				local var_46_4 = var_46_0

				if not var_46_2 then
					var_46_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_46_4)
					var_46_2.name = "444233"
					arg_43_1.var_.effect444233 = var_46_2
				else
					var_46_2.transform:SetParent(var_46_4)
				end

				var_46_2.transform.localPosition = Vector3.New(-1.41, -0.06, -0.09)
				var_46_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_46_5 = manager.ui.mainCamera.transform
			local var_46_6 = 0.2

			if var_46_6 < arg_43_1.time_ and arg_43_1.time_ <= var_46_6 + arg_46_0 then
				local var_46_7 = arg_43_1.var_.effect444234
				local var_46_8
				local var_46_9 = var_46_5

				if not var_46_7 then
					var_46_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_46_9)
					var_46_7.name = "444234"
					arg_43_1.var_.effect444234 = var_46_7
				else
					var_46_7.transform:SetParent(var_46_9)
				end

				var_46_7.transform.localPosition = Vector3.New(-0.25, -0.28, 0)
				var_46_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_46_10 = manager.ui.mainCamera.transform
			local var_46_11 = 0.433333333333334

			if var_46_11 < arg_43_1.time_ and arg_43_1.time_ <= var_46_11 + arg_46_0 then
				local var_46_12 = arg_43_1.var_.effect444235
				local var_46_13
				local var_46_14 = var_46_10

				if not var_46_12 then
					var_46_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), var_46_14)
					var_46_12.name = "444235"
					arg_43_1.var_.effect444235 = var_46_12
				else
					var_46_12.transform:SetParent(var_46_14)
				end

				var_46_12.transform.localPosition = Vector3.New(0.63, -0.34, -1.1)
				var_46_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_46_15 = manager.ui.mainCamera.transform
			local var_46_16 = 0.433333333333333

			if var_46_16 < arg_43_1.time_ and arg_43_1.time_ <= var_46_16 + arg_46_0 then
				local var_46_17 = arg_43_1.var_.effect444233

				if var_46_17 then
					Object.Destroy(var_46_17)

					arg_43_1.var_.effect444233 = nil
				end
			end

			local var_46_18 = manager.ui.mainCamera.transform
			local var_46_19 = 0.633333333333333

			if var_46_19 < arg_43_1.time_ and arg_43_1.time_ <= var_46_19 + arg_46_0 then
				local var_46_20 = arg_43_1.var_.effect444234

				if var_46_20 then
					Object.Destroy(var_46_20)

					arg_43_1.var_.effect444234 = nil
				end
			end

			local var_46_21 = manager.ui.mainCamera.transform
			local var_46_22 = 0.866666666666667

			if var_46_22 < arg_43_1.time_ and arg_43_1.time_ <= var_46_22 + arg_46_0 then
				local var_46_23 = arg_43_1.var_.effect444235

				if var_46_23 then
					Object.Destroy(var_46_23)

					arg_43_1.var_.effect444235 = nil
				end
			end

			local var_46_24 = 0

			if var_46_24 < arg_43_1.time_ and arg_43_1.time_ <= var_46_24 + arg_46_0 then
				arg_43_1.allBtn_.enabled = false
			end

			local var_46_25 = 1.33333333333333

			if arg_43_1.time_ >= var_46_24 + var_46_25 and arg_43_1.time_ < var_46_24 + var_46_25 + arg_46_0 then
				arg_43_1.allBtn_.enabled = true
			end

			local var_46_26 = 0
			local var_46_27 = 1

			if var_46_26 < arg_43_1.time_ and arg_43_1.time_ <= var_46_26 + arg_46_0 then
				local var_46_28 = "play"
				local var_46_29 = "effect"

				arg_43_1:AudioAction(var_46_28, var_46_29, "se_story_136", "se_story_136_gun", "")
			end

			if arg_43_1.frameCnt_ <= 1 then
				arg_43_1.dialog_:SetActive(false)
			end

			local var_46_30 = 0.633333333333333
			local var_46_31 = 0.875

			if var_46_30 < arg_43_1.time_ and arg_43_1.time_ <= var_46_30 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				arg_43_1.dialog_:SetActive(true)

				arg_43_1.dialogCg_.alpha = 0

				local var_46_32 = LeanTween.value(arg_43_1.dialog_, 0, 1, 0.3)

				var_46_32:setOnUpdate(LuaHelper.FloatAction(function(arg_47_0)
					arg_43_1.dialogCg_.alpha = arg_47_0
				end))
				var_46_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_43_1.dialog_)
					var_46_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_43_1.duration_ = arg_43_1.duration_ + 0.3

				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_33 = arg_43_1:GetWordFromCfg(323501008)
				local var_46_34 = arg_43_1:FormatText(var_46_33.content)

				arg_43_1.text_.text = var_46_34

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_35 = 35
				local var_46_36 = utf8.len(var_46_34)
				local var_46_37 = var_46_35 <= 0 and var_46_31 or var_46_31 * (var_46_36 / var_46_35)

				if var_46_37 > 0 and var_46_31 < var_46_37 then
					arg_43_1.talkMaxDuration = var_46_37
					var_46_30 = var_46_30 + 0.3

					if var_46_37 + var_46_30 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_37 + var_46_30
					end
				end

				arg_43_1.text_.text = var_46_34
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_38 = var_46_30 + 0.3
			local var_46_39 = math.max(var_46_31, arg_43_1.talkMaxDuration)

			if var_46_38 <= arg_43_1.time_ and arg_43_1.time_ < var_46_38 + var_46_39 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_38) / var_46_39

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_38 + var_46_39 and arg_43_1.time_ < var_46_38 + var_46_39 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play323501009 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 323501009
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play323501010(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 1.45

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_2 = arg_49_1:GetWordFromCfg(323501009)
				local var_52_3 = arg_49_1:FormatText(var_52_2.content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 58
				local var_52_5 = utf8.len(var_52_3)
				local var_52_6 = var_52_4 <= 0 and var_52_1 or var_52_1 * (var_52_5 / var_52_4)

				if var_52_6 > 0 and var_52_1 < var_52_6 then
					arg_49_1.talkMaxDuration = var_52_6

					if var_52_6 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_6 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_7 and arg_49_1.time_ < var_52_0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play323501010 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 323501010
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play323501011(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.1
			local var_56_1 = 1

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				local var_56_2 = "play"
				local var_56_3 = "effect"

				arg_53_1:AudioAction(var_56_2, var_56_3, "se_story_144", "se_story_144_gun_battle", "")
			end

			local var_56_4 = 0
			local var_56_5 = 1.5

			if var_56_4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(323501010)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_8 = 60
				local var_56_9 = utf8.len(var_56_7)
				local var_56_10 = var_56_8 <= 0 and var_56_5 or var_56_5 * (var_56_9 / var_56_8)

				if var_56_10 > 0 and var_56_5 < var_56_10 then
					arg_53_1.talkMaxDuration = var_56_10

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_11 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_11 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_11

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_11 and arg_53_1.time_ < var_56_4 + var_56_11 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play323501011 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 323501011
		arg_57_1.duration_ = 2.93

		local var_57_0 = {
			zh = 1.9,
			ja = 2.933
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
				arg_57_0:Play323501012(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = "1069ui_story"

			if arg_57_1.actors_[var_60_0] == nil then
				local var_60_1 = Asset.Load("Char/" .. "1069ui_story")

				if not isNil(var_60_1) then
					local var_60_2 = Object.Instantiate(Asset.Load("Char/" .. "1069ui_story"), arg_57_1.stage_.transform)

					var_60_2.name = var_60_0
					var_60_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_57_1.actors_[var_60_0] = var_60_2

					local var_60_3 = var_60_2:GetComponentInChildren(typeof(CharacterEffect))

					var_60_3.enabled = true

					local var_60_4 = GameObjectTools.GetOrAddComponent(var_60_2, typeof(DynamicBoneHelper))

					if var_60_4 then
						var_60_4:EnableDynamicBone(false)
					end

					arg_57_1:ShowWeapon(var_60_3.transform, false)

					arg_57_1.var_[var_60_0 .. "Animator"] = var_60_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_57_1.var_[var_60_0 .. "Animator"].applyRootMotion = true
					arg_57_1.var_[var_60_0 .. "LipSync"] = var_60_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_60_5 = arg_57_1.actors_["1069ui_story"]
			local var_60_6 = 0

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.characterEffect1069ui_story == nil then
				arg_57_1.var_.characterEffect1069ui_story = var_60_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_7 = 0.200000002980232

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_7 and not isNil(var_60_5) then
				local var_60_8 = (arg_57_1.time_ - var_60_6) / var_60_7

				if arg_57_1.var_.characterEffect1069ui_story and not isNil(var_60_5) then
					arg_57_1.var_.characterEffect1069ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_6 + var_60_7 and arg_57_1.time_ < var_60_6 + var_60_7 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.characterEffect1069ui_story then
				arg_57_1.var_.characterEffect1069ui_story.fillFlat = false
			end

			local var_60_9 = 0
			local var_60_10 = 0.225

			if var_60_9 < arg_57_1.time_ and arg_57_1.time_ <= var_60_9 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_11 = arg_57_1:FormatText(StoryNameCfg[1460].name)

				arg_57_1.leftNameTxt_.text = var_60_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10166")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_12 = arg_57_1:GetWordFromCfg(323501011)
				local var_60_13 = arg_57_1:FormatText(var_60_12.content)

				arg_57_1.text_.text = var_60_13

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_14 = 9
				local var_60_15 = utf8.len(var_60_13)
				local var_60_16 = var_60_14 <= 0 and var_60_10 or var_60_10 * (var_60_15 / var_60_14)

				if var_60_16 > 0 and var_60_10 < var_60_16 then
					arg_57_1.talkMaxDuration = var_60_16

					if var_60_16 + var_60_9 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_16 + var_60_9
					end
				end

				arg_57_1.text_.text = var_60_13
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323501", "323501011", "story_v_out_323501.awb") ~= 0 then
					local var_60_17 = manager.audio:GetVoiceLength("story_v_out_323501", "323501011", "story_v_out_323501.awb") / 1000

					if var_60_17 + var_60_9 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_17 + var_60_9
					end

					if var_60_12.prefab_name ~= "" and arg_57_1.actors_[var_60_12.prefab_name] ~= nil then
						local var_60_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_12.prefab_name].transform, "story_v_out_323501", "323501011", "story_v_out_323501.awb")

						arg_57_1:RecordAudio("323501011", var_60_18)
						arg_57_1:RecordAudio("323501011", var_60_18)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_323501", "323501011", "story_v_out_323501.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_323501", "323501011", "story_v_out_323501.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_19 = math.max(var_60_10, arg_57_1.talkMaxDuration)

			if var_60_9 <= arg_57_1.time_ and arg_57_1.time_ < var_60_9 + var_60_19 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_9) / var_60_19

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_9 + var_60_19 and arg_57_1.time_ < var_60_9 + var_60_19 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play323501012 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 323501012
		arg_61_1.duration_ = 4.87

		local var_61_0 = {
			zh = 3.9,
			ja = 4.866
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
				arg_61_0:Play323501013(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1067ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1067ui_story == nil then
				arg_61_1.var_.characterEffect1067ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1067ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1067ui_story then
				arg_61_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_64_4 = arg_61_1.actors_["1069ui_story"]
			local var_64_5 = 0

			if var_64_5 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect1069ui_story == nil then
				arg_61_1.var_.characterEffect1069ui_story = var_64_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_6 = 0.200000002980232

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_6 and not isNil(var_64_4) then
				local var_64_7 = (arg_61_1.time_ - var_64_5) / var_64_6

				if arg_61_1.var_.characterEffect1069ui_story and not isNil(var_64_4) then
					local var_64_8 = Mathf.Lerp(0, 0.5, var_64_7)

					arg_61_1.var_.characterEffect1069ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1069ui_story.fillRatio = var_64_8
				end
			end

			if arg_61_1.time_ >= var_64_5 + var_64_6 and arg_61_1.time_ < var_64_5 + var_64_6 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect1069ui_story then
				local var_64_9 = 0.5

				arg_61_1.var_.characterEffect1069ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1069ui_story.fillRatio = var_64_9
			end

			local var_64_10 = 0
			local var_64_11 = 0.425

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_12 = arg_61_1:FormatText(StoryNameCfg[1459].name)

				arg_61_1.leftNameTxt_.text = var_64_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10162")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_13 = arg_61_1:GetWordFromCfg(323501012)
				local var_64_14 = arg_61_1:FormatText(var_64_13.content)

				arg_61_1.text_.text = var_64_14

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_15 = 17
				local var_64_16 = utf8.len(var_64_14)
				local var_64_17 = var_64_15 <= 0 and var_64_11 or var_64_11 * (var_64_16 / var_64_15)

				if var_64_17 > 0 and var_64_11 < var_64_17 then
					arg_61_1.talkMaxDuration = var_64_17

					if var_64_17 + var_64_10 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_17 + var_64_10
					end
				end

				arg_61_1.text_.text = var_64_14
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323501", "323501012", "story_v_out_323501.awb") ~= 0 then
					local var_64_18 = manager.audio:GetVoiceLength("story_v_out_323501", "323501012", "story_v_out_323501.awb") / 1000

					if var_64_18 + var_64_10 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_18 + var_64_10
					end

					if var_64_13.prefab_name ~= "" and arg_61_1.actors_[var_64_13.prefab_name] ~= nil then
						local var_64_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_13.prefab_name].transform, "story_v_out_323501", "323501012", "story_v_out_323501.awb")

						arg_61_1:RecordAudio("323501012", var_64_19)
						arg_61_1:RecordAudio("323501012", var_64_19)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_323501", "323501012", "story_v_out_323501.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_323501", "323501012", "story_v_out_323501.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_20 = math.max(var_64_11, arg_61_1.talkMaxDuration)

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_20 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_10) / var_64_20

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_10 + var_64_20 and arg_61_1.time_ < var_64_10 + var_64_20 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play323501013 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 323501013
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play323501014(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1067ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1067ui_story == nil then
				arg_65_1.var_.characterEffect1067ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1067ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1067ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1067ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1067ui_story.fillRatio = var_68_5
			end

			local var_68_6 = 0
			local var_68_7 = 1.175

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_8 = arg_65_1:GetWordFromCfg(323501013)
				local var_68_9 = arg_65_1:FormatText(var_68_8.content)

				arg_65_1.text_.text = var_68_9

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 47
				local var_68_11 = utf8.len(var_68_9)
				local var_68_12 = var_68_10 <= 0 and var_68_7 or var_68_7 * (var_68_11 / var_68_10)

				if var_68_12 > 0 and var_68_7 < var_68_12 then
					arg_65_1.talkMaxDuration = var_68_12

					if var_68_12 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_12 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_9
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_13 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_13 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_13

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_13 and arg_65_1.time_ < var_68_6 + var_68_13 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play323501014 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 323501014
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play323501015(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.575
			local var_72_1 = 1

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				local var_72_2 = "play"
				local var_72_3 = "effect"

				arg_69_1:AudioAction(var_72_2, var_72_3, "se_story_144", "se_story_144_gun_battle02", "")
			end

			local var_72_4 = 0
			local var_72_5 = 1.575

			if var_72_4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(323501014)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_8 = 63
				local var_72_9 = utf8.len(var_72_7)
				local var_72_10 = var_72_8 <= 0 and var_72_5 or var_72_5 * (var_72_9 / var_72_8)

				if var_72_10 > 0 and var_72_5 < var_72_10 then
					arg_69_1.talkMaxDuration = var_72_10

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_11 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_11 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_11

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_11 and arg_69_1.time_ < var_72_4 + var_72_11 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play323501015 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 323501015
		arg_73_1.duration_ = 6.33

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play323501016(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = manager.ui.mainCamera.transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				local var_76_2 = arg_73_1.var_.effectQWE
				local var_76_3
				local var_76_4 = var_76_0

				if not var_76_2 then
					var_76_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rockfall"), var_76_4)
					var_76_2.name = "QWE"
					arg_73_1.var_.effectQWE = var_76_2
				else
					var_76_2.transform:SetParent(var_76_4)
				end

				var_76_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_76_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_76_5 = 1.7777777777777777
				local var_76_6 = Screen.width / Screen.height
				local var_76_7 = var_76_6 / var_76_5
				local var_76_8 = Mathf.Max(var_76_5 / var_76_6, 1)

				var_76_2.transform.localScale = Vector3.New(var_76_2.transform.localScale.x * var_76_7, var_76_2.transform.localScale.y * var_76_8, var_76_2.transform.localScale.z)
			end

			local var_76_9 = 0

			if var_76_9 < arg_73_1.time_ and arg_73_1.time_ <= var_76_9 + arg_76_0 then
				arg_73_1.allBtn_.enabled = false
			end

			local var_76_10 = 1.33333333333333

			if arg_73_1.time_ >= var_76_9 + var_76_10 and arg_73_1.time_ < var_76_9 + var_76_10 + arg_76_0 then
				arg_73_1.allBtn_.enabled = true
			end

			local var_76_11 = 0.200000002980232
			local var_76_12 = 1

			if var_76_11 < arg_73_1.time_ and arg_73_1.time_ <= var_76_11 + arg_76_0 then
				local var_76_13 = "play"
				local var_76_14 = "effect"

				arg_73_1:AudioAction(var_76_13, var_76_14, "se_story_144", "se_story_144_metal", "")
			end

			local var_76_15 = 1.23333333333333
			local var_76_16 = 1

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 then
				local var_76_17 = "play"
				local var_76_18 = "effect"

				arg_73_1:AudioAction(var_76_17, var_76_18, "se_story_140", "se_story_140_foley_down", "")
			end

			if arg_73_1.frameCnt_ <= 1 then
				arg_73_1.dialog_:SetActive(false)
			end

			local var_76_19 = 1.33333333333333
			local var_76_20 = 1.65

			if var_76_19 < arg_73_1.time_ and arg_73_1.time_ <= var_76_19 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				arg_73_1.dialog_:SetActive(true)

				arg_73_1.dialogCg_.alpha = 0

				local var_76_21 = LeanTween.value(arg_73_1.dialog_, 0, 1, 0.3)

				var_76_21:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_73_1.dialogCg_.alpha = arg_77_0
				end))
				var_76_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_73_1.dialog_)
					var_76_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_73_1.duration_ = arg_73_1.duration_ + 0.3

				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_22 = arg_73_1:GetWordFromCfg(323501015)
				local var_76_23 = arg_73_1:FormatText(var_76_22.content)

				arg_73_1.text_.text = var_76_23

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_24 = 66
				local var_76_25 = utf8.len(var_76_23)
				local var_76_26 = var_76_24 <= 0 and var_76_20 or var_76_20 * (var_76_25 / var_76_24)

				if var_76_26 > 0 and var_76_20 < var_76_26 then
					arg_73_1.talkMaxDuration = var_76_26
					var_76_19 = var_76_19 + 0.3

					if var_76_26 + var_76_19 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_26 + var_76_19
					end
				end

				arg_73_1.text_.text = var_76_23
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_27 = var_76_19 + 0.3
			local var_76_28 = math.max(var_76_20, arg_73_1.talkMaxDuration)

			if var_76_27 <= arg_73_1.time_ and arg_73_1.time_ < var_76_27 + var_76_28 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_27) / var_76_28

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_27 + var_76_28 and arg_73_1.time_ < var_76_27 + var_76_28 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequencyGain = 1,
				className = "StoryShakeNode",
				noiseSettingsAssetPath = "Camera/Noise/6D_Shake",
				duration = 0.799999997019768,
				amplitudeGain = 1,
				startTime = 0.200000002980232,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.CAMERA
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play323501016 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 323501016
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play323501017(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 1.4

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_2 = arg_79_1:GetWordFromCfg(323501016)
				local var_82_3 = arg_79_1:FormatText(var_82_2.content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 56
				local var_82_5 = utf8.len(var_82_3)
				local var_82_6 = var_82_4 <= 0 and var_82_1 or var_82_1 * (var_82_5 / var_82_4)

				if var_82_6 > 0 and var_82_1 < var_82_6 then
					arg_79_1.talkMaxDuration = var_82_6

					if var_82_6 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_6 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_7 and arg_79_1.time_ < var_82_0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play323501017 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 323501017
		arg_83_1.duration_ = 6.62

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play323501018(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = manager.ui.mainCamera.transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				local var_86_2 = arg_83_1.var_.effectQWE

				if var_86_2 then
					Object.Destroy(var_86_2)

					arg_83_1.var_.effectQWE = nil
				end
			end

			local var_86_3 = 0

			if var_86_3 < arg_83_1.time_ and arg_83_1.time_ <= var_86_3 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_4 = 2

			if var_86_3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_3 + var_86_4 then
				local var_86_5 = (arg_83_1.time_ - var_86_3) / var_86_4
				local var_86_6 = Color.New(0, 0, 0)

				var_86_6.a = Mathf.Lerp(1, 0, var_86_5)
				arg_83_1.mask_.color = var_86_6
			end

			if arg_83_1.time_ >= var_86_3 + var_86_4 and arg_83_1.time_ < var_86_3 + var_86_4 + arg_86_0 then
				local var_86_7 = Color.New(0, 0, 0)
				local var_86_8 = 0

				arg_83_1.mask_.enabled = false
				var_86_7.a = var_86_8
				arg_83_1.mask_.color = var_86_7
			end

			if arg_83_1.frameCnt_ <= 1 then
				arg_83_1.dialog_:SetActive(false)
			end

			local var_86_9 = 1.625
			local var_86_10 = 1.075

			if var_86_9 < arg_83_1.time_ and arg_83_1.time_ <= var_86_9 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				arg_83_1.dialog_:SetActive(true)

				arg_83_1.dialogCg_.alpha = 0

				local var_86_11 = LeanTween.value(arg_83_1.dialog_, 0, 1, 0.3)

				var_86_11:setOnUpdate(LuaHelper.FloatAction(function(arg_87_0)
					arg_83_1.dialogCg_.alpha = arg_87_0
				end))
				var_86_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_83_1.dialog_)
					var_86_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_83_1.duration_ = arg_83_1.duration_ + 0.3

				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_12 = arg_83_1:GetWordFromCfg(323501017)
				local var_86_13 = arg_83_1:FormatText(var_86_12.content)

				arg_83_1.text_.text = var_86_13

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_14 = 43
				local var_86_15 = utf8.len(var_86_13)
				local var_86_16 = var_86_14 <= 0 and var_86_10 or var_86_10 * (var_86_15 / var_86_14)

				if var_86_16 > 0 and var_86_10 < var_86_16 then
					arg_83_1.talkMaxDuration = var_86_16
					var_86_9 = var_86_9 + 0.3

					if var_86_16 + var_86_9 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_16 + var_86_9
					end
				end

				arg_83_1.text_.text = var_86_13
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_17 = var_86_9 + 0.3
			local var_86_18 = math.max(var_86_10, arg_83_1.talkMaxDuration)

			if var_86_17 <= arg_83_1.time_ and arg_83_1.time_ < var_86_17 + var_86_18 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_17) / var_86_18

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_17 + var_86_18 and arg_83_1.time_ < var_86_17 + var_86_18 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play323501018 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 323501018
		arg_89_1.duration_ = 1.37

		local var_89_0 = {
			zh = 0.999999999999,
			ja = 1.366
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
				arg_89_0:Play323501019(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = "10162ui_story"

			if arg_89_1.actors_[var_92_0] == nil then
				local var_92_1 = Asset.Load("Char/" .. "10162ui_story")

				if not isNil(var_92_1) then
					local var_92_2 = Object.Instantiate(Asset.Load("Char/" .. "10162ui_story"), arg_89_1.stage_.transform)

					var_92_2.name = var_92_0
					var_92_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_89_1.actors_[var_92_0] = var_92_2

					local var_92_3 = var_92_2:GetComponentInChildren(typeof(CharacterEffect))

					var_92_3.enabled = true

					local var_92_4 = GameObjectTools.GetOrAddComponent(var_92_2, typeof(DynamicBoneHelper))

					if var_92_4 then
						var_92_4:EnableDynamicBone(false)
					end

					arg_89_1:ShowWeapon(var_92_3.transform, false)

					arg_89_1.var_[var_92_0 .. "Animator"] = var_92_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_89_1.var_[var_92_0 .. "Animator"].applyRootMotion = true
					arg_89_1.var_[var_92_0 .. "LipSync"] = var_92_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_92_5 = arg_89_1.actors_["10162ui_story"]
			local var_92_6 = 0

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.characterEffect10162ui_story == nil then
				arg_89_1.var_.characterEffect10162ui_story = var_92_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_7 = 0.200000002980232

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_7 and not isNil(var_92_5) then
				local var_92_8 = (arg_89_1.time_ - var_92_6) / var_92_7

				if arg_89_1.var_.characterEffect10162ui_story and not isNil(var_92_5) then
					arg_89_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_6 + var_92_7 and arg_89_1.time_ < var_92_6 + var_92_7 + arg_92_0 and not isNil(var_92_5) and arg_89_1.var_.characterEffect10162ui_story then
				arg_89_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_92_9 = 0
			local var_92_10 = 0.1

			if var_92_9 < arg_89_1.time_ and arg_89_1.time_ <= var_92_9 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_11 = arg_89_1:FormatText(StoryNameCfg[1460].name)

				arg_89_1.leftNameTxt_.text = var_92_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10166")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_12 = arg_89_1:GetWordFromCfg(323501018)
				local var_92_13 = arg_89_1:FormatText(var_92_12.content)

				arg_89_1.text_.text = var_92_13

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_14 = 4
				local var_92_15 = utf8.len(var_92_13)
				local var_92_16 = var_92_14 <= 0 and var_92_10 or var_92_10 * (var_92_15 / var_92_14)

				if var_92_16 > 0 and var_92_10 < var_92_16 then
					arg_89_1.talkMaxDuration = var_92_16

					if var_92_16 + var_92_9 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_16 + var_92_9
					end
				end

				arg_89_1.text_.text = var_92_13
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323501", "323501018", "story_v_out_323501.awb") ~= 0 then
					local var_92_17 = manager.audio:GetVoiceLength("story_v_out_323501", "323501018", "story_v_out_323501.awb") / 1000

					if var_92_17 + var_92_9 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_17 + var_92_9
					end

					if var_92_12.prefab_name ~= "" and arg_89_1.actors_[var_92_12.prefab_name] ~= nil then
						local var_92_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_12.prefab_name].transform, "story_v_out_323501", "323501018", "story_v_out_323501.awb")

						arg_89_1:RecordAudio("323501018", var_92_18)
						arg_89_1:RecordAudio("323501018", var_92_18)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_323501", "323501018", "story_v_out_323501.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_323501", "323501018", "story_v_out_323501.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_19 = math.max(var_92_10, arg_89_1.talkMaxDuration)

			if var_92_9 <= arg_89_1.time_ and arg_89_1.time_ < var_92_9 + var_92_19 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_9) / var_92_19

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_9 + var_92_19 and arg_89_1.time_ < var_92_9 + var_92_19 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play323501019 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 323501019
		arg_93_1.duration_ = 2.3

		local var_93_0 = {
			zh = 2.033,
			ja = 2.3
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
				arg_93_0:Play323501020(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10162ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos10162ui_story = var_96_0.localPosition

				local var_96_2 = GameObjectTools.GetOrAddComponent(var_96_0.gameObject, typeof(DynamicBoneHelper))

				if var_96_2 then
					var_96_2:EnableDynamicBone(false)
				end
			end

			local var_96_3 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_3 then
				local var_96_4 = (arg_93_1.time_ - var_96_1) / var_96_3
				local var_96_5 = Vector3.New(-0.74, -1.08, -5.83)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10162ui_story, var_96_5, var_96_4)

				local var_96_6 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_6.x, var_96_6.y, var_96_6.z)

				local var_96_7 = var_96_0.localEulerAngles

				var_96_7.z = 0
				var_96_7.x = 0
				var_96_0.localEulerAngles = var_96_7
			end

			if arg_93_1.time_ >= var_96_1 + var_96_3 and arg_93_1.time_ < var_96_1 + var_96_3 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(-0.74, -1.08, -5.83)

				local var_96_8 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_8.x, var_96_8.y, var_96_8.z)

				local var_96_9 = var_96_0.localEulerAngles

				var_96_9.z = 0
				var_96_9.x = 0
				var_96_0.localEulerAngles = var_96_9

				local var_96_10 = GameObjectTools.GetOrAddComponent(var_96_0.gameObject, typeof(DynamicBoneHelper))

				if var_96_10 then
					var_96_10:EnableDynamicBone(true)
				end
			end

			local var_96_11 = "10166ui_story"

			if arg_93_1.actors_[var_96_11] == nil then
				local var_96_12 = Asset.Load("Char/" .. "10166ui_story")

				if not isNil(var_96_12) then
					local var_96_13 = Object.Instantiate(Asset.Load("Char/" .. "10166ui_story"), arg_93_1.stage_.transform)

					var_96_13.name = var_96_11
					var_96_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_93_1.actors_[var_96_11] = var_96_13

					local var_96_14 = var_96_13:GetComponentInChildren(typeof(CharacterEffect))

					var_96_14.enabled = true

					local var_96_15 = GameObjectTools.GetOrAddComponent(var_96_13, typeof(DynamicBoneHelper))

					if var_96_15 then
						var_96_15:EnableDynamicBone(false)
					end

					arg_93_1:ShowWeapon(var_96_14.transform, false)

					arg_93_1.var_[var_96_11 .. "Animator"] = var_96_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_93_1.var_[var_96_11 .. "Animator"].applyRootMotion = true
					arg_93_1.var_[var_96_11 .. "LipSync"] = var_96_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_96_16 = arg_93_1.actors_["10166ui_story"]
			local var_96_17 = 0

			if var_96_17 < arg_93_1.time_ and arg_93_1.time_ <= var_96_17 + arg_96_0 and not isNil(var_96_16) and arg_93_1.var_.characterEffect10166ui_story == nil then
				arg_93_1.var_.characterEffect10166ui_story = var_96_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_18 = 0.200000002980232

			if var_96_17 <= arg_93_1.time_ and arg_93_1.time_ < var_96_17 + var_96_18 and not isNil(var_96_16) then
				local var_96_19 = (arg_93_1.time_ - var_96_17) / var_96_18

				if arg_93_1.var_.characterEffect10166ui_story and not isNil(var_96_16) then
					local var_96_20 = Mathf.Lerp(0, 0.5, var_96_19)

					arg_93_1.var_.characterEffect10166ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10166ui_story.fillRatio = var_96_20
				end
			end

			if arg_93_1.time_ >= var_96_17 + var_96_18 and arg_93_1.time_ < var_96_17 + var_96_18 + arg_96_0 and not isNil(var_96_16) and arg_93_1.var_.characterEffect10166ui_story then
				local var_96_21 = 0.5

				arg_93_1.var_.characterEffect10166ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10166ui_story.fillRatio = var_96_21
			end

			local var_96_22 = arg_93_1.actors_["10162ui_story"]
			local var_96_23 = 0

			if var_96_23 < arg_93_1.time_ and arg_93_1.time_ <= var_96_23 + arg_96_0 and not isNil(var_96_22) and arg_93_1.var_.characterEffect10162ui_story == nil then
				arg_93_1.var_.characterEffect10162ui_story = var_96_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_24 = 0.200000002980232

			if var_96_23 <= arg_93_1.time_ and arg_93_1.time_ < var_96_23 + var_96_24 and not isNil(var_96_22) then
				local var_96_25 = (arg_93_1.time_ - var_96_23) / var_96_24

				if arg_93_1.var_.characterEffect10162ui_story and not isNil(var_96_22) then
					arg_93_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_23 + var_96_24 and arg_93_1.time_ < var_96_23 + var_96_24 + arg_96_0 and not isNil(var_96_22) and arg_93_1.var_.characterEffect10162ui_story then
				arg_93_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_96_26 = 0

			if var_96_26 < arg_93_1.time_ and arg_93_1.time_ <= var_96_26 + arg_96_0 then
				arg_93_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_1")
			end

			local var_96_27 = 0

			if var_96_27 < arg_93_1.time_ and arg_93_1.time_ <= var_96_27 + arg_96_0 then
				arg_93_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_96_28 = 0
			local var_96_29 = 0.2

			if var_96_28 < arg_93_1.time_ and arg_93_1.time_ <= var_96_28 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_30 = arg_93_1:FormatText(StoryNameCfg[1459].name)

				arg_93_1.leftNameTxt_.text = var_96_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_31 = arg_93_1:GetWordFromCfg(323501019)
				local var_96_32 = arg_93_1:FormatText(var_96_31.content)

				arg_93_1.text_.text = var_96_32

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_33 = 8
				local var_96_34 = utf8.len(var_96_32)
				local var_96_35 = var_96_33 <= 0 and var_96_29 or var_96_29 * (var_96_34 / var_96_33)

				if var_96_35 > 0 and var_96_29 < var_96_35 then
					arg_93_1.talkMaxDuration = var_96_35

					if var_96_35 + var_96_28 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_35 + var_96_28
					end
				end

				arg_93_1.text_.text = var_96_32
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323501", "323501019", "story_v_out_323501.awb") ~= 0 then
					local var_96_36 = manager.audio:GetVoiceLength("story_v_out_323501", "323501019", "story_v_out_323501.awb") / 1000

					if var_96_36 + var_96_28 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_36 + var_96_28
					end

					if var_96_31.prefab_name ~= "" and arg_93_1.actors_[var_96_31.prefab_name] ~= nil then
						local var_96_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_31.prefab_name].transform, "story_v_out_323501", "323501019", "story_v_out_323501.awb")

						arg_93_1:RecordAudio("323501019", var_96_37)
						arg_93_1:RecordAudio("323501019", var_96_37)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_323501", "323501019", "story_v_out_323501.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_323501", "323501019", "story_v_out_323501.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_38 = math.max(var_96_29, arg_93_1.talkMaxDuration)

			if var_96_28 <= arg_93_1.time_ and arg_93_1.time_ < var_96_28 + var_96_38 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_28) / var_96_38

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_28 + var_96_38 and arg_93_1.time_ < var_96_28 + var_96_38 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
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
	Play323501020 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 323501020
		arg_97_1.duration_ = 2.7

		local var_97_0 = {
			zh = 1.999999999999,
			ja = 2.7
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
				arg_97_0:Play323501021(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10166ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos10166ui_story = var_100_0.localPosition

				local var_100_2 = GameObjectTools.GetOrAddComponent(var_100_0.gameObject, typeof(DynamicBoneHelper))

				if var_100_2 then
					var_100_2:EnableDynamicBone(false)
				end
			end

			local var_100_3 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_3 then
				local var_100_4 = (arg_97_1.time_ - var_100_1) / var_100_3
				local var_100_5 = Vector3.New(0.7, -1.28, -5.73)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10166ui_story, var_100_5, var_100_4)

				local var_100_6 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_6.x, var_100_6.y, var_100_6.z)

				local var_100_7 = var_100_0.localEulerAngles

				var_100_7.z = 0
				var_100_7.x = 0
				var_100_0.localEulerAngles = var_100_7
			end

			if arg_97_1.time_ >= var_100_1 + var_100_3 and arg_97_1.time_ < var_100_1 + var_100_3 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0.7, -1.28, -5.73)

				local var_100_8 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_8.x, var_100_8.y, var_100_8.z)

				local var_100_9 = var_100_0.localEulerAngles

				var_100_9.z = 0
				var_100_9.x = 0
				var_100_0.localEulerAngles = var_100_9

				local var_100_10 = GameObjectTools.GetOrAddComponent(var_100_0.gameObject, typeof(DynamicBoneHelper))

				if var_100_10 then
					var_100_10:EnableDynamicBone(true)
				end
			end

			local var_100_11 = arg_97_1.actors_["10162ui_story"]
			local var_100_12 = 0

			if var_100_12 < arg_97_1.time_ and arg_97_1.time_ <= var_100_12 + arg_100_0 and not isNil(var_100_11) and arg_97_1.var_.characterEffect10162ui_story == nil then
				arg_97_1.var_.characterEffect10162ui_story = var_100_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_13 = 0.200000002980232

			if var_100_12 <= arg_97_1.time_ and arg_97_1.time_ < var_100_12 + var_100_13 and not isNil(var_100_11) then
				local var_100_14 = (arg_97_1.time_ - var_100_12) / var_100_13

				if arg_97_1.var_.characterEffect10162ui_story and not isNil(var_100_11) then
					local var_100_15 = Mathf.Lerp(0, 0.5, var_100_14)

					arg_97_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_97_1.var_.characterEffect10162ui_story.fillRatio = var_100_15
				end
			end

			if arg_97_1.time_ >= var_100_12 + var_100_13 and arg_97_1.time_ < var_100_12 + var_100_13 + arg_100_0 and not isNil(var_100_11) and arg_97_1.var_.characterEffect10162ui_story then
				local var_100_16 = 0.5

				arg_97_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_97_1.var_.characterEffect10162ui_story.fillRatio = var_100_16
			end

			local var_100_17 = arg_97_1.actors_["10166ui_story"]
			local var_100_18 = 0

			if var_100_18 < arg_97_1.time_ and arg_97_1.time_ <= var_100_18 + arg_100_0 and not isNil(var_100_17) and arg_97_1.var_.characterEffect10166ui_story == nil then
				arg_97_1.var_.characterEffect10166ui_story = var_100_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_19 = 0.200000002980232

			if var_100_18 <= arg_97_1.time_ and arg_97_1.time_ < var_100_18 + var_100_19 and not isNil(var_100_17) then
				local var_100_20 = (arg_97_1.time_ - var_100_18) / var_100_19

				if arg_97_1.var_.characterEffect10166ui_story and not isNil(var_100_17) then
					arg_97_1.var_.characterEffect10166ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_18 + var_100_19 and arg_97_1.time_ < var_100_18 + var_100_19 + arg_100_0 and not isNil(var_100_17) and arg_97_1.var_.characterEffect10166ui_story then
				arg_97_1.var_.characterEffect10166ui_story.fillFlat = false
			end

			local var_100_21 = 0

			if var_100_21 < arg_97_1.time_ and arg_97_1.time_ <= var_100_21 + arg_100_0 then
				arg_97_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/story10166/story10166action/10166action1_1")
			end

			local var_100_22 = 0

			if var_100_22 < arg_97_1.time_ and arg_97_1.time_ <= var_100_22 + arg_100_0 then
				arg_97_1:PlayTimeline("10166ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_100_23 = 0
			local var_100_24 = 0.125

			if var_100_23 < arg_97_1.time_ and arg_97_1.time_ <= var_100_23 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_25 = arg_97_1:FormatText(StoryNameCfg[1460].name)

				arg_97_1.leftNameTxt_.text = var_100_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_26 = arg_97_1:GetWordFromCfg(323501020)
				local var_100_27 = arg_97_1:FormatText(var_100_26.content)

				arg_97_1.text_.text = var_100_27

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_28 = 5
				local var_100_29 = utf8.len(var_100_27)
				local var_100_30 = var_100_28 <= 0 and var_100_24 or var_100_24 * (var_100_29 / var_100_28)

				if var_100_30 > 0 and var_100_24 < var_100_30 then
					arg_97_1.talkMaxDuration = var_100_30

					if var_100_30 + var_100_23 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_30 + var_100_23
					end
				end

				arg_97_1.text_.text = var_100_27
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323501", "323501020", "story_v_out_323501.awb") ~= 0 then
					local var_100_31 = manager.audio:GetVoiceLength("story_v_out_323501", "323501020", "story_v_out_323501.awb") / 1000

					if var_100_31 + var_100_23 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_31 + var_100_23
					end

					if var_100_26.prefab_name ~= "" and arg_97_1.actors_[var_100_26.prefab_name] ~= nil then
						local var_100_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_26.prefab_name].transform, "story_v_out_323501", "323501020", "story_v_out_323501.awb")

						arg_97_1:RecordAudio("323501020", var_100_32)
						arg_97_1:RecordAudio("323501020", var_100_32)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_323501", "323501020", "story_v_out_323501.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_323501", "323501020", "story_v_out_323501.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_33 = math.max(var_100_24, arg_97_1.talkMaxDuration)

			if var_100_23 <= arg_97_1.time_ and arg_97_1.time_ < var_100_23 + var_100_33 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_23) / var_100_33

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_23 + var_100_33 and arg_97_1.time_ < var_100_23 + var_100_33 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10166ui_story",
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
	Play323501021 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 323501021
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play323501022(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10162ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10162ui_story == nil then
				arg_101_1.var_.characterEffect10162ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 and not isNil(var_104_0) then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect10162ui_story and not isNil(var_104_0) then
					local var_104_4 = Mathf.Lerp(0, 0.5, var_104_3)

					arg_101_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10162ui_story.fillRatio = var_104_4
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and not isNil(var_104_0) and arg_101_1.var_.characterEffect10162ui_story then
				local var_104_5 = 0.5

				arg_101_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10162ui_story.fillRatio = var_104_5
			end

			local var_104_6 = arg_101_1.actors_["10162ui_story"].transform
			local var_104_7 = 0

			if var_104_7 < arg_101_1.time_ and arg_101_1.time_ <= var_104_7 + arg_104_0 then
				arg_101_1.var_.moveOldPos10162ui_story = var_104_6.localPosition

				local var_104_8 = GameObjectTools.GetOrAddComponent(var_104_6.gameObject, typeof(DynamicBoneHelper))

				if var_104_8 then
					var_104_8:EnableDynamicBone(false)
				end
			end

			local var_104_9 = 0.001

			if var_104_7 <= arg_101_1.time_ and arg_101_1.time_ < var_104_7 + var_104_9 then
				local var_104_10 = (arg_101_1.time_ - var_104_7) / var_104_9
				local var_104_11 = Vector3.New(0, 100, 0)

				var_104_6.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10162ui_story, var_104_11, var_104_10)

				local var_104_12 = manager.ui.mainCamera.transform.position - var_104_6.position

				var_104_6.forward = Vector3.New(var_104_12.x, var_104_12.y, var_104_12.z)

				local var_104_13 = var_104_6.localEulerAngles

				var_104_13.z = 0
				var_104_13.x = 0
				var_104_6.localEulerAngles = var_104_13
			end

			if arg_101_1.time_ >= var_104_7 + var_104_9 and arg_101_1.time_ < var_104_7 + var_104_9 + arg_104_0 then
				var_104_6.localPosition = Vector3.New(0, 100, 0)

				local var_104_14 = manager.ui.mainCamera.transform.position - var_104_6.position

				var_104_6.forward = Vector3.New(var_104_14.x, var_104_14.y, var_104_14.z)

				local var_104_15 = var_104_6.localEulerAngles

				var_104_15.z = 0
				var_104_15.x = 0
				var_104_6.localEulerAngles = var_104_15

				local var_104_16 = GameObjectTools.GetOrAddComponent(var_104_6.gameObject, typeof(DynamicBoneHelper))

				if var_104_16 then
					var_104_16:EnableDynamicBone(true)
				end
			end

			local var_104_17 = arg_101_1.actors_["10166ui_story"].transform
			local var_104_18 = 0

			if var_104_18 < arg_101_1.time_ and arg_101_1.time_ <= var_104_18 + arg_104_0 then
				arg_101_1.var_.moveOldPos10166ui_story = var_104_17.localPosition

				local var_104_19 = GameObjectTools.GetOrAddComponent(var_104_17.gameObject, typeof(DynamicBoneHelper))

				if var_104_19 then
					var_104_19:EnableDynamicBone(false)
				end
			end

			local var_104_20 = 0.001

			if var_104_18 <= arg_101_1.time_ and arg_101_1.time_ < var_104_18 + var_104_20 then
				local var_104_21 = (arg_101_1.time_ - var_104_18) / var_104_20
				local var_104_22 = Vector3.New(0, 100, 0)

				var_104_17.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10166ui_story, var_104_22, var_104_21)

				local var_104_23 = manager.ui.mainCamera.transform.position - var_104_17.position

				var_104_17.forward = Vector3.New(var_104_23.x, var_104_23.y, var_104_23.z)

				local var_104_24 = var_104_17.localEulerAngles

				var_104_24.z = 0
				var_104_24.x = 0
				var_104_17.localEulerAngles = var_104_24
			end

			if arg_101_1.time_ >= var_104_18 + var_104_20 and arg_101_1.time_ < var_104_18 + var_104_20 + arg_104_0 then
				var_104_17.localPosition = Vector3.New(0, 100, 0)

				local var_104_25 = manager.ui.mainCamera.transform.position - var_104_17.position

				var_104_17.forward = Vector3.New(var_104_25.x, var_104_25.y, var_104_25.z)

				local var_104_26 = var_104_17.localEulerAngles

				var_104_26.z = 0
				var_104_26.x = 0
				var_104_17.localEulerAngles = var_104_26

				local var_104_27 = GameObjectTools.GetOrAddComponent(var_104_17.gameObject, typeof(DynamicBoneHelper))

				if var_104_27 then
					var_104_27:EnableDynamicBone(true)
				end
			end

			local var_104_28 = 0
			local var_104_29 = 0.85

			if var_104_28 < arg_101_1.time_ and arg_101_1.time_ <= var_104_28 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_30 = arg_101_1:GetWordFromCfg(323501021)
				local var_104_31 = arg_101_1:FormatText(var_104_30.content)

				arg_101_1.text_.text = var_104_31

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_32 = 34
				local var_104_33 = utf8.len(var_104_31)
				local var_104_34 = var_104_32 <= 0 and var_104_29 or var_104_29 * (var_104_33 / var_104_32)

				if var_104_34 > 0 and var_104_29 < var_104_34 then
					arg_101_1.talkMaxDuration = var_104_34

					if var_104_34 + var_104_28 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_34 + var_104_28
					end
				end

				arg_101_1.text_.text = var_104_31
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_35 = math.max(var_104_29, arg_101_1.talkMaxDuration)

			if var_104_28 <= arg_101_1.time_ and arg_101_1.time_ < var_104_28 + var_104_35 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_28) / var_104_35

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_28 + var_104_35 and arg_101_1.time_ < var_104_28 + var_104_35 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play323501022 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 323501022
		arg_105_1.duration_ = 5.7

		local var_105_0 = {
			zh = 4.8,
			ja = 5.7
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
				arg_105_0:Play323501023(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10162ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect10162ui_story == nil then
				arg_105_1.var_.characterEffect10162ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect10162ui_story and not isNil(var_108_0) then
					arg_105_1.var_.characterEffect10162ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect10162ui_story then
				arg_105_1.var_.characterEffect10162ui_story.fillFlat = false
			end

			local var_108_4 = 0

			if var_108_4 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1:PlayTimeline("10162ui_story", "StoryTimeline/CharAction/story10162/story10162action/10162action15_2")
			end

			local var_108_5 = arg_105_1.actors_["10162ui_story"].transform
			local var_108_6 = 0

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.var_.moveOldPos10162ui_story = var_108_5.localPosition

				local var_108_7 = GameObjectTools.GetOrAddComponent(var_108_5.gameObject, typeof(DynamicBoneHelper))

				if var_108_7 then
					var_108_7:EnableDynamicBone(false)
				end
			end

			local var_108_8 = 0.001

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_8 then
				local var_108_9 = (arg_105_1.time_ - var_108_6) / var_108_8
				local var_108_10 = Vector3.New(0, -1.08, -5.83)

				var_108_5.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10162ui_story, var_108_10, var_108_9)

				local var_108_11 = manager.ui.mainCamera.transform.position - var_108_5.position

				var_108_5.forward = Vector3.New(var_108_11.x, var_108_11.y, var_108_11.z)

				local var_108_12 = var_108_5.localEulerAngles

				var_108_12.z = 0
				var_108_12.x = 0
				var_108_5.localEulerAngles = var_108_12
			end

			if arg_105_1.time_ >= var_108_6 + var_108_8 and arg_105_1.time_ < var_108_6 + var_108_8 + arg_108_0 then
				var_108_5.localPosition = Vector3.New(0, -1.08, -5.83)

				local var_108_13 = manager.ui.mainCamera.transform.position - var_108_5.position

				var_108_5.forward = Vector3.New(var_108_13.x, var_108_13.y, var_108_13.z)

				local var_108_14 = var_108_5.localEulerAngles

				var_108_14.z = 0
				var_108_14.x = 0
				var_108_5.localEulerAngles = var_108_14

				local var_108_15 = GameObjectTools.GetOrAddComponent(var_108_5.gameObject, typeof(DynamicBoneHelper))

				if var_108_15 then
					var_108_15:EnableDynamicBone(true)
				end
			end

			local var_108_16 = 0
			local var_108_17 = 0.65

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_18 = arg_105_1:FormatText(StoryNameCfg[1459].name)

				arg_105_1.leftNameTxt_.text = var_108_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_19 = arg_105_1:GetWordFromCfg(323501022)
				local var_108_20 = arg_105_1:FormatText(var_108_19.content)

				arg_105_1.text_.text = var_108_20

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_21 = 26
				local var_108_22 = utf8.len(var_108_20)
				local var_108_23 = var_108_21 <= 0 and var_108_17 or var_108_17 * (var_108_22 / var_108_21)

				if var_108_23 > 0 and var_108_17 < var_108_23 then
					arg_105_1.talkMaxDuration = var_108_23

					if var_108_23 + var_108_16 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_23 + var_108_16
					end
				end

				arg_105_1.text_.text = var_108_20
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323501", "323501022", "story_v_out_323501.awb") ~= 0 then
					local var_108_24 = manager.audio:GetVoiceLength("story_v_out_323501", "323501022", "story_v_out_323501.awb") / 1000

					if var_108_24 + var_108_16 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_24 + var_108_16
					end

					if var_108_19.prefab_name ~= "" and arg_105_1.actors_[var_108_19.prefab_name] ~= nil then
						local var_108_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_19.prefab_name].transform, "story_v_out_323501", "323501022", "story_v_out_323501.awb")

						arg_105_1:RecordAudio("323501022", var_108_25)
						arg_105_1:RecordAudio("323501022", var_108_25)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_323501", "323501022", "story_v_out_323501.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_323501", "323501022", "story_v_out_323501.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_26 = math.max(var_108_17, arg_105_1.talkMaxDuration)

			if var_108_16 <= arg_105_1.time_ and arg_105_1.time_ < var_108_16 + var_108_26 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_16) / var_108_26

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_16 + var_108_26 and arg_105_1.time_ < var_108_16 + var_108_26 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play323501023 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 323501023
		arg_109_1.duration_ = 2.9

		local var_109_0 = {
			zh = 2.166,
			ja = 2.9
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
				arg_109_0:Play323501024(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10162ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect10162ui_story == nil then
				arg_109_1.var_.characterEffect10162ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect10162ui_story and not isNil(var_112_0) then
					local var_112_4 = Mathf.Lerp(0, 0.5, var_112_3)

					arg_109_1.var_.characterEffect10162ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10162ui_story.fillRatio = var_112_4
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect10162ui_story then
				local var_112_5 = 0.5

				arg_109_1.var_.characterEffect10162ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10162ui_story.fillRatio = var_112_5
			end

			local var_112_6 = 0
			local var_112_7 = 0.275

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_8 = arg_109_1:FormatText(StoryNameCfg[1461].name)

				arg_109_1.leftNameTxt_.text = var_112_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10166")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_9 = arg_109_1:GetWordFromCfg(323501023)
				local var_112_10 = arg_109_1:FormatText(var_112_9.content)

				arg_109_1.text_.text = var_112_10

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 11
				local var_112_12 = utf8.len(var_112_10)
				local var_112_13 = var_112_11 <= 0 and var_112_7 or var_112_7 * (var_112_12 / var_112_11)

				if var_112_13 > 0 and var_112_7 < var_112_13 then
					arg_109_1.talkMaxDuration = var_112_13

					if var_112_13 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_6
					end
				end

				arg_109_1.text_.text = var_112_10
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323501", "323501023", "story_v_out_323501.awb") ~= 0 then
					local var_112_14 = manager.audio:GetVoiceLength("story_v_out_323501", "323501023", "story_v_out_323501.awb") / 1000

					if var_112_14 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_6
					end

					if var_112_9.prefab_name ~= "" and arg_109_1.actors_[var_112_9.prefab_name] ~= nil then
						local var_112_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_9.prefab_name].transform, "story_v_out_323501", "323501023", "story_v_out_323501.awb")

						arg_109_1:RecordAudio("323501023", var_112_15)
						arg_109_1:RecordAudio("323501023", var_112_15)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_323501", "323501023", "story_v_out_323501.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_323501", "323501023", "story_v_out_323501.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_16 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_16 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_16

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_16 and arg_109_1.time_ < var_112_6 + var_112_16 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play323501024 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 323501024
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play323501025(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10162ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos10162ui_story = var_116_0.localPosition

				local var_116_2 = GameObjectTools.GetOrAddComponent(var_116_0.gameObject, typeof(DynamicBoneHelper))

				if var_116_2 then
					var_116_2:EnableDynamicBone(false)
				end
			end

			local var_116_3 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_3 then
				local var_116_4 = (arg_113_1.time_ - var_116_1) / var_116_3
				local var_116_5 = Vector3.New(0, 100, 0)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10162ui_story, var_116_5, var_116_4)

				local var_116_6 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_6.x, var_116_6.y, var_116_6.z)

				local var_116_7 = var_116_0.localEulerAngles

				var_116_7.z = 0
				var_116_7.x = 0
				var_116_0.localEulerAngles = var_116_7
			end

			if arg_113_1.time_ >= var_116_1 + var_116_3 and arg_113_1.time_ < var_116_1 + var_116_3 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, 100, 0)

				local var_116_8 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_8.x, var_116_8.y, var_116_8.z)

				local var_116_9 = var_116_0.localEulerAngles

				var_116_9.z = 0
				var_116_9.x = 0
				var_116_0.localEulerAngles = var_116_9

				local var_116_10 = GameObjectTools.GetOrAddComponent(var_116_0.gameObject, typeof(DynamicBoneHelper))

				if var_116_10 then
					var_116_10:EnableDynamicBone(true)
				end
			end

			local var_116_11 = arg_113_1.actors_["10166ui_story"].transform
			local var_116_12 = 0

			if var_116_12 < arg_113_1.time_ and arg_113_1.time_ <= var_116_12 + arg_116_0 then
				arg_113_1.var_.moveOldPos10166ui_story = var_116_11.localPosition

				local var_116_13 = GameObjectTools.GetOrAddComponent(var_116_11.gameObject, typeof(DynamicBoneHelper))

				if var_116_13 then
					var_116_13:EnableDynamicBone(false)
				end
			end

			local var_116_14 = 0.001

			if var_116_12 <= arg_113_1.time_ and arg_113_1.time_ < var_116_12 + var_116_14 then
				local var_116_15 = (arg_113_1.time_ - var_116_12) / var_116_14
				local var_116_16 = Vector3.New(0, 100, 0)

				var_116_11.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10166ui_story, var_116_16, var_116_15)

				local var_116_17 = manager.ui.mainCamera.transform.position - var_116_11.position

				var_116_11.forward = Vector3.New(var_116_17.x, var_116_17.y, var_116_17.z)

				local var_116_18 = var_116_11.localEulerAngles

				var_116_18.z = 0
				var_116_18.x = 0
				var_116_11.localEulerAngles = var_116_18
			end

			if arg_113_1.time_ >= var_116_12 + var_116_14 and arg_113_1.time_ < var_116_12 + var_116_14 + arg_116_0 then
				var_116_11.localPosition = Vector3.New(0, 100, 0)

				local var_116_19 = manager.ui.mainCamera.transform.position - var_116_11.position

				var_116_11.forward = Vector3.New(var_116_19.x, var_116_19.y, var_116_19.z)

				local var_116_20 = var_116_11.localEulerAngles

				var_116_20.z = 0
				var_116_20.x = 0
				var_116_11.localEulerAngles = var_116_20

				local var_116_21 = GameObjectTools.GetOrAddComponent(var_116_11.gameObject, typeof(DynamicBoneHelper))

				if var_116_21 then
					var_116_21:EnableDynamicBone(true)
				end
			end

			local var_116_22 = "1158ui_story"

			if arg_113_1.actors_[var_116_22] == nil then
				local var_116_23 = Asset.Load("Char/" .. "1158ui_story")

				if not isNil(var_116_23) then
					local var_116_24 = Object.Instantiate(Asset.Load("Char/" .. "1158ui_story"), arg_113_1.stage_.transform)

					var_116_24.name = var_116_22
					var_116_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_113_1.actors_[var_116_22] = var_116_24

					local var_116_25 = var_116_24:GetComponentInChildren(typeof(CharacterEffect))

					var_116_25.enabled = true

					local var_116_26 = GameObjectTools.GetOrAddComponent(var_116_24, typeof(DynamicBoneHelper))

					if var_116_26 then
						var_116_26:EnableDynamicBone(false)
					end

					arg_113_1:ShowWeapon(var_116_25.transform, false)

					arg_113_1.var_[var_116_22 .. "Animator"] = var_116_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_113_1.var_[var_116_22 .. "Animator"].applyRootMotion = true
					arg_113_1.var_[var_116_22 .. "LipSync"] = var_116_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_116_27 = arg_113_1.actors_["1158ui_story"]
			local var_116_28 = 0

			if var_116_28 < arg_113_1.time_ and arg_113_1.time_ <= var_116_28 + arg_116_0 and not isNil(var_116_27) and arg_113_1.var_.characterEffect1158ui_story == nil then
				arg_113_1.var_.characterEffect1158ui_story = var_116_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_29 = 0.200000002980232

			if var_116_28 <= arg_113_1.time_ and arg_113_1.time_ < var_116_28 + var_116_29 and not isNil(var_116_27) then
				local var_116_30 = (arg_113_1.time_ - var_116_28) / var_116_29

				if arg_113_1.var_.characterEffect1158ui_story and not isNil(var_116_27) then
					local var_116_31 = Mathf.Lerp(0, 0.5, var_116_30)

					arg_113_1.var_.characterEffect1158ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1158ui_story.fillRatio = var_116_31
				end
			end

			if arg_113_1.time_ >= var_116_28 + var_116_29 and arg_113_1.time_ < var_116_28 + var_116_29 + arg_116_0 and not isNil(var_116_27) and arg_113_1.var_.characterEffect1158ui_story then
				local var_116_32 = 0.5

				arg_113_1.var_.characterEffect1158ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1158ui_story.fillRatio = var_116_32
			end

			local var_116_33 = 0
			local var_116_34 = 1.65

			if var_116_33 < arg_113_1.time_ and arg_113_1.time_ <= var_116_33 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_35 = arg_113_1:GetWordFromCfg(323501024)
				local var_116_36 = arg_113_1:FormatText(var_116_35.content)

				arg_113_1.text_.text = var_116_36

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_37 = 66
				local var_116_38 = utf8.len(var_116_36)
				local var_116_39 = var_116_37 <= 0 and var_116_34 or var_116_34 * (var_116_38 / var_116_37)

				if var_116_39 > 0 and var_116_34 < var_116_39 then
					arg_113_1.talkMaxDuration = var_116_39

					if var_116_39 + var_116_33 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_39 + var_116_33
					end
				end

				arg_113_1.text_.text = var_116_36
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_40 = math.max(var_116_34, arg_113_1.talkMaxDuration)

			if var_116_33 <= arg_113_1.time_ and arg_113_1.time_ < var_116_33 + var_116_40 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_33) / var_116_40

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_33 + var_116_40 and arg_113_1.time_ < var_116_33 + var_116_40 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10162ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play323501025 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 323501025
		arg_117_1.duration_ = 6.23

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play323501026(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = manager.ui.mainCamera.transform
			local var_120_1 = 0.233333333333333

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				local var_120_2 = arg_117_1.var_.effect334
				local var_120_3
				local var_120_4 = var_120_0

				if not var_120_2 then
					var_120_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xdaoguang"), var_120_4)
					var_120_2.name = "334"
					arg_117_1.var_.effect334 = var_120_2
				else
					var_120_2.transform:SetParent(var_120_4)
				end

				var_120_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_120_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_120_5 = 1.7777777777777777
				local var_120_6 = Screen.width / Screen.height
				local var_120_7 = var_120_6 / var_120_5
				local var_120_8 = Mathf.Max(var_120_5 / var_120_6, 1)

				var_120_2.transform.localScale = Vector3.New(var_120_2.transform.localScale.x * var_120_7, var_120_2.transform.localScale.y * var_120_8, var_120_2.transform.localScale.z)
			end

			local var_120_9 = 0

			if var_120_9 < arg_117_1.time_ and arg_117_1.time_ <= var_120_9 + arg_120_0 then
				arg_117_1.allBtn_.enabled = false
			end

			local var_120_10 = 1.7

			if arg_117_1.time_ >= var_120_9 + var_120_10 and arg_117_1.time_ < var_120_9 + var_120_10 + arg_120_0 then
				arg_117_1.allBtn_.enabled = true
			end

			local var_120_11 = 0
			local var_120_12 = 1

			if var_120_11 < arg_117_1.time_ and arg_117_1.time_ <= var_120_11 + arg_120_0 then
				local var_120_13 = "play"
				local var_120_14 = "effect"

				arg_117_1:AudioAction(var_120_13, var_120_14, "se_story_122_03", "se_story_122_03_swordlight", "")
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_15 = 1.233333333332
			local var_120_16 = 1.175

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_17 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_17:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_18 = arg_117_1:GetWordFromCfg(323501025)
				local var_120_19 = arg_117_1:FormatText(var_120_18.content)

				arg_117_1.text_.text = var_120_19

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_20 = 47
				local var_120_21 = utf8.len(var_120_19)
				local var_120_22 = var_120_20 <= 0 and var_120_16 or var_120_16 * (var_120_21 / var_120_20)

				if var_120_22 > 0 and var_120_16 < var_120_22 then
					arg_117_1.talkMaxDuration = var_120_22
					var_120_15 = var_120_15 + 0.3

					if var_120_22 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_22 + var_120_15
					end
				end

				arg_117_1.text_.text = var_120_19
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_23 = var_120_15 + 0.3
			local var_120_24 = math.max(var_120_16, arg_117_1.talkMaxDuration)

			if var_120_23 <= arg_117_1.time_ and arg_117_1.time_ < var_120_23 + var_120_24 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_23) / var_120_24

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_23 + var_120_24 and arg_117_1.time_ < var_120_23 + var_120_24 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play323501026 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 323501026
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play323501027(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.466666666666667
			local var_126_1 = 1

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				local var_126_2 = "play"
				local var_126_3 = "effect"

				arg_123_1:AudioAction(var_126_2, var_126_3, "se_story_148", "se_story_148_monster_roll", "")
			end

			local var_126_4 = 0
			local var_126_5 = 1.275

			if var_126_4 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_6 = arg_123_1:GetWordFromCfg(323501026)
				local var_126_7 = arg_123_1:FormatText(var_126_6.content)

				arg_123_1.text_.text = var_126_7

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_8 = 51
				local var_126_9 = utf8.len(var_126_7)
				local var_126_10 = var_126_8 <= 0 and var_126_5 or var_126_5 * (var_126_9 / var_126_8)

				if var_126_10 > 0 and var_126_5 < var_126_10 then
					arg_123_1.talkMaxDuration = var_126_10

					if var_126_10 + var_126_4 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_4
					end
				end

				arg_123_1.text_.text = var_126_7
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_11 = math.max(var_126_5, arg_123_1.talkMaxDuration)

			if var_126_4 <= arg_123_1.time_ and arg_123_1.time_ < var_126_4 + var_126_11 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_4) / var_126_11

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_4 + var_126_11 and arg_123_1.time_ < var_126_4 + var_126_11 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play323501027 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 323501027
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play323501028(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.9

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_2 = arg_127_1:GetWordFromCfg(323501027)
				local var_130_3 = arg_127_1:FormatText(var_130_2.content)

				arg_127_1.text_.text = var_130_3

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 36
				local var_130_5 = utf8.len(var_130_3)
				local var_130_6 = var_130_4 <= 0 and var_130_1 or var_130_1 * (var_130_5 / var_130_4)

				if var_130_6 > 0 and var_130_1 < var_130_6 then
					arg_127_1.talkMaxDuration = var_130_6

					if var_130_6 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_6 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_3
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_7 and arg_127_1.time_ < var_130_0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play323501028 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 323501028
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play323501029(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.4

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[7].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_3 = arg_131_1:GetWordFromCfg(323501028)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 16
				local var_134_6 = utf8.len(var_134_4)
				local var_134_7 = var_134_5 <= 0 and var_134_1 or var_134_1 * (var_134_6 / var_134_5)

				if var_134_7 > 0 and var_134_1 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_8 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_8 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_8

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_8 and arg_131_1.time_ < var_134_0 + var_134_8 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play323501029 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 323501029
		arg_135_1.duration_ = 3.77

		local var_135_0 = {
			zh = 3.766,
			ja = 1.999999999999
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play323501030(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = "10170ui_story"

			if arg_135_1.actors_[var_138_0] == nil then
				local var_138_1 = Asset.Load("Char/" .. "10170ui_story")

				if not isNil(var_138_1) then
					local var_138_2 = Object.Instantiate(Asset.Load("Char/" .. "10170ui_story"), arg_135_1.stage_.transform)

					var_138_2.name = var_138_0
					var_138_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_135_1.actors_[var_138_0] = var_138_2

					local var_138_3 = var_138_2:GetComponentInChildren(typeof(CharacterEffect))

					var_138_3.enabled = true

					local var_138_4 = GameObjectTools.GetOrAddComponent(var_138_2, typeof(DynamicBoneHelper))

					if var_138_4 then
						var_138_4:EnableDynamicBone(false)
					end

					arg_135_1:ShowWeapon(var_138_3.transform, false)

					arg_135_1.var_[var_138_0 .. "Animator"] = var_138_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_135_1.var_[var_138_0 .. "Animator"].applyRootMotion = true
					arg_135_1.var_[var_138_0 .. "LipSync"] = var_138_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_138_5 = arg_135_1.actors_["10170ui_story"].transform
			local var_138_6 = 0

			if var_138_6 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1.var_.moveOldPos10170ui_story = var_138_5.localPosition

				local var_138_7 = GameObjectTools.GetOrAddComponent(var_138_5.gameObject, typeof(DynamicBoneHelper))

				if var_138_7 then
					var_138_7:EnableDynamicBone(false)
				end
			end

			local var_138_8 = 0.001

			if var_138_6 <= arg_135_1.time_ and arg_135_1.time_ < var_138_6 + var_138_8 then
				local var_138_9 = (arg_135_1.time_ - var_138_6) / var_138_8
				local var_138_10 = Vector3.New(0, -1.03, -6.05)

				var_138_5.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10170ui_story, var_138_10, var_138_9)

				local var_138_11 = manager.ui.mainCamera.transform.position - var_138_5.position

				var_138_5.forward = Vector3.New(var_138_11.x, var_138_11.y, var_138_11.z)

				local var_138_12 = var_138_5.localEulerAngles

				var_138_12.z = 0
				var_138_12.x = 0
				var_138_5.localEulerAngles = var_138_12
			end

			if arg_135_1.time_ >= var_138_6 + var_138_8 and arg_135_1.time_ < var_138_6 + var_138_8 + arg_138_0 then
				var_138_5.localPosition = Vector3.New(0, -1.03, -6.05)

				local var_138_13 = manager.ui.mainCamera.transform.position - var_138_5.position

				var_138_5.forward = Vector3.New(var_138_13.x, var_138_13.y, var_138_13.z)

				local var_138_14 = var_138_5.localEulerAngles

				var_138_14.z = 0
				var_138_14.x = 0
				var_138_5.localEulerAngles = var_138_14

				local var_138_15 = GameObjectTools.GetOrAddComponent(var_138_5.gameObject, typeof(DynamicBoneHelper))

				if var_138_15 then
					var_138_15:EnableDynamicBone(true)
				end
			end

			local var_138_16 = arg_135_1.actors_["10170ui_story"]
			local var_138_17 = 0

			if var_138_17 < arg_135_1.time_ and arg_135_1.time_ <= var_138_17 + arg_138_0 and not isNil(var_138_16) and arg_135_1.var_.characterEffect10170ui_story == nil then
				arg_135_1.var_.characterEffect10170ui_story = var_138_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_18 = 0.200000002980232

			if var_138_17 <= arg_135_1.time_ and arg_135_1.time_ < var_138_17 + var_138_18 and not isNil(var_138_16) then
				local var_138_19 = (arg_135_1.time_ - var_138_17) / var_138_18

				if arg_135_1.var_.characterEffect10170ui_story and not isNil(var_138_16) then
					arg_135_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_17 + var_138_18 and arg_135_1.time_ < var_138_17 + var_138_18 + arg_138_0 and not isNil(var_138_16) and arg_135_1.var_.characterEffect10170ui_story then
				arg_135_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_138_20 = 0

			if var_138_20 < arg_135_1.time_ and arg_135_1.time_ <= var_138_20 + arg_138_0 then
				arg_135_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action30_1")
			end

			local var_138_21 = 0

			if var_138_21 < arg_135_1.time_ and arg_135_1.time_ <= var_138_21 + arg_138_0 then
				arg_135_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_138_22 = 0
			local var_138_23 = 0.475

			if var_138_22 < arg_135_1.time_ and arg_135_1.time_ <= var_138_22 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_24 = arg_135_1:FormatText(StoryNameCfg[1450].name)

				arg_135_1.leftNameTxt_.text = var_138_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_25 = arg_135_1:GetWordFromCfg(323501029)
				local var_138_26 = arg_135_1:FormatText(var_138_25.content)

				arg_135_1.text_.text = var_138_26

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_27 = 19
				local var_138_28 = utf8.len(var_138_26)
				local var_138_29 = var_138_27 <= 0 and var_138_23 or var_138_23 * (var_138_28 / var_138_27)

				if var_138_29 > 0 and var_138_23 < var_138_29 then
					arg_135_1.talkMaxDuration = var_138_29

					if var_138_29 + var_138_22 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_29 + var_138_22
					end
				end

				arg_135_1.text_.text = var_138_26
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323501", "323501029", "story_v_out_323501.awb") ~= 0 then
					local var_138_30 = manager.audio:GetVoiceLength("story_v_out_323501", "323501029", "story_v_out_323501.awb") / 1000

					if var_138_30 + var_138_22 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_30 + var_138_22
					end

					if var_138_25.prefab_name ~= "" and arg_135_1.actors_[var_138_25.prefab_name] ~= nil then
						local var_138_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_25.prefab_name].transform, "story_v_out_323501", "323501029", "story_v_out_323501.awb")

						arg_135_1:RecordAudio("323501029", var_138_31)
						arg_135_1:RecordAudio("323501029", var_138_31)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_323501", "323501029", "story_v_out_323501.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_323501", "323501029", "story_v_out_323501.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_32 = math.max(var_138_23, arg_135_1.talkMaxDuration)

			if var_138_22 <= arg_135_1.time_ and arg_135_1.time_ < var_138_22 + var_138_32 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_22) / var_138_32

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_22 + var_138_32 and arg_135_1.time_ < var_138_22 + var_138_32 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play323501030 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 323501030
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
			arg_139_1.auto_ = false
		end

		function arg_139_1.playNext_(arg_141_0)
			arg_139_1.onStoryFinished_()
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = "1033ui_story"

			if arg_139_1.actors_[var_142_0] == nil then
				local var_142_1 = Asset.Load("Char/" .. "1033ui_story")

				if not isNil(var_142_1) then
					local var_142_2 = Object.Instantiate(Asset.Load("Char/" .. "1033ui_story"), arg_139_1.stage_.transform)

					var_142_2.name = var_142_0
					var_142_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_139_1.actors_[var_142_0] = var_142_2

					local var_142_3 = var_142_2:GetComponentInChildren(typeof(CharacterEffect))

					var_142_3.enabled = true

					local var_142_4 = GameObjectTools.GetOrAddComponent(var_142_2, typeof(DynamicBoneHelper))

					if var_142_4 then
						var_142_4:EnableDynamicBone(false)
					end

					arg_139_1:ShowWeapon(var_142_3.transform, false)

					arg_139_1.var_[var_142_0 .. "Animator"] = var_142_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_139_1.var_[var_142_0 .. "Animator"].applyRootMotion = true
					arg_139_1.var_[var_142_0 .. "LipSync"] = var_142_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_142_5 = arg_139_1.actors_["1033ui_story"]
			local var_142_6 = 0

			if var_142_6 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.characterEffect1033ui_story == nil then
				arg_139_1.var_.characterEffect1033ui_story = var_142_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_7 = 0.200000002980232

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_7 and not isNil(var_142_5) then
				local var_142_8 = (arg_139_1.time_ - var_142_6) / var_142_7

				if arg_139_1.var_.characterEffect1033ui_story and not isNil(var_142_5) then
					local var_142_9 = Mathf.Lerp(0, 0.5, var_142_8)

					arg_139_1.var_.characterEffect1033ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1033ui_story.fillRatio = var_142_9
				end
			end

			if arg_139_1.time_ >= var_142_6 + var_142_7 and arg_139_1.time_ < var_142_6 + var_142_7 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.characterEffect1033ui_story then
				local var_142_10 = 0.5

				arg_139_1.var_.characterEffect1033ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1033ui_story.fillRatio = var_142_10
			end

			local var_142_11 = 0
			local var_142_12 = 0.55

			if var_142_11 < arg_139_1.time_ and arg_139_1.time_ <= var_142_11 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_13 = arg_139_1:FormatText(StoryNameCfg[7].name)

				arg_139_1.leftNameTxt_.text = var_142_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_14 = arg_139_1:GetWordFromCfg(323501030)
				local var_142_15 = arg_139_1:FormatText(var_142_14.content)

				arg_139_1.text_.text = var_142_15

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_16 = 22
				local var_142_17 = utf8.len(var_142_15)
				local var_142_18 = var_142_16 <= 0 and var_142_12 or var_142_12 * (var_142_17 / var_142_16)

				if var_142_18 > 0 and var_142_12 < var_142_18 then
					arg_139_1.talkMaxDuration = var_142_18

					if var_142_18 + var_142_11 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_18 + var_142_11
					end
				end

				arg_139_1.text_.text = var_142_15
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_19 = math.max(var_142_12, arg_139_1.talkMaxDuration)

			if var_142_11 <= arg_139_1.time_ and arg_139_1.time_ < var_142_11 + var_142_19 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_11) / var_142_19

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_11 + var_142_19 and arg_139_1.time_ < var_142_11 + var_142_19 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST03",
		"TextureConfig/Background/ST22",
		"TextureConfig/Background/ST59",
		"TextureConfig/Background/ST47",
		"TextureConfig/Background/J21f"
	},
	voices = {
		"story_v_out_323501.awb"
	}
}
