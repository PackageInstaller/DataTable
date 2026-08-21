return {
	Play410172001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410172001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play410172002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L04g"

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
				local var_4_5 = arg_1_1.bgs_.L04g

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
					if iter_4_0 ~= "L04g" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

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
			local var_4_23 = 0.166666666666667

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = ""
				local var_4_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_27 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_27 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_27

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_27
						arg_1_1.bgmTxt2_.text = var_4_27
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

			local var_4_28 = 0.3
			local var_4_29 = 1

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building")

				if var_4_33 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_33 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_33

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_33
						arg_1_1.bgmTxt2_.text = var_4_33
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_34 = 2
			local var_4_35 = 0.925

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_36 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_36:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_37 = arg_1_1:GetWordFromCfg(410172001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 37
				local var_4_40 = utf8.len(var_4_38)
				local var_4_41 = var_4_39 <= 0 and var_4_35 or var_4_35 * (var_4_40 / var_4_39)

				if var_4_41 > 0 and var_4_35 < var_4_41 then
					arg_1_1.talkMaxDuration = var_4_41
					var_4_34 = var_4_34 + 0.3

					if var_4_41 + var_4_34 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_41 + var_4_34
					end
				end

				arg_1_1.text_.text = var_4_38
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_42 = var_4_34 + 0.3
			local var_4_43 = math.max(var_4_35, arg_1_1.talkMaxDuration)

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_42) / var_4_43

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play410172002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410172002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play410172003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.45

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_2 = arg_9_1:GetWordFromCfg(410172002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 58
				local var_12_5 = utf8.len(var_12_3)
				local var_12_6 = var_12_4 <= 0 and var_12_1 or var_12_1 * (var_12_5 / var_12_4)

				if var_12_6 > 0 and var_12_1 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_0
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_1, arg_9_1.talkMaxDuration)

			if var_12_0 <= arg_9_1.time_ and arg_9_1.time_ < var_12_0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_0 + var_12_7 and arg_9_1.time_ < var_12_0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play410172003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410172003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play410172004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.925

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(410172003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 37
				local var_16_5 = utf8.len(var_16_3)
				local var_16_6 = var_16_4 <= 0 and var_16_1 or var_16_1 * (var_16_5 / var_16_4)

				if var_16_6 > 0 and var_16_1 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_7 and arg_13_1.time_ < var_16_0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play410172004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410172004
		arg_17_1.duration_ = 7.4

		local var_17_0 = {
			ja = 7.4,
			CriLanguages = 6.266,
			zh = 6.266
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
				arg_17_0:Play410172005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "1061"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1061")

				if not isNil(var_20_1) then
					local var_20_2 = Object.Instantiate(var_20_1, arg_17_1.canvasGo_.transform)

					var_20_2.transform:SetSiblingIndex(1)

					var_20_2.name = var_20_0
					var_20_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_[var_20_0] = var_20_2

					local var_20_3 = var_20_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_17_1.isInRecall_ then
						for iter_20_0, iter_20_1 in ipairs(var_20_3) do
							iter_20_1.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_4 = arg_17_1.actors_["1061"].transform
			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.var_.moveOldPos1061 = var_20_4.localPosition
				var_20_4.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("1061", 2)

				local var_20_6 = var_20_4.childCount

				for iter_20_2 = 0, var_20_6 - 1 do
					local var_20_7 = var_20_4:GetChild(iter_20_2)

					if var_20_7.name == "split_5" or not string.find(var_20_7.name, "split") then
						var_20_7.gameObject:SetActive(true)
					else
						var_20_7.gameObject:SetActive(false)
					end
				end
			end

			local var_20_8 = 0.001

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_8 then
				local var_20_9 = (arg_17_1.time_ - var_20_5) / var_20_8
				local var_20_10 = Vector3.New(-390, -490, 18)

				var_20_4.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1061, var_20_10, var_20_9)
			end

			if arg_17_1.time_ >= var_20_5 + var_20_8 and arg_17_1.time_ < var_20_5 + var_20_8 + arg_20_0 then
				var_20_4.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_20_11 = "10059"

			if arg_17_1.actors_[var_20_11] == nil then
				local var_20_12 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10059")

				if not isNil(var_20_12) then
					local var_20_13 = Object.Instantiate(var_20_12, arg_17_1.canvasGo_.transform)

					var_20_13.transform:SetSiblingIndex(1)

					var_20_13.name = var_20_11
					var_20_13.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_17_1.actors_[var_20_11] = var_20_13

					local var_20_14 = var_20_13:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_17_1.isInRecall_ then
						for iter_20_3, iter_20_4 in ipairs(var_20_14) do
							iter_20_4.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_20_15 = arg_17_1.actors_["10059"].transform
			local var_20_16 = 0

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1.var_.moveOldPos10059 = var_20_15.localPosition
				var_20_15.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10059", 4)

				local var_20_17 = var_20_15.childCount

				for iter_20_5 = 0, var_20_17 - 1 do
					local var_20_18 = var_20_15:GetChild(iter_20_5)

					if var_20_18.name == "" or not string.find(var_20_18.name, "split") then
						var_20_18.gameObject:SetActive(true)
					else
						var_20_18.gameObject:SetActive(false)
					end
				end
			end

			local var_20_19 = 0.001

			if var_20_16 <= arg_17_1.time_ and arg_17_1.time_ < var_20_16 + var_20_19 then
				local var_20_20 = (arg_17_1.time_ - var_20_16) / var_20_19
				local var_20_21 = Vector3.New(390, -530, 35)

				var_20_15.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10059, var_20_21, var_20_20)
			end

			if arg_17_1.time_ >= var_20_16 + var_20_19 and arg_17_1.time_ < var_20_16 + var_20_19 + arg_20_0 then
				var_20_15.localPosition = Vector3.New(390, -530, 35)
			end

			local var_20_22 = arg_17_1.actors_["1061"]
			local var_20_23 = 0

			if var_20_23 < arg_17_1.time_ and arg_17_1.time_ <= var_20_23 + arg_20_0 and not isNil(var_20_22) and arg_17_1.var_.actorSpriteComps1061 == nil then
				arg_17_1.var_.actorSpriteComps1061 = var_20_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_24 = 0.034

			if var_20_23 <= arg_17_1.time_ and arg_17_1.time_ < var_20_23 + var_20_24 and not isNil(var_20_22) then
				local var_20_25 = (arg_17_1.time_ - var_20_23) / var_20_24

				if arg_17_1.var_.actorSpriteComps1061 then
					for iter_20_6, iter_20_7 in pairs(arg_17_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_20_7 then
							if arg_17_1.isInRecall_ then
								local var_20_26 = Mathf.Lerp(iter_20_7.color.r, arg_17_1.hightColor1.r, var_20_25)
								local var_20_27 = Mathf.Lerp(iter_20_7.color.g, arg_17_1.hightColor1.g, var_20_25)
								local var_20_28 = Mathf.Lerp(iter_20_7.color.b, arg_17_1.hightColor1.b, var_20_25)

								iter_20_7.color = Color.New(var_20_26, var_20_27, var_20_28)
							else
								local var_20_29 = Mathf.Lerp(iter_20_7.color.r, 1, var_20_25)

								iter_20_7.color = Color.New(var_20_29, var_20_29, var_20_29)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_23 + var_20_24 and arg_17_1.time_ < var_20_23 + var_20_24 + arg_20_0 and not isNil(var_20_22) and arg_17_1.var_.actorSpriteComps1061 then
				for iter_20_8, iter_20_9 in pairs(arg_17_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_20_9 then
						if arg_17_1.isInRecall_ then
							iter_20_9.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps1061 = nil
			end

			local var_20_30 = arg_17_1.actors_["10059"]
			local var_20_31 = 0

			if var_20_31 < arg_17_1.time_ and arg_17_1.time_ <= var_20_31 + arg_20_0 and not isNil(var_20_30) and arg_17_1.var_.actorSpriteComps10059 == nil then
				arg_17_1.var_.actorSpriteComps10059 = var_20_30:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_32 = 0.034

			if var_20_31 <= arg_17_1.time_ and arg_17_1.time_ < var_20_31 + var_20_32 and not isNil(var_20_30) then
				local var_20_33 = (arg_17_1.time_ - var_20_31) / var_20_32

				if arg_17_1.var_.actorSpriteComps10059 then
					for iter_20_10, iter_20_11 in pairs(arg_17_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_20_11 then
							if arg_17_1.isInRecall_ then
								local var_20_34 = Mathf.Lerp(iter_20_11.color.r, arg_17_1.hightColor2.r, var_20_33)
								local var_20_35 = Mathf.Lerp(iter_20_11.color.g, arg_17_1.hightColor2.g, var_20_33)
								local var_20_36 = Mathf.Lerp(iter_20_11.color.b, arg_17_1.hightColor2.b, var_20_33)

								iter_20_11.color = Color.New(var_20_34, var_20_35, var_20_36)
							else
								local var_20_37 = Mathf.Lerp(iter_20_11.color.r, 0.5, var_20_33)

								iter_20_11.color = Color.New(var_20_37, var_20_37, var_20_37)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_31 + var_20_32 and arg_17_1.time_ < var_20_31 + var_20_32 + arg_20_0 and not isNil(var_20_30) and arg_17_1.var_.actorSpriteComps10059 then
				for iter_20_12, iter_20_13 in pairs(arg_17_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_20_13 then
						if arg_17_1.isInRecall_ then
							iter_20_13.color = arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_20_13.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10059 = nil
			end

			local var_20_38 = 0
			local var_20_39 = 0.85

			if var_20_38 < arg_17_1.time_ and arg_17_1.time_ <= var_20_38 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_40 = arg_17_1:FormatText(StoryNameCfg[612].name)

				arg_17_1.leftNameTxt_.text = var_20_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_41 = arg_17_1:GetWordFromCfg(410172004)
				local var_20_42 = arg_17_1:FormatText(var_20_41.content)

				arg_17_1.text_.text = var_20_42

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_43 = 34
				local var_20_44 = utf8.len(var_20_42)
				local var_20_45 = var_20_43 <= 0 and var_20_39 or var_20_39 * (var_20_44 / var_20_43)

				if var_20_45 > 0 and var_20_39 < var_20_45 then
					arg_17_1.talkMaxDuration = var_20_45

					if var_20_45 + var_20_38 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_45 + var_20_38
					end
				end

				arg_17_1.text_.text = var_20_42
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172004", "story_v_out_410172.awb") ~= 0 then
					local var_20_46 = manager.audio:GetVoiceLength("story_v_out_410172", "410172004", "story_v_out_410172.awb") / 1000

					if var_20_46 + var_20_38 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_46 + var_20_38
					end

					if var_20_41.prefab_name ~= "" and arg_17_1.actors_[var_20_41.prefab_name] ~= nil then
						local var_20_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_41.prefab_name].transform, "story_v_out_410172", "410172004", "story_v_out_410172.awb")

						arg_17_1:RecordAudio("410172004", var_20_47)
						arg_17_1:RecordAudio("410172004", var_20_47)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_410172", "410172004", "story_v_out_410172.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_410172", "410172004", "story_v_out_410172.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_48 = math.max(var_20_39, arg_17_1.talkMaxDuration)

			if var_20_38 <= arg_17_1.time_ and arg_17_1.time_ < var_20_38 + var_20_48 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_38) / var_20_48

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_38 + var_20_48 and arg_17_1.time_ < var_20_38 + var_20_48 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play410172005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410172005
		arg_21_1.duration_ = 5.1

		local var_21_0 = {
			ja = 4.6,
			CriLanguages = 5.1,
			zh = 5.1
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
				arg_21_0:Play410172006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1061"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1061 = var_24_0.localPosition
				var_24_0.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1061", 2)

				local var_24_2 = var_24_0.childCount

				for iter_24_0 = 0, var_24_2 - 1 do
					local var_24_3 = var_24_0:GetChild(iter_24_0)

					if var_24_3.name == "" or not string.find(var_24_3.name, "split") then
						var_24_3.gameObject:SetActive(true)
					else
						var_24_3.gameObject:SetActive(false)
					end
				end
			end

			local var_24_4 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_4 then
				local var_24_5 = (arg_21_1.time_ - var_24_1) / var_24_4
				local var_24_6 = Vector3.New(-390, -490, 18)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1061, var_24_6, var_24_5)
			end

			if arg_21_1.time_ >= var_24_1 + var_24_4 and arg_21_1.time_ < var_24_1 + var_24_4 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_24_7 = arg_21_1.actors_["1061"]
			local var_24_8 = 0

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 and not isNil(var_24_7) and arg_21_1.var_.actorSpriteComps1061 == nil then
				arg_21_1.var_.actorSpriteComps1061 = var_24_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_9 = 0.034

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_9 and not isNil(var_24_7) then
				local var_24_10 = (arg_21_1.time_ - var_24_8) / var_24_9

				if arg_21_1.var_.actorSpriteComps1061 then
					for iter_24_1, iter_24_2 in pairs(arg_21_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_24_2 then
							if arg_21_1.isInRecall_ then
								local var_24_11 = Mathf.Lerp(iter_24_2.color.r, arg_21_1.hightColor1.r, var_24_10)
								local var_24_12 = Mathf.Lerp(iter_24_2.color.g, arg_21_1.hightColor1.g, var_24_10)
								local var_24_13 = Mathf.Lerp(iter_24_2.color.b, arg_21_1.hightColor1.b, var_24_10)

								iter_24_2.color = Color.New(var_24_11, var_24_12, var_24_13)
							else
								local var_24_14 = Mathf.Lerp(iter_24_2.color.r, 1, var_24_10)

								iter_24_2.color = Color.New(var_24_14, var_24_14, var_24_14)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= var_24_8 + var_24_9 and arg_21_1.time_ < var_24_8 + var_24_9 + arg_24_0 and not isNil(var_24_7) and arg_21_1.var_.actorSpriteComps1061 then
				for iter_24_3, iter_24_4 in pairs(arg_21_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_24_4 then
						if arg_21_1.isInRecall_ then
							iter_24_4.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_24_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_21_1.var_.actorSpriteComps1061 = nil
			end

			local var_24_15 = 0
			local var_24_16 = 0.625

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_17 = arg_21_1:FormatText(StoryNameCfg[612].name)

				arg_21_1.leftNameTxt_.text = var_24_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_18 = arg_21_1:GetWordFromCfg(410172005)
				local var_24_19 = arg_21_1:FormatText(var_24_18.content)

				arg_21_1.text_.text = var_24_19

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_20 = 25
				local var_24_21 = utf8.len(var_24_19)
				local var_24_22 = var_24_20 <= 0 and var_24_16 or var_24_16 * (var_24_21 / var_24_20)

				if var_24_22 > 0 and var_24_16 < var_24_22 then
					arg_21_1.talkMaxDuration = var_24_22

					if var_24_22 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_22 + var_24_15
					end
				end

				arg_21_1.text_.text = var_24_19
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172005", "story_v_out_410172.awb") ~= 0 then
					local var_24_23 = manager.audio:GetVoiceLength("story_v_out_410172", "410172005", "story_v_out_410172.awb") / 1000

					if var_24_23 + var_24_15 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_23 + var_24_15
					end

					if var_24_18.prefab_name ~= "" and arg_21_1.actors_[var_24_18.prefab_name] ~= nil then
						local var_24_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_18.prefab_name].transform, "story_v_out_410172", "410172005", "story_v_out_410172.awb")

						arg_21_1:RecordAudio("410172005", var_24_24)
						arg_21_1:RecordAudio("410172005", var_24_24)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410172", "410172005", "story_v_out_410172.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410172", "410172005", "story_v_out_410172.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_25 = math.max(var_24_16, arg_21_1.talkMaxDuration)

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_25 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_15) / var_24_25

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_15 + var_24_25 and arg_21_1.time_ < var_24_15 + var_24_25 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play410172006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410172006
		arg_25_1.duration_ = 10

		local var_25_0 = {
			ja = 10,
			CriLanguages = 7.566,
			zh = 7.566
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
				arg_25_0:Play410172007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["10059"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos10059 = var_28_0.localPosition
				var_28_0.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10059", 4)

				local var_28_2 = var_28_0.childCount

				for iter_28_0 = 0, var_28_2 - 1 do
					local var_28_3 = var_28_0:GetChild(iter_28_0)

					if var_28_3.name == "split_2" or not string.find(var_28_3.name, "split") then
						var_28_3.gameObject:SetActive(true)
					else
						var_28_3.gameObject:SetActive(false)
					end
				end
			end

			local var_28_4 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_4 then
				local var_28_5 = (arg_25_1.time_ - var_28_1) / var_28_4
				local var_28_6 = Vector3.New(390, -530, 35)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10059, var_28_6, var_28_5)
			end

			if arg_25_1.time_ >= var_28_1 + var_28_4 and arg_25_1.time_ < var_28_1 + var_28_4 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_28_7 = arg_25_1.actors_["10059"]
			local var_28_8 = 0

			if var_28_8 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps10059 == nil then
				arg_25_1.var_.actorSpriteComps10059 = var_28_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_9 = 0.034

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_9 and not isNil(var_28_7) then
				local var_28_10 = (arg_25_1.time_ - var_28_8) / var_28_9

				if arg_25_1.var_.actorSpriteComps10059 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_28_2 then
							if arg_25_1.isInRecall_ then
								local var_28_11 = Mathf.Lerp(iter_28_2.color.r, arg_25_1.hightColor1.r, var_28_10)
								local var_28_12 = Mathf.Lerp(iter_28_2.color.g, arg_25_1.hightColor1.g, var_28_10)
								local var_28_13 = Mathf.Lerp(iter_28_2.color.b, arg_25_1.hightColor1.b, var_28_10)

								iter_28_2.color = Color.New(var_28_11, var_28_12, var_28_13)
							else
								local var_28_14 = Mathf.Lerp(iter_28_2.color.r, 1, var_28_10)

								iter_28_2.color = Color.New(var_28_14, var_28_14, var_28_14)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_8 + var_28_9 and arg_25_1.time_ < var_28_8 + var_28_9 + arg_28_0 and not isNil(var_28_7) and arg_25_1.var_.actorSpriteComps10059 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_28_4 then
						if arg_25_1.isInRecall_ then
							iter_28_4.color = arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_28_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps10059 = nil
			end

			local var_28_15 = arg_25_1.actors_["1061"]
			local var_28_16 = 0

			if var_28_16 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.actorSpriteComps1061 == nil then
				arg_25_1.var_.actorSpriteComps1061 = var_28_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_17 = 0.034

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_17 and not isNil(var_28_15) then
				local var_28_18 = (arg_25_1.time_ - var_28_16) / var_28_17

				if arg_25_1.var_.actorSpriteComps1061 then
					for iter_28_5, iter_28_6 in pairs(arg_25_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_28_6 then
							if arg_25_1.isInRecall_ then
								local var_28_19 = Mathf.Lerp(iter_28_6.color.r, arg_25_1.hightColor2.r, var_28_18)
								local var_28_20 = Mathf.Lerp(iter_28_6.color.g, arg_25_1.hightColor2.g, var_28_18)
								local var_28_21 = Mathf.Lerp(iter_28_6.color.b, arg_25_1.hightColor2.b, var_28_18)

								iter_28_6.color = Color.New(var_28_19, var_28_20, var_28_21)
							else
								local var_28_22 = Mathf.Lerp(iter_28_6.color.r, 0.5, var_28_18)

								iter_28_6.color = Color.New(var_28_22, var_28_22, var_28_22)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= var_28_16 + var_28_17 and arg_25_1.time_ < var_28_16 + var_28_17 + arg_28_0 and not isNil(var_28_15) and arg_25_1.var_.actorSpriteComps1061 then
				for iter_28_7, iter_28_8 in pairs(arg_25_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_28_8 then
						if arg_25_1.isInRecall_ then
							iter_28_8.color = arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_28_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_25_1.var_.actorSpriteComps1061 = nil
			end

			local var_28_23 = 0
			local var_28_24 = 0.825

			if var_28_23 < arg_25_1.time_ and arg_25_1.time_ <= var_28_23 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_25 = arg_25_1:FormatText(StoryNameCfg[596].name)

				arg_25_1.leftNameTxt_.text = var_28_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_26 = arg_25_1:GetWordFromCfg(410172006)
				local var_28_27 = arg_25_1:FormatText(var_28_26.content)

				arg_25_1.text_.text = var_28_27

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_28 = 33
				local var_28_29 = utf8.len(var_28_27)
				local var_28_30 = var_28_28 <= 0 and var_28_24 or var_28_24 * (var_28_29 / var_28_28)

				if var_28_30 > 0 and var_28_24 < var_28_30 then
					arg_25_1.talkMaxDuration = var_28_30

					if var_28_30 + var_28_23 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_30 + var_28_23
					end
				end

				arg_25_1.text_.text = var_28_27
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172006", "story_v_out_410172.awb") ~= 0 then
					local var_28_31 = manager.audio:GetVoiceLength("story_v_out_410172", "410172006", "story_v_out_410172.awb") / 1000

					if var_28_31 + var_28_23 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_31 + var_28_23
					end

					if var_28_26.prefab_name ~= "" and arg_25_1.actors_[var_28_26.prefab_name] ~= nil then
						local var_28_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_26.prefab_name].transform, "story_v_out_410172", "410172006", "story_v_out_410172.awb")

						arg_25_1:RecordAudio("410172006", var_28_32)
						arg_25_1:RecordAudio("410172006", var_28_32)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_410172", "410172006", "story_v_out_410172.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_410172", "410172006", "story_v_out_410172.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_33 = math.max(var_28_24, arg_25_1.talkMaxDuration)

			if var_28_23 <= arg_25_1.time_ and arg_25_1.time_ < var_28_23 + var_28_33 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_23) / var_28_33

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_23 + var_28_33 and arg_25_1.time_ < var_28_23 + var_28_33 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play410172007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410172007
		arg_29_1.duration_ = 4.9

		local var_29_0 = {
			ja = 4.9,
			CriLanguages = 1.166,
			zh = 1.166
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
				arg_29_0:Play410172008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1061"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1061 = var_32_0.localPosition
				var_32_0.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1061", 2)

				local var_32_2 = var_32_0.childCount

				for iter_32_0 = 0, var_32_2 - 1 do
					local var_32_3 = var_32_0:GetChild(iter_32_0)

					if var_32_3.name == "split_5" or not string.find(var_32_3.name, "split") then
						var_32_3.gameObject:SetActive(true)
					else
						var_32_3.gameObject:SetActive(false)
					end
				end
			end

			local var_32_4 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_4 then
				local var_32_5 = (arg_29_1.time_ - var_32_1) / var_32_4
				local var_32_6 = Vector3.New(-390, -490, 18)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1061, var_32_6, var_32_5)
			end

			if arg_29_1.time_ >= var_32_1 + var_32_4 and arg_29_1.time_ < var_32_1 + var_32_4 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_32_7 = arg_29_1.actors_["1061"]
			local var_32_8 = 0

			if var_32_8 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.actorSpriteComps1061 == nil then
				arg_29_1.var_.actorSpriteComps1061 = var_32_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_9 = 0.034

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_9 and not isNil(var_32_7) then
				local var_32_10 = (arg_29_1.time_ - var_32_8) / var_32_9

				if arg_29_1.var_.actorSpriteComps1061 then
					for iter_32_1, iter_32_2 in pairs(arg_29_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_32_2 then
							if arg_29_1.isInRecall_ then
								local var_32_11 = Mathf.Lerp(iter_32_2.color.r, arg_29_1.hightColor1.r, var_32_10)
								local var_32_12 = Mathf.Lerp(iter_32_2.color.g, arg_29_1.hightColor1.g, var_32_10)
								local var_32_13 = Mathf.Lerp(iter_32_2.color.b, arg_29_1.hightColor1.b, var_32_10)

								iter_32_2.color = Color.New(var_32_11, var_32_12, var_32_13)
							else
								local var_32_14 = Mathf.Lerp(iter_32_2.color.r, 1, var_32_10)

								iter_32_2.color = Color.New(var_32_14, var_32_14, var_32_14)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_8 + var_32_9 and arg_29_1.time_ < var_32_8 + var_32_9 + arg_32_0 and not isNil(var_32_7) and arg_29_1.var_.actorSpriteComps1061 then
				for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_32_4 then
						if arg_29_1.isInRecall_ then
							iter_32_4.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_32_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps1061 = nil
			end

			local var_32_15 = arg_29_1.actors_["10059"]
			local var_32_16 = 0

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 and not isNil(var_32_15) and arg_29_1.var_.actorSpriteComps10059 == nil then
				arg_29_1.var_.actorSpriteComps10059 = var_32_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_17 = 0.034

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_17 and not isNil(var_32_15) then
				local var_32_18 = (arg_29_1.time_ - var_32_16) / var_32_17

				if arg_29_1.var_.actorSpriteComps10059 then
					for iter_32_5, iter_32_6 in pairs(arg_29_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_32_6 then
							if arg_29_1.isInRecall_ then
								local var_32_19 = Mathf.Lerp(iter_32_6.color.r, arg_29_1.hightColor2.r, var_32_18)
								local var_32_20 = Mathf.Lerp(iter_32_6.color.g, arg_29_1.hightColor2.g, var_32_18)
								local var_32_21 = Mathf.Lerp(iter_32_6.color.b, arg_29_1.hightColor2.b, var_32_18)

								iter_32_6.color = Color.New(var_32_19, var_32_20, var_32_21)
							else
								local var_32_22 = Mathf.Lerp(iter_32_6.color.r, 0.5, var_32_18)

								iter_32_6.color = Color.New(var_32_22, var_32_22, var_32_22)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= var_32_16 + var_32_17 and arg_29_1.time_ < var_32_16 + var_32_17 + arg_32_0 and not isNil(var_32_15) and arg_29_1.var_.actorSpriteComps10059 then
				for iter_32_7, iter_32_8 in pairs(arg_29_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_32_8 then
						if arg_29_1.isInRecall_ then
							iter_32_8.color = arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_32_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_29_1.var_.actorSpriteComps10059 = nil
			end

			local var_32_23 = 0
			local var_32_24 = 0.2

			if var_32_23 < arg_29_1.time_ and arg_29_1.time_ <= var_32_23 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_25 = arg_29_1:FormatText(StoryNameCfg[612].name)

				arg_29_1.leftNameTxt_.text = var_32_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_26 = arg_29_1:GetWordFromCfg(410172007)
				local var_32_27 = arg_29_1:FormatText(var_32_26.content)

				arg_29_1.text_.text = var_32_27

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_28 = 8
				local var_32_29 = utf8.len(var_32_27)
				local var_32_30 = var_32_28 <= 0 and var_32_24 or var_32_24 * (var_32_29 / var_32_28)

				if var_32_30 > 0 and var_32_24 < var_32_30 then
					arg_29_1.talkMaxDuration = var_32_30

					if var_32_30 + var_32_23 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_30 + var_32_23
					end
				end

				arg_29_1.text_.text = var_32_27
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172007", "story_v_out_410172.awb") ~= 0 then
					local var_32_31 = manager.audio:GetVoiceLength("story_v_out_410172", "410172007", "story_v_out_410172.awb") / 1000

					if var_32_31 + var_32_23 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_31 + var_32_23
					end

					if var_32_26.prefab_name ~= "" and arg_29_1.actors_[var_32_26.prefab_name] ~= nil then
						local var_32_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_26.prefab_name].transform, "story_v_out_410172", "410172007", "story_v_out_410172.awb")

						arg_29_1:RecordAudio("410172007", var_32_32)
						arg_29_1:RecordAudio("410172007", var_32_32)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_410172", "410172007", "story_v_out_410172.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_410172", "410172007", "story_v_out_410172.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_33 = math.max(var_32_24, arg_29_1.talkMaxDuration)

			if var_32_23 <= arg_29_1.time_ and arg_29_1.time_ < var_32_23 + var_32_33 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_23) / var_32_33

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_23 + var_32_33 and arg_29_1.time_ < var_32_23 + var_32_33 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play410172008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410172008
		arg_33_1.duration_ = 10.3

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play410172009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10059"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos10059 = var_36_0.localPosition
				var_36_0.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10059", 4)

				local var_36_2 = var_36_0.childCount

				for iter_36_0 = 0, var_36_2 - 1 do
					local var_36_3 = var_36_0:GetChild(iter_36_0)

					if var_36_3.name == "" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_4 then
				local var_36_5 = (arg_33_1.time_ - var_36_1) / var_36_4
				local var_36_6 = Vector3.New(390, -530, 35)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10059, var_36_6, var_36_5)
			end

			if arg_33_1.time_ >= var_36_1 + var_36_4 and arg_33_1.time_ < var_36_1 + var_36_4 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_36_7 = arg_33_1.actors_["10059"]
			local var_36_8 = 0

			if var_36_8 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps10059 == nil then
				arg_33_1.var_.actorSpriteComps10059 = var_36_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_9 = 0.034

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_9 and not isNil(var_36_7) then
				local var_36_10 = (arg_33_1.time_ - var_36_8) / var_36_9

				if arg_33_1.var_.actorSpriteComps10059 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_36_2 then
							if arg_33_1.isInRecall_ then
								local var_36_11 = Mathf.Lerp(iter_36_2.color.r, arg_33_1.hightColor1.r, var_36_10)
								local var_36_12 = Mathf.Lerp(iter_36_2.color.g, arg_33_1.hightColor1.g, var_36_10)
								local var_36_13 = Mathf.Lerp(iter_36_2.color.b, arg_33_1.hightColor1.b, var_36_10)

								iter_36_2.color = Color.New(var_36_11, var_36_12, var_36_13)
							else
								local var_36_14 = Mathf.Lerp(iter_36_2.color.r, 1, var_36_10)

								iter_36_2.color = Color.New(var_36_14, var_36_14, var_36_14)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_8 + var_36_9 and arg_33_1.time_ < var_36_8 + var_36_9 + arg_36_0 and not isNil(var_36_7) and arg_33_1.var_.actorSpriteComps10059 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_36_4 then
						if arg_33_1.isInRecall_ then
							iter_36_4.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_36_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps10059 = nil
			end

			local var_36_15 = arg_33_1.actors_["1061"]
			local var_36_16 = 0

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.actorSpriteComps1061 == nil then
				arg_33_1.var_.actorSpriteComps1061 = var_36_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_17 = 0.034

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_17 and not isNil(var_36_15) then
				local var_36_18 = (arg_33_1.time_ - var_36_16) / var_36_17

				if arg_33_1.var_.actorSpriteComps1061 then
					for iter_36_5, iter_36_6 in pairs(arg_33_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_36_6 then
							if arg_33_1.isInRecall_ then
								local var_36_19 = Mathf.Lerp(iter_36_6.color.r, arg_33_1.hightColor2.r, var_36_18)
								local var_36_20 = Mathf.Lerp(iter_36_6.color.g, arg_33_1.hightColor2.g, var_36_18)
								local var_36_21 = Mathf.Lerp(iter_36_6.color.b, arg_33_1.hightColor2.b, var_36_18)

								iter_36_6.color = Color.New(var_36_19, var_36_20, var_36_21)
							else
								local var_36_22 = Mathf.Lerp(iter_36_6.color.r, 0.5, var_36_18)

								iter_36_6.color = Color.New(var_36_22, var_36_22, var_36_22)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= var_36_16 + var_36_17 and arg_33_1.time_ < var_36_16 + var_36_17 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.actorSpriteComps1061 then
				for iter_36_7, iter_36_8 in pairs(arg_33_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_36_8 then
						if arg_33_1.isInRecall_ then
							iter_36_8.color = arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_36_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_33_1.var_.actorSpriteComps1061 = nil
			end

			local var_36_23 = 0
			local var_36_24 = 1.15

			if var_36_23 < arg_33_1.time_ and arg_33_1.time_ <= var_36_23 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_25 = arg_33_1:FormatText(StoryNameCfg[596].name)

				arg_33_1.leftNameTxt_.text = var_36_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_26 = arg_33_1:GetWordFromCfg(410172008)
				local var_36_27 = arg_33_1:FormatText(var_36_26.content)

				arg_33_1.text_.text = var_36_27

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_28 = 46
				local var_36_29 = utf8.len(var_36_27)
				local var_36_30 = var_36_28 <= 0 and var_36_24 or var_36_24 * (var_36_29 / var_36_28)

				if var_36_30 > 0 and var_36_24 < var_36_30 then
					arg_33_1.talkMaxDuration = var_36_30

					if var_36_30 + var_36_23 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_30 + var_36_23
					end
				end

				arg_33_1.text_.text = var_36_27
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172008", "story_v_out_410172.awb") ~= 0 then
					local var_36_31 = manager.audio:GetVoiceLength("story_v_out_410172", "410172008", "story_v_out_410172.awb") / 1000

					if var_36_31 + var_36_23 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_31 + var_36_23
					end

					if var_36_26.prefab_name ~= "" and arg_33_1.actors_[var_36_26.prefab_name] ~= nil then
						local var_36_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_26.prefab_name].transform, "story_v_out_410172", "410172008", "story_v_out_410172.awb")

						arg_33_1:RecordAudio("410172008", var_36_32)
						arg_33_1:RecordAudio("410172008", var_36_32)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_410172", "410172008", "story_v_out_410172.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_410172", "410172008", "story_v_out_410172.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_33 = math.max(var_36_24, arg_33_1.talkMaxDuration)

			if var_36_23 <= arg_33_1.time_ and arg_33_1.time_ < var_36_23 + var_36_33 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_23) / var_36_33

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_23 + var_36_33 and arg_33_1.time_ < var_36_23 + var_36_33 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play410172009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410172009
		arg_37_1.duration_ = 5.7

		local var_37_0 = {
			ja = 5.7,
			CriLanguages = 5.333,
			zh = 5.333
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
				arg_37_0:Play410172010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["10059"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos10059 = var_40_0.localPosition
				var_40_0.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10059", 4)

				local var_40_2 = var_40_0.childCount

				for iter_40_0 = 0, var_40_2 - 1 do
					local var_40_3 = var_40_0:GetChild(iter_40_0)

					if var_40_3.name == "split_3" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_4 then
				local var_40_5 = (arg_37_1.time_ - var_40_1) / var_40_4
				local var_40_6 = Vector3.New(390, -530, 35)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10059, var_40_6, var_40_5)
			end

			if arg_37_1.time_ >= var_40_1 + var_40_4 and arg_37_1.time_ < var_40_1 + var_40_4 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_40_7 = arg_37_1.actors_["10059"]
			local var_40_8 = 0

			if var_40_8 < arg_37_1.time_ and arg_37_1.time_ <= var_40_8 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.actorSpriteComps10059 == nil then
				arg_37_1.var_.actorSpriteComps10059 = var_40_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_9 = 0.034

			if var_40_8 <= arg_37_1.time_ and arg_37_1.time_ < var_40_8 + var_40_9 and not isNil(var_40_7) then
				local var_40_10 = (arg_37_1.time_ - var_40_8) / var_40_9

				if arg_37_1.var_.actorSpriteComps10059 then
					for iter_40_1, iter_40_2 in pairs(arg_37_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_40_2 then
							if arg_37_1.isInRecall_ then
								local var_40_11 = Mathf.Lerp(iter_40_2.color.r, arg_37_1.hightColor1.r, var_40_10)
								local var_40_12 = Mathf.Lerp(iter_40_2.color.g, arg_37_1.hightColor1.g, var_40_10)
								local var_40_13 = Mathf.Lerp(iter_40_2.color.b, arg_37_1.hightColor1.b, var_40_10)

								iter_40_2.color = Color.New(var_40_11, var_40_12, var_40_13)
							else
								local var_40_14 = Mathf.Lerp(iter_40_2.color.r, 1, var_40_10)

								iter_40_2.color = Color.New(var_40_14, var_40_14, var_40_14)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= var_40_8 + var_40_9 and arg_37_1.time_ < var_40_8 + var_40_9 + arg_40_0 and not isNil(var_40_7) and arg_37_1.var_.actorSpriteComps10059 then
				for iter_40_3, iter_40_4 in pairs(arg_37_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_40_4 then
						if arg_37_1.isInRecall_ then
							iter_40_4.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_40_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_37_1.var_.actorSpriteComps10059 = nil
			end

			local var_40_15 = 0
			local var_40_16 = 0.6

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_17 = arg_37_1:FormatText(StoryNameCfg[596].name)

				arg_37_1.leftNameTxt_.text = var_40_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_18 = arg_37_1:GetWordFromCfg(410172009)
				local var_40_19 = arg_37_1:FormatText(var_40_18.content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 24
				local var_40_21 = utf8.len(var_40_19)
				local var_40_22 = var_40_20 <= 0 and var_40_16 or var_40_16 * (var_40_21 / var_40_20)

				if var_40_22 > 0 and var_40_16 < var_40_22 then
					arg_37_1.talkMaxDuration = var_40_22

					if var_40_22 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_22 + var_40_15
					end
				end

				arg_37_1.text_.text = var_40_19
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172009", "story_v_out_410172.awb") ~= 0 then
					local var_40_23 = manager.audio:GetVoiceLength("story_v_out_410172", "410172009", "story_v_out_410172.awb") / 1000

					if var_40_23 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_15
					end

					if var_40_18.prefab_name ~= "" and arg_37_1.actors_[var_40_18.prefab_name] ~= nil then
						local var_40_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_18.prefab_name].transform, "story_v_out_410172", "410172009", "story_v_out_410172.awb")

						arg_37_1:RecordAudio("410172009", var_40_24)
						arg_37_1:RecordAudio("410172009", var_40_24)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_410172", "410172009", "story_v_out_410172.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_410172", "410172009", "story_v_out_410172.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_25 = math.max(var_40_16, arg_37_1.talkMaxDuration)

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_25 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_15) / var_40_25

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_15 + var_40_25 and arg_37_1.time_ < var_40_15 + var_40_25 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play410172010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410172010
		arg_41_1.duration_ = 8.4

		local var_41_0 = {
			ja = 6.433,
			CriLanguages = 8.4,
			zh = 8.4
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
				arg_41_0:Play410172011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10059"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos10059 = var_44_0.localPosition
				var_44_0.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10059", 4)

				local var_44_2 = var_44_0.childCount

				for iter_44_0 = 0, var_44_2 - 1 do
					local var_44_3 = var_44_0:GetChild(iter_44_0)

					if var_44_3.name == "split_3" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_4 then
				local var_44_5 = (arg_41_1.time_ - var_44_1) / var_44_4
				local var_44_6 = Vector3.New(390, -530, 35)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10059, var_44_6, var_44_5)
			end

			if arg_41_1.time_ >= var_44_1 + var_44_4 and arg_41_1.time_ < var_44_1 + var_44_4 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(390, -530, 35)
			end

			local var_44_7 = arg_41_1.actors_["10059"]
			local var_44_8 = 0

			if var_44_8 < arg_41_1.time_ and arg_41_1.time_ <= var_44_8 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.actorSpriteComps10059 == nil then
				arg_41_1.var_.actorSpriteComps10059 = var_44_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_9 = 0.034

			if var_44_8 <= arg_41_1.time_ and arg_41_1.time_ < var_44_8 + var_44_9 and not isNil(var_44_7) then
				local var_44_10 = (arg_41_1.time_ - var_44_8) / var_44_9

				if arg_41_1.var_.actorSpriteComps10059 then
					for iter_44_1, iter_44_2 in pairs(arg_41_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_44_2 then
							if arg_41_1.isInRecall_ then
								local var_44_11 = Mathf.Lerp(iter_44_2.color.r, arg_41_1.hightColor1.r, var_44_10)
								local var_44_12 = Mathf.Lerp(iter_44_2.color.g, arg_41_1.hightColor1.g, var_44_10)
								local var_44_13 = Mathf.Lerp(iter_44_2.color.b, arg_41_1.hightColor1.b, var_44_10)

								iter_44_2.color = Color.New(var_44_11, var_44_12, var_44_13)
							else
								local var_44_14 = Mathf.Lerp(iter_44_2.color.r, 1, var_44_10)

								iter_44_2.color = Color.New(var_44_14, var_44_14, var_44_14)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= var_44_8 + var_44_9 and arg_41_1.time_ < var_44_8 + var_44_9 + arg_44_0 and not isNil(var_44_7) and arg_41_1.var_.actorSpriteComps10059 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_44_4 then
						if arg_41_1.isInRecall_ then
							iter_44_4.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_44_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_41_1.var_.actorSpriteComps10059 = nil
			end

			local var_44_15 = 0
			local var_44_16 = 0.85

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_17 = arg_41_1:FormatText(StoryNameCfg[596].name)

				arg_41_1.leftNameTxt_.text = var_44_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_18 = arg_41_1:GetWordFromCfg(410172010)
				local var_44_19 = arg_41_1:FormatText(var_44_18.content)

				arg_41_1.text_.text = var_44_19

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_20 = 34
				local var_44_21 = utf8.len(var_44_19)
				local var_44_22 = var_44_20 <= 0 and var_44_16 or var_44_16 * (var_44_21 / var_44_20)

				if var_44_22 > 0 and var_44_16 < var_44_22 then
					arg_41_1.talkMaxDuration = var_44_22

					if var_44_22 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_22 + var_44_15
					end
				end

				arg_41_1.text_.text = var_44_19
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172010", "story_v_out_410172.awb") ~= 0 then
					local var_44_23 = manager.audio:GetVoiceLength("story_v_out_410172", "410172010", "story_v_out_410172.awb") / 1000

					if var_44_23 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_23 + var_44_15
					end

					if var_44_18.prefab_name ~= "" and arg_41_1.actors_[var_44_18.prefab_name] ~= nil then
						local var_44_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_18.prefab_name].transform, "story_v_out_410172", "410172010", "story_v_out_410172.awb")

						arg_41_1:RecordAudio("410172010", var_44_24)
						arg_41_1:RecordAudio("410172010", var_44_24)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_410172", "410172010", "story_v_out_410172.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_410172", "410172010", "story_v_out_410172.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_25 = math.max(var_44_16, arg_41_1.talkMaxDuration)

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_25 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_15) / var_44_25

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_15 + var_44_25 and arg_41_1.time_ < var_44_15 + var_44_25 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play410172011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410172011
		arg_45_1.duration_ = 9.27

		local var_45_0 = {
			ja = 9.266,
			CriLanguages = 5.033,
			zh = 5.033
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
				arg_45_0:Play410172012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1061"].transform
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.var_.moveOldPos1061 = var_48_0.localPosition
				var_48_0.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1061", 2)

				local var_48_2 = var_48_0.childCount

				for iter_48_0 = 0, var_48_2 - 1 do
					local var_48_3 = var_48_0:GetChild(iter_48_0)

					if var_48_3.name == "" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_4 then
				local var_48_5 = (arg_45_1.time_ - var_48_1) / var_48_4
				local var_48_6 = Vector3.New(-390, -490, 18)

				var_48_0.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1061, var_48_6, var_48_5)
			end

			if arg_45_1.time_ >= var_48_1 + var_48_4 and arg_45_1.time_ < var_48_1 + var_48_4 + arg_48_0 then
				var_48_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_48_7 = arg_45_1.actors_["1061"]
			local var_48_8 = 0

			if var_48_8 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps1061 == nil then
				arg_45_1.var_.actorSpriteComps1061 = var_48_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_9 = 0.034

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_9 and not isNil(var_48_7) then
				local var_48_10 = (arg_45_1.time_ - var_48_8) / var_48_9

				if arg_45_1.var_.actorSpriteComps1061 then
					for iter_48_1, iter_48_2 in pairs(arg_45_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_48_2 then
							if arg_45_1.isInRecall_ then
								local var_48_11 = Mathf.Lerp(iter_48_2.color.r, arg_45_1.hightColor1.r, var_48_10)
								local var_48_12 = Mathf.Lerp(iter_48_2.color.g, arg_45_1.hightColor1.g, var_48_10)
								local var_48_13 = Mathf.Lerp(iter_48_2.color.b, arg_45_1.hightColor1.b, var_48_10)

								iter_48_2.color = Color.New(var_48_11, var_48_12, var_48_13)
							else
								local var_48_14 = Mathf.Lerp(iter_48_2.color.r, 1, var_48_10)

								iter_48_2.color = Color.New(var_48_14, var_48_14, var_48_14)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_8 + var_48_9 and arg_45_1.time_ < var_48_8 + var_48_9 + arg_48_0 and not isNil(var_48_7) and arg_45_1.var_.actorSpriteComps1061 then
				for iter_48_3, iter_48_4 in pairs(arg_45_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_48_4 then
						if arg_45_1.isInRecall_ then
							iter_48_4.color = arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_48_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps1061 = nil
			end

			local var_48_15 = arg_45_1.actors_["10059"]
			local var_48_16 = 0

			if var_48_16 < arg_45_1.time_ and arg_45_1.time_ <= var_48_16 + arg_48_0 and not isNil(var_48_15) and arg_45_1.var_.actorSpriteComps10059 == nil then
				arg_45_1.var_.actorSpriteComps10059 = var_48_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_17 = 0.034

			if var_48_16 <= arg_45_1.time_ and arg_45_1.time_ < var_48_16 + var_48_17 and not isNil(var_48_15) then
				local var_48_18 = (arg_45_1.time_ - var_48_16) / var_48_17

				if arg_45_1.var_.actorSpriteComps10059 then
					for iter_48_5, iter_48_6 in pairs(arg_45_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_48_6 then
							if arg_45_1.isInRecall_ then
								local var_48_19 = Mathf.Lerp(iter_48_6.color.r, arg_45_1.hightColor2.r, var_48_18)
								local var_48_20 = Mathf.Lerp(iter_48_6.color.g, arg_45_1.hightColor2.g, var_48_18)
								local var_48_21 = Mathf.Lerp(iter_48_6.color.b, arg_45_1.hightColor2.b, var_48_18)

								iter_48_6.color = Color.New(var_48_19, var_48_20, var_48_21)
							else
								local var_48_22 = Mathf.Lerp(iter_48_6.color.r, 0.5, var_48_18)

								iter_48_6.color = Color.New(var_48_22, var_48_22, var_48_22)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= var_48_16 + var_48_17 and arg_45_1.time_ < var_48_16 + var_48_17 + arg_48_0 and not isNil(var_48_15) and arg_45_1.var_.actorSpriteComps10059 then
				for iter_48_7, iter_48_8 in pairs(arg_45_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_48_8 then
						if arg_45_1.isInRecall_ then
							iter_48_8.color = arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_48_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_45_1.var_.actorSpriteComps10059 = nil
			end

			local var_48_23 = 0
			local var_48_24 = 0.75

			if var_48_23 < arg_45_1.time_ and arg_45_1.time_ <= var_48_23 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_25 = arg_45_1:FormatText(StoryNameCfg[612].name)

				arg_45_1.leftNameTxt_.text = var_48_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_26 = arg_45_1:GetWordFromCfg(410172011)
				local var_48_27 = arg_45_1:FormatText(var_48_26.content)

				arg_45_1.text_.text = var_48_27

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_28 = 30
				local var_48_29 = utf8.len(var_48_27)
				local var_48_30 = var_48_28 <= 0 and var_48_24 or var_48_24 * (var_48_29 / var_48_28)

				if var_48_30 > 0 and var_48_24 < var_48_30 then
					arg_45_1.talkMaxDuration = var_48_30

					if var_48_30 + var_48_23 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_30 + var_48_23
					end
				end

				arg_45_1.text_.text = var_48_27
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172011", "story_v_out_410172.awb") ~= 0 then
					local var_48_31 = manager.audio:GetVoiceLength("story_v_out_410172", "410172011", "story_v_out_410172.awb") / 1000

					if var_48_31 + var_48_23 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_31 + var_48_23
					end

					if var_48_26.prefab_name ~= "" and arg_45_1.actors_[var_48_26.prefab_name] ~= nil then
						local var_48_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_26.prefab_name].transform, "story_v_out_410172", "410172011", "story_v_out_410172.awb")

						arg_45_1:RecordAudio("410172011", var_48_32)
						arg_45_1:RecordAudio("410172011", var_48_32)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_410172", "410172011", "story_v_out_410172.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_410172", "410172011", "story_v_out_410172.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_33 = math.max(var_48_24, arg_45_1.talkMaxDuration)

			if var_48_23 <= arg_45_1.time_ and arg_45_1.time_ < var_48_23 + var_48_33 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_23) / var_48_33

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_23 + var_48_33 and arg_45_1.time_ < var_48_23 + var_48_33 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play410172012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410172012
		arg_49_1.duration_ = 7.2

		local var_49_0 = {
			ja = 7.2,
			CriLanguages = 4.533,
			zh = 4.533
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
				arg_49_0:Play410172013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1061"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1061 = var_52_0.localPosition
				var_52_0.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1061", 7)

				local var_52_2 = var_52_0.childCount

				for iter_52_0 = 0, var_52_2 - 1 do
					local var_52_3 = var_52_0:GetChild(iter_52_0)

					if var_52_3.name == "" or not string.find(var_52_3.name, "split") then
						var_52_3.gameObject:SetActive(true)
					else
						var_52_3.gameObject:SetActive(false)
					end
				end
			end

			local var_52_4 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_4 then
				local var_52_5 = (arg_49_1.time_ - var_52_1) / var_52_4
				local var_52_6 = Vector3.New(0, -2000, 18)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1061, var_52_6, var_52_5)
			end

			if arg_49_1.time_ >= var_52_1 + var_52_4 and arg_49_1.time_ < var_52_1 + var_52_4 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_52_7 = arg_49_1.actors_["10059"].transform
			local var_52_8 = 0

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.var_.moveOldPos10059 = var_52_7.localPosition
				var_52_7.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("10059", 7)

				local var_52_9 = var_52_7.childCount

				for iter_52_1 = 0, var_52_9 - 1 do
					local var_52_10 = var_52_7:GetChild(iter_52_1)

					if var_52_10.name == "" or not string.find(var_52_10.name, "split") then
						var_52_10.gameObject:SetActive(true)
					else
						var_52_10.gameObject:SetActive(false)
					end
				end
			end

			local var_52_11 = 0.001

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_11 then
				local var_52_12 = (arg_49_1.time_ - var_52_8) / var_52_11
				local var_52_13 = Vector3.New(0, -2000, 35)

				var_52_7.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10059, var_52_13, var_52_12)
			end

			if arg_49_1.time_ >= var_52_8 + var_52_11 and arg_49_1.time_ < var_52_8 + var_52_11 + arg_52_0 then
				var_52_7.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_52_14 = arg_49_1.actors_["1061"]
			local var_52_15 = 0

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 and not isNil(var_52_14) and arg_49_1.var_.actorSpriteComps1061 == nil then
				arg_49_1.var_.actorSpriteComps1061 = var_52_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_16 = 0.034

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_16 and not isNil(var_52_14) then
				local var_52_17 = (arg_49_1.time_ - var_52_15) / var_52_16

				if arg_49_1.var_.actorSpriteComps1061 then
					for iter_52_2, iter_52_3 in pairs(arg_49_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_52_3 then
							if arg_49_1.isInRecall_ then
								local var_52_18 = Mathf.Lerp(iter_52_3.color.r, arg_49_1.hightColor2.r, var_52_17)
								local var_52_19 = Mathf.Lerp(iter_52_3.color.g, arg_49_1.hightColor2.g, var_52_17)
								local var_52_20 = Mathf.Lerp(iter_52_3.color.b, arg_49_1.hightColor2.b, var_52_17)

								iter_52_3.color = Color.New(var_52_18, var_52_19, var_52_20)
							else
								local var_52_21 = Mathf.Lerp(iter_52_3.color.r, 0.5, var_52_17)

								iter_52_3.color = Color.New(var_52_21, var_52_21, var_52_21)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_15 + var_52_16 and arg_49_1.time_ < var_52_15 + var_52_16 + arg_52_0 and not isNil(var_52_14) and arg_49_1.var_.actorSpriteComps1061 then
				for iter_52_4, iter_52_5 in pairs(arg_49_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_52_5 then
						if arg_49_1.isInRecall_ then
							iter_52_5.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps1061 = nil
			end

			local var_52_22 = arg_49_1.actors_["10059"]
			local var_52_23 = 0

			if var_52_23 < arg_49_1.time_ and arg_49_1.time_ <= var_52_23 + arg_52_0 and not isNil(var_52_22) and arg_49_1.var_.actorSpriteComps10059 == nil then
				arg_49_1.var_.actorSpriteComps10059 = var_52_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_52_24 = 0.034

			if var_52_23 <= arg_49_1.time_ and arg_49_1.time_ < var_52_23 + var_52_24 and not isNil(var_52_22) then
				local var_52_25 = (arg_49_1.time_ - var_52_23) / var_52_24

				if arg_49_1.var_.actorSpriteComps10059 then
					for iter_52_6, iter_52_7 in pairs(arg_49_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_52_7 then
							if arg_49_1.isInRecall_ then
								local var_52_26 = Mathf.Lerp(iter_52_7.color.r, arg_49_1.hightColor2.r, var_52_25)
								local var_52_27 = Mathf.Lerp(iter_52_7.color.g, arg_49_1.hightColor2.g, var_52_25)
								local var_52_28 = Mathf.Lerp(iter_52_7.color.b, arg_49_1.hightColor2.b, var_52_25)

								iter_52_7.color = Color.New(var_52_26, var_52_27, var_52_28)
							else
								local var_52_29 = Mathf.Lerp(iter_52_7.color.r, 0.5, var_52_25)

								iter_52_7.color = Color.New(var_52_29, var_52_29, var_52_29)
							end
						end
					end
				end
			end

			if arg_49_1.time_ >= var_52_23 + var_52_24 and arg_49_1.time_ < var_52_23 + var_52_24 + arg_52_0 and not isNil(var_52_22) and arg_49_1.var_.actorSpriteComps10059 then
				for iter_52_8, iter_52_9 in pairs(arg_49_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_52_9 then
						if arg_49_1.isInRecall_ then
							iter_52_9.color = arg_49_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_52_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_49_1.var_.actorSpriteComps10059 = nil
			end

			local var_52_30 = 0
			local var_52_31 = 0.45

			if var_52_30 < arg_49_1.time_ and arg_49_1.time_ <= var_52_30 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_32 = arg_49_1:FormatText(StoryNameCfg[36].name)

				arg_49_1.leftNameTxt_.text = var_52_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_33 = arg_49_1:GetWordFromCfg(410172012)
				local var_52_34 = arg_49_1:FormatText(var_52_33.content)

				arg_49_1.text_.text = var_52_34

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_35 = 18
				local var_52_36 = utf8.len(var_52_34)
				local var_52_37 = var_52_35 <= 0 and var_52_31 or var_52_31 * (var_52_36 / var_52_35)

				if var_52_37 > 0 and var_52_31 < var_52_37 then
					arg_49_1.talkMaxDuration = var_52_37

					if var_52_37 + var_52_30 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_37 + var_52_30
					end
				end

				arg_49_1.text_.text = var_52_34
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172012", "story_v_out_410172.awb") ~= 0 then
					local var_52_38 = manager.audio:GetVoiceLength("story_v_out_410172", "410172012", "story_v_out_410172.awb") / 1000

					if var_52_38 + var_52_30 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_38 + var_52_30
					end

					if var_52_33.prefab_name ~= "" and arg_49_1.actors_[var_52_33.prefab_name] ~= nil then
						local var_52_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_33.prefab_name].transform, "story_v_out_410172", "410172012", "story_v_out_410172.awb")

						arg_49_1:RecordAudio("410172012", var_52_39)
						arg_49_1:RecordAudio("410172012", var_52_39)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_410172", "410172012", "story_v_out_410172.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_410172", "410172012", "story_v_out_410172.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_40 = math.max(var_52_31, arg_49_1.talkMaxDuration)

			if var_52_30 <= arg_49_1.time_ and arg_49_1.time_ < var_52_30 + var_52_40 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_30) / var_52_40

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_30 + var_52_40 and arg_49_1.time_ < var_52_30 + var_52_40 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play410172013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410172013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play410172014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.4

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_2 = arg_53_1:GetWordFromCfg(410172013)
				local var_56_3 = arg_53_1:FormatText(var_56_2.content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 56
				local var_56_5 = utf8.len(var_56_3)
				local var_56_6 = var_56_4 <= 0 and var_56_1 or var_56_1 * (var_56_5 / var_56_4)

				if var_56_6 > 0 and var_56_1 < var_56_6 then
					arg_53_1.talkMaxDuration = var_56_6

					if var_56_6 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_6 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_3
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_7 and arg_53_1.time_ < var_56_0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play410172014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410172014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play410172015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.4

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_2 = arg_57_1:GetWordFromCfg(410172014)
				local var_60_3 = arg_57_1:FormatText(var_60_2.content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 16
				local var_60_5 = utf8.len(var_60_3)
				local var_60_6 = var_60_4 <= 0 and var_60_1 or var_60_1 * (var_60_5 / var_60_4)

				if var_60_6 > 0 and var_60_1 < var_60_6 then
					arg_57_1.talkMaxDuration = var_60_6

					if var_60_6 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_7 and arg_57_1.time_ < var_60_0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play410172015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410172015
		arg_61_1.duration_ = 6.07

		local var_61_0 = {
			ja = 6.066,
			CriLanguages = 3.766,
			zh = 3.766
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
				arg_61_0:Play410172016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1061"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1061 = var_64_0.localPosition
				var_64_0.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1061", 2)

				local var_64_2 = var_64_0.childCount

				for iter_64_0 = 0, var_64_2 - 1 do
					local var_64_3 = var_64_0:GetChild(iter_64_0)

					if var_64_3.name == "" or not string.find(var_64_3.name, "split") then
						var_64_3.gameObject:SetActive(true)
					else
						var_64_3.gameObject:SetActive(false)
					end
				end
			end

			local var_64_4 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_4 then
				local var_64_5 = (arg_61_1.time_ - var_64_1) / var_64_4
				local var_64_6 = Vector3.New(-390, -490, 18)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1061, var_64_6, var_64_5)
			end

			if arg_61_1.time_ >= var_64_1 + var_64_4 and arg_61_1.time_ < var_64_1 + var_64_4 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_64_7 = "10062"

			if arg_61_1.actors_[var_64_7] == nil then
				local var_64_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10062")

				if not isNil(var_64_8) then
					local var_64_9 = Object.Instantiate(var_64_8, arg_61_1.canvasGo_.transform)

					var_64_9.transform:SetSiblingIndex(1)

					var_64_9.name = var_64_7
					var_64_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_61_1.actors_[var_64_7] = var_64_9

					local var_64_10 = var_64_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_61_1.isInRecall_ then
						for iter_64_1, iter_64_2 in ipairs(var_64_10) do
							iter_64_2.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_64_11 = arg_61_1.actors_["10062"].transform
			local var_64_12 = 0

			if var_64_12 < arg_61_1.time_ and arg_61_1.time_ <= var_64_12 + arg_64_0 then
				arg_61_1.var_.moveOldPos10062 = var_64_11.localPosition
				var_64_11.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10062", 4)

				local var_64_13 = var_64_11.childCount

				for iter_64_3 = 0, var_64_13 - 1 do
					local var_64_14 = var_64_11:GetChild(iter_64_3)

					if var_64_14.name == "" or not string.find(var_64_14.name, "split") then
						var_64_14.gameObject:SetActive(true)
					else
						var_64_14.gameObject:SetActive(false)
					end
				end
			end

			local var_64_15 = 0.001

			if var_64_12 <= arg_61_1.time_ and arg_61_1.time_ < var_64_12 + var_64_15 then
				local var_64_16 = (arg_61_1.time_ - var_64_12) / var_64_15
				local var_64_17 = Vector3.New(370, -390, -290)

				var_64_11.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10062, var_64_17, var_64_16)
			end

			if arg_61_1.time_ >= var_64_12 + var_64_15 and arg_61_1.time_ < var_64_12 + var_64_15 + arg_64_0 then
				var_64_11.localPosition = Vector3.New(370, -390, -290)
			end

			local var_64_18 = arg_61_1.actors_["1061"]
			local var_64_19 = 0

			if var_64_19 < arg_61_1.time_ and arg_61_1.time_ <= var_64_19 + arg_64_0 and not isNil(var_64_18) and arg_61_1.var_.actorSpriteComps1061 == nil then
				arg_61_1.var_.actorSpriteComps1061 = var_64_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_20 = 0.034

			if var_64_19 <= arg_61_1.time_ and arg_61_1.time_ < var_64_19 + var_64_20 and not isNil(var_64_18) then
				local var_64_21 = (arg_61_1.time_ - var_64_19) / var_64_20

				if arg_61_1.var_.actorSpriteComps1061 then
					for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_64_5 then
							if arg_61_1.isInRecall_ then
								local var_64_22 = Mathf.Lerp(iter_64_5.color.r, arg_61_1.hightColor1.r, var_64_21)
								local var_64_23 = Mathf.Lerp(iter_64_5.color.g, arg_61_1.hightColor1.g, var_64_21)
								local var_64_24 = Mathf.Lerp(iter_64_5.color.b, arg_61_1.hightColor1.b, var_64_21)

								iter_64_5.color = Color.New(var_64_22, var_64_23, var_64_24)
							else
								local var_64_25 = Mathf.Lerp(iter_64_5.color.r, 1, var_64_21)

								iter_64_5.color = Color.New(var_64_25, var_64_25, var_64_25)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_19 + var_64_20 and arg_61_1.time_ < var_64_19 + var_64_20 + arg_64_0 and not isNil(var_64_18) and arg_61_1.var_.actorSpriteComps1061 then
				for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_64_7 then
						if arg_61_1.isInRecall_ then
							iter_64_7.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_64_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps1061 = nil
			end

			local var_64_26 = arg_61_1.actors_["10062"]
			local var_64_27 = 0

			if var_64_27 < arg_61_1.time_ and arg_61_1.time_ <= var_64_27 + arg_64_0 and not isNil(var_64_26) and arg_61_1.var_.actorSpriteComps10062 == nil then
				arg_61_1.var_.actorSpriteComps10062 = var_64_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_28 = 0.034

			if var_64_27 <= arg_61_1.time_ and arg_61_1.time_ < var_64_27 + var_64_28 and not isNil(var_64_26) then
				local var_64_29 = (arg_61_1.time_ - var_64_27) / var_64_28

				if arg_61_1.var_.actorSpriteComps10062 then
					for iter_64_8, iter_64_9 in pairs(arg_61_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_64_9 then
							if arg_61_1.isInRecall_ then
								local var_64_30 = Mathf.Lerp(iter_64_9.color.r, arg_61_1.hightColor2.r, var_64_29)
								local var_64_31 = Mathf.Lerp(iter_64_9.color.g, arg_61_1.hightColor2.g, var_64_29)
								local var_64_32 = Mathf.Lerp(iter_64_9.color.b, arg_61_1.hightColor2.b, var_64_29)

								iter_64_9.color = Color.New(var_64_30, var_64_31, var_64_32)
							else
								local var_64_33 = Mathf.Lerp(iter_64_9.color.r, 0.5, var_64_29)

								iter_64_9.color = Color.New(var_64_33, var_64_33, var_64_33)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_27 + var_64_28 and arg_61_1.time_ < var_64_27 + var_64_28 + arg_64_0 and not isNil(var_64_26) and arg_61_1.var_.actorSpriteComps10062 then
				for iter_64_10, iter_64_11 in pairs(arg_61_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_64_11 then
						if arg_61_1.isInRecall_ then
							iter_64_11.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10062 = nil
			end

			local var_64_34 = 0
			local var_64_35 = 0.475

			if var_64_34 < arg_61_1.time_ and arg_61_1.time_ <= var_64_34 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_36 = arg_61_1:FormatText(StoryNameCfg[612].name)

				arg_61_1.leftNameTxt_.text = var_64_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_37 = arg_61_1:GetWordFromCfg(410172015)
				local var_64_38 = arg_61_1:FormatText(var_64_37.content)

				arg_61_1.text_.text = var_64_38

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_39 = 19
				local var_64_40 = utf8.len(var_64_38)
				local var_64_41 = var_64_39 <= 0 and var_64_35 or var_64_35 * (var_64_40 / var_64_39)

				if var_64_41 > 0 and var_64_35 < var_64_41 then
					arg_61_1.talkMaxDuration = var_64_41

					if var_64_41 + var_64_34 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_41 + var_64_34
					end
				end

				arg_61_1.text_.text = var_64_38
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172015", "story_v_out_410172.awb") ~= 0 then
					local var_64_42 = manager.audio:GetVoiceLength("story_v_out_410172", "410172015", "story_v_out_410172.awb") / 1000

					if var_64_42 + var_64_34 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_42 + var_64_34
					end

					if var_64_37.prefab_name ~= "" and arg_61_1.actors_[var_64_37.prefab_name] ~= nil then
						local var_64_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_37.prefab_name].transform, "story_v_out_410172", "410172015", "story_v_out_410172.awb")

						arg_61_1:RecordAudio("410172015", var_64_43)
						arg_61_1:RecordAudio("410172015", var_64_43)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_410172", "410172015", "story_v_out_410172.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_410172", "410172015", "story_v_out_410172.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_44 = math.max(var_64_35, arg_61_1.talkMaxDuration)

			if var_64_34 <= arg_61_1.time_ and arg_61_1.time_ < var_64_34 + var_64_44 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_34) / var_64_44

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_34 + var_64_44 and arg_61_1.time_ < var_64_34 + var_64_44 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play410172016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 410172016
		arg_65_1.duration_ = 10.93

		local var_65_0 = {
			ja = 10.933,
			CriLanguages = 6.166,
			zh = 6.166
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
				arg_65_0:Play410172017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10062"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos10062 = var_68_0.localPosition
				var_68_0.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10062", 4)

				local var_68_2 = var_68_0.childCount

				for iter_68_0 = 0, var_68_2 - 1 do
					local var_68_3 = var_68_0:GetChild(iter_68_0)

					if var_68_3.name == "" or not string.find(var_68_3.name, "split") then
						var_68_3.gameObject:SetActive(true)
					else
						var_68_3.gameObject:SetActive(false)
					end
				end
			end

			local var_68_4 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_4 then
				local var_68_5 = (arg_65_1.time_ - var_68_1) / var_68_4
				local var_68_6 = Vector3.New(370, -390, -290)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10062, var_68_6, var_68_5)
			end

			if arg_65_1.time_ >= var_68_1 + var_68_4 and arg_65_1.time_ < var_68_1 + var_68_4 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_68_7 = arg_65_1.actors_["10062"]
			local var_68_8 = 0

			if var_68_8 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.actorSpriteComps10062 == nil then
				arg_65_1.var_.actorSpriteComps10062 = var_68_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_9 = 0.034

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_9 and not isNil(var_68_7) then
				local var_68_10 = (arg_65_1.time_ - var_68_8) / var_68_9

				if arg_65_1.var_.actorSpriteComps10062 then
					for iter_68_1, iter_68_2 in pairs(arg_65_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_68_2 then
							if arg_65_1.isInRecall_ then
								local var_68_11 = Mathf.Lerp(iter_68_2.color.r, arg_65_1.hightColor1.r, var_68_10)
								local var_68_12 = Mathf.Lerp(iter_68_2.color.g, arg_65_1.hightColor1.g, var_68_10)
								local var_68_13 = Mathf.Lerp(iter_68_2.color.b, arg_65_1.hightColor1.b, var_68_10)

								iter_68_2.color = Color.New(var_68_11, var_68_12, var_68_13)
							else
								local var_68_14 = Mathf.Lerp(iter_68_2.color.r, 1, var_68_10)

								iter_68_2.color = Color.New(var_68_14, var_68_14, var_68_14)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_8 + var_68_9 and arg_65_1.time_ < var_68_8 + var_68_9 + arg_68_0 and not isNil(var_68_7) and arg_65_1.var_.actorSpriteComps10062 then
				for iter_68_3, iter_68_4 in pairs(arg_65_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_68_4 then
						if arg_65_1.isInRecall_ then
							iter_68_4.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10062 = nil
			end

			local var_68_15 = arg_65_1.actors_["1061"]
			local var_68_16 = 0

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.actorSpriteComps1061 == nil then
				arg_65_1.var_.actorSpriteComps1061 = var_68_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_17 = 0.034

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_17 and not isNil(var_68_15) then
				local var_68_18 = (arg_65_1.time_ - var_68_16) / var_68_17

				if arg_65_1.var_.actorSpriteComps1061 then
					for iter_68_5, iter_68_6 in pairs(arg_65_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_68_6 then
							if arg_65_1.isInRecall_ then
								local var_68_19 = Mathf.Lerp(iter_68_6.color.r, arg_65_1.hightColor2.r, var_68_18)
								local var_68_20 = Mathf.Lerp(iter_68_6.color.g, arg_65_1.hightColor2.g, var_68_18)
								local var_68_21 = Mathf.Lerp(iter_68_6.color.b, arg_65_1.hightColor2.b, var_68_18)

								iter_68_6.color = Color.New(var_68_19, var_68_20, var_68_21)
							else
								local var_68_22 = Mathf.Lerp(iter_68_6.color.r, 0.5, var_68_18)

								iter_68_6.color = Color.New(var_68_22, var_68_22, var_68_22)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_16 + var_68_17 and arg_65_1.time_ < var_68_16 + var_68_17 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.actorSpriteComps1061 then
				for iter_68_7, iter_68_8 in pairs(arg_65_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_68_8 then
						if arg_65_1.isInRecall_ then
							iter_68_8.color = arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_68_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps1061 = nil
			end

			local var_68_23 = 0
			local var_68_24 = 0.7

			if var_68_23 < arg_65_1.time_ and arg_65_1.time_ <= var_68_23 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_25 = arg_65_1:FormatText(StoryNameCfg[600].name)

				arg_65_1.leftNameTxt_.text = var_68_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_26 = arg_65_1:GetWordFromCfg(410172016)
				local var_68_27 = arg_65_1:FormatText(var_68_26.content)

				arg_65_1.text_.text = var_68_27

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_28 = 28
				local var_68_29 = utf8.len(var_68_27)
				local var_68_30 = var_68_28 <= 0 and var_68_24 or var_68_24 * (var_68_29 / var_68_28)

				if var_68_30 > 0 and var_68_24 < var_68_30 then
					arg_65_1.talkMaxDuration = var_68_30

					if var_68_30 + var_68_23 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_30 + var_68_23
					end
				end

				arg_65_1.text_.text = var_68_27
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172016", "story_v_out_410172.awb") ~= 0 then
					local var_68_31 = manager.audio:GetVoiceLength("story_v_out_410172", "410172016", "story_v_out_410172.awb") / 1000

					if var_68_31 + var_68_23 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_31 + var_68_23
					end

					if var_68_26.prefab_name ~= "" and arg_65_1.actors_[var_68_26.prefab_name] ~= nil then
						local var_68_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_26.prefab_name].transform, "story_v_out_410172", "410172016", "story_v_out_410172.awb")

						arg_65_1:RecordAudio("410172016", var_68_32)
						arg_65_1:RecordAudio("410172016", var_68_32)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_410172", "410172016", "story_v_out_410172.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_410172", "410172016", "story_v_out_410172.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_33 = math.max(var_68_24, arg_65_1.talkMaxDuration)

			if var_68_23 <= arg_65_1.time_ and arg_65_1.time_ < var_68_23 + var_68_33 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_23) / var_68_33

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_23 + var_68_33 and arg_65_1.time_ < var_68_23 + var_68_33 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play410172017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 410172017
		arg_69_1.duration_ = 3.33

		local var_69_0 = {
			ja = 1.333,
			CriLanguages = 3.333,
			zh = 3.333
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play410172018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1061"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1061 = var_72_0.localPosition
				var_72_0.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1061", 2)

				local var_72_2 = var_72_0.childCount

				for iter_72_0 = 0, var_72_2 - 1 do
					local var_72_3 = var_72_0:GetChild(iter_72_0)

					if var_72_3.name == "" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_4 then
				local var_72_5 = (arg_69_1.time_ - var_72_1) / var_72_4
				local var_72_6 = Vector3.New(-390, -490, 18)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1061, var_72_6, var_72_5)
			end

			if arg_69_1.time_ >= var_72_1 + var_72_4 and arg_69_1.time_ < var_72_1 + var_72_4 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_72_7 = arg_69_1.actors_["1061"]
			local var_72_8 = 0

			if var_72_8 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.actorSpriteComps1061 == nil then
				arg_69_1.var_.actorSpriteComps1061 = var_72_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_9 = 0.034

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_9 and not isNil(var_72_7) then
				local var_72_10 = (arg_69_1.time_ - var_72_8) / var_72_9

				if arg_69_1.var_.actorSpriteComps1061 then
					for iter_72_1, iter_72_2 in pairs(arg_69_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_72_2 then
							if arg_69_1.isInRecall_ then
								local var_72_11 = Mathf.Lerp(iter_72_2.color.r, arg_69_1.hightColor1.r, var_72_10)
								local var_72_12 = Mathf.Lerp(iter_72_2.color.g, arg_69_1.hightColor1.g, var_72_10)
								local var_72_13 = Mathf.Lerp(iter_72_2.color.b, arg_69_1.hightColor1.b, var_72_10)

								iter_72_2.color = Color.New(var_72_11, var_72_12, var_72_13)
							else
								local var_72_14 = Mathf.Lerp(iter_72_2.color.r, 1, var_72_10)

								iter_72_2.color = Color.New(var_72_14, var_72_14, var_72_14)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_8 + var_72_9 and arg_69_1.time_ < var_72_8 + var_72_9 + arg_72_0 and not isNil(var_72_7) and arg_69_1.var_.actorSpriteComps1061 then
				for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_72_4 then
						if arg_69_1.isInRecall_ then
							iter_72_4.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps1061 = nil
			end

			local var_72_15 = arg_69_1.actors_["10062"]
			local var_72_16 = 0

			if var_72_16 < arg_69_1.time_ and arg_69_1.time_ <= var_72_16 + arg_72_0 and not isNil(var_72_15) and arg_69_1.var_.actorSpriteComps10062 == nil then
				arg_69_1.var_.actorSpriteComps10062 = var_72_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_17 = 0.034

			if var_72_16 <= arg_69_1.time_ and arg_69_1.time_ < var_72_16 + var_72_17 and not isNil(var_72_15) then
				local var_72_18 = (arg_69_1.time_ - var_72_16) / var_72_17

				if arg_69_1.var_.actorSpriteComps10062 then
					for iter_72_5, iter_72_6 in pairs(arg_69_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_72_6 then
							if arg_69_1.isInRecall_ then
								local var_72_19 = Mathf.Lerp(iter_72_6.color.r, arg_69_1.hightColor2.r, var_72_18)
								local var_72_20 = Mathf.Lerp(iter_72_6.color.g, arg_69_1.hightColor2.g, var_72_18)
								local var_72_21 = Mathf.Lerp(iter_72_6.color.b, arg_69_1.hightColor2.b, var_72_18)

								iter_72_6.color = Color.New(var_72_19, var_72_20, var_72_21)
							else
								local var_72_22 = Mathf.Lerp(iter_72_6.color.r, 0.5, var_72_18)

								iter_72_6.color = Color.New(var_72_22, var_72_22, var_72_22)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_16 + var_72_17 and arg_69_1.time_ < var_72_16 + var_72_17 + arg_72_0 and not isNil(var_72_15) and arg_69_1.var_.actorSpriteComps10062 then
				for iter_72_7, iter_72_8 in pairs(arg_69_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_72_8 then
						if arg_69_1.isInRecall_ then
							iter_72_8.color = arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_72_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10062 = nil
			end

			local var_72_23 = 0
			local var_72_24 = 0.375

			if var_72_23 < arg_69_1.time_ and arg_69_1.time_ <= var_72_23 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_25 = arg_69_1:FormatText(StoryNameCfg[612].name)

				arg_69_1.leftNameTxt_.text = var_72_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_26 = arg_69_1:GetWordFromCfg(410172017)
				local var_72_27 = arg_69_1:FormatText(var_72_26.content)

				arg_69_1.text_.text = var_72_27

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_28 = 15
				local var_72_29 = utf8.len(var_72_27)
				local var_72_30 = var_72_28 <= 0 and var_72_24 or var_72_24 * (var_72_29 / var_72_28)

				if var_72_30 > 0 and var_72_24 < var_72_30 then
					arg_69_1.talkMaxDuration = var_72_30

					if var_72_30 + var_72_23 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_30 + var_72_23
					end
				end

				arg_69_1.text_.text = var_72_27
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172017", "story_v_out_410172.awb") ~= 0 then
					local var_72_31 = manager.audio:GetVoiceLength("story_v_out_410172", "410172017", "story_v_out_410172.awb") / 1000

					if var_72_31 + var_72_23 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_31 + var_72_23
					end

					if var_72_26.prefab_name ~= "" and arg_69_1.actors_[var_72_26.prefab_name] ~= nil then
						local var_72_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_26.prefab_name].transform, "story_v_out_410172", "410172017", "story_v_out_410172.awb")

						arg_69_1:RecordAudio("410172017", var_72_32)
						arg_69_1:RecordAudio("410172017", var_72_32)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_410172", "410172017", "story_v_out_410172.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_410172", "410172017", "story_v_out_410172.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_33 = math.max(var_72_24, arg_69_1.talkMaxDuration)

			if var_72_23 <= arg_69_1.time_ and arg_69_1.time_ < var_72_23 + var_72_33 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_23) / var_72_33

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_23 + var_72_33 and arg_69_1.time_ < var_72_23 + var_72_33 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play410172018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 410172018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play410172019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10062"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos10062 = var_76_0.localPosition
				var_76_0.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10062", 4)

				local var_76_2 = var_76_0.childCount

				for iter_76_0 = 0, var_76_2 - 1 do
					local var_76_3 = var_76_0:GetChild(iter_76_0)

					if var_76_3.name == "" or not string.find(var_76_3.name, "split") then
						var_76_3.gameObject:SetActive(true)
					else
						var_76_3.gameObject:SetActive(false)
					end
				end
			end

			local var_76_4 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_4 then
				local var_76_5 = (arg_73_1.time_ - var_76_1) / var_76_4
				local var_76_6 = Vector3.New(370, -390, -290)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10062, var_76_6, var_76_5)
			end

			if arg_73_1.time_ >= var_76_1 + var_76_4 and arg_73_1.time_ < var_76_1 + var_76_4 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_76_7 = arg_73_1.actors_["1061"].transform
			local var_76_8 = 0

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.var_.moveOldPos1061 = var_76_7.localPosition
				var_76_7.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1061", 7)

				local var_76_9 = var_76_7.childCount

				for iter_76_1 = 0, var_76_9 - 1 do
					local var_76_10 = var_76_7:GetChild(iter_76_1)

					if var_76_10.name == "" or not string.find(var_76_10.name, "split") then
						var_76_10.gameObject:SetActive(true)
					else
						var_76_10.gameObject:SetActive(false)
					end
				end
			end

			local var_76_11 = 0.001

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_11 then
				local var_76_12 = (arg_73_1.time_ - var_76_8) / var_76_11
				local var_76_13 = Vector3.New(0, -2000, 18)

				var_76_7.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1061, var_76_13, var_76_12)
			end

			if arg_73_1.time_ >= var_76_8 + var_76_11 and arg_73_1.time_ < var_76_8 + var_76_11 + arg_76_0 then
				var_76_7.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_76_14 = arg_73_1.actors_["10059"].transform
			local var_76_15 = 0

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 then
				arg_73_1.var_.moveOldPos10059 = var_76_14.localPosition
				var_76_14.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10059", 2)

				local var_76_16 = var_76_14.childCount

				for iter_76_2 = 0, var_76_16 - 1 do
					local var_76_17 = var_76_14:GetChild(iter_76_2)

					if var_76_17.name == "" or not string.find(var_76_17.name, "split") then
						var_76_17.gameObject:SetActive(true)
					else
						var_76_17.gameObject:SetActive(false)
					end
				end
			end

			local var_76_18 = 0.001

			if var_76_15 <= arg_73_1.time_ and arg_73_1.time_ < var_76_15 + var_76_18 then
				local var_76_19 = (arg_73_1.time_ - var_76_15) / var_76_18
				local var_76_20 = Vector3.New(-390, -530, 35)

				var_76_14.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10059, var_76_20, var_76_19)
			end

			if arg_73_1.time_ >= var_76_15 + var_76_18 and arg_73_1.time_ < var_76_15 + var_76_18 + arg_76_0 then
				var_76_14.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_76_21 = arg_73_1.actors_["10062"]
			local var_76_22 = 0

			if var_76_22 < arg_73_1.time_ and arg_73_1.time_ <= var_76_22 + arg_76_0 and not isNil(var_76_21) and arg_73_1.var_.actorSpriteComps10062 == nil then
				arg_73_1.var_.actorSpriteComps10062 = var_76_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_23 = 0.034

			if var_76_22 <= arg_73_1.time_ and arg_73_1.time_ < var_76_22 + var_76_23 and not isNil(var_76_21) then
				local var_76_24 = (arg_73_1.time_ - var_76_22) / var_76_23

				if arg_73_1.var_.actorSpriteComps10062 then
					for iter_76_3, iter_76_4 in pairs(arg_73_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_76_4 then
							if arg_73_1.isInRecall_ then
								local var_76_25 = Mathf.Lerp(iter_76_4.color.r, arg_73_1.hightColor2.r, var_76_24)
								local var_76_26 = Mathf.Lerp(iter_76_4.color.g, arg_73_1.hightColor2.g, var_76_24)
								local var_76_27 = Mathf.Lerp(iter_76_4.color.b, arg_73_1.hightColor2.b, var_76_24)

								iter_76_4.color = Color.New(var_76_25, var_76_26, var_76_27)
							else
								local var_76_28 = Mathf.Lerp(iter_76_4.color.r, 0.5, var_76_24)

								iter_76_4.color = Color.New(var_76_28, var_76_28, var_76_28)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_22 + var_76_23 and arg_73_1.time_ < var_76_22 + var_76_23 + arg_76_0 and not isNil(var_76_21) and arg_73_1.var_.actorSpriteComps10062 then
				for iter_76_5, iter_76_6 in pairs(arg_73_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_76_6 then
						if arg_73_1.isInRecall_ then
							iter_76_6.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10062 = nil
			end

			local var_76_29 = arg_73_1.actors_["1061"]
			local var_76_30 = 0

			if var_76_30 < arg_73_1.time_ and arg_73_1.time_ <= var_76_30 + arg_76_0 and not isNil(var_76_29) and arg_73_1.var_.actorSpriteComps1061 == nil then
				arg_73_1.var_.actorSpriteComps1061 = var_76_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_31 = 0.034

			if var_76_30 <= arg_73_1.time_ and arg_73_1.time_ < var_76_30 + var_76_31 and not isNil(var_76_29) then
				local var_76_32 = (arg_73_1.time_ - var_76_30) / var_76_31

				if arg_73_1.var_.actorSpriteComps1061 then
					for iter_76_7, iter_76_8 in pairs(arg_73_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_76_8 then
							if arg_73_1.isInRecall_ then
								local var_76_33 = Mathf.Lerp(iter_76_8.color.r, arg_73_1.hightColor2.r, var_76_32)
								local var_76_34 = Mathf.Lerp(iter_76_8.color.g, arg_73_1.hightColor2.g, var_76_32)
								local var_76_35 = Mathf.Lerp(iter_76_8.color.b, arg_73_1.hightColor2.b, var_76_32)

								iter_76_8.color = Color.New(var_76_33, var_76_34, var_76_35)
							else
								local var_76_36 = Mathf.Lerp(iter_76_8.color.r, 0.5, var_76_32)

								iter_76_8.color = Color.New(var_76_36, var_76_36, var_76_36)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_30 + var_76_31 and arg_73_1.time_ < var_76_30 + var_76_31 + arg_76_0 and not isNil(var_76_29) and arg_73_1.var_.actorSpriteComps1061 then
				for iter_76_9, iter_76_10 in pairs(arg_73_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_76_10 then
						if arg_73_1.isInRecall_ then
							iter_76_10.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps1061 = nil
			end

			local var_76_37 = arg_73_1.actors_["10059"]
			local var_76_38 = 0

			if var_76_38 < arg_73_1.time_ and arg_73_1.time_ <= var_76_38 + arg_76_0 and not isNil(var_76_37) and arg_73_1.var_.actorSpriteComps10059 == nil then
				arg_73_1.var_.actorSpriteComps10059 = var_76_37:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_39 = 0.034

			if var_76_38 <= arg_73_1.time_ and arg_73_1.time_ < var_76_38 + var_76_39 and not isNil(var_76_37) then
				local var_76_40 = (arg_73_1.time_ - var_76_38) / var_76_39

				if arg_73_1.var_.actorSpriteComps10059 then
					for iter_76_11, iter_76_12 in pairs(arg_73_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_76_12 then
							if arg_73_1.isInRecall_ then
								local var_76_41 = Mathf.Lerp(iter_76_12.color.r, arg_73_1.hightColor2.r, var_76_40)
								local var_76_42 = Mathf.Lerp(iter_76_12.color.g, arg_73_1.hightColor2.g, var_76_40)
								local var_76_43 = Mathf.Lerp(iter_76_12.color.b, arg_73_1.hightColor2.b, var_76_40)

								iter_76_12.color = Color.New(var_76_41, var_76_42, var_76_43)
							else
								local var_76_44 = Mathf.Lerp(iter_76_12.color.r, 0.5, var_76_40)

								iter_76_12.color = Color.New(var_76_44, var_76_44, var_76_44)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_38 + var_76_39 and arg_73_1.time_ < var_76_38 + var_76_39 + arg_76_0 and not isNil(var_76_37) and arg_73_1.var_.actorSpriteComps10059 then
				for iter_76_13, iter_76_14 in pairs(arg_73_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_76_14 then
						if arg_73_1.isInRecall_ then
							iter_76_14.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_14.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10059 = nil
			end

			local var_76_45 = 0
			local var_76_46 = 0.825

			if var_76_45 < arg_73_1.time_ and arg_73_1.time_ <= var_76_45 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_47 = arg_73_1:GetWordFromCfg(410172018)
				local var_76_48 = arg_73_1:FormatText(var_76_47.content)

				arg_73_1.text_.text = var_76_48

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_49 = 33
				local var_76_50 = utf8.len(var_76_48)
				local var_76_51 = var_76_49 <= 0 and var_76_46 or var_76_46 * (var_76_50 / var_76_49)

				if var_76_51 > 0 and var_76_46 < var_76_51 then
					arg_73_1.talkMaxDuration = var_76_51

					if var_76_51 + var_76_45 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_51 + var_76_45
					end
				end

				arg_73_1.text_.text = var_76_48
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_52 = math.max(var_76_46, arg_73_1.talkMaxDuration)

			if var_76_45 <= arg_73_1.time_ and arg_73_1.time_ < var_76_45 + var_76_52 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_45) / var_76_52

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_45 + var_76_52 and arg_73_1.time_ < var_76_45 + var_76_52 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play410172019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 410172019
		arg_77_1.duration_ = 5.03

		local var_77_0 = {
			ja = 5.033,
			CriLanguages = 3.933,
			zh = 3.933
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
				arg_77_0:Play410172020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10062"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos10062 = var_80_0.localPosition
				var_80_0.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10062", 4)

				local var_80_2 = var_80_0.childCount

				for iter_80_0 = 0, var_80_2 - 1 do
					local var_80_3 = var_80_0:GetChild(iter_80_0)

					if var_80_3.name == "" or not string.find(var_80_3.name, "split") then
						var_80_3.gameObject:SetActive(true)
					else
						var_80_3.gameObject:SetActive(false)
					end
				end
			end

			local var_80_4 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_4 then
				local var_80_5 = (arg_77_1.time_ - var_80_1) / var_80_4
				local var_80_6 = Vector3.New(370, -390, -290)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10062, var_80_6, var_80_5)
			end

			if arg_77_1.time_ >= var_80_1 + var_80_4 and arg_77_1.time_ < var_80_1 + var_80_4 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_80_7 = arg_77_1.actors_["10062"]
			local var_80_8 = 0

			if var_80_8 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps10062 == nil then
				arg_77_1.var_.actorSpriteComps10062 = var_80_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_9 = 0.034

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_9 and not isNil(var_80_7) then
				local var_80_10 = (arg_77_1.time_ - var_80_8) / var_80_9

				if arg_77_1.var_.actorSpriteComps10062 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_80_2 then
							if arg_77_1.isInRecall_ then
								local var_80_11 = Mathf.Lerp(iter_80_2.color.r, arg_77_1.hightColor1.r, var_80_10)
								local var_80_12 = Mathf.Lerp(iter_80_2.color.g, arg_77_1.hightColor1.g, var_80_10)
								local var_80_13 = Mathf.Lerp(iter_80_2.color.b, arg_77_1.hightColor1.b, var_80_10)

								iter_80_2.color = Color.New(var_80_11, var_80_12, var_80_13)
							else
								local var_80_14 = Mathf.Lerp(iter_80_2.color.r, 1, var_80_10)

								iter_80_2.color = Color.New(var_80_14, var_80_14, var_80_14)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_8 + var_80_9 and arg_77_1.time_ < var_80_8 + var_80_9 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps10062 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_80_4 then
						if arg_77_1.isInRecall_ then
							iter_80_4.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10062 = nil
			end

			local var_80_15 = arg_77_1.actors_["10059"]
			local var_80_16 = 0

			if var_80_16 < arg_77_1.time_ and arg_77_1.time_ <= var_80_16 + arg_80_0 and not isNil(var_80_15) and arg_77_1.var_.actorSpriteComps10059 == nil then
				arg_77_1.var_.actorSpriteComps10059 = var_80_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_17 = 0.034

			if var_80_16 <= arg_77_1.time_ and arg_77_1.time_ < var_80_16 + var_80_17 and not isNil(var_80_15) then
				local var_80_18 = (arg_77_1.time_ - var_80_16) / var_80_17

				if arg_77_1.var_.actorSpriteComps10059 then
					for iter_80_5, iter_80_6 in pairs(arg_77_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_80_6 then
							if arg_77_1.isInRecall_ then
								local var_80_19 = Mathf.Lerp(iter_80_6.color.r, arg_77_1.hightColor2.r, var_80_18)
								local var_80_20 = Mathf.Lerp(iter_80_6.color.g, arg_77_1.hightColor2.g, var_80_18)
								local var_80_21 = Mathf.Lerp(iter_80_6.color.b, arg_77_1.hightColor2.b, var_80_18)

								iter_80_6.color = Color.New(var_80_19, var_80_20, var_80_21)
							else
								local var_80_22 = Mathf.Lerp(iter_80_6.color.r, 0.5, var_80_18)

								iter_80_6.color = Color.New(var_80_22, var_80_22, var_80_22)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= var_80_16 + var_80_17 and arg_77_1.time_ < var_80_16 + var_80_17 + arg_80_0 and not isNil(var_80_15) and arg_77_1.var_.actorSpriteComps10059 then
				for iter_80_7, iter_80_8 in pairs(arg_77_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_80_8 then
						if arg_77_1.isInRecall_ then
							iter_80_8.color = arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_80_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10059 = nil
			end

			local var_80_23 = 0
			local var_80_24 = 0.275

			if var_80_23 < arg_77_1.time_ and arg_77_1.time_ <= var_80_23 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_25 = arg_77_1:FormatText(StoryNameCfg[600].name)

				arg_77_1.leftNameTxt_.text = var_80_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_26 = arg_77_1:GetWordFromCfg(410172019)
				local var_80_27 = arg_77_1:FormatText(var_80_26.content)

				arg_77_1.text_.text = var_80_27

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_28 = 11
				local var_80_29 = utf8.len(var_80_27)
				local var_80_30 = var_80_28 <= 0 and var_80_24 or var_80_24 * (var_80_29 / var_80_28)

				if var_80_30 > 0 and var_80_24 < var_80_30 then
					arg_77_1.talkMaxDuration = var_80_30

					if var_80_30 + var_80_23 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_30 + var_80_23
					end
				end

				arg_77_1.text_.text = var_80_27
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172019", "story_v_out_410172.awb") ~= 0 then
					local var_80_31 = manager.audio:GetVoiceLength("story_v_out_410172", "410172019", "story_v_out_410172.awb") / 1000

					if var_80_31 + var_80_23 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_31 + var_80_23
					end

					if var_80_26.prefab_name ~= "" and arg_77_1.actors_[var_80_26.prefab_name] ~= nil then
						local var_80_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_26.prefab_name].transform, "story_v_out_410172", "410172019", "story_v_out_410172.awb")

						arg_77_1:RecordAudio("410172019", var_80_32)
						arg_77_1:RecordAudio("410172019", var_80_32)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_410172", "410172019", "story_v_out_410172.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_410172", "410172019", "story_v_out_410172.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_33 = math.max(var_80_24, arg_77_1.talkMaxDuration)

			if var_80_23 <= arg_77_1.time_ and arg_77_1.time_ < var_80_23 + var_80_33 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_23) / var_80_33

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_23 + var_80_33 and arg_77_1.time_ < var_80_23 + var_80_33 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play410172020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 410172020
		arg_81_1.duration_ = 8.77

		local var_81_0 = {
			ja = 8.766,
			CriLanguages = 5.333,
			zh = 5.333
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
				arg_81_0:Play410172021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10059"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos10059 = var_84_0.localPosition
				var_84_0.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10059", 2)

				local var_84_2 = var_84_0.childCount

				for iter_84_0 = 0, var_84_2 - 1 do
					local var_84_3 = var_84_0:GetChild(iter_84_0)

					if var_84_3.name == "" or not string.find(var_84_3.name, "split") then
						var_84_3.gameObject:SetActive(true)
					else
						var_84_3.gameObject:SetActive(false)
					end
				end
			end

			local var_84_4 = 0.001

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_4 then
				local var_84_5 = (arg_81_1.time_ - var_84_1) / var_84_4
				local var_84_6 = Vector3.New(-390, -530, 35)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10059, var_84_6, var_84_5)
			end

			if arg_81_1.time_ >= var_84_1 + var_84_4 and arg_81_1.time_ < var_84_1 + var_84_4 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_84_7 = arg_81_1.actors_["10059"]
			local var_84_8 = 0

			if var_84_8 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 and not isNil(var_84_7) and arg_81_1.var_.actorSpriteComps10059 == nil then
				arg_81_1.var_.actorSpriteComps10059 = var_84_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_9 = 0.034

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_9 and not isNil(var_84_7) then
				local var_84_10 = (arg_81_1.time_ - var_84_8) / var_84_9

				if arg_81_1.var_.actorSpriteComps10059 then
					for iter_84_1, iter_84_2 in pairs(arg_81_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_84_2 then
							if arg_81_1.isInRecall_ then
								local var_84_11 = Mathf.Lerp(iter_84_2.color.r, arg_81_1.hightColor1.r, var_84_10)
								local var_84_12 = Mathf.Lerp(iter_84_2.color.g, arg_81_1.hightColor1.g, var_84_10)
								local var_84_13 = Mathf.Lerp(iter_84_2.color.b, arg_81_1.hightColor1.b, var_84_10)

								iter_84_2.color = Color.New(var_84_11, var_84_12, var_84_13)
							else
								local var_84_14 = Mathf.Lerp(iter_84_2.color.r, 1, var_84_10)

								iter_84_2.color = Color.New(var_84_14, var_84_14, var_84_14)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_8 + var_84_9 and arg_81_1.time_ < var_84_8 + var_84_9 + arg_84_0 and not isNil(var_84_7) and arg_81_1.var_.actorSpriteComps10059 then
				for iter_84_3, iter_84_4 in pairs(arg_81_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_84_4 then
						if arg_81_1.isInRecall_ then
							iter_84_4.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_84_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10059 = nil
			end

			local var_84_15 = arg_81_1.actors_["10062"]
			local var_84_16 = 0

			if var_84_16 < arg_81_1.time_ and arg_81_1.time_ <= var_84_16 + arg_84_0 and not isNil(var_84_15) and arg_81_1.var_.actorSpriteComps10062 == nil then
				arg_81_1.var_.actorSpriteComps10062 = var_84_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_17 = 0.034

			if var_84_16 <= arg_81_1.time_ and arg_81_1.time_ < var_84_16 + var_84_17 and not isNil(var_84_15) then
				local var_84_18 = (arg_81_1.time_ - var_84_16) / var_84_17

				if arg_81_1.var_.actorSpriteComps10062 then
					for iter_84_5, iter_84_6 in pairs(arg_81_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_84_6 then
							if arg_81_1.isInRecall_ then
								local var_84_19 = Mathf.Lerp(iter_84_6.color.r, arg_81_1.hightColor2.r, var_84_18)
								local var_84_20 = Mathf.Lerp(iter_84_6.color.g, arg_81_1.hightColor2.g, var_84_18)
								local var_84_21 = Mathf.Lerp(iter_84_6.color.b, arg_81_1.hightColor2.b, var_84_18)

								iter_84_6.color = Color.New(var_84_19, var_84_20, var_84_21)
							else
								local var_84_22 = Mathf.Lerp(iter_84_6.color.r, 0.5, var_84_18)

								iter_84_6.color = Color.New(var_84_22, var_84_22, var_84_22)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_16 + var_84_17 and arg_81_1.time_ < var_84_16 + var_84_17 + arg_84_0 and not isNil(var_84_15) and arg_81_1.var_.actorSpriteComps10062 then
				for iter_84_7, iter_84_8 in pairs(arg_81_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_84_8 then
						if arg_81_1.isInRecall_ then
							iter_84_8.color = arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_84_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10062 = nil
			end

			local var_84_23 = 0
			local var_84_24 = 0.7

			if var_84_23 < arg_81_1.time_ and arg_81_1.time_ <= var_84_23 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_25 = arg_81_1:FormatText(StoryNameCfg[596].name)

				arg_81_1.leftNameTxt_.text = var_84_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_26 = arg_81_1:GetWordFromCfg(410172020)
				local var_84_27 = arg_81_1:FormatText(var_84_26.content)

				arg_81_1.text_.text = var_84_27

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_28 = 28
				local var_84_29 = utf8.len(var_84_27)
				local var_84_30 = var_84_28 <= 0 and var_84_24 or var_84_24 * (var_84_29 / var_84_28)

				if var_84_30 > 0 and var_84_24 < var_84_30 then
					arg_81_1.talkMaxDuration = var_84_30

					if var_84_30 + var_84_23 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_30 + var_84_23
					end
				end

				arg_81_1.text_.text = var_84_27
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172020", "story_v_out_410172.awb") ~= 0 then
					local var_84_31 = manager.audio:GetVoiceLength("story_v_out_410172", "410172020", "story_v_out_410172.awb") / 1000

					if var_84_31 + var_84_23 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_31 + var_84_23
					end

					if var_84_26.prefab_name ~= "" and arg_81_1.actors_[var_84_26.prefab_name] ~= nil then
						local var_84_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_26.prefab_name].transform, "story_v_out_410172", "410172020", "story_v_out_410172.awb")

						arg_81_1:RecordAudio("410172020", var_84_32)
						arg_81_1:RecordAudio("410172020", var_84_32)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_410172", "410172020", "story_v_out_410172.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_410172", "410172020", "story_v_out_410172.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_33 = math.max(var_84_24, arg_81_1.talkMaxDuration)

			if var_84_23 <= arg_81_1.time_ and arg_81_1.time_ < var_84_23 + var_84_33 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_23) / var_84_33

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_23 + var_84_33 and arg_81_1.time_ < var_84_23 + var_84_33 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play410172021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 410172021
		arg_85_1.duration_ = 12.57

		local var_85_0 = {
			ja = 12.566,
			CriLanguages = 7.066,
			zh = 7.066
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
				arg_85_0:Play410172022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10059"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos10059 = var_88_0.localPosition
				var_88_0.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10059", 2)

				local var_88_2 = var_88_0.childCount

				for iter_88_0 = 0, var_88_2 - 1 do
					local var_88_3 = var_88_0:GetChild(iter_88_0)

					if var_88_3.name == "" or not string.find(var_88_3.name, "split") then
						var_88_3.gameObject:SetActive(true)
					else
						var_88_3.gameObject:SetActive(false)
					end
				end
			end

			local var_88_4 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_4 then
				local var_88_5 = (arg_85_1.time_ - var_88_1) / var_88_4
				local var_88_6 = Vector3.New(-390, -530, 35)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10059, var_88_6, var_88_5)
			end

			if arg_85_1.time_ >= var_88_1 + var_88_4 and arg_85_1.time_ < var_88_1 + var_88_4 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(-390, -530, 35)
			end

			local var_88_7 = arg_85_1.actors_["10059"]
			local var_88_8 = 0

			if var_88_8 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 and not isNil(var_88_7) and arg_85_1.var_.actorSpriteComps10059 == nil then
				arg_85_1.var_.actorSpriteComps10059 = var_88_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_9 = 0.034

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_9 and not isNil(var_88_7) then
				local var_88_10 = (arg_85_1.time_ - var_88_8) / var_88_9

				if arg_85_1.var_.actorSpriteComps10059 then
					for iter_88_1, iter_88_2 in pairs(arg_85_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_88_2 then
							if arg_85_1.isInRecall_ then
								local var_88_11 = Mathf.Lerp(iter_88_2.color.r, arg_85_1.hightColor1.r, var_88_10)
								local var_88_12 = Mathf.Lerp(iter_88_2.color.g, arg_85_1.hightColor1.g, var_88_10)
								local var_88_13 = Mathf.Lerp(iter_88_2.color.b, arg_85_1.hightColor1.b, var_88_10)

								iter_88_2.color = Color.New(var_88_11, var_88_12, var_88_13)
							else
								local var_88_14 = Mathf.Lerp(iter_88_2.color.r, 1, var_88_10)

								iter_88_2.color = Color.New(var_88_14, var_88_14, var_88_14)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_8 + var_88_9 and arg_85_1.time_ < var_88_8 + var_88_9 + arg_88_0 and not isNil(var_88_7) and arg_85_1.var_.actorSpriteComps10059 then
				for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_88_4 then
						if arg_85_1.isInRecall_ then
							iter_88_4.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10059 = nil
			end

			local var_88_15 = 0
			local var_88_16 = 0.725

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_17 = arg_85_1:FormatText(StoryNameCfg[596].name)

				arg_85_1.leftNameTxt_.text = var_88_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_18 = arg_85_1:GetWordFromCfg(410172021)
				local var_88_19 = arg_85_1:FormatText(var_88_18.content)

				arg_85_1.text_.text = var_88_19

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_20 = 29
				local var_88_21 = utf8.len(var_88_19)
				local var_88_22 = var_88_20 <= 0 and var_88_16 or var_88_16 * (var_88_21 / var_88_20)

				if var_88_22 > 0 and var_88_16 < var_88_22 then
					arg_85_1.talkMaxDuration = var_88_22

					if var_88_22 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_22 + var_88_15
					end
				end

				arg_85_1.text_.text = var_88_19
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172021", "story_v_out_410172.awb") ~= 0 then
					local var_88_23 = manager.audio:GetVoiceLength("story_v_out_410172", "410172021", "story_v_out_410172.awb") / 1000

					if var_88_23 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_15
					end

					if var_88_18.prefab_name ~= "" and arg_85_1.actors_[var_88_18.prefab_name] ~= nil then
						local var_88_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_18.prefab_name].transform, "story_v_out_410172", "410172021", "story_v_out_410172.awb")

						arg_85_1:RecordAudio("410172021", var_88_24)
						arg_85_1:RecordAudio("410172021", var_88_24)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_410172", "410172021", "story_v_out_410172.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_410172", "410172021", "story_v_out_410172.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_25 = math.max(var_88_16, arg_85_1.talkMaxDuration)

			if var_88_15 <= arg_85_1.time_ and arg_85_1.time_ < var_88_15 + var_88_25 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_15) / var_88_25

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_15 + var_88_25 and arg_85_1.time_ < var_88_15 + var_88_25 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play410172022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 410172022
		arg_89_1.duration_ = 2.1

		local var_89_0 = {
			ja = 2.1,
			CriLanguages = 1.133,
			zh = 1.133
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
				arg_89_0:Play410172023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10062"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos10062 = var_92_0.localPosition
				var_92_0.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10062", 4)

				local var_92_2 = var_92_0.childCount

				for iter_92_0 = 0, var_92_2 - 1 do
					local var_92_3 = var_92_0:GetChild(iter_92_0)

					if var_92_3.name == "" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_4 then
				local var_92_5 = (arg_89_1.time_ - var_92_1) / var_92_4
				local var_92_6 = Vector3.New(370, -390, -290)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10062, var_92_6, var_92_5)
			end

			if arg_89_1.time_ >= var_92_1 + var_92_4 and arg_89_1.time_ < var_92_1 + var_92_4 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_92_7 = arg_89_1.actors_["10059"]
			local var_92_8 = 0

			if var_92_8 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 and not isNil(var_92_7) and arg_89_1.var_.actorSpriteComps10059 == nil then
				arg_89_1.var_.actorSpriteComps10059 = var_92_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_9 = 0.034

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_9 and not isNil(var_92_7) then
				local var_92_10 = (arg_89_1.time_ - var_92_8) / var_92_9

				if arg_89_1.var_.actorSpriteComps10059 then
					for iter_92_1, iter_92_2 in pairs(arg_89_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_92_2 then
							if arg_89_1.isInRecall_ then
								local var_92_11 = Mathf.Lerp(iter_92_2.color.r, arg_89_1.hightColor2.r, var_92_10)
								local var_92_12 = Mathf.Lerp(iter_92_2.color.g, arg_89_1.hightColor2.g, var_92_10)
								local var_92_13 = Mathf.Lerp(iter_92_2.color.b, arg_89_1.hightColor2.b, var_92_10)

								iter_92_2.color = Color.New(var_92_11, var_92_12, var_92_13)
							else
								local var_92_14 = Mathf.Lerp(iter_92_2.color.r, 0.5, var_92_10)

								iter_92_2.color = Color.New(var_92_14, var_92_14, var_92_14)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_8 + var_92_9 and arg_89_1.time_ < var_92_8 + var_92_9 + arg_92_0 and not isNil(var_92_7) and arg_89_1.var_.actorSpriteComps10059 then
				for iter_92_3, iter_92_4 in pairs(arg_89_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_92_4 then
						if arg_89_1.isInRecall_ then
							iter_92_4.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10059 = nil
			end

			local var_92_15 = arg_89_1.actors_["10062"]
			local var_92_16 = 0

			if var_92_16 < arg_89_1.time_ and arg_89_1.time_ <= var_92_16 + arg_92_0 and not isNil(var_92_15) and arg_89_1.var_.actorSpriteComps10062 == nil then
				arg_89_1.var_.actorSpriteComps10062 = var_92_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_17 = 0.034

			if var_92_16 <= arg_89_1.time_ and arg_89_1.time_ < var_92_16 + var_92_17 and not isNil(var_92_15) then
				local var_92_18 = (arg_89_1.time_ - var_92_16) / var_92_17

				if arg_89_1.var_.actorSpriteComps10062 then
					for iter_92_5, iter_92_6 in pairs(arg_89_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_92_6 then
							if arg_89_1.isInRecall_ then
								local var_92_19 = Mathf.Lerp(iter_92_6.color.r, arg_89_1.hightColor1.r, var_92_18)
								local var_92_20 = Mathf.Lerp(iter_92_6.color.g, arg_89_1.hightColor1.g, var_92_18)
								local var_92_21 = Mathf.Lerp(iter_92_6.color.b, arg_89_1.hightColor1.b, var_92_18)

								iter_92_6.color = Color.New(var_92_19, var_92_20, var_92_21)
							else
								local var_92_22 = Mathf.Lerp(iter_92_6.color.r, 1, var_92_18)

								iter_92_6.color = Color.New(var_92_22, var_92_22, var_92_22)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_16 + var_92_17 and arg_89_1.time_ < var_92_16 + var_92_17 + arg_92_0 and not isNil(var_92_15) and arg_89_1.var_.actorSpriteComps10062 then
				for iter_92_7, iter_92_8 in pairs(arg_89_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_92_8 then
						if arg_89_1.isInRecall_ then
							iter_92_8.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10062 = nil
			end

			local var_92_23 = 0
			local var_92_24 = 0.05

			if var_92_23 < arg_89_1.time_ and arg_89_1.time_ <= var_92_23 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_25 = arg_89_1:FormatText(StoryNameCfg[600].name)

				arg_89_1.leftNameTxt_.text = var_92_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_26 = arg_89_1:GetWordFromCfg(410172022)
				local var_92_27 = arg_89_1:FormatText(var_92_26.content)

				arg_89_1.text_.text = var_92_27

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_28 = 2
				local var_92_29 = utf8.len(var_92_27)
				local var_92_30 = var_92_28 <= 0 and var_92_24 or var_92_24 * (var_92_29 / var_92_28)

				if var_92_30 > 0 and var_92_24 < var_92_30 then
					arg_89_1.talkMaxDuration = var_92_30

					if var_92_30 + var_92_23 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_30 + var_92_23
					end
				end

				arg_89_1.text_.text = var_92_27
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172022", "story_v_out_410172.awb") ~= 0 then
					local var_92_31 = manager.audio:GetVoiceLength("story_v_out_410172", "410172022", "story_v_out_410172.awb") / 1000

					if var_92_31 + var_92_23 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_31 + var_92_23
					end

					if var_92_26.prefab_name ~= "" and arg_89_1.actors_[var_92_26.prefab_name] ~= nil then
						local var_92_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_26.prefab_name].transform, "story_v_out_410172", "410172022", "story_v_out_410172.awb")

						arg_89_1:RecordAudio("410172022", var_92_32)
						arg_89_1:RecordAudio("410172022", var_92_32)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_410172", "410172022", "story_v_out_410172.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_410172", "410172022", "story_v_out_410172.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_33 = math.max(var_92_24, arg_89_1.talkMaxDuration)

			if var_92_23 <= arg_89_1.time_ and arg_89_1.time_ < var_92_23 + var_92_33 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_23) / var_92_33

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_23 + var_92_33 and arg_89_1.time_ < var_92_23 + var_92_33 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play410172023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 410172023
		arg_93_1.duration_ = 5.83

		local var_93_0 = {
			ja = 5.833,
			CriLanguages = 4.566,
			zh = 4.566
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
				arg_93_0:Play410172024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1061"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1061 = var_96_0.localPosition
				var_96_0.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1061", 2)

				local var_96_2 = var_96_0.childCount

				for iter_96_0 = 0, var_96_2 - 1 do
					local var_96_3 = var_96_0:GetChild(iter_96_0)

					if var_96_3.name == "" or not string.find(var_96_3.name, "split") then
						var_96_3.gameObject:SetActive(true)
					else
						var_96_3.gameObject:SetActive(false)
					end
				end
			end

			local var_96_4 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_4 then
				local var_96_5 = (arg_93_1.time_ - var_96_1) / var_96_4
				local var_96_6 = Vector3.New(-390, -490, 18)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1061, var_96_6, var_96_5)
			end

			if arg_93_1.time_ >= var_96_1 + var_96_4 and arg_93_1.time_ < var_96_1 + var_96_4 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_96_7 = arg_93_1.actors_["10059"].transform
			local var_96_8 = 0

			if var_96_8 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.var_.moveOldPos10059 = var_96_7.localPosition
				var_96_7.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10059", 7)

				local var_96_9 = var_96_7.childCount

				for iter_96_1 = 0, var_96_9 - 1 do
					local var_96_10 = var_96_7:GetChild(iter_96_1)

					if var_96_10.name == "" or not string.find(var_96_10.name, "split") then
						var_96_10.gameObject:SetActive(true)
					else
						var_96_10.gameObject:SetActive(false)
					end
				end
			end

			local var_96_11 = 0.001

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_11 then
				local var_96_12 = (arg_93_1.time_ - var_96_8) / var_96_11
				local var_96_13 = Vector3.New(0, -2000, 35)

				var_96_7.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10059, var_96_13, var_96_12)
			end

			if arg_93_1.time_ >= var_96_8 + var_96_11 and arg_93_1.time_ < var_96_8 + var_96_11 + arg_96_0 then
				var_96_7.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_96_14 = arg_93_1.actors_["1061"]
			local var_96_15 = 0

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 and not isNil(var_96_14) and arg_93_1.var_.actorSpriteComps1061 == nil then
				arg_93_1.var_.actorSpriteComps1061 = var_96_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_16 = 0.034

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_16 and not isNil(var_96_14) then
				local var_96_17 = (arg_93_1.time_ - var_96_15) / var_96_16

				if arg_93_1.var_.actorSpriteComps1061 then
					for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_96_3 then
							if arg_93_1.isInRecall_ then
								local var_96_18 = Mathf.Lerp(iter_96_3.color.r, arg_93_1.hightColor2.r, var_96_17)
								local var_96_19 = Mathf.Lerp(iter_96_3.color.g, arg_93_1.hightColor2.g, var_96_17)
								local var_96_20 = Mathf.Lerp(iter_96_3.color.b, arg_93_1.hightColor2.b, var_96_17)

								iter_96_3.color = Color.New(var_96_18, var_96_19, var_96_20)
							else
								local var_96_21 = Mathf.Lerp(iter_96_3.color.r, 0.5, var_96_17)

								iter_96_3.color = Color.New(var_96_21, var_96_21, var_96_21)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_15 + var_96_16 and arg_93_1.time_ < var_96_15 + var_96_16 + arg_96_0 and not isNil(var_96_14) and arg_93_1.var_.actorSpriteComps1061 then
				for iter_96_4, iter_96_5 in pairs(arg_93_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_96_5 then
						if arg_93_1.isInRecall_ then
							iter_96_5.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps1061 = nil
			end

			local var_96_22 = arg_93_1.actors_["10059"]
			local var_96_23 = 0

			if var_96_23 < arg_93_1.time_ and arg_93_1.time_ <= var_96_23 + arg_96_0 and not isNil(var_96_22) and arg_93_1.var_.actorSpriteComps10059 == nil then
				arg_93_1.var_.actorSpriteComps10059 = var_96_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_24 = 0.034

			if var_96_23 <= arg_93_1.time_ and arg_93_1.time_ < var_96_23 + var_96_24 and not isNil(var_96_22) then
				local var_96_25 = (arg_93_1.time_ - var_96_23) / var_96_24

				if arg_93_1.var_.actorSpriteComps10059 then
					for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_96_7 then
							if arg_93_1.isInRecall_ then
								local var_96_26 = Mathf.Lerp(iter_96_7.color.r, arg_93_1.hightColor2.r, var_96_25)
								local var_96_27 = Mathf.Lerp(iter_96_7.color.g, arg_93_1.hightColor2.g, var_96_25)
								local var_96_28 = Mathf.Lerp(iter_96_7.color.b, arg_93_1.hightColor2.b, var_96_25)

								iter_96_7.color = Color.New(var_96_26, var_96_27, var_96_28)
							else
								local var_96_29 = Mathf.Lerp(iter_96_7.color.r, 0.5, var_96_25)

								iter_96_7.color = Color.New(var_96_29, var_96_29, var_96_29)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_23 + var_96_24 and arg_93_1.time_ < var_96_23 + var_96_24 + arg_96_0 and not isNil(var_96_22) and arg_93_1.var_.actorSpriteComps10059 then
				for iter_96_8, iter_96_9 in pairs(arg_93_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_96_9 then
						if arg_93_1.isInRecall_ then
							iter_96_9.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10059 = nil
			end

			local var_96_30 = arg_93_1.actors_["10062"].transform
			local var_96_31 = 0

			if var_96_31 < arg_93_1.time_ and arg_93_1.time_ <= var_96_31 + arg_96_0 then
				arg_93_1.var_.moveOldPos10062 = var_96_30.localPosition
				var_96_30.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10062", 4)

				local var_96_32 = var_96_30.childCount

				for iter_96_10 = 0, var_96_32 - 1 do
					local var_96_33 = var_96_30:GetChild(iter_96_10)

					if var_96_33.name == "" or not string.find(var_96_33.name, "split") then
						var_96_33.gameObject:SetActive(true)
					else
						var_96_33.gameObject:SetActive(false)
					end
				end
			end

			local var_96_34 = 0.001

			if var_96_31 <= arg_93_1.time_ and arg_93_1.time_ < var_96_31 + var_96_34 then
				local var_96_35 = (arg_93_1.time_ - var_96_31) / var_96_34
				local var_96_36 = Vector3.New(370, -390, -290)

				var_96_30.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10062, var_96_36, var_96_35)
			end

			if arg_93_1.time_ >= var_96_31 + var_96_34 and arg_93_1.time_ < var_96_31 + var_96_34 + arg_96_0 then
				var_96_30.localPosition = Vector3.New(370, -390, -290)
			end

			local var_96_37 = arg_93_1.actors_["10062"]
			local var_96_38 = 0

			if var_96_38 < arg_93_1.time_ and arg_93_1.time_ <= var_96_38 + arg_96_0 and not isNil(var_96_37) and arg_93_1.var_.actorSpriteComps10062 == nil then
				arg_93_1.var_.actorSpriteComps10062 = var_96_37:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_39 = 0.034

			if var_96_38 <= arg_93_1.time_ and arg_93_1.time_ < var_96_38 + var_96_39 and not isNil(var_96_37) then
				local var_96_40 = (arg_93_1.time_ - var_96_38) / var_96_39

				if arg_93_1.var_.actorSpriteComps10062 then
					for iter_96_11, iter_96_12 in pairs(arg_93_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_96_12 then
							if arg_93_1.isInRecall_ then
								local var_96_41 = Mathf.Lerp(iter_96_12.color.r, arg_93_1.hightColor1.r, var_96_40)
								local var_96_42 = Mathf.Lerp(iter_96_12.color.g, arg_93_1.hightColor1.g, var_96_40)
								local var_96_43 = Mathf.Lerp(iter_96_12.color.b, arg_93_1.hightColor1.b, var_96_40)

								iter_96_12.color = Color.New(var_96_41, var_96_42, var_96_43)
							else
								local var_96_44 = Mathf.Lerp(iter_96_12.color.r, 1, var_96_40)

								iter_96_12.color = Color.New(var_96_44, var_96_44, var_96_44)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_38 + var_96_39 and arg_93_1.time_ < var_96_38 + var_96_39 + arg_96_0 and not isNil(var_96_37) and arg_93_1.var_.actorSpriteComps10062 then
				for iter_96_13, iter_96_14 in pairs(arg_93_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_96_14 then
						if arg_93_1.isInRecall_ then
							iter_96_14.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_14.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10062 = nil
			end

			local var_96_45 = 0
			local var_96_46 = 0.325

			if var_96_45 < arg_93_1.time_ and arg_93_1.time_ <= var_96_45 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_47 = arg_93_1:FormatText(StoryNameCfg[600].name)

				arg_93_1.leftNameTxt_.text = var_96_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_48 = arg_93_1:GetWordFromCfg(410172023)
				local var_96_49 = arg_93_1:FormatText(var_96_48.content)

				arg_93_1.text_.text = var_96_49

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_50 = 13
				local var_96_51 = utf8.len(var_96_49)
				local var_96_52 = var_96_50 <= 0 and var_96_46 or var_96_46 * (var_96_51 / var_96_50)

				if var_96_52 > 0 and var_96_46 < var_96_52 then
					arg_93_1.talkMaxDuration = var_96_52

					if var_96_52 + var_96_45 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_52 + var_96_45
					end
				end

				arg_93_1.text_.text = var_96_49
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172023", "story_v_out_410172.awb") ~= 0 then
					local var_96_53 = manager.audio:GetVoiceLength("story_v_out_410172", "410172023", "story_v_out_410172.awb") / 1000

					if var_96_53 + var_96_45 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_53 + var_96_45
					end

					if var_96_48.prefab_name ~= "" and arg_93_1.actors_[var_96_48.prefab_name] ~= nil then
						local var_96_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_48.prefab_name].transform, "story_v_out_410172", "410172023", "story_v_out_410172.awb")

						arg_93_1:RecordAudio("410172023", var_96_54)
						arg_93_1:RecordAudio("410172023", var_96_54)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_410172", "410172023", "story_v_out_410172.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_410172", "410172023", "story_v_out_410172.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_55 = math.max(var_96_46, arg_93_1.talkMaxDuration)

			if var_96_45 <= arg_93_1.time_ and arg_93_1.time_ < var_96_45 + var_96_55 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_45) / var_96_55

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_45 + var_96_55 and arg_93_1.time_ < var_96_45 + var_96_55 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play410172024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 410172024
		arg_97_1.duration_ = 3.83

		local var_97_0 = {
			ja = 3.833,
			CriLanguages = 2.266,
			zh = 2.266
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
				arg_97_0:Play410172025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1061"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos1061 = var_100_0.localPosition
				var_100_0.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1061", 2)

				local var_100_2 = var_100_0.childCount

				for iter_100_0 = 0, var_100_2 - 1 do
					local var_100_3 = var_100_0:GetChild(iter_100_0)

					if var_100_3.name == "split_5" or not string.find(var_100_3.name, "split") then
						var_100_3.gameObject:SetActive(true)
					else
						var_100_3.gameObject:SetActive(false)
					end
				end
			end

			local var_100_4 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_4 then
				local var_100_5 = (arg_97_1.time_ - var_100_1) / var_100_4
				local var_100_6 = Vector3.New(-390, -490, 18)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1061, var_100_6, var_100_5)
			end

			if arg_97_1.time_ >= var_100_1 + var_100_4 and arg_97_1.time_ < var_100_1 + var_100_4 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_100_7 = arg_97_1.actors_["1061"]
			local var_100_8 = 0

			if var_100_8 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 and not isNil(var_100_7) and arg_97_1.var_.actorSpriteComps1061 == nil then
				arg_97_1.var_.actorSpriteComps1061 = var_100_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_9 = 0.034

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_9 and not isNil(var_100_7) then
				local var_100_10 = (arg_97_1.time_ - var_100_8) / var_100_9

				if arg_97_1.var_.actorSpriteComps1061 then
					for iter_100_1, iter_100_2 in pairs(arg_97_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_100_2 then
							if arg_97_1.isInRecall_ then
								local var_100_11 = Mathf.Lerp(iter_100_2.color.r, arg_97_1.hightColor1.r, var_100_10)
								local var_100_12 = Mathf.Lerp(iter_100_2.color.g, arg_97_1.hightColor1.g, var_100_10)
								local var_100_13 = Mathf.Lerp(iter_100_2.color.b, arg_97_1.hightColor1.b, var_100_10)

								iter_100_2.color = Color.New(var_100_11, var_100_12, var_100_13)
							else
								local var_100_14 = Mathf.Lerp(iter_100_2.color.r, 1, var_100_10)

								iter_100_2.color = Color.New(var_100_14, var_100_14, var_100_14)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_8 + var_100_9 and arg_97_1.time_ < var_100_8 + var_100_9 + arg_100_0 and not isNil(var_100_7) and arg_97_1.var_.actorSpriteComps1061 then
				for iter_100_3, iter_100_4 in pairs(arg_97_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_100_4 then
						if arg_97_1.isInRecall_ then
							iter_100_4.color = arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_100_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps1061 = nil
			end

			local var_100_15 = arg_97_1.actors_["10062"]
			local var_100_16 = 0

			if var_100_16 < arg_97_1.time_ and arg_97_1.time_ <= var_100_16 + arg_100_0 and not isNil(var_100_15) and arg_97_1.var_.actorSpriteComps10062 == nil then
				arg_97_1.var_.actorSpriteComps10062 = var_100_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_17 = 0.034

			if var_100_16 <= arg_97_1.time_ and arg_97_1.time_ < var_100_16 + var_100_17 and not isNil(var_100_15) then
				local var_100_18 = (arg_97_1.time_ - var_100_16) / var_100_17

				if arg_97_1.var_.actorSpriteComps10062 then
					for iter_100_5, iter_100_6 in pairs(arg_97_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_100_6 then
							if arg_97_1.isInRecall_ then
								local var_100_19 = Mathf.Lerp(iter_100_6.color.r, arg_97_1.hightColor2.r, var_100_18)
								local var_100_20 = Mathf.Lerp(iter_100_6.color.g, arg_97_1.hightColor2.g, var_100_18)
								local var_100_21 = Mathf.Lerp(iter_100_6.color.b, arg_97_1.hightColor2.b, var_100_18)

								iter_100_6.color = Color.New(var_100_19, var_100_20, var_100_21)
							else
								local var_100_22 = Mathf.Lerp(iter_100_6.color.r, 0.5, var_100_18)

								iter_100_6.color = Color.New(var_100_22, var_100_22, var_100_22)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_16 + var_100_17 and arg_97_1.time_ < var_100_16 + var_100_17 + arg_100_0 and not isNil(var_100_15) and arg_97_1.var_.actorSpriteComps10062 then
				for iter_100_7, iter_100_8 in pairs(arg_97_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_100_8 then
						if arg_97_1.isInRecall_ then
							iter_100_8.color = arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_100_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10062 = nil
			end

			local var_100_23 = 0
			local var_100_24 = 0.4

			if var_100_23 < arg_97_1.time_ and arg_97_1.time_ <= var_100_23 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_25 = arg_97_1:FormatText(StoryNameCfg[612].name)

				arg_97_1.leftNameTxt_.text = var_100_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_26 = arg_97_1:GetWordFromCfg(410172024)
				local var_100_27 = arg_97_1:FormatText(var_100_26.content)

				arg_97_1.text_.text = var_100_27

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_28 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172024", "story_v_out_410172.awb") ~= 0 then
					local var_100_31 = manager.audio:GetVoiceLength("story_v_out_410172", "410172024", "story_v_out_410172.awb") / 1000

					if var_100_31 + var_100_23 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_31 + var_100_23
					end

					if var_100_26.prefab_name ~= "" and arg_97_1.actors_[var_100_26.prefab_name] ~= nil then
						local var_100_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_26.prefab_name].transform, "story_v_out_410172", "410172024", "story_v_out_410172.awb")

						arg_97_1:RecordAudio("410172024", var_100_32)
						arg_97_1:RecordAudio("410172024", var_100_32)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_410172", "410172024", "story_v_out_410172.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_410172", "410172024", "story_v_out_410172.awb")
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
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play410172025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 410172025
		arg_101_1.duration_ = 3.47

		local var_101_0 = {
			ja = 3.466,
			CriLanguages = 2.4,
			zh = 2.4
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
				arg_101_0:Play410172026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10062"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos10062 = var_104_0.localPosition
				var_104_0.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10062", 4)

				local var_104_2 = var_104_0.childCount

				for iter_104_0 = 0, var_104_2 - 1 do
					local var_104_3 = var_104_0:GetChild(iter_104_0)

					if var_104_3.name == "" or not string.find(var_104_3.name, "split") then
						var_104_3.gameObject:SetActive(true)
					else
						var_104_3.gameObject:SetActive(false)
					end
				end
			end

			local var_104_4 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_4 then
				local var_104_5 = (arg_101_1.time_ - var_104_1) / var_104_4
				local var_104_6 = Vector3.New(370, -390, -290)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10062, var_104_6, var_104_5)
			end

			if arg_101_1.time_ >= var_104_1 + var_104_4 and arg_101_1.time_ < var_104_1 + var_104_4 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_104_7 = arg_101_1.actors_["10062"]
			local var_104_8 = 0

			if var_104_8 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.actorSpriteComps10062 == nil then
				arg_101_1.var_.actorSpriteComps10062 = var_104_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_9 = 0.034

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_9 and not isNil(var_104_7) then
				local var_104_10 = (arg_101_1.time_ - var_104_8) / var_104_9

				if arg_101_1.var_.actorSpriteComps10062 then
					for iter_104_1, iter_104_2 in pairs(arg_101_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_104_2 then
							if arg_101_1.isInRecall_ then
								local var_104_11 = Mathf.Lerp(iter_104_2.color.r, arg_101_1.hightColor1.r, var_104_10)
								local var_104_12 = Mathf.Lerp(iter_104_2.color.g, arg_101_1.hightColor1.g, var_104_10)
								local var_104_13 = Mathf.Lerp(iter_104_2.color.b, arg_101_1.hightColor1.b, var_104_10)

								iter_104_2.color = Color.New(var_104_11, var_104_12, var_104_13)
							else
								local var_104_14 = Mathf.Lerp(iter_104_2.color.r, 1, var_104_10)

								iter_104_2.color = Color.New(var_104_14, var_104_14, var_104_14)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_8 + var_104_9 and arg_101_1.time_ < var_104_8 + var_104_9 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.actorSpriteComps10062 then
				for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_104_4 then
						if arg_101_1.isInRecall_ then
							iter_104_4.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10062 = nil
			end

			local var_104_15 = arg_101_1.actors_["1061"]
			local var_104_16 = 0

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 and not isNil(var_104_15) and arg_101_1.var_.actorSpriteComps1061 == nil then
				arg_101_1.var_.actorSpriteComps1061 = var_104_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_17 = 0.034

			if var_104_16 <= arg_101_1.time_ and arg_101_1.time_ < var_104_16 + var_104_17 and not isNil(var_104_15) then
				local var_104_18 = (arg_101_1.time_ - var_104_16) / var_104_17

				if arg_101_1.var_.actorSpriteComps1061 then
					for iter_104_5, iter_104_6 in pairs(arg_101_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_104_6 then
							if arg_101_1.isInRecall_ then
								local var_104_19 = Mathf.Lerp(iter_104_6.color.r, arg_101_1.hightColor2.r, var_104_18)
								local var_104_20 = Mathf.Lerp(iter_104_6.color.g, arg_101_1.hightColor2.g, var_104_18)
								local var_104_21 = Mathf.Lerp(iter_104_6.color.b, arg_101_1.hightColor2.b, var_104_18)

								iter_104_6.color = Color.New(var_104_19, var_104_20, var_104_21)
							else
								local var_104_22 = Mathf.Lerp(iter_104_6.color.r, 0.5, var_104_18)

								iter_104_6.color = Color.New(var_104_22, var_104_22, var_104_22)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_16 + var_104_17 and arg_101_1.time_ < var_104_16 + var_104_17 + arg_104_0 and not isNil(var_104_15) and arg_101_1.var_.actorSpriteComps1061 then
				for iter_104_7, iter_104_8 in pairs(arg_101_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_104_8 then
						if arg_101_1.isInRecall_ then
							iter_104_8.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps1061 = nil
			end

			local var_104_23 = 0
			local var_104_24 = 0.2

			if var_104_23 < arg_101_1.time_ and arg_101_1.time_ <= var_104_23 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_25 = arg_101_1:FormatText(StoryNameCfg[600].name)

				arg_101_1.leftNameTxt_.text = var_104_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_26 = arg_101_1:GetWordFromCfg(410172025)
				local var_104_27 = arg_101_1:FormatText(var_104_26.content)

				arg_101_1.text_.text = var_104_27

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_28 = 8
				local var_104_29 = utf8.len(var_104_27)
				local var_104_30 = var_104_28 <= 0 and var_104_24 or var_104_24 * (var_104_29 / var_104_28)

				if var_104_30 > 0 and var_104_24 < var_104_30 then
					arg_101_1.talkMaxDuration = var_104_30

					if var_104_30 + var_104_23 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_30 + var_104_23
					end
				end

				arg_101_1.text_.text = var_104_27
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172025", "story_v_out_410172.awb") ~= 0 then
					local var_104_31 = manager.audio:GetVoiceLength("story_v_out_410172", "410172025", "story_v_out_410172.awb") / 1000

					if var_104_31 + var_104_23 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_31 + var_104_23
					end

					if var_104_26.prefab_name ~= "" and arg_101_1.actors_[var_104_26.prefab_name] ~= nil then
						local var_104_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_26.prefab_name].transform, "story_v_out_410172", "410172025", "story_v_out_410172.awb")

						arg_101_1:RecordAudio("410172025", var_104_32)
						arg_101_1:RecordAudio("410172025", var_104_32)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_410172", "410172025", "story_v_out_410172.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_410172", "410172025", "story_v_out_410172.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_33 = math.max(var_104_24, arg_101_1.talkMaxDuration)

			if var_104_23 <= arg_101_1.time_ and arg_101_1.time_ < var_104_23 + var_104_33 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_23) / var_104_33

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_23 + var_104_33 and arg_101_1.time_ < var_104_23 + var_104_33 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play410172026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 410172026
		arg_105_1.duration_ = 16.83

		local var_105_0 = {
			ja = 16.833,
			CriLanguages = 11.2,
			zh = 11.2
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
				arg_105_0:Play410172027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1061"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos1061 = var_108_0.localPosition
				var_108_0.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("1061", 2)

				local var_108_2 = var_108_0.childCount

				for iter_108_0 = 0, var_108_2 - 1 do
					local var_108_3 = var_108_0:GetChild(iter_108_0)

					if var_108_3.name == "" or not string.find(var_108_3.name, "split") then
						var_108_3.gameObject:SetActive(true)
					else
						var_108_3.gameObject:SetActive(false)
					end
				end
			end

			local var_108_4 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_4 then
				local var_108_5 = (arg_105_1.time_ - var_108_1) / var_108_4
				local var_108_6 = Vector3.New(-390, -490, 18)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1061, var_108_6, var_108_5)
			end

			if arg_105_1.time_ >= var_108_1 + var_108_4 and arg_105_1.time_ < var_108_1 + var_108_4 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_108_7 = arg_105_1.actors_["1061"]
			local var_108_8 = 0

			if var_108_8 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 and not isNil(var_108_7) and arg_105_1.var_.actorSpriteComps1061 == nil then
				arg_105_1.var_.actorSpriteComps1061 = var_108_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_9 = 0.034

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_9 and not isNil(var_108_7) then
				local var_108_10 = (arg_105_1.time_ - var_108_8) / var_108_9

				if arg_105_1.var_.actorSpriteComps1061 then
					for iter_108_1, iter_108_2 in pairs(arg_105_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_108_2 then
							if arg_105_1.isInRecall_ then
								local var_108_11 = Mathf.Lerp(iter_108_2.color.r, arg_105_1.hightColor1.r, var_108_10)
								local var_108_12 = Mathf.Lerp(iter_108_2.color.g, arg_105_1.hightColor1.g, var_108_10)
								local var_108_13 = Mathf.Lerp(iter_108_2.color.b, arg_105_1.hightColor1.b, var_108_10)

								iter_108_2.color = Color.New(var_108_11, var_108_12, var_108_13)
							else
								local var_108_14 = Mathf.Lerp(iter_108_2.color.r, 1, var_108_10)

								iter_108_2.color = Color.New(var_108_14, var_108_14, var_108_14)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_8 + var_108_9 and arg_105_1.time_ < var_108_8 + var_108_9 + arg_108_0 and not isNil(var_108_7) and arg_105_1.var_.actorSpriteComps1061 then
				for iter_108_3, iter_108_4 in pairs(arg_105_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_108_4 then
						if arg_105_1.isInRecall_ then
							iter_108_4.color = arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_108_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps1061 = nil
			end

			local var_108_15 = arg_105_1.actors_["10062"]
			local var_108_16 = 0

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 and not isNil(var_108_15) and arg_105_1.var_.actorSpriteComps10062 == nil then
				arg_105_1.var_.actorSpriteComps10062 = var_108_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_17 = 0.034

			if var_108_16 <= arg_105_1.time_ and arg_105_1.time_ < var_108_16 + var_108_17 and not isNil(var_108_15) then
				local var_108_18 = (arg_105_1.time_ - var_108_16) / var_108_17

				if arg_105_1.var_.actorSpriteComps10062 then
					for iter_108_5, iter_108_6 in pairs(arg_105_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_108_6 then
							if arg_105_1.isInRecall_ then
								local var_108_19 = Mathf.Lerp(iter_108_6.color.r, arg_105_1.hightColor2.r, var_108_18)
								local var_108_20 = Mathf.Lerp(iter_108_6.color.g, arg_105_1.hightColor2.g, var_108_18)
								local var_108_21 = Mathf.Lerp(iter_108_6.color.b, arg_105_1.hightColor2.b, var_108_18)

								iter_108_6.color = Color.New(var_108_19, var_108_20, var_108_21)
							else
								local var_108_22 = Mathf.Lerp(iter_108_6.color.r, 0.5, var_108_18)

								iter_108_6.color = Color.New(var_108_22, var_108_22, var_108_22)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_16 + var_108_17 and arg_105_1.time_ < var_108_16 + var_108_17 + arg_108_0 and not isNil(var_108_15) and arg_105_1.var_.actorSpriteComps10062 then
				for iter_108_7, iter_108_8 in pairs(arg_105_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_108_8 then
						if arg_105_1.isInRecall_ then
							iter_108_8.color = arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_108_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10062 = nil
			end

			local var_108_23 = 0
			local var_108_24 = 1.125

			if var_108_23 < arg_105_1.time_ and arg_105_1.time_ <= var_108_23 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_25 = arg_105_1:FormatText(StoryNameCfg[612].name)

				arg_105_1.leftNameTxt_.text = var_108_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_26 = arg_105_1:GetWordFromCfg(410172026)
				local var_108_27 = arg_105_1:FormatText(var_108_26.content)

				arg_105_1.text_.text = var_108_27

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_28 = 45
				local var_108_29 = utf8.len(var_108_27)
				local var_108_30 = var_108_28 <= 0 and var_108_24 or var_108_24 * (var_108_29 / var_108_28)

				if var_108_30 > 0 and var_108_24 < var_108_30 then
					arg_105_1.talkMaxDuration = var_108_30

					if var_108_30 + var_108_23 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_30 + var_108_23
					end
				end

				arg_105_1.text_.text = var_108_27
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172026", "story_v_out_410172.awb") ~= 0 then
					local var_108_31 = manager.audio:GetVoiceLength("story_v_out_410172", "410172026", "story_v_out_410172.awb") / 1000

					if var_108_31 + var_108_23 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_31 + var_108_23
					end

					if var_108_26.prefab_name ~= "" and arg_105_1.actors_[var_108_26.prefab_name] ~= nil then
						local var_108_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_26.prefab_name].transform, "story_v_out_410172", "410172026", "story_v_out_410172.awb")

						arg_105_1:RecordAudio("410172026", var_108_32)
						arg_105_1:RecordAudio("410172026", var_108_32)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_410172", "410172026", "story_v_out_410172.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_410172", "410172026", "story_v_out_410172.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_33 = math.max(var_108_24, arg_105_1.talkMaxDuration)

			if var_108_23 <= arg_105_1.time_ and arg_105_1.time_ < var_108_23 + var_108_33 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_23) / var_108_33

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_23 + var_108_33 and arg_105_1.time_ < var_108_23 + var_108_33 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play410172027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 410172027
		arg_109_1.duration_ = 5.83

		local var_109_0 = {
			ja = 5.833,
			CriLanguages = 4.2,
			zh = 4.2
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
				arg_109_0:Play410172028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10062"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos10062 = var_112_0.localPosition
				var_112_0.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10062", 4)

				local var_112_2 = var_112_0.childCount

				for iter_112_0 = 0, var_112_2 - 1 do
					local var_112_3 = var_112_0:GetChild(iter_112_0)

					if var_112_3.name == "" or not string.find(var_112_3.name, "split") then
						var_112_3.gameObject:SetActive(true)
					else
						var_112_3.gameObject:SetActive(false)
					end
				end
			end

			local var_112_4 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_4 then
				local var_112_5 = (arg_109_1.time_ - var_112_1) / var_112_4
				local var_112_6 = Vector3.New(370, -390, -290)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10062, var_112_6, var_112_5)
			end

			if arg_109_1.time_ >= var_112_1 + var_112_4 and arg_109_1.time_ < var_112_1 + var_112_4 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_112_7 = arg_109_1.actors_["10062"]
			local var_112_8 = 0

			if var_112_8 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps10062 == nil then
				arg_109_1.var_.actorSpriteComps10062 = var_112_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_9 = 0.034

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_9 and not isNil(var_112_7) then
				local var_112_10 = (arg_109_1.time_ - var_112_8) / var_112_9

				if arg_109_1.var_.actorSpriteComps10062 then
					for iter_112_1, iter_112_2 in pairs(arg_109_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_112_2 then
							if arg_109_1.isInRecall_ then
								local var_112_11 = Mathf.Lerp(iter_112_2.color.r, arg_109_1.hightColor1.r, var_112_10)
								local var_112_12 = Mathf.Lerp(iter_112_2.color.g, arg_109_1.hightColor1.g, var_112_10)
								local var_112_13 = Mathf.Lerp(iter_112_2.color.b, arg_109_1.hightColor1.b, var_112_10)

								iter_112_2.color = Color.New(var_112_11, var_112_12, var_112_13)
							else
								local var_112_14 = Mathf.Lerp(iter_112_2.color.r, 1, var_112_10)

								iter_112_2.color = Color.New(var_112_14, var_112_14, var_112_14)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_8 + var_112_9 and arg_109_1.time_ < var_112_8 + var_112_9 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps10062 then
				for iter_112_3, iter_112_4 in pairs(arg_109_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_112_4 then
						if arg_109_1.isInRecall_ then
							iter_112_4.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps10062 = nil
			end

			local var_112_15 = arg_109_1.actors_["1061"]
			local var_112_16 = 0

			if var_112_16 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 and not isNil(var_112_15) and arg_109_1.var_.actorSpriteComps1061 == nil then
				arg_109_1.var_.actorSpriteComps1061 = var_112_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_17 = 0.034

			if var_112_16 <= arg_109_1.time_ and arg_109_1.time_ < var_112_16 + var_112_17 and not isNil(var_112_15) then
				local var_112_18 = (arg_109_1.time_ - var_112_16) / var_112_17

				if arg_109_1.var_.actorSpriteComps1061 then
					for iter_112_5, iter_112_6 in pairs(arg_109_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_112_6 then
							if arg_109_1.isInRecall_ then
								local var_112_19 = Mathf.Lerp(iter_112_6.color.r, arg_109_1.hightColor2.r, var_112_18)
								local var_112_20 = Mathf.Lerp(iter_112_6.color.g, arg_109_1.hightColor2.g, var_112_18)
								local var_112_21 = Mathf.Lerp(iter_112_6.color.b, arg_109_1.hightColor2.b, var_112_18)

								iter_112_6.color = Color.New(var_112_19, var_112_20, var_112_21)
							else
								local var_112_22 = Mathf.Lerp(iter_112_6.color.r, 0.5, var_112_18)

								iter_112_6.color = Color.New(var_112_22, var_112_22, var_112_22)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= var_112_16 + var_112_17 and arg_109_1.time_ < var_112_16 + var_112_17 + arg_112_0 and not isNil(var_112_15) and arg_109_1.var_.actorSpriteComps1061 then
				for iter_112_7, iter_112_8 in pairs(arg_109_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_112_8 then
						if arg_109_1.isInRecall_ then
							iter_112_8.color = arg_109_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_112_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps1061 = nil
			end

			local var_112_23 = 0
			local var_112_24 = 0.425

			if var_112_23 < arg_109_1.time_ and arg_109_1.time_ <= var_112_23 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_25 = arg_109_1:FormatText(StoryNameCfg[600].name)

				arg_109_1.leftNameTxt_.text = var_112_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_26 = arg_109_1:GetWordFromCfg(410172027)
				local var_112_27 = arg_109_1:FormatText(var_112_26.content)

				arg_109_1.text_.text = var_112_27

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_28 = 17
				local var_112_29 = utf8.len(var_112_27)
				local var_112_30 = var_112_28 <= 0 and var_112_24 or var_112_24 * (var_112_29 / var_112_28)

				if var_112_30 > 0 and var_112_24 < var_112_30 then
					arg_109_1.talkMaxDuration = var_112_30

					if var_112_30 + var_112_23 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_30 + var_112_23
					end
				end

				arg_109_1.text_.text = var_112_27
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172027", "story_v_out_410172.awb") ~= 0 then
					local var_112_31 = manager.audio:GetVoiceLength("story_v_out_410172", "410172027", "story_v_out_410172.awb") / 1000

					if var_112_31 + var_112_23 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_31 + var_112_23
					end

					if var_112_26.prefab_name ~= "" and arg_109_1.actors_[var_112_26.prefab_name] ~= nil then
						local var_112_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_26.prefab_name].transform, "story_v_out_410172", "410172027", "story_v_out_410172.awb")

						arg_109_1:RecordAudio("410172027", var_112_32)
						arg_109_1:RecordAudio("410172027", var_112_32)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_410172", "410172027", "story_v_out_410172.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_410172", "410172027", "story_v_out_410172.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_33 = math.max(var_112_24, arg_109_1.talkMaxDuration)

			if var_112_23 <= arg_109_1.time_ and arg_109_1.time_ < var_112_23 + var_112_33 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_23) / var_112_33

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_23 + var_112_33 and arg_109_1.time_ < var_112_23 + var_112_33 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play410172028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 410172028
		arg_113_1.duration_ = 17.8

		local var_113_0 = {
			ja = 17.8,
			CriLanguages = 10.866,
			zh = 10.866
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
				arg_113_0:Play410172029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10062"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos10062 = var_116_0.localPosition
				var_116_0.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10062", 4)

				local var_116_2 = var_116_0.childCount

				for iter_116_0 = 0, var_116_2 - 1 do
					local var_116_3 = var_116_0:GetChild(iter_116_0)

					if var_116_3.name == "" or not string.find(var_116_3.name, "split") then
						var_116_3.gameObject:SetActive(true)
					else
						var_116_3.gameObject:SetActive(false)
					end
				end
			end

			local var_116_4 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_4 then
				local var_116_5 = (arg_113_1.time_ - var_116_1) / var_116_4
				local var_116_6 = Vector3.New(370, -390, -290)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10062, var_116_6, var_116_5)
			end

			if arg_113_1.time_ >= var_116_1 + var_116_4 and arg_113_1.time_ < var_116_1 + var_116_4 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_116_7 = arg_113_1.actors_["10062"]
			local var_116_8 = 0

			if var_116_8 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.actorSpriteComps10062 == nil then
				arg_113_1.var_.actorSpriteComps10062 = var_116_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_9 = 0.034

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_9 and not isNil(var_116_7) then
				local var_116_10 = (arg_113_1.time_ - var_116_8) / var_116_9

				if arg_113_1.var_.actorSpriteComps10062 then
					for iter_116_1, iter_116_2 in pairs(arg_113_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_116_2 then
							if arg_113_1.isInRecall_ then
								local var_116_11 = Mathf.Lerp(iter_116_2.color.r, arg_113_1.hightColor1.r, var_116_10)
								local var_116_12 = Mathf.Lerp(iter_116_2.color.g, arg_113_1.hightColor1.g, var_116_10)
								local var_116_13 = Mathf.Lerp(iter_116_2.color.b, arg_113_1.hightColor1.b, var_116_10)

								iter_116_2.color = Color.New(var_116_11, var_116_12, var_116_13)
							else
								local var_116_14 = Mathf.Lerp(iter_116_2.color.r, 1, var_116_10)

								iter_116_2.color = Color.New(var_116_14, var_116_14, var_116_14)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_8 + var_116_9 and arg_113_1.time_ < var_116_8 + var_116_9 + arg_116_0 and not isNil(var_116_7) and arg_113_1.var_.actorSpriteComps10062 then
				for iter_116_3, iter_116_4 in pairs(arg_113_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_116_4 then
						if arg_113_1.isInRecall_ then
							iter_116_4.color = arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_116_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps10062 = nil
			end

			local var_116_15 = arg_113_1.actors_["1061"]
			local var_116_16 = 0

			if var_116_16 < arg_113_1.time_ and arg_113_1.time_ <= var_116_16 + arg_116_0 and not isNil(var_116_15) and arg_113_1.var_.actorSpriteComps1061 == nil then
				arg_113_1.var_.actorSpriteComps1061 = var_116_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_17 = 0.034

			if var_116_16 <= arg_113_1.time_ and arg_113_1.time_ < var_116_16 + var_116_17 and not isNil(var_116_15) then
				local var_116_18 = (arg_113_1.time_ - var_116_16) / var_116_17

				if arg_113_1.var_.actorSpriteComps1061 then
					for iter_116_5, iter_116_6 in pairs(arg_113_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_116_6 then
							if arg_113_1.isInRecall_ then
								local var_116_19 = Mathf.Lerp(iter_116_6.color.r, arg_113_1.hightColor2.r, var_116_18)
								local var_116_20 = Mathf.Lerp(iter_116_6.color.g, arg_113_1.hightColor2.g, var_116_18)
								local var_116_21 = Mathf.Lerp(iter_116_6.color.b, arg_113_1.hightColor2.b, var_116_18)

								iter_116_6.color = Color.New(var_116_19, var_116_20, var_116_21)
							else
								local var_116_22 = Mathf.Lerp(iter_116_6.color.r, 0.5, var_116_18)

								iter_116_6.color = Color.New(var_116_22, var_116_22, var_116_22)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_16 + var_116_17 and arg_113_1.time_ < var_116_16 + var_116_17 + arg_116_0 and not isNil(var_116_15) and arg_113_1.var_.actorSpriteComps1061 then
				for iter_116_7, iter_116_8 in pairs(arg_113_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_116_8 then
						if arg_113_1.isInRecall_ then
							iter_116_8.color = arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_116_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps1061 = nil
			end

			local var_116_23 = 0
			local var_116_24 = 1

			if var_116_23 < arg_113_1.time_ and arg_113_1.time_ <= var_116_23 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_25 = arg_113_1:FormatText(StoryNameCfg[600].name)

				arg_113_1.leftNameTxt_.text = var_116_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_26 = arg_113_1:GetWordFromCfg(410172028)
				local var_116_27 = arg_113_1:FormatText(var_116_26.content)

				arg_113_1.text_.text = var_116_27

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_28 = 40
				local var_116_29 = utf8.len(var_116_27)
				local var_116_30 = var_116_28 <= 0 and var_116_24 or var_116_24 * (var_116_29 / var_116_28)

				if var_116_30 > 0 and var_116_24 < var_116_30 then
					arg_113_1.talkMaxDuration = var_116_30

					if var_116_30 + var_116_23 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_30 + var_116_23
					end
				end

				arg_113_1.text_.text = var_116_27
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172028", "story_v_out_410172.awb") ~= 0 then
					local var_116_31 = manager.audio:GetVoiceLength("story_v_out_410172", "410172028", "story_v_out_410172.awb") / 1000

					if var_116_31 + var_116_23 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_31 + var_116_23
					end

					if var_116_26.prefab_name ~= "" and arg_113_1.actors_[var_116_26.prefab_name] ~= nil then
						local var_116_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_26.prefab_name].transform, "story_v_out_410172", "410172028", "story_v_out_410172.awb")

						arg_113_1:RecordAudio("410172028", var_116_32)
						arg_113_1:RecordAudio("410172028", var_116_32)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_410172", "410172028", "story_v_out_410172.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_410172", "410172028", "story_v_out_410172.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_33 = math.max(var_116_24, arg_113_1.talkMaxDuration)

			if var_116_23 <= arg_113_1.time_ and arg_113_1.time_ < var_116_23 + var_116_33 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_23) / var_116_33

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_23 + var_116_33 and arg_113_1.time_ < var_116_23 + var_116_33 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play410172029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 410172029
		arg_117_1.duration_ = 7.2

		local var_117_0 = {
			ja = 6.633,
			CriLanguages = 7.2,
			zh = 7.2
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
				arg_117_0:Play410172030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1061"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1061 = var_120_0.localPosition
				var_120_0.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("1061", 2)

				local var_120_2 = var_120_0.childCount

				for iter_120_0 = 0, var_120_2 - 1 do
					local var_120_3 = var_120_0:GetChild(iter_120_0)

					if var_120_3.name == "split_2" or not string.find(var_120_3.name, "split") then
						var_120_3.gameObject:SetActive(true)
					else
						var_120_3.gameObject:SetActive(false)
					end
				end
			end

			local var_120_4 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_4 then
				local var_120_5 = (arg_117_1.time_ - var_120_1) / var_120_4
				local var_120_6 = Vector3.New(-390, -490, 18)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1061, var_120_6, var_120_5)
			end

			if arg_117_1.time_ >= var_120_1 + var_120_4 and arg_117_1.time_ < var_120_1 + var_120_4 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_120_7 = arg_117_1.actors_["1061"]
			local var_120_8 = 0

			if var_120_8 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 and not isNil(var_120_7) and arg_117_1.var_.actorSpriteComps1061 == nil then
				arg_117_1.var_.actorSpriteComps1061 = var_120_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_9 = 0.034

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_9 and not isNil(var_120_7) then
				local var_120_10 = (arg_117_1.time_ - var_120_8) / var_120_9

				if arg_117_1.var_.actorSpriteComps1061 then
					for iter_120_1, iter_120_2 in pairs(arg_117_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_120_2 then
							if arg_117_1.isInRecall_ then
								local var_120_11 = Mathf.Lerp(iter_120_2.color.r, arg_117_1.hightColor1.r, var_120_10)
								local var_120_12 = Mathf.Lerp(iter_120_2.color.g, arg_117_1.hightColor1.g, var_120_10)
								local var_120_13 = Mathf.Lerp(iter_120_2.color.b, arg_117_1.hightColor1.b, var_120_10)

								iter_120_2.color = Color.New(var_120_11, var_120_12, var_120_13)
							else
								local var_120_14 = Mathf.Lerp(iter_120_2.color.r, 1, var_120_10)

								iter_120_2.color = Color.New(var_120_14, var_120_14, var_120_14)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_8 + var_120_9 and arg_117_1.time_ < var_120_8 + var_120_9 + arg_120_0 and not isNil(var_120_7) and arg_117_1.var_.actorSpriteComps1061 then
				for iter_120_3, iter_120_4 in pairs(arg_117_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_120_4 then
						if arg_117_1.isInRecall_ then
							iter_120_4.color = arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_120_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps1061 = nil
			end

			local var_120_15 = arg_117_1.actors_["10062"]
			local var_120_16 = 0

			if var_120_16 < arg_117_1.time_ and arg_117_1.time_ <= var_120_16 + arg_120_0 and not isNil(var_120_15) and arg_117_1.var_.actorSpriteComps10062 == nil then
				arg_117_1.var_.actorSpriteComps10062 = var_120_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_17 = 0.034

			if var_120_16 <= arg_117_1.time_ and arg_117_1.time_ < var_120_16 + var_120_17 and not isNil(var_120_15) then
				local var_120_18 = (arg_117_1.time_ - var_120_16) / var_120_17

				if arg_117_1.var_.actorSpriteComps10062 then
					for iter_120_5, iter_120_6 in pairs(arg_117_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_120_6 then
							if arg_117_1.isInRecall_ then
								local var_120_19 = Mathf.Lerp(iter_120_6.color.r, arg_117_1.hightColor2.r, var_120_18)
								local var_120_20 = Mathf.Lerp(iter_120_6.color.g, arg_117_1.hightColor2.g, var_120_18)
								local var_120_21 = Mathf.Lerp(iter_120_6.color.b, arg_117_1.hightColor2.b, var_120_18)

								iter_120_6.color = Color.New(var_120_19, var_120_20, var_120_21)
							else
								local var_120_22 = Mathf.Lerp(iter_120_6.color.r, 0.5, var_120_18)

								iter_120_6.color = Color.New(var_120_22, var_120_22, var_120_22)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_16 + var_120_17 and arg_117_1.time_ < var_120_16 + var_120_17 + arg_120_0 and not isNil(var_120_15) and arg_117_1.var_.actorSpriteComps10062 then
				for iter_120_7, iter_120_8 in pairs(arg_117_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_120_8 then
						if arg_117_1.isInRecall_ then
							iter_120_8.color = arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_120_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10062 = nil
			end

			local var_120_23 = 0
			local var_120_24 = 0.85

			if var_120_23 < arg_117_1.time_ and arg_117_1.time_ <= var_120_23 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_25 = arg_117_1:FormatText(StoryNameCfg[612].name)

				arg_117_1.leftNameTxt_.text = var_120_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_26 = arg_117_1:GetWordFromCfg(410172029)
				local var_120_27 = arg_117_1:FormatText(var_120_26.content)

				arg_117_1.text_.text = var_120_27

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_28 = 34
				local var_120_29 = utf8.len(var_120_27)
				local var_120_30 = var_120_28 <= 0 and var_120_24 or var_120_24 * (var_120_29 / var_120_28)

				if var_120_30 > 0 and var_120_24 < var_120_30 then
					arg_117_1.talkMaxDuration = var_120_30

					if var_120_30 + var_120_23 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_30 + var_120_23
					end
				end

				arg_117_1.text_.text = var_120_27
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172029", "story_v_out_410172.awb") ~= 0 then
					local var_120_31 = manager.audio:GetVoiceLength("story_v_out_410172", "410172029", "story_v_out_410172.awb") / 1000

					if var_120_31 + var_120_23 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_31 + var_120_23
					end

					if var_120_26.prefab_name ~= "" and arg_117_1.actors_[var_120_26.prefab_name] ~= nil then
						local var_120_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_26.prefab_name].transform, "story_v_out_410172", "410172029", "story_v_out_410172.awb")

						arg_117_1:RecordAudio("410172029", var_120_32)
						arg_117_1:RecordAudio("410172029", var_120_32)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_410172", "410172029", "story_v_out_410172.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_410172", "410172029", "story_v_out_410172.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_33 = math.max(var_120_24, arg_117_1.talkMaxDuration)

			if var_120_23 <= arg_117_1.time_ and arg_117_1.time_ < var_120_23 + var_120_33 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_23) / var_120_33

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_23 + var_120_33 and arg_117_1.time_ < var_120_23 + var_120_33 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play410172030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 410172030
		arg_121_1.duration_ = 7.13

		local var_121_0 = {
			ja = 7.133,
			CriLanguages = 5.433,
			zh = 5.433
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
				arg_121_0:Play410172031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10062"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos10062 = var_124_0.localPosition
				var_124_0.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10062", 4)

				local var_124_2 = var_124_0.childCount

				for iter_124_0 = 0, var_124_2 - 1 do
					local var_124_3 = var_124_0:GetChild(iter_124_0)

					if var_124_3.name == "split_2" or not string.find(var_124_3.name, "split") then
						var_124_3.gameObject:SetActive(true)
					else
						var_124_3.gameObject:SetActive(false)
					end
				end
			end

			local var_124_4 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_4 then
				local var_124_5 = (arg_121_1.time_ - var_124_1) / var_124_4
				local var_124_6 = Vector3.New(370, -390, -290)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10062, var_124_6, var_124_5)
			end

			if arg_121_1.time_ >= var_124_1 + var_124_4 and arg_121_1.time_ < var_124_1 + var_124_4 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_124_7 = arg_121_1.actors_["10062"]
			local var_124_8 = 0

			if var_124_8 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 and not isNil(var_124_7) and arg_121_1.var_.actorSpriteComps10062 == nil then
				arg_121_1.var_.actorSpriteComps10062 = var_124_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_9 = 0.034

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_9 and not isNil(var_124_7) then
				local var_124_10 = (arg_121_1.time_ - var_124_8) / var_124_9

				if arg_121_1.var_.actorSpriteComps10062 then
					for iter_124_1, iter_124_2 in pairs(arg_121_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_124_2 then
							if arg_121_1.isInRecall_ then
								local var_124_11 = Mathf.Lerp(iter_124_2.color.r, arg_121_1.hightColor1.r, var_124_10)
								local var_124_12 = Mathf.Lerp(iter_124_2.color.g, arg_121_1.hightColor1.g, var_124_10)
								local var_124_13 = Mathf.Lerp(iter_124_2.color.b, arg_121_1.hightColor1.b, var_124_10)

								iter_124_2.color = Color.New(var_124_11, var_124_12, var_124_13)
							else
								local var_124_14 = Mathf.Lerp(iter_124_2.color.r, 1, var_124_10)

								iter_124_2.color = Color.New(var_124_14, var_124_14, var_124_14)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_8 + var_124_9 and arg_121_1.time_ < var_124_8 + var_124_9 + arg_124_0 and not isNil(var_124_7) and arg_121_1.var_.actorSpriteComps10062 then
				for iter_124_3, iter_124_4 in pairs(arg_121_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_124_4 then
						if arg_121_1.isInRecall_ then
							iter_124_4.color = arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_124_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps10062 = nil
			end

			local var_124_15 = arg_121_1.actors_["1061"]
			local var_124_16 = 0

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 and not isNil(var_124_15) and arg_121_1.var_.actorSpriteComps1061 == nil then
				arg_121_1.var_.actorSpriteComps1061 = var_124_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_17 = 0.034

			if var_124_16 <= arg_121_1.time_ and arg_121_1.time_ < var_124_16 + var_124_17 and not isNil(var_124_15) then
				local var_124_18 = (arg_121_1.time_ - var_124_16) / var_124_17

				if arg_121_1.var_.actorSpriteComps1061 then
					for iter_124_5, iter_124_6 in pairs(arg_121_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_124_6 then
							if arg_121_1.isInRecall_ then
								local var_124_19 = Mathf.Lerp(iter_124_6.color.r, arg_121_1.hightColor2.r, var_124_18)
								local var_124_20 = Mathf.Lerp(iter_124_6.color.g, arg_121_1.hightColor2.g, var_124_18)
								local var_124_21 = Mathf.Lerp(iter_124_6.color.b, arg_121_1.hightColor2.b, var_124_18)

								iter_124_6.color = Color.New(var_124_19, var_124_20, var_124_21)
							else
								local var_124_22 = Mathf.Lerp(iter_124_6.color.r, 0.5, var_124_18)

								iter_124_6.color = Color.New(var_124_22, var_124_22, var_124_22)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_16 + var_124_17 and arg_121_1.time_ < var_124_16 + var_124_17 + arg_124_0 and not isNil(var_124_15) and arg_121_1.var_.actorSpriteComps1061 then
				for iter_124_7, iter_124_8 in pairs(arg_121_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_124_8 then
						if arg_121_1.isInRecall_ then
							iter_124_8.color = arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_124_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps1061 = nil
			end

			local var_124_23 = 0
			local var_124_24 = 0.45

			if var_124_23 < arg_121_1.time_ and arg_121_1.time_ <= var_124_23 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_25 = arg_121_1:FormatText(StoryNameCfg[600].name)

				arg_121_1.leftNameTxt_.text = var_124_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_26 = arg_121_1:GetWordFromCfg(410172030)
				local var_124_27 = arg_121_1:FormatText(var_124_26.content)

				arg_121_1.text_.text = var_124_27

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_28 = 18
				local var_124_29 = utf8.len(var_124_27)
				local var_124_30 = var_124_28 <= 0 and var_124_24 or var_124_24 * (var_124_29 / var_124_28)

				if var_124_30 > 0 and var_124_24 < var_124_30 then
					arg_121_1.talkMaxDuration = var_124_30

					if var_124_30 + var_124_23 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_30 + var_124_23
					end
				end

				arg_121_1.text_.text = var_124_27
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172030", "story_v_out_410172.awb") ~= 0 then
					local var_124_31 = manager.audio:GetVoiceLength("story_v_out_410172", "410172030", "story_v_out_410172.awb") / 1000

					if var_124_31 + var_124_23 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_31 + var_124_23
					end

					if var_124_26.prefab_name ~= "" and arg_121_1.actors_[var_124_26.prefab_name] ~= nil then
						local var_124_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_26.prefab_name].transform, "story_v_out_410172", "410172030", "story_v_out_410172.awb")

						arg_121_1:RecordAudio("410172030", var_124_32)
						arg_121_1:RecordAudio("410172030", var_124_32)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_410172", "410172030", "story_v_out_410172.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_410172", "410172030", "story_v_out_410172.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_33 = math.max(var_124_24, arg_121_1.talkMaxDuration)

			if var_124_23 <= arg_121_1.time_ and arg_121_1.time_ < var_124_23 + var_124_33 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_23) / var_124_33

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_23 + var_124_33 and arg_121_1.time_ < var_124_23 + var_124_33 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play410172031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 410172031
		arg_125_1.duration_ = 12

		local var_125_0 = {
			ja = 12,
			CriLanguages = 7.866,
			zh = 7.866
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
				arg_125_0:Play410172032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1061"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1061 = var_128_0.localPosition
				var_128_0.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("1061", 2)

				local var_128_2 = var_128_0.childCount

				for iter_128_0 = 0, var_128_2 - 1 do
					local var_128_3 = var_128_0:GetChild(iter_128_0)

					if var_128_3.name == "split_2" or not string.find(var_128_3.name, "split") then
						var_128_3.gameObject:SetActive(true)
					else
						var_128_3.gameObject:SetActive(false)
					end
				end
			end

			local var_128_4 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_4 then
				local var_128_5 = (arg_125_1.time_ - var_128_1) / var_128_4
				local var_128_6 = Vector3.New(-390, -490, 18)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1061, var_128_6, var_128_5)
			end

			if arg_125_1.time_ >= var_128_1 + var_128_4 and arg_125_1.time_ < var_128_1 + var_128_4 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_128_7 = arg_125_1.actors_["1061"]
			local var_128_8 = 0

			if var_128_8 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 and not isNil(var_128_7) and arg_125_1.var_.actorSpriteComps1061 == nil then
				arg_125_1.var_.actorSpriteComps1061 = var_128_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_9 = 0.034

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_9 and not isNil(var_128_7) then
				local var_128_10 = (arg_125_1.time_ - var_128_8) / var_128_9

				if arg_125_1.var_.actorSpriteComps1061 then
					for iter_128_1, iter_128_2 in pairs(arg_125_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_128_2 then
							if arg_125_1.isInRecall_ then
								local var_128_11 = Mathf.Lerp(iter_128_2.color.r, arg_125_1.hightColor1.r, var_128_10)
								local var_128_12 = Mathf.Lerp(iter_128_2.color.g, arg_125_1.hightColor1.g, var_128_10)
								local var_128_13 = Mathf.Lerp(iter_128_2.color.b, arg_125_1.hightColor1.b, var_128_10)

								iter_128_2.color = Color.New(var_128_11, var_128_12, var_128_13)
							else
								local var_128_14 = Mathf.Lerp(iter_128_2.color.r, 1, var_128_10)

								iter_128_2.color = Color.New(var_128_14, var_128_14, var_128_14)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_8 + var_128_9 and arg_125_1.time_ < var_128_8 + var_128_9 + arg_128_0 and not isNil(var_128_7) and arg_125_1.var_.actorSpriteComps1061 then
				for iter_128_3, iter_128_4 in pairs(arg_125_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_128_4 then
						if arg_125_1.isInRecall_ then
							iter_128_4.color = arg_125_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_128_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps1061 = nil
			end

			local var_128_15 = arg_125_1.actors_["10062"]
			local var_128_16 = 0

			if var_128_16 < arg_125_1.time_ and arg_125_1.time_ <= var_128_16 + arg_128_0 and not isNil(var_128_15) and arg_125_1.var_.actorSpriteComps10062 == nil then
				arg_125_1.var_.actorSpriteComps10062 = var_128_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_17 = 0.034

			if var_128_16 <= arg_125_1.time_ and arg_125_1.time_ < var_128_16 + var_128_17 and not isNil(var_128_15) then
				local var_128_18 = (arg_125_1.time_ - var_128_16) / var_128_17

				if arg_125_1.var_.actorSpriteComps10062 then
					for iter_128_5, iter_128_6 in pairs(arg_125_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_128_6 then
							if arg_125_1.isInRecall_ then
								local var_128_19 = Mathf.Lerp(iter_128_6.color.r, arg_125_1.hightColor2.r, var_128_18)
								local var_128_20 = Mathf.Lerp(iter_128_6.color.g, arg_125_1.hightColor2.g, var_128_18)
								local var_128_21 = Mathf.Lerp(iter_128_6.color.b, arg_125_1.hightColor2.b, var_128_18)

								iter_128_6.color = Color.New(var_128_19, var_128_20, var_128_21)
							else
								local var_128_22 = Mathf.Lerp(iter_128_6.color.r, 0.5, var_128_18)

								iter_128_6.color = Color.New(var_128_22, var_128_22, var_128_22)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= var_128_16 + var_128_17 and arg_125_1.time_ < var_128_16 + var_128_17 + arg_128_0 and not isNil(var_128_15) and arg_125_1.var_.actorSpriteComps10062 then
				for iter_128_7, iter_128_8 in pairs(arg_125_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_128_8 then
						if arg_125_1.isInRecall_ then
							iter_128_8.color = arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_128_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_125_1.var_.actorSpriteComps10062 = nil
			end

			local var_128_23 = 0
			local var_128_24 = 0.825

			if var_128_23 < arg_125_1.time_ and arg_125_1.time_ <= var_128_23 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_25 = arg_125_1:FormatText(StoryNameCfg[612].name)

				arg_125_1.leftNameTxt_.text = var_128_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_26 = arg_125_1:GetWordFromCfg(410172031)
				local var_128_27 = arg_125_1:FormatText(var_128_26.content)

				arg_125_1.text_.text = var_128_27

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_28 = 33
				local var_128_29 = utf8.len(var_128_27)
				local var_128_30 = var_128_28 <= 0 and var_128_24 or var_128_24 * (var_128_29 / var_128_28)

				if var_128_30 > 0 and var_128_24 < var_128_30 then
					arg_125_1.talkMaxDuration = var_128_30

					if var_128_30 + var_128_23 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_30 + var_128_23
					end
				end

				arg_125_1.text_.text = var_128_27
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172031", "story_v_out_410172.awb") ~= 0 then
					local var_128_31 = manager.audio:GetVoiceLength("story_v_out_410172", "410172031", "story_v_out_410172.awb") / 1000

					if var_128_31 + var_128_23 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_31 + var_128_23
					end

					if var_128_26.prefab_name ~= "" and arg_125_1.actors_[var_128_26.prefab_name] ~= nil then
						local var_128_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_26.prefab_name].transform, "story_v_out_410172", "410172031", "story_v_out_410172.awb")

						arg_125_1:RecordAudio("410172031", var_128_32)
						arg_125_1:RecordAudio("410172031", var_128_32)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_410172", "410172031", "story_v_out_410172.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_410172", "410172031", "story_v_out_410172.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_33 = math.max(var_128_24, arg_125_1.talkMaxDuration)

			if var_128_23 <= arg_125_1.time_ and arg_125_1.time_ < var_128_23 + var_128_33 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_23) / var_128_33

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_23 + var_128_33 and arg_125_1.time_ < var_128_23 + var_128_33 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play410172032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 410172032
		arg_129_1.duration_ = 10.3

		local var_129_0 = {
			ja = 10.3,
			CriLanguages = 5.733,
			zh = 5.733
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
				arg_129_0:Play410172033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["10062"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos10062 = var_132_0.localPosition
				var_132_0.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10062", 4)

				local var_132_2 = var_132_0.childCount

				for iter_132_0 = 0, var_132_2 - 1 do
					local var_132_3 = var_132_0:GetChild(iter_132_0)

					if var_132_3.name == "split_2" or not string.find(var_132_3.name, "split") then
						var_132_3.gameObject:SetActive(true)
					else
						var_132_3.gameObject:SetActive(false)
					end
				end
			end

			local var_132_4 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_4 then
				local var_132_5 = (arg_129_1.time_ - var_132_1) / var_132_4
				local var_132_6 = Vector3.New(370, -390, -290)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10062, var_132_6, var_132_5)
			end

			if arg_129_1.time_ >= var_132_1 + var_132_4 and arg_129_1.time_ < var_132_1 + var_132_4 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_132_7 = arg_129_1.actors_["10062"]
			local var_132_8 = 0

			if var_132_8 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 and not isNil(var_132_7) and arg_129_1.var_.actorSpriteComps10062 == nil then
				arg_129_1.var_.actorSpriteComps10062 = var_132_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_9 = 0.034

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_9 and not isNil(var_132_7) then
				local var_132_10 = (arg_129_1.time_ - var_132_8) / var_132_9

				if arg_129_1.var_.actorSpriteComps10062 then
					for iter_132_1, iter_132_2 in pairs(arg_129_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_132_2 then
							if arg_129_1.isInRecall_ then
								local var_132_11 = Mathf.Lerp(iter_132_2.color.r, arg_129_1.hightColor1.r, var_132_10)
								local var_132_12 = Mathf.Lerp(iter_132_2.color.g, arg_129_1.hightColor1.g, var_132_10)
								local var_132_13 = Mathf.Lerp(iter_132_2.color.b, arg_129_1.hightColor1.b, var_132_10)

								iter_132_2.color = Color.New(var_132_11, var_132_12, var_132_13)
							else
								local var_132_14 = Mathf.Lerp(iter_132_2.color.r, 1, var_132_10)

								iter_132_2.color = Color.New(var_132_14, var_132_14, var_132_14)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_8 + var_132_9 and arg_129_1.time_ < var_132_8 + var_132_9 + arg_132_0 and not isNil(var_132_7) and arg_129_1.var_.actorSpriteComps10062 then
				for iter_132_3, iter_132_4 in pairs(arg_129_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_132_4 then
						if arg_129_1.isInRecall_ then
							iter_132_4.color = arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_132_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps10062 = nil
			end

			local var_132_15 = arg_129_1.actors_["1061"]
			local var_132_16 = 0

			if var_132_16 < arg_129_1.time_ and arg_129_1.time_ <= var_132_16 + arg_132_0 and not isNil(var_132_15) and arg_129_1.var_.actorSpriteComps1061 == nil then
				arg_129_1.var_.actorSpriteComps1061 = var_132_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_17 = 0.034

			if var_132_16 <= arg_129_1.time_ and arg_129_1.time_ < var_132_16 + var_132_17 and not isNil(var_132_15) then
				local var_132_18 = (arg_129_1.time_ - var_132_16) / var_132_17

				if arg_129_1.var_.actorSpriteComps1061 then
					for iter_132_5, iter_132_6 in pairs(arg_129_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_132_6 then
							if arg_129_1.isInRecall_ then
								local var_132_19 = Mathf.Lerp(iter_132_6.color.r, arg_129_1.hightColor2.r, var_132_18)
								local var_132_20 = Mathf.Lerp(iter_132_6.color.g, arg_129_1.hightColor2.g, var_132_18)
								local var_132_21 = Mathf.Lerp(iter_132_6.color.b, arg_129_1.hightColor2.b, var_132_18)

								iter_132_6.color = Color.New(var_132_19, var_132_20, var_132_21)
							else
								local var_132_22 = Mathf.Lerp(iter_132_6.color.r, 0.5, var_132_18)

								iter_132_6.color = Color.New(var_132_22, var_132_22, var_132_22)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= var_132_16 + var_132_17 and arg_129_1.time_ < var_132_16 + var_132_17 + arg_132_0 and not isNil(var_132_15) and arg_129_1.var_.actorSpriteComps1061 then
				for iter_132_7, iter_132_8 in pairs(arg_129_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_132_8 then
						if arg_129_1.isInRecall_ then
							iter_132_8.color = arg_129_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_132_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_129_1.var_.actorSpriteComps1061 = nil
			end

			local var_132_23 = 0
			local var_132_24 = 0.575

			if var_132_23 < arg_129_1.time_ and arg_129_1.time_ <= var_132_23 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_25 = arg_129_1:FormatText(StoryNameCfg[600].name)

				arg_129_1.leftNameTxt_.text = var_132_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_26 = arg_129_1:GetWordFromCfg(410172032)
				local var_132_27 = arg_129_1:FormatText(var_132_26.content)

				arg_129_1.text_.text = var_132_27

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_28 = 23
				local var_132_29 = utf8.len(var_132_27)
				local var_132_30 = var_132_28 <= 0 and var_132_24 or var_132_24 * (var_132_29 / var_132_28)

				if var_132_30 > 0 and var_132_24 < var_132_30 then
					arg_129_1.talkMaxDuration = var_132_30

					if var_132_30 + var_132_23 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_30 + var_132_23
					end
				end

				arg_129_1.text_.text = var_132_27
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172032", "story_v_out_410172.awb") ~= 0 then
					local var_132_31 = manager.audio:GetVoiceLength("story_v_out_410172", "410172032", "story_v_out_410172.awb") / 1000

					if var_132_31 + var_132_23 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_31 + var_132_23
					end

					if var_132_26.prefab_name ~= "" and arg_129_1.actors_[var_132_26.prefab_name] ~= nil then
						local var_132_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_26.prefab_name].transform, "story_v_out_410172", "410172032", "story_v_out_410172.awb")

						arg_129_1:RecordAudio("410172032", var_132_32)
						arg_129_1:RecordAudio("410172032", var_132_32)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_410172", "410172032", "story_v_out_410172.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_410172", "410172032", "story_v_out_410172.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_33 = math.max(var_132_24, arg_129_1.talkMaxDuration)

			if var_132_23 <= arg_129_1.time_ and arg_129_1.time_ < var_132_23 + var_132_33 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_23) / var_132_33

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_23 + var_132_33 and arg_129_1.time_ < var_132_23 + var_132_33 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play410172033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 410172033
		arg_133_1.duration_ = 1.77

		local var_133_0 = {
			ja = 1.766,
			CriLanguages = 1.2,
			zh = 1.2
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
				arg_133_0:Play410172034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1061"].transform
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos1061 = var_136_0.localPosition
				var_136_0.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("1061", 2)

				local var_136_2 = var_136_0.childCount

				for iter_136_0 = 0, var_136_2 - 1 do
					local var_136_3 = var_136_0:GetChild(iter_136_0)

					if var_136_3.name == "split_5" or not string.find(var_136_3.name, "split") then
						var_136_3.gameObject:SetActive(true)
					else
						var_136_3.gameObject:SetActive(false)
					end
				end
			end

			local var_136_4 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_4 then
				local var_136_5 = (arg_133_1.time_ - var_136_1) / var_136_4
				local var_136_6 = Vector3.New(-390, -490, 18)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1061, var_136_6, var_136_5)
			end

			if arg_133_1.time_ >= var_136_1 + var_136_4 and arg_133_1.time_ < var_136_1 + var_136_4 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(-390, -490, 18)
			end

			local var_136_7 = arg_133_1.actors_["1061"]
			local var_136_8 = 0

			if var_136_8 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 and not isNil(var_136_7) and arg_133_1.var_.actorSpriteComps1061 == nil then
				arg_133_1.var_.actorSpriteComps1061 = var_136_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_9 = 0.034

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_9 and not isNil(var_136_7) then
				local var_136_10 = (arg_133_1.time_ - var_136_8) / var_136_9

				if arg_133_1.var_.actorSpriteComps1061 then
					for iter_136_1, iter_136_2 in pairs(arg_133_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_136_2 then
							if arg_133_1.isInRecall_ then
								local var_136_11 = Mathf.Lerp(iter_136_2.color.r, arg_133_1.hightColor1.r, var_136_10)
								local var_136_12 = Mathf.Lerp(iter_136_2.color.g, arg_133_1.hightColor1.g, var_136_10)
								local var_136_13 = Mathf.Lerp(iter_136_2.color.b, arg_133_1.hightColor1.b, var_136_10)

								iter_136_2.color = Color.New(var_136_11, var_136_12, var_136_13)
							else
								local var_136_14 = Mathf.Lerp(iter_136_2.color.r, 1, var_136_10)

								iter_136_2.color = Color.New(var_136_14, var_136_14, var_136_14)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= var_136_8 + var_136_9 and arg_133_1.time_ < var_136_8 + var_136_9 + arg_136_0 and not isNil(var_136_7) and arg_133_1.var_.actorSpriteComps1061 then
				for iter_136_3, iter_136_4 in pairs(arg_133_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_136_4 then
						if arg_133_1.isInRecall_ then
							iter_136_4.color = arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_136_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps1061 = nil
			end

			local var_136_15 = arg_133_1.actors_["10062"]
			local var_136_16 = 0

			if var_136_16 < arg_133_1.time_ and arg_133_1.time_ <= var_136_16 + arg_136_0 and not isNil(var_136_15) and arg_133_1.var_.actorSpriteComps10062 == nil then
				arg_133_1.var_.actorSpriteComps10062 = var_136_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_17 = 0.034

			if var_136_16 <= arg_133_1.time_ and arg_133_1.time_ < var_136_16 + var_136_17 and not isNil(var_136_15) then
				local var_136_18 = (arg_133_1.time_ - var_136_16) / var_136_17

				if arg_133_1.var_.actorSpriteComps10062 then
					for iter_136_5, iter_136_6 in pairs(arg_133_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_136_6 then
							if arg_133_1.isInRecall_ then
								local var_136_19 = Mathf.Lerp(iter_136_6.color.r, arg_133_1.hightColor2.r, var_136_18)
								local var_136_20 = Mathf.Lerp(iter_136_6.color.g, arg_133_1.hightColor2.g, var_136_18)
								local var_136_21 = Mathf.Lerp(iter_136_6.color.b, arg_133_1.hightColor2.b, var_136_18)

								iter_136_6.color = Color.New(var_136_19, var_136_20, var_136_21)
							else
								local var_136_22 = Mathf.Lerp(iter_136_6.color.r, 0.5, var_136_18)

								iter_136_6.color = Color.New(var_136_22, var_136_22, var_136_22)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= var_136_16 + var_136_17 and arg_133_1.time_ < var_136_16 + var_136_17 + arg_136_0 and not isNil(var_136_15) and arg_133_1.var_.actorSpriteComps10062 then
				for iter_136_7, iter_136_8 in pairs(arg_133_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_136_8 then
						if arg_133_1.isInRecall_ then
							iter_136_8.color = arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_136_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_133_1.var_.actorSpriteComps10062 = nil
			end

			local var_136_23 = 0
			local var_136_24 = 0.125

			if var_136_23 < arg_133_1.time_ and arg_133_1.time_ <= var_136_23 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_25 = arg_133_1:FormatText(StoryNameCfg[612].name)

				arg_133_1.leftNameTxt_.text = var_136_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_26 = arg_133_1:GetWordFromCfg(410172033)
				local var_136_27 = arg_133_1:FormatText(var_136_26.content)

				arg_133_1.text_.text = var_136_27

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_28 = 5
				local var_136_29 = utf8.len(var_136_27)
				local var_136_30 = var_136_28 <= 0 and var_136_24 or var_136_24 * (var_136_29 / var_136_28)

				if var_136_30 > 0 and var_136_24 < var_136_30 then
					arg_133_1.talkMaxDuration = var_136_30

					if var_136_30 + var_136_23 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_30 + var_136_23
					end
				end

				arg_133_1.text_.text = var_136_27
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172033", "story_v_out_410172.awb") ~= 0 then
					local var_136_31 = manager.audio:GetVoiceLength("story_v_out_410172", "410172033", "story_v_out_410172.awb") / 1000

					if var_136_31 + var_136_23 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_31 + var_136_23
					end

					if var_136_26.prefab_name ~= "" and arg_133_1.actors_[var_136_26.prefab_name] ~= nil then
						local var_136_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_26.prefab_name].transform, "story_v_out_410172", "410172033", "story_v_out_410172.awb")

						arg_133_1:RecordAudio("410172033", var_136_32)
						arg_133_1:RecordAudio("410172033", var_136_32)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_410172", "410172033", "story_v_out_410172.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_410172", "410172033", "story_v_out_410172.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_33 = math.max(var_136_24, arg_133_1.talkMaxDuration)

			if var_136_23 <= arg_133_1.time_ and arg_133_1.time_ < var_136_23 + var_136_33 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_23) / var_136_33

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_23 + var_136_33 and arg_133_1.time_ < var_136_23 + var_136_33 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play410172034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 410172034
		arg_137_1.duration_ = 13.67

		local var_137_0 = {
			ja = 13.666,
			CriLanguages = 5.7,
			zh = 5.7
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
				arg_137_0:Play410172035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["10062"].transform
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.var_.moveOldPos10062 = var_140_0.localPosition
				var_140_0.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10062", 4)

				local var_140_2 = var_140_0.childCount

				for iter_140_0 = 0, var_140_2 - 1 do
					local var_140_3 = var_140_0:GetChild(iter_140_0)

					if var_140_3.name == "split_1_1" or not string.find(var_140_3.name, "split") then
						var_140_3.gameObject:SetActive(true)
					else
						var_140_3.gameObject:SetActive(false)
					end
				end
			end

			local var_140_4 = 0.001

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_4 then
				local var_140_5 = (arg_137_1.time_ - var_140_1) / var_140_4
				local var_140_6 = Vector3.New(370, -390, -290)

				var_140_0.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10062, var_140_6, var_140_5)
			end

			if arg_137_1.time_ >= var_140_1 + var_140_4 and arg_137_1.time_ < var_140_1 + var_140_4 + arg_140_0 then
				var_140_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_140_7 = arg_137_1.actors_["10062"]
			local var_140_8 = 0

			if var_140_8 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.actorSpriteComps10062 == nil then
				arg_137_1.var_.actorSpriteComps10062 = var_140_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_9 = 0.034

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_9 and not isNil(var_140_7) then
				local var_140_10 = (arg_137_1.time_ - var_140_8) / var_140_9

				if arg_137_1.var_.actorSpriteComps10062 then
					for iter_140_1, iter_140_2 in pairs(arg_137_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_140_2 then
							if arg_137_1.isInRecall_ then
								local var_140_11 = Mathf.Lerp(iter_140_2.color.r, arg_137_1.hightColor1.r, var_140_10)
								local var_140_12 = Mathf.Lerp(iter_140_2.color.g, arg_137_1.hightColor1.g, var_140_10)
								local var_140_13 = Mathf.Lerp(iter_140_2.color.b, arg_137_1.hightColor1.b, var_140_10)

								iter_140_2.color = Color.New(var_140_11, var_140_12, var_140_13)
							else
								local var_140_14 = Mathf.Lerp(iter_140_2.color.r, 1, var_140_10)

								iter_140_2.color = Color.New(var_140_14, var_140_14, var_140_14)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_8 + var_140_9 and arg_137_1.time_ < var_140_8 + var_140_9 + arg_140_0 and not isNil(var_140_7) and arg_137_1.var_.actorSpriteComps10062 then
				for iter_140_3, iter_140_4 in pairs(arg_137_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_140_4 then
						if arg_137_1.isInRecall_ then
							iter_140_4.color = arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_140_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps10062 = nil
			end

			local var_140_15 = arg_137_1.actors_["1061"]
			local var_140_16 = 0

			if var_140_16 < arg_137_1.time_ and arg_137_1.time_ <= var_140_16 + arg_140_0 and not isNil(var_140_15) and arg_137_1.var_.actorSpriteComps1061 == nil then
				arg_137_1.var_.actorSpriteComps1061 = var_140_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_17 = 0.034

			if var_140_16 <= arg_137_1.time_ and arg_137_1.time_ < var_140_16 + var_140_17 and not isNil(var_140_15) then
				local var_140_18 = (arg_137_1.time_ - var_140_16) / var_140_17

				if arg_137_1.var_.actorSpriteComps1061 then
					for iter_140_5, iter_140_6 in pairs(arg_137_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_140_6 then
							if arg_137_1.isInRecall_ then
								local var_140_19 = Mathf.Lerp(iter_140_6.color.r, arg_137_1.hightColor2.r, var_140_18)
								local var_140_20 = Mathf.Lerp(iter_140_6.color.g, arg_137_1.hightColor2.g, var_140_18)
								local var_140_21 = Mathf.Lerp(iter_140_6.color.b, arg_137_1.hightColor2.b, var_140_18)

								iter_140_6.color = Color.New(var_140_19, var_140_20, var_140_21)
							else
								local var_140_22 = Mathf.Lerp(iter_140_6.color.r, 0.5, var_140_18)

								iter_140_6.color = Color.New(var_140_22, var_140_22, var_140_22)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= var_140_16 + var_140_17 and arg_137_1.time_ < var_140_16 + var_140_17 + arg_140_0 and not isNil(var_140_15) and arg_137_1.var_.actorSpriteComps1061 then
				for iter_140_7, iter_140_8 in pairs(arg_137_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_140_8 then
						if arg_137_1.isInRecall_ then
							iter_140_8.color = arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_140_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_137_1.var_.actorSpriteComps1061 = nil
			end

			local var_140_23 = 0
			local var_140_24 = 0.5

			if var_140_23 < arg_137_1.time_ and arg_137_1.time_ <= var_140_23 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_25 = arg_137_1:FormatText(StoryNameCfg[600].name)

				arg_137_1.leftNameTxt_.text = var_140_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_26 = arg_137_1:GetWordFromCfg(410172034)
				local var_140_27 = arg_137_1:FormatText(var_140_26.content)

				arg_137_1.text_.text = var_140_27

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_28 = 20
				local var_140_29 = utf8.len(var_140_27)
				local var_140_30 = var_140_28 <= 0 and var_140_24 or var_140_24 * (var_140_29 / var_140_28)

				if var_140_30 > 0 and var_140_24 < var_140_30 then
					arg_137_1.talkMaxDuration = var_140_30

					if var_140_30 + var_140_23 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_30 + var_140_23
					end
				end

				arg_137_1.text_.text = var_140_27
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172034", "story_v_out_410172.awb") ~= 0 then
					local var_140_31 = manager.audio:GetVoiceLength("story_v_out_410172", "410172034", "story_v_out_410172.awb") / 1000

					if var_140_31 + var_140_23 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_31 + var_140_23
					end

					if var_140_26.prefab_name ~= "" and arg_137_1.actors_[var_140_26.prefab_name] ~= nil then
						local var_140_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_26.prefab_name].transform, "story_v_out_410172", "410172034", "story_v_out_410172.awb")

						arg_137_1:RecordAudio("410172034", var_140_32)
						arg_137_1:RecordAudio("410172034", var_140_32)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_410172", "410172034", "story_v_out_410172.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_410172", "410172034", "story_v_out_410172.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_33 = math.max(var_140_24, arg_137_1.talkMaxDuration)

			if var_140_23 <= arg_137_1.time_ and arg_137_1.time_ < var_140_23 + var_140_33 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_23) / var_140_33

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_23 + var_140_33 and arg_137_1.time_ < var_140_23 + var_140_33 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play410172035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 410172035
		arg_141_1.duration_ = 11.73

		local var_141_0 = {
			ja = 11.6,
			CriLanguages = 11.733,
			zh = 11.733
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
				arg_141_0:Play410172036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["10062"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos10062 = var_144_0.localPosition
				var_144_0.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10062", 4)

				local var_144_2 = var_144_0.childCount

				for iter_144_0 = 0, var_144_2 - 1 do
					local var_144_3 = var_144_0:GetChild(iter_144_0)

					if var_144_3.name == "" or not string.find(var_144_3.name, "split") then
						var_144_3.gameObject:SetActive(true)
					else
						var_144_3.gameObject:SetActive(false)
					end
				end
			end

			local var_144_4 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_4 then
				local var_144_5 = (arg_141_1.time_ - var_144_1) / var_144_4
				local var_144_6 = Vector3.New(370, -390, -290)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10062, var_144_6, var_144_5)
			end

			if arg_141_1.time_ >= var_144_1 + var_144_4 and arg_141_1.time_ < var_144_1 + var_144_4 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_144_7 = arg_141_1.actors_["10062"]
			local var_144_8 = 0

			if var_144_8 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 and not isNil(var_144_7) and arg_141_1.var_.actorSpriteComps10062 == nil then
				arg_141_1.var_.actorSpriteComps10062 = var_144_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_9 = 0.034

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_9 and not isNil(var_144_7) then
				local var_144_10 = (arg_141_1.time_ - var_144_8) / var_144_9

				if arg_141_1.var_.actorSpriteComps10062 then
					for iter_144_1, iter_144_2 in pairs(arg_141_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_144_2 then
							if arg_141_1.isInRecall_ then
								local var_144_11 = Mathf.Lerp(iter_144_2.color.r, arg_141_1.hightColor1.r, var_144_10)
								local var_144_12 = Mathf.Lerp(iter_144_2.color.g, arg_141_1.hightColor1.g, var_144_10)
								local var_144_13 = Mathf.Lerp(iter_144_2.color.b, arg_141_1.hightColor1.b, var_144_10)

								iter_144_2.color = Color.New(var_144_11, var_144_12, var_144_13)
							else
								local var_144_14 = Mathf.Lerp(iter_144_2.color.r, 1, var_144_10)

								iter_144_2.color = Color.New(var_144_14, var_144_14, var_144_14)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_8 + var_144_9 and arg_141_1.time_ < var_144_8 + var_144_9 + arg_144_0 and not isNil(var_144_7) and arg_141_1.var_.actorSpriteComps10062 then
				for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_144_4 then
						if arg_141_1.isInRecall_ then
							iter_144_4.color = arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_144_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10062 = nil
			end

			local var_144_15 = arg_141_1.actors_["1061"]
			local var_144_16 = 0

			if var_144_16 < arg_141_1.time_ and arg_141_1.time_ <= var_144_16 + arg_144_0 and not isNil(var_144_15) and arg_141_1.var_.actorSpriteComps1061 == nil then
				arg_141_1.var_.actorSpriteComps1061 = var_144_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_17 = 0.034

			if var_144_16 <= arg_141_1.time_ and arg_141_1.time_ < var_144_16 + var_144_17 and not isNil(var_144_15) then
				local var_144_18 = (arg_141_1.time_ - var_144_16) / var_144_17

				if arg_141_1.var_.actorSpriteComps1061 then
					for iter_144_5, iter_144_6 in pairs(arg_141_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_144_6 then
							if arg_141_1.isInRecall_ then
								local var_144_19 = Mathf.Lerp(iter_144_6.color.r, arg_141_1.hightColor2.r, var_144_18)
								local var_144_20 = Mathf.Lerp(iter_144_6.color.g, arg_141_1.hightColor2.g, var_144_18)
								local var_144_21 = Mathf.Lerp(iter_144_6.color.b, arg_141_1.hightColor2.b, var_144_18)

								iter_144_6.color = Color.New(var_144_19, var_144_20, var_144_21)
							else
								local var_144_22 = Mathf.Lerp(iter_144_6.color.r, 0.5, var_144_18)

								iter_144_6.color = Color.New(var_144_22, var_144_22, var_144_22)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_16 + var_144_17 and arg_141_1.time_ < var_144_16 + var_144_17 + arg_144_0 and not isNil(var_144_15) and arg_141_1.var_.actorSpriteComps1061 then
				for iter_144_7, iter_144_8 in pairs(arg_141_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_144_8 then
						if arg_141_1.isInRecall_ then
							iter_144_8.color = arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_144_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps1061 = nil
			end

			local var_144_23 = 0
			local var_144_24 = 1.2

			if var_144_23 < arg_141_1.time_ and arg_141_1.time_ <= var_144_23 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_25 = arg_141_1:FormatText(StoryNameCfg[600].name)

				arg_141_1.leftNameTxt_.text = var_144_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_26 = arg_141_1:GetWordFromCfg(410172035)
				local var_144_27 = arg_141_1:FormatText(var_144_26.content)

				arg_141_1.text_.text = var_144_27

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_28 = 48
				local var_144_29 = utf8.len(var_144_27)
				local var_144_30 = var_144_28 <= 0 and var_144_24 or var_144_24 * (var_144_29 / var_144_28)

				if var_144_30 > 0 and var_144_24 < var_144_30 then
					arg_141_1.talkMaxDuration = var_144_30

					if var_144_30 + var_144_23 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_30 + var_144_23
					end
				end

				arg_141_1.text_.text = var_144_27
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172035", "story_v_out_410172.awb") ~= 0 then
					local var_144_31 = manager.audio:GetVoiceLength("story_v_out_410172", "410172035", "story_v_out_410172.awb") / 1000

					if var_144_31 + var_144_23 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_31 + var_144_23
					end

					if var_144_26.prefab_name ~= "" and arg_141_1.actors_[var_144_26.prefab_name] ~= nil then
						local var_144_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_26.prefab_name].transform, "story_v_out_410172", "410172035", "story_v_out_410172.awb")

						arg_141_1:RecordAudio("410172035", var_144_32)
						arg_141_1:RecordAudio("410172035", var_144_32)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_410172", "410172035", "story_v_out_410172.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_410172", "410172035", "story_v_out_410172.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_33 = math.max(var_144_24, arg_141_1.talkMaxDuration)

			if var_144_23 <= arg_141_1.time_ and arg_141_1.time_ < var_144_23 + var_144_33 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_23) / var_144_33

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_23 + var_144_33 and arg_141_1.time_ < var_144_23 + var_144_33 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play410172036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 410172036
		arg_145_1.duration_ = 23.47

		local var_145_0 = {
			ja = 23.466,
			CriLanguages = 11.2,
			zh = 11.2
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play410172037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10062"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos10062 = var_148_0.localPosition
				var_148_0.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("10062", 4)

				local var_148_2 = var_148_0.childCount

				for iter_148_0 = 0, var_148_2 - 1 do
					local var_148_3 = var_148_0:GetChild(iter_148_0)

					if var_148_3.name == "split_2" or not string.find(var_148_3.name, "split") then
						var_148_3.gameObject:SetActive(true)
					else
						var_148_3.gameObject:SetActive(false)
					end
				end
			end

			local var_148_4 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_4 then
				local var_148_5 = (arg_145_1.time_ - var_148_1) / var_148_4
				local var_148_6 = Vector3.New(370, -390, -290)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10062, var_148_6, var_148_5)
			end

			if arg_145_1.time_ >= var_148_1 + var_148_4 and arg_145_1.time_ < var_148_1 + var_148_4 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(370, -390, -290)
			end

			local var_148_7 = arg_145_1.actors_["10062"]
			local var_148_8 = 0

			if var_148_8 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 and not isNil(var_148_7) and arg_145_1.var_.actorSpriteComps10062 == nil then
				arg_145_1.var_.actorSpriteComps10062 = var_148_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_9 = 0.034

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_9 and not isNil(var_148_7) then
				local var_148_10 = (arg_145_1.time_ - var_148_8) / var_148_9

				if arg_145_1.var_.actorSpriteComps10062 then
					for iter_148_1, iter_148_2 in pairs(arg_145_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_148_2 then
							if arg_145_1.isInRecall_ then
								local var_148_11 = Mathf.Lerp(iter_148_2.color.r, arg_145_1.hightColor1.r, var_148_10)
								local var_148_12 = Mathf.Lerp(iter_148_2.color.g, arg_145_1.hightColor1.g, var_148_10)
								local var_148_13 = Mathf.Lerp(iter_148_2.color.b, arg_145_1.hightColor1.b, var_148_10)

								iter_148_2.color = Color.New(var_148_11, var_148_12, var_148_13)
							else
								local var_148_14 = Mathf.Lerp(iter_148_2.color.r, 1, var_148_10)

								iter_148_2.color = Color.New(var_148_14, var_148_14, var_148_14)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_8 + var_148_9 and arg_145_1.time_ < var_148_8 + var_148_9 + arg_148_0 and not isNil(var_148_7) and arg_145_1.var_.actorSpriteComps10062 then
				for iter_148_3, iter_148_4 in pairs(arg_145_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_148_4 then
						if arg_145_1.isInRecall_ then
							iter_148_4.color = arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_148_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps10062 = nil
			end

			local var_148_15 = arg_145_1.actors_["1061"]
			local var_148_16 = 0

			if var_148_16 < arg_145_1.time_ and arg_145_1.time_ <= var_148_16 + arg_148_0 and not isNil(var_148_15) and arg_145_1.var_.actorSpriteComps1061 == nil then
				arg_145_1.var_.actorSpriteComps1061 = var_148_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_17 = 0.034

			if var_148_16 <= arg_145_1.time_ and arg_145_1.time_ < var_148_16 + var_148_17 and not isNil(var_148_15) then
				local var_148_18 = (arg_145_1.time_ - var_148_16) / var_148_17

				if arg_145_1.var_.actorSpriteComps1061 then
					for iter_148_5, iter_148_6 in pairs(arg_145_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_148_6 then
							if arg_145_1.isInRecall_ then
								local var_148_19 = Mathf.Lerp(iter_148_6.color.r, arg_145_1.hightColor2.r, var_148_18)
								local var_148_20 = Mathf.Lerp(iter_148_6.color.g, arg_145_1.hightColor2.g, var_148_18)
								local var_148_21 = Mathf.Lerp(iter_148_6.color.b, arg_145_1.hightColor2.b, var_148_18)

								iter_148_6.color = Color.New(var_148_19, var_148_20, var_148_21)
							else
								local var_148_22 = Mathf.Lerp(iter_148_6.color.r, 0.5, var_148_18)

								iter_148_6.color = Color.New(var_148_22, var_148_22, var_148_22)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= var_148_16 + var_148_17 and arg_145_1.time_ < var_148_16 + var_148_17 + arg_148_0 and not isNil(var_148_15) and arg_145_1.var_.actorSpriteComps1061 then
				for iter_148_7, iter_148_8 in pairs(arg_145_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_148_8 then
						if arg_145_1.isInRecall_ then
							iter_148_8.color = arg_145_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_148_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_145_1.var_.actorSpriteComps1061 = nil
			end

			local var_148_23 = 0
			local var_148_24 = 1.05

			if var_148_23 < arg_145_1.time_ and arg_145_1.time_ <= var_148_23 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_25 = arg_145_1:FormatText(StoryNameCfg[600].name)

				arg_145_1.leftNameTxt_.text = var_148_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_26 = arg_145_1:GetWordFromCfg(410172036)
				local var_148_27 = arg_145_1:FormatText(var_148_26.content)

				arg_145_1.text_.text = var_148_27

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_28 = 39
				local var_148_29 = utf8.len(var_148_27)
				local var_148_30 = var_148_28 <= 0 and var_148_24 or var_148_24 * (var_148_29 / var_148_28)

				if var_148_30 > 0 and var_148_24 < var_148_30 then
					arg_145_1.talkMaxDuration = var_148_30

					if var_148_30 + var_148_23 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_30 + var_148_23
					end
				end

				arg_145_1.text_.text = var_148_27
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410172", "410172036", "story_v_out_410172.awb") ~= 0 then
					local var_148_31 = manager.audio:GetVoiceLength("story_v_out_410172", "410172036", "story_v_out_410172.awb") / 1000

					if var_148_31 + var_148_23 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_31 + var_148_23
					end

					if var_148_26.prefab_name ~= "" and arg_145_1.actors_[var_148_26.prefab_name] ~= nil then
						local var_148_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_26.prefab_name].transform, "story_v_out_410172", "410172036", "story_v_out_410172.awb")

						arg_145_1:RecordAudio("410172036", var_148_32)
						arg_145_1:RecordAudio("410172036", var_148_32)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_410172", "410172036", "story_v_out_410172.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_410172", "410172036", "story_v_out_410172.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_33 = math.max(var_148_24, arg_145_1.talkMaxDuration)

			if var_148_23 <= arg_145_1.time_ and arg_145_1.time_ < var_148_23 + var_148_33 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_23) / var_148_33

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_23 + var_148_33 and arg_145_1.time_ < var_148_23 + var_148_33 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play410172037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 410172037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play410172038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1061"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos1061 = var_152_0.localPosition
				var_152_0.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("1061", 7)

				local var_152_2 = var_152_0.childCount

				for iter_152_0 = 0, var_152_2 - 1 do
					local var_152_3 = var_152_0:GetChild(iter_152_0)

					if var_152_3.name == "" or not string.find(var_152_3.name, "split") then
						var_152_3.gameObject:SetActive(true)
					else
						var_152_3.gameObject:SetActive(false)
					end
				end
			end

			local var_152_4 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_4 then
				local var_152_5 = (arg_149_1.time_ - var_152_1) / var_152_4
				local var_152_6 = Vector3.New(0, -2000, 18)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1061, var_152_6, var_152_5)
			end

			if arg_149_1.time_ >= var_152_1 + var_152_4 and arg_149_1.time_ < var_152_1 + var_152_4 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(0, -2000, 18)
			end

			local var_152_7 = arg_149_1.actors_["10059"].transform
			local var_152_8 = 0

			if var_152_8 < arg_149_1.time_ and arg_149_1.time_ <= var_152_8 + arg_152_0 then
				arg_149_1.var_.moveOldPos10059 = var_152_7.localPosition
				var_152_7.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10059", 7)

				local var_152_9 = var_152_7.childCount

				for iter_152_1 = 0, var_152_9 - 1 do
					local var_152_10 = var_152_7:GetChild(iter_152_1)

					if var_152_10.name == "" or not string.find(var_152_10.name, "split") then
						var_152_10.gameObject:SetActive(true)
					else
						var_152_10.gameObject:SetActive(false)
					end
				end
			end

			local var_152_11 = 0.001

			if var_152_8 <= arg_149_1.time_ and arg_149_1.time_ < var_152_8 + var_152_11 then
				local var_152_12 = (arg_149_1.time_ - var_152_8) / var_152_11
				local var_152_13 = Vector3.New(0, -2000, 35)

				var_152_7.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10059, var_152_13, var_152_12)
			end

			if arg_149_1.time_ >= var_152_8 + var_152_11 and arg_149_1.time_ < var_152_8 + var_152_11 + arg_152_0 then
				var_152_7.localPosition = Vector3.New(0, -2000, 35)
			end

			local var_152_14 = arg_149_1.actors_["1061"]
			local var_152_15 = 0

			if var_152_15 < arg_149_1.time_ and arg_149_1.time_ <= var_152_15 + arg_152_0 and not isNil(var_152_14) and arg_149_1.var_.actorSpriteComps1061 == nil then
				arg_149_1.var_.actorSpriteComps1061 = var_152_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_16 = 0.034

			if var_152_15 <= arg_149_1.time_ and arg_149_1.time_ < var_152_15 + var_152_16 and not isNil(var_152_14) then
				local var_152_17 = (arg_149_1.time_ - var_152_15) / var_152_16

				if arg_149_1.var_.actorSpriteComps1061 then
					for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps1061:ToTable()) do
						if iter_152_3 then
							if arg_149_1.isInRecall_ then
								local var_152_18 = Mathf.Lerp(iter_152_3.color.r, arg_149_1.hightColor2.r, var_152_17)
								local var_152_19 = Mathf.Lerp(iter_152_3.color.g, arg_149_1.hightColor2.g, var_152_17)
								local var_152_20 = Mathf.Lerp(iter_152_3.color.b, arg_149_1.hightColor2.b, var_152_17)

								iter_152_3.color = Color.New(var_152_18, var_152_19, var_152_20)
							else
								local var_152_21 = Mathf.Lerp(iter_152_3.color.r, 0.5, var_152_17)

								iter_152_3.color = Color.New(var_152_21, var_152_21, var_152_21)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_15 + var_152_16 and arg_149_1.time_ < var_152_15 + var_152_16 + arg_152_0 and not isNil(var_152_14) and arg_149_1.var_.actorSpriteComps1061 then
				for iter_152_4, iter_152_5 in pairs(arg_149_1.var_.actorSpriteComps1061:ToTable()) do
					if iter_152_5 then
						if arg_149_1.isInRecall_ then
							iter_152_5.color = arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_152_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps1061 = nil
			end

			local var_152_22 = arg_149_1.actors_["10059"]
			local var_152_23 = 0

			if var_152_23 < arg_149_1.time_ and arg_149_1.time_ <= var_152_23 + arg_152_0 and not isNil(var_152_22) and arg_149_1.var_.actorSpriteComps10059 == nil then
				arg_149_1.var_.actorSpriteComps10059 = var_152_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_24 = 0.034

			if var_152_23 <= arg_149_1.time_ and arg_149_1.time_ < var_152_23 + var_152_24 and not isNil(var_152_22) then
				local var_152_25 = (arg_149_1.time_ - var_152_23) / var_152_24

				if arg_149_1.var_.actorSpriteComps10059 then
					for iter_152_6, iter_152_7 in pairs(arg_149_1.var_.actorSpriteComps10059:ToTable()) do
						if iter_152_7 then
							if arg_149_1.isInRecall_ then
								local var_152_26 = Mathf.Lerp(iter_152_7.color.r, arg_149_1.hightColor2.r, var_152_25)
								local var_152_27 = Mathf.Lerp(iter_152_7.color.g, arg_149_1.hightColor2.g, var_152_25)
								local var_152_28 = Mathf.Lerp(iter_152_7.color.b, arg_149_1.hightColor2.b, var_152_25)

								iter_152_7.color = Color.New(var_152_26, var_152_27, var_152_28)
							else
								local var_152_29 = Mathf.Lerp(iter_152_7.color.r, 0.5, var_152_25)

								iter_152_7.color = Color.New(var_152_29, var_152_29, var_152_29)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_23 + var_152_24 and arg_149_1.time_ < var_152_23 + var_152_24 + arg_152_0 and not isNil(var_152_22) and arg_149_1.var_.actorSpriteComps10059 then
				for iter_152_8, iter_152_9 in pairs(arg_149_1.var_.actorSpriteComps10059:ToTable()) do
					if iter_152_9 then
						if arg_149_1.isInRecall_ then
							iter_152_9.color = arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_152_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps10059 = nil
			end

			local var_152_30 = arg_149_1.actors_["10062"].transform
			local var_152_31 = 0

			if var_152_31 < arg_149_1.time_ and arg_149_1.time_ <= var_152_31 + arg_152_0 then
				arg_149_1.var_.moveOldPos10062 = var_152_30.localPosition
				var_152_30.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10062", 3)

				local var_152_32 = var_152_30.childCount

				for iter_152_10 = 0, var_152_32 - 1 do
					local var_152_33 = var_152_30:GetChild(iter_152_10)

					if var_152_33.name == "" or not string.find(var_152_33.name, "split") then
						var_152_33.gameObject:SetActive(true)
					else
						var_152_33.gameObject:SetActive(false)
					end
				end
			end

			local var_152_34 = 0.001

			if var_152_31 <= arg_149_1.time_ and arg_149_1.time_ < var_152_31 + var_152_34 then
				local var_152_35 = (arg_149_1.time_ - var_152_31) / var_152_34
				local var_152_36 = Vector3.New(0, -390, -290)

				var_152_30.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10062, var_152_36, var_152_35)
			end

			if arg_149_1.time_ >= var_152_31 + var_152_34 and arg_149_1.time_ < var_152_31 + var_152_34 + arg_152_0 then
				var_152_30.localPosition = Vector3.New(0, -390, -290)
			end

			local var_152_37 = arg_149_1.actors_["10062"]
			local var_152_38 = 0

			if var_152_38 < arg_149_1.time_ and arg_149_1.time_ <= var_152_38 + arg_152_0 and not isNil(var_152_37) and arg_149_1.var_.actorSpriteComps10062 == nil then
				arg_149_1.var_.actorSpriteComps10062 = var_152_37:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_39 = 0.034

			if var_152_38 <= arg_149_1.time_ and arg_149_1.time_ < var_152_38 + var_152_39 and not isNil(var_152_37) then
				local var_152_40 = (arg_149_1.time_ - var_152_38) / var_152_39

				if arg_149_1.var_.actorSpriteComps10062 then
					for iter_152_11, iter_152_12 in pairs(arg_149_1.var_.actorSpriteComps10062:ToTable()) do
						if iter_152_12 then
							if arg_149_1.isInRecall_ then
								local var_152_41 = Mathf.Lerp(iter_152_12.color.r, arg_149_1.hightColor2.r, var_152_40)
								local var_152_42 = Mathf.Lerp(iter_152_12.color.g, arg_149_1.hightColor2.g, var_152_40)
								local var_152_43 = Mathf.Lerp(iter_152_12.color.b, arg_149_1.hightColor2.b, var_152_40)

								iter_152_12.color = Color.New(var_152_41, var_152_42, var_152_43)
							else
								local var_152_44 = Mathf.Lerp(iter_152_12.color.r, 0.5, var_152_40)

								iter_152_12.color = Color.New(var_152_44, var_152_44, var_152_44)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= var_152_38 + var_152_39 and arg_149_1.time_ < var_152_38 + var_152_39 + arg_152_0 and not isNil(var_152_37) and arg_149_1.var_.actorSpriteComps10062 then
				for iter_152_13, iter_152_14 in pairs(arg_149_1.var_.actorSpriteComps10062:ToTable()) do
					if iter_152_14 then
						if arg_149_1.isInRecall_ then
							iter_152_14.color = arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_152_14.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_149_1.var_.actorSpriteComps10062 = nil
			end

			local var_152_45 = 0
			local var_152_46 = 0.675

			if var_152_45 < arg_149_1.time_ and arg_149_1.time_ <= var_152_45 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_47 = arg_149_1:GetWordFromCfg(410172037)
				local var_152_48 = arg_149_1:FormatText(var_152_47.content)

				arg_149_1.text_.text = var_152_48

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_49 = 27
				local var_152_50 = utf8.len(var_152_48)
				local var_152_51 = var_152_49 <= 0 and var_152_46 or var_152_46 * (var_152_50 / var_152_49)

				if var_152_51 > 0 and var_152_46 < var_152_51 then
					arg_149_1.talkMaxDuration = var_152_51

					if var_152_51 + var_152_45 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_51 + var_152_45
					end
				end

				arg_149_1.text_.text = var_152_48
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_52 = math.max(var_152_46, arg_149_1.talkMaxDuration)

			if var_152_45 <= arg_149_1.time_ and arg_149_1.time_ < var_152_45 + var_152_52 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_45) / var_152_52

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_45 + var_152_52 and arg_149_1.time_ < var_152_45 + var_152_52 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10059",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10062",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play410172038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 410172038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
			arg_153_1.auto_ = false
		end

		function arg_153_1.playNext_(arg_155_0)
			arg_153_1.onStoryFinished_()
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.8

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_2 = arg_153_1:GetWordFromCfg(410172038)
				local var_156_3 = arg_153_1:FormatText(var_156_2.content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 32
				local var_156_5 = utf8.len(var_156_3)
				local var_156_6 = var_156_4 <= 0 and var_156_1 or var_156_1 * (var_156_5 / var_156_4)

				if var_156_6 > 0 and var_156_1 < var_156_6 then
					arg_153_1.talkMaxDuration = var_156_6

					if var_156_6 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_6 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_3
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_7 and arg_153_1.time_ < var_156_0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L04g"
	},
	voices = {
		"story_v_out_410172.awb"
	}
}
