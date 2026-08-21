return {
	Play323162001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 323162001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play323162002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J22f"

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
				local var_4_5 = arg_1_1.bgs_.J22f

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
					if iter_4_0 ~= "J22f" then
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

			local var_4_24 = manager.ui.mainCamera.transform
			local var_4_25 = 0.3

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				local var_4_26 = arg_1_1.var_.effect334
				local var_4_27
				local var_4_28 = var_4_24

				if not var_4_26 then
					var_4_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xdaoguang"), var_4_28)
					var_4_26.name = "334"
					arg_1_1.var_.effect334 = var_4_26
				else
					var_4_26.transform:SetParent(var_4_28)
				end

				var_4_26.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_26.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_4_29 = 1.7777777777777777
				local var_4_30 = Screen.width / Screen.height
				local var_4_31 = var_4_30 / var_4_29
				local var_4_32 = Mathf.Max(var_4_29 / var_4_30, 1)

				var_4_26.transform.localScale = Vector3.New(var_4_26.transform.localScale.x * var_4_31, var_4_26.transform.localScale.y * var_4_32, var_4_26.transform.localScale.z)
			end

			local var_4_33 = 0
			local var_4_34 = 0.3

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				local var_4_35 = "play"
				local var_4_36 = "music"

				arg_1_1:AudioAction(var_4_35, var_4_36, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_37 = ""
				local var_4_38 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_38 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_38 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_38

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_38
						arg_1_1.bgmTxt2_.text = var_4_38
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

			local var_4_39 = 0.166666666666667
			local var_4_40 = 1

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				local var_4_41 = "play"
				local var_4_42 = "effect"

				arg_1_1:AudioAction(var_4_41, var_4_42, "se_story_146", "se_story_146_wind", "")
			end

			local var_4_43 = 0.3
			local var_4_44 = 1

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				local var_4_45 = "play"
				local var_4_46 = "effect"

				arg_1_1:AudioAction(var_4_45, var_4_46, "se_story_side_1093", "se_story_1093_hit", "")
			end

			local var_4_47 = 0.9
			local var_4_48 = 1

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				local var_4_49 = "play"
				local var_4_50 = "effect"

				arg_1_1:AudioAction(var_4_49, var_4_50, "se_story_3", "se_story_3_windspear", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_51 = 2
			local var_4_52 = 1.15

			if var_4_51 < arg_1_1.time_ and arg_1_1.time_ <= var_4_51 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_53 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_53:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_54 = arg_1_1:GetWordFromCfg(323162001)
				local var_4_55 = arg_1_1:FormatText(var_4_54.content)

				arg_1_1.text_.text = var_4_55

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_56 = 46
				local var_4_57 = utf8.len(var_4_55)
				local var_4_58 = var_4_56 <= 0 and var_4_52 or var_4_52 * (var_4_57 / var_4_56)

				if var_4_58 > 0 and var_4_52 < var_4_58 then
					arg_1_1.talkMaxDuration = var_4_58
					var_4_51 = var_4_51 + 0.3

					if var_4_58 + var_4_51 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_58 + var_4_51
					end
				end

				arg_1_1.text_.text = var_4_55
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_59 = var_4_51 + 0.3
			local var_4_60 = math.max(var_4_52, arg_1_1.talkMaxDuration)

			if var_4_59 <= arg_1_1.time_ and arg_1_1.time_ < var_4_59 + var_4_60 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_59) / var_4_60

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_59 + var_4_60 and arg_1_1.time_ < var_4_59 + var_4_60 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play323162002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 323162002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play323162003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.275

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_2 = arg_8_1:GetWordFromCfg(323162002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 51
				local var_11_5 = utf8.len(var_11_3)
				local var_11_6 = var_11_4 <= 0 and var_11_1 or var_11_1 * (var_11_5 / var_11_4)

				if var_11_6 > 0 and var_11_1 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_7 and arg_8_1.time_ < var_11_0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play323162003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 323162003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play323162004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			local var_15_1 = 1.33333333333333

			if arg_12_1.time_ >= var_15_0 + var_15_1 and arg_12_1.time_ < var_15_0 + var_15_1 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			local var_15_2 = 0
			local var_15_3 = 1

			if var_15_2 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				local var_15_4 = "play"
				local var_15_5 = "effect"

				arg_12_1:AudioAction(var_15_4, var_15_5, "se_story_148", "se_story_148_monster", "")
			end

			local var_15_6 = 0
			local var_15_7 = 0.125

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_8 = arg_12_1:FormatText(StoryNameCfg[1458].name)

				arg_12_1.leftNameTxt_.text = var_15_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2143")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_9 = arg_12_1:GetWordFromCfg(323162003)
				local var_15_10 = arg_12_1:FormatText(var_15_9.content)

				arg_12_1.text_.text = var_15_10

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 5
				local var_15_12 = utf8.len(var_15_10)
				local var_15_13 = var_15_11 <= 0 and var_15_7 or var_15_7 * (var_15_12 / var_15_11)

				if var_15_13 > 0 and var_15_7 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_10
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_14 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_14 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_14

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_14 and arg_12_1.time_ < var_15_6 + var_15_14 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequency = 7,
				className = "StoryShakeNode",
				duration = 0.533333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG_HEAD,
				offset = Vector3.New(10, 10, 0.1)
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play323162004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 323162004
		arg_16_1.duration_ = 1.17

		local var_16_0 = {
			zh = 1.049999999999,
			ja = 1.166
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play323162005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.05
			local var_19_1 = 1

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				local var_19_2 = "play"
				local var_19_3 = "effect"

				arg_16_1:AudioAction(var_19_2, var_19_3, "se_story_148", "se_story_148_hit", "")
			end

			local var_19_4 = 0
			local var_19_5 = 0.05

			if var_19_4 < arg_16_1.time_ and arg_16_1.time_ <= var_19_4 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_6 = arg_16_1:FormatText(StoryNameCfg[1451].name)

				arg_16_1.leftNameTxt_.text = var_19_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10171")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_7 = arg_16_1:GetWordFromCfg(323162004)
				local var_19_8 = arg_16_1:FormatText(var_19_7.content)

				arg_16_1.text_.text = var_19_8

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_9 = 2
				local var_19_10 = utf8.len(var_19_8)
				local var_19_11 = var_19_9 <= 0 and var_19_5 or var_19_5 * (var_19_10 / var_19_9)

				if var_19_11 > 0 and var_19_5 < var_19_11 then
					arg_16_1.talkMaxDuration = var_19_11

					if var_19_11 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_11 + var_19_4
					end
				end

				arg_16_1.text_.text = var_19_8
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162004", "story_v_out_323162.awb") ~= 0 then
					local var_19_12 = manager.audio:GetVoiceLength("story_v_out_323162", "323162004", "story_v_out_323162.awb") / 1000

					if var_19_12 + var_19_4 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_12 + var_19_4
					end

					if var_19_7.prefab_name ~= "" and arg_16_1.actors_[var_19_7.prefab_name] ~= nil then
						local var_19_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_7.prefab_name].transform, "story_v_out_323162", "323162004", "story_v_out_323162.awb")

						arg_16_1:RecordAudio("323162004", var_19_13)
						arg_16_1:RecordAudio("323162004", var_19_13)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_323162", "323162004", "story_v_out_323162.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_323162", "323162004", "story_v_out_323162.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_14 = math.max(var_19_5, arg_16_1.talkMaxDuration)

			if var_19_4 <= arg_16_1.time_ and arg_16_1.time_ < var_19_4 + var_19_14 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_4) / var_19_14

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_4 + var_19_14 and arg_16_1.time_ < var_19_4 + var_19_14 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play323162005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 323162005
		arg_20_1.duration_ = 7

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play323162006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				local var_23_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_23_2 then
					var_23_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_23_2.radialBlurScale = 0
					var_23_2.radialBlurGradient = 1
					var_23_2.radialBlurIntensity = 1

					if var_23_0 then
						var_23_2.radialBlurTarget = var_23_0.transform
					end
				end
			end

			local var_23_3 = 0.9

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_3 then
				local var_23_4 = (arg_20_1.time_ - var_23_1) / var_23_3
				local var_23_5 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_23_5 then
					var_23_5.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_23_5.radialBlurScale = Mathf.Lerp(0, 0.477, var_23_4)
					var_23_5.radialBlurGradient = Mathf.Lerp(1, 1, var_23_4)
					var_23_5.radialBlurIntensity = Mathf.Lerp(1, 1, var_23_4)
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_3 and arg_20_1.time_ < var_23_1 + var_23_3 + arg_23_0 then
				local var_23_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_23_6 then
					var_23_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_23_6.radialBlurScale = 0.477
					var_23_6.radialBlurGradient = 1
					var_23_6.radialBlurIntensity = 1
				end
			end

			local var_23_7
			local var_23_8 = 1.3

			if var_23_8 < arg_20_1.time_ and arg_20_1.time_ <= var_23_8 + arg_23_0 then
				local var_23_9 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_23_9 then
					var_23_9.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_23_9.radialBlurScale = 0.482
					var_23_9.radialBlurGradient = 1
					var_23_9.radialBlurIntensity = 1

					if var_23_7 then
						var_23_9.radialBlurTarget = var_23_7.transform
					end
				end
			end

			local var_23_10 = 0.9

			if var_23_8 <= arg_20_1.time_ and arg_20_1.time_ < var_23_8 + var_23_10 then
				local var_23_11 = (arg_20_1.time_ - var_23_8) / var_23_10
				local var_23_12 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_23_12 then
					var_23_12.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_23_12.radialBlurScale = Mathf.Lerp(0.482, 0.877, var_23_11)
					var_23_12.radialBlurGradient = Mathf.Lerp(1, 1, var_23_11)
					var_23_12.radialBlurIntensity = Mathf.Lerp(1, 1, var_23_11)
				end
			end

			if arg_20_1.time_ >= var_23_8 + var_23_10 and arg_20_1.time_ < var_23_8 + var_23_10 + arg_23_0 then
				local var_23_13 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_23_13 then
					var_23_13.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_23_13.radialBlurScale = 0.877
					var_23_13.radialBlurGradient = 1
					var_23_13.radialBlurIntensity = 1
				end
			end

			local var_23_14 = 0

			if var_23_14 < arg_20_1.time_ and arg_20_1.time_ <= var_23_14 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			local var_23_15 = 2.32807960337959

			if arg_20_1.time_ >= var_23_14 + var_23_15 and arg_20_1.time_ < var_23_14 + var_23_15 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			local var_23_16 = manager.ui.mainCamera.transform
			local var_23_17 = 0.266666666666667

			if var_23_17 < arg_20_1.time_ and arg_20_1.time_ <= var_23_17 + arg_23_0 then
				local var_23_18 = arg_20_1.var_.effect33
				local var_23_19
				local var_23_20 = var_23_16

				if not var_23_18 then
					var_23_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapblink"), var_23_20)
					var_23_18.name = "33"
					arg_20_1.var_.effect33 = var_23_18
				else
					var_23_18.transform:SetParent(var_23_20)
				end

				var_23_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_23_18.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_23_21 = 1.7777777777777777
				local var_23_22 = Screen.width / Screen.height
				local var_23_23 = var_23_22 / var_23_21
				local var_23_24 = Mathf.Max(var_23_21 / var_23_22, 1)

				var_23_18.transform.localScale = Vector3.New(var_23_18.transform.localScale.x * var_23_23, var_23_18.transform.localScale.y * var_23_24, var_23_18.transform.localScale.z)
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_25 = 2
			local var_23_26 = 1.55

			if var_23_25 < arg_20_1.time_ and arg_20_1.time_ <= var_23_25 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_27 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_27:setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
					arg_20_1.dialogCg_.alpha = arg_24_0
				end))
				var_23_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_28 = arg_20_1:GetWordFromCfg(323162005)
				local var_23_29 = arg_20_1:FormatText(var_23_28.content)

				arg_20_1.text_.text = var_23_29

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_30 = 62
				local var_23_31 = utf8.len(var_23_29)
				local var_23_32 = var_23_30 <= 0 and var_23_26 or var_23_26 * (var_23_31 / var_23_30)

				if var_23_32 > 0 and var_23_26 < var_23_32 then
					arg_20_1.talkMaxDuration = var_23_32
					var_23_25 = var_23_25 + 0.3

					if var_23_32 + var_23_25 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_32 + var_23_25
					end
				end

				arg_20_1.text_.text = var_23_29
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_33 = var_23_25 + 0.3
			local var_23_34 = math.max(var_23_26, arg_20_1.talkMaxDuration)

			if var_23_33 <= arg_20_1.time_ and arg_20_1.time_ < var_23_33 + var_23_34 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_33) / var_23_34

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_33 + var_23_34 and arg_20_1.time_ < var_23_33 + var_23_34 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play323162006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 323162006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play323162007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0
			local var_29_1 = 1.35

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_2 = arg_26_1:GetWordFromCfg(323162006)
				local var_29_3 = arg_26_1:FormatText(var_29_2.content)

				arg_26_1.text_.text = var_29_3

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 54
				local var_29_5 = utf8.len(var_29_3)
				local var_29_6 = var_29_4 <= 0 and var_29_1 or var_29_1 * (var_29_5 / var_29_4)

				if var_29_6 > 0 and var_29_1 < var_29_6 then
					arg_26_1.talkMaxDuration = var_29_6

					if var_29_6 + var_29_0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_6 + var_29_0
					end
				end

				arg_26_1.text_.text = var_29_3
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_7 = math.max(var_29_1, arg_26_1.talkMaxDuration)

			if var_29_0 <= arg_26_1.time_ and arg_26_1.time_ < var_29_0 + var_29_7 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_0) / var_29_7

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_0 + var_29_7 and arg_26_1.time_ < var_29_0 + var_29_7 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play323162007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 323162007
		arg_30_1.duration_ = 5.57

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play323162008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.allBtn_.enabled = false
			end

			local var_33_1 = 1.5

			if arg_30_1.time_ >= var_33_0 + var_33_1 and arg_30_1.time_ < var_33_0 + var_33_1 + arg_33_0 then
				arg_30_1.allBtn_.enabled = true
			end

			local var_33_2 = "STblack"

			if arg_30_1.bgs_[var_33_2] == nil then
				local var_33_3 = Object.Instantiate(arg_30_1.paintGo_)

				var_33_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_33_2)
				var_33_3.name = var_33_2
				var_33_3.transform.parent = arg_30_1.stage_.transform
				var_33_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_30_1.bgs_[var_33_2] = var_33_3
			end

			local var_33_4 = 0

			if var_33_4 < arg_30_1.time_ and arg_30_1.time_ <= var_33_4 + arg_33_0 then
				local var_33_5 = manager.ui.mainCamera.transform.localPosition
				local var_33_6 = Vector3.New(0, 0, 10) + Vector3.New(var_33_5.x, var_33_5.y, 0)
				local var_33_7 = arg_30_1.bgs_.STblack

				var_33_7.transform.localPosition = var_33_6
				var_33_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_33_8 = var_33_7:GetComponent("SpriteRenderer")

				if var_33_8 and var_33_8.sprite then
					local var_33_9 = (var_33_7.transform.localPosition - var_33_5).z
					local var_33_10 = manager.ui.mainCameraCom_
					local var_33_11 = 2 * var_33_9 * Mathf.Tan(var_33_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_33_12 = var_33_11 * var_33_10.aspect
					local var_33_13 = var_33_8.sprite.bounds.size.x
					local var_33_14 = var_33_8.sprite.bounds.size.y
					local var_33_15 = var_33_12 / var_33_13
					local var_33_16 = var_33_11 / var_33_14
					local var_33_17 = var_33_16 < var_33_15 and var_33_15 or var_33_16

					var_33_7.transform.localScale = Vector3.New(var_33_17, var_33_17, 0)
				end

				for iter_33_0, iter_33_1 in pairs(arg_30_1.bgs_) do
					if iter_33_0 ~= "STblack" then
						iter_33_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_33_18 = 0

			if var_33_18 < arg_30_1.time_ and arg_30_1.time_ <= var_33_18 + arg_33_0 then
				arg_30_1.mask_.enabled = true
				arg_30_1.mask_.raycastTarget = true

				arg_30_1:SetGaussion(false)
			end

			local var_33_19 = 0.433333333333333

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

			local var_33_24
			local var_33_25 = 0

			if var_33_25 < arg_30_1.time_ and arg_30_1.time_ <= var_33_25 + arg_33_0 then
				local var_33_26 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_33_26 then
					var_33_26.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_33_26.radialBlurScale = 0.473
					var_33_26.radialBlurGradient = 1
					var_33_26.radialBlurIntensity = 1

					if var_33_24 then
						var_33_26.radialBlurTarget = var_33_24.transform
					end
				end
			end

			local var_33_27 = 0.9

			if var_33_25 <= arg_30_1.time_ and arg_30_1.time_ < var_33_25 + var_33_27 then
				local var_33_28 = (arg_30_1.time_ - var_33_25) / var_33_27
				local var_33_29 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_33_29 then
					var_33_29.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_33_29.radialBlurScale = Mathf.Lerp(0.473, 0, var_33_28)
					var_33_29.radialBlurGradient = Mathf.Lerp(1, 1, var_33_28)
					var_33_29.radialBlurIntensity = Mathf.Lerp(1, 1, var_33_28)
				end
			end

			if arg_30_1.time_ >= var_33_25 + var_33_27 and arg_30_1.time_ < var_33_25 + var_33_27 + arg_33_0 then
				local var_33_30 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_33_30 then
					var_33_30.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_33_30.radialBlurScale = 0
					var_33_30.radialBlurGradient = 1
					var_33_30.radialBlurIntensity = 1
				end
			end

			local var_33_31 = 0.566666666666667
			local var_33_32 = 1

			if var_33_31 < arg_30_1.time_ and arg_30_1.time_ <= var_33_31 + arg_33_0 then
				local var_33_33 = "play"
				local var_33_34 = "effect"

				arg_30_1:AudioAction(var_33_33, var_33_34, "se_story_140", "se_story_140_explosion01", "")
			end

			local var_33_35 = 0
			local var_33_36 = 1

			if var_33_35 < arg_30_1.time_ and arg_30_1.time_ <= var_33_35 + arg_33_0 then
				local var_33_37 = "play"
				local var_33_38 = "effect"

				arg_30_1:AudioAction(var_33_37, var_33_38, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			local var_33_39 = 0
			local var_33_40 = 1

			if var_33_39 < arg_30_1.time_ and arg_30_1.time_ <= var_33_39 + arg_33_0 then
				local var_33_41 = "stop"
				local var_33_42 = "effect"

				arg_30_1:AudioAction(var_33_41, var_33_42, "se_story_146", "se_story_146_wind", "")
			end

			if arg_30_1.frameCnt_ <= 1 then
				arg_30_1.dialog_:SetActive(false)
			end

			local var_33_43 = 0.566666666666667
			local var_33_44 = 0.125

			if var_33_43 < arg_30_1.time_ and arg_30_1.time_ <= var_33_43 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0

				arg_30_1.dialog_:SetActive(true)

				arg_30_1.dialogCg_.alpha = 0

				local var_33_45 = LeanTween.value(arg_30_1.dialog_, 0, 1, 0.3)

				var_33_45:setOnUpdate(LuaHelper.FloatAction(function(arg_34_0)
					arg_30_1.dialogCg_.alpha = arg_34_0
				end))
				var_33_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_30_1.dialog_)
					var_33_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_30_1.duration_ = arg_30_1.duration_ + 0.3

				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_46 = arg_30_1:GetWordFromCfg(323162007)
				local var_33_47 = arg_30_1:FormatText(var_33_46.content)

				arg_30_1.text_.text = var_33_47

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_48 = 5
				local var_33_49 = utf8.len(var_33_47)
				local var_33_50 = var_33_48 <= 0 and var_33_44 or var_33_44 * (var_33_49 / var_33_48)

				if var_33_50 > 0 and var_33_44 < var_33_50 then
					arg_30_1.talkMaxDuration = var_33_50
					var_33_43 = var_33_43 + 0.3

					if var_33_50 + var_33_43 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_50 + var_33_43
					end
				end

				arg_30_1.text_.text = var_33_47
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_51 = var_33_43 + 0.3
			local var_33_52 = math.max(var_33_44, arg_30_1.talkMaxDuration)

			if var_33_51 <= arg_30_1.time_ and arg_30_1.time_ < var_33_51 + var_33_52 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_51) / var_33_52

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_51 + var_33_52 and arg_30_1.time_ < var_33_51 + var_33_52 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequency = 12,
				className = "StoryShakeNode",
				duration = 0.933333327372869,
				startTime = 0.166666672627131,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG,
				offset = Vector3.New(10, 0, 0)
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play323162008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 323162008
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play323162009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				local var_39_1 = manager.ui.mainCamera.transform.localPosition
				local var_39_2 = Vector3.New(0, 0, 10) + Vector3.New(var_39_1.x, var_39_1.y, 0)
				local var_39_3 = arg_36_1.bgs_.STblack

				var_39_3.transform.localPosition = var_39_2
				var_39_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_39_4 = var_39_3:GetComponent("SpriteRenderer")

				if var_39_4 and var_39_4.sprite then
					local var_39_5 = (var_39_3.transform.localPosition - var_39_1).z
					local var_39_6 = manager.ui.mainCameraCom_
					local var_39_7 = 2 * var_39_5 * Mathf.Tan(var_39_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_39_8 = var_39_7 * var_39_6.aspect
					local var_39_9 = var_39_4.sprite.bounds.size.x
					local var_39_10 = var_39_4.sprite.bounds.size.y
					local var_39_11 = var_39_8 / var_39_9
					local var_39_12 = var_39_7 / var_39_10
					local var_39_13 = var_39_12 < var_39_11 and var_39_11 or var_39_12

					var_39_3.transform.localScale = Vector3.New(var_39_13, var_39_13, 0)
				end

				for iter_39_0, iter_39_1 in pairs(arg_36_1.bgs_) do
					if iter_39_0 ~= "STblack" then
						iter_39_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_39_14 = 0

			if var_39_14 < arg_36_1.time_ and arg_36_1.time_ <= var_39_14 + arg_39_0 then
				arg_36_1.allBtn_.enabled = false
			end

			local var_39_15 = 0.3

			if arg_36_1.time_ >= var_39_14 + var_39_15 and arg_36_1.time_ < var_39_14 + var_39_15 + arg_39_0 then
				arg_36_1.allBtn_.enabled = true
			end

			local var_39_16 = 0
			local var_39_17 = 0.575

			if var_39_16 < arg_36_1.time_ and arg_36_1.time_ <= var_39_16 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0

				arg_36_1.dialog_:SetActive(true)

				arg_36_1.dialogCg_.alpha = 0

				local var_39_18 = LeanTween.value(arg_36_1.dialog_, 0, 1, 0.3)

				var_39_18:setOnUpdate(LuaHelper.FloatAction(function(arg_40_0)
					arg_36_1.dialogCg_.alpha = arg_40_0
				end))
				var_39_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_36_1.dialog_)
					var_39_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_36_1.duration_ = arg_36_1.duration_ + 0.3

				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_19 = arg_36_1:GetWordFromCfg(323162008)
				local var_39_20 = arg_36_1:FormatText(var_39_19.content)

				arg_36_1.text_.text = var_39_20

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_21 = 23
				local var_39_22 = utf8.len(var_39_20)
				local var_39_23 = var_39_21 <= 0 and var_39_17 or var_39_17 * (var_39_22 / var_39_21)

				if var_39_23 > 0 and var_39_17 < var_39_23 then
					arg_36_1.talkMaxDuration = var_39_23
					var_39_16 = var_39_16 + 0.3

					if var_39_23 + var_39_16 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_23 + var_39_16
					end
				end

				arg_36_1.text_.text = var_39_20
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_24 = var_39_16 + 0.3
			local var_39_25 = math.max(var_39_17, arg_36_1.talkMaxDuration)

			if var_39_24 <= arg_36_1.time_ and arg_36_1.time_ < var_39_24 + var_39_25 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_24) / var_39_25

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_24 + var_39_25 and arg_36_1.time_ < var_39_24 + var_39_25 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play323162009 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 323162009
		arg_42_1.duration_ = 5

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play323162010(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1.allBtn_.enabled = false
			end

			local var_45_1 = 1.76666666666667

			if arg_42_1.time_ >= var_45_0 + var_45_1 and arg_42_1.time_ < var_45_0 + var_45_1 + arg_45_0 then
				arg_42_1.allBtn_.enabled = true
			end

			local var_45_2 = 0
			local var_45_3 = 1.15

			if var_45_2 < arg_42_1.time_ and arg_42_1.time_ <= var_45_2 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_4 = arg_42_1:GetWordFromCfg(323162009)
				local var_45_5 = arg_42_1:FormatText(var_45_4.content)

				arg_42_1.text_.text = var_45_5

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_6 = 46
				local var_45_7 = utf8.len(var_45_5)
				local var_45_8 = var_45_6 <= 0 and var_45_3 or var_45_3 * (var_45_7 / var_45_6)

				if var_45_8 > 0 and var_45_3 < var_45_8 then
					arg_42_1.talkMaxDuration = var_45_8

					if var_45_8 + var_45_2 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_8 + var_45_2
					end
				end

				arg_42_1.text_.text = var_45_5
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_9 = math.max(var_45_3, arg_42_1.talkMaxDuration)

			if var_45_2 <= arg_42_1.time_ and arg_42_1.time_ < var_45_2 + var_45_9 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_2) / var_45_9

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_2 + var_45_9 and arg_42_1.time_ < var_45_2 + var_45_9 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play323162010 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 323162010
		arg_46_1.duration_ = 6.88

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play323162011(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.mask_.enabled = true
				arg_46_1.mask_.raycastTarget = true

				arg_46_1:SetGaussion(false)
			end

			local var_49_1 = 1

			if var_49_0 <= arg_46_1.time_ and arg_46_1.time_ < var_49_0 + var_49_1 then
				local var_49_2 = (arg_46_1.time_ - var_49_0) / var_49_1
				local var_49_3 = Color.New(0, 0, 0)

				var_49_3.a = Mathf.Lerp(0, 1, var_49_2)
				arg_46_1.mask_.color = var_49_3
			end

			if arg_46_1.time_ >= var_49_0 + var_49_1 and arg_46_1.time_ < var_49_0 + var_49_1 + arg_49_0 then
				local var_49_4 = Color.New(0, 0, 0)

				var_49_4.a = 1
				arg_46_1.mask_.color = var_49_4
			end

			local var_49_5 = 1

			if var_49_5 < arg_46_1.time_ and arg_46_1.time_ <= var_49_5 + arg_49_0 then
				arg_46_1.mask_.enabled = true
				arg_46_1.mask_.raycastTarget = true

				arg_46_1:SetGaussion(false)
			end

			local var_49_6 = 1

			if var_49_5 <= arg_46_1.time_ and arg_46_1.time_ < var_49_5 + var_49_6 then
				local var_49_7 = (arg_46_1.time_ - var_49_5) / var_49_6
				local var_49_8 = Color.New(0, 0, 0)

				var_49_8.a = Mathf.Lerp(1, 0, var_49_7)
				arg_46_1.mask_.color = var_49_8
			end

			if arg_46_1.time_ >= var_49_5 + var_49_6 and arg_46_1.time_ < var_49_5 + var_49_6 + arg_49_0 then
				local var_49_9 = Color.New(0, 0, 0)
				local var_49_10 = 0

				arg_46_1.mask_.enabled = false
				var_49_9.a = var_49_10
				arg_46_1.mask_.color = var_49_9
			end

			if arg_46_1.frameCnt_ <= 1 then
				arg_46_1.dialog_:SetActive(false)
			end

			local var_49_11 = 1.875
			local var_49_12 = 0.125

			if var_49_11 < arg_46_1.time_ and arg_46_1.time_ <= var_49_11 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0

				arg_46_1.dialog_:SetActive(true)

				arg_46_1.dialogCg_.alpha = 0

				local var_49_13 = LeanTween.value(arg_46_1.dialog_, 0, 1, 0.3)

				var_49_13:setOnUpdate(LuaHelper.FloatAction(function(arg_50_0)
					arg_46_1.dialogCg_.alpha = arg_50_0
				end))
				var_49_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_46_1.dialog_)
					var_49_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_46_1.duration_ = arg_46_1.duration_ + 0.3

				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_14 = arg_46_1:GetWordFromCfg(323162010)
				local var_49_15 = arg_46_1:FormatText(var_49_14.content)

				arg_46_1.text_.text = var_49_15

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_16 = 5
				local var_49_17 = utf8.len(var_49_15)
				local var_49_18 = var_49_16 <= 0 and var_49_12 or var_49_12 * (var_49_17 / var_49_16)

				if var_49_18 > 0 and var_49_12 < var_49_18 then
					arg_46_1.talkMaxDuration = var_49_18
					var_49_11 = var_49_11 + 0.3

					if var_49_18 + var_49_11 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_18 + var_49_11
					end
				end

				arg_46_1.text_.text = var_49_15
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_19 = var_49_11 + 0.3
			local var_49_20 = math.max(var_49_12, arg_46_1.talkMaxDuration)

			if var_49_19 <= arg_46_1.time_ and arg_46_1.time_ < var_49_19 + var_49_20 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_19) / var_49_20

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_19 + var_49_20 and arg_46_1.time_ < var_49_19 + var_49_20 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play323162011 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 323162011
		arg_52_1.duration_ = 2

		local var_52_0 = {
			zh = 2,
			ja = 1.633
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
				arg_52_0:Play323162012(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0
			local var_55_1 = 1

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				local var_55_2 = "play"
				local var_55_3 = "effect"

				arg_52_1:AudioAction(var_55_2, var_55_3, "se_story_147", "se_story_147_dizzy_down", "")
			end

			local var_55_4 = 0
			local var_55_5 = 0.075

			if var_55_4 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_6 = arg_52_1:FormatText(StoryNameCfg[1451].name)

				arg_52_1.leftNameTxt_.text = var_55_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10171")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_7 = arg_52_1:GetWordFromCfg(323162011)
				local var_55_8 = arg_52_1:FormatText(var_55_7.content)

				arg_52_1.text_.text = var_55_8

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 3
				local var_55_10 = utf8.len(var_55_8)
				local var_55_11 = var_55_9 <= 0 and var_55_5 or var_55_5 * (var_55_10 / var_55_9)

				if var_55_11 > 0 and var_55_5 < var_55_11 then
					arg_52_1.talkMaxDuration = var_55_11

					if var_55_11 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_11 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_8
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162011", "story_v_out_323162.awb") ~= 0 then
					local var_55_12 = manager.audio:GetVoiceLength("story_v_out_323162", "323162011", "story_v_out_323162.awb") / 1000

					if var_55_12 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_12 + var_55_4
					end

					if var_55_7.prefab_name ~= "" and arg_52_1.actors_[var_55_7.prefab_name] ~= nil then
						local var_55_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_7.prefab_name].transform, "story_v_out_323162", "323162011", "story_v_out_323162.awb")

						arg_52_1:RecordAudio("323162011", var_55_13)
						arg_52_1:RecordAudio("323162011", var_55_13)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_323162", "323162011", "story_v_out_323162.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_323162", "323162011", "story_v_out_323162.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_14 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_14 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_14

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_14 and arg_52_1.time_ < var_55_4 + var_55_14 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play323162012 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 323162012
		arg_56_1.duration_ = 2.5

		local var_56_0 = {
			zh = 1.133,
			ja = 2.5
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
				arg_56_0:Play323162013(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = "1075ui_story"

			if arg_56_1.actors_[var_59_0] == nil then
				local var_59_1 = Asset.Load("Char/" .. "1075ui_story")

				if not isNil(var_59_1) then
					local var_59_2 = Object.Instantiate(Asset.Load("Char/" .. "1075ui_story"), arg_56_1.stage_.transform)

					var_59_2.name = var_59_0
					var_59_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_56_1.actors_[var_59_0] = var_59_2

					local var_59_3 = var_59_2:GetComponentInChildren(typeof(CharacterEffect))

					var_59_3.enabled = true

					local var_59_4 = GameObjectTools.GetOrAddComponent(var_59_2, typeof(DynamicBoneHelper))

					if var_59_4 then
						var_59_4:EnableDynamicBone(false)
					end

					arg_56_1:ShowWeapon(var_59_3.transform, false)

					arg_56_1.var_[var_59_0 .. "Animator"] = var_59_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_56_1.var_[var_59_0 .. "Animator"].applyRootMotion = true
					arg_56_1.var_[var_59_0 .. "LipSync"] = var_59_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_59_5 = arg_56_1.actors_["1075ui_story"]
			local var_59_6 = 0

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 and not isNil(var_59_5) and arg_56_1.var_.characterEffect1075ui_story == nil then
				arg_56_1.var_.characterEffect1075ui_story = var_59_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_7 = 0.200000002980232

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_7 and not isNil(var_59_5) then
				local var_59_8 = (arg_56_1.time_ - var_59_6) / var_59_7

				if arg_56_1.var_.characterEffect1075ui_story and not isNil(var_59_5) then
					arg_56_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_6 + var_59_7 and arg_56_1.time_ < var_59_6 + var_59_7 + arg_59_0 and not isNil(var_59_5) and arg_56_1.var_.characterEffect1075ui_story then
				arg_56_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_59_9 = 0
			local var_59_10 = 0.075

			if var_59_9 < arg_56_1.time_ and arg_56_1.time_ <= var_59_9 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_11 = arg_56_1:FormatText(StoryNameCfg[381].name)

				arg_56_1.leftNameTxt_.text = var_59_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_12 = arg_56_1:GetWordFromCfg(323162012)
				local var_59_13 = arg_56_1:FormatText(var_59_12.content)

				arg_56_1.text_.text = var_59_13

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_14 = 3
				local var_59_15 = utf8.len(var_59_13)
				local var_59_16 = var_59_14 <= 0 and var_59_10 or var_59_10 * (var_59_15 / var_59_14)

				if var_59_16 > 0 and var_59_10 < var_59_16 then
					arg_56_1.talkMaxDuration = var_59_16

					if var_59_16 + var_59_9 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_16 + var_59_9
					end
				end

				arg_56_1.text_.text = var_59_13
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162012", "story_v_out_323162.awb") ~= 0 then
					local var_59_17 = manager.audio:GetVoiceLength("story_v_out_323162", "323162012", "story_v_out_323162.awb") / 1000

					if var_59_17 + var_59_9 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_17 + var_59_9
					end

					if var_59_12.prefab_name ~= "" and arg_56_1.actors_[var_59_12.prefab_name] ~= nil then
						local var_59_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_12.prefab_name].transform, "story_v_out_323162", "323162012", "story_v_out_323162.awb")

						arg_56_1:RecordAudio("323162012", var_59_18)
						arg_56_1:RecordAudio("323162012", var_59_18)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_323162", "323162012", "story_v_out_323162.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_323162", "323162012", "story_v_out_323162.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_19 = math.max(var_59_10, arg_56_1.talkMaxDuration)

			if var_59_9 <= arg_56_1.time_ and arg_56_1.time_ < var_59_9 + var_59_19 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_9) / var_59_19

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_9 + var_59_19 and arg_56_1.time_ < var_59_9 + var_59_19 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play323162013 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 323162013
		arg_60_1.duration_ = 1.8

		local var_60_0 = {
			zh = 1.333,
			ja = 1.8
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
				arg_60_0:Play323162014(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = "10039ui_story"

			if arg_60_1.actors_[var_63_0] == nil then
				local var_63_1 = Asset.Load("Char/" .. "10039ui_story")

				if not isNil(var_63_1) then
					local var_63_2 = Object.Instantiate(Asset.Load("Char/" .. "10039ui_story"), arg_60_1.stage_.transform)

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

			local var_63_5 = arg_60_1.actors_["10039ui_story"]
			local var_63_6 = 0

			if var_63_6 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 and not isNil(var_63_5) and arg_60_1.var_.characterEffect10039ui_story == nil then
				arg_60_1.var_.characterEffect10039ui_story = var_63_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_7 = 0.200000002980232

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_7 and not isNil(var_63_5) then
				local var_63_8 = (arg_60_1.time_ - var_63_6) / var_63_7

				if arg_60_1.var_.characterEffect10039ui_story and not isNil(var_63_5) then
					arg_60_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_6 + var_63_7 and arg_60_1.time_ < var_63_6 + var_63_7 + arg_63_0 and not isNil(var_63_5) and arg_60_1.var_.characterEffect10039ui_story then
				arg_60_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_63_9 = arg_60_1.actors_["1075ui_story"]
			local var_63_10 = 0

			if var_63_10 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 and not isNil(var_63_9) and arg_60_1.var_.characterEffect1075ui_story == nil then
				arg_60_1.var_.characterEffect1075ui_story = var_63_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_11 = 0.200000002980232

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_11 and not isNil(var_63_9) then
				local var_63_12 = (arg_60_1.time_ - var_63_10) / var_63_11

				if arg_60_1.var_.characterEffect1075ui_story and not isNil(var_63_9) then
					local var_63_13 = Mathf.Lerp(0, 0.5, var_63_12)

					arg_60_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1075ui_story.fillRatio = var_63_13
				end
			end

			if arg_60_1.time_ >= var_63_10 + var_63_11 and arg_60_1.time_ < var_63_10 + var_63_11 + arg_63_0 and not isNil(var_63_9) and arg_60_1.var_.characterEffect1075ui_story then
				local var_63_14 = 0.5

				arg_60_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1075ui_story.fillRatio = var_63_14
			end

			local var_63_15 = 0
			local var_63_16 = 0.125

			if var_63_15 < arg_60_1.time_ and arg_60_1.time_ <= var_63_15 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_17 = arg_60_1:FormatText(StoryNameCfg[472].name)

				arg_60_1.leftNameTxt_.text = var_63_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10039")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_18 = arg_60_1:GetWordFromCfg(323162013)
				local var_63_19 = arg_60_1:FormatText(var_63_18.content)

				arg_60_1.text_.text = var_63_19

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_20 = 5
				local var_63_21 = utf8.len(var_63_19)
				local var_63_22 = var_63_20 <= 0 and var_63_16 or var_63_16 * (var_63_21 / var_63_20)

				if var_63_22 > 0 and var_63_16 < var_63_22 then
					arg_60_1.talkMaxDuration = var_63_22

					if var_63_22 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_22 + var_63_15
					end
				end

				arg_60_1.text_.text = var_63_19
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162013", "story_v_out_323162.awb") ~= 0 then
					local var_63_23 = manager.audio:GetVoiceLength("story_v_out_323162", "323162013", "story_v_out_323162.awb") / 1000

					if var_63_23 + var_63_15 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_23 + var_63_15
					end

					if var_63_18.prefab_name ~= "" and arg_60_1.actors_[var_63_18.prefab_name] ~= nil then
						local var_63_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_18.prefab_name].transform, "story_v_out_323162", "323162013", "story_v_out_323162.awb")

						arg_60_1:RecordAudio("323162013", var_63_24)
						arg_60_1:RecordAudio("323162013", var_63_24)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_323162", "323162013", "story_v_out_323162.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_323162", "323162013", "story_v_out_323162.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_25 = math.max(var_63_16, arg_60_1.talkMaxDuration)

			if var_63_15 <= arg_60_1.time_ and arg_60_1.time_ < var_63_15 + var_63_25 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_15) / var_63_25

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_15 + var_63_25 and arg_60_1.time_ < var_63_15 + var_63_25 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play323162014 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 323162014
		arg_64_1.duration_ = 2.77

		local var_64_0 = {
			zh = 1.333,
			ja = 2.766
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
				arg_64_0:Play323162015(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1075ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1075ui_story == nil then
				arg_64_1.var_.characterEffect1075ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1075ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1075ui_story then
				arg_64_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["10039ui_story"]
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect10039ui_story == nil then
				arg_64_1.var_.characterEffect10039ui_story = var_67_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.200000002980232

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 and not isNil(var_67_4) then
				local var_67_7 = (arg_64_1.time_ - var_67_5) / var_67_6

				if arg_64_1.var_.characterEffect10039ui_story and not isNil(var_67_4) then
					local var_67_8 = Mathf.Lerp(0, 0.5, var_67_7)

					arg_64_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10039ui_story.fillRatio = var_67_8
				end
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect10039ui_story then
				local var_67_9 = 0.5

				arg_64_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10039ui_story.fillRatio = var_67_9
			end

			local var_67_10 = 0
			local var_67_11 = 0.125

			if var_67_10 < arg_64_1.time_ and arg_64_1.time_ <= var_67_10 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_12 = arg_64_1:FormatText(StoryNameCfg[381].name)

				arg_64_1.leftNameTxt_.text = var_67_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1075")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_13 = arg_64_1:GetWordFromCfg(323162014)
				local var_67_14 = arg_64_1:FormatText(var_67_13.content)

				arg_64_1.text_.text = var_67_14

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_15 = 5
				local var_67_16 = utf8.len(var_67_14)
				local var_67_17 = var_67_15 <= 0 and var_67_11 or var_67_11 * (var_67_16 / var_67_15)

				if var_67_17 > 0 and var_67_11 < var_67_17 then
					arg_64_1.talkMaxDuration = var_67_17

					if var_67_17 + var_67_10 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_17 + var_67_10
					end
				end

				arg_64_1.text_.text = var_67_14
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162014", "story_v_out_323162.awb") ~= 0 then
					local var_67_18 = manager.audio:GetVoiceLength("story_v_out_323162", "323162014", "story_v_out_323162.awb") / 1000

					if var_67_18 + var_67_10 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_18 + var_67_10
					end

					if var_67_13.prefab_name ~= "" and arg_64_1.actors_[var_67_13.prefab_name] ~= nil then
						local var_67_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_13.prefab_name].transform, "story_v_out_323162", "323162014", "story_v_out_323162.awb")

						arg_64_1:RecordAudio("323162014", var_67_19)
						arg_64_1:RecordAudio("323162014", var_67_19)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_323162", "323162014", "story_v_out_323162.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_323162", "323162014", "story_v_out_323162.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_20 = math.max(var_67_11, arg_64_1.talkMaxDuration)

			if var_67_10 <= arg_64_1.time_ and arg_64_1.time_ < var_67_10 + var_67_20 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_10) / var_67_20

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_10 + var_67_20 and arg_64_1.time_ < var_67_10 + var_67_20 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play323162015 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 323162015
		arg_68_1.duration_ = 7

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play323162016(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				local var_71_1 = manager.ui.mainCamera.transform.localPosition
				local var_71_2 = Vector3.New(0, 0, 10) + Vector3.New(var_71_1.x, var_71_1.y, 0)
				local var_71_3 = arg_68_1.bgs_.J22f

				var_71_3.transform.localPosition = var_71_2
				var_71_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_71_4 = var_71_3:GetComponent("SpriteRenderer")

				if var_71_4 and var_71_4.sprite then
					local var_71_5 = (var_71_3.transform.localPosition - var_71_1).z
					local var_71_6 = manager.ui.mainCameraCom_
					local var_71_7 = 2 * var_71_5 * Mathf.Tan(var_71_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_71_8 = var_71_7 * var_71_6.aspect
					local var_71_9 = var_71_4.sprite.bounds.size.x
					local var_71_10 = var_71_4.sprite.bounds.size.y
					local var_71_11 = var_71_8 / var_71_9
					local var_71_12 = var_71_7 / var_71_10
					local var_71_13 = var_71_12 < var_71_11 and var_71_11 or var_71_12

					var_71_3.transform.localScale = Vector3.New(var_71_13, var_71_13, 0)
				end

				for iter_71_0, iter_71_1 in pairs(arg_68_1.bgs_) do
					if iter_71_0 ~= "J22f" then
						iter_71_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_71_14 = 0

			if var_71_14 < arg_68_1.time_ and arg_68_1.time_ <= var_71_14 + arg_71_0 then
				arg_68_1.allBtn_.enabled = false
			end

			local var_71_15 = 0.3

			if arg_68_1.time_ >= var_71_14 + var_71_15 and arg_68_1.time_ < var_71_14 + var_71_15 + arg_71_0 then
				arg_68_1.allBtn_.enabled = true
			end

			local var_71_16 = 0

			if var_71_16 < arg_68_1.time_ and arg_68_1.time_ <= var_71_16 + arg_71_0 then
				arg_68_1.mask_.enabled = true
				arg_68_1.mask_.raycastTarget = true

				arg_68_1:SetGaussion(false)
			end

			local var_71_17 = 2.1

			if var_71_16 <= arg_68_1.time_ and arg_68_1.time_ < var_71_16 + var_71_17 then
				local var_71_18 = (arg_68_1.time_ - var_71_16) / var_71_17
				local var_71_19 = Color.New(0, 0, 0)

				var_71_19.a = Mathf.Lerp(1, 0, var_71_18)
				arg_68_1.mask_.color = var_71_19
			end

			if arg_68_1.time_ >= var_71_16 + var_71_17 and arg_68_1.time_ < var_71_16 + var_71_17 + arg_71_0 then
				local var_71_20 = Color.New(0, 0, 0)
				local var_71_21 = 0

				arg_68_1.mask_.enabled = false
				var_71_20.a = var_71_21
				arg_68_1.mask_.color = var_71_20
			end

			local var_71_22 = arg_68_1.actors_["1075ui_story"]
			local var_71_23 = 0

			if var_71_23 < arg_68_1.time_ and arg_68_1.time_ <= var_71_23 + arg_71_0 and not isNil(var_71_22) and arg_68_1.var_.characterEffect1075ui_story == nil then
				arg_68_1.var_.characterEffect1075ui_story = var_71_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_24 = 0.200000002980232

			if var_71_23 <= arg_68_1.time_ and arg_68_1.time_ < var_71_23 + var_71_24 and not isNil(var_71_22) then
				local var_71_25 = (arg_68_1.time_ - var_71_23) / var_71_24

				if arg_68_1.var_.characterEffect1075ui_story and not isNil(var_71_22) then
					local var_71_26 = Mathf.Lerp(0, 0.5, var_71_25)

					arg_68_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1075ui_story.fillRatio = var_71_26
				end
			end

			if arg_68_1.time_ >= var_71_23 + var_71_24 and arg_68_1.time_ < var_71_23 + var_71_24 + arg_71_0 and not isNil(var_71_22) and arg_68_1.var_.characterEffect1075ui_story then
				local var_71_27 = 0.5

				arg_68_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1075ui_story.fillRatio = var_71_27
			end

			local var_71_28 = manager.ui.mainCamera.transform
			local var_71_29 = 0

			if var_71_29 < arg_68_1.time_ and arg_68_1.time_ <= var_71_29 + arg_71_0 then
				local var_71_30 = arg_68_1.var_.effect334
				local var_71_31
				local var_71_32 = var_71_28

				if not var_71_30 then
					var_71_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapopen"), var_71_32)
					var_71_30.name = "334"
					arg_68_1.var_.effect334 = var_71_30
				else
					var_71_30.transform:SetParent(var_71_32)
				end

				var_71_30.transform.localPosition = Vector3.New(0, 0, 0)
				var_71_30.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_71_33 = 1.7777777777777777
				local var_71_34 = Screen.width / Screen.height
				local var_71_35 = var_71_34 / var_71_33
				local var_71_36 = Mathf.Max(var_71_33 / var_71_34, 1)

				var_71_30.transform.localScale = Vector3.New(var_71_30.transform.localScale.x * var_71_35, var_71_30.transform.localScale.y * var_71_36, var_71_30.transform.localScale.z)
			end

			local var_71_37 = 0
			local var_71_38 = 1

			if var_71_37 < arg_68_1.time_ and arg_68_1.time_ <= var_71_37 + arg_71_0 then
				local var_71_39 = "stop"
				local var_71_40 = "effect"

				arg_68_1:AudioAction(var_71_39, var_71_40, "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			local var_71_41 = 0.166666666666667
			local var_71_42 = 1

			if var_71_41 < arg_68_1.time_ and arg_68_1.time_ <= var_71_41 + arg_71_0 then
				local var_71_43 = "play"
				local var_71_44 = "effect"

				arg_68_1:AudioAction(var_71_43, var_71_44, "se_story_146", "se_story_146_wind", "")
			end

			if arg_68_1.frameCnt_ <= 1 then
				arg_68_1.dialog_:SetActive(false)
			end

			local var_71_45 = 2
			local var_71_46 = 1.525

			if var_71_45 < arg_68_1.time_ and arg_68_1.time_ <= var_71_45 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0

				arg_68_1.dialog_:SetActive(true)

				arg_68_1.dialogCg_.alpha = 0

				local var_71_47 = LeanTween.value(arg_68_1.dialog_, 0, 1, 0.3)

				var_71_47:setOnUpdate(LuaHelper.FloatAction(function(arg_72_0)
					arg_68_1.dialogCg_.alpha = arg_72_0
				end))
				var_71_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_68_1.dialog_)
					var_71_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_68_1.duration_ = arg_68_1.duration_ + 0.3

				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_48 = arg_68_1:GetWordFromCfg(323162015)
				local var_71_49 = arg_68_1:FormatText(var_71_48.content)

				arg_68_1.text_.text = var_71_49

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_50 = 61
				local var_71_51 = utf8.len(var_71_49)
				local var_71_52 = var_71_50 <= 0 and var_71_46 or var_71_46 * (var_71_51 / var_71_50)

				if var_71_52 > 0 and var_71_46 < var_71_52 then
					arg_68_1.talkMaxDuration = var_71_52
					var_71_45 = var_71_45 + 0.3

					if var_71_52 + var_71_45 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_52 + var_71_45
					end
				end

				arg_68_1.text_.text = var_71_49
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_53 = var_71_45 + 0.3
			local var_71_54 = math.max(var_71_46, arg_68_1.talkMaxDuration)

			if var_71_53 <= arg_68_1.time_ and arg_68_1.time_ < var_71_53 + var_71_54 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_53) / var_71_54

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_53 + var_71_54 and arg_68_1.time_ < var_71_53 + var_71_54 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play323162016 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 323162016
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play323162017(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0
			local var_77_1 = 1.025

			if var_77_0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_2 = arg_74_1:GetWordFromCfg(323162016)
				local var_77_3 = arg_74_1:FormatText(var_77_2.content)

				arg_74_1.text_.text = var_77_3

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 41
				local var_77_5 = utf8.len(var_77_3)
				local var_77_6 = var_77_4 <= 0 and var_77_1 or var_77_1 * (var_77_5 / var_77_4)

				if var_77_6 > 0 and var_77_1 < var_77_6 then
					arg_74_1.talkMaxDuration = var_77_6

					if var_77_6 + var_77_0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_6 + var_77_0
					end
				end

				arg_74_1.text_.text = var_77_3
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_1, arg_74_1.talkMaxDuration)

			if var_77_0 <= arg_74_1.time_ and arg_74_1.time_ < var_77_0 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_0) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_0 + var_77_7 and arg_74_1.time_ < var_77_0 + var_77_7 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play323162017 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 323162017
		arg_78_1.duration_ = 3.97

		local var_78_0 = {
			zh = 3.1,
			ja = 3.966
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play323162018(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 0.3

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				local var_81_2 = "play"
				local var_81_3 = "music"

				arg_78_1:AudioAction(var_81_2, var_81_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_81_4 = ""
				local var_81_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_81_5 ~= "" then
					if arg_78_1.bgmTxt_.text ~= var_81_5 and arg_78_1.bgmTxt_.text ~= "" then
						if arg_78_1.bgmTxt2_.text ~= "" then
							arg_78_1.bgmTxt_.text = arg_78_1.bgmTxt2_.text
						end

						arg_78_1.bgmTxt2_.text = var_81_5

						arg_78_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_78_1.bgmTxt_.text = var_81_5
						arg_78_1.bgmTxt2_.text = var_81_5
					end

					if arg_78_1.bgmTimer then
						arg_78_1.bgmTimer:Stop()

						arg_78_1.bgmTimer = nil
					end

					if arg_78_1.settingData.show_music_name == 1 then
						arg_78_1.musicController:SetSelectedState("show")
						arg_78_1.musicAnimator_:Play("open", 0, 0)

						if arg_78_1.settingData.music_time ~= 0 then
							arg_78_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_78_1.settingData.music_time), function()
								if arg_78_1 == nil or isNil(arg_78_1.bgmTxt_) then
									return
								end

								arg_78_1.musicController:SetSelectedState("hide")
								arg_78_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_81_6 = 0.433333333333333
			local var_81_7 = 1

			if var_81_6 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 then
				local var_81_8 = "play"
				local var_81_9 = "music"

				arg_78_1:AudioAction(var_81_8, var_81_9, "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown.awb")

				local var_81_10 = ""
				local var_81_11 = manager.audio:GetAudioName("bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown")

				if var_81_11 ~= "" then
					if arg_78_1.bgmTxt_.text ~= var_81_11 and arg_78_1.bgmTxt_.text ~= "" then
						if arg_78_1.bgmTxt2_.text ~= "" then
							arg_78_1.bgmTxt_.text = arg_78_1.bgmTxt2_.text
						end

						arg_78_1.bgmTxt2_.text = var_81_11

						arg_78_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_78_1.bgmTxt_.text = var_81_11
						arg_78_1.bgmTxt2_.text = var_81_11
					end

					if arg_78_1.bgmTimer then
						arg_78_1.bgmTimer:Stop()

						arg_78_1.bgmTimer = nil
					end

					if arg_78_1.settingData.show_music_name == 1 then
						arg_78_1.musicController:SetSelectedState("show")
						arg_78_1.musicAnimator_:Play("open", 0, 0)

						if arg_78_1.settingData.music_time ~= 0 then
							arg_78_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_78_1.settingData.music_time), function()
								if arg_78_1 == nil or isNil(arg_78_1.bgmTxt_) then
									return
								end

								arg_78_1.musicController:SetSelectedState("hide")
								arg_78_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_81_12 = 0
			local var_81_13 = 0.275

			if var_81_12 < arg_78_1.time_ and arg_78_1.time_ <= var_81_12 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_14 = arg_78_1:FormatText(StoryNameCfg[1451].name)

				arg_78_1.leftNameTxt_.text = var_81_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10171")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_15 = arg_78_1:GetWordFromCfg(323162017)
				local var_81_16 = arg_78_1:FormatText(var_81_15.content)

				arg_78_1.text_.text = var_81_16

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_17 = 11
				local var_81_18 = utf8.len(var_81_16)
				local var_81_19 = var_81_17 <= 0 and var_81_13 or var_81_13 * (var_81_18 / var_81_17)

				if var_81_19 > 0 and var_81_13 < var_81_19 then
					arg_78_1.talkMaxDuration = var_81_19

					if var_81_19 + var_81_12 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_19 + var_81_12
					end
				end

				arg_78_1.text_.text = var_81_16
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162017", "story_v_out_323162.awb") ~= 0 then
					local var_81_20 = manager.audio:GetVoiceLength("story_v_out_323162", "323162017", "story_v_out_323162.awb") / 1000

					if var_81_20 + var_81_12 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_20 + var_81_12
					end

					if var_81_15.prefab_name ~= "" and arg_78_1.actors_[var_81_15.prefab_name] ~= nil then
						local var_81_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_15.prefab_name].transform, "story_v_out_323162", "323162017", "story_v_out_323162.awb")

						arg_78_1:RecordAudio("323162017", var_81_21)
						arg_78_1:RecordAudio("323162017", var_81_21)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_323162", "323162017", "story_v_out_323162.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_323162", "323162017", "story_v_out_323162.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_22 = math.max(var_81_13, arg_78_1.talkMaxDuration)

			if var_81_12 <= arg_78_1.time_ and arg_78_1.time_ < var_81_12 + var_81_22 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_12) / var_81_22

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_12 + var_81_22 and arg_78_1.time_ < var_81_12 + var_81_22 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play323162018 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 323162018
		arg_84_1.duration_ = 2.73

		local var_84_0 = {
			zh = 1.999999999999,
			ja = 2.733
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play323162019(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1075ui_story"].transform
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.var_.moveOldPos1075ui_story = var_87_0.localPosition
			end

			local var_87_2 = 0.001

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2
				local var_87_4 = Vector3.New(0, -1.055, -6.16)

				var_87_0.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1075ui_story, var_87_4, var_87_3)

				local var_87_5 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_5.x, var_87_5.y, var_87_5.z)

				local var_87_6 = var_87_0.localEulerAngles

				var_87_6.z = 0
				var_87_6.x = 0
				var_87_0.localEulerAngles = var_87_6
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 then
				var_87_0.localPosition = Vector3.New(0, -1.055, -6.16)

				local var_87_7 = manager.ui.mainCamera.transform.position - var_87_0.position

				var_87_0.forward = Vector3.New(var_87_7.x, var_87_7.y, var_87_7.z)

				local var_87_8 = var_87_0.localEulerAngles

				var_87_8.z = 0
				var_87_8.x = 0
				var_87_0.localEulerAngles = var_87_8
			end

			local var_87_9 = arg_84_1.actors_["1075ui_story"]
			local var_87_10 = 0

			if var_87_10 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 and not isNil(var_87_9) and arg_84_1.var_.characterEffect1075ui_story == nil then
				arg_84_1.var_.characterEffect1075ui_story = var_87_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_11 = 0.200000002980232

			if var_87_10 <= arg_84_1.time_ and arg_84_1.time_ < var_87_10 + var_87_11 and not isNil(var_87_9) then
				local var_87_12 = (arg_84_1.time_ - var_87_10) / var_87_11

				if arg_84_1.var_.characterEffect1075ui_story and not isNil(var_87_9) then
					arg_84_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_10 + var_87_11 and arg_84_1.time_ < var_87_10 + var_87_11 + arg_87_0 and not isNil(var_87_9) and arg_84_1.var_.characterEffect1075ui_story then
				arg_84_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_87_13 = 0

			if var_87_13 < arg_84_1.time_ and arg_84_1.time_ <= var_87_13 + arg_87_0 then
				arg_84_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_1")
			end

			local var_87_14 = 0

			if var_87_14 < arg_84_1.time_ and arg_84_1.time_ <= var_87_14 + arg_87_0 then
				arg_84_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_87_15 = 0
			local var_87_16 = 0.225

			if var_87_15 < arg_84_1.time_ and arg_84_1.time_ <= var_87_15 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_17 = arg_84_1:FormatText(StoryNameCfg[381].name)

				arg_84_1.leftNameTxt_.text = var_87_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_18 = arg_84_1:GetWordFromCfg(323162018)
				local var_87_19 = arg_84_1:FormatText(var_87_18.content)

				arg_84_1.text_.text = var_87_19

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_20 = 9
				local var_87_21 = utf8.len(var_87_19)
				local var_87_22 = var_87_20 <= 0 and var_87_16 or var_87_16 * (var_87_21 / var_87_20)

				if var_87_22 > 0 and var_87_16 < var_87_22 then
					arg_84_1.talkMaxDuration = var_87_22

					if var_87_22 + var_87_15 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_22 + var_87_15
					end
				end

				arg_84_1.text_.text = var_87_19
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162018", "story_v_out_323162.awb") ~= 0 then
					local var_87_23 = manager.audio:GetVoiceLength("story_v_out_323162", "323162018", "story_v_out_323162.awb") / 1000

					if var_87_23 + var_87_15 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_23 + var_87_15
					end

					if var_87_18.prefab_name ~= "" and arg_84_1.actors_[var_87_18.prefab_name] ~= nil then
						local var_87_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_18.prefab_name].transform, "story_v_out_323162", "323162018", "story_v_out_323162.awb")

						arg_84_1:RecordAudio("323162018", var_87_24)
						arg_84_1:RecordAudio("323162018", var_87_24)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_323162", "323162018", "story_v_out_323162.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_323162", "323162018", "story_v_out_323162.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_25 = math.max(var_87_16, arg_84_1.talkMaxDuration)

			if var_87_15 <= arg_84_1.time_ and arg_84_1.time_ < var_87_15 + var_87_25 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_15) / var_87_25

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_15 + var_87_25 and arg_84_1.time_ < var_87_15 + var_87_25 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play323162019 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 323162019
		arg_88_1.duration_ = 10.8

		local var_88_0 = {
			zh = 6.033,
			ja = 10.8
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
				arg_88_0:Play323162020(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = "10171ui_story"

			if arg_88_1.actors_[var_91_0] == nil then
				local var_91_1 = Asset.Load("Char/" .. "10171ui_story")

				if not isNil(var_91_1) then
					local var_91_2 = Object.Instantiate(Asset.Load("Char/" .. "10171ui_story"), arg_88_1.stage_.transform)

					var_91_2.name = var_91_0
					var_91_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_88_1.actors_[var_91_0] = var_91_2

					local var_91_3 = var_91_2:GetComponentInChildren(typeof(CharacterEffect))

					var_91_3.enabled = true

					local var_91_4 = GameObjectTools.GetOrAddComponent(var_91_2, typeof(DynamicBoneHelper))

					if var_91_4 then
						var_91_4:EnableDynamicBone(false)
					end

					arg_88_1:ShowWeapon(var_91_3.transform, false)

					arg_88_1.var_[var_91_0 .. "Animator"] = var_91_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_88_1.var_[var_91_0 .. "Animator"].applyRootMotion = true
					arg_88_1.var_[var_91_0 .. "LipSync"] = var_91_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_91_5 = arg_88_1.actors_["10171ui_story"].transform
			local var_91_6 = 0

			if var_91_6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.var_.moveOldPos10171ui_story = var_91_5.localPosition

				local var_91_7 = GameObjectTools.GetOrAddComponent(var_91_5.gameObject, typeof(DynamicBoneHelper))

				if var_91_7 then
					var_91_7:EnableDynamicBone(false)
				end
			end

			local var_91_8 = 0.001

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_8 then
				local var_91_9 = (arg_88_1.time_ - var_91_6) / var_91_8
				local var_91_10 = Vector3.New(-0.7, -0.95, -6.05)

				var_91_5.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos10171ui_story, var_91_10, var_91_9)

				local var_91_11 = manager.ui.mainCamera.transform.position - var_91_5.position

				var_91_5.forward = Vector3.New(var_91_11.x, var_91_11.y, var_91_11.z)

				local var_91_12 = var_91_5.localEulerAngles

				var_91_12.z = 0
				var_91_12.x = 0
				var_91_5.localEulerAngles = var_91_12
			end

			if arg_88_1.time_ >= var_91_6 + var_91_8 and arg_88_1.time_ < var_91_6 + var_91_8 + arg_91_0 then
				var_91_5.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_91_13 = manager.ui.mainCamera.transform.position - var_91_5.position

				var_91_5.forward = Vector3.New(var_91_13.x, var_91_13.y, var_91_13.z)

				local var_91_14 = var_91_5.localEulerAngles

				var_91_14.z = 0
				var_91_14.x = 0
				var_91_5.localEulerAngles = var_91_14

				local var_91_15 = GameObjectTools.GetOrAddComponent(var_91_5.gameObject, typeof(DynamicBoneHelper))

				if var_91_15 then
					var_91_15:EnableDynamicBone(true)
				end
			end

			local var_91_16 = arg_88_1.actors_["1075ui_story"].transform
			local var_91_17 = 0

			if var_91_17 < arg_88_1.time_ and arg_88_1.time_ <= var_91_17 + arg_91_0 then
				arg_88_1.var_.moveOldPos1075ui_story = var_91_16.localPosition
			end

			local var_91_18 = 0.001

			if var_91_17 <= arg_88_1.time_ and arg_88_1.time_ < var_91_17 + var_91_18 then
				local var_91_19 = (arg_88_1.time_ - var_91_17) / var_91_18
				local var_91_20 = Vector3.New(0.7, -1.055, -6.16)

				var_91_16.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1075ui_story, var_91_20, var_91_19)

				local var_91_21 = manager.ui.mainCamera.transform.position - var_91_16.position

				var_91_16.forward = Vector3.New(var_91_21.x, var_91_21.y, var_91_21.z)

				local var_91_22 = var_91_16.localEulerAngles

				var_91_22.z = 0
				var_91_22.x = 0
				var_91_16.localEulerAngles = var_91_22
			end

			if arg_88_1.time_ >= var_91_17 + var_91_18 and arg_88_1.time_ < var_91_17 + var_91_18 + arg_91_0 then
				var_91_16.localPosition = Vector3.New(0.7, -1.055, -6.16)

				local var_91_23 = manager.ui.mainCamera.transform.position - var_91_16.position

				var_91_16.forward = Vector3.New(var_91_23.x, var_91_23.y, var_91_23.z)

				local var_91_24 = var_91_16.localEulerAngles

				var_91_24.z = 0
				var_91_24.x = 0
				var_91_16.localEulerAngles = var_91_24
			end

			local var_91_25 = arg_88_1.actors_["10171ui_story"]
			local var_91_26 = 0

			if var_91_26 < arg_88_1.time_ and arg_88_1.time_ <= var_91_26 + arg_91_0 and not isNil(var_91_25) and arg_88_1.var_.characterEffect10171ui_story == nil then
				arg_88_1.var_.characterEffect10171ui_story = var_91_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_27 = 0.200000002980232

			if var_91_26 <= arg_88_1.time_ and arg_88_1.time_ < var_91_26 + var_91_27 and not isNil(var_91_25) then
				local var_91_28 = (arg_88_1.time_ - var_91_26) / var_91_27

				if arg_88_1.var_.characterEffect10171ui_story and not isNil(var_91_25) then
					arg_88_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_26 + var_91_27 and arg_88_1.time_ < var_91_26 + var_91_27 + arg_91_0 and not isNil(var_91_25) and arg_88_1.var_.characterEffect10171ui_story then
				arg_88_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_91_29 = arg_88_1.actors_["1075ui_story"]
			local var_91_30 = 0

			if var_91_30 < arg_88_1.time_ and arg_88_1.time_ <= var_91_30 + arg_91_0 and not isNil(var_91_29) and arg_88_1.var_.characterEffect1075ui_story == nil then
				arg_88_1.var_.characterEffect1075ui_story = var_91_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_31 = 0.200000002980232

			if var_91_30 <= arg_88_1.time_ and arg_88_1.time_ < var_91_30 + var_91_31 and not isNil(var_91_29) then
				local var_91_32 = (arg_88_1.time_ - var_91_30) / var_91_31

				if arg_88_1.var_.characterEffect1075ui_story and not isNil(var_91_29) then
					local var_91_33 = Mathf.Lerp(0, 0.5, var_91_32)

					arg_88_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1075ui_story.fillRatio = var_91_33
				end
			end

			if arg_88_1.time_ >= var_91_30 + var_91_31 and arg_88_1.time_ < var_91_30 + var_91_31 + arg_91_0 and not isNil(var_91_29) and arg_88_1.var_.characterEffect1075ui_story then
				local var_91_34 = 0.5

				arg_88_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1075ui_story.fillRatio = var_91_34
			end

			local var_91_35 = 0

			if var_91_35 < arg_88_1.time_ and arg_88_1.time_ <= var_91_35 + arg_91_0 then
				arg_88_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			local var_91_36 = 0

			if var_91_36 < arg_88_1.time_ and arg_88_1.time_ <= var_91_36 + arg_91_0 then
				arg_88_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_91_37 = 0
			local var_91_38 = 0.475

			if var_91_37 < arg_88_1.time_ and arg_88_1.time_ <= var_91_37 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_39 = arg_88_1:FormatText(StoryNameCfg[1451].name)

				arg_88_1.leftNameTxt_.text = var_91_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_40 = arg_88_1:GetWordFromCfg(323162019)
				local var_91_41 = arg_88_1:FormatText(var_91_40.content)

				arg_88_1.text_.text = var_91_41

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_42 = 19
				local var_91_43 = utf8.len(var_91_41)
				local var_91_44 = var_91_42 <= 0 and var_91_38 or var_91_38 * (var_91_43 / var_91_42)

				if var_91_44 > 0 and var_91_38 < var_91_44 then
					arg_88_1.talkMaxDuration = var_91_44

					if var_91_44 + var_91_37 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_44 + var_91_37
					end
				end

				arg_88_1.text_.text = var_91_41
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162019", "story_v_out_323162.awb") ~= 0 then
					local var_91_45 = manager.audio:GetVoiceLength("story_v_out_323162", "323162019", "story_v_out_323162.awb") / 1000

					if var_91_45 + var_91_37 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_45 + var_91_37
					end

					if var_91_40.prefab_name ~= "" and arg_88_1.actors_[var_91_40.prefab_name] ~= nil then
						local var_91_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_40.prefab_name].transform, "story_v_out_323162", "323162019", "story_v_out_323162.awb")

						arg_88_1:RecordAudio("323162019", var_91_46)
						arg_88_1:RecordAudio("323162019", var_91_46)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_323162", "323162019", "story_v_out_323162.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_323162", "323162019", "story_v_out_323162.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_47 = math.max(var_91_38, arg_88_1.talkMaxDuration)

			if var_91_37 <= arg_88_1.time_ and arg_88_1.time_ < var_91_37 + var_91_47 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_37) / var_91_47

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_37 + var_91_47 and arg_88_1.time_ < var_91_37 + var_91_47 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play323162020 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 323162020
		arg_92_1.duration_ = 5.5

		local var_92_0 = {
			zh = 3.3,
			ja = 5.5
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
				arg_92_0:Play323162021(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["1075ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1075ui_story == nil then
				arg_92_1.var_.characterEffect1075ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.200000002980232

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect1075ui_story and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect1075ui_story then
				arg_92_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_95_4 = arg_92_1.actors_["10171ui_story"]
			local var_95_5 = 0

			if var_95_5 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect10171ui_story == nil then
				arg_92_1.var_.characterEffect10171ui_story = var_95_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_6 = 0.200000002980232

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_6 and not isNil(var_95_4) then
				local var_95_7 = (arg_92_1.time_ - var_95_5) / var_95_6

				if arg_92_1.var_.characterEffect10171ui_story and not isNil(var_95_4) then
					local var_95_8 = Mathf.Lerp(0, 0.5, var_95_7)

					arg_92_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_92_1.var_.characterEffect10171ui_story.fillRatio = var_95_8
				end
			end

			if arg_92_1.time_ >= var_95_5 + var_95_6 and arg_92_1.time_ < var_95_5 + var_95_6 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect10171ui_story then
				local var_95_9 = 0.5

				arg_92_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_92_1.var_.characterEffect10171ui_story.fillRatio = var_95_9
			end

			local var_95_10 = 0

			if var_95_10 < arg_92_1.time_ and arg_92_1.time_ <= var_95_10 + arg_95_0 then
				arg_92_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action4_2")
			end

			local var_95_11 = 0
			local var_95_12 = 0.35

			if var_95_11 < arg_92_1.time_ and arg_92_1.time_ <= var_95_11 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_13 = arg_92_1:FormatText(StoryNameCfg[381].name)

				arg_92_1.leftNameTxt_.text = var_95_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_14 = arg_92_1:GetWordFromCfg(323162020)
				local var_95_15 = arg_92_1:FormatText(var_95_14.content)

				arg_92_1.text_.text = var_95_15

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_16 = 14
				local var_95_17 = utf8.len(var_95_15)
				local var_95_18 = var_95_16 <= 0 and var_95_12 or var_95_12 * (var_95_17 / var_95_16)

				if var_95_18 > 0 and var_95_12 < var_95_18 then
					arg_92_1.talkMaxDuration = var_95_18

					if var_95_18 + var_95_11 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_18 + var_95_11
					end
				end

				arg_92_1.text_.text = var_95_15
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162020", "story_v_out_323162.awb") ~= 0 then
					local var_95_19 = manager.audio:GetVoiceLength("story_v_out_323162", "323162020", "story_v_out_323162.awb") / 1000

					if var_95_19 + var_95_11 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_19 + var_95_11
					end

					if var_95_14.prefab_name ~= "" and arg_92_1.actors_[var_95_14.prefab_name] ~= nil then
						local var_95_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_14.prefab_name].transform, "story_v_out_323162", "323162020", "story_v_out_323162.awb")

						arg_92_1:RecordAudio("323162020", var_95_20)
						arg_92_1:RecordAudio("323162020", var_95_20)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_323162", "323162020", "story_v_out_323162.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_323162", "323162020", "story_v_out_323162.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_21 = math.max(var_95_12, arg_92_1.talkMaxDuration)

			if var_95_11 <= arg_92_1.time_ and arg_92_1.time_ < var_95_11 + var_95_21 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_11) / var_95_21

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_11 + var_95_21 and arg_92_1.time_ < var_95_11 + var_95_21 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play323162021 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 323162021
		arg_96_1.duration_ = 3.37

		local var_96_0 = {
			zh = 2.533,
			ja = 3.366
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
				arg_96_0:Play323162022(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["10171ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect10171ui_story == nil then
				arg_96_1.var_.characterEffect10171ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect10171ui_story and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect10171ui_story then
				arg_96_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_99_4 = arg_96_1.actors_["1075ui_story"]
			local var_99_5 = 0

			if var_99_5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect1075ui_story == nil then
				arg_96_1.var_.characterEffect1075ui_story = var_99_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_6 = 0.200000002980232

			if var_99_5 <= arg_96_1.time_ and arg_96_1.time_ < var_99_5 + var_99_6 and not isNil(var_99_4) then
				local var_99_7 = (arg_96_1.time_ - var_99_5) / var_99_6

				if arg_96_1.var_.characterEffect1075ui_story and not isNil(var_99_4) then
					local var_99_8 = Mathf.Lerp(0, 0.5, var_99_7)

					arg_96_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1075ui_story.fillRatio = var_99_8
				end
			end

			if arg_96_1.time_ >= var_99_5 + var_99_6 and arg_96_1.time_ < var_99_5 + var_99_6 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect1075ui_story then
				local var_99_9 = 0.5

				arg_96_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1075ui_story.fillRatio = var_99_9
			end

			local var_99_10 = 0

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 then
				arg_96_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_1")
			end

			local var_99_11 = 0

			if var_99_11 < arg_96_1.time_ and arg_96_1.time_ <= var_99_11 + arg_99_0 then
				arg_96_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_99_12 = 0
			local var_99_13 = 0.25

			if var_99_12 < arg_96_1.time_ and arg_96_1.time_ <= var_99_12 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_14 = arg_96_1:FormatText(StoryNameCfg[1451].name)

				arg_96_1.leftNameTxt_.text = var_99_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_15 = arg_96_1:GetWordFromCfg(323162021)
				local var_99_16 = arg_96_1:FormatText(var_99_15.content)

				arg_96_1.text_.text = var_99_16

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_17 = 10
				local var_99_18 = utf8.len(var_99_16)
				local var_99_19 = var_99_17 <= 0 and var_99_13 or var_99_13 * (var_99_18 / var_99_17)

				if var_99_19 > 0 and var_99_13 < var_99_19 then
					arg_96_1.talkMaxDuration = var_99_19

					if var_99_19 + var_99_12 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_19 + var_99_12
					end
				end

				arg_96_1.text_.text = var_99_16
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162021", "story_v_out_323162.awb") ~= 0 then
					local var_99_20 = manager.audio:GetVoiceLength("story_v_out_323162", "323162021", "story_v_out_323162.awb") / 1000

					if var_99_20 + var_99_12 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_20 + var_99_12
					end

					if var_99_15.prefab_name ~= "" and arg_96_1.actors_[var_99_15.prefab_name] ~= nil then
						local var_99_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_15.prefab_name].transform, "story_v_out_323162", "323162021", "story_v_out_323162.awb")

						arg_96_1:RecordAudio("323162021", var_99_21)
						arg_96_1:RecordAudio("323162021", var_99_21)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_323162", "323162021", "story_v_out_323162.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_323162", "323162021", "story_v_out_323162.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_22 = math.max(var_99_13, arg_96_1.talkMaxDuration)

			if var_99_12 <= arg_96_1.time_ and arg_96_1.time_ < var_99_12 + var_99_22 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_12) / var_99_22

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_12 + var_99_22 and arg_96_1.time_ < var_99_12 + var_99_22 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play323162022 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 323162022
		arg_100_1.duration_ = 8.2

		local var_100_0 = {
			zh = 5.4,
			ja = 8.2
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
				arg_100_0:Play323162023(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1075ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1075ui_story == nil then
				arg_100_1.var_.characterEffect1075ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1075ui_story and not isNil(var_103_0) then
					arg_100_1.var_.characterEffect1075ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1075ui_story then
				arg_100_1.var_.characterEffect1075ui_story.fillFlat = false
			end

			local var_103_4 = arg_100_1.actors_["10171ui_story"]
			local var_103_5 = 0

			if var_103_5 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect10171ui_story == nil then
				arg_100_1.var_.characterEffect10171ui_story = var_103_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_6 = 0.200000002980232

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_6 and not isNil(var_103_4) then
				local var_103_7 = (arg_100_1.time_ - var_103_5) / var_103_6

				if arg_100_1.var_.characterEffect10171ui_story and not isNil(var_103_4) then
					local var_103_8 = Mathf.Lerp(0, 0.5, var_103_7)

					arg_100_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_100_1.var_.characterEffect10171ui_story.fillRatio = var_103_8
				end
			end

			if arg_100_1.time_ >= var_103_5 + var_103_6 and arg_100_1.time_ < var_103_5 + var_103_6 + arg_103_0 and not isNil(var_103_4) and arg_100_1.var_.characterEffect10171ui_story then
				local var_103_9 = 0.5

				arg_100_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_100_1.var_.characterEffect10171ui_story.fillRatio = var_103_9
			end

			local var_103_10 = 0
			local var_103_11 = 0.6

			if var_103_10 < arg_100_1.time_ and arg_100_1.time_ <= var_103_10 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_12 = arg_100_1:FormatText(StoryNameCfg[381].name)

				arg_100_1.leftNameTxt_.text = var_103_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_13 = arg_100_1:GetWordFromCfg(323162022)
				local var_103_14 = arg_100_1:FormatText(var_103_13.content)

				arg_100_1.text_.text = var_103_14

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_15 = 24
				local var_103_16 = utf8.len(var_103_14)
				local var_103_17 = var_103_15 <= 0 and var_103_11 or var_103_11 * (var_103_16 / var_103_15)

				if var_103_17 > 0 and var_103_11 < var_103_17 then
					arg_100_1.talkMaxDuration = var_103_17

					if var_103_17 + var_103_10 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_17 + var_103_10
					end
				end

				arg_100_1.text_.text = var_103_14
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162022", "story_v_out_323162.awb") ~= 0 then
					local var_103_18 = manager.audio:GetVoiceLength("story_v_out_323162", "323162022", "story_v_out_323162.awb") / 1000

					if var_103_18 + var_103_10 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_18 + var_103_10
					end

					if var_103_13.prefab_name ~= "" and arg_100_1.actors_[var_103_13.prefab_name] ~= nil then
						local var_103_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_13.prefab_name].transform, "story_v_out_323162", "323162022", "story_v_out_323162.awb")

						arg_100_1:RecordAudio("323162022", var_103_19)
						arg_100_1:RecordAudio("323162022", var_103_19)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_323162", "323162022", "story_v_out_323162.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_323162", "323162022", "story_v_out_323162.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_20 = math.max(var_103_11, arg_100_1.talkMaxDuration)

			if var_103_10 <= arg_100_1.time_ and arg_100_1.time_ < var_103_10 + var_103_20 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_10) / var_103_20

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_10 + var_103_20 and arg_100_1.time_ < var_103_10 + var_103_20 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play323162023 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 323162023
		arg_104_1.duration_ = 11.7

		local var_104_0 = {
			zh = 9.766,
			ja = 11.7
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play323162024(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/story1075/story1075action/1075action3_1")
			end

			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1:PlayTimeline("1075ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_107_2 = 0
			local var_107_3 = 1.1

			if var_107_2 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_4 = arg_104_1:FormatText(StoryNameCfg[381].name)

				arg_104_1.leftNameTxt_.text = var_107_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_5 = arg_104_1:GetWordFromCfg(323162023)
				local var_107_6 = arg_104_1:FormatText(var_107_5.content)

				arg_104_1.text_.text = var_107_6

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_7 = 44
				local var_107_8 = utf8.len(var_107_6)
				local var_107_9 = var_107_7 <= 0 and var_107_3 or var_107_3 * (var_107_8 / var_107_7)

				if var_107_9 > 0 and var_107_3 < var_107_9 then
					arg_104_1.talkMaxDuration = var_107_9

					if var_107_9 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_9 + var_107_2
					end
				end

				arg_104_1.text_.text = var_107_6
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162023", "story_v_out_323162.awb") ~= 0 then
					local var_107_10 = manager.audio:GetVoiceLength("story_v_out_323162", "323162023", "story_v_out_323162.awb") / 1000

					if var_107_10 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_10 + var_107_2
					end

					if var_107_5.prefab_name ~= "" and arg_104_1.actors_[var_107_5.prefab_name] ~= nil then
						local var_107_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_5.prefab_name].transform, "story_v_out_323162", "323162023", "story_v_out_323162.awb")

						arg_104_1:RecordAudio("323162023", var_107_11)
						arg_104_1:RecordAudio("323162023", var_107_11)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_323162", "323162023", "story_v_out_323162.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_323162", "323162023", "story_v_out_323162.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_12 = math.max(var_107_3, arg_104_1.talkMaxDuration)

			if var_107_2 <= arg_104_1.time_ and arg_104_1.time_ < var_107_2 + var_107_12 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_2) / var_107_12

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_2 + var_107_12 and arg_104_1.time_ < var_107_2 + var_107_12 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play323162024 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 323162024
		arg_108_1.duration_ = 4.8

		local var_108_0 = {
			zh = 2.8,
			ja = 4.8
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
				arg_108_0:Play323162025(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["10171ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect10171ui_story == nil then
				arg_108_1.var_.characterEffect10171ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect10171ui_story and not isNil(var_111_0) then
					arg_108_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect10171ui_story then
				arg_108_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_111_4 = arg_108_1.actors_["1075ui_story"]
			local var_111_5 = 0

			if var_111_5 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect1075ui_story == nil then
				arg_108_1.var_.characterEffect1075ui_story = var_111_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_6 = 0.200000002980232

			if var_111_5 <= arg_108_1.time_ and arg_108_1.time_ < var_111_5 + var_111_6 and not isNil(var_111_4) then
				local var_111_7 = (arg_108_1.time_ - var_111_5) / var_111_6

				if arg_108_1.var_.characterEffect1075ui_story and not isNil(var_111_4) then
					local var_111_8 = Mathf.Lerp(0, 0.5, var_111_7)

					arg_108_1.var_.characterEffect1075ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1075ui_story.fillRatio = var_111_8
				end
			end

			if arg_108_1.time_ >= var_111_5 + var_111_6 and arg_108_1.time_ < var_111_5 + var_111_6 + arg_111_0 and not isNil(var_111_4) and arg_108_1.var_.characterEffect1075ui_story then
				local var_111_9 = 0.5

				arg_108_1.var_.characterEffect1075ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1075ui_story.fillRatio = var_111_9
			end

			local var_111_10 = 0

			if var_111_10 < arg_108_1.time_ and arg_108_1.time_ <= var_111_10 + arg_111_0 then
				arg_108_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_2")
			end

			local var_111_11 = 0

			if var_111_11 < arg_108_1.time_ and arg_108_1.time_ <= var_111_11 + arg_111_0 then
				arg_108_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_111_12 = 0
			local var_111_13 = 0.25

			if var_111_12 < arg_108_1.time_ and arg_108_1.time_ <= var_111_12 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_14 = arg_108_1:FormatText(StoryNameCfg[1451].name)

				arg_108_1.leftNameTxt_.text = var_111_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_15 = arg_108_1:GetWordFromCfg(323162024)
				local var_111_16 = arg_108_1:FormatText(var_111_15.content)

				arg_108_1.text_.text = var_111_16

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_17 = 10
				local var_111_18 = utf8.len(var_111_16)
				local var_111_19 = var_111_17 <= 0 and var_111_13 or var_111_13 * (var_111_18 / var_111_17)

				if var_111_19 > 0 and var_111_13 < var_111_19 then
					arg_108_1.talkMaxDuration = var_111_19

					if var_111_19 + var_111_12 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_19 + var_111_12
					end
				end

				arg_108_1.text_.text = var_111_16
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162024", "story_v_out_323162.awb") ~= 0 then
					local var_111_20 = manager.audio:GetVoiceLength("story_v_out_323162", "323162024", "story_v_out_323162.awb") / 1000

					if var_111_20 + var_111_12 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_20 + var_111_12
					end

					if var_111_15.prefab_name ~= "" and arg_108_1.actors_[var_111_15.prefab_name] ~= nil then
						local var_111_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_15.prefab_name].transform, "story_v_out_323162", "323162024", "story_v_out_323162.awb")

						arg_108_1:RecordAudio("323162024", var_111_21)
						arg_108_1:RecordAudio("323162024", var_111_21)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_323162", "323162024", "story_v_out_323162.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_323162", "323162024", "story_v_out_323162.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_22 = math.max(var_111_13, arg_108_1.talkMaxDuration)

			if var_111_12 <= arg_108_1.time_ and arg_108_1.time_ < var_111_12 + var_111_22 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_12) / var_111_22

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_12 + var_111_22 and arg_108_1.time_ < var_111_12 + var_111_22 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play323162025 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 323162025
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play323162026(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["10171ui_story"].transform
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.var_.moveOldPos10171ui_story = var_115_0.localPosition

				local var_115_2 = GameObjectTools.GetOrAddComponent(var_115_0.gameObject, typeof(DynamicBoneHelper))

				if var_115_2 then
					var_115_2:EnableDynamicBone(false)
				end
			end

			local var_115_3 = 0.001

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_3 then
				local var_115_4 = (arg_112_1.time_ - var_115_1) / var_115_3
				local var_115_5 = Vector3.New(0, 100, 0)

				var_115_0.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10171ui_story, var_115_5, var_115_4)

				local var_115_6 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_6.x, var_115_6.y, var_115_6.z)

				local var_115_7 = var_115_0.localEulerAngles

				var_115_7.z = 0
				var_115_7.x = 0
				var_115_0.localEulerAngles = var_115_7
			end

			if arg_112_1.time_ >= var_115_1 + var_115_3 and arg_112_1.time_ < var_115_1 + var_115_3 + arg_115_0 then
				var_115_0.localPosition = Vector3.New(0, 100, 0)

				local var_115_8 = manager.ui.mainCamera.transform.position - var_115_0.position

				var_115_0.forward = Vector3.New(var_115_8.x, var_115_8.y, var_115_8.z)

				local var_115_9 = var_115_0.localEulerAngles

				var_115_9.z = 0
				var_115_9.x = 0
				var_115_0.localEulerAngles = var_115_9

				local var_115_10 = GameObjectTools.GetOrAddComponent(var_115_0.gameObject, typeof(DynamicBoneHelper))

				if var_115_10 then
					var_115_10:EnableDynamicBone(true)
				end
			end

			local var_115_11 = arg_112_1.actors_["1075ui_story"].transform
			local var_115_12 = 0

			if var_115_12 < arg_112_1.time_ and arg_112_1.time_ <= var_115_12 + arg_115_0 then
				arg_112_1.var_.moveOldPos1075ui_story = var_115_11.localPosition
			end

			local var_115_13 = 0.001

			if var_115_12 <= arg_112_1.time_ and arg_112_1.time_ < var_115_12 + var_115_13 then
				local var_115_14 = (arg_112_1.time_ - var_115_12) / var_115_13
				local var_115_15 = Vector3.New(0, 100, 0)

				var_115_11.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1075ui_story, var_115_15, var_115_14)

				local var_115_16 = manager.ui.mainCamera.transform.position - var_115_11.position

				var_115_11.forward = Vector3.New(var_115_16.x, var_115_16.y, var_115_16.z)

				local var_115_17 = var_115_11.localEulerAngles

				var_115_17.z = 0
				var_115_17.x = 0
				var_115_11.localEulerAngles = var_115_17
			end

			if arg_112_1.time_ >= var_115_12 + var_115_13 and arg_112_1.time_ < var_115_12 + var_115_13 + arg_115_0 then
				var_115_11.localPosition = Vector3.New(0, 100, 0)

				local var_115_18 = manager.ui.mainCamera.transform.position - var_115_11.position

				var_115_11.forward = Vector3.New(var_115_18.x, var_115_18.y, var_115_18.z)

				local var_115_19 = var_115_11.localEulerAngles

				var_115_19.z = 0
				var_115_19.x = 0
				var_115_11.localEulerAngles = var_115_19
			end

			local var_115_20 = arg_112_1.actors_["10171ui_story"]
			local var_115_21 = 0

			if var_115_21 < arg_112_1.time_ and arg_112_1.time_ <= var_115_21 + arg_115_0 and not isNil(var_115_20) and arg_112_1.var_.characterEffect10171ui_story == nil then
				arg_112_1.var_.characterEffect10171ui_story = var_115_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_22 = 0.200000002980232

			if var_115_21 <= arg_112_1.time_ and arg_112_1.time_ < var_115_21 + var_115_22 and not isNil(var_115_20) then
				local var_115_23 = (arg_112_1.time_ - var_115_21) / var_115_22

				if arg_112_1.var_.characterEffect10171ui_story and not isNil(var_115_20) then
					local var_115_24 = Mathf.Lerp(0, 0.5, var_115_23)

					arg_112_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_112_1.var_.characterEffect10171ui_story.fillRatio = var_115_24
				end
			end

			if arg_112_1.time_ >= var_115_21 + var_115_22 and arg_112_1.time_ < var_115_21 + var_115_22 + arg_115_0 and not isNil(var_115_20) and arg_112_1.var_.characterEffect10171ui_story then
				local var_115_25 = 0.5

				arg_112_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_112_1.var_.characterEffect10171ui_story.fillRatio = var_115_25
			end

			local var_115_26 = 0
			local var_115_27 = 1.225

			if var_115_26 < arg_112_1.time_ and arg_112_1.time_ <= var_115_26 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_28 = arg_112_1:GetWordFromCfg(323162025)
				local var_115_29 = arg_112_1:FormatText(var_115_28.content)

				arg_112_1.text_.text = var_115_29

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_30 = 49
				local var_115_31 = utf8.len(var_115_29)
				local var_115_32 = var_115_30 <= 0 and var_115_27 or var_115_27 * (var_115_31 / var_115_30)

				if var_115_32 > 0 and var_115_27 < var_115_32 then
					arg_112_1.talkMaxDuration = var_115_32

					if var_115_32 + var_115_26 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_32 + var_115_26
					end
				end

				arg_112_1.text_.text = var_115_29
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_33 = math.max(var_115_27, arg_112_1.talkMaxDuration)

			if var_115_26 <= arg_112_1.time_ and arg_112_1.time_ < var_115_26 + var_115_33 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_26) / var_115_33

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_26 + var_115_33 and arg_112_1.time_ < var_115_26 + var_115_33 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1075ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play323162026 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 323162026
		arg_116_1.duration_ = 13.6

		local var_116_0 = {
			zh = 8.866,
			ja = 13.6
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
				arg_116_0:Play323162027(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = arg_116_1.actors_["10039ui_story"].transform
			local var_119_1 = 0

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.var_.moveOldPos10039ui_story = var_119_0.localPosition
			end

			local var_119_2 = 0.001

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_2 then
				local var_119_3 = (arg_116_1.time_ - var_119_1) / var_119_2
				local var_119_4 = Vector3.New(0, -0.8, -6.2)

				var_119_0.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos10039ui_story, var_119_4, var_119_3)

				local var_119_5 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_5.x, var_119_5.y, var_119_5.z)

				local var_119_6 = var_119_0.localEulerAngles

				var_119_6.z = 0
				var_119_6.x = 0
				var_119_0.localEulerAngles = var_119_6
			end

			if arg_116_1.time_ >= var_119_1 + var_119_2 and arg_116_1.time_ < var_119_1 + var_119_2 + arg_119_0 then
				var_119_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_119_7 = manager.ui.mainCamera.transform.position - var_119_0.position

				var_119_0.forward = Vector3.New(var_119_7.x, var_119_7.y, var_119_7.z)

				local var_119_8 = var_119_0.localEulerAngles

				var_119_8.z = 0
				var_119_8.x = 0
				var_119_0.localEulerAngles = var_119_8
			end

			local var_119_9 = arg_116_1.actors_["10039ui_story"]
			local var_119_10 = 0

			if var_119_10 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect10039ui_story == nil then
				arg_116_1.var_.characterEffect10039ui_story = var_119_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_11 = 0.200000002980232

			if var_119_10 <= arg_116_1.time_ and arg_116_1.time_ < var_119_10 + var_119_11 and not isNil(var_119_9) then
				local var_119_12 = (arg_116_1.time_ - var_119_10) / var_119_11

				if arg_116_1.var_.characterEffect10039ui_story and not isNil(var_119_9) then
					arg_116_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= var_119_10 + var_119_11 and arg_116_1.time_ < var_119_10 + var_119_11 + arg_119_0 and not isNil(var_119_9) and arg_116_1.var_.characterEffect10039ui_story then
				arg_116_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_119_13 = 0

			if var_119_13 < arg_116_1.time_ and arg_116_1.time_ <= var_119_13 + arg_119_0 then
				arg_116_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action1_1")
			end

			local var_119_14 = 0

			if var_119_14 < arg_116_1.time_ and arg_116_1.time_ <= var_119_14 + arg_119_0 then
				arg_116_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_119_15 = 0
			local var_119_16 = 0.9

			if var_119_15 < arg_116_1.time_ and arg_116_1.time_ <= var_119_15 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_17 = arg_116_1:FormatText(StoryNameCfg[472].name)

				arg_116_1.leftNameTxt_.text = var_119_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_18 = arg_116_1:GetWordFromCfg(323162026)
				local var_119_19 = arg_116_1:FormatText(var_119_18.content)

				arg_116_1.text_.text = var_119_19

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_20 = 36
				local var_119_21 = utf8.len(var_119_19)
				local var_119_22 = var_119_20 <= 0 and var_119_16 or var_119_16 * (var_119_21 / var_119_20)

				if var_119_22 > 0 and var_119_16 < var_119_22 then
					arg_116_1.talkMaxDuration = var_119_22

					if var_119_22 + var_119_15 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_22 + var_119_15
					end
				end

				arg_116_1.text_.text = var_119_19
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162026", "story_v_out_323162.awb") ~= 0 then
					local var_119_23 = manager.audio:GetVoiceLength("story_v_out_323162", "323162026", "story_v_out_323162.awb") / 1000

					if var_119_23 + var_119_15 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_23 + var_119_15
					end

					if var_119_18.prefab_name ~= "" and arg_116_1.actors_[var_119_18.prefab_name] ~= nil then
						local var_119_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_18.prefab_name].transform, "story_v_out_323162", "323162026", "story_v_out_323162.awb")

						arg_116_1:RecordAudio("323162026", var_119_24)
						arg_116_1:RecordAudio("323162026", var_119_24)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_323162", "323162026", "story_v_out_323162.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_323162", "323162026", "story_v_out_323162.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_25 = math.max(var_119_16, arg_116_1.talkMaxDuration)

			if var_119_15 <= arg_116_1.time_ and arg_116_1.time_ < var_119_15 + var_119_25 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_15) / var_119_25

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_15 + var_119_25 and arg_116_1.time_ < var_119_15 + var_119_25 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
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
	Play323162027 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 323162027
		arg_120_1.duration_ = 2

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play323162028(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["10171ui_story"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos10171ui_story = var_123_0.localPosition

				local var_123_2 = GameObjectTools.GetOrAddComponent(var_123_0.gameObject, typeof(DynamicBoneHelper))

				if var_123_2 then
					var_123_2:EnableDynamicBone(false)
				end
			end

			local var_123_3 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_3 then
				local var_123_4 = (arg_120_1.time_ - var_123_1) / var_123_3
				local var_123_5 = Vector3.New(-0.7, -0.95, -6.05)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos10171ui_story, var_123_5, var_123_4)

				local var_123_6 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_6.x, var_123_6.y, var_123_6.z)

				local var_123_7 = var_123_0.localEulerAngles

				var_123_7.z = 0
				var_123_7.x = 0
				var_123_0.localEulerAngles = var_123_7
			end

			if arg_120_1.time_ >= var_123_1 + var_123_3 and arg_120_1.time_ < var_123_1 + var_123_3 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_123_8 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_8.x, var_123_8.y, var_123_8.z)

				local var_123_9 = var_123_0.localEulerAngles

				var_123_9.z = 0
				var_123_9.x = 0
				var_123_0.localEulerAngles = var_123_9

				local var_123_10 = GameObjectTools.GetOrAddComponent(var_123_0.gameObject, typeof(DynamicBoneHelper))

				if var_123_10 then
					var_123_10:EnableDynamicBone(true)
				end
			end

			local var_123_11 = arg_120_1.actors_["10039ui_story"].transform
			local var_123_12 = 0

			if var_123_12 < arg_120_1.time_ and arg_120_1.time_ <= var_123_12 + arg_123_0 then
				arg_120_1.var_.moveOldPos10039ui_story = var_123_11.localPosition
			end

			local var_123_13 = 0.001

			if var_123_12 <= arg_120_1.time_ and arg_120_1.time_ < var_123_12 + var_123_13 then
				local var_123_14 = (arg_120_1.time_ - var_123_12) / var_123_13
				local var_123_15 = Vector3.New(0.7, -0.8, -6.2)

				var_123_11.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos10039ui_story, var_123_15, var_123_14)

				local var_123_16 = manager.ui.mainCamera.transform.position - var_123_11.position

				var_123_11.forward = Vector3.New(var_123_16.x, var_123_16.y, var_123_16.z)

				local var_123_17 = var_123_11.localEulerAngles

				var_123_17.z = 0
				var_123_17.x = 0
				var_123_11.localEulerAngles = var_123_17
			end

			if arg_120_1.time_ >= var_123_12 + var_123_13 and arg_120_1.time_ < var_123_12 + var_123_13 + arg_123_0 then
				var_123_11.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_123_18 = manager.ui.mainCamera.transform.position - var_123_11.position

				var_123_11.forward = Vector3.New(var_123_18.x, var_123_18.y, var_123_18.z)

				local var_123_19 = var_123_11.localEulerAngles

				var_123_19.z = 0
				var_123_19.x = 0
				var_123_11.localEulerAngles = var_123_19
			end

			local var_123_20 = arg_120_1.actors_["10171ui_story"]
			local var_123_21 = 0

			if var_123_21 < arg_120_1.time_ and arg_120_1.time_ <= var_123_21 + arg_123_0 and not isNil(var_123_20) and arg_120_1.var_.characterEffect10171ui_story == nil then
				arg_120_1.var_.characterEffect10171ui_story = var_123_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_22 = 0.200000002980232

			if var_123_21 <= arg_120_1.time_ and arg_120_1.time_ < var_123_21 + var_123_22 and not isNil(var_123_20) then
				local var_123_23 = (arg_120_1.time_ - var_123_21) / var_123_22

				if arg_120_1.var_.characterEffect10171ui_story and not isNil(var_123_20) then
					arg_120_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_21 + var_123_22 and arg_120_1.time_ < var_123_21 + var_123_22 + arg_123_0 and not isNil(var_123_20) and arg_120_1.var_.characterEffect10171ui_story then
				arg_120_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_123_24 = arg_120_1.actors_["10039ui_story"]
			local var_123_25 = 0

			if var_123_25 < arg_120_1.time_ and arg_120_1.time_ <= var_123_25 + arg_123_0 and not isNil(var_123_24) and arg_120_1.var_.characterEffect10039ui_story == nil then
				arg_120_1.var_.characterEffect10039ui_story = var_123_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_26 = 0.200000002980232

			if var_123_25 <= arg_120_1.time_ and arg_120_1.time_ < var_123_25 + var_123_26 and not isNil(var_123_24) then
				local var_123_27 = (arg_120_1.time_ - var_123_25) / var_123_26

				if arg_120_1.var_.characterEffect10039ui_story and not isNil(var_123_24) then
					local var_123_28 = Mathf.Lerp(0, 0.5, var_123_27)

					arg_120_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_120_1.var_.characterEffect10039ui_story.fillRatio = var_123_28
				end
			end

			if arg_120_1.time_ >= var_123_25 + var_123_26 and arg_120_1.time_ < var_123_25 + var_123_26 + arg_123_0 and not isNil(var_123_24) and arg_120_1.var_.characterEffect10039ui_story then
				local var_123_29 = 0.5

				arg_120_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_120_1.var_.characterEffect10039ui_story.fillRatio = var_123_29
			end

			local var_123_30 = 0

			if var_123_30 < arg_120_1.time_ and arg_120_1.time_ <= var_123_30 + arg_123_0 then
				arg_120_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			local var_123_31 = 0

			if var_123_31 < arg_120_1.time_ and arg_120_1.time_ <= var_123_31 + arg_123_0 then
				arg_120_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_123_32 = 0
			local var_123_33 = 0.075

			if var_123_32 < arg_120_1.time_ and arg_120_1.time_ <= var_123_32 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_34 = arg_120_1:FormatText(StoryNameCfg[1451].name)

				arg_120_1.leftNameTxt_.text = var_123_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_35 = arg_120_1:GetWordFromCfg(323162027)
				local var_123_36 = arg_120_1:FormatText(var_123_35.content)

				arg_120_1.text_.text = var_123_36

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_37 = 3
				local var_123_38 = utf8.len(var_123_36)
				local var_123_39 = var_123_37 <= 0 and var_123_33 or var_123_33 * (var_123_38 / var_123_37)

				if var_123_39 > 0 and var_123_33 < var_123_39 then
					arg_120_1.talkMaxDuration = var_123_39

					if var_123_39 + var_123_32 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_39 + var_123_32
					end
				end

				arg_120_1.text_.text = var_123_36
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162027", "story_v_out_323162.awb") ~= 0 then
					local var_123_40 = manager.audio:GetVoiceLength("story_v_out_323162", "323162027", "story_v_out_323162.awb") / 1000

					if var_123_40 + var_123_32 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_40 + var_123_32
					end

					if var_123_35.prefab_name ~= "" and arg_120_1.actors_[var_123_35.prefab_name] ~= nil then
						local var_123_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_35.prefab_name].transform, "story_v_out_323162", "323162027", "story_v_out_323162.awb")

						arg_120_1:RecordAudio("323162027", var_123_41)
						arg_120_1:RecordAudio("323162027", var_123_41)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_323162", "323162027", "story_v_out_323162.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_323162", "323162027", "story_v_out_323162.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_42 = math.max(var_123_33, arg_120_1.talkMaxDuration)

			if var_123_32 <= arg_120_1.time_ and arg_120_1.time_ < var_123_32 + var_123_42 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_32) / var_123_42

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_32 + var_123_42 and arg_120_1.time_ < var_123_32 + var_123_42 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10039ui_story",
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
	Play323162028 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 323162028
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play323162029(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["10171ui_story"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect10171ui_story == nil then
				arg_124_1.var_.characterEffect10171ui_story = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.200000002980232

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect10171ui_story and not isNil(var_127_0) then
					local var_127_4 = Mathf.Lerp(0, 0.5, var_127_3)

					arg_124_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_124_1.var_.characterEffect10171ui_story.fillRatio = var_127_4
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect10171ui_story then
				local var_127_5 = 0.5

				arg_124_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_124_1.var_.characterEffect10171ui_story.fillRatio = var_127_5
			end

			local var_127_6 = 0
			local var_127_7 = 1.625

			if var_127_6 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_8 = arg_124_1:GetWordFromCfg(323162028)
				local var_127_9 = arg_124_1:FormatText(var_127_8.content)

				arg_124_1.text_.text = var_127_9

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_10 = 65
				local var_127_11 = utf8.len(var_127_9)
				local var_127_12 = var_127_10 <= 0 and var_127_7 or var_127_7 * (var_127_11 / var_127_10)

				if var_127_12 > 0 and var_127_7 < var_127_12 then
					arg_124_1.talkMaxDuration = var_127_12

					if var_127_12 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_12 + var_127_6
					end
				end

				arg_124_1.text_.text = var_127_9
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_13 = math.max(var_127_7, arg_124_1.talkMaxDuration)

			if var_127_6 <= arg_124_1.time_ and arg_124_1.time_ < var_127_6 + var_127_13 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_6) / var_127_13

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_6 + var_127_13 and arg_124_1.time_ < var_127_6 + var_127_13 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play323162029 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 323162029
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play323162030(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0
			local var_131_1 = 1.65

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_2 = arg_128_1:GetWordFromCfg(323162029)
				local var_131_3 = arg_128_1:FormatText(var_131_2.content)

				arg_128_1.text_.text = var_131_3

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_4 = 66
				local var_131_5 = utf8.len(var_131_3)
				local var_131_6 = var_131_4 <= 0 and var_131_1 or var_131_1 * (var_131_5 / var_131_4)

				if var_131_6 > 0 and var_131_1 < var_131_6 then
					arg_128_1.talkMaxDuration = var_131_6

					if var_131_6 + var_131_0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_6 + var_131_0
					end
				end

				arg_128_1.text_.text = var_131_3
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_7 = math.max(var_131_1, arg_128_1.talkMaxDuration)

			if var_131_0 <= arg_128_1.time_ and arg_128_1.time_ < var_131_0 + var_131_7 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_0) / var_131_7

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_0 + var_131_7 and arg_128_1.time_ < var_131_0 + var_131_7 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play323162030 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 323162030
		arg_132_1.duration_ = 3.3

		local var_132_0 = {
			zh = 3.3,
			ja = 3.166
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play323162031(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["10171ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect10171ui_story == nil then
				arg_132_1.var_.characterEffect10171ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect10171ui_story and not isNil(var_135_0) then
					arg_132_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect10171ui_story then
				arg_132_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_135_4 = 0

			if var_135_4 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_1")
			end

			local var_135_5 = 0

			if var_135_5 < arg_132_1.time_ and arg_132_1.time_ <= var_135_5 + arg_135_0 then
				arg_132_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_135_6 = 0
			local var_135_7 = 0.35

			if var_135_6 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_8 = arg_132_1:FormatText(StoryNameCfg[1451].name)

				arg_132_1.leftNameTxt_.text = var_135_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_9 = arg_132_1:GetWordFromCfg(323162030)
				local var_135_10 = arg_132_1:FormatText(var_135_9.content)

				arg_132_1.text_.text = var_135_10

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_11 = 14
				local var_135_12 = utf8.len(var_135_10)
				local var_135_13 = var_135_11 <= 0 and var_135_7 or var_135_7 * (var_135_12 / var_135_11)

				if var_135_13 > 0 and var_135_7 < var_135_13 then
					arg_132_1.talkMaxDuration = var_135_13

					if var_135_13 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_13 + var_135_6
					end
				end

				arg_132_1.text_.text = var_135_10
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162030", "story_v_out_323162.awb") ~= 0 then
					local var_135_14 = manager.audio:GetVoiceLength("story_v_out_323162", "323162030", "story_v_out_323162.awb") / 1000

					if var_135_14 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_14 + var_135_6
					end

					if var_135_9.prefab_name ~= "" and arg_132_1.actors_[var_135_9.prefab_name] ~= nil then
						local var_135_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_9.prefab_name].transform, "story_v_out_323162", "323162030", "story_v_out_323162.awb")

						arg_132_1:RecordAudio("323162030", var_135_15)
						arg_132_1:RecordAudio("323162030", var_135_15)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_323162", "323162030", "story_v_out_323162.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_323162", "323162030", "story_v_out_323162.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_16 = math.max(var_135_7, arg_132_1.talkMaxDuration)

			if var_135_6 <= arg_132_1.time_ and arg_132_1.time_ < var_135_6 + var_135_16 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_6) / var_135_16

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_6 + var_135_16 and arg_132_1.time_ < var_135_6 + var_135_16 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play323162031 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 323162031
		arg_136_1.duration_ = 3.5

		local var_136_0 = {
			zh = 3.5,
			ja = 2.7
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play323162032(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["10039ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect10039ui_story == nil then
				arg_136_1.var_.characterEffect10039ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect10039ui_story and not isNil(var_139_0) then
					arg_136_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect10039ui_story then
				arg_136_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_139_4 = arg_136_1.actors_["10171ui_story"]
			local var_139_5 = 0

			if var_139_5 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect10171ui_story == nil then
				arg_136_1.var_.characterEffect10171ui_story = var_139_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_6 = 0.200000002980232

			if var_139_5 <= arg_136_1.time_ and arg_136_1.time_ < var_139_5 + var_139_6 and not isNil(var_139_4) then
				local var_139_7 = (arg_136_1.time_ - var_139_5) / var_139_6

				if arg_136_1.var_.characterEffect10171ui_story and not isNil(var_139_4) then
					local var_139_8 = Mathf.Lerp(0, 0.5, var_139_7)

					arg_136_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_136_1.var_.characterEffect10171ui_story.fillRatio = var_139_8
				end
			end

			if arg_136_1.time_ >= var_139_5 + var_139_6 and arg_136_1.time_ < var_139_5 + var_139_6 + arg_139_0 and not isNil(var_139_4) and arg_136_1.var_.characterEffect10171ui_story then
				local var_139_9 = 0.5

				arg_136_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_136_1.var_.characterEffect10171ui_story.fillRatio = var_139_9
			end

			local var_139_10 = 0
			local var_139_11 = 0.35

			if var_139_10 < arg_136_1.time_ and arg_136_1.time_ <= var_139_10 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_12 = arg_136_1:FormatText(StoryNameCfg[472].name)

				arg_136_1.leftNameTxt_.text = var_139_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_13 = arg_136_1:GetWordFromCfg(323162031)
				local var_139_14 = arg_136_1:FormatText(var_139_13.content)

				arg_136_1.text_.text = var_139_14

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_15 = 14
				local var_139_16 = utf8.len(var_139_14)
				local var_139_17 = var_139_15 <= 0 and var_139_11 or var_139_11 * (var_139_16 / var_139_15)

				if var_139_17 > 0 and var_139_11 < var_139_17 then
					arg_136_1.talkMaxDuration = var_139_17

					if var_139_17 + var_139_10 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_17 + var_139_10
					end
				end

				arg_136_1.text_.text = var_139_14
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162031", "story_v_out_323162.awb") ~= 0 then
					local var_139_18 = manager.audio:GetVoiceLength("story_v_out_323162", "323162031", "story_v_out_323162.awb") / 1000

					if var_139_18 + var_139_10 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_18 + var_139_10
					end

					if var_139_13.prefab_name ~= "" and arg_136_1.actors_[var_139_13.prefab_name] ~= nil then
						local var_139_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_13.prefab_name].transform, "story_v_out_323162", "323162031", "story_v_out_323162.awb")

						arg_136_1:RecordAudio("323162031", var_139_19)
						arg_136_1:RecordAudio("323162031", var_139_19)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_323162", "323162031", "story_v_out_323162.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_323162", "323162031", "story_v_out_323162.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_20 = math.max(var_139_11, arg_136_1.talkMaxDuration)

			if var_139_10 <= arg_136_1.time_ and arg_136_1.time_ < var_139_10 + var_139_20 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_10) / var_139_20

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_10 + var_139_20 and arg_136_1.time_ < var_139_10 + var_139_20 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play323162032 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 323162032
		arg_140_1.duration_ = 11.4

		local var_140_0 = {
			zh = 9.333,
			ja = 11.4
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
				arg_140_0:Play323162033(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["10171ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect10171ui_story == nil then
				arg_140_1.var_.characterEffect10171ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect10171ui_story and not isNil(var_143_0) then
					arg_140_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect10171ui_story then
				arg_140_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_143_4 = arg_140_1.actors_["10039ui_story"]
			local var_143_5 = 0

			if var_143_5 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 and not isNil(var_143_4) and arg_140_1.var_.characterEffect10039ui_story == nil then
				arg_140_1.var_.characterEffect10039ui_story = var_143_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_6 = 0.200000002980232

			if var_143_5 <= arg_140_1.time_ and arg_140_1.time_ < var_143_5 + var_143_6 and not isNil(var_143_4) then
				local var_143_7 = (arg_140_1.time_ - var_143_5) / var_143_6

				if arg_140_1.var_.characterEffect10039ui_story and not isNil(var_143_4) then
					local var_143_8 = Mathf.Lerp(0, 0.5, var_143_7)

					arg_140_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_140_1.var_.characterEffect10039ui_story.fillRatio = var_143_8
				end
			end

			if arg_140_1.time_ >= var_143_5 + var_143_6 and arg_140_1.time_ < var_143_5 + var_143_6 + arg_143_0 and not isNil(var_143_4) and arg_140_1.var_.characterEffect10039ui_story then
				local var_143_9 = 0.5

				arg_140_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_140_1.var_.characterEffect10039ui_story.fillRatio = var_143_9
			end

			local var_143_10 = 0

			if var_143_10 < arg_140_1.time_ and arg_140_1.time_ <= var_143_10 + arg_143_0 then
				arg_140_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_143_11 = 0

			if var_143_11 < arg_140_1.time_ and arg_140_1.time_ <= var_143_11 + arg_143_0 then
				arg_140_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_2")
			end

			local var_143_12 = 0
			local var_143_13 = 1.075

			if var_143_12 < arg_140_1.time_ and arg_140_1.time_ <= var_143_12 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_14 = arg_140_1:FormatText(StoryNameCfg[1451].name)

				arg_140_1.leftNameTxt_.text = var_143_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_15 = arg_140_1:GetWordFromCfg(323162032)
				local var_143_16 = arg_140_1:FormatText(var_143_15.content)

				arg_140_1.text_.text = var_143_16

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_17 = 43
				local var_143_18 = utf8.len(var_143_16)
				local var_143_19 = var_143_17 <= 0 and var_143_13 or var_143_13 * (var_143_18 / var_143_17)

				if var_143_19 > 0 and var_143_13 < var_143_19 then
					arg_140_1.talkMaxDuration = var_143_19

					if var_143_19 + var_143_12 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_19 + var_143_12
					end
				end

				arg_140_1.text_.text = var_143_16
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162032", "story_v_out_323162.awb") ~= 0 then
					local var_143_20 = manager.audio:GetVoiceLength("story_v_out_323162", "323162032", "story_v_out_323162.awb") / 1000

					if var_143_20 + var_143_12 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_20 + var_143_12
					end

					if var_143_15.prefab_name ~= "" and arg_140_1.actors_[var_143_15.prefab_name] ~= nil then
						local var_143_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_15.prefab_name].transform, "story_v_out_323162", "323162032", "story_v_out_323162.awb")

						arg_140_1:RecordAudio("323162032", var_143_21)
						arg_140_1:RecordAudio("323162032", var_143_21)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_323162", "323162032", "story_v_out_323162.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_323162", "323162032", "story_v_out_323162.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_22 = math.max(var_143_13, arg_140_1.talkMaxDuration)

			if var_143_12 <= arg_140_1.time_ and arg_140_1.time_ < var_143_12 + var_143_22 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_12) / var_143_22

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_12 + var_143_22 and arg_140_1.time_ < var_143_12 + var_143_22 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play323162033 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 323162033
		arg_144_1.duration_ = 8.8

		local var_144_0 = {
			zh = 5.8,
			ja = 8.8
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
				arg_144_0:Play323162034(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["10039ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect10039ui_story == nil then
				arg_144_1.var_.characterEffect10039ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect10039ui_story and not isNil(var_147_0) then
					arg_144_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect10039ui_story then
				arg_144_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_147_4 = arg_144_1.actors_["10171ui_story"]
			local var_147_5 = 0

			if var_147_5 < arg_144_1.time_ and arg_144_1.time_ <= var_147_5 + arg_147_0 and not isNil(var_147_4) and arg_144_1.var_.characterEffect10171ui_story == nil then
				arg_144_1.var_.characterEffect10171ui_story = var_147_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_6 = 0.200000002980232

			if var_147_5 <= arg_144_1.time_ and arg_144_1.time_ < var_147_5 + var_147_6 and not isNil(var_147_4) then
				local var_147_7 = (arg_144_1.time_ - var_147_5) / var_147_6

				if arg_144_1.var_.characterEffect10171ui_story and not isNil(var_147_4) then
					local var_147_8 = Mathf.Lerp(0, 0.5, var_147_7)

					arg_144_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_144_1.var_.characterEffect10171ui_story.fillRatio = var_147_8
				end
			end

			if arg_144_1.time_ >= var_147_5 + var_147_6 and arg_144_1.time_ < var_147_5 + var_147_6 + arg_147_0 and not isNil(var_147_4) and arg_144_1.var_.characterEffect10171ui_story then
				local var_147_9 = 0.5

				arg_144_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_144_1.var_.characterEffect10171ui_story.fillRatio = var_147_9
			end

			local var_147_10 = 0
			local var_147_11 = 0.625

			if var_147_10 < arg_144_1.time_ and arg_144_1.time_ <= var_147_10 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_12 = arg_144_1:FormatText(StoryNameCfg[472].name)

				arg_144_1.leftNameTxt_.text = var_147_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_13 = arg_144_1:GetWordFromCfg(323162033)
				local var_147_14 = arg_144_1:FormatText(var_147_13.content)

				arg_144_1.text_.text = var_147_14

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_15 = 25
				local var_147_16 = utf8.len(var_147_14)
				local var_147_17 = var_147_15 <= 0 and var_147_11 or var_147_11 * (var_147_16 / var_147_15)

				if var_147_17 > 0 and var_147_11 < var_147_17 then
					arg_144_1.talkMaxDuration = var_147_17

					if var_147_17 + var_147_10 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_17 + var_147_10
					end
				end

				arg_144_1.text_.text = var_147_14
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162033", "story_v_out_323162.awb") ~= 0 then
					local var_147_18 = manager.audio:GetVoiceLength("story_v_out_323162", "323162033", "story_v_out_323162.awb") / 1000

					if var_147_18 + var_147_10 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_18 + var_147_10
					end

					if var_147_13.prefab_name ~= "" and arg_144_1.actors_[var_147_13.prefab_name] ~= nil then
						local var_147_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_13.prefab_name].transform, "story_v_out_323162", "323162033", "story_v_out_323162.awb")

						arg_144_1:RecordAudio("323162033", var_147_19)
						arg_144_1:RecordAudio("323162033", var_147_19)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_323162", "323162033", "story_v_out_323162.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_323162", "323162033", "story_v_out_323162.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_20 = math.max(var_147_11, arg_144_1.talkMaxDuration)

			if var_147_10 <= arg_144_1.time_ and arg_144_1.time_ < var_147_10 + var_147_20 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_10) / var_147_20

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_10 + var_147_20 and arg_144_1.time_ < var_147_10 + var_147_20 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play323162034 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 323162034
		arg_148_1.duration_ = 6.57

		local var_148_0 = {
			zh = 4.166,
			ja = 6.566
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
				arg_148_0:Play323162035(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0

			if var_151_0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_1")
			end

			local var_151_1 = 0
			local var_151_2 = 0.425

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				local var_151_3 = arg_148_1:FormatText(StoryNameCfg[472].name)

				arg_148_1.leftNameTxt_.text = var_151_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_4 = arg_148_1:GetWordFromCfg(323162034)
				local var_151_5 = arg_148_1:FormatText(var_151_4.content)

				arg_148_1.text_.text = var_151_5

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_6 = 17
				local var_151_7 = utf8.len(var_151_5)
				local var_151_8 = var_151_6 <= 0 and var_151_2 or var_151_2 * (var_151_7 / var_151_6)

				if var_151_8 > 0 and var_151_2 < var_151_8 then
					arg_148_1.talkMaxDuration = var_151_8

					if var_151_8 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_8 + var_151_1
					end
				end

				arg_148_1.text_.text = var_151_5
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162034", "story_v_out_323162.awb") ~= 0 then
					local var_151_9 = manager.audio:GetVoiceLength("story_v_out_323162", "323162034", "story_v_out_323162.awb") / 1000

					if var_151_9 + var_151_1 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_9 + var_151_1
					end

					if var_151_4.prefab_name ~= "" and arg_148_1.actors_[var_151_4.prefab_name] ~= nil then
						local var_151_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_4.prefab_name].transform, "story_v_out_323162", "323162034", "story_v_out_323162.awb")

						arg_148_1:RecordAudio("323162034", var_151_10)
						arg_148_1:RecordAudio("323162034", var_151_10)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_323162", "323162034", "story_v_out_323162.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_323162", "323162034", "story_v_out_323162.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_11 = math.max(var_151_2, arg_148_1.talkMaxDuration)

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_11 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_1) / var_151_11

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_1 + var_151_11 and arg_148_1.time_ < var_151_1 + var_151_11 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play323162035 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 323162035
		arg_152_1.duration_ = 11.73

		local var_152_0 = {
			zh = 7.733,
			ja = 11.733
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
				arg_152_0:Play323162036(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["10171ui_story"]
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect10171ui_story == nil then
				arg_152_1.var_.characterEffect10171ui_story = var_155_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.200000002980232

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_2 and not isNil(var_155_0) then
				local var_155_3 = (arg_152_1.time_ - var_155_1) / var_155_2

				if arg_152_1.var_.characterEffect10171ui_story and not isNil(var_155_0) then
					arg_152_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_1 + var_155_2 and arg_152_1.time_ < var_155_1 + var_155_2 + arg_155_0 and not isNil(var_155_0) and arg_152_1.var_.characterEffect10171ui_story then
				arg_152_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_155_4 = arg_152_1.actors_["10039ui_story"]
			local var_155_5 = 0

			if var_155_5 < arg_152_1.time_ and arg_152_1.time_ <= var_155_5 + arg_155_0 and not isNil(var_155_4) and arg_152_1.var_.characterEffect10039ui_story == nil then
				arg_152_1.var_.characterEffect10039ui_story = var_155_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_6 = 0.200000002980232

			if var_155_5 <= arg_152_1.time_ and arg_152_1.time_ < var_155_5 + var_155_6 and not isNil(var_155_4) then
				local var_155_7 = (arg_152_1.time_ - var_155_5) / var_155_6

				if arg_152_1.var_.characterEffect10039ui_story and not isNil(var_155_4) then
					local var_155_8 = Mathf.Lerp(0, 0.5, var_155_7)

					arg_152_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_152_1.var_.characterEffect10039ui_story.fillRatio = var_155_8
				end
			end

			if arg_152_1.time_ >= var_155_5 + var_155_6 and arg_152_1.time_ < var_155_5 + var_155_6 + arg_155_0 and not isNil(var_155_4) and arg_152_1.var_.characterEffect10039ui_story then
				local var_155_9 = 0.5

				arg_152_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_152_1.var_.characterEffect10039ui_story.fillRatio = var_155_9
			end

			local var_155_10 = 0
			local var_155_11 = 0.875

			if var_155_10 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_12 = arg_152_1:FormatText(StoryNameCfg[1451].name)

				arg_152_1.leftNameTxt_.text = var_155_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_13 = arg_152_1:GetWordFromCfg(323162035)
				local var_155_14 = arg_152_1:FormatText(var_155_13.content)

				arg_152_1.text_.text = var_155_14

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_15 = 35
				local var_155_16 = utf8.len(var_155_14)
				local var_155_17 = var_155_15 <= 0 and var_155_11 or var_155_11 * (var_155_16 / var_155_15)

				if var_155_17 > 0 and var_155_11 < var_155_17 then
					arg_152_1.talkMaxDuration = var_155_17

					if var_155_17 + var_155_10 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_17 + var_155_10
					end
				end

				arg_152_1.text_.text = var_155_14
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162035", "story_v_out_323162.awb") ~= 0 then
					local var_155_18 = manager.audio:GetVoiceLength("story_v_out_323162", "323162035", "story_v_out_323162.awb") / 1000

					if var_155_18 + var_155_10 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_18 + var_155_10
					end

					if var_155_13.prefab_name ~= "" and arg_152_1.actors_[var_155_13.prefab_name] ~= nil then
						local var_155_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_13.prefab_name].transform, "story_v_out_323162", "323162035", "story_v_out_323162.awb")

						arg_152_1:RecordAudio("323162035", var_155_19)
						arg_152_1:RecordAudio("323162035", var_155_19)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_323162", "323162035", "story_v_out_323162.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_323162", "323162035", "story_v_out_323162.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_20 = math.max(var_155_11, arg_152_1.talkMaxDuration)

			if var_155_10 <= arg_152_1.time_ and arg_152_1.time_ < var_155_10 + var_155_20 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_10) / var_155_20

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_10 + var_155_20 and arg_152_1.time_ < var_155_10 + var_155_20 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play323162036 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 323162036
		arg_156_1.duration_ = 7.13

		local var_156_0 = {
			zh = 6.433,
			ja = 7.133
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
				arg_156_0:Play323162037(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0
			local var_159_1 = 0.675

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_2 = arg_156_1:FormatText(StoryNameCfg[1451].name)

				arg_156_1.leftNameTxt_.text = var_159_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_3 = arg_156_1:GetWordFromCfg(323162036)
				local var_159_4 = arg_156_1:FormatText(var_159_3.content)

				arg_156_1.text_.text = var_159_4

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 27
				local var_159_6 = utf8.len(var_159_4)
				local var_159_7 = var_159_5 <= 0 and var_159_1 or var_159_1 * (var_159_6 / var_159_5)

				if var_159_7 > 0 and var_159_1 < var_159_7 then
					arg_156_1.talkMaxDuration = var_159_7

					if var_159_7 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_7 + var_159_0
					end
				end

				arg_156_1.text_.text = var_159_4
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162036", "story_v_out_323162.awb") ~= 0 then
					local var_159_8 = manager.audio:GetVoiceLength("story_v_out_323162", "323162036", "story_v_out_323162.awb") / 1000

					if var_159_8 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_8 + var_159_0
					end

					if var_159_3.prefab_name ~= "" and arg_156_1.actors_[var_159_3.prefab_name] ~= nil then
						local var_159_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_3.prefab_name].transform, "story_v_out_323162", "323162036", "story_v_out_323162.awb")

						arg_156_1:RecordAudio("323162036", var_159_9)
						arg_156_1:RecordAudio("323162036", var_159_9)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_323162", "323162036", "story_v_out_323162.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_323162", "323162036", "story_v_out_323162.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_10 = math.max(var_159_1, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_10 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_0) / var_159_10

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_10 and arg_156_1.time_ < var_159_0 + var_159_10 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play323162037 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 323162037
		arg_160_1.duration_ = 6.5

		local var_160_0 = {
			zh = 3.8,
			ja = 6.5
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
				arg_160_0:Play323162038(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["10039ui_story"]
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect10039ui_story == nil then
				arg_160_1.var_.characterEffect10039ui_story = var_163_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_2 = 0.200000002980232

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_2 and not isNil(var_163_0) then
				local var_163_3 = (arg_160_1.time_ - var_163_1) / var_163_2

				if arg_160_1.var_.characterEffect10039ui_story and not isNil(var_163_0) then
					arg_160_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_1 + var_163_2 and arg_160_1.time_ < var_163_1 + var_163_2 + arg_163_0 and not isNil(var_163_0) and arg_160_1.var_.characterEffect10039ui_story then
				arg_160_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_163_4 = arg_160_1.actors_["10171ui_story"]
			local var_163_5 = 0

			if var_163_5 < arg_160_1.time_ and arg_160_1.time_ <= var_163_5 + arg_163_0 and not isNil(var_163_4) and arg_160_1.var_.characterEffect10171ui_story == nil then
				arg_160_1.var_.characterEffect10171ui_story = var_163_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_6 = 0.200000002980232

			if var_163_5 <= arg_160_1.time_ and arg_160_1.time_ < var_163_5 + var_163_6 and not isNil(var_163_4) then
				local var_163_7 = (arg_160_1.time_ - var_163_5) / var_163_6

				if arg_160_1.var_.characterEffect10171ui_story and not isNil(var_163_4) then
					local var_163_8 = Mathf.Lerp(0, 0.5, var_163_7)

					arg_160_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_160_1.var_.characterEffect10171ui_story.fillRatio = var_163_8
				end
			end

			if arg_160_1.time_ >= var_163_5 + var_163_6 and arg_160_1.time_ < var_163_5 + var_163_6 + arg_163_0 and not isNil(var_163_4) and arg_160_1.var_.characterEffect10171ui_story then
				local var_163_9 = 0.5

				arg_160_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_160_1.var_.characterEffect10171ui_story.fillRatio = var_163_9
			end

			local var_163_10 = 0

			if var_163_10 < arg_160_1.time_ and arg_160_1.time_ <= var_163_10 + arg_163_0 then
				arg_160_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_2")
			end

			local var_163_11 = 0
			local var_163_12 = 0.375

			if var_163_11 < arg_160_1.time_ and arg_160_1.time_ <= var_163_11 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_13 = arg_160_1:FormatText(StoryNameCfg[472].name)

				arg_160_1.leftNameTxt_.text = var_163_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_14 = arg_160_1:GetWordFromCfg(323162037)
				local var_163_15 = arg_160_1:FormatText(var_163_14.content)

				arg_160_1.text_.text = var_163_15

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_16 = 15
				local var_163_17 = utf8.len(var_163_15)
				local var_163_18 = var_163_16 <= 0 and var_163_12 or var_163_12 * (var_163_17 / var_163_16)

				if var_163_18 > 0 and var_163_12 < var_163_18 then
					arg_160_1.talkMaxDuration = var_163_18

					if var_163_18 + var_163_11 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_18 + var_163_11
					end
				end

				arg_160_1.text_.text = var_163_15
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162037", "story_v_out_323162.awb") ~= 0 then
					local var_163_19 = manager.audio:GetVoiceLength("story_v_out_323162", "323162037", "story_v_out_323162.awb") / 1000

					if var_163_19 + var_163_11 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_19 + var_163_11
					end

					if var_163_14.prefab_name ~= "" and arg_160_1.actors_[var_163_14.prefab_name] ~= nil then
						local var_163_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_14.prefab_name].transform, "story_v_out_323162", "323162037", "story_v_out_323162.awb")

						arg_160_1:RecordAudio("323162037", var_163_20)
						arg_160_1:RecordAudio("323162037", var_163_20)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_323162", "323162037", "story_v_out_323162.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_323162", "323162037", "story_v_out_323162.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_21 = math.max(var_163_12, arg_160_1.talkMaxDuration)

			if var_163_11 <= arg_160_1.time_ and arg_160_1.time_ < var_163_11 + var_163_21 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_11) / var_163_21

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_11 + var_163_21 and arg_160_1.time_ < var_163_11 + var_163_21 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play323162038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 323162038
		arg_164_1.duration_ = 2.9

		local var_164_0 = {
			zh = 2.9,
			ja = 2.666
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
				arg_164_0:Play323162039(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["10171ui_story"]
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect10171ui_story == nil then
				arg_164_1.var_.characterEffect10171ui_story = var_167_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.200000002980232

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 and not isNil(var_167_0) then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2

				if arg_164_1.var_.characterEffect10171ui_story and not isNil(var_167_0) then
					arg_164_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 and not isNil(var_167_0) and arg_164_1.var_.characterEffect10171ui_story then
				arg_164_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_167_4 = arg_164_1.actors_["10039ui_story"]
			local var_167_5 = 0

			if var_167_5 < arg_164_1.time_ and arg_164_1.time_ <= var_167_5 + arg_167_0 and not isNil(var_167_4) and arg_164_1.var_.characterEffect10039ui_story == nil then
				arg_164_1.var_.characterEffect10039ui_story = var_167_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_6 = 0.200000002980232

			if var_167_5 <= arg_164_1.time_ and arg_164_1.time_ < var_167_5 + var_167_6 and not isNil(var_167_4) then
				local var_167_7 = (arg_164_1.time_ - var_167_5) / var_167_6

				if arg_164_1.var_.characterEffect10039ui_story and not isNil(var_167_4) then
					local var_167_8 = Mathf.Lerp(0, 0.5, var_167_7)

					arg_164_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_164_1.var_.characterEffect10039ui_story.fillRatio = var_167_8
				end
			end

			if arg_164_1.time_ >= var_167_5 + var_167_6 and arg_164_1.time_ < var_167_5 + var_167_6 + arg_167_0 and not isNil(var_167_4) and arg_164_1.var_.characterEffect10039ui_story then
				local var_167_9 = 0.5

				arg_164_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_164_1.var_.characterEffect10039ui_story.fillRatio = var_167_9
			end

			local var_167_10 = 0

			if var_167_10 < arg_164_1.time_ and arg_164_1.time_ <= var_167_10 + arg_167_0 then
				arg_164_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			local var_167_11 = 0

			if var_167_11 < arg_164_1.time_ and arg_164_1.time_ <= var_167_11 + arg_167_0 then
				arg_164_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_167_12 = 0
			local var_167_13 = 0.2

			if var_167_12 < arg_164_1.time_ and arg_164_1.time_ <= var_167_12 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_14 = arg_164_1:FormatText(StoryNameCfg[1451].name)

				arg_164_1.leftNameTxt_.text = var_167_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_15 = arg_164_1:GetWordFromCfg(323162038)
				local var_167_16 = arg_164_1:FormatText(var_167_15.content)

				arg_164_1.text_.text = var_167_16

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_17 = 8
				local var_167_18 = utf8.len(var_167_16)
				local var_167_19 = var_167_17 <= 0 and var_167_13 or var_167_13 * (var_167_18 / var_167_17)

				if var_167_19 > 0 and var_167_13 < var_167_19 then
					arg_164_1.talkMaxDuration = var_167_19

					if var_167_19 + var_167_12 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_19 + var_167_12
					end
				end

				arg_164_1.text_.text = var_167_16
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162038", "story_v_out_323162.awb") ~= 0 then
					local var_167_20 = manager.audio:GetVoiceLength("story_v_out_323162", "323162038", "story_v_out_323162.awb") / 1000

					if var_167_20 + var_167_12 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_20 + var_167_12
					end

					if var_167_15.prefab_name ~= "" and arg_164_1.actors_[var_167_15.prefab_name] ~= nil then
						local var_167_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_15.prefab_name].transform, "story_v_out_323162", "323162038", "story_v_out_323162.awb")

						arg_164_1:RecordAudio("323162038", var_167_21)
						arg_164_1:RecordAudio("323162038", var_167_21)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_323162", "323162038", "story_v_out_323162.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_323162", "323162038", "story_v_out_323162.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_22 = math.max(var_167_13, arg_164_1.talkMaxDuration)

			if var_167_12 <= arg_164_1.time_ and arg_164_1.time_ < var_167_12 + var_167_22 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_12) / var_167_22

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_12 + var_167_22 and arg_164_1.time_ < var_167_12 + var_167_22 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play323162039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 323162039
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play323162040(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["10171ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect10171ui_story == nil then
				arg_168_1.var_.characterEffect10171ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.200000002980232

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect10171ui_story and not isNil(var_171_0) then
					local var_171_4 = Mathf.Lerp(0, 0.5, var_171_3)

					arg_168_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_168_1.var_.characterEffect10171ui_story.fillRatio = var_171_4
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect10171ui_story then
				local var_171_5 = 0.5

				arg_168_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_168_1.var_.characterEffect10171ui_story.fillRatio = var_171_5
			end

			local var_171_6 = arg_168_1.actors_["10171ui_story"].transform
			local var_171_7 = 0

			if var_171_7 < arg_168_1.time_ and arg_168_1.time_ <= var_171_7 + arg_171_0 then
				arg_168_1.var_.moveOldPos10171ui_story = var_171_6.localPosition

				local var_171_8 = GameObjectTools.GetOrAddComponent(var_171_6.gameObject, typeof(DynamicBoneHelper))

				if var_171_8 then
					var_171_8:EnableDynamicBone(false)
				end
			end

			local var_171_9 = 0.001

			if var_171_7 <= arg_168_1.time_ and arg_168_1.time_ < var_171_7 + var_171_9 then
				local var_171_10 = (arg_168_1.time_ - var_171_7) / var_171_9
				local var_171_11 = Vector3.New(0, 100, 0)

				var_171_6.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10171ui_story, var_171_11, var_171_10)

				local var_171_12 = manager.ui.mainCamera.transform.position - var_171_6.position

				var_171_6.forward = Vector3.New(var_171_12.x, var_171_12.y, var_171_12.z)

				local var_171_13 = var_171_6.localEulerAngles

				var_171_13.z = 0
				var_171_13.x = 0
				var_171_6.localEulerAngles = var_171_13
			end

			if arg_168_1.time_ >= var_171_7 + var_171_9 and arg_168_1.time_ < var_171_7 + var_171_9 + arg_171_0 then
				var_171_6.localPosition = Vector3.New(0, 100, 0)

				local var_171_14 = manager.ui.mainCamera.transform.position - var_171_6.position

				var_171_6.forward = Vector3.New(var_171_14.x, var_171_14.y, var_171_14.z)

				local var_171_15 = var_171_6.localEulerAngles

				var_171_15.z = 0
				var_171_15.x = 0
				var_171_6.localEulerAngles = var_171_15

				local var_171_16 = GameObjectTools.GetOrAddComponent(var_171_6.gameObject, typeof(DynamicBoneHelper))

				if var_171_16 then
					var_171_16:EnableDynamicBone(true)
				end
			end

			local var_171_17 = arg_168_1.actors_["10039ui_story"].transform
			local var_171_18 = 0

			if var_171_18 < arg_168_1.time_ and arg_168_1.time_ <= var_171_18 + arg_171_0 then
				arg_168_1.var_.moveOldPos10039ui_story = var_171_17.localPosition
			end

			local var_171_19 = 0.001

			if var_171_18 <= arg_168_1.time_ and arg_168_1.time_ < var_171_18 + var_171_19 then
				local var_171_20 = (arg_168_1.time_ - var_171_18) / var_171_19
				local var_171_21 = Vector3.New(0, 100, 0)

				var_171_17.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10039ui_story, var_171_21, var_171_20)

				local var_171_22 = manager.ui.mainCamera.transform.position - var_171_17.position

				var_171_17.forward = Vector3.New(var_171_22.x, var_171_22.y, var_171_22.z)

				local var_171_23 = var_171_17.localEulerAngles

				var_171_23.z = 0
				var_171_23.x = 0
				var_171_17.localEulerAngles = var_171_23
			end

			if arg_168_1.time_ >= var_171_18 + var_171_19 and arg_168_1.time_ < var_171_18 + var_171_19 + arg_171_0 then
				var_171_17.localPosition = Vector3.New(0, 100, 0)

				local var_171_24 = manager.ui.mainCamera.transform.position - var_171_17.position

				var_171_17.forward = Vector3.New(var_171_24.x, var_171_24.y, var_171_24.z)

				local var_171_25 = var_171_17.localEulerAngles

				var_171_25.z = 0
				var_171_25.x = 0
				var_171_17.localEulerAngles = var_171_25
			end

			local var_171_26 = 0
			local var_171_27 = 1.775

			if var_171_26 < arg_168_1.time_ and arg_168_1.time_ <= var_171_26 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_28 = arg_168_1:GetWordFromCfg(323162039)
				local var_171_29 = arg_168_1:FormatText(var_171_28.content)

				arg_168_1.text_.text = var_171_29

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_30 = 71
				local var_171_31 = utf8.len(var_171_29)
				local var_171_32 = var_171_30 <= 0 and var_171_27 or var_171_27 * (var_171_31 / var_171_30)

				if var_171_32 > 0 and var_171_27 < var_171_32 then
					arg_168_1.talkMaxDuration = var_171_32

					if var_171_32 + var_171_26 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_32 + var_171_26
					end
				end

				arg_168_1.text_.text = var_171_29
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_33 = math.max(var_171_27, arg_168_1.talkMaxDuration)

			if var_171_26 <= arg_168_1.time_ and arg_168_1.time_ < var_171_26 + var_171_33 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_26) / var_171_33

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_26 + var_171_33 and arg_168_1.time_ < var_171_26 + var_171_33 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play323162040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 323162040
		arg_172_1.duration_ = 4.13

		local var_172_0 = {
			zh = 3.066,
			ja = 4.133
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
				arg_172_0:Play323162041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["10039ui_story"].transform
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.var_.moveOldPos10039ui_story = var_175_0.localPosition
			end

			local var_175_2 = 0.001

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2
				local var_175_4 = Vector3.New(0, -0.8, -6.2)

				var_175_0.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos10039ui_story, var_175_4, var_175_3)

				local var_175_5 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_5.x, var_175_5.y, var_175_5.z)

				local var_175_6 = var_175_0.localEulerAngles

				var_175_6.z = 0
				var_175_6.x = 0
				var_175_0.localEulerAngles = var_175_6
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 then
				var_175_0.localPosition = Vector3.New(0, -0.8, -6.2)

				local var_175_7 = manager.ui.mainCamera.transform.position - var_175_0.position

				var_175_0.forward = Vector3.New(var_175_7.x, var_175_7.y, var_175_7.z)

				local var_175_8 = var_175_0.localEulerAngles

				var_175_8.z = 0
				var_175_8.x = 0
				var_175_0.localEulerAngles = var_175_8
			end

			local var_175_9 = arg_172_1.actors_["10039ui_story"]
			local var_175_10 = 0

			if var_175_10 < arg_172_1.time_ and arg_172_1.time_ <= var_175_10 + arg_175_0 and not isNil(var_175_9) and arg_172_1.var_.characterEffect10039ui_story == nil then
				arg_172_1.var_.characterEffect10039ui_story = var_175_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_11 = 0.200000002980232

			if var_175_10 <= arg_172_1.time_ and arg_172_1.time_ < var_175_10 + var_175_11 and not isNil(var_175_9) then
				local var_175_12 = (arg_172_1.time_ - var_175_10) / var_175_11

				if arg_172_1.var_.characterEffect10039ui_story and not isNil(var_175_9) then
					arg_172_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= var_175_10 + var_175_11 and arg_172_1.time_ < var_175_10 + var_175_11 + arg_175_0 and not isNil(var_175_9) and arg_172_1.var_.characterEffect10039ui_story then
				arg_172_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_175_13 = 0
			local var_175_14 = 0.275

			if var_175_13 < arg_172_1.time_ and arg_172_1.time_ <= var_175_13 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_15 = arg_172_1:FormatText(StoryNameCfg[472].name)

				arg_172_1.leftNameTxt_.text = var_175_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_16 = arg_172_1:GetWordFromCfg(323162040)
				local var_175_17 = arg_172_1:FormatText(var_175_16.content)

				arg_172_1.text_.text = var_175_17

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_18 = 11
				local var_175_19 = utf8.len(var_175_17)
				local var_175_20 = var_175_18 <= 0 and var_175_14 or var_175_14 * (var_175_19 / var_175_18)

				if var_175_20 > 0 and var_175_14 < var_175_20 then
					arg_172_1.talkMaxDuration = var_175_20

					if var_175_20 + var_175_13 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_20 + var_175_13
					end
				end

				arg_172_1.text_.text = var_175_17
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162040", "story_v_out_323162.awb") ~= 0 then
					local var_175_21 = manager.audio:GetVoiceLength("story_v_out_323162", "323162040", "story_v_out_323162.awb") / 1000

					if var_175_21 + var_175_13 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_21 + var_175_13
					end

					if var_175_16.prefab_name ~= "" and arg_172_1.actors_[var_175_16.prefab_name] ~= nil then
						local var_175_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_16.prefab_name].transform, "story_v_out_323162", "323162040", "story_v_out_323162.awb")

						arg_172_1:RecordAudio("323162040", var_175_22)
						arg_172_1:RecordAudio("323162040", var_175_22)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_323162", "323162040", "story_v_out_323162.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_323162", "323162040", "story_v_out_323162.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_23 = math.max(var_175_14, arg_172_1.talkMaxDuration)

			if var_175_13 <= arg_172_1.time_ and arg_172_1.time_ < var_175_13 + var_175_23 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_13) / var_175_23

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_13 + var_175_23 and arg_172_1.time_ < var_175_13 + var_175_23 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play323162041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 323162041
		arg_176_1.duration_ = 12.1

		local var_176_0 = {
			zh = 9.2,
			ja = 12.1
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
				arg_176_0:Play323162042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0
			local var_179_1 = 0.95

			if var_179_0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_2 = arg_176_1:FormatText(StoryNameCfg[472].name)

				arg_176_1.leftNameTxt_.text = var_179_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_3 = arg_176_1:GetWordFromCfg(323162041)
				local var_179_4 = arg_176_1:FormatText(var_179_3.content)

				arg_176_1.text_.text = var_179_4

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_5 = 38
				local var_179_6 = utf8.len(var_179_4)
				local var_179_7 = var_179_5 <= 0 and var_179_1 or var_179_1 * (var_179_6 / var_179_5)

				if var_179_7 > 0 and var_179_1 < var_179_7 then
					arg_176_1.talkMaxDuration = var_179_7

					if var_179_7 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_7 + var_179_0
					end
				end

				arg_176_1.text_.text = var_179_4
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162041", "story_v_out_323162.awb") ~= 0 then
					local var_179_8 = manager.audio:GetVoiceLength("story_v_out_323162", "323162041", "story_v_out_323162.awb") / 1000

					if var_179_8 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_8 + var_179_0
					end

					if var_179_3.prefab_name ~= "" and arg_176_1.actors_[var_179_3.prefab_name] ~= nil then
						local var_179_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_3.prefab_name].transform, "story_v_out_323162", "323162041", "story_v_out_323162.awb")

						arg_176_1:RecordAudio("323162041", var_179_9)
						arg_176_1:RecordAudio("323162041", var_179_9)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_323162", "323162041", "story_v_out_323162.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_323162", "323162041", "story_v_out_323162.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_10 = math.max(var_179_1, arg_176_1.talkMaxDuration)

			if var_179_0 <= arg_176_1.time_ and arg_176_1.time_ < var_179_0 + var_179_10 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_0) / var_179_10

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_0 + var_179_10 and arg_176_1.time_ < var_179_0 + var_179_10 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play323162042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 323162042
		arg_180_1.duration_ = 2.05

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play323162043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["10171ui_story"].transform
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.var_.moveOldPos10171ui_story = var_183_0.localPosition

				local var_183_2 = GameObjectTools.GetOrAddComponent(var_183_0.gameObject, typeof(DynamicBoneHelper))

				if var_183_2 then
					var_183_2:EnableDynamicBone(false)
				end
			end

			local var_183_3 = 0.001

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_3 then
				local var_183_4 = (arg_180_1.time_ - var_183_1) / var_183_3
				local var_183_5 = Vector3.New(-0.7, -0.95, -6.05)

				var_183_0.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10171ui_story, var_183_5, var_183_4)

				local var_183_6 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_6.x, var_183_6.y, var_183_6.z)

				local var_183_7 = var_183_0.localEulerAngles

				var_183_7.z = 0
				var_183_7.x = 0
				var_183_0.localEulerAngles = var_183_7
			end

			if arg_180_1.time_ >= var_183_1 + var_183_3 and arg_180_1.time_ < var_183_1 + var_183_3 + arg_183_0 then
				var_183_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_183_8 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_8.x, var_183_8.y, var_183_8.z)

				local var_183_9 = var_183_0.localEulerAngles

				var_183_9.z = 0
				var_183_9.x = 0
				var_183_0.localEulerAngles = var_183_9

				local var_183_10 = GameObjectTools.GetOrAddComponent(var_183_0.gameObject, typeof(DynamicBoneHelper))

				if var_183_10 then
					var_183_10:EnableDynamicBone(true)
				end
			end

			local var_183_11 = arg_180_1.actors_["10171ui_story"]
			local var_183_12 = 0

			if var_183_12 < arg_180_1.time_ and arg_180_1.time_ <= var_183_12 + arg_183_0 and not isNil(var_183_11) and arg_180_1.var_.characterEffect10171ui_story == nil then
				arg_180_1.var_.characterEffect10171ui_story = var_183_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_13 = 0.200000002980232

			if var_183_12 <= arg_180_1.time_ and arg_180_1.time_ < var_183_12 + var_183_13 and not isNil(var_183_11) then
				local var_183_14 = (arg_180_1.time_ - var_183_12) / var_183_13

				if arg_180_1.var_.characterEffect10171ui_story and not isNil(var_183_11) then
					arg_180_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= var_183_12 + var_183_13 and arg_180_1.time_ < var_183_12 + var_183_13 + arg_183_0 and not isNil(var_183_11) and arg_180_1.var_.characterEffect10171ui_story then
				arg_180_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_183_15 = arg_180_1.actors_["10039ui_story"]
			local var_183_16 = 0

			if var_183_16 < arg_180_1.time_ and arg_180_1.time_ <= var_183_16 + arg_183_0 and not isNil(var_183_15) and arg_180_1.var_.characterEffect10039ui_story == nil then
				arg_180_1.var_.characterEffect10039ui_story = var_183_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_17 = 0.200000002980232

			if var_183_16 <= arg_180_1.time_ and arg_180_1.time_ < var_183_16 + var_183_17 and not isNil(var_183_15) then
				local var_183_18 = (arg_180_1.time_ - var_183_16) / var_183_17

				if arg_180_1.var_.characterEffect10039ui_story and not isNil(var_183_15) then
					local var_183_19 = Mathf.Lerp(0, 0.5, var_183_18)

					arg_180_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_180_1.var_.characterEffect10039ui_story.fillRatio = var_183_19
				end
			end

			if arg_180_1.time_ >= var_183_16 + var_183_17 and arg_180_1.time_ < var_183_16 + var_183_17 + arg_183_0 and not isNil(var_183_15) and arg_180_1.var_.characterEffect10039ui_story then
				local var_183_20 = 0.5

				arg_180_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_180_1.var_.characterEffect10039ui_story.fillRatio = var_183_20
			end

			local var_183_21 = 0

			if var_183_21 < arg_180_1.time_ and arg_180_1.time_ <= var_183_21 + arg_183_0 then
				arg_180_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			local var_183_22 = 0.05

			if var_183_22 < arg_180_1.time_ and arg_180_1.time_ <= var_183_22 + arg_183_0 then
				arg_180_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_183_23 = arg_180_1.actors_["10039ui_story"].transform
			local var_183_24 = 0

			if var_183_24 < arg_180_1.time_ and arg_180_1.time_ <= var_183_24 + arg_183_0 then
				arg_180_1.var_.moveOldPos10039ui_story = var_183_23.localPosition
			end

			local var_183_25 = 0.001

			if var_183_24 <= arg_180_1.time_ and arg_180_1.time_ < var_183_24 + var_183_25 then
				local var_183_26 = (arg_180_1.time_ - var_183_24) / var_183_25
				local var_183_27 = Vector3.New(0.7, -0.8, -6.2)

				var_183_23.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10039ui_story, var_183_27, var_183_26)

				local var_183_28 = manager.ui.mainCamera.transform.position - var_183_23.position

				var_183_23.forward = Vector3.New(var_183_28.x, var_183_28.y, var_183_28.z)

				local var_183_29 = var_183_23.localEulerAngles

				var_183_29.z = 0
				var_183_29.x = 0
				var_183_23.localEulerAngles = var_183_29
			end

			if arg_180_1.time_ >= var_183_24 + var_183_25 and arg_180_1.time_ < var_183_24 + var_183_25 + arg_183_0 then
				var_183_23.localPosition = Vector3.New(0.7, -0.8, -6.2)

				local var_183_30 = manager.ui.mainCamera.transform.position - var_183_23.position

				var_183_23.forward = Vector3.New(var_183_30.x, var_183_30.y, var_183_30.z)

				local var_183_31 = var_183_23.localEulerAngles

				var_183_31.z = 0
				var_183_31.x = 0
				var_183_23.localEulerAngles = var_183_31
			end

			local var_183_32 = 0
			local var_183_33 = 0.05

			if var_183_32 < arg_180_1.time_ and arg_180_1.time_ <= var_183_32 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_34 = arg_180_1:FormatText(StoryNameCfg[1451].name)

				arg_180_1.leftNameTxt_.text = var_183_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_35 = arg_180_1:GetWordFromCfg(323162042)
				local var_183_36 = arg_180_1:FormatText(var_183_35.content)

				arg_180_1.text_.text = var_183_36

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_37 = 2
				local var_183_38 = utf8.len(var_183_36)
				local var_183_39 = var_183_37 <= 0 and var_183_33 or var_183_33 * (var_183_38 / var_183_37)

				if var_183_39 > 0 and var_183_33 < var_183_39 then
					arg_180_1.talkMaxDuration = var_183_39

					if var_183_39 + var_183_32 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_39 + var_183_32
					end
				end

				arg_180_1.text_.text = var_183_36
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162042", "story_v_out_323162.awb") ~= 0 then
					local var_183_40 = manager.audio:GetVoiceLength("story_v_out_323162", "323162042", "story_v_out_323162.awb") / 1000

					if var_183_40 + var_183_32 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_40 + var_183_32
					end

					if var_183_35.prefab_name ~= "" and arg_180_1.actors_[var_183_35.prefab_name] ~= nil then
						local var_183_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_35.prefab_name].transform, "story_v_out_323162", "323162042", "story_v_out_323162.awb")

						arg_180_1:RecordAudio("323162042", var_183_41)
						arg_180_1:RecordAudio("323162042", var_183_41)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_323162", "323162042", "story_v_out_323162.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_323162", "323162042", "story_v_out_323162.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_42 = math.max(var_183_33, arg_180_1.talkMaxDuration)

			if var_183_32 <= arg_180_1.time_ and arg_180_1.time_ < var_183_32 + var_183_42 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_32) / var_183_42

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_32 + var_183_42 and arg_180_1.time_ < var_183_32 + var_183_42 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play323162043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 323162043
		arg_184_1.duration_ = 15.9

		local var_184_0 = {
			zh = 13.6,
			ja = 15.9
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
				arg_184_0:Play323162044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10039ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect10039ui_story == nil then
				arg_184_1.var_.characterEffect10039ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect10039ui_story and not isNil(var_187_0) then
					arg_184_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect10039ui_story then
				arg_184_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_187_4 = arg_184_1.actors_["10171ui_story"]
			local var_187_5 = 0

			if var_187_5 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 and not isNil(var_187_4) and arg_184_1.var_.characterEffect10171ui_story == nil then
				arg_184_1.var_.characterEffect10171ui_story = var_187_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_6 = 0.200000002980232

			if var_187_5 <= arg_184_1.time_ and arg_184_1.time_ < var_187_5 + var_187_6 and not isNil(var_187_4) then
				local var_187_7 = (arg_184_1.time_ - var_187_5) / var_187_6

				if arg_184_1.var_.characterEffect10171ui_story and not isNil(var_187_4) then
					local var_187_8 = Mathf.Lerp(0, 0.5, var_187_7)

					arg_184_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_184_1.var_.characterEffect10171ui_story.fillRatio = var_187_8
				end
			end

			if arg_184_1.time_ >= var_187_5 + var_187_6 and arg_184_1.time_ < var_187_5 + var_187_6 + arg_187_0 and not isNil(var_187_4) and arg_184_1.var_.characterEffect10171ui_story then
				local var_187_9 = 0.5

				arg_184_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_184_1.var_.characterEffect10171ui_story.fillRatio = var_187_9
			end

			local var_187_10 = 0

			if var_187_10 < arg_184_1.time_ and arg_184_1.time_ <= var_187_10 + arg_187_0 then
				arg_184_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action5_1")
			end

			local var_187_11 = 0

			if var_187_11 < arg_184_1.time_ and arg_184_1.time_ <= var_187_11 + arg_187_0 then
				arg_184_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_187_12 = 0
			local var_187_13 = 1.35

			if var_187_12 < arg_184_1.time_ and arg_184_1.time_ <= var_187_12 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_14 = arg_184_1:FormatText(StoryNameCfg[472].name)

				arg_184_1.leftNameTxt_.text = var_187_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_15 = arg_184_1:GetWordFromCfg(323162043)
				local var_187_16 = arg_184_1:FormatText(var_187_15.content)

				arg_184_1.text_.text = var_187_16

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_17 = 54
				local var_187_18 = utf8.len(var_187_16)
				local var_187_19 = var_187_17 <= 0 and var_187_13 or var_187_13 * (var_187_18 / var_187_17)

				if var_187_19 > 0 and var_187_13 < var_187_19 then
					arg_184_1.talkMaxDuration = var_187_19

					if var_187_19 + var_187_12 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_19 + var_187_12
					end
				end

				arg_184_1.text_.text = var_187_16
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162043", "story_v_out_323162.awb") ~= 0 then
					local var_187_20 = manager.audio:GetVoiceLength("story_v_out_323162", "323162043", "story_v_out_323162.awb") / 1000

					if var_187_20 + var_187_12 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_20 + var_187_12
					end

					if var_187_15.prefab_name ~= "" and arg_184_1.actors_[var_187_15.prefab_name] ~= nil then
						local var_187_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_15.prefab_name].transform, "story_v_out_323162", "323162043", "story_v_out_323162.awb")

						arg_184_1:RecordAudio("323162043", var_187_21)
						arg_184_1:RecordAudio("323162043", var_187_21)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_323162", "323162043", "story_v_out_323162.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_323162", "323162043", "story_v_out_323162.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_22 = math.max(var_187_13, arg_184_1.talkMaxDuration)

			if var_187_12 <= arg_184_1.time_ and arg_184_1.time_ < var_187_12 + var_187_22 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_12) / var_187_22

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_12 + var_187_22 and arg_184_1.time_ < var_187_12 + var_187_22 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play323162044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 323162044
		arg_188_1.duration_ = 3.33

		local var_188_0 = {
			zh = 3.2,
			ja = 3.333
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play323162045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["10171ui_story"]
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect10171ui_story == nil then
				arg_188_1.var_.characterEffect10171ui_story = var_191_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.200000002980232

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 and not isNil(var_191_0) then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2

				if arg_188_1.var_.characterEffect10171ui_story and not isNil(var_191_0) then
					arg_188_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 and not isNil(var_191_0) and arg_188_1.var_.characterEffect10171ui_story then
				arg_188_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_191_4 = arg_188_1.actors_["10039ui_story"]
			local var_191_5 = 0

			if var_191_5 < arg_188_1.time_ and arg_188_1.time_ <= var_191_5 + arg_191_0 and not isNil(var_191_4) and arg_188_1.var_.characterEffect10039ui_story == nil then
				arg_188_1.var_.characterEffect10039ui_story = var_191_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_6 = 0.200000002980232

			if var_191_5 <= arg_188_1.time_ and arg_188_1.time_ < var_191_5 + var_191_6 and not isNil(var_191_4) then
				local var_191_7 = (arg_188_1.time_ - var_191_5) / var_191_6

				if arg_188_1.var_.characterEffect10039ui_story and not isNil(var_191_4) then
					local var_191_8 = Mathf.Lerp(0, 0.5, var_191_7)

					arg_188_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_188_1.var_.characterEffect10039ui_story.fillRatio = var_191_8
				end
			end

			if arg_188_1.time_ >= var_191_5 + var_191_6 and arg_188_1.time_ < var_191_5 + var_191_6 + arg_191_0 and not isNil(var_191_4) and arg_188_1.var_.characterEffect10039ui_story then
				local var_191_9 = 0.5

				arg_188_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_188_1.var_.characterEffect10039ui_story.fillRatio = var_191_9
			end

			local var_191_10 = 0

			if var_191_10 < arg_188_1.time_ and arg_188_1.time_ <= var_191_10 + arg_191_0 then
				arg_188_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			local var_191_11 = 0
			local var_191_12 = 0.25

			if var_191_11 < arg_188_1.time_ and arg_188_1.time_ <= var_191_11 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_13 = arg_188_1:FormatText(StoryNameCfg[1451].name)

				arg_188_1.leftNameTxt_.text = var_191_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_14 = arg_188_1:GetWordFromCfg(323162044)
				local var_191_15 = arg_188_1:FormatText(var_191_14.content)

				arg_188_1.text_.text = var_191_15

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_16 = 10
				local var_191_17 = utf8.len(var_191_15)
				local var_191_18 = var_191_16 <= 0 and var_191_12 or var_191_12 * (var_191_17 / var_191_16)

				if var_191_18 > 0 and var_191_12 < var_191_18 then
					arg_188_1.talkMaxDuration = var_191_18

					if var_191_18 + var_191_11 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_18 + var_191_11
					end
				end

				arg_188_1.text_.text = var_191_15
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162044", "story_v_out_323162.awb") ~= 0 then
					local var_191_19 = manager.audio:GetVoiceLength("story_v_out_323162", "323162044", "story_v_out_323162.awb") / 1000

					if var_191_19 + var_191_11 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_19 + var_191_11
					end

					if var_191_14.prefab_name ~= "" and arg_188_1.actors_[var_191_14.prefab_name] ~= nil then
						local var_191_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_14.prefab_name].transform, "story_v_out_323162", "323162044", "story_v_out_323162.awb")

						arg_188_1:RecordAudio("323162044", var_191_20)
						arg_188_1:RecordAudio("323162044", var_191_20)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_323162", "323162044", "story_v_out_323162.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_323162", "323162044", "story_v_out_323162.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_21 = math.max(var_191_12, arg_188_1.talkMaxDuration)

			if var_191_11 <= arg_188_1.time_ and arg_188_1.time_ < var_191_11 + var_191_21 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_11) / var_191_21

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_11 + var_191_21 and arg_188_1.time_ < var_191_11 + var_191_21 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play323162045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 323162045
		arg_192_1.duration_ = 9.77

		local var_192_0 = {
			zh = 7.1,
			ja = 9.766
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
				arg_192_0:Play323162046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["10039ui_story"]
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect10039ui_story == nil then
				arg_192_1.var_.characterEffect10039ui_story = var_195_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_2 = 0.200000002980232

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_2 and not isNil(var_195_0) then
				local var_195_3 = (arg_192_1.time_ - var_195_1) / var_195_2

				if arg_192_1.var_.characterEffect10039ui_story and not isNil(var_195_0) then
					arg_192_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= var_195_1 + var_195_2 and arg_192_1.time_ < var_195_1 + var_195_2 + arg_195_0 and not isNil(var_195_0) and arg_192_1.var_.characterEffect10039ui_story then
				arg_192_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_195_4 = arg_192_1.actors_["10171ui_story"]
			local var_195_5 = 0

			if var_195_5 < arg_192_1.time_ and arg_192_1.time_ <= var_195_5 + arg_195_0 and not isNil(var_195_4) and arg_192_1.var_.characterEffect10171ui_story == nil then
				arg_192_1.var_.characterEffect10171ui_story = var_195_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_6 = 0.200000002980232

			if var_195_5 <= arg_192_1.time_ and arg_192_1.time_ < var_195_5 + var_195_6 and not isNil(var_195_4) then
				local var_195_7 = (arg_192_1.time_ - var_195_5) / var_195_6

				if arg_192_1.var_.characterEffect10171ui_story and not isNil(var_195_4) then
					local var_195_8 = Mathf.Lerp(0, 0.5, var_195_7)

					arg_192_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_192_1.var_.characterEffect10171ui_story.fillRatio = var_195_8
				end
			end

			if arg_192_1.time_ >= var_195_5 + var_195_6 and arg_192_1.time_ < var_195_5 + var_195_6 + arg_195_0 and not isNil(var_195_4) and arg_192_1.var_.characterEffect10171ui_story then
				local var_195_9 = 0.5

				arg_192_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_192_1.var_.characterEffect10171ui_story.fillRatio = var_195_9
			end

			local var_195_10 = 0
			local var_195_11 = 0.8

			if var_195_10 < arg_192_1.time_ and arg_192_1.time_ <= var_195_10 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_12 = arg_192_1:FormatText(StoryNameCfg[472].name)

				arg_192_1.leftNameTxt_.text = var_195_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_13 = arg_192_1:GetWordFromCfg(323162045)
				local var_195_14 = arg_192_1:FormatText(var_195_13.content)

				arg_192_1.text_.text = var_195_14

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_15 = 32
				local var_195_16 = utf8.len(var_195_14)
				local var_195_17 = var_195_15 <= 0 and var_195_11 or var_195_11 * (var_195_16 / var_195_15)

				if var_195_17 > 0 and var_195_11 < var_195_17 then
					arg_192_1.talkMaxDuration = var_195_17

					if var_195_17 + var_195_10 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_17 + var_195_10
					end
				end

				arg_192_1.text_.text = var_195_14
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162045", "story_v_out_323162.awb") ~= 0 then
					local var_195_18 = manager.audio:GetVoiceLength("story_v_out_323162", "323162045", "story_v_out_323162.awb") / 1000

					if var_195_18 + var_195_10 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_18 + var_195_10
					end

					if var_195_13.prefab_name ~= "" and arg_192_1.actors_[var_195_13.prefab_name] ~= nil then
						local var_195_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_13.prefab_name].transform, "story_v_out_323162", "323162045", "story_v_out_323162.awb")

						arg_192_1:RecordAudio("323162045", var_195_19)
						arg_192_1:RecordAudio("323162045", var_195_19)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_323162", "323162045", "story_v_out_323162.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_323162", "323162045", "story_v_out_323162.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_20 = math.max(var_195_11, arg_192_1.talkMaxDuration)

			if var_195_10 <= arg_192_1.time_ and arg_192_1.time_ < var_195_10 + var_195_20 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_10) / var_195_20

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_10 + var_195_20 and arg_192_1.time_ < var_195_10 + var_195_20 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play323162046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 323162046
		arg_196_1.duration_ = 11.03

		local var_196_0 = {
			zh = 9.733,
			ja = 11.033
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play323162047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				arg_196_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action5_2")
			end

			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_199_2 = 0
			local var_199_3 = 0.975

			if var_199_2 < arg_196_1.time_ and arg_196_1.time_ <= var_199_2 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_4 = arg_196_1:FormatText(StoryNameCfg[472].name)

				arg_196_1.leftNameTxt_.text = var_199_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_5 = arg_196_1:GetWordFromCfg(323162046)
				local var_199_6 = arg_196_1:FormatText(var_199_5.content)

				arg_196_1.text_.text = var_199_6

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_7 = 39
				local var_199_8 = utf8.len(var_199_6)
				local var_199_9 = var_199_7 <= 0 and var_199_3 or var_199_3 * (var_199_8 / var_199_7)

				if var_199_9 > 0 and var_199_3 < var_199_9 then
					arg_196_1.talkMaxDuration = var_199_9

					if var_199_9 + var_199_2 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_9 + var_199_2
					end
				end

				arg_196_1.text_.text = var_199_6
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162046", "story_v_out_323162.awb") ~= 0 then
					local var_199_10 = manager.audio:GetVoiceLength("story_v_out_323162", "323162046", "story_v_out_323162.awb") / 1000

					if var_199_10 + var_199_2 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_10 + var_199_2
					end

					if var_199_5.prefab_name ~= "" and arg_196_1.actors_[var_199_5.prefab_name] ~= nil then
						local var_199_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_5.prefab_name].transform, "story_v_out_323162", "323162046", "story_v_out_323162.awb")

						arg_196_1:RecordAudio("323162046", var_199_11)
						arg_196_1:RecordAudio("323162046", var_199_11)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_323162", "323162046", "story_v_out_323162.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_323162", "323162046", "story_v_out_323162.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_12 = math.max(var_199_3, arg_196_1.talkMaxDuration)

			if var_199_2 <= arg_196_1.time_ and arg_196_1.time_ < var_199_2 + var_199_12 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_2) / var_199_12

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_2 + var_199_12 and arg_196_1.time_ < var_199_2 + var_199_12 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play323162047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 323162047
		arg_200_1.duration_ = 16.97

		local var_200_0 = {
			zh = 13.266,
			ja = 16.966
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play323162048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0
			local var_203_1 = 1.35

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_2 = arg_200_1:FormatText(StoryNameCfg[472].name)

				arg_200_1.leftNameTxt_.text = var_203_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_3 = arg_200_1:GetWordFromCfg(323162047)
				local var_203_4 = arg_200_1:FormatText(var_203_3.content)

				arg_200_1.text_.text = var_203_4

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_5 = 54
				local var_203_6 = utf8.len(var_203_4)
				local var_203_7 = var_203_5 <= 0 and var_203_1 or var_203_1 * (var_203_6 / var_203_5)

				if var_203_7 > 0 and var_203_1 < var_203_7 then
					arg_200_1.talkMaxDuration = var_203_7

					if var_203_7 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_7 + var_203_0
					end
				end

				arg_200_1.text_.text = var_203_4
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162047", "story_v_out_323162.awb") ~= 0 then
					local var_203_8 = manager.audio:GetVoiceLength("story_v_out_323162", "323162047", "story_v_out_323162.awb") / 1000

					if var_203_8 + var_203_0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_8 + var_203_0
					end

					if var_203_3.prefab_name ~= "" and arg_200_1.actors_[var_203_3.prefab_name] ~= nil then
						local var_203_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_3.prefab_name].transform, "story_v_out_323162", "323162047", "story_v_out_323162.awb")

						arg_200_1:RecordAudio("323162047", var_203_9)
						arg_200_1:RecordAudio("323162047", var_203_9)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_323162", "323162047", "story_v_out_323162.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_323162", "323162047", "story_v_out_323162.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_10 = math.max(var_203_1, arg_200_1.talkMaxDuration)

			if var_203_0 <= arg_200_1.time_ and arg_200_1.time_ < var_203_0 + var_203_10 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_0) / var_203_10

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_0 + var_203_10 and arg_200_1.time_ < var_203_0 + var_203_10 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play323162048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 323162048
		arg_204_1.duration_ = 21.2

		local var_204_0 = {
			zh = 15.133,
			ja = 21.2
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
				arg_204_0:Play323162049(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0

			if var_207_0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_0 + arg_207_0 then
				arg_204_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_1")
			end

			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 then
				arg_204_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_207_2 = 0
			local var_207_3 = 1.35

			if var_207_2 < arg_204_1.time_ and arg_204_1.time_ <= var_207_2 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_4 = arg_204_1:FormatText(StoryNameCfg[472].name)

				arg_204_1.leftNameTxt_.text = var_207_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_5 = arg_204_1:GetWordFromCfg(323162048)
				local var_207_6 = arg_204_1:FormatText(var_207_5.content)

				arg_204_1.text_.text = var_207_6

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_7 = 54
				local var_207_8 = utf8.len(var_207_6)
				local var_207_9 = var_207_7 <= 0 and var_207_3 or var_207_3 * (var_207_8 / var_207_7)

				if var_207_9 > 0 and var_207_3 < var_207_9 then
					arg_204_1.talkMaxDuration = var_207_9

					if var_207_9 + var_207_2 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_9 + var_207_2
					end
				end

				arg_204_1.text_.text = var_207_6
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162048", "story_v_out_323162.awb") ~= 0 then
					local var_207_10 = manager.audio:GetVoiceLength("story_v_out_323162", "323162048", "story_v_out_323162.awb") / 1000

					if var_207_10 + var_207_2 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_10 + var_207_2
					end

					if var_207_5.prefab_name ~= "" and arg_204_1.actors_[var_207_5.prefab_name] ~= nil then
						local var_207_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_5.prefab_name].transform, "story_v_out_323162", "323162048", "story_v_out_323162.awb")

						arg_204_1:RecordAudio("323162048", var_207_11)
						arg_204_1:RecordAudio("323162048", var_207_11)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_323162", "323162048", "story_v_out_323162.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_323162", "323162048", "story_v_out_323162.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_12 = math.max(var_207_3, arg_204_1.talkMaxDuration)

			if var_207_2 <= arg_204_1.time_ and arg_204_1.time_ < var_207_2 + var_207_12 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_2) / var_207_12

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_2 + var_207_12 and arg_204_1.time_ < var_207_2 + var_207_12 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play323162049 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 323162049
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play323162050(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["10171ui_story"].transform
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.var_.moveOldPos10171ui_story = var_211_0.localPosition

				local var_211_2 = GameObjectTools.GetOrAddComponent(var_211_0.gameObject, typeof(DynamicBoneHelper))

				if var_211_2 then
					var_211_2:EnableDynamicBone(false)
				end
			end

			local var_211_3 = 0.001

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_3 then
				local var_211_4 = (arg_208_1.time_ - var_211_1) / var_211_3
				local var_211_5 = Vector3.New(0, 100, 0)

				var_211_0.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10171ui_story, var_211_5, var_211_4)

				local var_211_6 = manager.ui.mainCamera.transform.position - var_211_0.position

				var_211_0.forward = Vector3.New(var_211_6.x, var_211_6.y, var_211_6.z)

				local var_211_7 = var_211_0.localEulerAngles

				var_211_7.z = 0
				var_211_7.x = 0
				var_211_0.localEulerAngles = var_211_7
			end

			if arg_208_1.time_ >= var_211_1 + var_211_3 and arg_208_1.time_ < var_211_1 + var_211_3 + arg_211_0 then
				var_211_0.localPosition = Vector3.New(0, 100, 0)

				local var_211_8 = manager.ui.mainCamera.transform.position - var_211_0.position

				var_211_0.forward = Vector3.New(var_211_8.x, var_211_8.y, var_211_8.z)

				local var_211_9 = var_211_0.localEulerAngles

				var_211_9.z = 0
				var_211_9.x = 0
				var_211_0.localEulerAngles = var_211_9

				local var_211_10 = GameObjectTools.GetOrAddComponent(var_211_0.gameObject, typeof(DynamicBoneHelper))

				if var_211_10 then
					var_211_10:EnableDynamicBone(true)
				end
			end

			local var_211_11 = arg_208_1.actors_["10039ui_story"].transform
			local var_211_12 = 0

			if var_211_12 < arg_208_1.time_ and arg_208_1.time_ <= var_211_12 + arg_211_0 then
				arg_208_1.var_.moveOldPos10039ui_story = var_211_11.localPosition
			end

			local var_211_13 = 0.001

			if var_211_12 <= arg_208_1.time_ and arg_208_1.time_ < var_211_12 + var_211_13 then
				local var_211_14 = (arg_208_1.time_ - var_211_12) / var_211_13
				local var_211_15 = Vector3.New(0, 100, 0)

				var_211_11.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10039ui_story, var_211_15, var_211_14)

				local var_211_16 = manager.ui.mainCamera.transform.position - var_211_11.position

				var_211_11.forward = Vector3.New(var_211_16.x, var_211_16.y, var_211_16.z)

				local var_211_17 = var_211_11.localEulerAngles

				var_211_17.z = 0
				var_211_17.x = 0
				var_211_11.localEulerAngles = var_211_17
			end

			if arg_208_1.time_ >= var_211_12 + var_211_13 and arg_208_1.time_ < var_211_12 + var_211_13 + arg_211_0 then
				var_211_11.localPosition = Vector3.New(0, 100, 0)

				local var_211_18 = manager.ui.mainCamera.transform.position - var_211_11.position

				var_211_11.forward = Vector3.New(var_211_18.x, var_211_18.y, var_211_18.z)

				local var_211_19 = var_211_11.localEulerAngles

				var_211_19.z = 0
				var_211_19.x = 0
				var_211_11.localEulerAngles = var_211_19
			end

			local var_211_20 = arg_208_1.actors_["10039ui_story"]
			local var_211_21 = 0

			if var_211_21 < arg_208_1.time_ and arg_208_1.time_ <= var_211_21 + arg_211_0 and not isNil(var_211_20) and arg_208_1.var_.characterEffect10039ui_story == nil then
				arg_208_1.var_.characterEffect10039ui_story = var_211_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_22 = 0.200000002980232

			if var_211_21 <= arg_208_1.time_ and arg_208_1.time_ < var_211_21 + var_211_22 and not isNil(var_211_20) then
				local var_211_23 = (arg_208_1.time_ - var_211_21) / var_211_22

				if arg_208_1.var_.characterEffect10039ui_story and not isNil(var_211_20) then
					local var_211_24 = Mathf.Lerp(0, 0.5, var_211_23)

					arg_208_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_208_1.var_.characterEffect10039ui_story.fillRatio = var_211_24
				end
			end

			if arg_208_1.time_ >= var_211_21 + var_211_22 and arg_208_1.time_ < var_211_21 + var_211_22 + arg_211_0 and not isNil(var_211_20) and arg_208_1.var_.characterEffect10039ui_story then
				local var_211_25 = 0.5

				arg_208_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_208_1.var_.characterEffect10039ui_story.fillRatio = var_211_25
			end

			local var_211_26 = 0.533333333333333
			local var_211_27 = 1

			if var_211_26 < arg_208_1.time_ and arg_208_1.time_ <= var_211_26 + arg_211_0 then
				local var_211_28 = "play"
				local var_211_29 = "effect"

				arg_208_1:AudioAction(var_211_28, var_211_29, "se_story_148", "se_story_148_whoosh01", "")
			end

			local var_211_30 = 0
			local var_211_31 = 0.825

			if var_211_30 < arg_208_1.time_ and arg_208_1.time_ <= var_211_30 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, false)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_32 = arg_208_1:GetWordFromCfg(323162049)
				local var_211_33 = arg_208_1:FormatText(var_211_32.content)

				arg_208_1.text_.text = var_211_33

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_34 = 33
				local var_211_35 = utf8.len(var_211_33)
				local var_211_36 = var_211_34 <= 0 and var_211_31 or var_211_31 * (var_211_35 / var_211_34)

				if var_211_36 > 0 and var_211_31 < var_211_36 then
					arg_208_1.talkMaxDuration = var_211_36

					if var_211_36 + var_211_30 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_36 + var_211_30
					end
				end

				arg_208_1.text_.text = var_211_33
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_37 = math.max(var_211_31, arg_208_1.talkMaxDuration)

			if var_211_30 <= arg_208_1.time_ and arg_208_1.time_ < var_211_30 + var_211_37 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_30) / var_211_37

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_30 + var_211_37 and arg_208_1.time_ < var_211_30 + var_211_37 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10039ui_story",
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
	Play323162050 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 323162050
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play323162051(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0
			local var_215_1 = 1.325

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

				local var_215_2 = arg_212_1:GetWordFromCfg(323162050)
				local var_215_3 = arg_212_1:FormatText(var_215_2.content)

				arg_212_1.text_.text = var_215_3

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_4 = 53
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
	Play323162051 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 323162051
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play323162052(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 0.333333333333333
			local var_219_1 = 1

			if var_219_0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_0 + arg_219_0 then
				local var_219_2 = "play"
				local var_219_3 = "effect"

				arg_216_1:AudioAction(var_219_2, var_219_3, "se_story_144", "se_story_144_footstep01", "")
			end

			local var_219_4 = 0
			local var_219_5 = 1.05

			if var_219_4 < arg_216_1.time_ and arg_216_1.time_ <= var_219_4 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_6 = arg_216_1:GetWordFromCfg(323162051)
				local var_219_7 = arg_216_1:FormatText(var_219_6.content)

				arg_216_1.text_.text = var_219_7

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_8 = 42
				local var_219_9 = utf8.len(var_219_7)
				local var_219_10 = var_219_8 <= 0 and var_219_5 or var_219_5 * (var_219_9 / var_219_8)

				if var_219_10 > 0 and var_219_5 < var_219_10 then
					arg_216_1.talkMaxDuration = var_219_10

					if var_219_10 + var_219_4 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_10 + var_219_4
					end
				end

				arg_216_1.text_.text = var_219_7
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_11 = math.max(var_219_5, arg_216_1.talkMaxDuration)

			if var_219_4 <= arg_216_1.time_ and arg_216_1.time_ < var_219_4 + var_219_11 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_4) / var_219_11

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_4 + var_219_11 and arg_216_1.time_ < var_219_4 + var_219_11 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play323162052 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 323162052
		arg_220_1.duration_ = 6.33

		local var_220_0 = {
			zh = 4.4,
			ja = 6.333
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
			arg_220_1.auto_ = false
		end

		function arg_220_1.playNext_(arg_222_0)
			arg_220_1.onStoryFinished_()
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["10171ui_story"]
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect10171ui_story == nil then
				arg_220_1.var_.characterEffect10171ui_story = var_223_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_2 = 0.200000002980232

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_2 and not isNil(var_223_0) then
				local var_223_3 = (arg_220_1.time_ - var_223_1) / var_223_2

				if arg_220_1.var_.characterEffect10171ui_story and not isNil(var_223_0) then
					arg_220_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= var_223_1 + var_223_2 and arg_220_1.time_ < var_223_1 + var_223_2 + arg_223_0 and not isNil(var_223_0) and arg_220_1.var_.characterEffect10171ui_story then
				arg_220_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_223_4 = 0
			local var_223_5 = 0.525

			if var_223_4 < arg_220_1.time_ and arg_220_1.time_ <= var_223_4 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_6 = arg_220_1:FormatText(StoryNameCfg[1451].name)

				arg_220_1.leftNameTxt_.text = var_223_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10171")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_7 = arg_220_1:GetWordFromCfg(323162052)
				local var_223_8 = arg_220_1:FormatText(var_223_7.content)

				arg_220_1.text_.text = var_223_8

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_9 = 21
				local var_223_10 = utf8.len(var_223_8)
				local var_223_11 = var_223_9 <= 0 and var_223_5 or var_223_5 * (var_223_10 / var_223_9)

				if var_223_11 > 0 and var_223_5 < var_223_11 then
					arg_220_1.talkMaxDuration = var_223_11

					if var_223_11 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_11 + var_223_4
					end
				end

				arg_220_1.text_.text = var_223_8
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_323162", "323162052", "story_v_out_323162.awb") ~= 0 then
					local var_223_12 = manager.audio:GetVoiceLength("story_v_out_323162", "323162052", "story_v_out_323162.awb") / 1000

					if var_223_12 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_12 + var_223_4
					end

					if var_223_7.prefab_name ~= "" and arg_220_1.actors_[var_223_7.prefab_name] ~= nil then
						local var_223_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_7.prefab_name].transform, "story_v_out_323162", "323162052", "story_v_out_323162.awb")

						arg_220_1:RecordAudio("323162052", var_223_13)
						arg_220_1:RecordAudio("323162052", var_223_13)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_323162", "323162052", "story_v_out_323162.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_323162", "323162052", "story_v_out_323162.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_14 = math.max(var_223_5, arg_220_1.talkMaxDuration)

			if var_223_4 <= arg_220_1.time_ and arg_220_1.time_ < var_223_4 + var_223_14 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_4) / var_223_14

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_4 + var_223_14 and arg_220_1.time_ < var_223_4 + var_223_14 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J22f",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_323162.awb"
	}
}
