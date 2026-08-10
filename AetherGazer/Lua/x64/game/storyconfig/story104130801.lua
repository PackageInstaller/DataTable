return {
	Play413081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413081001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play413081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F08m"

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
				local var_4_5 = arg_1_1.bgs_.F08m

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
					if iter_4_0 ~= "F08m" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

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
			local var_4_25 = 0.266666666666667

			if var_4_24 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				local var_4_26 = "play"
				local var_4_27 = "music"

				arg_1_1:AudioAction(var_4_26, var_4_27, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = ""
				local var_4_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_29 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 0.366666666666667
			local var_4_31 = 0.833333333333333

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_32 = "play"
				local var_4_33 = "music"

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense")

				if var_4_35 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_35 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_35

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_35
						arg_1_1.bgmTxt2_.text = var_4_35
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

			local var_4_36 = 2
			local var_4_37 = 1

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				local var_4_38 = "play"
				local var_4_39 = "effect"

				arg_1_1:AudioAction(var_4_38, var_4_39, "se_story_134_01", "se_story_134_01_crowd", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_40 = 2
			local var_4_41 = 1.4

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_42 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_42:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_43 = arg_1_1:GetWordFromCfg(413081001)
				local var_4_44 = arg_1_1:FormatText(var_4_43.content)

				arg_1_1.text_.text = var_4_44

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_45 = 56
				local var_4_46 = utf8.len(var_4_44)
				local var_4_47 = var_4_45 <= 0 and var_4_41 or var_4_41 * (var_4_46 / var_4_45)

				if var_4_47 > 0 and var_4_41 < var_4_47 then
					arg_1_1.talkMaxDuration = var_4_47
					var_4_40 = var_4_40 + 0.3

					if var_4_47 + var_4_40 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_47 + var_4_40
					end
				end

				arg_1_1.text_.text = var_4_44
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_48 = var_4_40 + 0.3
			local var_4_49 = math.max(var_4_41, arg_1_1.talkMaxDuration)

			if var_4_48 <= arg_1_1.time_ and arg_1_1.time_ < var_4_48 + var_4_49 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_48) / var_4_49

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_48 + var_4_49 and arg_1_1.time_ < var_4_48 + var_4_49 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play413081002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413081002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play413081003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.825

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

				local var_12_2 = arg_9_1:GetWordFromCfg(413081002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 73
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
	Play413081003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413081003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play413081004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 1.575

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

				local var_16_2 = arg_13_1:GetWordFromCfg(413081003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 63
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
	Play413081004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413081004
		arg_17_1.duration_ = 12.43

		local var_17_0 = {
			zh = 6.2,
			ja = 12.433
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
				arg_17_0:Play413081005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = "10092"

			if arg_17_1.actors_[var_20_0] == nil then
				local var_20_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

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

			local var_20_4 = arg_17_1.actors_["10092"].transform
			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.var_.moveOldPos10092 = var_20_4.localPosition
				var_20_4.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10092", 3)

				local var_20_6 = var_20_4.childCount

				for iter_20_2 = 0, var_20_6 - 1 do
					local var_20_7 = var_20_4:GetChild(iter_20_2)

					if var_20_7.name == "split_8" or not string.find(var_20_7.name, "split") then
						var_20_7.gameObject:SetActive(true)
					else
						var_20_7.gameObject:SetActive(false)
					end
				end
			end

			local var_20_8 = 0.001

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_8 then
				local var_20_9 = (arg_17_1.time_ - var_20_5) / var_20_8
				local var_20_10 = Vector3.New(0, -300, -295)

				var_20_4.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10092, var_20_10, var_20_9)
			end

			if arg_17_1.time_ >= var_20_5 + var_20_8 and arg_17_1.time_ < var_20_5 + var_20_8 + arg_20_0 then
				var_20_4.localPosition = Vector3.New(0, -300, -295)
			end

			local var_20_11 = arg_17_1.actors_["10092"]
			local var_20_12 = 0

			if var_20_12 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 and not isNil(var_20_11) and arg_17_1.var_.actorSpriteComps10092 == nil then
				arg_17_1.var_.actorSpriteComps10092 = var_20_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_13 = 2

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_13 and not isNil(var_20_11) then
				local var_20_14 = (arg_17_1.time_ - var_20_12) / var_20_13

				if arg_17_1.var_.actorSpriteComps10092 then
					for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_20_4 then
							if arg_17_1.isInRecall_ then
								local var_20_15 = Mathf.Lerp(iter_20_4.color.r, arg_17_1.hightColor1.r, var_20_14)
								local var_20_16 = Mathf.Lerp(iter_20_4.color.g, arg_17_1.hightColor1.g, var_20_14)
								local var_20_17 = Mathf.Lerp(iter_20_4.color.b, arg_17_1.hightColor1.b, var_20_14)

								iter_20_4.color = Color.New(var_20_15, var_20_16, var_20_17)
							else
								local var_20_18 = Mathf.Lerp(iter_20_4.color.r, 1, var_20_14)

								iter_20_4.color = Color.New(var_20_18, var_20_18, var_20_18)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= var_20_12 + var_20_13 and arg_17_1.time_ < var_20_12 + var_20_13 + arg_20_0 and not isNil(var_20_11) and arg_17_1.var_.actorSpriteComps10092 then
				for iter_20_5, iter_20_6 in pairs(arg_17_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_20_6 then
						if arg_17_1.isInRecall_ then
							iter_20_6.color = arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_20_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_17_1.var_.actorSpriteComps10092 = nil
			end

			local var_20_19 = arg_17_1.actors_["10092"]
			local var_20_20 = 0

			if var_20_20 < arg_17_1.time_ and arg_17_1.time_ <= var_20_20 + arg_20_0 then
				local var_20_21 = var_20_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_20_21 then
					arg_17_1.var_.alphaOldValue10092 = var_20_21.alpha
					arg_17_1.var_.characterEffect10092 = var_20_21
				end

				arg_17_1.var_.alphaOldValue10092 = 0
			end

			local var_20_22 = 0.5

			if var_20_20 <= arg_17_1.time_ and arg_17_1.time_ < var_20_20 + var_20_22 then
				local var_20_23 = (arg_17_1.time_ - var_20_20) / var_20_22
				local var_20_24 = Mathf.Lerp(arg_17_1.var_.alphaOldValue10092, 1, var_20_23)

				if arg_17_1.var_.characterEffect10092 then
					arg_17_1.var_.characterEffect10092.alpha = var_20_24
				end
			end

			if arg_17_1.time_ >= var_20_20 + var_20_22 and arg_17_1.time_ < var_20_20 + var_20_22 + arg_20_0 and arg_17_1.var_.characterEffect10092 then
				arg_17_1.var_.characterEffect10092.alpha = 1
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_25 = 0.5
			local var_20_26 = 0.725

			if var_20_25 < arg_17_1.time_ and arg_17_1.time_ <= var_20_25 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_27 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_27:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_28 = arg_17_1:FormatText(StoryNameCfg[996].name)

				arg_17_1.leftNameTxt_.text = var_20_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_29 = arg_17_1:GetWordFromCfg(413081004)
				local var_20_30 = arg_17_1:FormatText(var_20_29.content)

				arg_17_1.text_.text = var_20_30

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_31 = 29
				local var_20_32 = utf8.len(var_20_30)
				local var_20_33 = var_20_31 <= 0 and var_20_26 or var_20_26 * (var_20_32 / var_20_31)

				if var_20_33 > 0 and var_20_26 < var_20_33 then
					arg_17_1.talkMaxDuration = var_20_33
					var_20_25 = var_20_25 + 0.3

					if var_20_33 + var_20_25 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_33 + var_20_25
					end
				end

				arg_17_1.text_.text = var_20_30
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081004", "story_v_out_413081.awb") ~= 0 then
					local var_20_34 = manager.audio:GetVoiceLength("story_v_out_413081", "413081004", "story_v_out_413081.awb") / 1000

					if var_20_34 + var_20_25 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_34 + var_20_25
					end

					if var_20_29.prefab_name ~= "" and arg_17_1.actors_[var_20_29.prefab_name] ~= nil then
						local var_20_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_29.prefab_name].transform, "story_v_out_413081", "413081004", "story_v_out_413081.awb")

						arg_17_1:RecordAudio("413081004", var_20_35)
						arg_17_1:RecordAudio("413081004", var_20_35)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413081", "413081004", "story_v_out_413081.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413081", "413081004", "story_v_out_413081.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_36 = var_20_25 + 0.3
			local var_20_37 = math.max(var_20_26, arg_17_1.talkMaxDuration)

			if var_20_36 <= arg_17_1.time_ and arg_17_1.time_ < var_20_36 + var_20_37 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_36) / var_20_37

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_36 + var_20_37 and arg_17_1.time_ < var_20_36 + var_20_37 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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
	Play413081005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 413081005
		arg_23_1.duration_ = 5.1

		local var_23_0 = {
			zh = 3.033,
			ja = 5.1
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play413081006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["10092"]
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.actorSpriteComps10092 == nil then
				arg_23_1.var_.actorSpriteComps10092 = var_26_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_2 = 2

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 and not isNil(var_26_0) then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2

				if arg_23_1.var_.actorSpriteComps10092 then
					for iter_26_0, iter_26_1 in pairs(arg_23_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_26_1 then
							if arg_23_1.isInRecall_ then
								local var_26_4 = Mathf.Lerp(iter_26_1.color.r, arg_23_1.hightColor2.r, var_26_3)
								local var_26_5 = Mathf.Lerp(iter_26_1.color.g, arg_23_1.hightColor2.g, var_26_3)
								local var_26_6 = Mathf.Lerp(iter_26_1.color.b, arg_23_1.hightColor2.b, var_26_3)

								iter_26_1.color = Color.New(var_26_4, var_26_5, var_26_6)
							else
								local var_26_7 = Mathf.Lerp(iter_26_1.color.r, 0.5, var_26_3)

								iter_26_1.color = Color.New(var_26_7, var_26_7, var_26_7)
							end
						end
					end
				end
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.actorSpriteComps10092 then
				for iter_26_2, iter_26_3 in pairs(arg_23_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_26_3 then
						if arg_23_1.isInRecall_ then
							iter_26_3.color = arg_23_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_26_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_23_1.var_.actorSpriteComps10092 = nil
			end

			local var_26_8 = 0
			local var_26_9 = 0.3

			if var_26_8 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_10 = arg_23_1:FormatText(StoryNameCfg[992].name)

				arg_23_1.leftNameTxt_.text = var_26_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_11 = arg_23_1:GetWordFromCfg(413081005)
				local var_26_12 = arg_23_1:FormatText(var_26_11.content)

				arg_23_1.text_.text = var_26_12

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_13 = 12
				local var_26_14 = utf8.len(var_26_12)
				local var_26_15 = var_26_13 <= 0 and var_26_9 or var_26_9 * (var_26_14 / var_26_13)

				if var_26_15 > 0 and var_26_9 < var_26_15 then
					arg_23_1.talkMaxDuration = var_26_15

					if var_26_15 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_15 + var_26_8
					end
				end

				arg_23_1.text_.text = var_26_12
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081005", "story_v_out_413081.awb") ~= 0 then
					local var_26_16 = manager.audio:GetVoiceLength("story_v_out_413081", "413081005", "story_v_out_413081.awb") / 1000

					if var_26_16 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_16 + var_26_8
					end

					if var_26_11.prefab_name ~= "" and arg_23_1.actors_[var_26_11.prefab_name] ~= nil then
						local var_26_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_11.prefab_name].transform, "story_v_out_413081", "413081005", "story_v_out_413081.awb")

						arg_23_1:RecordAudio("413081005", var_26_17)
						arg_23_1:RecordAudio("413081005", var_26_17)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_413081", "413081005", "story_v_out_413081.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_413081", "413081005", "story_v_out_413081.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_18 = math.max(var_26_9, arg_23_1.talkMaxDuration)

			if var_26_8 <= arg_23_1.time_ and arg_23_1.time_ < var_26_8 + var_26_18 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_8) / var_26_18

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_8 + var_26_18 and arg_23_1.time_ < var_26_8 + var_26_18 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play413081006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 413081006
		arg_27_1.duration_ = 5.2

		local var_27_0 = {
			zh = 3.666,
			ja = 5.2
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play413081007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["10092"]
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.actorSpriteComps10092 == nil then
				arg_27_1.var_.actorSpriteComps10092 = var_30_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_2 = 2

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 and not isNil(var_30_0) then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2

				if arg_27_1.var_.actorSpriteComps10092 then
					for iter_30_0, iter_30_1 in pairs(arg_27_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_30_1 then
							if arg_27_1.isInRecall_ then
								local var_30_4 = Mathf.Lerp(iter_30_1.color.r, arg_27_1.hightColor1.r, var_30_3)
								local var_30_5 = Mathf.Lerp(iter_30_1.color.g, arg_27_1.hightColor1.g, var_30_3)
								local var_30_6 = Mathf.Lerp(iter_30_1.color.b, arg_27_1.hightColor1.b, var_30_3)

								iter_30_1.color = Color.New(var_30_4, var_30_5, var_30_6)
							else
								local var_30_7 = Mathf.Lerp(iter_30_1.color.r, 1, var_30_3)

								iter_30_1.color = Color.New(var_30_7, var_30_7, var_30_7)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 and not isNil(var_30_0) and arg_27_1.var_.actorSpriteComps10092 then
				for iter_30_2, iter_30_3 in pairs(arg_27_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_30_3 then
						if arg_27_1.isInRecall_ then
							iter_30_3.color = arg_27_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_30_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_27_1.var_.actorSpriteComps10092 = nil
			end

			local var_30_8 = 0
			local var_30_9 = 0.4

			if var_30_8 < arg_27_1.time_ and arg_27_1.time_ <= var_30_8 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_10 = arg_27_1:FormatText(StoryNameCfg[996].name)

				arg_27_1.leftNameTxt_.text = var_30_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_11 = arg_27_1:GetWordFromCfg(413081006)
				local var_30_12 = arg_27_1:FormatText(var_30_11.content)

				arg_27_1.text_.text = var_30_12

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_13 = 16
				local var_30_14 = utf8.len(var_30_12)
				local var_30_15 = var_30_13 <= 0 and var_30_9 or var_30_9 * (var_30_14 / var_30_13)

				if var_30_15 > 0 and var_30_9 < var_30_15 then
					arg_27_1.talkMaxDuration = var_30_15

					if var_30_15 + var_30_8 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_15 + var_30_8
					end
				end

				arg_27_1.text_.text = var_30_12
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081006", "story_v_out_413081.awb") ~= 0 then
					local var_30_16 = manager.audio:GetVoiceLength("story_v_out_413081", "413081006", "story_v_out_413081.awb") / 1000

					if var_30_16 + var_30_8 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_16 + var_30_8
					end

					if var_30_11.prefab_name ~= "" and arg_27_1.actors_[var_30_11.prefab_name] ~= nil then
						local var_30_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_11.prefab_name].transform, "story_v_out_413081", "413081006", "story_v_out_413081.awb")

						arg_27_1:RecordAudio("413081006", var_30_17)
						arg_27_1:RecordAudio("413081006", var_30_17)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_413081", "413081006", "story_v_out_413081.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_413081", "413081006", "story_v_out_413081.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_18 = math.max(var_30_9, arg_27_1.talkMaxDuration)

			if var_30_8 <= arg_27_1.time_ and arg_27_1.time_ < var_30_8 + var_30_18 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_8) / var_30_18

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_8 + var_30_18 and arg_27_1.time_ < var_30_8 + var_30_18 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play413081007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 413081007
		arg_31_1.duration_ = 9.87

		local var_31_0 = {
			zh = 6.066,
			ja = 9.866
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play413081008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["10092"]
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.actorSpriteComps10092 == nil then
				arg_31_1.var_.actorSpriteComps10092 = var_34_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_2 = 2

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 and not isNil(var_34_0) then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2

				if arg_31_1.var_.actorSpriteComps10092 then
					for iter_34_0, iter_34_1 in pairs(arg_31_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_34_1 then
							if arg_31_1.isInRecall_ then
								local var_34_4 = Mathf.Lerp(iter_34_1.color.r, arg_31_1.hightColor2.r, var_34_3)
								local var_34_5 = Mathf.Lerp(iter_34_1.color.g, arg_31_1.hightColor2.g, var_34_3)
								local var_34_6 = Mathf.Lerp(iter_34_1.color.b, arg_31_1.hightColor2.b, var_34_3)

								iter_34_1.color = Color.New(var_34_4, var_34_5, var_34_6)
							else
								local var_34_7 = Mathf.Lerp(iter_34_1.color.r, 0.5, var_34_3)

								iter_34_1.color = Color.New(var_34_7, var_34_7, var_34_7)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.actorSpriteComps10092 then
				for iter_34_2, iter_34_3 in pairs(arg_31_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_34_3 then
						if arg_31_1.isInRecall_ then
							iter_34_3.color = arg_31_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_34_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_31_1.var_.actorSpriteComps10092 = nil
			end

			local var_34_8 = 0
			local var_34_9 = 0.9

			if var_34_8 < arg_31_1.time_ and arg_31_1.time_ <= var_34_8 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_10 = arg_31_1:FormatText(StoryNameCfg[992].name)

				arg_31_1.leftNameTxt_.text = var_34_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_11 = arg_31_1:GetWordFromCfg(413081007)
				local var_34_12 = arg_31_1:FormatText(var_34_11.content)

				arg_31_1.text_.text = var_34_12

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_13 = 36
				local var_34_14 = utf8.len(var_34_12)
				local var_34_15 = var_34_13 <= 0 and var_34_9 or var_34_9 * (var_34_14 / var_34_13)

				if var_34_15 > 0 and var_34_9 < var_34_15 then
					arg_31_1.talkMaxDuration = var_34_15

					if var_34_15 + var_34_8 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_15 + var_34_8
					end
				end

				arg_31_1.text_.text = var_34_12
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081007", "story_v_out_413081.awb") ~= 0 then
					local var_34_16 = manager.audio:GetVoiceLength("story_v_out_413081", "413081007", "story_v_out_413081.awb") / 1000

					if var_34_16 + var_34_8 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_16 + var_34_8
					end

					if var_34_11.prefab_name ~= "" and arg_31_1.actors_[var_34_11.prefab_name] ~= nil then
						local var_34_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_11.prefab_name].transform, "story_v_out_413081", "413081007", "story_v_out_413081.awb")

						arg_31_1:RecordAudio("413081007", var_34_17)
						arg_31_1:RecordAudio("413081007", var_34_17)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_413081", "413081007", "story_v_out_413081.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_413081", "413081007", "story_v_out_413081.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_18 = math.max(var_34_9, arg_31_1.talkMaxDuration)

			if var_34_8 <= arg_31_1.time_ and arg_31_1.time_ < var_34_8 + var_34_18 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_8) / var_34_18

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_8 + var_34_18 and arg_31_1.time_ < var_34_8 + var_34_18 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play413081008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 413081008
		arg_35_1.duration_ = 5.83

		local var_35_0 = {
			zh = 3.966,
			ja = 5.833
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play413081009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["10092"].transform
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.var_.moveOldPos10092 = var_38_0.localPosition
				var_38_0.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("10092", 3)

				local var_38_2 = var_38_0.childCount

				for iter_38_0 = 0, var_38_2 - 1 do
					local var_38_3 = var_38_0:GetChild(iter_38_0)

					if var_38_3.name == "split_5" or not string.find(var_38_3.name, "split") then
						var_38_3.gameObject:SetActive(true)
					else
						var_38_3.gameObject:SetActive(false)
					end
				end
			end

			local var_38_4 = 0.001

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_4 then
				local var_38_5 = (arg_35_1.time_ - var_38_1) / var_38_4
				local var_38_6 = Vector3.New(0, -300, -295)

				var_38_0.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10092, var_38_6, var_38_5)
			end

			if arg_35_1.time_ >= var_38_1 + var_38_4 and arg_35_1.time_ < var_38_1 + var_38_4 + arg_38_0 then
				var_38_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_38_7 = arg_35_1.actors_["10092"]
			local var_38_8 = 0

			if var_38_8 < arg_35_1.time_ and arg_35_1.time_ <= var_38_8 + arg_38_0 and not isNil(var_38_7) and arg_35_1.var_.actorSpriteComps10092 == nil then
				arg_35_1.var_.actorSpriteComps10092 = var_38_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_9 = 2

			if var_38_8 <= arg_35_1.time_ and arg_35_1.time_ < var_38_8 + var_38_9 and not isNil(var_38_7) then
				local var_38_10 = (arg_35_1.time_ - var_38_8) / var_38_9

				if arg_35_1.var_.actorSpriteComps10092 then
					for iter_38_1, iter_38_2 in pairs(arg_35_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_38_2 then
							if arg_35_1.isInRecall_ then
								local var_38_11 = Mathf.Lerp(iter_38_2.color.r, arg_35_1.hightColor1.r, var_38_10)
								local var_38_12 = Mathf.Lerp(iter_38_2.color.g, arg_35_1.hightColor1.g, var_38_10)
								local var_38_13 = Mathf.Lerp(iter_38_2.color.b, arg_35_1.hightColor1.b, var_38_10)

								iter_38_2.color = Color.New(var_38_11, var_38_12, var_38_13)
							else
								local var_38_14 = Mathf.Lerp(iter_38_2.color.r, 1, var_38_10)

								iter_38_2.color = Color.New(var_38_14, var_38_14, var_38_14)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= var_38_8 + var_38_9 and arg_35_1.time_ < var_38_8 + var_38_9 + arg_38_0 and not isNil(var_38_7) and arg_35_1.var_.actorSpriteComps10092 then
				for iter_38_3, iter_38_4 in pairs(arg_35_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_38_4 then
						if arg_35_1.isInRecall_ then
							iter_38_4.color = arg_35_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_38_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_35_1.var_.actorSpriteComps10092 = nil
			end

			local var_38_15 = 0
			local var_38_16 = 0.45

			if var_38_15 < arg_35_1.time_ and arg_35_1.time_ <= var_38_15 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_17 = arg_35_1:FormatText(StoryNameCfg[996].name)

				arg_35_1.leftNameTxt_.text = var_38_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_18 = arg_35_1:GetWordFromCfg(413081008)
				local var_38_19 = arg_35_1:FormatText(var_38_18.content)

				arg_35_1.text_.text = var_38_19

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_20 = 18
				local var_38_21 = utf8.len(var_38_19)
				local var_38_22 = var_38_20 <= 0 and var_38_16 or var_38_16 * (var_38_21 / var_38_20)

				if var_38_22 > 0 and var_38_16 < var_38_22 then
					arg_35_1.talkMaxDuration = var_38_22

					if var_38_22 + var_38_15 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_22 + var_38_15
					end
				end

				arg_35_1.text_.text = var_38_19
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081008", "story_v_out_413081.awb") ~= 0 then
					local var_38_23 = manager.audio:GetVoiceLength("story_v_out_413081", "413081008", "story_v_out_413081.awb") / 1000

					if var_38_23 + var_38_15 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_23 + var_38_15
					end

					if var_38_18.prefab_name ~= "" and arg_35_1.actors_[var_38_18.prefab_name] ~= nil then
						local var_38_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_18.prefab_name].transform, "story_v_out_413081", "413081008", "story_v_out_413081.awb")

						arg_35_1:RecordAudio("413081008", var_38_24)
						arg_35_1:RecordAudio("413081008", var_38_24)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_413081", "413081008", "story_v_out_413081.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_413081", "413081008", "story_v_out_413081.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_25 = math.max(var_38_16, arg_35_1.talkMaxDuration)

			if var_38_15 <= arg_35_1.time_ and arg_35_1.time_ < var_38_15 + var_38_25 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_15) / var_38_25

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_15 + var_38_25 and arg_35_1.time_ < var_38_15 + var_38_25 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play413081009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 413081009
		arg_39_1.duration_ = 11.53

		local var_39_0 = {
			zh = 4.133,
			ja = 11.533
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play413081010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["10092"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.actorSpriteComps10092 == nil then
				arg_39_1.var_.actorSpriteComps10092 = var_42_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_2 = 2

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 and not isNil(var_42_0) then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2

				if arg_39_1.var_.actorSpriteComps10092 then
					for iter_42_0, iter_42_1 in pairs(arg_39_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_42_1 then
							if arg_39_1.isInRecall_ then
								local var_42_4 = Mathf.Lerp(iter_42_1.color.r, arg_39_1.hightColor2.r, var_42_3)
								local var_42_5 = Mathf.Lerp(iter_42_1.color.g, arg_39_1.hightColor2.g, var_42_3)
								local var_42_6 = Mathf.Lerp(iter_42_1.color.b, arg_39_1.hightColor2.b, var_42_3)

								iter_42_1.color = Color.New(var_42_4, var_42_5, var_42_6)
							else
								local var_42_7 = Mathf.Lerp(iter_42_1.color.r, 0.5, var_42_3)

								iter_42_1.color = Color.New(var_42_7, var_42_7, var_42_7)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.actorSpriteComps10092 then
				for iter_42_2, iter_42_3 in pairs(arg_39_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_42_3 then
						if arg_39_1.isInRecall_ then
							iter_42_3.color = arg_39_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_42_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_39_1.var_.actorSpriteComps10092 = nil
			end

			local var_42_8 = 0
			local var_42_9 = 0.65

			if var_42_8 < arg_39_1.time_ and arg_39_1.time_ <= var_42_8 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_10 = arg_39_1:FormatText(StoryNameCfg[992].name)

				arg_39_1.leftNameTxt_.text = var_42_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_11 = arg_39_1:GetWordFromCfg(413081009)
				local var_42_12 = arg_39_1:FormatText(var_42_11.content)

				arg_39_1.text_.text = var_42_12

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_13 = 26
				local var_42_14 = utf8.len(var_42_12)
				local var_42_15 = var_42_13 <= 0 and var_42_9 or var_42_9 * (var_42_14 / var_42_13)

				if var_42_15 > 0 and var_42_9 < var_42_15 then
					arg_39_1.talkMaxDuration = var_42_15

					if var_42_15 + var_42_8 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_15 + var_42_8
					end
				end

				arg_39_1.text_.text = var_42_12
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081009", "story_v_out_413081.awb") ~= 0 then
					local var_42_16 = manager.audio:GetVoiceLength("story_v_out_413081", "413081009", "story_v_out_413081.awb") / 1000

					if var_42_16 + var_42_8 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_16 + var_42_8
					end

					if var_42_11.prefab_name ~= "" and arg_39_1.actors_[var_42_11.prefab_name] ~= nil then
						local var_42_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_11.prefab_name].transform, "story_v_out_413081", "413081009", "story_v_out_413081.awb")

						arg_39_1:RecordAudio("413081009", var_42_17)
						arg_39_1:RecordAudio("413081009", var_42_17)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_413081", "413081009", "story_v_out_413081.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_413081", "413081009", "story_v_out_413081.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_18 = math.max(var_42_9, arg_39_1.talkMaxDuration)

			if var_42_8 <= arg_39_1.time_ and arg_39_1.time_ < var_42_8 + var_42_18 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_8) / var_42_18

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_8 + var_42_18 and arg_39_1.time_ < var_42_8 + var_42_18 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play413081010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 413081010
		arg_43_1.duration_ = 5.07

		local var_43_0 = {
			zh = 5.066,
			ja = 4.7
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play413081011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["10092"].transform
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.var_.moveOldPos10092 = var_46_0.localPosition
				var_46_0.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("10092", 7)

				local var_46_2 = var_46_0.childCount

				for iter_46_0 = 0, var_46_2 - 1 do
					local var_46_3 = var_46_0:GetChild(iter_46_0)

					if var_46_3.name == "split_8" or not string.find(var_46_3.name, "split") then
						var_46_3.gameObject:SetActive(true)
					else
						var_46_3.gameObject:SetActive(false)
					end
				end
			end

			local var_46_4 = 0.001

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_4 then
				local var_46_5 = (arg_43_1.time_ - var_46_1) / var_46_4
				local var_46_6 = Vector3.New(0, -2000, 0)

				var_46_0.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10092, var_46_6, var_46_5)
			end

			if arg_43_1.time_ >= var_46_1 + var_46_4 and arg_43_1.time_ < var_46_1 + var_46_4 + arg_46_0 then
				var_46_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_46_7 = "10093"

			if arg_43_1.actors_[var_46_7] == nil then
				local var_46_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_46_8) then
					local var_46_9 = Object.Instantiate(var_46_8, arg_43_1.canvasGo_.transform)

					var_46_9.transform:SetSiblingIndex(1)

					var_46_9.name = var_46_7
					var_46_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_43_1.actors_[var_46_7] = var_46_9

					local var_46_10 = var_46_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_43_1.isInRecall_ then
						for iter_46_1, iter_46_2 in ipairs(var_46_10) do
							iter_46_2.color = arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_46_11 = arg_43_1.actors_["10093"].transform
			local var_46_12 = 0

			if var_46_12 < arg_43_1.time_ and arg_43_1.time_ <= var_46_12 + arg_46_0 then
				arg_43_1.var_.moveOldPos10093 = var_46_11.localPosition
				var_46_11.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("10093", 3)

				local var_46_13 = var_46_11.childCount

				for iter_46_3 = 0, var_46_13 - 1 do
					local var_46_14 = var_46_11:GetChild(iter_46_3)

					if var_46_14.name == "split_7" or not string.find(var_46_14.name, "split") then
						var_46_14.gameObject:SetActive(true)
					else
						var_46_14.gameObject:SetActive(false)
					end
				end
			end

			local var_46_15 = 0.001

			if var_46_12 <= arg_43_1.time_ and arg_43_1.time_ < var_46_12 + var_46_15 then
				local var_46_16 = (arg_43_1.time_ - var_46_12) / var_46_15
				local var_46_17 = Vector3.New(0, -345, -245)

				var_46_11.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10093, var_46_17, var_46_16)
			end

			if arg_43_1.time_ >= var_46_12 + var_46_15 and arg_43_1.time_ < var_46_12 + var_46_15 + arg_46_0 then
				var_46_11.localPosition = Vector3.New(0, -345, -245)
			end

			local var_46_18 = arg_43_1.actors_["10093"]
			local var_46_19 = 0

			if var_46_19 < arg_43_1.time_ and arg_43_1.time_ <= var_46_19 + arg_46_0 and not isNil(var_46_18) and arg_43_1.var_.actorSpriteComps10093 == nil then
				arg_43_1.var_.actorSpriteComps10093 = var_46_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_20 = 2

			if var_46_19 <= arg_43_1.time_ and arg_43_1.time_ < var_46_19 + var_46_20 and not isNil(var_46_18) then
				local var_46_21 = (arg_43_1.time_ - var_46_19) / var_46_20

				if arg_43_1.var_.actorSpriteComps10093 then
					for iter_46_4, iter_46_5 in pairs(arg_43_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_46_5 then
							if arg_43_1.isInRecall_ then
								local var_46_22 = Mathf.Lerp(iter_46_5.color.r, arg_43_1.hightColor1.r, var_46_21)
								local var_46_23 = Mathf.Lerp(iter_46_5.color.g, arg_43_1.hightColor1.g, var_46_21)
								local var_46_24 = Mathf.Lerp(iter_46_5.color.b, arg_43_1.hightColor1.b, var_46_21)

								iter_46_5.color = Color.New(var_46_22, var_46_23, var_46_24)
							else
								local var_46_25 = Mathf.Lerp(iter_46_5.color.r, 1, var_46_21)

								iter_46_5.color = Color.New(var_46_25, var_46_25, var_46_25)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_19 + var_46_20 and arg_43_1.time_ < var_46_19 + var_46_20 + arg_46_0 and not isNil(var_46_18) and arg_43_1.var_.actorSpriteComps10093 then
				for iter_46_6, iter_46_7 in pairs(arg_43_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_46_7 then
						if arg_43_1.isInRecall_ then
							iter_46_7.color = arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_46_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps10093 = nil
			end

			local var_46_26 = 0
			local var_46_27 = 0.6

			if var_46_26 < arg_43_1.time_ and arg_43_1.time_ <= var_46_26 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_28 = arg_43_1:FormatText(StoryNameCfg[28].name)

				arg_43_1.leftNameTxt_.text = var_46_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_29 = arg_43_1:GetWordFromCfg(413081010)
				local var_46_30 = arg_43_1:FormatText(var_46_29.content)

				arg_43_1.text_.text = var_46_30

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_31 = 24
				local var_46_32 = utf8.len(var_46_30)
				local var_46_33 = var_46_31 <= 0 and var_46_27 or var_46_27 * (var_46_32 / var_46_31)

				if var_46_33 > 0 and var_46_27 < var_46_33 then
					arg_43_1.talkMaxDuration = var_46_33

					if var_46_33 + var_46_26 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_33 + var_46_26
					end
				end

				arg_43_1.text_.text = var_46_30
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081010", "story_v_out_413081.awb") ~= 0 then
					local var_46_34 = manager.audio:GetVoiceLength("story_v_out_413081", "413081010", "story_v_out_413081.awb") / 1000

					if var_46_34 + var_46_26 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_34 + var_46_26
					end

					if var_46_29.prefab_name ~= "" and arg_43_1.actors_[var_46_29.prefab_name] ~= nil then
						local var_46_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_29.prefab_name].transform, "story_v_out_413081", "413081010", "story_v_out_413081.awb")

						arg_43_1:RecordAudio("413081010", var_46_35)
						arg_43_1:RecordAudio("413081010", var_46_35)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_413081", "413081010", "story_v_out_413081.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_413081", "413081010", "story_v_out_413081.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_36 = math.max(var_46_27, arg_43_1.talkMaxDuration)

			if var_46_26 <= arg_43_1.time_ and arg_43_1.time_ < var_46_26 + var_46_36 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_26) / var_46_36

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_26 + var_46_36 and arg_43_1.time_ < var_46_26 + var_46_36 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play413081011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 413081011
		arg_47_1.duration_ = 8.37

		local var_47_0 = {
			zh = 4.466,
			ja = 8.366
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play413081012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["10092"].transform
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.var_.moveOldPos10092 = var_50_0.localPosition
				var_50_0.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("10092", 7)

				local var_50_2 = var_50_0.childCount

				for iter_50_0 = 0, var_50_2 - 1 do
					local var_50_3 = var_50_0:GetChild(iter_50_0)

					if var_50_3.name == "" or not string.find(var_50_3.name, "split") then
						var_50_3.gameObject:SetActive(true)
					else
						var_50_3.gameObject:SetActive(false)
					end
				end
			end

			local var_50_4 = 0.001

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_4 then
				local var_50_5 = (arg_47_1.time_ - var_50_1) / var_50_4
				local var_50_6 = Vector3.New(0, -2000, -180)

				var_50_0.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10092, var_50_6, var_50_5)
			end

			if arg_47_1.time_ >= var_50_1 + var_50_4 and arg_47_1.time_ < var_50_1 + var_50_4 + arg_50_0 then
				var_50_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_50_7 = "10094"

			if arg_47_1.actors_[var_50_7] == nil then
				local var_50_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_50_8) then
					local var_50_9 = Object.Instantiate(var_50_8, arg_47_1.canvasGo_.transform)

					var_50_9.transform:SetSiblingIndex(1)

					var_50_9.name = var_50_7
					var_50_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_47_1.actors_[var_50_7] = var_50_9

					local var_50_10 = var_50_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_47_1.isInRecall_ then
						for iter_50_1, iter_50_2 in ipairs(var_50_10) do
							iter_50_2.color = arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_50_11 = arg_47_1.actors_["10094"].transform
			local var_50_12 = 0

			if var_50_12 < arg_47_1.time_ and arg_47_1.time_ <= var_50_12 + arg_50_0 then
				arg_47_1.var_.moveOldPos10094 = var_50_11.localPosition
				var_50_11.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("10094", 3)

				local var_50_13 = var_50_11.childCount

				for iter_50_3 = 0, var_50_13 - 1 do
					local var_50_14 = var_50_11:GetChild(iter_50_3)

					if var_50_14.name == "split_2" or not string.find(var_50_14.name, "split") then
						var_50_14.gameObject:SetActive(true)
					else
						var_50_14.gameObject:SetActive(false)
					end
				end
			end

			local var_50_15 = 0.001

			if var_50_12 <= arg_47_1.time_ and arg_47_1.time_ < var_50_12 + var_50_15 then
				local var_50_16 = (arg_47_1.time_ - var_50_12) / var_50_15
				local var_50_17 = Vector3.New(0, -340, -414)

				var_50_11.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10094, var_50_17, var_50_16)
			end

			if arg_47_1.time_ >= var_50_12 + var_50_15 and arg_47_1.time_ < var_50_12 + var_50_15 + arg_50_0 then
				var_50_11.localPosition = Vector3.New(0, -340, -414)
			end

			local var_50_18 = arg_47_1.actors_["10092"]
			local var_50_19 = 0

			if var_50_19 < arg_47_1.time_ and arg_47_1.time_ <= var_50_19 + arg_50_0 and not isNil(var_50_18) and arg_47_1.var_.actorSpriteComps10092 == nil then
				arg_47_1.var_.actorSpriteComps10092 = var_50_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_20 = 2

			if var_50_19 <= arg_47_1.time_ and arg_47_1.time_ < var_50_19 + var_50_20 and not isNil(var_50_18) then
				local var_50_21 = (arg_47_1.time_ - var_50_19) / var_50_20

				if arg_47_1.var_.actorSpriteComps10092 then
					for iter_50_4, iter_50_5 in pairs(arg_47_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_50_5 then
							if arg_47_1.isInRecall_ then
								local var_50_22 = Mathf.Lerp(iter_50_5.color.r, arg_47_1.hightColor2.r, var_50_21)
								local var_50_23 = Mathf.Lerp(iter_50_5.color.g, arg_47_1.hightColor2.g, var_50_21)
								local var_50_24 = Mathf.Lerp(iter_50_5.color.b, arg_47_1.hightColor2.b, var_50_21)

								iter_50_5.color = Color.New(var_50_22, var_50_23, var_50_24)
							else
								local var_50_25 = Mathf.Lerp(iter_50_5.color.r, 0.5, var_50_21)

								iter_50_5.color = Color.New(var_50_25, var_50_25, var_50_25)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= var_50_19 + var_50_20 and arg_47_1.time_ < var_50_19 + var_50_20 + arg_50_0 and not isNil(var_50_18) and arg_47_1.var_.actorSpriteComps10092 then
				for iter_50_6, iter_50_7 in pairs(arg_47_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_50_7 then
						if arg_47_1.isInRecall_ then
							iter_50_7.color = arg_47_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_50_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_47_1.var_.actorSpriteComps10092 = nil
			end

			local var_50_26 = arg_47_1.actors_["10094"]
			local var_50_27 = 0

			if var_50_27 < arg_47_1.time_ and arg_47_1.time_ <= var_50_27 + arg_50_0 and not isNil(var_50_26) and arg_47_1.var_.actorSpriteComps10094 == nil then
				arg_47_1.var_.actorSpriteComps10094 = var_50_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_28 = 2

			if var_50_27 <= arg_47_1.time_ and arg_47_1.time_ < var_50_27 + var_50_28 and not isNil(var_50_26) then
				local var_50_29 = (arg_47_1.time_ - var_50_27) / var_50_28

				if arg_47_1.var_.actorSpriteComps10094 then
					for iter_50_8, iter_50_9 in pairs(arg_47_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_50_9 then
							if arg_47_1.isInRecall_ then
								local var_50_30 = Mathf.Lerp(iter_50_9.color.r, arg_47_1.hightColor1.r, var_50_29)
								local var_50_31 = Mathf.Lerp(iter_50_9.color.g, arg_47_1.hightColor1.g, var_50_29)
								local var_50_32 = Mathf.Lerp(iter_50_9.color.b, arg_47_1.hightColor1.b, var_50_29)

								iter_50_9.color = Color.New(var_50_30, var_50_31, var_50_32)
							else
								local var_50_33 = Mathf.Lerp(iter_50_9.color.r, 1, var_50_29)

								iter_50_9.color = Color.New(var_50_33, var_50_33, var_50_33)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= var_50_27 + var_50_28 and arg_47_1.time_ < var_50_27 + var_50_28 + arg_50_0 and not isNil(var_50_26) and arg_47_1.var_.actorSpriteComps10094 then
				for iter_50_10, iter_50_11 in pairs(arg_47_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_50_11 then
						if arg_47_1.isInRecall_ then
							iter_50_11.color = arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_50_11.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_47_1.var_.actorSpriteComps10094 = nil
			end

			local var_50_34 = 0
			local var_50_35 = 0.5

			if var_50_34 < arg_47_1.time_ and arg_47_1.time_ <= var_50_34 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_36 = arg_47_1:FormatText(StoryNameCfg[259].name)

				arg_47_1.leftNameTxt_.text = var_50_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_37 = arg_47_1:GetWordFromCfg(413081011)
				local var_50_38 = arg_47_1:FormatText(var_50_37.content)

				arg_47_1.text_.text = var_50_38

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_39 = 20
				local var_50_40 = utf8.len(var_50_38)
				local var_50_41 = var_50_39 <= 0 and var_50_35 or var_50_35 * (var_50_40 / var_50_39)

				if var_50_41 > 0 and var_50_35 < var_50_41 then
					arg_47_1.talkMaxDuration = var_50_41

					if var_50_41 + var_50_34 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_41 + var_50_34
					end
				end

				arg_47_1.text_.text = var_50_38
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081011", "story_v_out_413081.awb") ~= 0 then
					local var_50_42 = manager.audio:GetVoiceLength("story_v_out_413081", "413081011", "story_v_out_413081.awb") / 1000

					if var_50_42 + var_50_34 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_42 + var_50_34
					end

					if var_50_37.prefab_name ~= "" and arg_47_1.actors_[var_50_37.prefab_name] ~= nil then
						local var_50_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_37.prefab_name].transform, "story_v_out_413081", "413081011", "story_v_out_413081.awb")

						arg_47_1:RecordAudio("413081011", var_50_43)
						arg_47_1:RecordAudio("413081011", var_50_43)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_413081", "413081011", "story_v_out_413081.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_413081", "413081011", "story_v_out_413081.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_44 = math.max(var_50_35, arg_47_1.talkMaxDuration)

			if var_50_34 <= arg_47_1.time_ and arg_47_1.time_ < var_50_34 + var_50_44 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_34) / var_50_44

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_34 + var_50_44 and arg_47_1.time_ < var_50_34 + var_50_44 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play413081012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 413081012
		arg_51_1.duration_ = 2

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play413081013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["10093"].transform
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.var_.moveOldPos10093 = var_54_0.localPosition
				var_54_0.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("10093", 3)

				local var_54_2 = var_54_0.childCount

				for iter_54_0 = 0, var_54_2 - 1 do
					local var_54_3 = var_54_0:GetChild(iter_54_0)

					if var_54_3.name == "split_4" or not string.find(var_54_3.name, "split") then
						var_54_3.gameObject:SetActive(true)
					else
						var_54_3.gameObject:SetActive(false)
					end
				end
			end

			local var_54_4 = 0.001

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_4 then
				local var_54_5 = (arg_51_1.time_ - var_54_1) / var_54_4
				local var_54_6 = Vector3.New(0, -345, -245)

				var_54_0.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10093, var_54_6, var_54_5)
			end

			if arg_51_1.time_ >= var_54_1 + var_54_4 and arg_51_1.time_ < var_54_1 + var_54_4 + arg_54_0 then
				var_54_0.localPosition = Vector3.New(0, -345, -245)
			end

			local var_54_7 = arg_51_1.actors_["10094"].transform
			local var_54_8 = 0

			if var_54_8 < arg_51_1.time_ and arg_51_1.time_ <= var_54_8 + arg_54_0 then
				arg_51_1.var_.moveOldPos10094 = var_54_7.localPosition
				var_54_7.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("10094", 7)

				local var_54_9 = var_54_7.childCount

				for iter_54_1 = 0, var_54_9 - 1 do
					local var_54_10 = var_54_7:GetChild(iter_54_1)

					if var_54_10.name == "" or not string.find(var_54_10.name, "split") then
						var_54_10.gameObject:SetActive(true)
					else
						var_54_10.gameObject:SetActive(false)
					end
				end
			end

			local var_54_11 = 0.001

			if var_54_8 <= arg_51_1.time_ and arg_51_1.time_ < var_54_8 + var_54_11 then
				local var_54_12 = (arg_51_1.time_ - var_54_8) / var_54_11
				local var_54_13 = Vector3.New(0, -2000, 0)

				var_54_7.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10094, var_54_13, var_54_12)
			end

			if arg_51_1.time_ >= var_54_8 + var_54_11 and arg_51_1.time_ < var_54_8 + var_54_11 + arg_54_0 then
				var_54_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_54_14 = arg_51_1.actors_["10093"]
			local var_54_15 = 0

			if var_54_15 < arg_51_1.time_ and arg_51_1.time_ <= var_54_15 + arg_54_0 and not isNil(var_54_14) and arg_51_1.var_.actorSpriteComps10093 == nil then
				arg_51_1.var_.actorSpriteComps10093 = var_54_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_16 = 2

			if var_54_15 <= arg_51_1.time_ and arg_51_1.time_ < var_54_15 + var_54_16 and not isNil(var_54_14) then
				local var_54_17 = (arg_51_1.time_ - var_54_15) / var_54_16

				if arg_51_1.var_.actorSpriteComps10093 then
					for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_54_3 then
							if arg_51_1.isInRecall_ then
								local var_54_18 = Mathf.Lerp(iter_54_3.color.r, arg_51_1.hightColor1.r, var_54_17)
								local var_54_19 = Mathf.Lerp(iter_54_3.color.g, arg_51_1.hightColor1.g, var_54_17)
								local var_54_20 = Mathf.Lerp(iter_54_3.color.b, arg_51_1.hightColor1.b, var_54_17)

								iter_54_3.color = Color.New(var_54_18, var_54_19, var_54_20)
							else
								local var_54_21 = Mathf.Lerp(iter_54_3.color.r, 1, var_54_17)

								iter_54_3.color = Color.New(var_54_21, var_54_21, var_54_21)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= var_54_15 + var_54_16 and arg_51_1.time_ < var_54_15 + var_54_16 + arg_54_0 and not isNil(var_54_14) and arg_51_1.var_.actorSpriteComps10093 then
				for iter_54_4, iter_54_5 in pairs(arg_51_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_54_5 then
						if arg_51_1.isInRecall_ then
							iter_54_5.color = arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_54_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_51_1.var_.actorSpriteComps10093 = nil
			end

			local var_54_22 = arg_51_1.actors_["10094"]
			local var_54_23 = 0

			if var_54_23 < arg_51_1.time_ and arg_51_1.time_ <= var_54_23 + arg_54_0 and not isNil(var_54_22) and arg_51_1.var_.actorSpriteComps10094 == nil then
				arg_51_1.var_.actorSpriteComps10094 = var_54_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_24 = 2

			if var_54_23 <= arg_51_1.time_ and arg_51_1.time_ < var_54_23 + var_54_24 and not isNil(var_54_22) then
				local var_54_25 = (arg_51_1.time_ - var_54_23) / var_54_24

				if arg_51_1.var_.actorSpriteComps10094 then
					for iter_54_6, iter_54_7 in pairs(arg_51_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_54_7 then
							if arg_51_1.isInRecall_ then
								local var_54_26 = Mathf.Lerp(iter_54_7.color.r, arg_51_1.hightColor2.r, var_54_25)
								local var_54_27 = Mathf.Lerp(iter_54_7.color.g, arg_51_1.hightColor2.g, var_54_25)
								local var_54_28 = Mathf.Lerp(iter_54_7.color.b, arg_51_1.hightColor2.b, var_54_25)

								iter_54_7.color = Color.New(var_54_26, var_54_27, var_54_28)
							else
								local var_54_29 = Mathf.Lerp(iter_54_7.color.r, 0.5, var_54_25)

								iter_54_7.color = Color.New(var_54_29, var_54_29, var_54_29)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= var_54_23 + var_54_24 and arg_51_1.time_ < var_54_23 + var_54_24 + arg_54_0 and not isNil(var_54_22) and arg_51_1.var_.actorSpriteComps10094 then
				for iter_54_8, iter_54_9 in pairs(arg_51_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_54_9 then
						if arg_51_1.isInRecall_ then
							iter_54_9.color = arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_54_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_51_1.var_.actorSpriteComps10094 = nil
			end

			local var_54_30 = 0
			local var_54_31 = 0.1

			if var_54_30 < arg_51_1.time_ and arg_51_1.time_ <= var_54_30 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_32 = arg_51_1:FormatText(StoryNameCfg[28].name)

				arg_51_1.leftNameTxt_.text = var_54_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_33 = arg_51_1:GetWordFromCfg(413081012)
				local var_54_34 = arg_51_1:FormatText(var_54_33.content)

				arg_51_1.text_.text = var_54_34

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_35 = 4
				local var_54_36 = utf8.len(var_54_34)
				local var_54_37 = var_54_35 <= 0 and var_54_31 or var_54_31 * (var_54_36 / var_54_35)

				if var_54_37 > 0 and var_54_31 < var_54_37 then
					arg_51_1.talkMaxDuration = var_54_37

					if var_54_37 + var_54_30 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_37 + var_54_30
					end
				end

				arg_51_1.text_.text = var_54_34
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081012", "story_v_out_413081.awb") ~= 0 then
					local var_54_38 = manager.audio:GetVoiceLength("story_v_out_413081", "413081012", "story_v_out_413081.awb") / 1000

					if var_54_38 + var_54_30 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_38 + var_54_30
					end

					if var_54_33.prefab_name ~= "" and arg_51_1.actors_[var_54_33.prefab_name] ~= nil then
						local var_54_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_33.prefab_name].transform, "story_v_out_413081", "413081012", "story_v_out_413081.awb")

						arg_51_1:RecordAudio("413081012", var_54_39)
						arg_51_1:RecordAudio("413081012", var_54_39)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_413081", "413081012", "story_v_out_413081.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_413081", "413081012", "story_v_out_413081.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_40 = math.max(var_54_31, arg_51_1.talkMaxDuration)

			if var_54_30 <= arg_51_1.time_ and arg_51_1.time_ < var_54_30 + var_54_40 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_30) / var_54_40

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_30 + var_54_40 and arg_51_1.time_ < var_54_30 + var_54_40 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play413081013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 413081013
		arg_55_1.duration_ = 6.3

		local var_55_0 = {
			zh = 4.466,
			ja = 6.3
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play413081014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["10093"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos10093 = var_58_0.localPosition
				var_58_0.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("10093", 7)

				local var_58_2 = var_58_0.childCount

				for iter_58_0 = 0, var_58_2 - 1 do
					local var_58_3 = var_58_0:GetChild(iter_58_0)

					if var_58_3.name == "" or not string.find(var_58_3.name, "split") then
						var_58_3.gameObject:SetActive(true)
					else
						var_58_3.gameObject:SetActive(false)
					end
				end
			end

			local var_58_4 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_4 then
				local var_58_5 = (arg_55_1.time_ - var_58_1) / var_58_4
				local var_58_6 = Vector3.New(0, -2000, -180)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10093, var_58_6, var_58_5)
			end

			if arg_55_1.time_ >= var_58_1 + var_58_4 and arg_55_1.time_ < var_58_1 + var_58_4 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_58_7 = arg_55_1.actors_["10092"].transform
			local var_58_8 = 0

			if var_58_8 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 then
				arg_55_1.var_.moveOldPos10092 = var_58_7.localPosition
				var_58_7.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("10092", 3)

				local var_58_9 = var_58_7.childCount

				for iter_58_1 = 0, var_58_9 - 1 do
					local var_58_10 = var_58_7:GetChild(iter_58_1)

					if var_58_10.name == "split_8" or not string.find(var_58_10.name, "split") then
						var_58_10.gameObject:SetActive(true)
					else
						var_58_10.gameObject:SetActive(false)
					end
				end
			end

			local var_58_11 = 0.001

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_11 then
				local var_58_12 = (arg_55_1.time_ - var_58_8) / var_58_11
				local var_58_13 = Vector3.New(0, -300, -295)

				var_58_7.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10092, var_58_13, var_58_12)
			end

			if arg_55_1.time_ >= var_58_8 + var_58_11 and arg_55_1.time_ < var_58_8 + var_58_11 + arg_58_0 then
				var_58_7.localPosition = Vector3.New(0, -300, -295)
			end

			local var_58_14 = arg_55_1.actors_["10093"]
			local var_58_15 = 0

			if var_58_15 < arg_55_1.time_ and arg_55_1.time_ <= var_58_15 + arg_58_0 and not isNil(var_58_14) and arg_55_1.var_.actorSpriteComps10093 == nil then
				arg_55_1.var_.actorSpriteComps10093 = var_58_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_16 = 2

			if var_58_15 <= arg_55_1.time_ and arg_55_1.time_ < var_58_15 + var_58_16 and not isNil(var_58_14) then
				local var_58_17 = (arg_55_1.time_ - var_58_15) / var_58_16

				if arg_55_1.var_.actorSpriteComps10093 then
					for iter_58_2, iter_58_3 in pairs(arg_55_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_58_3 then
							if arg_55_1.isInRecall_ then
								local var_58_18 = Mathf.Lerp(iter_58_3.color.r, arg_55_1.hightColor2.r, var_58_17)
								local var_58_19 = Mathf.Lerp(iter_58_3.color.g, arg_55_1.hightColor2.g, var_58_17)
								local var_58_20 = Mathf.Lerp(iter_58_3.color.b, arg_55_1.hightColor2.b, var_58_17)

								iter_58_3.color = Color.New(var_58_18, var_58_19, var_58_20)
							else
								local var_58_21 = Mathf.Lerp(iter_58_3.color.r, 0.5, var_58_17)

								iter_58_3.color = Color.New(var_58_21, var_58_21, var_58_21)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= var_58_15 + var_58_16 and arg_55_1.time_ < var_58_15 + var_58_16 + arg_58_0 and not isNil(var_58_14) and arg_55_1.var_.actorSpriteComps10093 then
				for iter_58_4, iter_58_5 in pairs(arg_55_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_58_5 then
						if arg_55_1.isInRecall_ then
							iter_58_5.color = arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_58_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_55_1.var_.actorSpriteComps10093 = nil
			end

			local var_58_22 = arg_55_1.actors_["10092"]
			local var_58_23 = 0

			if var_58_23 < arg_55_1.time_ and arg_55_1.time_ <= var_58_23 + arg_58_0 and not isNil(var_58_22) and arg_55_1.var_.actorSpriteComps10092 == nil then
				arg_55_1.var_.actorSpriteComps10092 = var_58_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_24 = 2

			if var_58_23 <= arg_55_1.time_ and arg_55_1.time_ < var_58_23 + var_58_24 and not isNil(var_58_22) then
				local var_58_25 = (arg_55_1.time_ - var_58_23) / var_58_24

				if arg_55_1.var_.actorSpriteComps10092 then
					for iter_58_6, iter_58_7 in pairs(arg_55_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_58_7 then
							if arg_55_1.isInRecall_ then
								local var_58_26 = Mathf.Lerp(iter_58_7.color.r, arg_55_1.hightColor1.r, var_58_25)
								local var_58_27 = Mathf.Lerp(iter_58_7.color.g, arg_55_1.hightColor1.g, var_58_25)
								local var_58_28 = Mathf.Lerp(iter_58_7.color.b, arg_55_1.hightColor1.b, var_58_25)

								iter_58_7.color = Color.New(var_58_26, var_58_27, var_58_28)
							else
								local var_58_29 = Mathf.Lerp(iter_58_7.color.r, 1, var_58_25)

								iter_58_7.color = Color.New(var_58_29, var_58_29, var_58_29)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= var_58_23 + var_58_24 and arg_55_1.time_ < var_58_23 + var_58_24 + arg_58_0 and not isNil(var_58_22) and arg_55_1.var_.actorSpriteComps10092 then
				for iter_58_8, iter_58_9 in pairs(arg_55_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_58_9 then
						if arg_55_1.isInRecall_ then
							iter_58_9.color = arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_58_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_55_1.var_.actorSpriteComps10092 = nil
			end

			local var_58_30 = 0
			local var_58_31 = 0.675

			if var_58_30 < arg_55_1.time_ and arg_55_1.time_ <= var_58_30 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_32 = arg_55_1:FormatText(StoryNameCfg[996].name)

				arg_55_1.leftNameTxt_.text = var_58_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_33 = arg_55_1:GetWordFromCfg(413081013)
				local var_58_34 = arg_55_1:FormatText(var_58_33.content)

				arg_55_1.text_.text = var_58_34

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_35 = 27
				local var_58_36 = utf8.len(var_58_34)
				local var_58_37 = var_58_35 <= 0 and var_58_31 or var_58_31 * (var_58_36 / var_58_35)

				if var_58_37 > 0 and var_58_31 < var_58_37 then
					arg_55_1.talkMaxDuration = var_58_37

					if var_58_37 + var_58_30 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_37 + var_58_30
					end
				end

				arg_55_1.text_.text = var_58_34
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081013", "story_v_out_413081.awb") ~= 0 then
					local var_58_38 = manager.audio:GetVoiceLength("story_v_out_413081", "413081013", "story_v_out_413081.awb") / 1000

					if var_58_38 + var_58_30 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_38 + var_58_30
					end

					if var_58_33.prefab_name ~= "" and arg_55_1.actors_[var_58_33.prefab_name] ~= nil then
						local var_58_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_33.prefab_name].transform, "story_v_out_413081", "413081013", "story_v_out_413081.awb")

						arg_55_1:RecordAudio("413081013", var_58_39)
						arg_55_1:RecordAudio("413081013", var_58_39)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_413081", "413081013", "story_v_out_413081.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_413081", "413081013", "story_v_out_413081.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_40 = math.max(var_58_31, arg_55_1.talkMaxDuration)

			if var_58_30 <= arg_55_1.time_ and arg_55_1.time_ < var_58_30 + var_58_40 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_30) / var_58_40

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_30 + var_58_40 and arg_55_1.time_ < var_58_30 + var_58_40 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play413081014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 413081014
		arg_59_1.duration_ = 5.73

		local var_59_0 = {
			zh = 3.3,
			ja = 5.733
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play413081015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.45

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_2 = arg_59_1:FormatText(StoryNameCfg[996].name)

				arg_59_1.leftNameTxt_.text = var_62_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_3 = arg_59_1:GetWordFromCfg(413081014)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 18
				local var_62_6 = utf8.len(var_62_4)
				local var_62_7 = var_62_5 <= 0 and var_62_1 or var_62_1 * (var_62_6 / var_62_5)

				if var_62_7 > 0 and var_62_1 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_4
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081014", "story_v_out_413081.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081014", "story_v_out_413081.awb") / 1000

					if var_62_8 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_0
					end

					if var_62_3.prefab_name ~= "" and arg_59_1.actors_[var_62_3.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_3.prefab_name].transform, "story_v_out_413081", "413081014", "story_v_out_413081.awb")

						arg_59_1:RecordAudio("413081014", var_62_9)
						arg_59_1:RecordAudio("413081014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_413081", "413081014", "story_v_out_413081.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_413081", "413081014", "story_v_out_413081.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_10 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_10 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_10

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_10 and arg_59_1.time_ < var_62_0 + var_62_10 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play413081015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 413081015
		arg_63_1.duration_ = 4.27

		local var_63_0 = {
			zh = 1.999999999999,
			ja = 4.266
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
				arg_63_0:Play413081016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["10092"].transform
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1.var_.moveOldPos10092 = var_66_0.localPosition
				var_66_0.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("10092", 7)

				local var_66_2 = var_66_0.childCount

				for iter_66_0 = 0, var_66_2 - 1 do
					local var_66_3 = var_66_0:GetChild(iter_66_0)

					if var_66_3.name == "" or not string.find(var_66_3.name, "split") then
						var_66_3.gameObject:SetActive(true)
					else
						var_66_3.gameObject:SetActive(false)
					end
				end
			end

			local var_66_4 = 0.001

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_4 then
				local var_66_5 = (arg_63_1.time_ - var_66_1) / var_66_4
				local var_66_6 = Vector3.New(0, -2000, -180)

				var_66_0.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10092, var_66_6, var_66_5)
			end

			if arg_63_1.time_ >= var_66_1 + var_66_4 and arg_63_1.time_ < var_66_1 + var_66_4 + arg_66_0 then
				var_66_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_66_7 = arg_63_1.actors_["10094"].transform
			local var_66_8 = 0

			if var_66_8 < arg_63_1.time_ and arg_63_1.time_ <= var_66_8 + arg_66_0 then
				arg_63_1.var_.moveOldPos10094 = var_66_7.localPosition
				var_66_7.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("10094", 3)

				local var_66_9 = var_66_7.childCount

				for iter_66_1 = 0, var_66_9 - 1 do
					local var_66_10 = var_66_7:GetChild(iter_66_1)

					if var_66_10.name == "" or not string.find(var_66_10.name, "split") then
						var_66_10.gameObject:SetActive(true)
					else
						var_66_10.gameObject:SetActive(false)
					end
				end
			end

			local var_66_11 = 0.001

			if var_66_8 <= arg_63_1.time_ and arg_63_1.time_ < var_66_8 + var_66_11 then
				local var_66_12 = (arg_63_1.time_ - var_66_8) / var_66_11
				local var_66_13 = Vector3.New(0, -340, -414)

				var_66_7.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10094, var_66_13, var_66_12)
			end

			if arg_63_1.time_ >= var_66_8 + var_66_11 and arg_63_1.time_ < var_66_8 + var_66_11 + arg_66_0 then
				var_66_7.localPosition = Vector3.New(0, -340, -414)
			end

			local var_66_14 = arg_63_1.actors_["10092"]
			local var_66_15 = 0

			if var_66_15 < arg_63_1.time_ and arg_63_1.time_ <= var_66_15 + arg_66_0 and not isNil(var_66_14) and arg_63_1.var_.actorSpriteComps10092 == nil then
				arg_63_1.var_.actorSpriteComps10092 = var_66_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_16 = 2

			if var_66_15 <= arg_63_1.time_ and arg_63_1.time_ < var_66_15 + var_66_16 and not isNil(var_66_14) then
				local var_66_17 = (arg_63_1.time_ - var_66_15) / var_66_16

				if arg_63_1.var_.actorSpriteComps10092 then
					for iter_66_2, iter_66_3 in pairs(arg_63_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_66_3 then
							if arg_63_1.isInRecall_ then
								local var_66_18 = Mathf.Lerp(iter_66_3.color.r, arg_63_1.hightColor2.r, var_66_17)
								local var_66_19 = Mathf.Lerp(iter_66_3.color.g, arg_63_1.hightColor2.g, var_66_17)
								local var_66_20 = Mathf.Lerp(iter_66_3.color.b, arg_63_1.hightColor2.b, var_66_17)

								iter_66_3.color = Color.New(var_66_18, var_66_19, var_66_20)
							else
								local var_66_21 = Mathf.Lerp(iter_66_3.color.r, 0.5, var_66_17)

								iter_66_3.color = Color.New(var_66_21, var_66_21, var_66_21)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= var_66_15 + var_66_16 and arg_63_1.time_ < var_66_15 + var_66_16 + arg_66_0 and not isNil(var_66_14) and arg_63_1.var_.actorSpriteComps10092 then
				for iter_66_4, iter_66_5 in pairs(arg_63_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_66_5 then
						if arg_63_1.isInRecall_ then
							iter_66_5.color = arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_66_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_63_1.var_.actorSpriteComps10092 = nil
			end

			local var_66_22 = arg_63_1.actors_["10094"]
			local var_66_23 = 0

			if var_66_23 < arg_63_1.time_ and arg_63_1.time_ <= var_66_23 + arg_66_0 and not isNil(var_66_22) and arg_63_1.var_.actorSpriteComps10094 == nil then
				arg_63_1.var_.actorSpriteComps10094 = var_66_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_24 = 2

			if var_66_23 <= arg_63_1.time_ and arg_63_1.time_ < var_66_23 + var_66_24 and not isNil(var_66_22) then
				local var_66_25 = (arg_63_1.time_ - var_66_23) / var_66_24

				if arg_63_1.var_.actorSpriteComps10094 then
					for iter_66_6, iter_66_7 in pairs(arg_63_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_66_7 then
							if arg_63_1.isInRecall_ then
								local var_66_26 = Mathf.Lerp(iter_66_7.color.r, arg_63_1.hightColor1.r, var_66_25)
								local var_66_27 = Mathf.Lerp(iter_66_7.color.g, arg_63_1.hightColor1.g, var_66_25)
								local var_66_28 = Mathf.Lerp(iter_66_7.color.b, arg_63_1.hightColor1.b, var_66_25)

								iter_66_7.color = Color.New(var_66_26, var_66_27, var_66_28)
							else
								local var_66_29 = Mathf.Lerp(iter_66_7.color.r, 1, var_66_25)

								iter_66_7.color = Color.New(var_66_29, var_66_29, var_66_29)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= var_66_23 + var_66_24 and arg_63_1.time_ < var_66_23 + var_66_24 + arg_66_0 and not isNil(var_66_22) and arg_63_1.var_.actorSpriteComps10094 then
				for iter_66_8, iter_66_9 in pairs(arg_63_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_66_9 then
						if arg_63_1.isInRecall_ then
							iter_66_9.color = arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_66_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_63_1.var_.actorSpriteComps10094 = nil
			end

			local var_66_30 = 0
			local var_66_31 = 0.15

			if var_66_30 < arg_63_1.time_ and arg_63_1.time_ <= var_66_30 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_32 = arg_63_1:FormatText(StoryNameCfg[259].name)

				arg_63_1.leftNameTxt_.text = var_66_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_33 = arg_63_1:GetWordFromCfg(413081015)
				local var_66_34 = arg_63_1:FormatText(var_66_33.content)

				arg_63_1.text_.text = var_66_34

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_35 = 6
				local var_66_36 = utf8.len(var_66_34)
				local var_66_37 = var_66_35 <= 0 and var_66_31 or var_66_31 * (var_66_36 / var_66_35)

				if var_66_37 > 0 and var_66_31 < var_66_37 then
					arg_63_1.talkMaxDuration = var_66_37

					if var_66_37 + var_66_30 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_37 + var_66_30
					end
				end

				arg_63_1.text_.text = var_66_34
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081015", "story_v_out_413081.awb") ~= 0 then
					local var_66_38 = manager.audio:GetVoiceLength("story_v_out_413081", "413081015", "story_v_out_413081.awb") / 1000

					if var_66_38 + var_66_30 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_38 + var_66_30
					end

					if var_66_33.prefab_name ~= "" and arg_63_1.actors_[var_66_33.prefab_name] ~= nil then
						local var_66_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_33.prefab_name].transform, "story_v_out_413081", "413081015", "story_v_out_413081.awb")

						arg_63_1:RecordAudio("413081015", var_66_39)
						arg_63_1:RecordAudio("413081015", var_66_39)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_413081", "413081015", "story_v_out_413081.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_413081", "413081015", "story_v_out_413081.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_40 = math.max(var_66_31, arg_63_1.talkMaxDuration)

			if var_66_30 <= arg_63_1.time_ and arg_63_1.time_ < var_66_30 + var_66_40 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_30) / var_66_40

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_30 + var_66_40 and arg_63_1.time_ < var_66_30 + var_66_40 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play413081016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 413081016
		arg_67_1.duration_ = 2.37

		local var_67_0 = {
			zh = 1.999999999999,
			ja = 2.366
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
				arg_67_0:Play413081017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["10094"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos10094 = var_70_0.localPosition
				var_70_0.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("10094", 0)

				local var_70_2 = var_70_0.childCount

				for iter_70_0 = 0, var_70_2 - 1 do
					local var_70_3 = var_70_0:GetChild(iter_70_0)

					if var_70_3.name == "" or not string.find(var_70_3.name, "split") then
						var_70_3.gameObject:SetActive(true)
					else
						var_70_3.gameObject:SetActive(false)
					end
				end
			end

			local var_70_4 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_4 then
				local var_70_5 = (arg_67_1.time_ - var_70_1) / var_70_4
				local var_70_6 = Vector3.New(-5000, -340, -414)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos10094, var_70_6, var_70_5)
			end

			if arg_67_1.time_ >= var_70_1 + var_70_4 and arg_67_1.time_ < var_70_1 + var_70_4 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_70_7 = arg_67_1.actors_["10092"].transform
			local var_70_8 = 0

			if var_70_8 < arg_67_1.time_ and arg_67_1.time_ <= var_70_8 + arg_70_0 then
				arg_67_1.var_.moveOldPos10092 = var_70_7.localPosition
				var_70_7.localScale = Vector3.New(1, 1, 1)

				arg_67_1:CheckSpriteTmpPos("10092", 3)

				local var_70_9 = var_70_7.childCount

				for iter_70_1 = 0, var_70_9 - 1 do
					local var_70_10 = var_70_7:GetChild(iter_70_1)

					if var_70_10.name == "split_8" or not string.find(var_70_10.name, "split") then
						var_70_10.gameObject:SetActive(true)
					else
						var_70_10.gameObject:SetActive(false)
					end
				end
			end

			local var_70_11 = 0.001

			if var_70_8 <= arg_67_1.time_ and arg_67_1.time_ < var_70_8 + var_70_11 then
				local var_70_12 = (arg_67_1.time_ - var_70_8) / var_70_11
				local var_70_13 = Vector3.New(0, -300, -295)

				var_70_7.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos10092, var_70_13, var_70_12)
			end

			if arg_67_1.time_ >= var_70_8 + var_70_11 and arg_67_1.time_ < var_70_8 + var_70_11 + arg_70_0 then
				var_70_7.localPosition = Vector3.New(0, -300, -295)
			end

			local var_70_14 = arg_67_1.actors_["10094"]
			local var_70_15 = 0

			if var_70_15 < arg_67_1.time_ and arg_67_1.time_ <= var_70_15 + arg_70_0 and not isNil(var_70_14) and arg_67_1.var_.actorSpriteComps10094 == nil then
				arg_67_1.var_.actorSpriteComps10094 = var_70_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_16 = 2

			if var_70_15 <= arg_67_1.time_ and arg_67_1.time_ < var_70_15 + var_70_16 and not isNil(var_70_14) then
				local var_70_17 = (arg_67_1.time_ - var_70_15) / var_70_16

				if arg_67_1.var_.actorSpriteComps10094 then
					for iter_70_2, iter_70_3 in pairs(arg_67_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_70_3 then
							if arg_67_1.isInRecall_ then
								local var_70_18 = Mathf.Lerp(iter_70_3.color.r, arg_67_1.hightColor2.r, var_70_17)
								local var_70_19 = Mathf.Lerp(iter_70_3.color.g, arg_67_1.hightColor2.g, var_70_17)
								local var_70_20 = Mathf.Lerp(iter_70_3.color.b, arg_67_1.hightColor2.b, var_70_17)

								iter_70_3.color = Color.New(var_70_18, var_70_19, var_70_20)
							else
								local var_70_21 = Mathf.Lerp(iter_70_3.color.r, 0.5, var_70_17)

								iter_70_3.color = Color.New(var_70_21, var_70_21, var_70_21)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= var_70_15 + var_70_16 and arg_67_1.time_ < var_70_15 + var_70_16 + arg_70_0 and not isNil(var_70_14) and arg_67_1.var_.actorSpriteComps10094 then
				for iter_70_4, iter_70_5 in pairs(arg_67_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_70_5 then
						if arg_67_1.isInRecall_ then
							iter_70_5.color = arg_67_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_70_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_67_1.var_.actorSpriteComps10094 = nil
			end

			local var_70_22 = arg_67_1.actors_["10092"]
			local var_70_23 = 0

			if var_70_23 < arg_67_1.time_ and arg_67_1.time_ <= var_70_23 + arg_70_0 and not isNil(var_70_22) and arg_67_1.var_.actorSpriteComps10092 == nil then
				arg_67_1.var_.actorSpriteComps10092 = var_70_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_70_24 = 2

			if var_70_23 <= arg_67_1.time_ and arg_67_1.time_ < var_70_23 + var_70_24 and not isNil(var_70_22) then
				local var_70_25 = (arg_67_1.time_ - var_70_23) / var_70_24

				if arg_67_1.var_.actorSpriteComps10092 then
					for iter_70_6, iter_70_7 in pairs(arg_67_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_70_7 then
							if arg_67_1.isInRecall_ then
								local var_70_26 = Mathf.Lerp(iter_70_7.color.r, arg_67_1.hightColor1.r, var_70_25)
								local var_70_27 = Mathf.Lerp(iter_70_7.color.g, arg_67_1.hightColor1.g, var_70_25)
								local var_70_28 = Mathf.Lerp(iter_70_7.color.b, arg_67_1.hightColor1.b, var_70_25)

								iter_70_7.color = Color.New(var_70_26, var_70_27, var_70_28)
							else
								local var_70_29 = Mathf.Lerp(iter_70_7.color.r, 1, var_70_25)

								iter_70_7.color = Color.New(var_70_29, var_70_29, var_70_29)
							end
						end
					end
				end
			end

			if arg_67_1.time_ >= var_70_23 + var_70_24 and arg_67_1.time_ < var_70_23 + var_70_24 + arg_70_0 and not isNil(var_70_22) and arg_67_1.var_.actorSpriteComps10092 then
				for iter_70_8, iter_70_9 in pairs(arg_67_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_70_9 then
						if arg_67_1.isInRecall_ then
							iter_70_9.color = arg_67_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_70_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_67_1.var_.actorSpriteComps10092 = nil
			end

			local var_70_30 = 0
			local var_70_31 = 0.1

			if var_70_30 < arg_67_1.time_ and arg_67_1.time_ <= var_70_30 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_32 = arg_67_1:FormatText(StoryNameCfg[996].name)

				arg_67_1.leftNameTxt_.text = var_70_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_33 = arg_67_1:GetWordFromCfg(413081016)
				local var_70_34 = arg_67_1:FormatText(var_70_33.content)

				arg_67_1.text_.text = var_70_34

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_35 = 4
				local var_70_36 = utf8.len(var_70_34)
				local var_70_37 = var_70_35 <= 0 and var_70_31 or var_70_31 * (var_70_36 / var_70_35)

				if var_70_37 > 0 and var_70_31 < var_70_37 then
					arg_67_1.talkMaxDuration = var_70_37

					if var_70_37 + var_70_30 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_37 + var_70_30
					end
				end

				arg_67_1.text_.text = var_70_34
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081016", "story_v_out_413081.awb") ~= 0 then
					local var_70_38 = manager.audio:GetVoiceLength("story_v_out_413081", "413081016", "story_v_out_413081.awb") / 1000

					if var_70_38 + var_70_30 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_38 + var_70_30
					end

					if var_70_33.prefab_name ~= "" and arg_67_1.actors_[var_70_33.prefab_name] ~= nil then
						local var_70_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_33.prefab_name].transform, "story_v_out_413081", "413081016", "story_v_out_413081.awb")

						arg_67_1:RecordAudio("413081016", var_70_39)
						arg_67_1:RecordAudio("413081016", var_70_39)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_413081", "413081016", "story_v_out_413081.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_413081", "413081016", "story_v_out_413081.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_40 = math.max(var_70_31, arg_67_1.talkMaxDuration)

			if var_70_30 <= arg_67_1.time_ and arg_67_1.time_ < var_70_30 + var_70_40 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_30) / var_70_40

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_30 + var_70_40 and arg_67_1.time_ < var_70_30 + var_70_40 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play413081017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 413081017
		arg_71_1.duration_ = 9

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play413081018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 2

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				local var_74_1 = manager.ui.mainCamera.transform.localPosition
				local var_74_2 = Vector3.New(0, 0, 10) + Vector3.New(var_74_1.x, var_74_1.y, 0)
				local var_74_3 = arg_71_1.bgs_.F08m

				var_74_3.transform.localPosition = var_74_2
				var_74_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_74_4 = var_74_3:GetComponent("SpriteRenderer")

				if var_74_4 and var_74_4.sprite then
					local var_74_5 = (var_74_3.transform.localPosition - var_74_1).z
					local var_74_6 = manager.ui.mainCameraCom_
					local var_74_7 = 2 * var_74_5 * Mathf.Tan(var_74_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_74_8 = var_74_7 * var_74_6.aspect
					local var_74_9 = var_74_4.sprite.bounds.size.x
					local var_74_10 = var_74_4.sprite.bounds.size.y
					local var_74_11 = var_74_8 / var_74_9
					local var_74_12 = var_74_7 / var_74_10
					local var_74_13 = var_74_12 < var_74_11 and var_74_11 or var_74_12

					var_74_3.transform.localScale = Vector3.New(var_74_13, var_74_13, 0)
				end

				for iter_74_0, iter_74_1 in pairs(arg_71_1.bgs_) do
					if iter_74_0 ~= "F08m" then
						iter_74_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_74_14 = 4

			if var_74_14 < arg_71_1.time_ and arg_71_1.time_ <= var_74_14 + arg_74_0 then
				arg_71_1.allBtn_.enabled = false
			end

			local var_74_15 = 0.3

			if arg_71_1.time_ >= var_74_14 + var_74_15 and arg_71_1.time_ < var_74_14 + var_74_15 + arg_74_0 then
				arg_71_1.allBtn_.enabled = true
			end

			local var_74_16 = 0

			if var_74_16 < arg_71_1.time_ and arg_71_1.time_ <= var_74_16 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_17 = 2

			if var_74_16 <= arg_71_1.time_ and arg_71_1.time_ < var_74_16 + var_74_17 then
				local var_74_18 = (arg_71_1.time_ - var_74_16) / var_74_17
				local var_74_19 = Color.New(0, 0, 0)

				var_74_19.a = Mathf.Lerp(0, 1, var_74_18)
				arg_71_1.mask_.color = var_74_19
			end

			if arg_71_1.time_ >= var_74_16 + var_74_17 and arg_71_1.time_ < var_74_16 + var_74_17 + arg_74_0 then
				local var_74_20 = Color.New(0, 0, 0)

				var_74_20.a = 1
				arg_71_1.mask_.color = var_74_20
			end

			local var_74_21 = 2

			if var_74_21 < arg_71_1.time_ and arg_71_1.time_ <= var_74_21 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_22 = 2

			if var_74_21 <= arg_71_1.time_ and arg_71_1.time_ < var_74_21 + var_74_22 then
				local var_74_23 = (arg_71_1.time_ - var_74_21) / var_74_22
				local var_74_24 = Color.New(0, 0, 0)

				var_74_24.a = Mathf.Lerp(1, 0, var_74_23)
				arg_71_1.mask_.color = var_74_24
			end

			if arg_71_1.time_ >= var_74_21 + var_74_22 and arg_71_1.time_ < var_74_21 + var_74_22 + arg_74_0 then
				local var_74_25 = Color.New(0, 0, 0)
				local var_74_26 = 0

				arg_71_1.mask_.enabled = false
				var_74_25.a = var_74_26
				arg_71_1.mask_.color = var_74_25
			end

			local var_74_27 = arg_71_1.actors_["10092"].transform
			local var_74_28 = 1.966

			if var_74_28 < arg_71_1.time_ and arg_71_1.time_ <= var_74_28 + arg_74_0 then
				arg_71_1.var_.moveOldPos10092 = var_74_27.localPosition
				var_74_27.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("10092", 7)

				local var_74_29 = var_74_27.childCount

				for iter_74_2 = 0, var_74_29 - 1 do
					local var_74_30 = var_74_27:GetChild(iter_74_2)

					if var_74_30.name == "" or not string.find(var_74_30.name, "split") then
						var_74_30.gameObject:SetActive(true)
					else
						var_74_30.gameObject:SetActive(false)
					end
				end
			end

			local var_74_31 = 0.001

			if var_74_28 <= arg_71_1.time_ and arg_71_1.time_ < var_74_28 + var_74_31 then
				local var_74_32 = (arg_71_1.time_ - var_74_28) / var_74_31
				local var_74_33 = Vector3.New(0, -2000, -180)

				var_74_27.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10092, var_74_33, var_74_32)
			end

			if arg_71_1.time_ >= var_74_28 + var_74_31 and arg_71_1.time_ < var_74_28 + var_74_31 + arg_74_0 then
				var_74_27.localPosition = Vector3.New(0, -2000, -180)
			end

			if arg_71_1.frameCnt_ <= 1 then
				arg_71_1.dialog_:SetActive(false)
			end

			local var_74_34 = 4
			local var_74_35 = 1.625

			if var_74_34 < arg_71_1.time_ and arg_71_1.time_ <= var_74_34 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				arg_71_1.dialog_:SetActive(true)

				arg_71_1.dialogCg_.alpha = 0

				local var_74_36 = LeanTween.value(arg_71_1.dialog_, 0, 1, 0.3)

				var_74_36:setOnUpdate(LuaHelper.FloatAction(function(arg_75_0)
					arg_71_1.dialogCg_.alpha = arg_75_0
				end))
				var_74_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_71_1.dialog_)
					var_74_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_71_1.duration_ = arg_71_1.duration_ + 0.3

				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_37 = arg_71_1:GetWordFromCfg(413081017)
				local var_74_38 = arg_71_1:FormatText(var_74_37.content)

				arg_71_1.text_.text = var_74_38

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_39 = 65
				local var_74_40 = utf8.len(var_74_38)
				local var_74_41 = var_74_39 <= 0 and var_74_35 or var_74_35 * (var_74_40 / var_74_39)

				if var_74_41 > 0 and var_74_35 < var_74_41 then
					arg_71_1.talkMaxDuration = var_74_41
					var_74_34 = var_74_34 + 0.3

					if var_74_41 + var_74_34 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_41 + var_74_34
					end
				end

				arg_71_1.text_.text = var_74_38
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_42 = var_74_34 + 0.3
			local var_74_43 = math.max(var_74_35, arg_71_1.talkMaxDuration)

			if var_74_42 <= arg_71_1.time_ and arg_71_1.time_ < var_74_42 + var_74_43 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_42) / var_74_43

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_42 + var_74_43 and arg_71_1.time_ < var_74_42 + var_74_43 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play413081018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413081018
		arg_77_1.duration_ = 4.8

		local var_77_0 = {
			zh = 3.733,
			ja = 4.8
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
				arg_77_0:Play413081019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["10092"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos10092 = var_80_0.localPosition
				var_80_0.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10092", 3)

				local var_80_2 = var_80_0.childCount

				for iter_80_0 = 0, var_80_2 - 1 do
					local var_80_3 = var_80_0:GetChild(iter_80_0)

					if var_80_3.name == "split_8" or not string.find(var_80_3.name, "split") then
						var_80_3.gameObject:SetActive(true)
					else
						var_80_3.gameObject:SetActive(false)
					end
				end
			end

			local var_80_4 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_4 then
				local var_80_5 = (arg_77_1.time_ - var_80_1) / var_80_4
				local var_80_6 = Vector3.New(0, -300, -295)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10092, var_80_6, var_80_5)
			end

			if arg_77_1.time_ >= var_80_1 + var_80_4 and arg_77_1.time_ < var_80_1 + var_80_4 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_80_7 = arg_77_1.actors_["10092"]
			local var_80_8 = 0

			if var_80_8 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps10092 == nil then
				arg_77_1.var_.actorSpriteComps10092 = var_80_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_9 = 2

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_9 and not isNil(var_80_7) then
				local var_80_10 = (arg_77_1.time_ - var_80_8) / var_80_9

				if arg_77_1.var_.actorSpriteComps10092 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_77_1.time_ >= var_80_8 + var_80_9 and arg_77_1.time_ < var_80_8 + var_80_9 + arg_80_0 and not isNil(var_80_7) and arg_77_1.var_.actorSpriteComps10092 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_80_4 then
						if arg_77_1.isInRecall_ then
							iter_80_4.color = arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_80_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_77_1.var_.actorSpriteComps10092 = nil
			end

			local var_80_15 = 0
			local var_80_16 = 0.575

			if var_80_15 < arg_77_1.time_ and arg_77_1.time_ <= var_80_15 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_17 = arg_77_1:FormatText(StoryNameCfg[996].name)

				arg_77_1.leftNameTxt_.text = var_80_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_18 = arg_77_1:GetWordFromCfg(413081018)
				local var_80_19 = arg_77_1:FormatText(var_80_18.content)

				arg_77_1.text_.text = var_80_19

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_20 = 23
				local var_80_21 = utf8.len(var_80_19)
				local var_80_22 = var_80_20 <= 0 and var_80_16 or var_80_16 * (var_80_21 / var_80_20)

				if var_80_22 > 0 and var_80_16 < var_80_22 then
					arg_77_1.talkMaxDuration = var_80_22

					if var_80_22 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_22 + var_80_15
					end
				end

				arg_77_1.text_.text = var_80_19
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081018", "story_v_out_413081.awb") ~= 0 then
					local var_80_23 = manager.audio:GetVoiceLength("story_v_out_413081", "413081018", "story_v_out_413081.awb") / 1000

					if var_80_23 + var_80_15 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_23 + var_80_15
					end

					if var_80_18.prefab_name ~= "" and arg_77_1.actors_[var_80_18.prefab_name] ~= nil then
						local var_80_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_18.prefab_name].transform, "story_v_out_413081", "413081018", "story_v_out_413081.awb")

						arg_77_1:RecordAudio("413081018", var_80_24)
						arg_77_1:RecordAudio("413081018", var_80_24)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413081", "413081018", "story_v_out_413081.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413081", "413081018", "story_v_out_413081.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_25 = math.max(var_80_16, arg_77_1.talkMaxDuration)

			if var_80_15 <= arg_77_1.time_ and arg_77_1.time_ < var_80_15 + var_80_25 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_15) / var_80_25

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_15 + var_80_25 and arg_77_1.time_ < var_80_15 + var_80_25 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
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
	Play413081019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 413081019
		arg_81_1.duration_ = 5.13

		local var_81_0 = {
			zh = 3.333,
			ja = 5.133
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
				arg_81_0:Play413081020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.575

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[996].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_3 = arg_81_1:GetWordFromCfg(413081019)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 23
				local var_84_6 = utf8.len(var_84_4)
				local var_84_7 = var_84_5 <= 0 and var_84_1 or var_84_1 * (var_84_6 / var_84_5)

				if var_84_7 > 0 and var_84_1 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_4
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081019", "story_v_out_413081.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081019", "story_v_out_413081.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_413081", "413081019", "story_v_out_413081.awb")

						arg_81_1:RecordAudio("413081019", var_84_9)
						arg_81_1:RecordAudio("413081019", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_413081", "413081019", "story_v_out_413081.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_413081", "413081019", "story_v_out_413081.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_10 and arg_81_1.time_ < var_84_0 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play413081020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413081020
		arg_85_1.duration_ = 2

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play413081021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10092"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10092 == nil then
				arg_85_1.var_.actorSpriteComps10092 = var_88_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_2 = 2

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 and not isNil(var_88_0) then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2

				if arg_85_1.var_.actorSpriteComps10092 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								local var_88_4 = Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor2.r, var_88_3)
								local var_88_5 = Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor2.g, var_88_3)
								local var_88_6 = Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor2.b, var_88_3)

								iter_88_1.color = Color.New(var_88_4, var_88_5, var_88_6)
							else
								local var_88_7 = Mathf.Lerp(iter_88_1.color.r, 0.5, var_88_3)

								iter_88_1.color = Color.New(var_88_7, var_88_7, var_88_7)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.actorSpriteComps10092 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_88_3 then
						if arg_85_1.isInRecall_ then
							iter_88_3.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10092 = nil
			end

			local var_88_8 = 0
			local var_88_9 = 0.15

			if var_88_8 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_10 = arg_85_1:FormatText(StoryNameCfg[992].name)

				arg_85_1.leftNameTxt_.text = var_88_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_11 = arg_85_1:GetWordFromCfg(413081020)
				local var_88_12 = arg_85_1:FormatText(var_88_11.content)

				arg_85_1.text_.text = var_88_12

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 6
				local var_88_14 = utf8.len(var_88_12)
				local var_88_15 = var_88_13 <= 0 and var_88_9 or var_88_9 * (var_88_14 / var_88_13)

				if var_88_15 > 0 and var_88_9 < var_88_15 then
					arg_85_1.talkMaxDuration = var_88_15

					if var_88_15 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_15 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_12
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081020", "story_v_out_413081.awb") ~= 0 then
					local var_88_16 = manager.audio:GetVoiceLength("story_v_out_413081", "413081020", "story_v_out_413081.awb") / 1000

					if var_88_16 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_16 + var_88_8
					end

					if var_88_11.prefab_name ~= "" and arg_85_1.actors_[var_88_11.prefab_name] ~= nil then
						local var_88_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_11.prefab_name].transform, "story_v_out_413081", "413081020", "story_v_out_413081.awb")

						arg_85_1:RecordAudio("413081020", var_88_17)
						arg_85_1:RecordAudio("413081020", var_88_17)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413081", "413081020", "story_v_out_413081.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413081", "413081020", "story_v_out_413081.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_18 = math.max(var_88_9, arg_85_1.talkMaxDuration)

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_18 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_8) / var_88_18

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_8 + var_88_18 and arg_85_1.time_ < var_88_8 + var_88_18 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play413081021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413081021
		arg_89_1.duration_ = 2.6

		local var_89_0 = {
			zh = 1.999999999999,
			ja = 2.6
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
				arg_89_0:Play413081022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10092"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos10092 = var_92_0.localPosition
				var_92_0.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10092", 2)

				local var_92_2 = var_92_0.childCount

				for iter_92_0 = 0, var_92_2 - 1 do
					local var_92_3 = var_92_0:GetChild(iter_92_0)

					if var_92_3.name == "split_8" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_4 then
				local var_92_5 = (arg_89_1.time_ - var_92_1) / var_92_4
				local var_92_6 = Vector3.New(-389.49, -300, -295)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10092, var_92_6, var_92_5)
			end

			if arg_89_1.time_ >= var_92_1 + var_92_4 and arg_89_1.time_ < var_92_1 + var_92_4 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_92_7 = arg_89_1.actors_["10093"].transform
			local var_92_8 = 0

			if var_92_8 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.var_.moveOldPos10093 = var_92_7.localPosition
				var_92_7.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10093", 4)

				local var_92_9 = var_92_7.childCount

				for iter_92_1 = 0, var_92_9 - 1 do
					local var_92_10 = var_92_7:GetChild(iter_92_1)

					if var_92_10.name == "split_7" or not string.find(var_92_10.name, "split") then
						var_92_10.gameObject:SetActive(true)
					else
						var_92_10.gameObject:SetActive(false)
					end
				end
			end

			local var_92_11 = 0.001

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_11 then
				local var_92_12 = (arg_89_1.time_ - var_92_8) / var_92_11
				local var_92_13 = Vector3.New(390, -345, -245)

				var_92_7.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10093, var_92_13, var_92_12)
			end

			if arg_89_1.time_ >= var_92_8 + var_92_11 and arg_89_1.time_ < var_92_8 + var_92_11 + arg_92_0 then
				var_92_7.localPosition = Vector3.New(390, -345, -245)
			end

			local var_92_14 = arg_89_1.actors_["10092"]
			local var_92_15 = 0

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 and not isNil(var_92_14) and arg_89_1.var_.actorSpriteComps10092 == nil then
				arg_89_1.var_.actorSpriteComps10092 = var_92_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_16 = 2

			if var_92_15 <= arg_89_1.time_ and arg_89_1.time_ < var_92_15 + var_92_16 and not isNil(var_92_14) then
				local var_92_17 = (arg_89_1.time_ - var_92_15) / var_92_16

				if arg_89_1.var_.actorSpriteComps10092 then
					for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_92_3 then
							if arg_89_1.isInRecall_ then
								local var_92_18 = Mathf.Lerp(iter_92_3.color.r, arg_89_1.hightColor2.r, var_92_17)
								local var_92_19 = Mathf.Lerp(iter_92_3.color.g, arg_89_1.hightColor2.g, var_92_17)
								local var_92_20 = Mathf.Lerp(iter_92_3.color.b, arg_89_1.hightColor2.b, var_92_17)

								iter_92_3.color = Color.New(var_92_18, var_92_19, var_92_20)
							else
								local var_92_21 = Mathf.Lerp(iter_92_3.color.r, 0.5, var_92_17)

								iter_92_3.color = Color.New(var_92_21, var_92_21, var_92_21)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_15 + var_92_16 and arg_89_1.time_ < var_92_15 + var_92_16 + arg_92_0 and not isNil(var_92_14) and arg_89_1.var_.actorSpriteComps10092 then
				for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_92_5 then
						if arg_89_1.isInRecall_ then
							iter_92_5.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10092 = nil
			end

			local var_92_22 = arg_89_1.actors_["10093"]
			local var_92_23 = 0

			if var_92_23 < arg_89_1.time_ and arg_89_1.time_ <= var_92_23 + arg_92_0 and not isNil(var_92_22) and arg_89_1.var_.actorSpriteComps10093 == nil then
				arg_89_1.var_.actorSpriteComps10093 = var_92_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_24 = 2

			if var_92_23 <= arg_89_1.time_ and arg_89_1.time_ < var_92_23 + var_92_24 and not isNil(var_92_22) then
				local var_92_25 = (arg_89_1.time_ - var_92_23) / var_92_24

				if arg_89_1.var_.actorSpriteComps10093 then
					for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_92_7 then
							if arg_89_1.isInRecall_ then
								local var_92_26 = Mathf.Lerp(iter_92_7.color.r, arg_89_1.hightColor1.r, var_92_25)
								local var_92_27 = Mathf.Lerp(iter_92_7.color.g, arg_89_1.hightColor1.g, var_92_25)
								local var_92_28 = Mathf.Lerp(iter_92_7.color.b, arg_89_1.hightColor1.b, var_92_25)

								iter_92_7.color = Color.New(var_92_26, var_92_27, var_92_28)
							else
								local var_92_29 = Mathf.Lerp(iter_92_7.color.r, 1, var_92_25)

								iter_92_7.color = Color.New(var_92_29, var_92_29, var_92_29)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_23 + var_92_24 and arg_89_1.time_ < var_92_23 + var_92_24 + arg_92_0 and not isNil(var_92_22) and arg_89_1.var_.actorSpriteComps10093 then
				for iter_92_8, iter_92_9 in pairs(arg_89_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_92_9 then
						if arg_89_1.isInRecall_ then
							iter_92_9.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10093 = nil
			end

			local var_92_30 = 0
			local var_92_31 = 0.25

			if var_92_30 < arg_89_1.time_ and arg_89_1.time_ <= var_92_30 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_32 = arg_89_1:FormatText(StoryNameCfg[28].name)

				arg_89_1.leftNameTxt_.text = var_92_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_33 = arg_89_1:GetWordFromCfg(413081021)
				local var_92_34 = arg_89_1:FormatText(var_92_33.content)

				arg_89_1.text_.text = var_92_34

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_35 = 10
				local var_92_36 = utf8.len(var_92_34)
				local var_92_37 = var_92_35 <= 0 and var_92_31 or var_92_31 * (var_92_36 / var_92_35)

				if var_92_37 > 0 and var_92_31 < var_92_37 then
					arg_89_1.talkMaxDuration = var_92_37

					if var_92_37 + var_92_30 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_37 + var_92_30
					end
				end

				arg_89_1.text_.text = var_92_34
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081021", "story_v_out_413081.awb") ~= 0 then
					local var_92_38 = manager.audio:GetVoiceLength("story_v_out_413081", "413081021", "story_v_out_413081.awb") / 1000

					if var_92_38 + var_92_30 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_38 + var_92_30
					end

					if var_92_33.prefab_name ~= "" and arg_89_1.actors_[var_92_33.prefab_name] ~= nil then
						local var_92_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_33.prefab_name].transform, "story_v_out_413081", "413081021", "story_v_out_413081.awb")

						arg_89_1:RecordAudio("413081021", var_92_39)
						arg_89_1:RecordAudio("413081021", var_92_39)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_413081", "413081021", "story_v_out_413081.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_413081", "413081021", "story_v_out_413081.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_40 = math.max(var_92_31, arg_89_1.talkMaxDuration)

			if var_92_30 <= arg_89_1.time_ and arg_89_1.time_ < var_92_30 + var_92_40 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_30) / var_92_40

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_30 + var_92_40 and arg_89_1.time_ < var_92_30 + var_92_40 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
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
	Play413081022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413081022
		arg_93_1.duration_ = 4.83

		local var_93_0 = {
			zh = 4.833,
			ja = 3.8
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
				arg_93_0:Play413081023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10092"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos10092 = var_96_0.localPosition
				var_96_0.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10092", 2)

				local var_96_2 = var_96_0.childCount

				for iter_96_0 = 0, var_96_2 - 1 do
					local var_96_3 = var_96_0:GetChild(iter_96_0)

					if var_96_3.name == "split_8" or not string.find(var_96_3.name, "split") then
						var_96_3.gameObject:SetActive(true)
					else
						var_96_3.gameObject:SetActive(false)
					end
				end
			end

			local var_96_4 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_4 then
				local var_96_5 = (arg_93_1.time_ - var_96_1) / var_96_4
				local var_96_6 = Vector3.New(-389.49, -300, -295)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10092, var_96_6, var_96_5)
			end

			if arg_93_1.time_ >= var_96_1 + var_96_4 and arg_93_1.time_ < var_96_1 + var_96_4 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_96_7 = arg_93_1.actors_["10093"].transform
			local var_96_8 = 0

			if var_96_8 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.var_.moveOldPos10093 = var_96_7.localPosition
				var_96_7.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10093", 4)

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
				local var_96_13 = Vector3.New(390, -345, -245)

				var_96_7.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10093, var_96_13, var_96_12)
			end

			if arg_93_1.time_ >= var_96_8 + var_96_11 and arg_93_1.time_ < var_96_8 + var_96_11 + arg_96_0 then
				var_96_7.localPosition = Vector3.New(390, -345, -245)
			end

			local var_96_14 = arg_93_1.actors_["10092"]
			local var_96_15 = 0

			if var_96_15 < arg_93_1.time_ and arg_93_1.time_ <= var_96_15 + arg_96_0 and not isNil(var_96_14) and arg_93_1.var_.actorSpriteComps10092 == nil then
				arg_93_1.var_.actorSpriteComps10092 = var_96_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_16 = 2

			if var_96_15 <= arg_93_1.time_ and arg_93_1.time_ < var_96_15 + var_96_16 and not isNil(var_96_14) then
				local var_96_17 = (arg_93_1.time_ - var_96_15) / var_96_16

				if arg_93_1.var_.actorSpriteComps10092 then
					for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_96_3 then
							if arg_93_1.isInRecall_ then
								local var_96_18 = Mathf.Lerp(iter_96_3.color.r, arg_93_1.hightColor1.r, var_96_17)
								local var_96_19 = Mathf.Lerp(iter_96_3.color.g, arg_93_1.hightColor1.g, var_96_17)
								local var_96_20 = Mathf.Lerp(iter_96_3.color.b, arg_93_1.hightColor1.b, var_96_17)

								iter_96_3.color = Color.New(var_96_18, var_96_19, var_96_20)
							else
								local var_96_21 = Mathf.Lerp(iter_96_3.color.r, 1, var_96_17)

								iter_96_3.color = Color.New(var_96_21, var_96_21, var_96_21)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_15 + var_96_16 and arg_93_1.time_ < var_96_15 + var_96_16 + arg_96_0 and not isNil(var_96_14) and arg_93_1.var_.actorSpriteComps10092 then
				for iter_96_4, iter_96_5 in pairs(arg_93_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_96_5 then
						if arg_93_1.isInRecall_ then
							iter_96_5.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10092 = nil
			end

			local var_96_22 = arg_93_1.actors_["10093"]
			local var_96_23 = 0

			if var_96_23 < arg_93_1.time_ and arg_93_1.time_ <= var_96_23 + arg_96_0 and not isNil(var_96_22) and arg_93_1.var_.actorSpriteComps10093 == nil then
				arg_93_1.var_.actorSpriteComps10093 = var_96_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_24 = 2

			if var_96_23 <= arg_93_1.time_ and arg_93_1.time_ < var_96_23 + var_96_24 and not isNil(var_96_22) then
				local var_96_25 = (arg_93_1.time_ - var_96_23) / var_96_24

				if arg_93_1.var_.actorSpriteComps10093 then
					for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_93_1.time_ >= var_96_23 + var_96_24 and arg_93_1.time_ < var_96_23 + var_96_24 + arg_96_0 and not isNil(var_96_22) and arg_93_1.var_.actorSpriteComps10093 then
				for iter_96_8, iter_96_9 in pairs(arg_93_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_96_9 then
						if arg_93_1.isInRecall_ then
							iter_96_9.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10093 = nil
			end

			local var_96_30 = 0
			local var_96_31 = 0.65

			if var_96_30 < arg_93_1.time_ and arg_93_1.time_ <= var_96_30 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_32 = arg_93_1:FormatText(StoryNameCfg[996].name)

				arg_93_1.leftNameTxt_.text = var_96_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_33 = arg_93_1:GetWordFromCfg(413081022)
				local var_96_34 = arg_93_1:FormatText(var_96_33.content)

				arg_93_1.text_.text = var_96_34

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_35 = 26
				local var_96_36 = utf8.len(var_96_34)
				local var_96_37 = var_96_35 <= 0 and var_96_31 or var_96_31 * (var_96_36 / var_96_35)

				if var_96_37 > 0 and var_96_31 < var_96_37 then
					arg_93_1.talkMaxDuration = var_96_37

					if var_96_37 + var_96_30 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_37 + var_96_30
					end
				end

				arg_93_1.text_.text = var_96_34
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081022", "story_v_out_413081.awb") ~= 0 then
					local var_96_38 = manager.audio:GetVoiceLength("story_v_out_413081", "413081022", "story_v_out_413081.awb") / 1000

					if var_96_38 + var_96_30 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_38 + var_96_30
					end

					if var_96_33.prefab_name ~= "" and arg_93_1.actors_[var_96_33.prefab_name] ~= nil then
						local var_96_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_33.prefab_name].transform, "story_v_out_413081", "413081022", "story_v_out_413081.awb")

						arg_93_1:RecordAudio("413081022", var_96_39)
						arg_93_1:RecordAudio("413081022", var_96_39)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413081", "413081022", "story_v_out_413081.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413081", "413081022", "story_v_out_413081.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_40 = math.max(var_96_31, arg_93_1.talkMaxDuration)

			if var_96_30 <= arg_93_1.time_ and arg_93_1.time_ < var_96_30 + var_96_40 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_30) / var_96_40

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_30 + var_96_40 and arg_93_1.time_ < var_96_30 + var_96_40 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
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
	Play413081023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413081023
		arg_97_1.duration_ = 12.97

		local var_97_0 = {
			zh = 5.666,
			ja = 12.966
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
				arg_97_0:Play413081024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0
			local var_100_1 = 0.825

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_2 = arg_97_1:FormatText(StoryNameCfg[996].name)

				arg_97_1.leftNameTxt_.text = var_100_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:GetWordFromCfg(413081023)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 33
				local var_100_6 = utf8.len(var_100_4)
				local var_100_7 = var_100_5 <= 0 and var_100_1 or var_100_1 * (var_100_6 / var_100_5)

				if var_100_7 > 0 and var_100_1 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081023", "story_v_out_413081.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081023", "story_v_out_413081.awb") / 1000

					if var_100_8 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_0
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_413081", "413081023", "story_v_out_413081.awb")

						arg_97_1:RecordAudio("413081023", var_100_9)
						arg_97_1:RecordAudio("413081023", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_413081", "413081023", "story_v_out_413081.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_413081", "413081023", "story_v_out_413081.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_10 and arg_97_1.time_ < var_100_0 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play413081024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413081024
		arg_101_1.duration_ = 3.37

		local var_101_0 = {
			zh = 3.366,
			ja = 3.2
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
				arg_101_0:Play413081025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10093"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos10093 = var_104_0.localPosition
				var_104_0.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10093", 4)

				local var_104_2 = var_104_0.childCount

				for iter_104_0 = 0, var_104_2 - 1 do
					local var_104_3 = var_104_0:GetChild(iter_104_0)

					if var_104_3.name == "split_4" or not string.find(var_104_3.name, "split") then
						var_104_3.gameObject:SetActive(true)
					else
						var_104_3.gameObject:SetActive(false)
					end
				end
			end

			local var_104_4 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_4 then
				local var_104_5 = (arg_101_1.time_ - var_104_1) / var_104_4
				local var_104_6 = Vector3.New(390, -345, -245)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10093, var_104_6, var_104_5)
			end

			if arg_101_1.time_ >= var_104_1 + var_104_4 and arg_101_1.time_ < var_104_1 + var_104_4 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(390, -345, -245)
			end

			local var_104_7 = arg_101_1.actors_["10092"]
			local var_104_8 = 0

			if var_104_8 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.actorSpriteComps10092 == nil then
				arg_101_1.var_.actorSpriteComps10092 = var_104_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_9 = 2

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_9 and not isNil(var_104_7) then
				local var_104_10 = (arg_101_1.time_ - var_104_8) / var_104_9

				if arg_101_1.var_.actorSpriteComps10092 then
					for iter_104_1, iter_104_2 in pairs(arg_101_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_104_2 then
							if arg_101_1.isInRecall_ then
								local var_104_11 = Mathf.Lerp(iter_104_2.color.r, arg_101_1.hightColor2.r, var_104_10)
								local var_104_12 = Mathf.Lerp(iter_104_2.color.g, arg_101_1.hightColor2.g, var_104_10)
								local var_104_13 = Mathf.Lerp(iter_104_2.color.b, arg_101_1.hightColor2.b, var_104_10)

								iter_104_2.color = Color.New(var_104_11, var_104_12, var_104_13)
							else
								local var_104_14 = Mathf.Lerp(iter_104_2.color.r, 0.5, var_104_10)

								iter_104_2.color = Color.New(var_104_14, var_104_14, var_104_14)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_8 + var_104_9 and arg_101_1.time_ < var_104_8 + var_104_9 + arg_104_0 and not isNil(var_104_7) and arg_101_1.var_.actorSpriteComps10092 then
				for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_104_4 then
						if arg_101_1.isInRecall_ then
							iter_104_4.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10092 = nil
			end

			local var_104_15 = arg_101_1.actors_["10093"]
			local var_104_16 = 0

			if var_104_16 < arg_101_1.time_ and arg_101_1.time_ <= var_104_16 + arg_104_0 and not isNil(var_104_15) and arg_101_1.var_.actorSpriteComps10093 == nil then
				arg_101_1.var_.actorSpriteComps10093 = var_104_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_17 = 2

			if var_104_16 <= arg_101_1.time_ and arg_101_1.time_ < var_104_16 + var_104_17 and not isNil(var_104_15) then
				local var_104_18 = (arg_101_1.time_ - var_104_16) / var_104_17

				if arg_101_1.var_.actorSpriteComps10093 then
					for iter_104_5, iter_104_6 in pairs(arg_101_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_104_6 then
							if arg_101_1.isInRecall_ then
								local var_104_19 = Mathf.Lerp(iter_104_6.color.r, arg_101_1.hightColor1.r, var_104_18)
								local var_104_20 = Mathf.Lerp(iter_104_6.color.g, arg_101_1.hightColor1.g, var_104_18)
								local var_104_21 = Mathf.Lerp(iter_104_6.color.b, arg_101_1.hightColor1.b, var_104_18)

								iter_104_6.color = Color.New(var_104_19, var_104_20, var_104_21)
							else
								local var_104_22 = Mathf.Lerp(iter_104_6.color.r, 1, var_104_18)

								iter_104_6.color = Color.New(var_104_22, var_104_22, var_104_22)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_16 + var_104_17 and arg_101_1.time_ < var_104_16 + var_104_17 + arg_104_0 and not isNil(var_104_15) and arg_101_1.var_.actorSpriteComps10093 then
				for iter_104_7, iter_104_8 in pairs(arg_101_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_104_8 then
						if arg_101_1.isInRecall_ then
							iter_104_8.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10093 = nil
			end

			local var_104_23 = 0
			local var_104_24 = 0.475

			if var_104_23 < arg_101_1.time_ and arg_101_1.time_ <= var_104_23 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_25 = arg_101_1:FormatText(StoryNameCfg[28].name)

				arg_101_1.leftNameTxt_.text = var_104_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_26 = arg_101_1:GetWordFromCfg(413081024)
				local var_104_27 = arg_101_1:FormatText(var_104_26.content)

				arg_101_1.text_.text = var_104_27

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_28 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081024", "story_v_out_413081.awb") ~= 0 then
					local var_104_31 = manager.audio:GetVoiceLength("story_v_out_413081", "413081024", "story_v_out_413081.awb") / 1000

					if var_104_31 + var_104_23 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_31 + var_104_23
					end

					if var_104_26.prefab_name ~= "" and arg_101_1.actors_[var_104_26.prefab_name] ~= nil then
						local var_104_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_26.prefab_name].transform, "story_v_out_413081", "413081024", "story_v_out_413081.awb")

						arg_101_1:RecordAudio("413081024", var_104_32)
						arg_101_1:RecordAudio("413081024", var_104_32)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_413081", "413081024", "story_v_out_413081.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_413081", "413081024", "story_v_out_413081.awb")
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
				actorName = "10093",
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
	Play413081025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 413081025
		arg_105_1.duration_ = 2.93

		local var_105_0 = {
			zh = 2.833,
			ja = 2.933
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
				arg_105_0:Play413081026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10092"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps10092 == nil then
				arg_105_1.var_.actorSpriteComps10092 = var_108_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_2 = 2

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.actorSpriteComps10092 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								local var_108_4 = Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor1.r, var_108_3)
								local var_108_5 = Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor1.g, var_108_3)
								local var_108_6 = Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor1.b, var_108_3)

								iter_108_1.color = Color.New(var_108_4, var_108_5, var_108_6)
							else
								local var_108_7 = Mathf.Lerp(iter_108_1.color.r, 1, var_108_3)

								iter_108_1.color = Color.New(var_108_7, var_108_7, var_108_7)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.actorSpriteComps10092 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_108_3 then
						if arg_105_1.isInRecall_ then
							iter_108_3.color = arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_108_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10092 = nil
			end

			local var_108_8 = arg_105_1.actors_["10093"]
			local var_108_9 = 0

			if var_108_9 < arg_105_1.time_ and arg_105_1.time_ <= var_108_9 + arg_108_0 and not isNil(var_108_8) and arg_105_1.var_.actorSpriteComps10093 == nil then
				arg_105_1.var_.actorSpriteComps10093 = var_108_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_10 = 2

			if var_108_9 <= arg_105_1.time_ and arg_105_1.time_ < var_108_9 + var_108_10 and not isNil(var_108_8) then
				local var_108_11 = (arg_105_1.time_ - var_108_9) / var_108_10

				if arg_105_1.var_.actorSpriteComps10093 then
					for iter_108_4, iter_108_5 in pairs(arg_105_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_108_5 then
							if arg_105_1.isInRecall_ then
								local var_108_12 = Mathf.Lerp(iter_108_5.color.r, arg_105_1.hightColor2.r, var_108_11)
								local var_108_13 = Mathf.Lerp(iter_108_5.color.g, arg_105_1.hightColor2.g, var_108_11)
								local var_108_14 = Mathf.Lerp(iter_108_5.color.b, arg_105_1.hightColor2.b, var_108_11)

								iter_108_5.color = Color.New(var_108_12, var_108_13, var_108_14)
							else
								local var_108_15 = Mathf.Lerp(iter_108_5.color.r, 0.5, var_108_11)

								iter_108_5.color = Color.New(var_108_15, var_108_15, var_108_15)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_9 + var_108_10 and arg_105_1.time_ < var_108_9 + var_108_10 + arg_108_0 and not isNil(var_108_8) and arg_105_1.var_.actorSpriteComps10093 then
				for iter_108_6, iter_108_7 in pairs(arg_105_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_108_7 then
						if arg_105_1.isInRecall_ then
							iter_108_7.color = arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_108_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10093 = nil
			end

			local var_108_16 = arg_105_1.actors_["10092"].transform
			local var_108_17 = 0

			if var_108_17 < arg_105_1.time_ and arg_105_1.time_ <= var_108_17 + arg_108_0 then
				arg_105_1.var_.moveOldPos10092 = var_108_16.localPosition
				var_108_16.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10092", 2)

				local var_108_18 = var_108_16.childCount

				for iter_108_8 = 0, var_108_18 - 1 do
					local var_108_19 = var_108_16:GetChild(iter_108_8)

					if var_108_19.name == "split_1_1" or not string.find(var_108_19.name, "split") then
						var_108_19.gameObject:SetActive(true)
					else
						var_108_19.gameObject:SetActive(false)
					end
				end
			end

			local var_108_20 = 0.001

			if var_108_17 <= arg_105_1.time_ and arg_105_1.time_ < var_108_17 + var_108_20 then
				local var_108_21 = (arg_105_1.time_ - var_108_17) / var_108_20
				local var_108_22 = Vector3.New(-389.49, -300, -295)

				var_108_16.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10092, var_108_22, var_108_21)
			end

			if arg_105_1.time_ >= var_108_17 + var_108_20 and arg_105_1.time_ < var_108_17 + var_108_20 + arg_108_0 then
				var_108_16.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_108_23 = 0
			local var_108_24 = 0.325

			if var_108_23 < arg_105_1.time_ and arg_105_1.time_ <= var_108_23 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_25 = arg_105_1:FormatText(StoryNameCfg[996].name)

				arg_105_1.leftNameTxt_.text = var_108_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_26 = arg_105_1:GetWordFromCfg(413081025)
				local var_108_27 = arg_105_1:FormatText(var_108_26.content)

				arg_105_1.text_.text = var_108_27

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_28 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081025", "story_v_out_413081.awb") ~= 0 then
					local var_108_31 = manager.audio:GetVoiceLength("story_v_out_413081", "413081025", "story_v_out_413081.awb") / 1000

					if var_108_31 + var_108_23 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_31 + var_108_23
					end

					if var_108_26.prefab_name ~= "" and arg_105_1.actors_[var_108_26.prefab_name] ~= nil then
						local var_108_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_26.prefab_name].transform, "story_v_out_413081", "413081025", "story_v_out_413081.awb")

						arg_105_1:RecordAudio("413081025", var_108_32)
						arg_105_1:RecordAudio("413081025", var_108_32)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_413081", "413081025", "story_v_out_413081.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_413081", "413081025", "story_v_out_413081.awb")
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
				actorName = "10092",
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
	Play413081026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 413081026
		arg_109_1.duration_ = 7.97

		local var_109_0 = {
			zh = 4.1,
			ja = 7.966
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
				arg_109_0:Play413081027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0
			local var_112_1 = 0.65

			if var_112_0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_2 = arg_109_1:FormatText(StoryNameCfg[996].name)

				arg_109_1.leftNameTxt_.text = var_112_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:GetWordFromCfg(413081026)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 26
				local var_112_6 = utf8.len(var_112_4)
				local var_112_7 = var_112_5 <= 0 and var_112_1 or var_112_1 * (var_112_6 / var_112_5)

				if var_112_7 > 0 and var_112_1 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_0
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081026", "story_v_out_413081.awb") ~= 0 then
					local var_112_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081026", "story_v_out_413081.awb") / 1000

					if var_112_8 + var_112_0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_8 + var_112_0
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_413081", "413081026", "story_v_out_413081.awb")

						arg_109_1:RecordAudio("413081026", var_112_9)
						arg_109_1:RecordAudio("413081026", var_112_9)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_413081", "413081026", "story_v_out_413081.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_413081", "413081026", "story_v_out_413081.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_10 = math.max(var_112_1, arg_109_1.talkMaxDuration)

			if var_112_0 <= arg_109_1.time_ and arg_109_1.time_ < var_112_0 + var_112_10 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_0) / var_112_10

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_0 + var_112_10 and arg_109_1.time_ < var_112_0 + var_112_10 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play413081027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 413081027
		arg_113_1.duration_ = 5.1

		local var_113_0 = {
			zh = 1.5,
			ja = 5.1
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
				arg_113_0:Play413081028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 0.2

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[996].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_3 = arg_113_1:GetWordFromCfg(413081027)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 8
				local var_116_6 = utf8.len(var_116_4)
				local var_116_7 = var_116_5 <= 0 and var_116_1 or var_116_1 * (var_116_6 / var_116_5)

				if var_116_7 > 0 and var_116_1 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081027", "story_v_out_413081.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081027", "story_v_out_413081.awb") / 1000

					if var_116_8 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_0
					end

					if var_116_3.prefab_name ~= "" and arg_113_1.actors_[var_116_3.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_3.prefab_name].transform, "story_v_out_413081", "413081027", "story_v_out_413081.awb")

						arg_113_1:RecordAudio("413081027", var_116_9)
						arg_113_1:RecordAudio("413081027", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_413081", "413081027", "story_v_out_413081.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_413081", "413081027", "story_v_out_413081.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_10 and arg_113_1.time_ < var_116_0 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play413081028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 413081028
		arg_117_1.duration_ = 3.53

		local var_117_0 = {
			zh = 2.966,
			ja = 3.533
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
				arg_117_0:Play413081029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["10092"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps10092 == nil then
				arg_117_1.var_.actorSpriteComps10092 = var_120_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_2 = 2

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.actorSpriteComps10092 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								local var_120_4 = Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor2.r, var_120_3)
								local var_120_5 = Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor2.g, var_120_3)
								local var_120_6 = Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor2.b, var_120_3)

								iter_120_1.color = Color.New(var_120_4, var_120_5, var_120_6)
							else
								local var_120_7 = Mathf.Lerp(iter_120_1.color.r, 0.5, var_120_3)

								iter_120_1.color = Color.New(var_120_7, var_120_7, var_120_7)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.actorSpriteComps10092 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_120_3 then
						if arg_117_1.isInRecall_ then
							iter_120_3.color = arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_120_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10092 = nil
			end

			local var_120_8 = arg_117_1.actors_["10093"]
			local var_120_9 = 0

			if var_120_9 < arg_117_1.time_ and arg_117_1.time_ <= var_120_9 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.actorSpriteComps10093 == nil then
				arg_117_1.var_.actorSpriteComps10093 = var_120_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_10 = 2

			if var_120_9 <= arg_117_1.time_ and arg_117_1.time_ < var_120_9 + var_120_10 and not isNil(var_120_8) then
				local var_120_11 = (arg_117_1.time_ - var_120_9) / var_120_10

				if arg_117_1.var_.actorSpriteComps10093 then
					for iter_120_4, iter_120_5 in pairs(arg_117_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_120_5 then
							if arg_117_1.isInRecall_ then
								local var_120_12 = Mathf.Lerp(iter_120_5.color.r, arg_117_1.hightColor1.r, var_120_11)
								local var_120_13 = Mathf.Lerp(iter_120_5.color.g, arg_117_1.hightColor1.g, var_120_11)
								local var_120_14 = Mathf.Lerp(iter_120_5.color.b, arg_117_1.hightColor1.b, var_120_11)

								iter_120_5.color = Color.New(var_120_12, var_120_13, var_120_14)
							else
								local var_120_15 = Mathf.Lerp(iter_120_5.color.r, 1, var_120_11)

								iter_120_5.color = Color.New(var_120_15, var_120_15, var_120_15)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= var_120_9 + var_120_10 and arg_117_1.time_ < var_120_9 + var_120_10 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.actorSpriteComps10093 then
				for iter_120_6, iter_120_7 in pairs(arg_117_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_120_7 then
						if arg_117_1.isInRecall_ then
							iter_120_7.color = arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_120_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_117_1.var_.actorSpriteComps10093 = nil
			end

			local var_120_16 = 0
			local var_120_17 = 0.25

			if var_120_16 < arg_117_1.time_ and arg_117_1.time_ <= var_120_16 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_18 = arg_117_1:FormatText(StoryNameCfg[28].name)

				arg_117_1.leftNameTxt_.text = var_120_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_19 = arg_117_1:GetWordFromCfg(413081028)
				local var_120_20 = arg_117_1:FormatText(var_120_19.content)

				arg_117_1.text_.text = var_120_20

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_21 = 10
				local var_120_22 = utf8.len(var_120_20)
				local var_120_23 = var_120_21 <= 0 and var_120_17 or var_120_17 * (var_120_22 / var_120_21)

				if var_120_23 > 0 and var_120_17 < var_120_23 then
					arg_117_1.talkMaxDuration = var_120_23

					if var_120_23 + var_120_16 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_23 + var_120_16
					end
				end

				arg_117_1.text_.text = var_120_20
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081028", "story_v_out_413081.awb") ~= 0 then
					local var_120_24 = manager.audio:GetVoiceLength("story_v_out_413081", "413081028", "story_v_out_413081.awb") / 1000

					if var_120_24 + var_120_16 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_24 + var_120_16
					end

					if var_120_19.prefab_name ~= "" and arg_117_1.actors_[var_120_19.prefab_name] ~= nil then
						local var_120_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_19.prefab_name].transform, "story_v_out_413081", "413081028", "story_v_out_413081.awb")

						arg_117_1:RecordAudio("413081028", var_120_25)
						arg_117_1:RecordAudio("413081028", var_120_25)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_413081", "413081028", "story_v_out_413081.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_413081", "413081028", "story_v_out_413081.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_26 = math.max(var_120_17, arg_117_1.talkMaxDuration)

			if var_120_16 <= arg_117_1.time_ and arg_117_1.time_ < var_120_16 + var_120_26 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_16) / var_120_26

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_16 + var_120_26 and arg_117_1.time_ < var_120_16 + var_120_26 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play413081029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 413081029
		arg_121_1.duration_ = 6

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play413081030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10093"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps10093 == nil then
				arg_121_1.var_.actorSpriteComps10093 = var_124_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_2 = 2

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.actorSpriteComps10093 then
					for iter_124_0, iter_124_1 in pairs(arg_121_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_124_1 then
							if arg_121_1.isInRecall_ then
								local var_124_4 = Mathf.Lerp(iter_124_1.color.r, arg_121_1.hightColor2.r, var_124_3)
								local var_124_5 = Mathf.Lerp(iter_124_1.color.g, arg_121_1.hightColor2.g, var_124_3)
								local var_124_6 = Mathf.Lerp(iter_124_1.color.b, arg_121_1.hightColor2.b, var_124_3)

								iter_124_1.color = Color.New(var_124_4, var_124_5, var_124_6)
							else
								local var_124_7 = Mathf.Lerp(iter_124_1.color.r, 0.5, var_124_3)

								iter_124_1.color = Color.New(var_124_7, var_124_7, var_124_7)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.actorSpriteComps10093 then
				for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_124_3 then
						if arg_121_1.isInRecall_ then
							iter_124_3.color = arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_124_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps10093 = nil
			end

			local var_124_8 = arg_121_1.actors_["10092"]
			local var_124_9 = 0

			if var_124_9 < arg_121_1.time_ and arg_121_1.time_ <= var_124_9 + arg_124_0 then
				local var_124_10 = var_124_8:GetComponentInChildren(typeof(CanvasGroup))

				if var_124_10 then
					arg_121_1.var_.alphaOldValue10092 = var_124_10.alpha
					arg_121_1.var_.characterEffect10092 = var_124_10
				end

				arg_121_1.var_.alphaOldValue10092 = 1
			end

			local var_124_11 = 0.5

			if var_124_9 <= arg_121_1.time_ and arg_121_1.time_ < var_124_9 + var_124_11 then
				local var_124_12 = (arg_121_1.time_ - var_124_9) / var_124_11
				local var_124_13 = Mathf.Lerp(arg_121_1.var_.alphaOldValue10092, 0, var_124_12)

				if arg_121_1.var_.characterEffect10092 then
					arg_121_1.var_.characterEffect10092.alpha = var_124_13
				end
			end

			if arg_121_1.time_ >= var_124_9 + var_124_11 and arg_121_1.time_ < var_124_9 + var_124_11 + arg_124_0 and arg_121_1.var_.characterEffect10092 then
				arg_121_1.var_.characterEffect10092.alpha = 0
			end

			local var_124_14 = arg_121_1.actors_["10093"]
			local var_124_15 = 0

			if var_124_15 < arg_121_1.time_ and arg_121_1.time_ <= var_124_15 + arg_124_0 then
				local var_124_16 = var_124_14:GetComponentInChildren(typeof(CanvasGroup))

				if var_124_16 then
					arg_121_1.var_.alphaOldValue10093 = var_124_16.alpha
					arg_121_1.var_.characterEffect10093 = var_124_16
				end

				arg_121_1.var_.alphaOldValue10093 = 1
			end

			local var_124_17 = 0.5

			if var_124_15 <= arg_121_1.time_ and arg_121_1.time_ < var_124_15 + var_124_17 then
				local var_124_18 = (arg_121_1.time_ - var_124_15) / var_124_17
				local var_124_19 = Mathf.Lerp(arg_121_1.var_.alphaOldValue10093, 0, var_124_18)

				if arg_121_1.var_.characterEffect10093 then
					arg_121_1.var_.characterEffect10093.alpha = var_124_19
				end
			end

			if arg_121_1.time_ >= var_124_15 + var_124_17 and arg_121_1.time_ < var_124_15 + var_124_17 + arg_124_0 and arg_121_1.var_.characterEffect10093 then
				arg_121_1.var_.characterEffect10093.alpha = 0
			end

			local var_124_20 = 0.366666666666667
			local var_124_21 = 1

			if var_124_20 < arg_121_1.time_ and arg_121_1.time_ <= var_124_20 + arg_124_0 then
				local var_124_22 = "play"
				local var_124_23 = "effect"

				arg_121_1:AudioAction(var_124_22, var_124_23, "se_story_127", "se_story_127_hit", "")
			end

			local var_124_24 = 0.6666667
			local var_124_25 = 1

			if var_124_24 < arg_121_1.time_ and arg_121_1.time_ <= var_124_24 + arg_124_0 then
				local var_124_26 = "play"
				local var_124_27 = "effect"

				arg_121_1:AudioAction(var_124_26, var_124_27, "se_story_side_1070", "se_story_1070_hit02", "")
			end

			if arg_121_1.frameCnt_ <= 1 then
				arg_121_1.dialog_:SetActive(false)
			end

			local var_124_28 = 1
			local var_124_29 = 1.575

			if var_124_28 < arg_121_1.time_ and arg_121_1.time_ <= var_124_28 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_30 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_30:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_31 = arg_121_1:GetWordFromCfg(413081029)
				local var_124_32 = arg_121_1:FormatText(var_124_31.content)

				arg_121_1.text_.text = var_124_32

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_33 = 63
				local var_124_34 = utf8.len(var_124_32)
				local var_124_35 = var_124_33 <= 0 and var_124_29 or var_124_29 * (var_124_34 / var_124_33)

				if var_124_35 > 0 and var_124_29 < var_124_35 then
					arg_121_1.talkMaxDuration = var_124_35
					var_124_28 = var_124_28 + 0.3

					if var_124_35 + var_124_28 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_35 + var_124_28
					end
				end

				arg_121_1.text_.text = var_124_32
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_36 = var_124_28 + 0.3
			local var_124_37 = math.max(var_124_29, arg_121_1.talkMaxDuration)

			if var_124_36 <= arg_121_1.time_ and arg_121_1.time_ < var_124_36 + var_124_37 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_36) / var_124_37

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_36 + var_124_37 and arg_121_1.time_ < var_124_36 + var_124_37 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play413081030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 413081030
		arg_127_1.duration_ = 9.43

		local var_127_0 = {
			zh = 6.6,
			ja = 9.433
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play413081031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10092"].transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos10092 = var_130_0.localPosition
				var_130_0.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10092", 3)

				local var_130_2 = var_130_0.childCount

				for iter_130_0 = 0, var_130_2 - 1 do
					local var_130_3 = var_130_0:GetChild(iter_130_0)

					if var_130_3.name == "split_1_1" or not string.find(var_130_3.name, "split") then
						var_130_3.gameObject:SetActive(true)
					else
						var_130_3.gameObject:SetActive(false)
					end
				end
			end

			local var_130_4 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_4 then
				local var_130_5 = (arg_127_1.time_ - var_130_1) / var_130_4
				local var_130_6 = Vector3.New(0, -300, -295)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10092, var_130_6, var_130_5)
			end

			if arg_127_1.time_ >= var_130_1 + var_130_4 and arg_127_1.time_ < var_130_1 + var_130_4 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_130_7 = arg_127_1.actors_["10093"].transform
			local var_130_8 = 0

			if var_130_8 < arg_127_1.time_ and arg_127_1.time_ <= var_130_8 + arg_130_0 then
				arg_127_1.var_.moveOldPos10093 = var_130_7.localPosition
				var_130_7.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10093", 4)

				local var_130_9 = var_130_7.childCount

				for iter_130_1 = 0, var_130_9 - 1 do
					local var_130_10 = var_130_7:GetChild(iter_130_1)

					if var_130_10.name == "" or not string.find(var_130_10.name, "split") then
						var_130_10.gameObject:SetActive(true)
					else
						var_130_10.gameObject:SetActive(false)
					end
				end
			end

			local var_130_11 = 0.001

			if var_130_8 <= arg_127_1.time_ and arg_127_1.time_ < var_130_8 + var_130_11 then
				local var_130_12 = (arg_127_1.time_ - var_130_8) / var_130_11
				local var_130_13 = Vector3.New(390, -350, -180)

				var_130_7.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10093, var_130_13, var_130_12)
			end

			if arg_127_1.time_ >= var_130_8 + var_130_11 and arg_127_1.time_ < var_130_8 + var_130_11 + arg_130_0 then
				var_130_7.localPosition = Vector3.New(390, -350, -180)
			end

			local var_130_14 = arg_127_1.actors_["10092"]
			local var_130_15 = 0

			if var_130_15 < arg_127_1.time_ and arg_127_1.time_ <= var_130_15 + arg_130_0 and not isNil(var_130_14) and arg_127_1.var_.actorSpriteComps10092 == nil then
				arg_127_1.var_.actorSpriteComps10092 = var_130_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_16 = 2

			if var_130_15 <= arg_127_1.time_ and arg_127_1.time_ < var_130_15 + var_130_16 and not isNil(var_130_14) then
				local var_130_17 = (arg_127_1.time_ - var_130_15) / var_130_16

				if arg_127_1.var_.actorSpriteComps10092 then
					for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_130_3 then
							if arg_127_1.isInRecall_ then
								local var_130_18 = Mathf.Lerp(iter_130_3.color.r, arg_127_1.hightColor1.r, var_130_17)
								local var_130_19 = Mathf.Lerp(iter_130_3.color.g, arg_127_1.hightColor1.g, var_130_17)
								local var_130_20 = Mathf.Lerp(iter_130_3.color.b, arg_127_1.hightColor1.b, var_130_17)

								iter_130_3.color = Color.New(var_130_18, var_130_19, var_130_20)
							else
								local var_130_21 = Mathf.Lerp(iter_130_3.color.r, 1, var_130_17)

								iter_130_3.color = Color.New(var_130_21, var_130_21, var_130_21)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_15 + var_130_16 and arg_127_1.time_ < var_130_15 + var_130_16 + arg_130_0 and not isNil(var_130_14) and arg_127_1.var_.actorSpriteComps10092 then
				for iter_130_4, iter_130_5 in pairs(arg_127_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_130_5 then
						if arg_127_1.isInRecall_ then
							iter_130_5.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_130_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps10092 = nil
			end

			local var_130_22 = arg_127_1.actors_["10093"]
			local var_130_23 = 0

			if var_130_23 < arg_127_1.time_ and arg_127_1.time_ <= var_130_23 + arg_130_0 and not isNil(var_130_22) and arg_127_1.var_.actorSpriteComps10093 == nil then
				arg_127_1.var_.actorSpriteComps10093 = var_130_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_24 = 2

			if var_130_23 <= arg_127_1.time_ and arg_127_1.time_ < var_130_23 + var_130_24 and not isNil(var_130_22) then
				local var_130_25 = (arg_127_1.time_ - var_130_23) / var_130_24

				if arg_127_1.var_.actorSpriteComps10093 then
					for iter_130_6, iter_130_7 in pairs(arg_127_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_130_7 then
							if arg_127_1.isInRecall_ then
								local var_130_26 = Mathf.Lerp(iter_130_7.color.r, arg_127_1.hightColor2.r, var_130_25)
								local var_130_27 = Mathf.Lerp(iter_130_7.color.g, arg_127_1.hightColor2.g, var_130_25)
								local var_130_28 = Mathf.Lerp(iter_130_7.color.b, arg_127_1.hightColor2.b, var_130_25)

								iter_130_7.color = Color.New(var_130_26, var_130_27, var_130_28)
							else
								local var_130_29 = Mathf.Lerp(iter_130_7.color.r, 0.5, var_130_25)

								iter_130_7.color = Color.New(var_130_29, var_130_29, var_130_29)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_23 + var_130_24 and arg_127_1.time_ < var_130_23 + var_130_24 + arg_130_0 and not isNil(var_130_22) and arg_127_1.var_.actorSpriteComps10093 then
				for iter_130_8, iter_130_9 in pairs(arg_127_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_130_9 then
						if arg_127_1.isInRecall_ then
							iter_130_9.color = arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_130_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps10093 = nil
			end

			local var_130_30 = arg_127_1.actors_["10092"]
			local var_130_31 = 0

			if var_130_31 < arg_127_1.time_ and arg_127_1.time_ <= var_130_31 + arg_130_0 then
				local var_130_32 = var_130_30:GetComponentInChildren(typeof(CanvasGroup))

				if var_130_32 then
					arg_127_1.var_.alphaOldValue10092 = var_130_32.alpha
					arg_127_1.var_.characterEffect10092 = var_130_32
				end

				arg_127_1.var_.alphaOldValue10092 = 0
			end

			local var_130_33 = 0.5

			if var_130_31 <= arg_127_1.time_ and arg_127_1.time_ < var_130_31 + var_130_33 then
				local var_130_34 = (arg_127_1.time_ - var_130_31) / var_130_33
				local var_130_35 = Mathf.Lerp(arg_127_1.var_.alphaOldValue10092, 1, var_130_34)

				if arg_127_1.var_.characterEffect10092 then
					arg_127_1.var_.characterEffect10092.alpha = var_130_35
				end
			end

			if arg_127_1.time_ >= var_130_31 + var_130_33 and arg_127_1.time_ < var_130_31 + var_130_33 + arg_130_0 and arg_127_1.var_.characterEffect10092 then
				arg_127_1.var_.characterEffect10092.alpha = 1
			end

			local var_130_36 = 0
			local var_130_37 = 0.6

			if var_130_36 < arg_127_1.time_ and arg_127_1.time_ <= var_130_36 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_38 = arg_127_1:FormatText(StoryNameCfg[996].name)

				arg_127_1.leftNameTxt_.text = var_130_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_39 = arg_127_1:GetWordFromCfg(413081030)
				local var_130_40 = arg_127_1:FormatText(var_130_39.content)

				arg_127_1.text_.text = var_130_40

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_41 = 24
				local var_130_42 = utf8.len(var_130_40)
				local var_130_43 = var_130_41 <= 0 and var_130_37 or var_130_37 * (var_130_42 / var_130_41)

				if var_130_43 > 0 and var_130_37 < var_130_43 then
					arg_127_1.talkMaxDuration = var_130_43

					if var_130_43 + var_130_36 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_43 + var_130_36
					end
				end

				arg_127_1.text_.text = var_130_40
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081030", "story_v_out_413081.awb") ~= 0 then
					local var_130_44 = manager.audio:GetVoiceLength("story_v_out_413081", "413081030", "story_v_out_413081.awb") / 1000

					if var_130_44 + var_130_36 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_44 + var_130_36
					end

					if var_130_39.prefab_name ~= "" and arg_127_1.actors_[var_130_39.prefab_name] ~= nil then
						local var_130_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_39.prefab_name].transform, "story_v_out_413081", "413081030", "story_v_out_413081.awb")

						arg_127_1:RecordAudio("413081030", var_130_45)
						arg_127_1:RecordAudio("413081030", var_130_45)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_413081", "413081030", "story_v_out_413081.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_413081", "413081030", "story_v_out_413081.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_46 = math.max(var_130_37, arg_127_1.talkMaxDuration)

			if var_130_36 <= arg_127_1.time_ and arg_127_1.time_ < var_130_36 + var_130_46 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_36) / var_130_46

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_36 + var_130_46 and arg_127_1.time_ < var_130_36 + var_130_46 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play413081031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 413081031
		arg_131_1.duration_ = 5.1

		local var_131_0 = {
			zh = 4.333,
			ja = 5.1
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play413081032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.45

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[996].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_3 = arg_131_1:GetWordFromCfg(413081031)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081031", "story_v_out_413081.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081031", "story_v_out_413081.awb") / 1000

					if var_134_8 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_0
					end

					if var_134_3.prefab_name ~= "" and arg_131_1.actors_[var_134_3.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_3.prefab_name].transform, "story_v_out_413081", "413081031", "story_v_out_413081.awb")

						arg_131_1:RecordAudio("413081031", var_134_9)
						arg_131_1:RecordAudio("413081031", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_413081", "413081031", "story_v_out_413081.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_413081", "413081031", "story_v_out_413081.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_10 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_10 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_10

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_10 and arg_131_1.time_ < var_134_0 + var_134_10 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play413081032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 413081032
		arg_135_1.duration_ = 7.2

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play413081033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = "F08i"

			if arg_135_1.bgs_[var_138_0] == nil then
				local var_138_1 = Object.Instantiate(arg_135_1.paintGo_)

				var_138_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_138_0)
				var_138_1.name = var_138_0
				var_138_1.transform.parent = arg_135_1.stage_.transform
				var_138_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_135_1.bgs_[var_138_0] = var_138_1
			end

			local var_138_2 = 0.5

			if var_138_2 < arg_135_1.time_ and arg_135_1.time_ <= var_138_2 + arg_138_0 then
				local var_138_3 = manager.ui.mainCamera.transform.localPosition
				local var_138_4 = Vector3.New(0, 0, 10) + Vector3.New(var_138_3.x, var_138_3.y, 0)
				local var_138_5 = arg_135_1.bgs_.F08i

				var_138_5.transform.localPosition = var_138_4
				var_138_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_138_6 = var_138_5:GetComponent("SpriteRenderer")

				if var_138_6 and var_138_6.sprite then
					local var_138_7 = (var_138_5.transform.localPosition - var_138_3).z
					local var_138_8 = manager.ui.mainCameraCom_
					local var_138_9 = 2 * var_138_7 * Mathf.Tan(var_138_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_138_10 = var_138_9 * var_138_8.aspect
					local var_138_11 = var_138_6.sprite.bounds.size.x
					local var_138_12 = var_138_6.sprite.bounds.size.y
					local var_138_13 = var_138_10 / var_138_11
					local var_138_14 = var_138_9 / var_138_12
					local var_138_15 = var_138_14 < var_138_13 and var_138_13 or var_138_14

					var_138_5.transform.localScale = Vector3.New(var_138_15, var_138_15, 0)
				end

				for iter_138_0, iter_138_1 in pairs(arg_135_1.bgs_) do
					if iter_138_0 ~= "F08i" then
						iter_138_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_138_16 = 2.5

			if var_138_16 < arg_135_1.time_ and arg_135_1.time_ <= var_138_16 + arg_138_0 then
				arg_135_1.allBtn_.enabled = false
			end

			local var_138_17 = 0.3

			if arg_135_1.time_ >= var_138_16 + var_138_17 and arg_135_1.time_ < var_138_16 + var_138_17 + arg_138_0 then
				arg_135_1.allBtn_.enabled = true
			end

			local var_138_18 = 0

			if var_138_18 < arg_135_1.time_ and arg_135_1.time_ <= var_138_18 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_19 = 0.5

			if var_138_18 <= arg_135_1.time_ and arg_135_1.time_ < var_138_18 + var_138_19 then
				local var_138_20 = (arg_135_1.time_ - var_138_18) / var_138_19
				local var_138_21 = Color.New(1, 1, 1)

				var_138_21.a = Mathf.Lerp(0, 1, var_138_20)
				arg_135_1.mask_.color = var_138_21
			end

			if arg_135_1.time_ >= var_138_18 + var_138_19 and arg_135_1.time_ < var_138_18 + var_138_19 + arg_138_0 then
				local var_138_22 = Color.New(1, 1, 1)

				var_138_22.a = 1
				arg_135_1.mask_.color = var_138_22
			end

			local var_138_23 = 0.5

			if var_138_23 < arg_135_1.time_ and arg_135_1.time_ <= var_138_23 + arg_138_0 then
				arg_135_1.mask_.enabled = true
				arg_135_1.mask_.raycastTarget = true

				arg_135_1:SetGaussion(false)
			end

			local var_138_24 = 2

			if var_138_23 <= arg_135_1.time_ and arg_135_1.time_ < var_138_23 + var_138_24 then
				local var_138_25 = (arg_135_1.time_ - var_138_23) / var_138_24
				local var_138_26 = Color.New(1, 1, 1)

				var_138_26.a = Mathf.Lerp(1, 0, var_138_25)
				arg_135_1.mask_.color = var_138_26
			end

			if arg_135_1.time_ >= var_138_23 + var_138_24 and arg_135_1.time_ < var_138_23 + var_138_24 + arg_138_0 then
				local var_138_27 = Color.New(1, 1, 1)
				local var_138_28 = 0

				arg_135_1.mask_.enabled = false
				var_138_27.a = var_138_28
				arg_135_1.mask_.color = var_138_27
			end

			local var_138_29 = arg_135_1.actors_["10092"].transform
			local var_138_30 = 0.5

			if var_138_30 < arg_135_1.time_ and arg_135_1.time_ <= var_138_30 + arg_138_0 then
				arg_135_1.var_.moveOldPos10092 = var_138_29.localPosition
				var_138_29.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10092", 7)

				local var_138_31 = var_138_29.childCount

				for iter_138_2 = 0, var_138_31 - 1 do
					local var_138_32 = var_138_29:GetChild(iter_138_2)

					if var_138_32.name == "" or not string.find(var_138_32.name, "split") then
						var_138_32.gameObject:SetActive(true)
					else
						var_138_32.gameObject:SetActive(false)
					end
				end
			end

			local var_138_33 = 0.001

			if var_138_30 <= arg_135_1.time_ and arg_135_1.time_ < var_138_30 + var_138_33 then
				local var_138_34 = (arg_135_1.time_ - var_138_30) / var_138_33
				local var_138_35 = Vector3.New(0, -2000, -180)

				var_138_29.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10092, var_138_35, var_138_34)
			end

			if arg_135_1.time_ >= var_138_30 + var_138_33 and arg_135_1.time_ < var_138_30 + var_138_33 + arg_138_0 then
				var_138_29.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_138_36 = arg_135_1.actors_["10093"].transform
			local var_138_37 = 0.5

			if var_138_37 < arg_135_1.time_ and arg_135_1.time_ <= var_138_37 + arg_138_0 then
				arg_135_1.var_.moveOldPos10093 = var_138_36.localPosition
				var_138_36.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10093", 7)

				local var_138_38 = var_138_36.childCount

				for iter_138_3 = 0, var_138_38 - 1 do
					local var_138_39 = var_138_36:GetChild(iter_138_3)

					if var_138_39.name == "" or not string.find(var_138_39.name, "split") then
						var_138_39.gameObject:SetActive(true)
					else
						var_138_39.gameObject:SetActive(false)
					end
				end
			end

			local var_138_40 = 0.001

			if var_138_37 <= arg_135_1.time_ and arg_135_1.time_ < var_138_37 + var_138_40 then
				local var_138_41 = (arg_135_1.time_ - var_138_37) / var_138_40
				local var_138_42 = Vector3.New(0, -2000, -180)

				var_138_36.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10093, var_138_42, var_138_41)
			end

			if arg_135_1.time_ >= var_138_37 + var_138_40 and arg_135_1.time_ < var_138_37 + var_138_40 + arg_138_0 then
				var_138_36.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_138_43 = 0

			if var_138_43 < arg_135_1.time_ and arg_135_1.time_ <= var_138_43 + arg_138_0 then
				arg_135_1.allBtn_.enabled = false
			end

			local var_138_44 = 0.534

			if arg_135_1.time_ >= var_138_43 + var_138_44 and arg_135_1.time_ < var_138_43 + var_138_44 + arg_138_0 then
				arg_135_1.allBtn_.enabled = true
			end

			local var_138_45 = 0.1
			local var_138_46 = 2.7

			if var_138_45 < arg_135_1.time_ and arg_135_1.time_ <= var_138_45 + arg_138_0 then
				local var_138_47 = "play"
				local var_138_48 = "effect"

				arg_135_1:AudioAction(var_138_47, var_138_48, "se_story_121_00", "se_story_121_00_spear01", "")
			end

			local var_138_49 = 1.2
			local var_138_50 = 1

			if var_138_49 < arg_135_1.time_ and arg_135_1.time_ <= var_138_49 + arg_138_0 then
				local var_138_51 = "play"
				local var_138_52 = "effect"

				arg_135_1:AudioAction(var_138_51, var_138_52, "se_story_121_00", "se_story_121_00_spear02", "")
			end

			if arg_135_1.frameCnt_ <= 1 then
				arg_135_1.dialog_:SetActive(false)
			end

			local var_138_53 = 2.2
			local var_138_54 = 1.6

			if var_138_53 < arg_135_1.time_ and arg_135_1.time_ <= var_138_53 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				arg_135_1.dialog_:SetActive(true)

				arg_135_1.dialogCg_.alpha = 0

				local var_138_55 = LeanTween.value(arg_135_1.dialog_, 0, 1, 0.3)

				var_138_55:setOnUpdate(LuaHelper.FloatAction(function(arg_139_0)
					arg_135_1.dialogCg_.alpha = arg_139_0
				end))
				var_138_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_135_1.dialog_)
					var_138_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_135_1.duration_ = arg_135_1.duration_ + 0.3

				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_56 = arg_135_1:GetWordFromCfg(413081032)
				local var_138_57 = arg_135_1:FormatText(var_138_56.content)

				arg_135_1.text_.text = var_138_57

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_58 = 64
				local var_138_59 = utf8.len(var_138_57)
				local var_138_60 = var_138_58 <= 0 and var_138_54 or var_138_54 * (var_138_59 / var_138_58)

				if var_138_60 > 0 and var_138_54 < var_138_60 then
					arg_135_1.talkMaxDuration = var_138_60
					var_138_53 = var_138_53 + 0.3

					if var_138_60 + var_138_53 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_60 + var_138_53
					end
				end

				arg_135_1.text_.text = var_138_57
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_61 = var_138_53 + 0.3
			local var_138_62 = math.max(var_138_54, arg_135_1.talkMaxDuration)

			if var_138_61 <= arg_135_1.time_ and arg_135_1.time_ < var_138_61 + var_138_62 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_61) / var_138_62

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_61 + var_138_62 and arg_135_1.time_ < var_138_61 + var_138_62 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play413081033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 413081033
		arg_141_1.duration_ = 3.02

		local var_141_0 = {
			zh = 2.058,
			ja = 3.025
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
				arg_141_0:Play413081034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = "10022"

			if arg_141_1.actors_[var_144_0] == nil then
				local var_144_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_144_1) then
					local var_144_2 = Object.Instantiate(var_144_1, arg_141_1.canvasGo_.transform)

					var_144_2.transform:SetSiblingIndex(1)

					var_144_2.name = var_144_0
					var_144_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_141_1.actors_[var_144_0] = var_144_2

					local var_144_3 = var_144_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_141_1.isInRecall_ then
						for iter_144_0, iter_144_1 in ipairs(var_144_3) do
							iter_144_1.color = arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_144_4 = arg_141_1.actors_["10022"].transform
			local var_144_5 = 0

			if var_144_5 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.var_.moveOldPos10022 = var_144_4.localPosition
				var_144_4.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10022", 3)

				local var_144_6 = var_144_4.childCount

				for iter_144_2 = 0, var_144_6 - 1 do
					local var_144_7 = var_144_4:GetChild(iter_144_2)

					if var_144_7.name == "split_6" or not string.find(var_144_7.name, "split") then
						var_144_7.gameObject:SetActive(true)
					else
						var_144_7.gameObject:SetActive(false)
					end
				end
			end

			local var_144_8 = 0.001

			if var_144_5 <= arg_141_1.time_ and arg_141_1.time_ < var_144_5 + var_144_8 then
				local var_144_9 = (arg_141_1.time_ - var_144_5) / var_144_8
				local var_144_10 = Vector3.New(0, -315, -320)

				var_144_4.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10022, var_144_10, var_144_9)
			end

			if arg_141_1.time_ >= var_144_5 + var_144_8 and arg_141_1.time_ < var_144_5 + var_144_8 + arg_144_0 then
				var_144_4.localPosition = Vector3.New(0, -315, -320)
			end

			local var_144_11 = arg_141_1.actors_["10092"]
			local var_144_12 = 0

			if var_144_12 < arg_141_1.time_ and arg_141_1.time_ <= var_144_12 + arg_144_0 and not isNil(var_144_11) and arg_141_1.var_.actorSpriteComps10092 == nil then
				arg_141_1.var_.actorSpriteComps10092 = var_144_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_13 = 2

			if var_144_12 <= arg_141_1.time_ and arg_141_1.time_ < var_144_12 + var_144_13 and not isNil(var_144_11) then
				local var_144_14 = (arg_141_1.time_ - var_144_12) / var_144_13

				if arg_141_1.var_.actorSpriteComps10092 then
					for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_144_4 then
							if arg_141_1.isInRecall_ then
								local var_144_15 = Mathf.Lerp(iter_144_4.color.r, arg_141_1.hightColor1.r, var_144_14)
								local var_144_16 = Mathf.Lerp(iter_144_4.color.g, arg_141_1.hightColor1.g, var_144_14)
								local var_144_17 = Mathf.Lerp(iter_144_4.color.b, arg_141_1.hightColor1.b, var_144_14)

								iter_144_4.color = Color.New(var_144_15, var_144_16, var_144_17)
							else
								local var_144_18 = Mathf.Lerp(iter_144_4.color.r, 1, var_144_14)

								iter_144_4.color = Color.New(var_144_18, var_144_18, var_144_18)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= var_144_12 + var_144_13 and arg_141_1.time_ < var_144_12 + var_144_13 + arg_144_0 and not isNil(var_144_11) and arg_141_1.var_.actorSpriteComps10092 then
				for iter_144_5, iter_144_6 in pairs(arg_141_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_144_6 then
						if arg_141_1.isInRecall_ then
							iter_144_6.color = arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_144_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_141_1.var_.actorSpriteComps10092 = nil
			end

			local var_144_19 = arg_141_1.actors_["10022"]
			local var_144_20 = 0

			if var_144_20 < arg_141_1.time_ and arg_141_1.time_ <= var_144_20 + arg_144_0 then
				local var_144_21 = var_144_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_144_21 then
					arg_141_1.var_.alphaOldValue10022 = var_144_21.alpha
					arg_141_1.var_.characterEffect10022 = var_144_21
				end

				arg_141_1.var_.alphaOldValue10022 = 0
			end

			local var_144_22 = 0.5

			if var_144_20 <= arg_141_1.time_ and arg_141_1.time_ < var_144_20 + var_144_22 then
				local var_144_23 = (arg_141_1.time_ - var_144_20) / var_144_22
				local var_144_24 = Mathf.Lerp(arg_141_1.var_.alphaOldValue10022, 1, var_144_23)

				if arg_141_1.var_.characterEffect10022 then
					arg_141_1.var_.characterEffect10022.alpha = var_144_24
				end
			end

			if arg_141_1.time_ >= var_144_20 + var_144_22 and arg_141_1.time_ < var_144_20 + var_144_22 + arg_144_0 and arg_141_1.var_.characterEffect10022 then
				arg_141_1.var_.characterEffect10022.alpha = 1
			end

			if arg_141_1.frameCnt_ <= 1 then
				arg_141_1.dialog_:SetActive(false)
			end

			local var_144_25 = 0.225
			local var_144_26 = 0.275

			if var_144_25 < arg_141_1.time_ and arg_141_1.time_ <= var_144_25 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				arg_141_1.dialog_:SetActive(true)

				arg_141_1.dialogCg_.alpha = 0

				local var_144_27 = LeanTween.value(arg_141_1.dialog_, 0, 1, 0.3)

				var_144_27:setOnUpdate(LuaHelper.FloatAction(function(arg_145_0)
					arg_141_1.dialogCg_.alpha = arg_145_0
				end))
				var_144_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_141_1.dialog_)
					var_144_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_141_1.duration_ = arg_141_1.duration_ + 0.3

				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_28 = arg_141_1:FormatText(StoryNameCfg[614].name)

				arg_141_1.leftNameTxt_.text = var_144_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_29 = arg_141_1:GetWordFromCfg(413081033)
				local var_144_30 = arg_141_1:FormatText(var_144_29.content)

				arg_141_1.text_.text = var_144_30

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_31 = 11
				local var_144_32 = utf8.len(var_144_30)
				local var_144_33 = var_144_31 <= 0 and var_144_26 or var_144_26 * (var_144_32 / var_144_31)

				if var_144_33 > 0 and var_144_26 < var_144_33 then
					arg_141_1.talkMaxDuration = var_144_33
					var_144_25 = var_144_25 + 0.3

					if var_144_33 + var_144_25 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_33 + var_144_25
					end
				end

				arg_141_1.text_.text = var_144_30
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081033", "story_v_out_413081.awb") ~= 0 then
					local var_144_34 = manager.audio:GetVoiceLength("story_v_out_413081", "413081033", "story_v_out_413081.awb") / 1000

					if var_144_34 + var_144_25 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_34 + var_144_25
					end

					if var_144_29.prefab_name ~= "" and arg_141_1.actors_[var_144_29.prefab_name] ~= nil then
						local var_144_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_29.prefab_name].transform, "story_v_out_413081", "413081033", "story_v_out_413081.awb")

						arg_141_1:RecordAudio("413081033", var_144_35)
						arg_141_1:RecordAudio("413081033", var_144_35)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_413081", "413081033", "story_v_out_413081.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_413081", "413081033", "story_v_out_413081.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_36 = var_144_25 + 0.3
			local var_144_37 = math.max(var_144_26, arg_141_1.talkMaxDuration)

			if var_144_36 <= arg_141_1.time_ and arg_141_1.time_ < var_144_36 + var_144_37 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_36) / var_144_37

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_36 + var_144_37 and arg_141_1.time_ < var_144_36 + var_144_37 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413081034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 413081034
		arg_147_1.duration_ = 4.53

		local var_147_0 = {
			zh = 3,
			ja = 4.533
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
				arg_147_0:Play413081035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.45

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[614].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:GetWordFromCfg(413081034)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 18
				local var_150_6 = utf8.len(var_150_4)
				local var_150_7 = var_150_5 <= 0 and var_150_1 or var_150_1 * (var_150_6 / var_150_5)

				if var_150_7 > 0 and var_150_1 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081034", "story_v_out_413081.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081034", "story_v_out_413081.awb") / 1000

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_413081", "413081034", "story_v_out_413081.awb")

						arg_147_1:RecordAudio("413081034", var_150_9)
						arg_147_1:RecordAudio("413081034", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_413081", "413081034", "story_v_out_413081.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_413081", "413081034", "story_v_out_413081.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_10 and arg_147_1.time_ < var_150_0 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play413081035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 413081035
		arg_151_1.duration_ = 2.7

		local var_151_0 = {
			zh = 2.7,
			ja = 1.999999999999
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
				arg_151_0:Play413081036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10022"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps10022 == nil then
				arg_151_1.var_.actorSpriteComps10022 = var_154_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_2 = 2

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 and not isNil(var_154_0) then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.actorSpriteComps10022 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								local var_154_4 = Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor2.r, var_154_3)
								local var_154_5 = Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor2.g, var_154_3)
								local var_154_6 = Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor2.b, var_154_3)

								iter_154_1.color = Color.New(var_154_4, var_154_5, var_154_6)
							else
								local var_154_7 = Mathf.Lerp(iter_154_1.color.r, 0.5, var_154_3)

								iter_154_1.color = Color.New(var_154_7, var_154_7, var_154_7)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and not isNil(var_154_0) and arg_151_1.var_.actorSpriteComps10022 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_154_3 then
						if arg_151_1.isInRecall_ then
							iter_154_3.color = arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_154_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps10022 = nil
			end

			local var_154_8 = 0
			local var_154_9 = 0.275

			if var_154_8 < arg_151_1.time_ and arg_151_1.time_ <= var_154_8 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_10 = arg_151_1:FormatText(StoryNameCfg[993].name)

				arg_151_1.leftNameTxt_.text = var_154_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_11 = arg_151_1:GetWordFromCfg(413081035)
				local var_154_12 = arg_151_1:FormatText(var_154_11.content)

				arg_151_1.text_.text = var_154_12

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_13 = 11
				local var_154_14 = utf8.len(var_154_12)
				local var_154_15 = var_154_13 <= 0 and var_154_9 or var_154_9 * (var_154_14 / var_154_13)

				if var_154_15 > 0 and var_154_9 < var_154_15 then
					arg_151_1.talkMaxDuration = var_154_15

					if var_154_15 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_15 + var_154_8
					end
				end

				arg_151_1.text_.text = var_154_12
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081035", "story_v_out_413081.awb") ~= 0 then
					local var_154_16 = manager.audio:GetVoiceLength("story_v_out_413081", "413081035", "story_v_out_413081.awb") / 1000

					if var_154_16 + var_154_8 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_16 + var_154_8
					end

					if var_154_11.prefab_name ~= "" and arg_151_1.actors_[var_154_11.prefab_name] ~= nil then
						local var_154_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_11.prefab_name].transform, "story_v_out_413081", "413081035", "story_v_out_413081.awb")

						arg_151_1:RecordAudio("413081035", var_154_17)
						arg_151_1:RecordAudio("413081035", var_154_17)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_413081", "413081035", "story_v_out_413081.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_413081", "413081035", "story_v_out_413081.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_18 = math.max(var_154_9, arg_151_1.talkMaxDuration)

			if var_154_8 <= arg_151_1.time_ and arg_151_1.time_ < var_154_8 + var_154_18 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_8) / var_154_18

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_8 + var_154_18 and arg_151_1.time_ < var_154_8 + var_154_18 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play413081036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 413081036
		arg_155_1.duration_ = 3.7

		local var_155_0 = {
			zh = 2.333,
			ja = 3.7
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
				arg_155_0:Play413081037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10022"].transform
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 then
				arg_155_1.var_.moveOldPos10022 = var_158_0.localPosition
				var_158_0.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10022", 3)

				local var_158_2 = var_158_0.childCount

				for iter_158_0 = 0, var_158_2 - 1 do
					local var_158_3 = var_158_0:GetChild(iter_158_0)

					if var_158_3.name == "split_2" or not string.find(var_158_3.name, "split") then
						var_158_3.gameObject:SetActive(true)
					else
						var_158_3.gameObject:SetActive(false)
					end
				end
			end

			local var_158_4 = 0.001

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_4 then
				local var_158_5 = (arg_155_1.time_ - var_158_1) / var_158_4
				local var_158_6 = Vector3.New(0, -315, -320)

				var_158_0.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10022, var_158_6, var_158_5)
			end

			if arg_155_1.time_ >= var_158_1 + var_158_4 and arg_155_1.time_ < var_158_1 + var_158_4 + arg_158_0 then
				var_158_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_158_7 = arg_155_1.actors_["10022"]
			local var_158_8 = 0

			if var_158_8 < arg_155_1.time_ and arg_155_1.time_ <= var_158_8 + arg_158_0 and not isNil(var_158_7) and arg_155_1.var_.actorSpriteComps10022 == nil then
				arg_155_1.var_.actorSpriteComps10022 = var_158_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_9 = 2

			if var_158_8 <= arg_155_1.time_ and arg_155_1.time_ < var_158_8 + var_158_9 and not isNil(var_158_7) then
				local var_158_10 = (arg_155_1.time_ - var_158_8) / var_158_9

				if arg_155_1.var_.actorSpriteComps10022 then
					for iter_158_1, iter_158_2 in pairs(arg_155_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_158_2 then
							if arg_155_1.isInRecall_ then
								local var_158_11 = Mathf.Lerp(iter_158_2.color.r, arg_155_1.hightColor1.r, var_158_10)
								local var_158_12 = Mathf.Lerp(iter_158_2.color.g, arg_155_1.hightColor1.g, var_158_10)
								local var_158_13 = Mathf.Lerp(iter_158_2.color.b, arg_155_1.hightColor1.b, var_158_10)

								iter_158_2.color = Color.New(var_158_11, var_158_12, var_158_13)
							else
								local var_158_14 = Mathf.Lerp(iter_158_2.color.r, 1, var_158_10)

								iter_158_2.color = Color.New(var_158_14, var_158_14, var_158_14)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= var_158_8 + var_158_9 and arg_155_1.time_ < var_158_8 + var_158_9 + arg_158_0 and not isNil(var_158_7) and arg_155_1.var_.actorSpriteComps10022 then
				for iter_158_3, iter_158_4 in pairs(arg_155_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_158_4 then
						if arg_155_1.isInRecall_ then
							iter_158_4.color = arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_158_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_155_1.var_.actorSpriteComps10022 = nil
			end

			local var_158_15 = arg_155_1.actors_["10022"]
			local var_158_16 = 0

			if var_158_16 < arg_155_1.time_ and arg_155_1.time_ <= var_158_16 + arg_158_0 then
				local var_158_17 = var_158_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_158_17 then
					arg_155_1.var_.alphaOldValue10022 = var_158_17.alpha
					arg_155_1.var_.characterEffect10022 = var_158_17
				end

				arg_155_1.var_.alphaOldValue10022 = 0
			end

			local var_158_18 = 0.0166666666666667

			if var_158_16 <= arg_155_1.time_ and arg_155_1.time_ < var_158_16 + var_158_18 then
				local var_158_19 = (arg_155_1.time_ - var_158_16) / var_158_18
				local var_158_20 = Mathf.Lerp(arg_155_1.var_.alphaOldValue10022, 1, var_158_19)

				if arg_155_1.var_.characterEffect10022 then
					arg_155_1.var_.characterEffect10022.alpha = var_158_20
				end
			end

			if arg_155_1.time_ >= var_158_16 + var_158_18 and arg_155_1.time_ < var_158_16 + var_158_18 + arg_158_0 and arg_155_1.var_.characterEffect10022 then
				arg_155_1.var_.characterEffect10022.alpha = 1
			end

			local var_158_21 = 0
			local var_158_22 = 0.325

			if var_158_21 < arg_155_1.time_ and arg_155_1.time_ <= var_158_21 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_23 = arg_155_1:FormatText(StoryNameCfg[614].name)

				arg_155_1.leftNameTxt_.text = var_158_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_24 = arg_155_1:GetWordFromCfg(413081036)
				local var_158_25 = arg_155_1:FormatText(var_158_24.content)

				arg_155_1.text_.text = var_158_25

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_26 = 13
				local var_158_27 = utf8.len(var_158_25)
				local var_158_28 = var_158_26 <= 0 and var_158_22 or var_158_22 * (var_158_27 / var_158_26)

				if var_158_28 > 0 and var_158_22 < var_158_28 then
					arg_155_1.talkMaxDuration = var_158_28

					if var_158_28 + var_158_21 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_28 + var_158_21
					end
				end

				arg_155_1.text_.text = var_158_25
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081036", "story_v_out_413081.awb") ~= 0 then
					local var_158_29 = manager.audio:GetVoiceLength("story_v_out_413081", "413081036", "story_v_out_413081.awb") / 1000

					if var_158_29 + var_158_21 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_29 + var_158_21
					end

					if var_158_24.prefab_name ~= "" and arg_155_1.actors_[var_158_24.prefab_name] ~= nil then
						local var_158_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_24.prefab_name].transform, "story_v_out_413081", "413081036", "story_v_out_413081.awb")

						arg_155_1:RecordAudio("413081036", var_158_30)
						arg_155_1:RecordAudio("413081036", var_158_30)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_413081", "413081036", "story_v_out_413081.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_413081", "413081036", "story_v_out_413081.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_31 = math.max(var_158_22, arg_155_1.talkMaxDuration)

			if var_158_21 <= arg_155_1.time_ and arg_155_1.time_ < var_158_21 + var_158_31 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_21) / var_158_31

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_21 + var_158_31 and arg_155_1.time_ < var_158_21 + var_158_31 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play413081037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 413081037
		arg_159_1.duration_ = 6.57

		local var_159_0 = {
			zh = 6.566,
			ja = 4
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
				arg_159_0:Play413081038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10022"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos10022 = var_162_0.localPosition
				var_162_0.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10022", 7)

				local var_162_2 = var_162_0.childCount

				for iter_162_0 = 0, var_162_2 - 1 do
					local var_162_3 = var_162_0:GetChild(iter_162_0)

					if var_162_3.name == "" or not string.find(var_162_3.name, "split") then
						var_162_3.gameObject:SetActive(true)
					else
						var_162_3.gameObject:SetActive(false)
					end
				end
			end

			local var_162_4 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_4 then
				local var_162_5 = (arg_159_1.time_ - var_162_1) / var_162_4
				local var_162_6 = Vector3.New(0, -2000, 0)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10022, var_162_6, var_162_5)
			end

			if arg_159_1.time_ >= var_162_1 + var_162_4 and arg_159_1.time_ < var_162_1 + var_162_4 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_162_7 = 0
			local var_162_8 = 0.2

			if var_162_7 < arg_159_1.time_ and arg_159_1.time_ <= var_162_7 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_9 = arg_159_1:FormatText(StoryNameCfg[1005].name)

				arg_159_1.leftNameTxt_.text = var_162_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2123")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_10 = arg_159_1:GetWordFromCfg(413081037)
				local var_162_11 = arg_159_1:FormatText(var_162_10.content)

				arg_159_1.text_.text = var_162_11

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_12 = 8
				local var_162_13 = utf8.len(var_162_11)
				local var_162_14 = var_162_12 <= 0 and var_162_8 or var_162_8 * (var_162_13 / var_162_12)

				if var_162_14 > 0 and var_162_8 < var_162_14 then
					arg_159_1.talkMaxDuration = var_162_14

					if var_162_14 + var_162_7 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_14 + var_162_7
					end
				end

				arg_159_1.text_.text = var_162_11
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081037", "story_v_out_413081.awb") ~= 0 then
					local var_162_15 = manager.audio:GetVoiceLength("story_v_out_413081", "413081037", "story_v_out_413081.awb") / 1000

					if var_162_15 + var_162_7 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_15 + var_162_7
					end

					if var_162_10.prefab_name ~= "" and arg_159_1.actors_[var_162_10.prefab_name] ~= nil then
						local var_162_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_10.prefab_name].transform, "story_v_out_413081", "413081037", "story_v_out_413081.awb")

						arg_159_1:RecordAudio("413081037", var_162_16)
						arg_159_1:RecordAudio("413081037", var_162_16)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_413081", "413081037", "story_v_out_413081.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_413081", "413081037", "story_v_out_413081.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_17 = math.max(var_162_8, arg_159_1.talkMaxDuration)

			if var_162_7 <= arg_159_1.time_ and arg_159_1.time_ < var_162_7 + var_162_17 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_7) / var_162_17

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_7 + var_162_17 and arg_159_1.time_ < var_162_7 + var_162_17 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play413081038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 413081038
		arg_163_1.duration_ = 3.4

		local var_163_0 = {
			zh = 2.2,
			ja = 3.4
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
				arg_163_0:Play413081039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10022"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos10022 = var_166_0.localPosition
				var_166_0.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10022", 3)

				local var_166_2 = var_166_0.childCount

				for iter_166_0 = 0, var_166_2 - 1 do
					local var_166_3 = var_166_0:GetChild(iter_166_0)

					if var_166_3.name == "split_8" or not string.find(var_166_3.name, "split") then
						var_166_3.gameObject:SetActive(true)
					else
						var_166_3.gameObject:SetActive(false)
					end
				end
			end

			local var_166_4 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_4 then
				local var_166_5 = (arg_163_1.time_ - var_166_1) / var_166_4
				local var_166_6 = Vector3.New(0, -315, -320)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10022, var_166_6, var_166_5)
			end

			if arg_163_1.time_ >= var_166_1 + var_166_4 and arg_163_1.time_ < var_166_1 + var_166_4 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_166_7 = arg_163_1.actors_["10092"]
			local var_166_8 = 0

			if var_166_8 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 and not isNil(var_166_7) and arg_163_1.var_.actorSpriteComps10092 == nil then
				arg_163_1.var_.actorSpriteComps10092 = var_166_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_9 = 2

			if var_166_8 <= arg_163_1.time_ and arg_163_1.time_ < var_166_8 + var_166_9 and not isNil(var_166_7) then
				local var_166_10 = (arg_163_1.time_ - var_166_8) / var_166_9

				if arg_163_1.var_.actorSpriteComps10092 then
					for iter_166_1, iter_166_2 in pairs(arg_163_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_166_2 then
							if arg_163_1.isInRecall_ then
								local var_166_11 = Mathf.Lerp(iter_166_2.color.r, arg_163_1.hightColor1.r, var_166_10)
								local var_166_12 = Mathf.Lerp(iter_166_2.color.g, arg_163_1.hightColor1.g, var_166_10)
								local var_166_13 = Mathf.Lerp(iter_166_2.color.b, arg_163_1.hightColor1.b, var_166_10)

								iter_166_2.color = Color.New(var_166_11, var_166_12, var_166_13)
							else
								local var_166_14 = Mathf.Lerp(iter_166_2.color.r, 1, var_166_10)

								iter_166_2.color = Color.New(var_166_14, var_166_14, var_166_14)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= var_166_8 + var_166_9 and arg_163_1.time_ < var_166_8 + var_166_9 + arg_166_0 and not isNil(var_166_7) and arg_163_1.var_.actorSpriteComps10092 then
				for iter_166_3, iter_166_4 in pairs(arg_163_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_166_4 then
						if arg_163_1.isInRecall_ then
							iter_166_4.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_166_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_163_1.var_.actorSpriteComps10092 = nil
			end

			local var_166_15 = 0
			local var_166_16 = 0.3

			if var_166_15 < arg_163_1.time_ and arg_163_1.time_ <= var_166_15 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_17 = arg_163_1:FormatText(StoryNameCfg[614].name)

				arg_163_1.leftNameTxt_.text = var_166_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_18 = arg_163_1:GetWordFromCfg(413081038)
				local var_166_19 = arg_163_1:FormatText(var_166_18.content)

				arg_163_1.text_.text = var_166_19

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_20 = 12
				local var_166_21 = utf8.len(var_166_19)
				local var_166_22 = var_166_20 <= 0 and var_166_16 or var_166_16 * (var_166_21 / var_166_20)

				if var_166_22 > 0 and var_166_16 < var_166_22 then
					arg_163_1.talkMaxDuration = var_166_22

					if var_166_22 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_22 + var_166_15
					end
				end

				arg_163_1.text_.text = var_166_19
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081038", "story_v_out_413081.awb") ~= 0 then
					local var_166_23 = manager.audio:GetVoiceLength("story_v_out_413081", "413081038", "story_v_out_413081.awb") / 1000

					if var_166_23 + var_166_15 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_23 + var_166_15
					end

					if var_166_18.prefab_name ~= "" and arg_163_1.actors_[var_166_18.prefab_name] ~= nil then
						local var_166_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_18.prefab_name].transform, "story_v_out_413081", "413081038", "story_v_out_413081.awb")

						arg_163_1:RecordAudio("413081038", var_166_24)
						arg_163_1:RecordAudio("413081038", var_166_24)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_413081", "413081038", "story_v_out_413081.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_413081", "413081038", "story_v_out_413081.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_25 = math.max(var_166_16, arg_163_1.talkMaxDuration)

			if var_166_15 <= arg_163_1.time_ and arg_163_1.time_ < var_166_15 + var_166_25 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_15) / var_166_25

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_15 + var_166_25 and arg_163_1.time_ < var_166_15 + var_166_25 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play413081039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 413081039
		arg_167_1.duration_ = 3.23

		local var_167_0 = {
			zh = 3.1,
			ja = 3.233
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
				arg_167_0:Play413081040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10092"].transform
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 then
				arg_167_1.var_.moveOldPos10092 = var_170_0.localPosition
				var_170_0.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10092", 0)

				local var_170_2 = var_170_0.childCount

				for iter_170_0 = 0, var_170_2 - 1 do
					local var_170_3 = var_170_0:GetChild(iter_170_0)

					if var_170_3.name == "" or not string.find(var_170_3.name, "split") then
						var_170_3.gameObject:SetActive(true)
					else
						var_170_3.gameObject:SetActive(false)
					end
				end
			end

			local var_170_4 = 0.001

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_4 then
				local var_170_5 = (arg_167_1.time_ - var_170_1) / var_170_4
				local var_170_6 = Vector3.New(-1500, -350, -180)

				var_170_0.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10092, var_170_6, var_170_5)
			end

			if arg_167_1.time_ >= var_170_1 + var_170_4 and arg_167_1.time_ < var_170_1 + var_170_4 + arg_170_0 then
				var_170_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_170_7 = arg_167_1.actors_["10094"].transform
			local var_170_8 = 0

			if var_170_8 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 then
				arg_167_1.var_.moveOldPos10094 = var_170_7.localPosition
				var_170_7.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10094", 3)

				local var_170_9 = var_170_7.childCount

				for iter_170_1 = 0, var_170_9 - 1 do
					local var_170_10 = var_170_7:GetChild(iter_170_1)

					if var_170_10.name == "" or not string.find(var_170_10.name, "split") then
						var_170_10.gameObject:SetActive(true)
					else
						var_170_10.gameObject:SetActive(false)
					end
				end
			end

			local var_170_11 = 0.001

			if var_170_8 <= arg_167_1.time_ and arg_167_1.time_ < var_170_8 + var_170_11 then
				local var_170_12 = (arg_167_1.time_ - var_170_8) / var_170_11
				local var_170_13 = Vector3.New(0, -340, -414)

				var_170_7.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10094, var_170_13, var_170_12)
			end

			if arg_167_1.time_ >= var_170_8 + var_170_11 and arg_167_1.time_ < var_170_8 + var_170_11 + arg_170_0 then
				var_170_7.localPosition = Vector3.New(0, -340, -414)
			end

			local var_170_14 = arg_167_1.actors_["10092"]
			local var_170_15 = 0

			if var_170_15 < arg_167_1.time_ and arg_167_1.time_ <= var_170_15 + arg_170_0 and not isNil(var_170_14) and arg_167_1.var_.actorSpriteComps10092 == nil then
				arg_167_1.var_.actorSpriteComps10092 = var_170_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_16 = 2

			if var_170_15 <= arg_167_1.time_ and arg_167_1.time_ < var_170_15 + var_170_16 and not isNil(var_170_14) then
				local var_170_17 = (arg_167_1.time_ - var_170_15) / var_170_16

				if arg_167_1.var_.actorSpriteComps10092 then
					for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_170_3 then
							if arg_167_1.isInRecall_ then
								local var_170_18 = Mathf.Lerp(iter_170_3.color.r, arg_167_1.hightColor2.r, var_170_17)
								local var_170_19 = Mathf.Lerp(iter_170_3.color.g, arg_167_1.hightColor2.g, var_170_17)
								local var_170_20 = Mathf.Lerp(iter_170_3.color.b, arg_167_1.hightColor2.b, var_170_17)

								iter_170_3.color = Color.New(var_170_18, var_170_19, var_170_20)
							else
								local var_170_21 = Mathf.Lerp(iter_170_3.color.r, 0.5, var_170_17)

								iter_170_3.color = Color.New(var_170_21, var_170_21, var_170_21)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= var_170_15 + var_170_16 and arg_167_1.time_ < var_170_15 + var_170_16 + arg_170_0 and not isNil(var_170_14) and arg_167_1.var_.actorSpriteComps10092 then
				for iter_170_4, iter_170_5 in pairs(arg_167_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_170_5 then
						if arg_167_1.isInRecall_ then
							iter_170_5.color = arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_170_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps10092 = nil
			end

			local var_170_22 = arg_167_1.actors_["10094"]
			local var_170_23 = 0

			if var_170_23 < arg_167_1.time_ and arg_167_1.time_ <= var_170_23 + arg_170_0 and not isNil(var_170_22) and arg_167_1.var_.actorSpriteComps10094 == nil then
				arg_167_1.var_.actorSpriteComps10094 = var_170_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_24 = 2

			if var_170_23 <= arg_167_1.time_ and arg_167_1.time_ < var_170_23 + var_170_24 and not isNil(var_170_22) then
				local var_170_25 = (arg_167_1.time_ - var_170_23) / var_170_24

				if arg_167_1.var_.actorSpriteComps10094 then
					for iter_170_6, iter_170_7 in pairs(arg_167_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_170_7 then
							if arg_167_1.isInRecall_ then
								local var_170_26 = Mathf.Lerp(iter_170_7.color.r, arg_167_1.hightColor1.r, var_170_25)
								local var_170_27 = Mathf.Lerp(iter_170_7.color.g, arg_167_1.hightColor1.g, var_170_25)
								local var_170_28 = Mathf.Lerp(iter_170_7.color.b, arg_167_1.hightColor1.b, var_170_25)

								iter_170_7.color = Color.New(var_170_26, var_170_27, var_170_28)
							else
								local var_170_29 = Mathf.Lerp(iter_170_7.color.r, 1, var_170_25)

								iter_170_7.color = Color.New(var_170_29, var_170_29, var_170_29)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= var_170_23 + var_170_24 and arg_167_1.time_ < var_170_23 + var_170_24 + arg_170_0 and not isNil(var_170_22) and arg_167_1.var_.actorSpriteComps10094 then
				for iter_170_8, iter_170_9 in pairs(arg_167_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_170_9 then
						if arg_167_1.isInRecall_ then
							iter_170_9.color = arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_170_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_167_1.var_.actorSpriteComps10094 = nil
			end

			local var_170_30 = arg_167_1.actors_["10094"]
			local var_170_31 = 0

			if var_170_31 < arg_167_1.time_ and arg_167_1.time_ <= var_170_31 + arg_170_0 then
				local var_170_32 = var_170_30:GetComponentInChildren(typeof(CanvasGroup))

				if var_170_32 then
					arg_167_1.var_.alphaOldValue10094 = var_170_32.alpha
					arg_167_1.var_.characterEffect10094 = var_170_32
				end

				arg_167_1.var_.alphaOldValue10094 = 0
			end

			local var_170_33 = 0.5

			if var_170_31 <= arg_167_1.time_ and arg_167_1.time_ < var_170_31 + var_170_33 then
				local var_170_34 = (arg_167_1.time_ - var_170_31) / var_170_33
				local var_170_35 = Mathf.Lerp(arg_167_1.var_.alphaOldValue10094, 1, var_170_34)

				if arg_167_1.var_.characterEffect10094 then
					arg_167_1.var_.characterEffect10094.alpha = var_170_35
				end
			end

			if arg_167_1.time_ >= var_170_31 + var_170_33 and arg_167_1.time_ < var_170_31 + var_170_33 + arg_170_0 and arg_167_1.var_.characterEffect10094 then
				arg_167_1.var_.characterEffect10094.alpha = 1
			end

			local var_170_36 = 0.034
			local var_170_37 = 1.966

			if var_170_36 < arg_167_1.time_ and arg_167_1.time_ <= var_170_36 + arg_170_0 then
				local var_170_38 = "play"
				local var_170_39 = "effect"

				arg_167_1:AudioAction(var_170_38, var_170_39, "se_story_134_01", "se_story_134_01_skill01", "")
			end

			if arg_167_1.frameCnt_ <= 1 then
				arg_167_1.dialog_:SetActive(false)
			end

			local var_170_40 = 0.5
			local var_170_41 = 0.125

			if var_170_40 < arg_167_1.time_ and arg_167_1.time_ <= var_170_40 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0

				arg_167_1.dialog_:SetActive(true)

				arg_167_1.dialogCg_.alpha = 0

				local var_170_42 = LeanTween.value(arg_167_1.dialog_, 0, 1, 0.3)

				var_170_42:setOnUpdate(LuaHelper.FloatAction(function(arg_171_0)
					arg_167_1.dialogCg_.alpha = arg_171_0
				end))
				var_170_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_167_1.dialog_)
					var_170_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_167_1.duration_ = arg_167_1.duration_ + 0.3

				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_43 = arg_167_1:FormatText(StoryNameCfg[259].name)

				arg_167_1.leftNameTxt_.text = var_170_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_44 = arg_167_1:GetWordFromCfg(413081039)
				local var_170_45 = arg_167_1:FormatText(var_170_44.content)

				arg_167_1.text_.text = var_170_45

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_46 = 5
				local var_170_47 = utf8.len(var_170_45)
				local var_170_48 = var_170_46 <= 0 and var_170_41 or var_170_41 * (var_170_47 / var_170_46)

				if var_170_48 > 0 and var_170_41 < var_170_48 then
					arg_167_1.talkMaxDuration = var_170_48
					var_170_40 = var_170_40 + 0.3

					if var_170_48 + var_170_40 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_48 + var_170_40
					end
				end

				arg_167_1.text_.text = var_170_45
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081039", "story_v_out_413081.awb") ~= 0 then
					local var_170_49 = manager.audio:GetVoiceLength("story_v_out_413081", "413081039", "story_v_out_413081.awb") / 1000

					if var_170_49 + var_170_40 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_49 + var_170_40
					end

					if var_170_44.prefab_name ~= "" and arg_167_1.actors_[var_170_44.prefab_name] ~= nil then
						local var_170_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_44.prefab_name].transform, "story_v_out_413081", "413081039", "story_v_out_413081.awb")

						arg_167_1:RecordAudio("413081039", var_170_50)
						arg_167_1:RecordAudio("413081039", var_170_50)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_413081", "413081039", "story_v_out_413081.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_413081", "413081039", "story_v_out_413081.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_51 = var_170_40 + 0.3
			local var_170_52 = math.max(var_170_41, arg_167_1.talkMaxDuration)

			if var_170_51 <= arg_167_1.time_ and arg_167_1.time_ < var_170_51 + var_170_52 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_51) / var_170_52

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_51 + var_170_52 and arg_167_1.time_ < var_170_51 + var_170_52 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play413081040 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 413081040
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play413081041(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10094"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos10094 = var_176_0.localPosition
				var_176_0.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("10094", 0)

				local var_176_2 = var_176_0.childCount

				for iter_176_0 = 0, var_176_2 - 1 do
					local var_176_3 = var_176_0:GetChild(iter_176_0)

					if var_176_3.name == "" or not string.find(var_176_3.name, "split") then
						var_176_3.gameObject:SetActive(true)
					else
						var_176_3.gameObject:SetActive(false)
					end
				end
			end

			local var_176_4 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_4 then
				local var_176_5 = (arg_173_1.time_ - var_176_1) / var_176_4
				local var_176_6 = Vector3.New(-5000, -340, -414)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10094, var_176_6, var_176_5)
			end

			if arg_173_1.time_ >= var_176_1 + var_176_4 and arg_173_1.time_ < var_176_1 + var_176_4 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_176_7 = arg_173_1.actors_["10094"]
			local var_176_8 = 0

			if var_176_8 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 and not isNil(var_176_7) and arg_173_1.var_.actorSpriteComps10094 == nil then
				arg_173_1.var_.actorSpriteComps10094 = var_176_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_9 = 2

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_9 and not isNil(var_176_7) then
				local var_176_10 = (arg_173_1.time_ - var_176_8) / var_176_9

				if arg_173_1.var_.actorSpriteComps10094 then
					for iter_176_1, iter_176_2 in pairs(arg_173_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_176_2 then
							if arg_173_1.isInRecall_ then
								local var_176_11 = Mathf.Lerp(iter_176_2.color.r, arg_173_1.hightColor2.r, var_176_10)
								local var_176_12 = Mathf.Lerp(iter_176_2.color.g, arg_173_1.hightColor2.g, var_176_10)
								local var_176_13 = Mathf.Lerp(iter_176_2.color.b, arg_173_1.hightColor2.b, var_176_10)

								iter_176_2.color = Color.New(var_176_11, var_176_12, var_176_13)
							else
								local var_176_14 = Mathf.Lerp(iter_176_2.color.r, 0.5, var_176_10)

								iter_176_2.color = Color.New(var_176_14, var_176_14, var_176_14)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= var_176_8 + var_176_9 and arg_173_1.time_ < var_176_8 + var_176_9 + arg_176_0 and not isNil(var_176_7) and arg_173_1.var_.actorSpriteComps10094 then
				for iter_176_3, iter_176_4 in pairs(arg_173_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_176_4 then
						if arg_173_1.isInRecall_ then
							iter_176_4.color = arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_176_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_173_1.var_.actorSpriteComps10094 = nil
			end

			local var_176_15 = 0
			local var_176_16 = 1.5

			if var_176_15 < arg_173_1.time_ and arg_173_1.time_ <= var_176_15 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_17 = arg_173_1:GetWordFromCfg(413081040)
				local var_176_18 = arg_173_1:FormatText(var_176_17.content)

				arg_173_1.text_.text = var_176_18

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_19 = 60
				local var_176_20 = utf8.len(var_176_18)
				local var_176_21 = var_176_19 <= 0 and var_176_16 or var_176_16 * (var_176_20 / var_176_19)

				if var_176_21 > 0 and var_176_16 < var_176_21 then
					arg_173_1.talkMaxDuration = var_176_21

					if var_176_21 + var_176_15 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_21 + var_176_15
					end
				end

				arg_173_1.text_.text = var_176_18
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_22 = math.max(var_176_16, arg_173_1.talkMaxDuration)

			if var_176_15 <= arg_173_1.time_ and arg_173_1.time_ < var_176_15 + var_176_22 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_15) / var_176_22

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_15 + var_176_22 and arg_173_1.time_ < var_176_15 + var_176_22 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play413081041 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 413081041
		arg_177_1.duration_ = 6.4

		local var_177_0 = {
			zh = 4,
			ja = 6.4
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
				arg_177_0:Play413081042(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10022"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos10022 = var_180_0.localPosition
				var_180_0.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("10022", 2)

				local var_180_2 = var_180_0.childCount

				for iter_180_0 = 0, var_180_2 - 1 do
					local var_180_3 = var_180_0:GetChild(iter_180_0)

					if var_180_3.name == "split_8" or not string.find(var_180_3.name, "split") then
						var_180_3.gameObject:SetActive(true)
					else
						var_180_3.gameObject:SetActive(false)
					end
				end
			end

			local var_180_4 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_4 then
				local var_180_5 = (arg_177_1.time_ - var_180_1) / var_180_4
				local var_180_6 = Vector3.New(-390, -315, -320)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10022, var_180_6, var_180_5)
			end

			if arg_177_1.time_ >= var_180_1 + var_180_4 and arg_177_1.time_ < var_180_1 + var_180_4 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_180_7 = arg_177_1.actors_["10022"]
			local var_180_8 = 0

			if var_180_8 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 and not isNil(var_180_7) and arg_177_1.var_.actorSpriteComps10022 == nil then
				arg_177_1.var_.actorSpriteComps10022 = var_180_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_9 = 2

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_9 and not isNil(var_180_7) then
				local var_180_10 = (arg_177_1.time_ - var_180_8) / var_180_9

				if arg_177_1.var_.actorSpriteComps10022 then
					for iter_180_1, iter_180_2 in pairs(arg_177_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_180_2 then
							if arg_177_1.isInRecall_ then
								local var_180_11 = Mathf.Lerp(iter_180_2.color.r, arg_177_1.hightColor1.r, var_180_10)
								local var_180_12 = Mathf.Lerp(iter_180_2.color.g, arg_177_1.hightColor1.g, var_180_10)
								local var_180_13 = Mathf.Lerp(iter_180_2.color.b, arg_177_1.hightColor1.b, var_180_10)

								iter_180_2.color = Color.New(var_180_11, var_180_12, var_180_13)
							else
								local var_180_14 = Mathf.Lerp(iter_180_2.color.r, 1, var_180_10)

								iter_180_2.color = Color.New(var_180_14, var_180_14, var_180_14)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= var_180_8 + var_180_9 and arg_177_1.time_ < var_180_8 + var_180_9 + arg_180_0 and not isNil(var_180_7) and arg_177_1.var_.actorSpriteComps10022 then
				for iter_180_3, iter_180_4 in pairs(arg_177_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_180_4 then
						if arg_177_1.isInRecall_ then
							iter_180_4.color = arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_180_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_177_1.var_.actorSpriteComps10022 = nil
			end

			local var_180_15 = 0
			local var_180_16 = 0.4

			if var_180_15 < arg_177_1.time_ and arg_177_1.time_ <= var_180_15 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_17 = arg_177_1:FormatText(StoryNameCfg[614].name)

				arg_177_1.leftNameTxt_.text = var_180_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_18 = arg_177_1:GetWordFromCfg(413081041)
				local var_180_19 = arg_177_1:FormatText(var_180_18.content)

				arg_177_1.text_.text = var_180_19

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_20 = 16
				local var_180_21 = utf8.len(var_180_19)
				local var_180_22 = var_180_20 <= 0 and var_180_16 or var_180_16 * (var_180_21 / var_180_20)

				if var_180_22 > 0 and var_180_16 < var_180_22 then
					arg_177_1.talkMaxDuration = var_180_22

					if var_180_22 + var_180_15 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_22 + var_180_15
					end
				end

				arg_177_1.text_.text = var_180_19
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081041", "story_v_out_413081.awb") ~= 0 then
					local var_180_23 = manager.audio:GetVoiceLength("story_v_out_413081", "413081041", "story_v_out_413081.awb") / 1000

					if var_180_23 + var_180_15 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_23 + var_180_15
					end

					if var_180_18.prefab_name ~= "" and arg_177_1.actors_[var_180_18.prefab_name] ~= nil then
						local var_180_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_18.prefab_name].transform, "story_v_out_413081", "413081041", "story_v_out_413081.awb")

						arg_177_1:RecordAudio("413081041", var_180_24)
						arg_177_1:RecordAudio("413081041", var_180_24)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_413081", "413081041", "story_v_out_413081.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_413081", "413081041", "story_v_out_413081.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_25 = math.max(var_180_16, arg_177_1.talkMaxDuration)

			if var_180_15 <= arg_177_1.time_ and arg_177_1.time_ < var_180_15 + var_180_25 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_15) / var_180_25

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_15 + var_180_25 and arg_177_1.time_ < var_180_15 + var_180_25 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play413081042 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 413081042
		arg_181_1.duration_ = 3.6

		local var_181_0 = {
			zh = 2.4,
			ja = 3.6
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
				arg_181_0:Play413081043(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10094"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos10094 = var_184_0.localPosition
				var_184_0.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10094", 4)

				local var_184_2 = var_184_0.childCount

				for iter_184_0 = 0, var_184_2 - 1 do
					local var_184_3 = var_184_0:GetChild(iter_184_0)

					if var_184_3.name == "" or not string.find(var_184_3.name, "split") then
						var_184_3.gameObject:SetActive(true)
					else
						var_184_3.gameObject:SetActive(false)
					end
				end
			end

			local var_184_4 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_4 then
				local var_184_5 = (arg_181_1.time_ - var_184_1) / var_184_4
				local var_184_6 = Vector3.New(390, -340, -414)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10094, var_184_6, var_184_5)
			end

			if arg_181_1.time_ >= var_184_1 + var_184_4 and arg_181_1.time_ < var_184_1 + var_184_4 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(390, -340, -414)
			end

			local var_184_7 = arg_181_1.actors_["10022"].transform
			local var_184_8 = 0

			if var_184_8 < arg_181_1.time_ and arg_181_1.time_ <= var_184_8 + arg_184_0 then
				arg_181_1.var_.moveOldPos10022 = var_184_7.localPosition
				var_184_7.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10022", 2)

				local var_184_9 = var_184_7.childCount

				for iter_184_1 = 0, var_184_9 - 1 do
					local var_184_10 = var_184_7:GetChild(iter_184_1)

					if var_184_10.name == "" or not string.find(var_184_10.name, "split") then
						var_184_10.gameObject:SetActive(true)
					else
						var_184_10.gameObject:SetActive(false)
					end
				end
			end

			local var_184_11 = 0.001

			if var_184_8 <= arg_181_1.time_ and arg_181_1.time_ < var_184_8 + var_184_11 then
				local var_184_12 = (arg_181_1.time_ - var_184_8) / var_184_11
				local var_184_13 = Vector3.New(-390, -315, -320)

				var_184_7.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10022, var_184_13, var_184_12)
			end

			if arg_181_1.time_ >= var_184_8 + var_184_11 and arg_181_1.time_ < var_184_8 + var_184_11 + arg_184_0 then
				var_184_7.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_184_14 = arg_181_1.actors_["10094"]
			local var_184_15 = 0

			if var_184_15 < arg_181_1.time_ and arg_181_1.time_ <= var_184_15 + arg_184_0 and not isNil(var_184_14) and arg_181_1.var_.actorSpriteComps10094 == nil then
				arg_181_1.var_.actorSpriteComps10094 = var_184_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_16 = 2

			if var_184_15 <= arg_181_1.time_ and arg_181_1.time_ < var_184_15 + var_184_16 and not isNil(var_184_14) then
				local var_184_17 = (arg_181_1.time_ - var_184_15) / var_184_16

				if arg_181_1.var_.actorSpriteComps10094 then
					for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_184_3 then
							if arg_181_1.isInRecall_ then
								local var_184_18 = Mathf.Lerp(iter_184_3.color.r, arg_181_1.hightColor1.r, var_184_17)
								local var_184_19 = Mathf.Lerp(iter_184_3.color.g, arg_181_1.hightColor1.g, var_184_17)
								local var_184_20 = Mathf.Lerp(iter_184_3.color.b, arg_181_1.hightColor1.b, var_184_17)

								iter_184_3.color = Color.New(var_184_18, var_184_19, var_184_20)
							else
								local var_184_21 = Mathf.Lerp(iter_184_3.color.r, 1, var_184_17)

								iter_184_3.color = Color.New(var_184_21, var_184_21, var_184_21)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_15 + var_184_16 and arg_181_1.time_ < var_184_15 + var_184_16 + arg_184_0 and not isNil(var_184_14) and arg_181_1.var_.actorSpriteComps10094 then
				for iter_184_4, iter_184_5 in pairs(arg_181_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_184_5 then
						if arg_181_1.isInRecall_ then
							iter_184_5.color = arg_181_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_184_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10094 = nil
			end

			local var_184_22 = arg_181_1.actors_["10022"]
			local var_184_23 = 0

			if var_184_23 < arg_181_1.time_ and arg_181_1.time_ <= var_184_23 + arg_184_0 and not isNil(var_184_22) and arg_181_1.var_.actorSpriteComps10022 == nil then
				arg_181_1.var_.actorSpriteComps10022 = var_184_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_24 = 2

			if var_184_23 <= arg_181_1.time_ and arg_181_1.time_ < var_184_23 + var_184_24 and not isNil(var_184_22) then
				local var_184_25 = (arg_181_1.time_ - var_184_23) / var_184_24

				if arg_181_1.var_.actorSpriteComps10022 then
					for iter_184_6, iter_184_7 in pairs(arg_181_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_184_7 then
							if arg_181_1.isInRecall_ then
								local var_184_26 = Mathf.Lerp(iter_184_7.color.r, arg_181_1.hightColor2.r, var_184_25)
								local var_184_27 = Mathf.Lerp(iter_184_7.color.g, arg_181_1.hightColor2.g, var_184_25)
								local var_184_28 = Mathf.Lerp(iter_184_7.color.b, arg_181_1.hightColor2.b, var_184_25)

								iter_184_7.color = Color.New(var_184_26, var_184_27, var_184_28)
							else
								local var_184_29 = Mathf.Lerp(iter_184_7.color.r, 0.5, var_184_25)

								iter_184_7.color = Color.New(var_184_29, var_184_29, var_184_29)
							end
						end
					end
				end
			end

			if arg_181_1.time_ >= var_184_23 + var_184_24 and arg_181_1.time_ < var_184_23 + var_184_24 + arg_184_0 and not isNil(var_184_22) and arg_181_1.var_.actorSpriteComps10022 then
				for iter_184_8, iter_184_9 in pairs(arg_181_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_184_9 then
						if arg_181_1.isInRecall_ then
							iter_184_9.color = arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_184_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_181_1.var_.actorSpriteComps10022 = nil
			end

			local var_184_30 = 0
			local var_184_31 = 0.225

			if var_184_30 < arg_181_1.time_ and arg_181_1.time_ <= var_184_30 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_32 = arg_181_1:FormatText(StoryNameCfg[259].name)

				arg_181_1.leftNameTxt_.text = var_184_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_33 = arg_181_1:GetWordFromCfg(413081042)
				local var_184_34 = arg_181_1:FormatText(var_184_33.content)

				arg_181_1.text_.text = var_184_34

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_35 = 9
				local var_184_36 = utf8.len(var_184_34)
				local var_184_37 = var_184_35 <= 0 and var_184_31 or var_184_31 * (var_184_36 / var_184_35)

				if var_184_37 > 0 and var_184_31 < var_184_37 then
					arg_181_1.talkMaxDuration = var_184_37

					if var_184_37 + var_184_30 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_37 + var_184_30
					end
				end

				arg_181_1.text_.text = var_184_34
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081042", "story_v_out_413081.awb") ~= 0 then
					local var_184_38 = manager.audio:GetVoiceLength("story_v_out_413081", "413081042", "story_v_out_413081.awb") / 1000

					if var_184_38 + var_184_30 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_38 + var_184_30
					end

					if var_184_33.prefab_name ~= "" and arg_181_1.actors_[var_184_33.prefab_name] ~= nil then
						local var_184_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_33.prefab_name].transform, "story_v_out_413081", "413081042", "story_v_out_413081.awb")

						arg_181_1:RecordAudio("413081042", var_184_39)
						arg_181_1:RecordAudio("413081042", var_184_39)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_413081", "413081042", "story_v_out_413081.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_413081", "413081042", "story_v_out_413081.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_40 = math.max(var_184_31, arg_181_1.talkMaxDuration)

			if var_184_30 <= arg_181_1.time_ and arg_181_1.time_ < var_184_30 + var_184_40 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_30) / var_184_40

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_30 + var_184_40 and arg_181_1.time_ < var_184_30 + var_184_40 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play413081043 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 413081043
		arg_185_1.duration_ = 5.03

		local var_185_0 = {
			zh = 2.8,
			ja = 5.033
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
				arg_185_0:Play413081044(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["10022"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos10022 = var_188_0.localPosition
				var_188_0.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("10022", 2)

				local var_188_2 = var_188_0.childCount

				for iter_188_0 = 0, var_188_2 - 1 do
					local var_188_3 = var_188_0:GetChild(iter_188_0)

					if var_188_3.name == "" or not string.find(var_188_3.name, "split") then
						var_188_3.gameObject:SetActive(true)
					else
						var_188_3.gameObject:SetActive(false)
					end
				end
			end

			local var_188_4 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_4 then
				local var_188_5 = (arg_185_1.time_ - var_188_1) / var_188_4
				local var_188_6 = Vector3.New(-390, -315, -320)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10022, var_188_6, var_188_5)
			end

			if arg_185_1.time_ >= var_188_1 + var_188_4 and arg_185_1.time_ < var_188_1 + var_188_4 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_188_7 = arg_185_1.actors_["10094"].transform
			local var_188_8 = 0

			if var_188_8 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.var_.moveOldPos10094 = var_188_7.localPosition
				var_188_7.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("10094", 4)

				local var_188_9 = var_188_7.childCount

				for iter_188_1 = 0, var_188_9 - 1 do
					local var_188_10 = var_188_7:GetChild(iter_188_1)

					if var_188_10.name == "" or not string.find(var_188_10.name, "split") then
						var_188_10.gameObject:SetActive(true)
					else
						var_188_10.gameObject:SetActive(false)
					end
				end
			end

			local var_188_11 = 0.001

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_11 then
				local var_188_12 = (arg_185_1.time_ - var_188_8) / var_188_11
				local var_188_13 = Vector3.New(390, -340, -414)

				var_188_7.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10094, var_188_13, var_188_12)
			end

			if arg_185_1.time_ >= var_188_8 + var_188_11 and arg_185_1.time_ < var_188_8 + var_188_11 + arg_188_0 then
				var_188_7.localPosition = Vector3.New(390, -340, -414)
			end

			local var_188_14 = arg_185_1.actors_["10022"]
			local var_188_15 = 0

			if var_188_15 < arg_185_1.time_ and arg_185_1.time_ <= var_188_15 + arg_188_0 and not isNil(var_188_14) and arg_185_1.var_.actorSpriteComps10022 == nil then
				arg_185_1.var_.actorSpriteComps10022 = var_188_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_16 = 2

			if var_188_15 <= arg_185_1.time_ and arg_185_1.time_ < var_188_15 + var_188_16 and not isNil(var_188_14) then
				local var_188_17 = (arg_185_1.time_ - var_188_15) / var_188_16

				if arg_185_1.var_.actorSpriteComps10022 then
					for iter_188_2, iter_188_3 in pairs(arg_185_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_188_3 then
							if arg_185_1.isInRecall_ then
								local var_188_18 = Mathf.Lerp(iter_188_3.color.r, arg_185_1.hightColor1.r, var_188_17)
								local var_188_19 = Mathf.Lerp(iter_188_3.color.g, arg_185_1.hightColor1.g, var_188_17)
								local var_188_20 = Mathf.Lerp(iter_188_3.color.b, arg_185_1.hightColor1.b, var_188_17)

								iter_188_3.color = Color.New(var_188_18, var_188_19, var_188_20)
							else
								local var_188_21 = Mathf.Lerp(iter_188_3.color.r, 1, var_188_17)

								iter_188_3.color = Color.New(var_188_21, var_188_21, var_188_21)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_15 + var_188_16 and arg_185_1.time_ < var_188_15 + var_188_16 + arg_188_0 and not isNil(var_188_14) and arg_185_1.var_.actorSpriteComps10022 then
				for iter_188_4, iter_188_5 in pairs(arg_185_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_188_5 then
						if arg_185_1.isInRecall_ then
							iter_188_5.color = arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_188_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps10022 = nil
			end

			local var_188_22 = arg_185_1.actors_["10094"]
			local var_188_23 = 0

			if var_188_23 < arg_185_1.time_ and arg_185_1.time_ <= var_188_23 + arg_188_0 and not isNil(var_188_22) and arg_185_1.var_.actorSpriteComps10094 == nil then
				arg_185_1.var_.actorSpriteComps10094 = var_188_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_24 = 2

			if var_188_23 <= arg_185_1.time_ and arg_185_1.time_ < var_188_23 + var_188_24 and not isNil(var_188_22) then
				local var_188_25 = (arg_185_1.time_ - var_188_23) / var_188_24

				if arg_185_1.var_.actorSpriteComps10094 then
					for iter_188_6, iter_188_7 in pairs(arg_185_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_188_7 then
							if arg_185_1.isInRecall_ then
								local var_188_26 = Mathf.Lerp(iter_188_7.color.r, arg_185_1.hightColor2.r, var_188_25)
								local var_188_27 = Mathf.Lerp(iter_188_7.color.g, arg_185_1.hightColor2.g, var_188_25)
								local var_188_28 = Mathf.Lerp(iter_188_7.color.b, arg_185_1.hightColor2.b, var_188_25)

								iter_188_7.color = Color.New(var_188_26, var_188_27, var_188_28)
							else
								local var_188_29 = Mathf.Lerp(iter_188_7.color.r, 0.5, var_188_25)

								iter_188_7.color = Color.New(var_188_29, var_188_29, var_188_29)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= var_188_23 + var_188_24 and arg_185_1.time_ < var_188_23 + var_188_24 + arg_188_0 and not isNil(var_188_22) and arg_185_1.var_.actorSpriteComps10094 then
				for iter_188_8, iter_188_9 in pairs(arg_185_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_188_9 then
						if arg_185_1.isInRecall_ then
							iter_188_9.color = arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_188_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_185_1.var_.actorSpriteComps10094 = nil
			end

			local var_188_30 = 0
			local var_188_31 = 0.325

			if var_188_30 < arg_185_1.time_ and arg_185_1.time_ <= var_188_30 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_32 = arg_185_1:FormatText(StoryNameCfg[614].name)

				arg_185_1.leftNameTxt_.text = var_188_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_33 = arg_185_1:GetWordFromCfg(413081043)
				local var_188_34 = arg_185_1:FormatText(var_188_33.content)

				arg_185_1.text_.text = var_188_34

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_35 = 13
				local var_188_36 = utf8.len(var_188_34)
				local var_188_37 = var_188_35 <= 0 and var_188_31 or var_188_31 * (var_188_36 / var_188_35)

				if var_188_37 > 0 and var_188_31 < var_188_37 then
					arg_185_1.talkMaxDuration = var_188_37

					if var_188_37 + var_188_30 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_37 + var_188_30
					end
				end

				arg_185_1.text_.text = var_188_34
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081043", "story_v_out_413081.awb") ~= 0 then
					local var_188_38 = manager.audio:GetVoiceLength("story_v_out_413081", "413081043", "story_v_out_413081.awb") / 1000

					if var_188_38 + var_188_30 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_38 + var_188_30
					end

					if var_188_33.prefab_name ~= "" and arg_185_1.actors_[var_188_33.prefab_name] ~= nil then
						local var_188_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_33.prefab_name].transform, "story_v_out_413081", "413081043", "story_v_out_413081.awb")

						arg_185_1:RecordAudio("413081043", var_188_39)
						arg_185_1:RecordAudio("413081043", var_188_39)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_413081", "413081043", "story_v_out_413081.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_413081", "413081043", "story_v_out_413081.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_40 = math.max(var_188_31, arg_185_1.talkMaxDuration)

			if var_188_30 <= arg_185_1.time_ and arg_185_1.time_ < var_188_30 + var_188_40 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_30) / var_188_40

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_30 + var_188_40 and arg_185_1.time_ < var_188_30 + var_188_40 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play413081044 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 413081044
		arg_189_1.duration_ = 10.23

		local var_189_0 = {
			zh = 5.133,
			ja = 10.233
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
				arg_189_0:Play413081045(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.775

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_2 = arg_189_1:FormatText(StoryNameCfg[614].name)

				arg_189_1.leftNameTxt_.text = var_192_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_3 = arg_189_1:GetWordFromCfg(413081044)
				local var_192_4 = arg_189_1:FormatText(var_192_3.content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 31
				local var_192_6 = utf8.len(var_192_4)
				local var_192_7 = var_192_5 <= 0 and var_192_1 or var_192_1 * (var_192_6 / var_192_5)

				if var_192_7 > 0 and var_192_1 < var_192_7 then
					arg_189_1.talkMaxDuration = var_192_7

					if var_192_7 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_7 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081044", "story_v_out_413081.awb") ~= 0 then
					local var_192_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081044", "story_v_out_413081.awb") / 1000

					if var_192_8 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_8 + var_192_0
					end

					if var_192_3.prefab_name ~= "" and arg_189_1.actors_[var_192_3.prefab_name] ~= nil then
						local var_192_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_3.prefab_name].transform, "story_v_out_413081", "413081044", "story_v_out_413081.awb")

						arg_189_1:RecordAudio("413081044", var_192_9)
						arg_189_1:RecordAudio("413081044", var_192_9)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_413081", "413081044", "story_v_out_413081.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_413081", "413081044", "story_v_out_413081.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_10 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_10 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_10

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_10 and arg_189_1.time_ < var_192_0 + var_192_10 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play413081045 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 413081045
		arg_193_1.duration_ = 7.33

		local var_193_0 = {
			zh = 3.966,
			ja = 7.333
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
				arg_193_0:Play413081046(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["10094"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos10094 = var_196_0.localPosition
				var_196_0.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10094", 4)

				local var_196_2 = var_196_0.childCount

				for iter_196_0 = 0, var_196_2 - 1 do
					local var_196_3 = var_196_0:GetChild(iter_196_0)

					if var_196_3.name == "" or not string.find(var_196_3.name, "split") then
						var_196_3.gameObject:SetActive(true)
					else
						var_196_3.gameObject:SetActive(false)
					end
				end
			end

			local var_196_4 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_4 then
				local var_196_5 = (arg_193_1.time_ - var_196_1) / var_196_4
				local var_196_6 = Vector3.New(390, -340, -414)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10094, var_196_6, var_196_5)
			end

			if arg_193_1.time_ >= var_196_1 + var_196_4 and arg_193_1.time_ < var_196_1 + var_196_4 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(390, -340, -414)
			end

			local var_196_7 = arg_193_1.actors_["10022"].transform
			local var_196_8 = 0

			if var_196_8 < arg_193_1.time_ and arg_193_1.time_ <= var_196_8 + arg_196_0 then
				arg_193_1.var_.moveOldPos10022 = var_196_7.localPosition
				var_196_7.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10022", 2)

				local var_196_9 = var_196_7.childCount

				for iter_196_1 = 0, var_196_9 - 1 do
					local var_196_10 = var_196_7:GetChild(iter_196_1)

					if var_196_10.name == "" or not string.find(var_196_10.name, "split") then
						var_196_10.gameObject:SetActive(true)
					else
						var_196_10.gameObject:SetActive(false)
					end
				end
			end

			local var_196_11 = 0.001

			if var_196_8 <= arg_193_1.time_ and arg_193_1.time_ < var_196_8 + var_196_11 then
				local var_196_12 = (arg_193_1.time_ - var_196_8) / var_196_11
				local var_196_13 = Vector3.New(-390, -315, -320)

				var_196_7.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10022, var_196_13, var_196_12)
			end

			if arg_193_1.time_ >= var_196_8 + var_196_11 and arg_193_1.time_ < var_196_8 + var_196_11 + arg_196_0 then
				var_196_7.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_196_14 = arg_193_1.actors_["10094"]
			local var_196_15 = 0

			if var_196_15 < arg_193_1.time_ and arg_193_1.time_ <= var_196_15 + arg_196_0 and not isNil(var_196_14) and arg_193_1.var_.actorSpriteComps10094 == nil then
				arg_193_1.var_.actorSpriteComps10094 = var_196_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_16 = 2

			if var_196_15 <= arg_193_1.time_ and arg_193_1.time_ < var_196_15 + var_196_16 and not isNil(var_196_14) then
				local var_196_17 = (arg_193_1.time_ - var_196_15) / var_196_16

				if arg_193_1.var_.actorSpriteComps10094 then
					for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_196_3 then
							if arg_193_1.isInRecall_ then
								local var_196_18 = Mathf.Lerp(iter_196_3.color.r, arg_193_1.hightColor1.r, var_196_17)
								local var_196_19 = Mathf.Lerp(iter_196_3.color.g, arg_193_1.hightColor1.g, var_196_17)
								local var_196_20 = Mathf.Lerp(iter_196_3.color.b, arg_193_1.hightColor1.b, var_196_17)

								iter_196_3.color = Color.New(var_196_18, var_196_19, var_196_20)
							else
								local var_196_21 = Mathf.Lerp(iter_196_3.color.r, 1, var_196_17)

								iter_196_3.color = Color.New(var_196_21, var_196_21, var_196_21)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_15 + var_196_16 and arg_193_1.time_ < var_196_15 + var_196_16 + arg_196_0 and not isNil(var_196_14) and arg_193_1.var_.actorSpriteComps10094 then
				for iter_196_4, iter_196_5 in pairs(arg_193_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_196_5 then
						if arg_193_1.isInRecall_ then
							iter_196_5.color = arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_196_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10094 = nil
			end

			local var_196_22 = arg_193_1.actors_["10022"]
			local var_196_23 = 0

			if var_196_23 < arg_193_1.time_ and arg_193_1.time_ <= var_196_23 + arg_196_0 and not isNil(var_196_22) and arg_193_1.var_.actorSpriteComps10022 == nil then
				arg_193_1.var_.actorSpriteComps10022 = var_196_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_24 = 2

			if var_196_23 <= arg_193_1.time_ and arg_193_1.time_ < var_196_23 + var_196_24 and not isNil(var_196_22) then
				local var_196_25 = (arg_193_1.time_ - var_196_23) / var_196_24

				if arg_193_1.var_.actorSpriteComps10022 then
					for iter_196_6, iter_196_7 in pairs(arg_193_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_196_7 then
							if arg_193_1.isInRecall_ then
								local var_196_26 = Mathf.Lerp(iter_196_7.color.r, arg_193_1.hightColor2.r, var_196_25)
								local var_196_27 = Mathf.Lerp(iter_196_7.color.g, arg_193_1.hightColor2.g, var_196_25)
								local var_196_28 = Mathf.Lerp(iter_196_7.color.b, arg_193_1.hightColor2.b, var_196_25)

								iter_196_7.color = Color.New(var_196_26, var_196_27, var_196_28)
							else
								local var_196_29 = Mathf.Lerp(iter_196_7.color.r, 0.5, var_196_25)

								iter_196_7.color = Color.New(var_196_29, var_196_29, var_196_29)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= var_196_23 + var_196_24 and arg_193_1.time_ < var_196_23 + var_196_24 + arg_196_0 and not isNil(var_196_22) and arg_193_1.var_.actorSpriteComps10022 then
				for iter_196_8, iter_196_9 in pairs(arg_193_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_196_9 then
						if arg_193_1.isInRecall_ then
							iter_196_9.color = arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_196_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_193_1.var_.actorSpriteComps10022 = nil
			end

			local var_196_30 = 0
			local var_196_31 = 0.45

			if var_196_30 < arg_193_1.time_ and arg_193_1.time_ <= var_196_30 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_32 = arg_193_1:FormatText(StoryNameCfg[259].name)

				arg_193_1.leftNameTxt_.text = var_196_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_33 = arg_193_1:GetWordFromCfg(413081045)
				local var_196_34 = arg_193_1:FormatText(var_196_33.content)

				arg_193_1.text_.text = var_196_34

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_35 = 18
				local var_196_36 = utf8.len(var_196_34)
				local var_196_37 = var_196_35 <= 0 and var_196_31 or var_196_31 * (var_196_36 / var_196_35)

				if var_196_37 > 0 and var_196_31 < var_196_37 then
					arg_193_1.talkMaxDuration = var_196_37

					if var_196_37 + var_196_30 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_37 + var_196_30
					end
				end

				arg_193_1.text_.text = var_196_34
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081045", "story_v_out_413081.awb") ~= 0 then
					local var_196_38 = manager.audio:GetVoiceLength("story_v_out_413081", "413081045", "story_v_out_413081.awb") / 1000

					if var_196_38 + var_196_30 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_38 + var_196_30
					end

					if var_196_33.prefab_name ~= "" and arg_193_1.actors_[var_196_33.prefab_name] ~= nil then
						local var_196_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_33.prefab_name].transform, "story_v_out_413081", "413081045", "story_v_out_413081.awb")

						arg_193_1:RecordAudio("413081045", var_196_39)
						arg_193_1:RecordAudio("413081045", var_196_39)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_413081", "413081045", "story_v_out_413081.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_413081", "413081045", "story_v_out_413081.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_40 = math.max(var_196_31, arg_193_1.talkMaxDuration)

			if var_196_30 <= arg_193_1.time_ and arg_193_1.time_ < var_196_30 + var_196_40 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_30) / var_196_40

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_30 + var_196_40 and arg_193_1.time_ < var_196_30 + var_196_40 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play413081046 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 413081046
		arg_197_1.duration_ = 5.37

		local var_197_0 = {
			zh = 3.3,
			ja = 5.366
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
				arg_197_0:Play413081047(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["10022"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos10022 = var_200_0.localPosition
				var_200_0.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("10022", 2)

				local var_200_2 = var_200_0.childCount

				for iter_200_0 = 0, var_200_2 - 1 do
					local var_200_3 = var_200_0:GetChild(iter_200_0)

					if var_200_3.name == "split_6" or not string.find(var_200_3.name, "split") then
						var_200_3.gameObject:SetActive(true)
					else
						var_200_3.gameObject:SetActive(false)
					end
				end
			end

			local var_200_4 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_4 then
				local var_200_5 = (arg_197_1.time_ - var_200_1) / var_200_4
				local var_200_6 = Vector3.New(-390, -315, -320)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10022, var_200_6, var_200_5)
			end

			if arg_197_1.time_ >= var_200_1 + var_200_4 and arg_197_1.time_ < var_200_1 + var_200_4 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_200_7 = arg_197_1.actors_["10022"]
			local var_200_8 = 0

			if var_200_8 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 and not isNil(var_200_7) and arg_197_1.var_.actorSpriteComps10022 == nil then
				arg_197_1.var_.actorSpriteComps10022 = var_200_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_9 = 2

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_9 and not isNil(var_200_7) then
				local var_200_10 = (arg_197_1.time_ - var_200_8) / var_200_9

				if arg_197_1.var_.actorSpriteComps10022 then
					for iter_200_1, iter_200_2 in pairs(arg_197_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_200_2 then
							if arg_197_1.isInRecall_ then
								local var_200_11 = Mathf.Lerp(iter_200_2.color.r, arg_197_1.hightColor1.r, var_200_10)
								local var_200_12 = Mathf.Lerp(iter_200_2.color.g, arg_197_1.hightColor1.g, var_200_10)
								local var_200_13 = Mathf.Lerp(iter_200_2.color.b, arg_197_1.hightColor1.b, var_200_10)

								iter_200_2.color = Color.New(var_200_11, var_200_12, var_200_13)
							else
								local var_200_14 = Mathf.Lerp(iter_200_2.color.r, 1, var_200_10)

								iter_200_2.color = Color.New(var_200_14, var_200_14, var_200_14)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_8 + var_200_9 and arg_197_1.time_ < var_200_8 + var_200_9 + arg_200_0 and not isNil(var_200_7) and arg_197_1.var_.actorSpriteComps10022 then
				for iter_200_3, iter_200_4 in pairs(arg_197_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_200_4 then
						if arg_197_1.isInRecall_ then
							iter_200_4.color = arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_200_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps10022 = nil
			end

			local var_200_15 = arg_197_1.actors_["10094"]
			local var_200_16 = 0

			if var_200_16 < arg_197_1.time_ and arg_197_1.time_ <= var_200_16 + arg_200_0 and not isNil(var_200_15) and arg_197_1.var_.actorSpriteComps10094 == nil then
				arg_197_1.var_.actorSpriteComps10094 = var_200_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_17 = 2

			if var_200_16 <= arg_197_1.time_ and arg_197_1.time_ < var_200_16 + var_200_17 and not isNil(var_200_15) then
				local var_200_18 = (arg_197_1.time_ - var_200_16) / var_200_17

				if arg_197_1.var_.actorSpriteComps10094 then
					for iter_200_5, iter_200_6 in pairs(arg_197_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_200_6 then
							if arg_197_1.isInRecall_ then
								local var_200_19 = Mathf.Lerp(iter_200_6.color.r, arg_197_1.hightColor2.r, var_200_18)
								local var_200_20 = Mathf.Lerp(iter_200_6.color.g, arg_197_1.hightColor2.g, var_200_18)
								local var_200_21 = Mathf.Lerp(iter_200_6.color.b, arg_197_1.hightColor2.b, var_200_18)

								iter_200_6.color = Color.New(var_200_19, var_200_20, var_200_21)
							else
								local var_200_22 = Mathf.Lerp(iter_200_6.color.r, 0.5, var_200_18)

								iter_200_6.color = Color.New(var_200_22, var_200_22, var_200_22)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= var_200_16 + var_200_17 and arg_197_1.time_ < var_200_16 + var_200_17 + arg_200_0 and not isNil(var_200_15) and arg_197_1.var_.actorSpriteComps10094 then
				for iter_200_7, iter_200_8 in pairs(arg_197_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_200_8 then
						if arg_197_1.isInRecall_ then
							iter_200_8.color = arg_197_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_200_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_197_1.var_.actorSpriteComps10094 = nil
			end

			local var_200_23 = 0
			local var_200_24 = 0.375

			if var_200_23 < arg_197_1.time_ and arg_197_1.time_ <= var_200_23 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_25 = arg_197_1:FormatText(StoryNameCfg[614].name)

				arg_197_1.leftNameTxt_.text = var_200_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_26 = arg_197_1:GetWordFromCfg(413081046)
				local var_200_27 = arg_197_1:FormatText(var_200_26.content)

				arg_197_1.text_.text = var_200_27

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_28 = 15
				local var_200_29 = utf8.len(var_200_27)
				local var_200_30 = var_200_28 <= 0 and var_200_24 or var_200_24 * (var_200_29 / var_200_28)

				if var_200_30 > 0 and var_200_24 < var_200_30 then
					arg_197_1.talkMaxDuration = var_200_30

					if var_200_30 + var_200_23 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_30 + var_200_23
					end
				end

				arg_197_1.text_.text = var_200_27
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081046", "story_v_out_413081.awb") ~= 0 then
					local var_200_31 = manager.audio:GetVoiceLength("story_v_out_413081", "413081046", "story_v_out_413081.awb") / 1000

					if var_200_31 + var_200_23 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_31 + var_200_23
					end

					if var_200_26.prefab_name ~= "" and arg_197_1.actors_[var_200_26.prefab_name] ~= nil then
						local var_200_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_26.prefab_name].transform, "story_v_out_413081", "413081046", "story_v_out_413081.awb")

						arg_197_1:RecordAudio("413081046", var_200_32)
						arg_197_1:RecordAudio("413081046", var_200_32)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_413081", "413081046", "story_v_out_413081.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_413081", "413081046", "story_v_out_413081.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_33 = math.max(var_200_24, arg_197_1.talkMaxDuration)

			if var_200_23 <= arg_197_1.time_ and arg_197_1.time_ < var_200_23 + var_200_33 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_23) / var_200_33

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_23 + var_200_33 and arg_197_1.time_ < var_200_23 + var_200_33 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play413081047 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 413081047
		arg_201_1.duration_ = 7.4

		local var_201_0 = {
			zh = 4.066,
			ja = 7.4
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
				arg_201_0:Play413081048(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["10094"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.actorSpriteComps10094 == nil then
				arg_201_1.var_.actorSpriteComps10094 = var_204_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_2 = 2

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.actorSpriteComps10094 then
					for iter_204_0, iter_204_1 in pairs(arg_201_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_204_1 then
							if arg_201_1.isInRecall_ then
								local var_204_4 = Mathf.Lerp(iter_204_1.color.r, arg_201_1.hightColor1.r, var_204_3)
								local var_204_5 = Mathf.Lerp(iter_204_1.color.g, arg_201_1.hightColor1.g, var_204_3)
								local var_204_6 = Mathf.Lerp(iter_204_1.color.b, arg_201_1.hightColor1.b, var_204_3)

								iter_204_1.color = Color.New(var_204_4, var_204_5, var_204_6)
							else
								local var_204_7 = Mathf.Lerp(iter_204_1.color.r, 1, var_204_3)

								iter_204_1.color = Color.New(var_204_7, var_204_7, var_204_7)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.actorSpriteComps10094 then
				for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_204_3 then
						if arg_201_1.isInRecall_ then
							iter_204_3.color = arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_204_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps10094 = nil
			end

			local var_204_8 = arg_201_1.actors_["10022"]
			local var_204_9 = 0

			if var_204_9 < arg_201_1.time_ and arg_201_1.time_ <= var_204_9 + arg_204_0 and not isNil(var_204_8) and arg_201_1.var_.actorSpriteComps10022 == nil then
				arg_201_1.var_.actorSpriteComps10022 = var_204_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_10 = 2

			if var_204_9 <= arg_201_1.time_ and arg_201_1.time_ < var_204_9 + var_204_10 and not isNil(var_204_8) then
				local var_204_11 = (arg_201_1.time_ - var_204_9) / var_204_10

				if arg_201_1.var_.actorSpriteComps10022 then
					for iter_204_4, iter_204_5 in pairs(arg_201_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_204_5 then
							if arg_201_1.isInRecall_ then
								local var_204_12 = Mathf.Lerp(iter_204_5.color.r, arg_201_1.hightColor2.r, var_204_11)
								local var_204_13 = Mathf.Lerp(iter_204_5.color.g, arg_201_1.hightColor2.g, var_204_11)
								local var_204_14 = Mathf.Lerp(iter_204_5.color.b, arg_201_1.hightColor2.b, var_204_11)

								iter_204_5.color = Color.New(var_204_12, var_204_13, var_204_14)
							else
								local var_204_15 = Mathf.Lerp(iter_204_5.color.r, 0.5, var_204_11)

								iter_204_5.color = Color.New(var_204_15, var_204_15, var_204_15)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= var_204_9 + var_204_10 and arg_201_1.time_ < var_204_9 + var_204_10 + arg_204_0 and not isNil(var_204_8) and arg_201_1.var_.actorSpriteComps10022 then
				for iter_204_6, iter_204_7 in pairs(arg_201_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_204_7 then
						if arg_201_1.isInRecall_ then
							iter_204_7.color = arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_204_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_201_1.var_.actorSpriteComps10022 = nil
			end

			local var_204_16 = 0
			local var_204_17 = 0.475

			if var_204_16 < arg_201_1.time_ and arg_201_1.time_ <= var_204_16 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_18 = arg_201_1:FormatText(StoryNameCfg[259].name)

				arg_201_1.leftNameTxt_.text = var_204_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_19 = arg_201_1:GetWordFromCfg(413081047)
				local var_204_20 = arg_201_1:FormatText(var_204_19.content)

				arg_201_1.text_.text = var_204_20

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_21 = 19
				local var_204_22 = utf8.len(var_204_20)
				local var_204_23 = var_204_21 <= 0 and var_204_17 or var_204_17 * (var_204_22 / var_204_21)

				if var_204_23 > 0 and var_204_17 < var_204_23 then
					arg_201_1.talkMaxDuration = var_204_23

					if var_204_23 + var_204_16 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_23 + var_204_16
					end
				end

				arg_201_1.text_.text = var_204_20
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081047", "story_v_out_413081.awb") ~= 0 then
					local var_204_24 = manager.audio:GetVoiceLength("story_v_out_413081", "413081047", "story_v_out_413081.awb") / 1000

					if var_204_24 + var_204_16 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_24 + var_204_16
					end

					if var_204_19.prefab_name ~= "" and arg_201_1.actors_[var_204_19.prefab_name] ~= nil then
						local var_204_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_19.prefab_name].transform, "story_v_out_413081", "413081047", "story_v_out_413081.awb")

						arg_201_1:RecordAudio("413081047", var_204_25)
						arg_201_1:RecordAudio("413081047", var_204_25)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_413081", "413081047", "story_v_out_413081.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_413081", "413081047", "story_v_out_413081.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_26 = math.max(var_204_17, arg_201_1.talkMaxDuration)

			if var_204_16 <= arg_201_1.time_ and arg_201_1.time_ < var_204_16 + var_204_26 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_16) / var_204_26

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_16 + var_204_26 and arg_201_1.time_ < var_204_16 + var_204_26 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play413081048 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 413081048
		arg_205_1.duration_ = 4.67

		local var_205_0 = {
			zh = 2.7,
			ja = 4.666
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
				arg_205_0:Play413081049(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["10022"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps10022 == nil then
				arg_205_1.var_.actorSpriteComps10022 = var_208_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_2 = 2

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.actorSpriteComps10022 then
					for iter_208_0, iter_208_1 in pairs(arg_205_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_208_1 then
							if arg_205_1.isInRecall_ then
								local var_208_4 = Mathf.Lerp(iter_208_1.color.r, arg_205_1.hightColor1.r, var_208_3)
								local var_208_5 = Mathf.Lerp(iter_208_1.color.g, arg_205_1.hightColor1.g, var_208_3)
								local var_208_6 = Mathf.Lerp(iter_208_1.color.b, arg_205_1.hightColor1.b, var_208_3)

								iter_208_1.color = Color.New(var_208_4, var_208_5, var_208_6)
							else
								local var_208_7 = Mathf.Lerp(iter_208_1.color.r, 1, var_208_3)

								iter_208_1.color = Color.New(var_208_7, var_208_7, var_208_7)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.actorSpriteComps10022 then
				for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_208_3 then
						if arg_205_1.isInRecall_ then
							iter_208_3.color = arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_208_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps10022 = nil
			end

			local var_208_8 = arg_205_1.actors_["10094"]
			local var_208_9 = 0

			if var_208_9 < arg_205_1.time_ and arg_205_1.time_ <= var_208_9 + arg_208_0 and not isNil(var_208_8) and arg_205_1.var_.actorSpriteComps10094 == nil then
				arg_205_1.var_.actorSpriteComps10094 = var_208_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_10 = 2

			if var_208_9 <= arg_205_1.time_ and arg_205_1.time_ < var_208_9 + var_208_10 and not isNil(var_208_8) then
				local var_208_11 = (arg_205_1.time_ - var_208_9) / var_208_10

				if arg_205_1.var_.actorSpriteComps10094 then
					for iter_208_4, iter_208_5 in pairs(arg_205_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_208_5 then
							if arg_205_1.isInRecall_ then
								local var_208_12 = Mathf.Lerp(iter_208_5.color.r, arg_205_1.hightColor2.r, var_208_11)
								local var_208_13 = Mathf.Lerp(iter_208_5.color.g, arg_205_1.hightColor2.g, var_208_11)
								local var_208_14 = Mathf.Lerp(iter_208_5.color.b, arg_205_1.hightColor2.b, var_208_11)

								iter_208_5.color = Color.New(var_208_12, var_208_13, var_208_14)
							else
								local var_208_15 = Mathf.Lerp(iter_208_5.color.r, 0.5, var_208_11)

								iter_208_5.color = Color.New(var_208_15, var_208_15, var_208_15)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= var_208_9 + var_208_10 and arg_205_1.time_ < var_208_9 + var_208_10 + arg_208_0 and not isNil(var_208_8) and arg_205_1.var_.actorSpriteComps10094 then
				for iter_208_6, iter_208_7 in pairs(arg_205_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_208_7 then
						if arg_205_1.isInRecall_ then
							iter_208_7.color = arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_208_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_205_1.var_.actorSpriteComps10094 = nil
			end

			local var_208_16 = 0
			local var_208_17 = 0.35

			if var_208_16 < arg_205_1.time_ and arg_205_1.time_ <= var_208_16 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_18 = arg_205_1:FormatText(StoryNameCfg[614].name)

				arg_205_1.leftNameTxt_.text = var_208_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_19 = arg_205_1:GetWordFromCfg(413081048)
				local var_208_20 = arg_205_1:FormatText(var_208_19.content)

				arg_205_1.text_.text = var_208_20

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_21 = 14
				local var_208_22 = utf8.len(var_208_20)
				local var_208_23 = var_208_21 <= 0 and var_208_17 or var_208_17 * (var_208_22 / var_208_21)

				if var_208_23 > 0 and var_208_17 < var_208_23 then
					arg_205_1.talkMaxDuration = var_208_23

					if var_208_23 + var_208_16 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_23 + var_208_16
					end
				end

				arg_205_1.text_.text = var_208_20
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081048", "story_v_out_413081.awb") ~= 0 then
					local var_208_24 = manager.audio:GetVoiceLength("story_v_out_413081", "413081048", "story_v_out_413081.awb") / 1000

					if var_208_24 + var_208_16 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_24 + var_208_16
					end

					if var_208_19.prefab_name ~= "" and arg_205_1.actors_[var_208_19.prefab_name] ~= nil then
						local var_208_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_19.prefab_name].transform, "story_v_out_413081", "413081048", "story_v_out_413081.awb")

						arg_205_1:RecordAudio("413081048", var_208_25)
						arg_205_1:RecordAudio("413081048", var_208_25)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_413081", "413081048", "story_v_out_413081.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_413081", "413081048", "story_v_out_413081.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_26 = math.max(var_208_17, arg_205_1.talkMaxDuration)

			if var_208_16 <= arg_205_1.time_ and arg_205_1.time_ < var_208_16 + var_208_26 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_16) / var_208_26

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_16 + var_208_26 and arg_205_1.time_ < var_208_16 + var_208_26 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play413081049 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 413081049
		arg_209_1.duration_ = 4.27

		local var_209_0 = {
			zh = 2.1,
			ja = 4.266
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
				arg_209_0:Play413081050(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["10094"]
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps10094 == nil then
				arg_209_1.var_.actorSpriteComps10094 = var_212_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_2 = 2

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 and not isNil(var_212_0) then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2

				if arg_209_1.var_.actorSpriteComps10094 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_212_1 then
							if arg_209_1.isInRecall_ then
								local var_212_4 = Mathf.Lerp(iter_212_1.color.r, arg_209_1.hightColor1.r, var_212_3)
								local var_212_5 = Mathf.Lerp(iter_212_1.color.g, arg_209_1.hightColor1.g, var_212_3)
								local var_212_6 = Mathf.Lerp(iter_212_1.color.b, arg_209_1.hightColor1.b, var_212_3)

								iter_212_1.color = Color.New(var_212_4, var_212_5, var_212_6)
							else
								local var_212_7 = Mathf.Lerp(iter_212_1.color.r, 1, var_212_3)

								iter_212_1.color = Color.New(var_212_7, var_212_7, var_212_7)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 and not isNil(var_212_0) and arg_209_1.var_.actorSpriteComps10094 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_212_3 then
						if arg_209_1.isInRecall_ then
							iter_212_3.color = arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_212_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps10094 = nil
			end

			local var_212_8 = arg_209_1.actors_["10022"]
			local var_212_9 = 0

			if var_212_9 < arg_209_1.time_ and arg_209_1.time_ <= var_212_9 + arg_212_0 and not isNil(var_212_8) and arg_209_1.var_.actorSpriteComps10022 == nil then
				arg_209_1.var_.actorSpriteComps10022 = var_212_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_10 = 2

			if var_212_9 <= arg_209_1.time_ and arg_209_1.time_ < var_212_9 + var_212_10 and not isNil(var_212_8) then
				local var_212_11 = (arg_209_1.time_ - var_212_9) / var_212_10

				if arg_209_1.var_.actorSpriteComps10022 then
					for iter_212_4, iter_212_5 in pairs(arg_209_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_212_5 then
							if arg_209_1.isInRecall_ then
								local var_212_12 = Mathf.Lerp(iter_212_5.color.r, arg_209_1.hightColor2.r, var_212_11)
								local var_212_13 = Mathf.Lerp(iter_212_5.color.g, arg_209_1.hightColor2.g, var_212_11)
								local var_212_14 = Mathf.Lerp(iter_212_5.color.b, arg_209_1.hightColor2.b, var_212_11)

								iter_212_5.color = Color.New(var_212_12, var_212_13, var_212_14)
							else
								local var_212_15 = Mathf.Lerp(iter_212_5.color.r, 0.5, var_212_11)

								iter_212_5.color = Color.New(var_212_15, var_212_15, var_212_15)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= var_212_9 + var_212_10 and arg_209_1.time_ < var_212_9 + var_212_10 + arg_212_0 and not isNil(var_212_8) and arg_209_1.var_.actorSpriteComps10022 then
				for iter_212_6, iter_212_7 in pairs(arg_209_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_212_7 then
						if arg_209_1.isInRecall_ then
							iter_212_7.color = arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_212_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_209_1.var_.actorSpriteComps10022 = nil
			end

			local var_212_16 = 0
			local var_212_17 = 0.25

			if var_212_16 < arg_209_1.time_ and arg_209_1.time_ <= var_212_16 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_18 = arg_209_1:FormatText(StoryNameCfg[259].name)

				arg_209_1.leftNameTxt_.text = var_212_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_19 = arg_209_1:GetWordFromCfg(413081049)
				local var_212_20 = arg_209_1:FormatText(var_212_19.content)

				arg_209_1.text_.text = var_212_20

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_21 = 10
				local var_212_22 = utf8.len(var_212_20)
				local var_212_23 = var_212_21 <= 0 and var_212_17 or var_212_17 * (var_212_22 / var_212_21)

				if var_212_23 > 0 and var_212_17 < var_212_23 then
					arg_209_1.talkMaxDuration = var_212_23

					if var_212_23 + var_212_16 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_23 + var_212_16
					end
				end

				arg_209_1.text_.text = var_212_20
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081049", "story_v_out_413081.awb") ~= 0 then
					local var_212_24 = manager.audio:GetVoiceLength("story_v_out_413081", "413081049", "story_v_out_413081.awb") / 1000

					if var_212_24 + var_212_16 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_24 + var_212_16
					end

					if var_212_19.prefab_name ~= "" and arg_209_1.actors_[var_212_19.prefab_name] ~= nil then
						local var_212_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_19.prefab_name].transform, "story_v_out_413081", "413081049", "story_v_out_413081.awb")

						arg_209_1:RecordAudio("413081049", var_212_25)
						arg_209_1:RecordAudio("413081049", var_212_25)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_413081", "413081049", "story_v_out_413081.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_413081", "413081049", "story_v_out_413081.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_26 = math.max(var_212_17, arg_209_1.talkMaxDuration)

			if var_212_16 <= arg_209_1.time_ and arg_209_1.time_ < var_212_16 + var_212_26 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_16) / var_212_26

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_16 + var_212_26 and arg_209_1.time_ < var_212_16 + var_212_26 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play413081050 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 413081050
		arg_213_1.duration_ = 11.37

		local var_213_0 = {
			zh = 8.833,
			ja = 11.366
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
				arg_213_0:Play413081051(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["10022"]
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.actorSpriteComps10022 == nil then
				arg_213_1.var_.actorSpriteComps10022 = var_216_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_2 = 2

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 and not isNil(var_216_0) then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2

				if arg_213_1.var_.actorSpriteComps10022 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_216_1 then
							if arg_213_1.isInRecall_ then
								local var_216_4 = Mathf.Lerp(iter_216_1.color.r, arg_213_1.hightColor1.r, var_216_3)
								local var_216_5 = Mathf.Lerp(iter_216_1.color.g, arg_213_1.hightColor1.g, var_216_3)
								local var_216_6 = Mathf.Lerp(iter_216_1.color.b, arg_213_1.hightColor1.b, var_216_3)

								iter_216_1.color = Color.New(var_216_4, var_216_5, var_216_6)
							else
								local var_216_7 = Mathf.Lerp(iter_216_1.color.r, 1, var_216_3)

								iter_216_1.color = Color.New(var_216_7, var_216_7, var_216_7)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 and not isNil(var_216_0) and arg_213_1.var_.actorSpriteComps10022 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_216_3 then
						if arg_213_1.isInRecall_ then
							iter_216_3.color = arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_216_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps10022 = nil
			end

			local var_216_8 = arg_213_1.actors_["10094"]
			local var_216_9 = 0

			if var_216_9 < arg_213_1.time_ and arg_213_1.time_ <= var_216_9 + arg_216_0 and not isNil(var_216_8) and arg_213_1.var_.actorSpriteComps10094 == nil then
				arg_213_1.var_.actorSpriteComps10094 = var_216_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_10 = 2

			if var_216_9 <= arg_213_1.time_ and arg_213_1.time_ < var_216_9 + var_216_10 and not isNil(var_216_8) then
				local var_216_11 = (arg_213_1.time_ - var_216_9) / var_216_10

				if arg_213_1.var_.actorSpriteComps10094 then
					for iter_216_4, iter_216_5 in pairs(arg_213_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_216_5 then
							if arg_213_1.isInRecall_ then
								local var_216_12 = Mathf.Lerp(iter_216_5.color.r, arg_213_1.hightColor2.r, var_216_11)
								local var_216_13 = Mathf.Lerp(iter_216_5.color.g, arg_213_1.hightColor2.g, var_216_11)
								local var_216_14 = Mathf.Lerp(iter_216_5.color.b, arg_213_1.hightColor2.b, var_216_11)

								iter_216_5.color = Color.New(var_216_12, var_216_13, var_216_14)
							else
								local var_216_15 = Mathf.Lerp(iter_216_5.color.r, 0.5, var_216_11)

								iter_216_5.color = Color.New(var_216_15, var_216_15, var_216_15)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= var_216_9 + var_216_10 and arg_213_1.time_ < var_216_9 + var_216_10 + arg_216_0 and not isNil(var_216_8) and arg_213_1.var_.actorSpriteComps10094 then
				for iter_216_6, iter_216_7 in pairs(arg_213_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_216_7 then
						if arg_213_1.isInRecall_ then
							iter_216_7.color = arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_216_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_213_1.var_.actorSpriteComps10094 = nil
			end

			local var_216_16 = 0
			local var_216_17 = 1.05

			if var_216_16 < arg_213_1.time_ and arg_213_1.time_ <= var_216_16 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_18 = arg_213_1:FormatText(StoryNameCfg[614].name)

				arg_213_1.leftNameTxt_.text = var_216_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_19 = arg_213_1:GetWordFromCfg(413081050)
				local var_216_20 = arg_213_1:FormatText(var_216_19.content)

				arg_213_1.text_.text = var_216_20

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_21 = 40
				local var_216_22 = utf8.len(var_216_20)
				local var_216_23 = var_216_21 <= 0 and var_216_17 or var_216_17 * (var_216_22 / var_216_21)

				if var_216_23 > 0 and var_216_17 < var_216_23 then
					arg_213_1.talkMaxDuration = var_216_23

					if var_216_23 + var_216_16 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_23 + var_216_16
					end
				end

				arg_213_1.text_.text = var_216_20
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081050", "story_v_out_413081.awb") ~= 0 then
					local var_216_24 = manager.audio:GetVoiceLength("story_v_out_413081", "413081050", "story_v_out_413081.awb") / 1000

					if var_216_24 + var_216_16 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_24 + var_216_16
					end

					if var_216_19.prefab_name ~= "" and arg_213_1.actors_[var_216_19.prefab_name] ~= nil then
						local var_216_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_19.prefab_name].transform, "story_v_out_413081", "413081050", "story_v_out_413081.awb")

						arg_213_1:RecordAudio("413081050", var_216_25)
						arg_213_1:RecordAudio("413081050", var_216_25)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_413081", "413081050", "story_v_out_413081.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_413081", "413081050", "story_v_out_413081.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_26 = math.max(var_216_17, arg_213_1.talkMaxDuration)

			if var_216_16 <= arg_213_1.time_ and arg_213_1.time_ < var_216_16 + var_216_26 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_16) / var_216_26

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_16 + var_216_26 and arg_213_1.time_ < var_216_16 + var_216_26 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play413081051 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 413081051
		arg_217_1.duration_ = 6.33

		local var_217_0 = {
			zh = 5.566,
			ja = 6.333
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
				arg_217_0:Play413081052(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["10022"]
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.actorSpriteComps10022 == nil then
				arg_217_1.var_.actorSpriteComps10022 = var_220_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_2 = 2

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 and not isNil(var_220_0) then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2

				if arg_217_1.var_.actorSpriteComps10022 then
					for iter_220_0, iter_220_1 in pairs(arg_217_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_220_1 then
							if arg_217_1.isInRecall_ then
								local var_220_4 = Mathf.Lerp(iter_220_1.color.r, arg_217_1.hightColor2.r, var_220_3)
								local var_220_5 = Mathf.Lerp(iter_220_1.color.g, arg_217_1.hightColor2.g, var_220_3)
								local var_220_6 = Mathf.Lerp(iter_220_1.color.b, arg_217_1.hightColor2.b, var_220_3)

								iter_220_1.color = Color.New(var_220_4, var_220_5, var_220_6)
							else
								local var_220_7 = Mathf.Lerp(iter_220_1.color.r, 0.5, var_220_3)

								iter_220_1.color = Color.New(var_220_7, var_220_7, var_220_7)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 and not isNil(var_220_0) and arg_217_1.var_.actorSpriteComps10022 then
				for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_220_3 then
						if arg_217_1.isInRecall_ then
							iter_220_3.color = arg_217_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_220_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_217_1.var_.actorSpriteComps10022 = nil
			end

			local var_220_8 = 0
			local var_220_9 = 0.45

			if var_220_8 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_10 = arg_217_1:FormatText(StoryNameCfg[993].name)

				arg_217_1.leftNameTxt_.text = var_220_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_11 = arg_217_1:GetWordFromCfg(413081051)
				local var_220_12 = arg_217_1:FormatText(var_220_11.content)

				arg_217_1.text_.text = var_220_12

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_13 = 18
				local var_220_14 = utf8.len(var_220_12)
				local var_220_15 = var_220_13 <= 0 and var_220_9 or var_220_9 * (var_220_14 / var_220_13)

				if var_220_15 > 0 and var_220_9 < var_220_15 then
					arg_217_1.talkMaxDuration = var_220_15

					if var_220_15 + var_220_8 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_15 + var_220_8
					end
				end

				arg_217_1.text_.text = var_220_12
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081051", "story_v_out_413081.awb") ~= 0 then
					local var_220_16 = manager.audio:GetVoiceLength("story_v_out_413081", "413081051", "story_v_out_413081.awb") / 1000

					if var_220_16 + var_220_8 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_16 + var_220_8
					end

					if var_220_11.prefab_name ~= "" and arg_217_1.actors_[var_220_11.prefab_name] ~= nil then
						local var_220_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_11.prefab_name].transform, "story_v_out_413081", "413081051", "story_v_out_413081.awb")

						arg_217_1:RecordAudio("413081051", var_220_17)
						arg_217_1:RecordAudio("413081051", var_220_17)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_413081", "413081051", "story_v_out_413081.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_413081", "413081051", "story_v_out_413081.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_18 = math.max(var_220_9, arg_217_1.talkMaxDuration)

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_18 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_8) / var_220_18

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_8 + var_220_18 and arg_217_1.time_ < var_220_8 + var_220_18 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play413081052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 413081052
		arg_221_1.duration_ = 6.47

		local var_221_0 = {
			zh = 5.933,
			ja = 6.466
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
				arg_221_0:Play413081053(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10022"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos10022 = var_224_0.localPosition
				var_224_0.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10022", 2)

				local var_224_2 = var_224_0.childCount

				for iter_224_0 = 0, var_224_2 - 1 do
					local var_224_3 = var_224_0:GetChild(iter_224_0)

					if var_224_3.name == "split_2" or not string.find(var_224_3.name, "split") then
						var_224_3.gameObject:SetActive(true)
					else
						var_224_3.gameObject:SetActive(false)
					end
				end
			end

			local var_224_4 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_4 then
				local var_224_5 = (arg_221_1.time_ - var_224_1) / var_224_4
				local var_224_6 = Vector3.New(-390, -315, -320)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10022, var_224_6, var_224_5)
			end

			if arg_221_1.time_ >= var_224_1 + var_224_4 and arg_221_1.time_ < var_224_1 + var_224_4 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_224_7 = arg_221_1.actors_["10022"]
			local var_224_8 = 0

			if var_224_8 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 and not isNil(var_224_7) and arg_221_1.var_.actorSpriteComps10022 == nil then
				arg_221_1.var_.actorSpriteComps10022 = var_224_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_9 = 2

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_9 and not isNil(var_224_7) then
				local var_224_10 = (arg_221_1.time_ - var_224_8) / var_224_9

				if arg_221_1.var_.actorSpriteComps10022 then
					for iter_224_1, iter_224_2 in pairs(arg_221_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_224_2 then
							if arg_221_1.isInRecall_ then
								local var_224_11 = Mathf.Lerp(iter_224_2.color.r, arg_221_1.hightColor1.r, var_224_10)
								local var_224_12 = Mathf.Lerp(iter_224_2.color.g, arg_221_1.hightColor1.g, var_224_10)
								local var_224_13 = Mathf.Lerp(iter_224_2.color.b, arg_221_1.hightColor1.b, var_224_10)

								iter_224_2.color = Color.New(var_224_11, var_224_12, var_224_13)
							else
								local var_224_14 = Mathf.Lerp(iter_224_2.color.r, 1, var_224_10)

								iter_224_2.color = Color.New(var_224_14, var_224_14, var_224_14)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= var_224_8 + var_224_9 and arg_221_1.time_ < var_224_8 + var_224_9 + arg_224_0 and not isNil(var_224_7) and arg_221_1.var_.actorSpriteComps10022 then
				for iter_224_3, iter_224_4 in pairs(arg_221_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_224_4 then
						if arg_221_1.isInRecall_ then
							iter_224_4.color = arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_224_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_221_1.var_.actorSpriteComps10022 = nil
			end

			local var_224_15 = 0
			local var_224_16 = 0.325

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_17 = arg_221_1:FormatText(StoryNameCfg[614].name)

				arg_221_1.leftNameTxt_.text = var_224_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_18 = arg_221_1:GetWordFromCfg(413081052)
				local var_224_19 = arg_221_1:FormatText(var_224_18.content)

				arg_221_1.text_.text = var_224_19

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_20 = 13
				local var_224_21 = utf8.len(var_224_19)
				local var_224_22 = var_224_20 <= 0 and var_224_16 or var_224_16 * (var_224_21 / var_224_20)

				if var_224_22 > 0 and var_224_16 < var_224_22 then
					arg_221_1.talkMaxDuration = var_224_22

					if var_224_22 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_22 + var_224_15
					end
				end

				arg_221_1.text_.text = var_224_19
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081052", "story_v_out_413081.awb") ~= 0 then
					local var_224_23 = manager.audio:GetVoiceLength("story_v_out_413081", "413081052", "story_v_out_413081.awb") / 1000

					if var_224_23 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_23 + var_224_15
					end

					if var_224_18.prefab_name ~= "" and arg_221_1.actors_[var_224_18.prefab_name] ~= nil then
						local var_224_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_18.prefab_name].transform, "story_v_out_413081", "413081052", "story_v_out_413081.awb")

						arg_221_1:RecordAudio("413081052", var_224_24)
						arg_221_1:RecordAudio("413081052", var_224_24)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_413081", "413081052", "story_v_out_413081.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_413081", "413081052", "story_v_out_413081.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_25 = math.max(var_224_16, arg_221_1.talkMaxDuration)

			if var_224_15 <= arg_221_1.time_ and arg_221_1.time_ < var_224_15 + var_224_25 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_15) / var_224_25

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_15 + var_224_25 and arg_221_1.time_ < var_224_15 + var_224_25 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play413081053 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 413081053
		arg_225_1.duration_ = 10.67

		local var_225_0 = {
			zh = 10.3666666666667,
			ja = 10.6666666666667
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
				arg_225_0:Play413081054(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 2

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				local var_228_1 = manager.ui.mainCamera.transform.localPosition
				local var_228_2 = Vector3.New(0, 0, 10) + Vector3.New(var_228_1.x, var_228_1.y, 0)
				local var_228_3 = arg_225_1.bgs_.F08m

				var_228_3.transform.localPosition = var_228_2
				var_228_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_228_4 = var_228_3:GetComponent("SpriteRenderer")

				if var_228_4 and var_228_4.sprite then
					local var_228_5 = (var_228_3.transform.localPosition - var_228_1).z
					local var_228_6 = manager.ui.mainCameraCom_
					local var_228_7 = 2 * var_228_5 * Mathf.Tan(var_228_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_228_8 = var_228_7 * var_228_6.aspect
					local var_228_9 = var_228_4.sprite.bounds.size.x
					local var_228_10 = var_228_4.sprite.bounds.size.y
					local var_228_11 = var_228_8 / var_228_9
					local var_228_12 = var_228_7 / var_228_10
					local var_228_13 = var_228_12 < var_228_11 and var_228_11 or var_228_12

					var_228_3.transform.localScale = Vector3.New(var_228_13, var_228_13, 0)
				end

				for iter_228_0, iter_228_1 in pairs(arg_225_1.bgs_) do
					if iter_228_0 ~= "F08m" then
						iter_228_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_228_14 = 4

			if var_228_14 < arg_225_1.time_ and arg_225_1.time_ <= var_228_14 + arg_228_0 then
				arg_225_1.allBtn_.enabled = false
			end

			local var_228_15 = 0.3

			if arg_225_1.time_ >= var_228_14 + var_228_15 and arg_225_1.time_ < var_228_14 + var_228_15 + arg_228_0 then
				arg_225_1.allBtn_.enabled = true
			end

			local var_228_16 = 0

			if var_228_16 < arg_225_1.time_ and arg_225_1.time_ <= var_228_16 + arg_228_0 then
				arg_225_1.mask_.enabled = true
				arg_225_1.mask_.raycastTarget = true

				arg_225_1:SetGaussion(false)
			end

			local var_228_17 = 2

			if var_228_16 <= arg_225_1.time_ and arg_225_1.time_ < var_228_16 + var_228_17 then
				local var_228_18 = (arg_225_1.time_ - var_228_16) / var_228_17
				local var_228_19 = Color.New(0, 0, 0)

				var_228_19.a = Mathf.Lerp(0, 1, var_228_18)
				arg_225_1.mask_.color = var_228_19
			end

			if arg_225_1.time_ >= var_228_16 + var_228_17 and arg_225_1.time_ < var_228_16 + var_228_17 + arg_228_0 then
				local var_228_20 = Color.New(0, 0, 0)

				var_228_20.a = 1
				arg_225_1.mask_.color = var_228_20
			end

			local var_228_21 = 2

			if var_228_21 < arg_225_1.time_ and arg_225_1.time_ <= var_228_21 + arg_228_0 then
				arg_225_1.mask_.enabled = true
				arg_225_1.mask_.raycastTarget = true

				arg_225_1:SetGaussion(false)
			end

			local var_228_22 = 2

			if var_228_21 <= arg_225_1.time_ and arg_225_1.time_ < var_228_21 + var_228_22 then
				local var_228_23 = (arg_225_1.time_ - var_228_21) / var_228_22
				local var_228_24 = Color.New(0, 0, 0)

				var_228_24.a = Mathf.Lerp(1, 0, var_228_23)
				arg_225_1.mask_.color = var_228_24
			end

			if arg_225_1.time_ >= var_228_21 + var_228_22 and arg_225_1.time_ < var_228_21 + var_228_22 + arg_228_0 then
				local var_228_25 = Color.New(0, 0, 0)
				local var_228_26 = 0

				arg_225_1.mask_.enabled = false
				var_228_25.a = var_228_26
				arg_225_1.mask_.color = var_228_25
			end

			local var_228_27 = arg_225_1.actors_["10022"].transform
			local var_228_28 = 1.966

			if var_228_28 < arg_225_1.time_ and arg_225_1.time_ <= var_228_28 + arg_228_0 then
				arg_225_1.var_.moveOldPos10022 = var_228_27.localPosition
				var_228_27.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10022", 0)

				local var_228_29 = var_228_27.childCount

				for iter_228_2 = 0, var_228_29 - 1 do
					local var_228_30 = var_228_27:GetChild(iter_228_2)

					if var_228_30.name == "" or not string.find(var_228_30.name, "split") then
						var_228_30.gameObject:SetActive(true)
					else
						var_228_30.gameObject:SetActive(false)
					end
				end
			end

			local var_228_31 = 0.001

			if var_228_28 <= arg_225_1.time_ and arg_225_1.time_ < var_228_28 + var_228_31 then
				local var_228_32 = (arg_225_1.time_ - var_228_28) / var_228_31
				local var_228_33 = Vector3.New(-5000, -315, -320)

				var_228_27.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10022, var_228_33, var_228_32)
			end

			if arg_225_1.time_ >= var_228_28 + var_228_31 and arg_225_1.time_ < var_228_28 + var_228_31 + arg_228_0 then
				var_228_27.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_228_34 = arg_225_1.actors_["10094"].transform
			local var_228_35 = 1.966

			if var_228_35 < arg_225_1.time_ and arg_225_1.time_ <= var_228_35 + arg_228_0 then
				arg_225_1.var_.moveOldPos10094 = var_228_34.localPosition
				var_228_34.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10094", 0)

				local var_228_36 = var_228_34.childCount

				for iter_228_3 = 0, var_228_36 - 1 do
					local var_228_37 = var_228_34:GetChild(iter_228_3)

					if var_228_37.name == "" or not string.find(var_228_37.name, "split") then
						var_228_37.gameObject:SetActive(true)
					else
						var_228_37.gameObject:SetActive(false)
					end
				end
			end

			local var_228_38 = 0.001

			if var_228_35 <= arg_225_1.time_ and arg_225_1.time_ < var_228_35 + var_228_38 then
				local var_228_39 = (arg_225_1.time_ - var_228_35) / var_228_38
				local var_228_40 = Vector3.New(-5000, -340, -414)

				var_228_34.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10094, var_228_40, var_228_39)
			end

			if arg_225_1.time_ >= var_228_35 + var_228_38 and arg_225_1.time_ < var_228_35 + var_228_38 + arg_228_0 then
				var_228_34.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_228_41 = arg_225_1.actors_["10022"]
			local var_228_42 = 1.966

			if var_228_42 < arg_225_1.time_ and arg_225_1.time_ <= var_228_42 + arg_228_0 and not isNil(var_228_41) and arg_225_1.var_.actorSpriteComps10022 == nil then
				arg_225_1.var_.actorSpriteComps10022 = var_228_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_43 = 0.034

			if var_228_42 <= arg_225_1.time_ and arg_225_1.time_ < var_228_42 + var_228_43 and not isNil(var_228_41) then
				local var_228_44 = (arg_225_1.time_ - var_228_42) / var_228_43

				if arg_225_1.var_.actorSpriteComps10022 then
					for iter_228_4, iter_228_5 in pairs(arg_225_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_228_5 then
							if arg_225_1.isInRecall_ then
								local var_228_45 = Mathf.Lerp(iter_228_5.color.r, arg_225_1.hightColor2.r, var_228_44)
								local var_228_46 = Mathf.Lerp(iter_228_5.color.g, arg_225_1.hightColor2.g, var_228_44)
								local var_228_47 = Mathf.Lerp(iter_228_5.color.b, arg_225_1.hightColor2.b, var_228_44)

								iter_228_5.color = Color.New(var_228_45, var_228_46, var_228_47)
							else
								local var_228_48 = Mathf.Lerp(iter_228_5.color.r, 0.5, var_228_44)

								iter_228_5.color = Color.New(var_228_48, var_228_48, var_228_48)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_42 + var_228_43 and arg_225_1.time_ < var_228_42 + var_228_43 + arg_228_0 and not isNil(var_228_41) and arg_225_1.var_.actorSpriteComps10022 then
				for iter_228_6, iter_228_7 in pairs(arg_225_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_228_7 then
						if arg_225_1.isInRecall_ then
							iter_228_7.color = arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_228_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10022 = nil
			end

			local var_228_49 = arg_225_1.actors_["10094"]
			local var_228_50 = 1.966

			if var_228_50 < arg_225_1.time_ and arg_225_1.time_ <= var_228_50 + arg_228_0 and not isNil(var_228_49) and arg_225_1.var_.actorSpriteComps10094 == nil then
				arg_225_1.var_.actorSpriteComps10094 = var_228_49:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_51 = 0.034

			if var_228_50 <= arg_225_1.time_ and arg_225_1.time_ < var_228_50 + var_228_51 and not isNil(var_228_49) then
				local var_228_52 = (arg_225_1.time_ - var_228_50) / var_228_51

				if arg_225_1.var_.actorSpriteComps10094 then
					for iter_228_8, iter_228_9 in pairs(arg_225_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_228_9 then
							if arg_225_1.isInRecall_ then
								local var_228_53 = Mathf.Lerp(iter_228_9.color.r, arg_225_1.hightColor2.r, var_228_52)
								local var_228_54 = Mathf.Lerp(iter_228_9.color.g, arg_225_1.hightColor2.g, var_228_52)
								local var_228_55 = Mathf.Lerp(iter_228_9.color.b, arg_225_1.hightColor2.b, var_228_52)

								iter_228_9.color = Color.New(var_228_53, var_228_54, var_228_55)
							else
								local var_228_56 = Mathf.Lerp(iter_228_9.color.r, 0.5, var_228_52)

								iter_228_9.color = Color.New(var_228_56, var_228_56, var_228_56)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_50 + var_228_51 and arg_225_1.time_ < var_228_50 + var_228_51 + arg_228_0 and not isNil(var_228_49) and arg_225_1.var_.actorSpriteComps10094 then
				for iter_228_10, iter_228_11 in pairs(arg_225_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_228_11 then
						if arg_225_1.isInRecall_ then
							iter_228_11.color = arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_228_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10094 = nil
			end

			local var_228_57 = arg_225_1.actors_["10092"].transform
			local var_228_58 = 3.73333333333333

			if var_228_58 < arg_225_1.time_ and arg_225_1.time_ <= var_228_58 + arg_228_0 then
				arg_225_1.var_.moveOldPos10092 = var_228_57.localPosition
				var_228_57.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10092", 3)

				local var_228_59 = var_228_57.childCount

				for iter_228_12 = 0, var_228_59 - 1 do
					local var_228_60 = var_228_57:GetChild(iter_228_12)

					if var_228_60.name == "split_1_1" or not string.find(var_228_60.name, "split") then
						var_228_60.gameObject:SetActive(true)
					else
						var_228_60.gameObject:SetActive(false)
					end
				end
			end

			local var_228_61 = 0.001

			if var_228_58 <= arg_225_1.time_ and arg_225_1.time_ < var_228_58 + var_228_61 then
				local var_228_62 = (arg_225_1.time_ - var_228_58) / var_228_61
				local var_228_63 = Vector3.New(0, -300, -295)

				var_228_57.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10092, var_228_63, var_228_62)
			end

			if arg_225_1.time_ >= var_228_58 + var_228_61 and arg_225_1.time_ < var_228_58 + var_228_61 + arg_228_0 then
				var_228_57.localPosition = Vector3.New(0, -300, -295)
			end

			local var_228_64 = arg_225_1.actors_["10092"]
			local var_228_65 = 3.73333333333333

			if var_228_65 < arg_225_1.time_ and arg_225_1.time_ <= var_228_65 + arg_228_0 and not isNil(var_228_64) and arg_225_1.var_.actorSpriteComps10092 == nil then
				arg_225_1.var_.actorSpriteComps10092 = var_228_64:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_66 = 0.2

			if var_228_65 <= arg_225_1.time_ and arg_225_1.time_ < var_228_65 + var_228_66 and not isNil(var_228_64) then
				local var_228_67 = (arg_225_1.time_ - var_228_65) / var_228_66

				if arg_225_1.var_.actorSpriteComps10092 then
					for iter_228_13, iter_228_14 in pairs(arg_225_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_228_14 then
							if arg_225_1.isInRecall_ then
								local var_228_68 = Mathf.Lerp(iter_228_14.color.r, arg_225_1.hightColor1.r, var_228_67)
								local var_228_69 = Mathf.Lerp(iter_228_14.color.g, arg_225_1.hightColor1.g, var_228_67)
								local var_228_70 = Mathf.Lerp(iter_228_14.color.b, arg_225_1.hightColor1.b, var_228_67)

								iter_228_14.color = Color.New(var_228_68, var_228_69, var_228_70)
							else
								local var_228_71 = Mathf.Lerp(iter_228_14.color.r, 1, var_228_67)

								iter_228_14.color = Color.New(var_228_71, var_228_71, var_228_71)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= var_228_65 + var_228_66 and arg_225_1.time_ < var_228_65 + var_228_66 + arg_228_0 and not isNil(var_228_64) and arg_225_1.var_.actorSpriteComps10092 then
				for iter_228_15, iter_228_16 in pairs(arg_225_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_228_16 then
						if arg_225_1.isInRecall_ then
							iter_228_16.color = arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_228_16.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_225_1.var_.actorSpriteComps10092 = nil
			end

			local var_228_72 = arg_225_1.actors_["10092"]
			local var_228_73 = 3.73333333333333

			if var_228_73 < arg_225_1.time_ and arg_225_1.time_ <= var_228_73 + arg_228_0 then
				local var_228_74 = var_228_72:GetComponentInChildren(typeof(CanvasGroup))

				if var_228_74 then
					arg_225_1.var_.alphaOldValue10092 = var_228_74.alpha
					arg_225_1.var_.characterEffect10092 = var_228_74
				end

				arg_225_1.var_.alphaOldValue10092 = 0
			end

			local var_228_75 = 0.2

			if var_228_73 <= arg_225_1.time_ and arg_225_1.time_ < var_228_73 + var_228_75 then
				local var_228_76 = (arg_225_1.time_ - var_228_73) / var_228_75
				local var_228_77 = Mathf.Lerp(arg_225_1.var_.alphaOldValue10092, 1, var_228_76)

				if arg_225_1.var_.characterEffect10092 then
					arg_225_1.var_.characterEffect10092.alpha = var_228_77
				end
			end

			if arg_225_1.time_ >= var_228_73 + var_228_75 and arg_225_1.time_ < var_228_73 + var_228_75 + arg_228_0 and arg_225_1.var_.characterEffect10092 then
				arg_225_1.var_.characterEffect10092.alpha = 1
			end

			if arg_225_1.frameCnt_ <= 1 then
				arg_225_1.dialog_:SetActive(false)
			end

			local var_228_78 = 4.06666666666667
			local var_228_79 = 0.725

			if var_228_78 < arg_225_1.time_ and arg_225_1.time_ <= var_228_78 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0

				arg_225_1.dialog_:SetActive(true)

				arg_225_1.dialogCg_.alpha = 0

				local var_228_80 = LeanTween.value(arg_225_1.dialog_, 0, 1, 0.3)

				var_228_80:setOnUpdate(LuaHelper.FloatAction(function(arg_229_0)
					arg_225_1.dialogCg_.alpha = arg_229_0
				end))
				var_228_80:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_225_1.dialog_)
					var_228_80:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_225_1.duration_ = arg_225_1.duration_ + 0.3

				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_81 = arg_225_1:FormatText(StoryNameCfg[996].name)

				arg_225_1.leftNameTxt_.text = var_228_81

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_82 = arg_225_1:GetWordFromCfg(413081053)
				local var_228_83 = arg_225_1:FormatText(var_228_82.content)

				arg_225_1.text_.text = var_228_83

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_84 = 29
				local var_228_85 = utf8.len(var_228_83)
				local var_228_86 = var_228_84 <= 0 and var_228_79 or var_228_79 * (var_228_85 / var_228_84)

				if var_228_86 > 0 and var_228_79 < var_228_86 then
					arg_225_1.talkMaxDuration = var_228_86
					var_228_78 = var_228_78 + 0.3

					if var_228_86 + var_228_78 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_86 + var_228_78
					end
				end

				arg_225_1.text_.text = var_228_83
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081053", "story_v_out_413081.awb") ~= 0 then
					local var_228_87 = manager.audio:GetVoiceLength("story_v_out_413081", "413081053", "story_v_out_413081.awb") / 1000

					if var_228_87 + var_228_78 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_87 + var_228_78
					end

					if var_228_82.prefab_name ~= "" and arg_225_1.actors_[var_228_82.prefab_name] ~= nil then
						local var_228_88 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_82.prefab_name].transform, "story_v_out_413081", "413081053", "story_v_out_413081.awb")

						arg_225_1:RecordAudio("413081053", var_228_88)
						arg_225_1:RecordAudio("413081053", var_228_88)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_413081", "413081053", "story_v_out_413081.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_413081", "413081053", "story_v_out_413081.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_89 = var_228_78 + 0.3
			local var_228_90 = math.max(var_228_79, arg_225_1.talkMaxDuration)

			if var_228_89 <= arg_225_1.time_ and arg_225_1.time_ < var_228_89 + var_228_90 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_89) / var_228_90

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_89 + var_228_90 and arg_225_1.time_ < var_228_89 + var_228_90 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play413081054 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 413081054
		arg_231_1.duration_ = 4.93

		local var_231_0 = {
			zh = 4.933,
			ja = 4.6
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play413081055(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["10092"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps10092 == nil then
				arg_231_1.var_.actorSpriteComps10092 = var_234_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_2 = 0.034

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.actorSpriteComps10092 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_234_1 then
							if arg_231_1.isInRecall_ then
								local var_234_4 = Mathf.Lerp(iter_234_1.color.r, arg_231_1.hightColor2.r, var_234_3)
								local var_234_5 = Mathf.Lerp(iter_234_1.color.g, arg_231_1.hightColor2.g, var_234_3)
								local var_234_6 = Mathf.Lerp(iter_234_1.color.b, arg_231_1.hightColor2.b, var_234_3)

								iter_234_1.color = Color.New(var_234_4, var_234_5, var_234_6)
							else
								local var_234_7 = Mathf.Lerp(iter_234_1.color.r, 0.5, var_234_3)

								iter_234_1.color = Color.New(var_234_7, var_234_7, var_234_7)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.actorSpriteComps10092 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_234_3 then
						if arg_231_1.isInRecall_ then
							iter_234_3.color = arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_234_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_231_1.var_.actorSpriteComps10092 = nil
			end

			local var_234_8 = 0
			local var_234_9 = 0.475

			if var_234_8 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_10 = arg_231_1:FormatText(StoryNameCfg[999].name)

				arg_231_1.leftNameTxt_.text = var_234_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_11 = arg_231_1:GetWordFromCfg(413081054)
				local var_234_12 = arg_231_1:FormatText(var_234_11.content)

				arg_231_1.text_.text = var_234_12

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_13 = 19
				local var_234_14 = utf8.len(var_234_12)
				local var_234_15 = var_234_13 <= 0 and var_234_9 or var_234_9 * (var_234_14 / var_234_13)

				if var_234_15 > 0 and var_234_9 < var_234_15 then
					arg_231_1.talkMaxDuration = var_234_15

					if var_234_15 + var_234_8 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_15 + var_234_8
					end
				end

				arg_231_1.text_.text = var_234_12
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081054", "story_v_out_413081.awb") ~= 0 then
					local var_234_16 = manager.audio:GetVoiceLength("story_v_out_413081", "413081054", "story_v_out_413081.awb") / 1000

					if var_234_16 + var_234_8 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_16 + var_234_8
					end

					if var_234_11.prefab_name ~= "" and arg_231_1.actors_[var_234_11.prefab_name] ~= nil then
						local var_234_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_11.prefab_name].transform, "story_v_out_413081", "413081054", "story_v_out_413081.awb")

						arg_231_1:RecordAudio("413081054", var_234_17)
						arg_231_1:RecordAudio("413081054", var_234_17)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_413081", "413081054", "story_v_out_413081.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_413081", "413081054", "story_v_out_413081.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_18 = math.max(var_234_9, arg_231_1.talkMaxDuration)

			if var_234_8 <= arg_231_1.time_ and arg_231_1.time_ < var_234_8 + var_234_18 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_8) / var_234_18

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_8 + var_234_18 and arg_231_1.time_ < var_234_8 + var_234_18 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play413081055 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 413081055
		arg_235_1.duration_ = 12.37

		local var_235_0 = {
			zh = 7.233,
			ja = 12.366
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play413081056(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 0.9

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_2 = arg_235_1:FormatText(StoryNameCfg[999].name)

				arg_235_1.leftNameTxt_.text = var_238_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_3 = arg_235_1:GetWordFromCfg(413081055)
				local var_238_4 = arg_235_1:FormatText(var_238_3.content)

				arg_235_1.text_.text = var_238_4

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 36
				local var_238_6 = utf8.len(var_238_4)
				local var_238_7 = var_238_5 <= 0 and var_238_1 or var_238_1 * (var_238_6 / var_238_5)

				if var_238_7 > 0 and var_238_1 < var_238_7 then
					arg_235_1.talkMaxDuration = var_238_7

					if var_238_7 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_7 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_4
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081055", "story_v_out_413081.awb") ~= 0 then
					local var_238_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081055", "story_v_out_413081.awb") / 1000

					if var_238_8 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_0
					end

					if var_238_3.prefab_name ~= "" and arg_235_1.actors_[var_238_3.prefab_name] ~= nil then
						local var_238_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_3.prefab_name].transform, "story_v_out_413081", "413081055", "story_v_out_413081.awb")

						arg_235_1:RecordAudio("413081055", var_238_9)
						arg_235_1:RecordAudio("413081055", var_238_9)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_413081", "413081055", "story_v_out_413081.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_413081", "413081055", "story_v_out_413081.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_10 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_10 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_10

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_10 and arg_235_1.time_ < var_238_0 + var_238_10 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play413081056 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 413081056
		arg_239_1.duration_ = 2.47

		local var_239_0 = {
			zh = 2.466,
			ja = 2.3
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play413081057(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["10092"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos10092 = var_242_0.localPosition
				var_242_0.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("10092", 3)

				local var_242_2 = var_242_0.childCount

				for iter_242_0 = 0, var_242_2 - 1 do
					local var_242_3 = var_242_0:GetChild(iter_242_0)

					if var_242_3.name == "" or not string.find(var_242_3.name, "split") then
						var_242_3.gameObject:SetActive(true)
					else
						var_242_3.gameObject:SetActive(false)
					end
				end
			end

			local var_242_4 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_4 then
				local var_242_5 = (arg_239_1.time_ - var_242_1) / var_242_4
				local var_242_6 = Vector3.New(0, -300, -295)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos10092, var_242_6, var_242_5)
			end

			if arg_239_1.time_ >= var_242_1 + var_242_4 and arg_239_1.time_ < var_242_1 + var_242_4 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_242_7 = arg_239_1.actors_["10092"]
			local var_242_8 = 0

			if var_242_8 < arg_239_1.time_ and arg_239_1.time_ <= var_242_8 + arg_242_0 and not isNil(var_242_7) and arg_239_1.var_.actorSpriteComps10092 == nil then
				arg_239_1.var_.actorSpriteComps10092 = var_242_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_9 = 2

			if var_242_8 <= arg_239_1.time_ and arg_239_1.time_ < var_242_8 + var_242_9 and not isNil(var_242_7) then
				local var_242_10 = (arg_239_1.time_ - var_242_8) / var_242_9

				if arg_239_1.var_.actorSpriteComps10092 then
					for iter_242_1, iter_242_2 in pairs(arg_239_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_242_2 then
							if arg_239_1.isInRecall_ then
								local var_242_11 = Mathf.Lerp(iter_242_2.color.r, arg_239_1.hightColor1.r, var_242_10)
								local var_242_12 = Mathf.Lerp(iter_242_2.color.g, arg_239_1.hightColor1.g, var_242_10)
								local var_242_13 = Mathf.Lerp(iter_242_2.color.b, arg_239_1.hightColor1.b, var_242_10)

								iter_242_2.color = Color.New(var_242_11, var_242_12, var_242_13)
							else
								local var_242_14 = Mathf.Lerp(iter_242_2.color.r, 1, var_242_10)

								iter_242_2.color = Color.New(var_242_14, var_242_14, var_242_14)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= var_242_8 + var_242_9 and arg_239_1.time_ < var_242_8 + var_242_9 + arg_242_0 and not isNil(var_242_7) and arg_239_1.var_.actorSpriteComps10092 then
				for iter_242_3, iter_242_4 in pairs(arg_239_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_242_4 then
						if arg_239_1.isInRecall_ then
							iter_242_4.color = arg_239_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_242_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_239_1.var_.actorSpriteComps10092 = nil
			end

			local var_242_15 = 0
			local var_242_16 = 0.25

			if var_242_15 < arg_239_1.time_ and arg_239_1.time_ <= var_242_15 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_17 = arg_239_1:FormatText(StoryNameCfg[996].name)

				arg_239_1.leftNameTxt_.text = var_242_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_18 = arg_239_1:GetWordFromCfg(413081056)
				local var_242_19 = arg_239_1:FormatText(var_242_18.content)

				arg_239_1.text_.text = var_242_19

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_20 = 10
				local var_242_21 = utf8.len(var_242_19)
				local var_242_22 = var_242_20 <= 0 and var_242_16 or var_242_16 * (var_242_21 / var_242_20)

				if var_242_22 > 0 and var_242_16 < var_242_22 then
					arg_239_1.talkMaxDuration = var_242_22

					if var_242_22 + var_242_15 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_22 + var_242_15
					end
				end

				arg_239_1.text_.text = var_242_19
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081056", "story_v_out_413081.awb") ~= 0 then
					local var_242_23 = manager.audio:GetVoiceLength("story_v_out_413081", "413081056", "story_v_out_413081.awb") / 1000

					if var_242_23 + var_242_15 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_23 + var_242_15
					end

					if var_242_18.prefab_name ~= "" and arg_239_1.actors_[var_242_18.prefab_name] ~= nil then
						local var_242_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_18.prefab_name].transform, "story_v_out_413081", "413081056", "story_v_out_413081.awb")

						arg_239_1:RecordAudio("413081056", var_242_24)
						arg_239_1:RecordAudio("413081056", var_242_24)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_413081", "413081056", "story_v_out_413081.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_413081", "413081056", "story_v_out_413081.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_25 = math.max(var_242_16, arg_239_1.talkMaxDuration)

			if var_242_15 <= arg_239_1.time_ and arg_239_1.time_ < var_242_15 + var_242_25 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_15) / var_242_25

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_15 + var_242_25 and arg_239_1.time_ < var_242_15 + var_242_25 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play413081057 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 413081057
		arg_243_1.duration_ = 11.4

		local var_243_0 = {
			zh = 5.433,
			ja = 11.4
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
				arg_243_0:Play413081058(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 0.7

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_2 = arg_243_1:FormatText(StoryNameCfg[996].name)

				arg_243_1.leftNameTxt_.text = var_246_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_3 = arg_243_1:GetWordFromCfg(413081057)
				local var_246_4 = arg_243_1:FormatText(var_246_3.content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 28
				local var_246_6 = utf8.len(var_246_4)
				local var_246_7 = var_246_5 <= 0 and var_246_1 or var_246_1 * (var_246_6 / var_246_5)

				if var_246_7 > 0 and var_246_1 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_4
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081057", "story_v_out_413081.awb") ~= 0 then
					local var_246_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081057", "story_v_out_413081.awb") / 1000

					if var_246_8 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_8 + var_246_0
					end

					if var_246_3.prefab_name ~= "" and arg_243_1.actors_[var_246_3.prefab_name] ~= nil then
						local var_246_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_3.prefab_name].transform, "story_v_out_413081", "413081057", "story_v_out_413081.awb")

						arg_243_1:RecordAudio("413081057", var_246_9)
						arg_243_1:RecordAudio("413081057", var_246_9)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_413081", "413081057", "story_v_out_413081.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_413081", "413081057", "story_v_out_413081.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_10 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_10 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_10

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_10 and arg_243_1.time_ < var_246_0 + var_246_10 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play413081058 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 413081058
		arg_247_1.duration_ = 3.73

		local var_247_0 = {
			zh = 3.733,
			ja = 3.3
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
				arg_247_0:Play413081059(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["10092"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps10092 == nil then
				arg_247_1.var_.actorSpriteComps10092 = var_250_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_2 = 2

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.actorSpriteComps10092 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_250_1 then
							if arg_247_1.isInRecall_ then
								local var_250_4 = Mathf.Lerp(iter_250_1.color.r, arg_247_1.hightColor2.r, var_250_3)
								local var_250_5 = Mathf.Lerp(iter_250_1.color.g, arg_247_1.hightColor2.g, var_250_3)
								local var_250_6 = Mathf.Lerp(iter_250_1.color.b, arg_247_1.hightColor2.b, var_250_3)

								iter_250_1.color = Color.New(var_250_4, var_250_5, var_250_6)
							else
								local var_250_7 = Mathf.Lerp(iter_250_1.color.r, 0.5, var_250_3)

								iter_250_1.color = Color.New(var_250_7, var_250_7, var_250_7)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.actorSpriteComps10092 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_250_3 then
						if arg_247_1.isInRecall_ then
							iter_250_3.color = arg_247_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_250_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_247_1.var_.actorSpriteComps10092 = nil
			end

			local var_250_8 = 0
			local var_250_9 = 0.325

			if var_250_8 < arg_247_1.time_ and arg_247_1.time_ <= var_250_8 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_10 = arg_247_1:FormatText(StoryNameCfg[999].name)

				arg_247_1.leftNameTxt_.text = var_250_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_11 = arg_247_1:GetWordFromCfg(413081058)
				local var_250_12 = arg_247_1:FormatText(var_250_11.content)

				arg_247_1.text_.text = var_250_12

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_13 = 13
				local var_250_14 = utf8.len(var_250_12)
				local var_250_15 = var_250_13 <= 0 and var_250_9 or var_250_9 * (var_250_14 / var_250_13)

				if var_250_15 > 0 and var_250_9 < var_250_15 then
					arg_247_1.talkMaxDuration = var_250_15

					if var_250_15 + var_250_8 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_15 + var_250_8
					end
				end

				arg_247_1.text_.text = var_250_12
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081058", "story_v_out_413081.awb") ~= 0 then
					local var_250_16 = manager.audio:GetVoiceLength("story_v_out_413081", "413081058", "story_v_out_413081.awb") / 1000

					if var_250_16 + var_250_8 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_16 + var_250_8
					end

					if var_250_11.prefab_name ~= "" and arg_247_1.actors_[var_250_11.prefab_name] ~= nil then
						local var_250_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_11.prefab_name].transform, "story_v_out_413081", "413081058", "story_v_out_413081.awb")

						arg_247_1:RecordAudio("413081058", var_250_17)
						arg_247_1:RecordAudio("413081058", var_250_17)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_413081", "413081058", "story_v_out_413081.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_413081", "413081058", "story_v_out_413081.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_18 = math.max(var_250_9, arg_247_1.talkMaxDuration)

			if var_250_8 <= arg_247_1.time_ and arg_247_1.time_ < var_250_8 + var_250_18 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_8) / var_250_18

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_8 + var_250_18 and arg_247_1.time_ < var_250_8 + var_250_18 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play413081059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 413081059
		arg_251_1.duration_ = 2.87

		local var_251_0 = {
			zh = 2.86666666666667,
			ja = 2.53266666666667
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
				arg_251_0:Play413081060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10092"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos10092 = var_254_0.localPosition
				var_254_0.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("10092", 3)

				local var_254_2 = var_254_0.childCount

				for iter_254_0 = 0, var_254_2 - 1 do
					local var_254_3 = var_254_0:GetChild(iter_254_0)

					if var_254_3.name == "split_5" or not string.find(var_254_3.name, "split") then
						var_254_3.gameObject:SetActive(true)
					else
						var_254_3.gameObject:SetActive(false)
					end
				end
			end

			local var_254_4 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_4 then
				local var_254_5 = (arg_251_1.time_ - var_254_1) / var_254_4
				local var_254_6 = Vector3.New(0, -300, -295)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10092, var_254_6, var_254_5)
			end

			if arg_251_1.time_ >= var_254_1 + var_254_4 and arg_251_1.time_ < var_254_1 + var_254_4 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_254_7 = arg_251_1.actors_["10092"]
			local var_254_8 = 0

			if var_254_8 < arg_251_1.time_ and arg_251_1.time_ <= var_254_8 + arg_254_0 and not isNil(var_254_7) and arg_251_1.var_.actorSpriteComps10092 == nil then
				arg_251_1.var_.actorSpriteComps10092 = var_254_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_9 = 2

			if var_254_8 <= arg_251_1.time_ and arg_251_1.time_ < var_254_8 + var_254_9 and not isNil(var_254_7) then
				local var_254_10 = (arg_251_1.time_ - var_254_8) / var_254_9

				if arg_251_1.var_.actorSpriteComps10092 then
					for iter_254_1, iter_254_2 in pairs(arg_251_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_254_2 then
							if arg_251_1.isInRecall_ then
								local var_254_11 = Mathf.Lerp(iter_254_2.color.r, arg_251_1.hightColor1.r, var_254_10)
								local var_254_12 = Mathf.Lerp(iter_254_2.color.g, arg_251_1.hightColor1.g, var_254_10)
								local var_254_13 = Mathf.Lerp(iter_254_2.color.b, arg_251_1.hightColor1.b, var_254_10)

								iter_254_2.color = Color.New(var_254_11, var_254_12, var_254_13)
							else
								local var_254_14 = Mathf.Lerp(iter_254_2.color.r, 1, var_254_10)

								iter_254_2.color = Color.New(var_254_14, var_254_14, var_254_14)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= var_254_8 + var_254_9 and arg_251_1.time_ < var_254_8 + var_254_9 + arg_254_0 and not isNil(var_254_7) and arg_251_1.var_.actorSpriteComps10092 then
				for iter_254_3, iter_254_4 in pairs(arg_251_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_254_4 then
						if arg_251_1.isInRecall_ then
							iter_254_4.color = arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_254_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_251_1.var_.actorSpriteComps10092 = nil
			end

			if arg_251_1.frameCnt_ <= 1 then
				arg_251_1.dialog_:SetActive(false)
			end

			local var_254_15 = 0.566666666666667
			local var_254_16 = 0.3

			if var_254_15 < arg_251_1.time_ and arg_251_1.time_ <= var_254_15 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0

				arg_251_1.dialog_:SetActive(true)

				arg_251_1.dialogCg_.alpha = 0

				local var_254_17 = LeanTween.value(arg_251_1.dialog_, 0, 1, 0.3)

				var_254_17:setOnUpdate(LuaHelper.FloatAction(function(arg_255_0)
					arg_251_1.dialogCg_.alpha = arg_255_0
				end))
				var_254_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_251_1.dialog_)
					var_254_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_251_1.duration_ = arg_251_1.duration_ + 0.3

				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_18 = arg_251_1:FormatText(StoryNameCfg[996].name)

				arg_251_1.leftNameTxt_.text = var_254_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_19 = arg_251_1:GetWordFromCfg(413081059)
				local var_254_20 = arg_251_1:FormatText(var_254_19.content)

				arg_251_1.text_.text = var_254_20

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_21 = 12
				local var_254_22 = utf8.len(var_254_20)
				local var_254_23 = var_254_21 <= 0 and var_254_16 or var_254_16 * (var_254_22 / var_254_21)

				if var_254_23 > 0 and var_254_16 < var_254_23 then
					arg_251_1.talkMaxDuration = var_254_23
					var_254_15 = var_254_15 + 0.3

					if var_254_23 + var_254_15 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_23 + var_254_15
					end
				end

				arg_251_1.text_.text = var_254_20
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081059", "story_v_out_413081.awb") ~= 0 then
					local var_254_24 = manager.audio:GetVoiceLength("story_v_out_413081", "413081059", "story_v_out_413081.awb") / 1000

					if var_254_24 + var_254_15 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_24 + var_254_15
					end

					if var_254_19.prefab_name ~= "" and arg_251_1.actors_[var_254_19.prefab_name] ~= nil then
						local var_254_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_19.prefab_name].transform, "story_v_out_413081", "413081059", "story_v_out_413081.awb")

						arg_251_1:RecordAudio("413081059", var_254_25)
						arg_251_1:RecordAudio("413081059", var_254_25)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_413081", "413081059", "story_v_out_413081.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_413081", "413081059", "story_v_out_413081.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_26 = var_254_15 + 0.3
			local var_254_27 = math.max(var_254_16, arg_251_1.talkMaxDuration)

			if var_254_26 <= arg_251_1.time_ and arg_251_1.time_ < var_254_26 + var_254_27 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_26) / var_254_27

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_26 + var_254_27 and arg_251_1.time_ < var_254_26 + var_254_27 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play413081060 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 413081060
		arg_257_1.duration_ = 3.57

		local var_257_0 = {
			zh = 3.566,
			ja = 3.466
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play413081061(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["10092"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps10092 == nil then
				arg_257_1.var_.actorSpriteComps10092 = var_260_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_2 = 2

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.actorSpriteComps10092 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_260_1 then
							if arg_257_1.isInRecall_ then
								local var_260_4 = Mathf.Lerp(iter_260_1.color.r, arg_257_1.hightColor2.r, var_260_3)
								local var_260_5 = Mathf.Lerp(iter_260_1.color.g, arg_257_1.hightColor2.g, var_260_3)
								local var_260_6 = Mathf.Lerp(iter_260_1.color.b, arg_257_1.hightColor2.b, var_260_3)

								iter_260_1.color = Color.New(var_260_4, var_260_5, var_260_6)
							else
								local var_260_7 = Mathf.Lerp(iter_260_1.color.r, 0.5, var_260_3)

								iter_260_1.color = Color.New(var_260_7, var_260_7, var_260_7)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.actorSpriteComps10092 then
				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_260_3 then
						if arg_257_1.isInRecall_ then
							iter_260_3.color = arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_260_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_257_1.var_.actorSpriteComps10092 = nil
			end

			local var_260_8 = 0
			local var_260_9 = 0.25

			if var_260_8 < arg_257_1.time_ and arg_257_1.time_ <= var_260_8 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_10 = arg_257_1:FormatText(StoryNameCfg[999].name)

				arg_257_1.leftNameTxt_.text = var_260_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_11 = arg_257_1:GetWordFromCfg(413081060)
				local var_260_12 = arg_257_1:FormatText(var_260_11.content)

				arg_257_1.text_.text = var_260_12

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_13 = 10
				local var_260_14 = utf8.len(var_260_12)
				local var_260_15 = var_260_13 <= 0 and var_260_9 or var_260_9 * (var_260_14 / var_260_13)

				if var_260_15 > 0 and var_260_9 < var_260_15 then
					arg_257_1.talkMaxDuration = var_260_15

					if var_260_15 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_15 + var_260_8
					end
				end

				arg_257_1.text_.text = var_260_12
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081060", "story_v_out_413081.awb") ~= 0 then
					local var_260_16 = manager.audio:GetVoiceLength("story_v_out_413081", "413081060", "story_v_out_413081.awb") / 1000

					if var_260_16 + var_260_8 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_16 + var_260_8
					end

					if var_260_11.prefab_name ~= "" and arg_257_1.actors_[var_260_11.prefab_name] ~= nil then
						local var_260_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_11.prefab_name].transform, "story_v_out_413081", "413081060", "story_v_out_413081.awb")

						arg_257_1:RecordAudio("413081060", var_260_17)
						arg_257_1:RecordAudio("413081060", var_260_17)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_413081", "413081060", "story_v_out_413081.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_413081", "413081060", "story_v_out_413081.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_18 = math.max(var_260_9, arg_257_1.talkMaxDuration)

			if var_260_8 <= arg_257_1.time_ and arg_257_1.time_ < var_260_8 + var_260_18 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_8) / var_260_18

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_8 + var_260_18 and arg_257_1.time_ < var_260_8 + var_260_18 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play413081061 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 413081061
		arg_261_1.duration_ = 8.33

		local var_261_0 = {
			zh = 2.933,
			ja = 8.333
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
				arg_261_0:Play413081062(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["10092"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos10092 = var_264_0.localPosition
				var_264_0.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("10092", 3)

				local var_264_2 = var_264_0.childCount

				for iter_264_0 = 0, var_264_2 - 1 do
					local var_264_3 = var_264_0:GetChild(iter_264_0)

					if var_264_3.name == "split_8" or not string.find(var_264_3.name, "split") then
						var_264_3.gameObject:SetActive(true)
					else
						var_264_3.gameObject:SetActive(false)
					end
				end
			end

			local var_264_4 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_4 then
				local var_264_5 = (arg_261_1.time_ - var_264_1) / var_264_4
				local var_264_6 = Vector3.New(0, -300, -295)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10092, var_264_6, var_264_5)
			end

			if arg_261_1.time_ >= var_264_1 + var_264_4 and arg_261_1.time_ < var_264_1 + var_264_4 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_264_7 = arg_261_1.actors_["10092"]
			local var_264_8 = 0

			if var_264_8 < arg_261_1.time_ and arg_261_1.time_ <= var_264_8 + arg_264_0 and not isNil(var_264_7) and arg_261_1.var_.actorSpriteComps10092 == nil then
				arg_261_1.var_.actorSpriteComps10092 = var_264_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_9 = 2

			if var_264_8 <= arg_261_1.time_ and arg_261_1.time_ < var_264_8 + var_264_9 and not isNil(var_264_7) then
				local var_264_10 = (arg_261_1.time_ - var_264_8) / var_264_9

				if arg_261_1.var_.actorSpriteComps10092 then
					for iter_264_1, iter_264_2 in pairs(arg_261_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_264_2 then
							if arg_261_1.isInRecall_ then
								local var_264_11 = Mathf.Lerp(iter_264_2.color.r, arg_261_1.hightColor1.r, var_264_10)
								local var_264_12 = Mathf.Lerp(iter_264_2.color.g, arg_261_1.hightColor1.g, var_264_10)
								local var_264_13 = Mathf.Lerp(iter_264_2.color.b, arg_261_1.hightColor1.b, var_264_10)

								iter_264_2.color = Color.New(var_264_11, var_264_12, var_264_13)
							else
								local var_264_14 = Mathf.Lerp(iter_264_2.color.r, 1, var_264_10)

								iter_264_2.color = Color.New(var_264_14, var_264_14, var_264_14)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= var_264_8 + var_264_9 and arg_261_1.time_ < var_264_8 + var_264_9 + arg_264_0 and not isNil(var_264_7) and arg_261_1.var_.actorSpriteComps10092 then
				for iter_264_3, iter_264_4 in pairs(arg_261_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_264_4 then
						if arg_261_1.isInRecall_ then
							iter_264_4.color = arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_264_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_261_1.var_.actorSpriteComps10092 = nil
			end

			local var_264_15 = 0
			local var_264_16 = 0.25

			if var_264_15 < arg_261_1.time_ and arg_261_1.time_ <= var_264_15 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_17 = arg_261_1:FormatText(StoryNameCfg[996].name)

				arg_261_1.leftNameTxt_.text = var_264_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_18 = arg_261_1:GetWordFromCfg(413081061)
				local var_264_19 = arg_261_1:FormatText(var_264_18.content)

				arg_261_1.text_.text = var_264_19

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_20 = 10
				local var_264_21 = utf8.len(var_264_19)
				local var_264_22 = var_264_20 <= 0 and var_264_16 or var_264_16 * (var_264_21 / var_264_20)

				if var_264_22 > 0 and var_264_16 < var_264_22 then
					arg_261_1.talkMaxDuration = var_264_22

					if var_264_22 + var_264_15 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_22 + var_264_15
					end
				end

				arg_261_1.text_.text = var_264_19
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081061", "story_v_out_413081.awb") ~= 0 then
					local var_264_23 = manager.audio:GetVoiceLength("story_v_out_413081", "413081061", "story_v_out_413081.awb") / 1000

					if var_264_23 + var_264_15 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_23 + var_264_15
					end

					if var_264_18.prefab_name ~= "" and arg_261_1.actors_[var_264_18.prefab_name] ~= nil then
						local var_264_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_18.prefab_name].transform, "story_v_out_413081", "413081061", "story_v_out_413081.awb")

						arg_261_1:RecordAudio("413081061", var_264_24)
						arg_261_1:RecordAudio("413081061", var_264_24)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_413081", "413081061", "story_v_out_413081.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_413081", "413081061", "story_v_out_413081.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_25 = math.max(var_264_16, arg_261_1.talkMaxDuration)

			if var_264_15 <= arg_261_1.time_ and arg_261_1.time_ < var_264_15 + var_264_25 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_15) / var_264_25

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_15 + var_264_25 and arg_261_1.time_ < var_264_15 + var_264_25 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_261_1:InitPlayNodeList()
	end,
	Play413081062 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 413081062
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play413081063(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["10092"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos10092 = var_268_0.localPosition
				var_268_0.localScale = Vector3.New(1, 1, 1)

				arg_265_1:CheckSpriteTmpPos("10092", 7)

				local var_268_2 = var_268_0.childCount

				for iter_268_0 = 0, var_268_2 - 1 do
					local var_268_3 = var_268_0:GetChild(iter_268_0)

					if var_268_3.name == "" or not string.find(var_268_3.name, "split") then
						var_268_3.gameObject:SetActive(true)
					else
						var_268_3.gameObject:SetActive(false)
					end
				end
			end

			local var_268_4 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_4 then
				local var_268_5 = (arg_265_1.time_ - var_268_1) / var_268_4
				local var_268_6 = Vector3.New(0, -2000, -180)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10092, var_268_6, var_268_5)
			end

			if arg_265_1.time_ >= var_268_1 + var_268_4 and arg_265_1.time_ < var_268_1 + var_268_4 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_268_7 = arg_265_1.actors_["10092"]
			local var_268_8 = 0

			if var_268_8 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 and not isNil(var_268_7) and arg_265_1.var_.actorSpriteComps10092 == nil then
				arg_265_1.var_.actorSpriteComps10092 = var_268_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_9 = 2

			if var_268_8 <= arg_265_1.time_ and arg_265_1.time_ < var_268_8 + var_268_9 and not isNil(var_268_7) then
				local var_268_10 = (arg_265_1.time_ - var_268_8) / var_268_9

				if arg_265_1.var_.actorSpriteComps10092 then
					for iter_268_1, iter_268_2 in pairs(arg_265_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_268_2 then
							if arg_265_1.isInRecall_ then
								local var_268_11 = Mathf.Lerp(iter_268_2.color.r, arg_265_1.hightColor2.r, var_268_10)
								local var_268_12 = Mathf.Lerp(iter_268_2.color.g, arg_265_1.hightColor2.g, var_268_10)
								local var_268_13 = Mathf.Lerp(iter_268_2.color.b, arg_265_1.hightColor2.b, var_268_10)

								iter_268_2.color = Color.New(var_268_11, var_268_12, var_268_13)
							else
								local var_268_14 = Mathf.Lerp(iter_268_2.color.r, 0.5, var_268_10)

								iter_268_2.color = Color.New(var_268_14, var_268_14, var_268_14)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= var_268_8 + var_268_9 and arg_265_1.time_ < var_268_8 + var_268_9 + arg_268_0 and not isNil(var_268_7) and arg_265_1.var_.actorSpriteComps10092 then
				for iter_268_3, iter_268_4 in pairs(arg_265_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_268_4 then
						if arg_265_1.isInRecall_ then
							iter_268_4.color = arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_268_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_265_1.var_.actorSpriteComps10092 = nil
			end

			local var_268_15 = 0
			local var_268_16 = 1.425

			if var_268_15 < arg_265_1.time_ and arg_265_1.time_ <= var_268_15 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_17 = arg_265_1:GetWordFromCfg(413081062)
				local var_268_18 = arg_265_1:FormatText(var_268_17.content)

				arg_265_1.text_.text = var_268_18

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_19 = 57
				local var_268_20 = utf8.len(var_268_18)
				local var_268_21 = var_268_19 <= 0 and var_268_16 or var_268_16 * (var_268_20 / var_268_19)

				if var_268_21 > 0 and var_268_16 < var_268_21 then
					arg_265_1.talkMaxDuration = var_268_21

					if var_268_21 + var_268_15 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_21 + var_268_15
					end
				end

				arg_265_1.text_.text = var_268_18
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_22 = math.max(var_268_16, arg_265_1.talkMaxDuration)

			if var_268_15 <= arg_265_1.time_ and arg_265_1.time_ < var_268_15 + var_268_22 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_15) / var_268_22

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_15 + var_268_22 and arg_265_1.time_ < var_268_15 + var_268_22 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play413081063 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 413081063
		arg_269_1.duration_ = 7.4

		local var_269_0 = {
			zh = 2.533,
			ja = 7.4
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
				arg_269_0:Play413081064(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0
			local var_272_1 = 0.3

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_2 = arg_269_1:FormatText(StoryNameCfg[996].name)

				arg_269_1.leftNameTxt_.text = var_272_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_5")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_3 = arg_269_1:GetWordFromCfg(413081063)
				local var_272_4 = arg_269_1:FormatText(var_272_3.content)

				arg_269_1.text_.text = var_272_4

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 12
				local var_272_6 = utf8.len(var_272_4)
				local var_272_7 = var_272_5 <= 0 and var_272_1 or var_272_1 * (var_272_6 / var_272_5)

				if var_272_7 > 0 and var_272_1 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_4
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081063", "story_v_out_413081.awb") ~= 0 then
					local var_272_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081063", "story_v_out_413081.awb") / 1000

					if var_272_8 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_0
					end

					if var_272_3.prefab_name ~= "" and arg_269_1.actors_[var_272_3.prefab_name] ~= nil then
						local var_272_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_3.prefab_name].transform, "story_v_out_413081", "413081063", "story_v_out_413081.awb")

						arg_269_1:RecordAudio("413081063", var_272_9)
						arg_269_1:RecordAudio("413081063", var_272_9)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_413081", "413081063", "story_v_out_413081.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_413081", "413081063", "story_v_out_413081.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_10 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_10 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_10

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_10 and arg_269_1.time_ < var_272_0 + var_272_10 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play413081064 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 413081064
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play413081065(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["10092"].transform
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.var_.moveOldPos10092 = var_276_0.localPosition
				var_276_0.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("10092", 7)

				local var_276_2 = var_276_0.childCount

				for iter_276_0 = 0, var_276_2 - 1 do
					local var_276_3 = var_276_0:GetChild(iter_276_0)

					if var_276_3.name == "" or not string.find(var_276_3.name, "split") then
						var_276_3.gameObject:SetActive(true)
					else
						var_276_3.gameObject:SetActive(false)
					end
				end
			end

			local var_276_4 = 0.001

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_4 then
				local var_276_5 = (arg_273_1.time_ - var_276_1) / var_276_4
				local var_276_6 = Vector3.New(0, -2000, -180)

				var_276_0.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10092, var_276_6, var_276_5)
			end

			if arg_273_1.time_ >= var_276_1 + var_276_4 and arg_273_1.time_ < var_276_1 + var_276_4 + arg_276_0 then
				var_276_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_276_7 = arg_273_1.actors_["10092"]
			local var_276_8 = 0

			if var_276_8 < arg_273_1.time_ and arg_273_1.time_ <= var_276_8 + arg_276_0 and not isNil(var_276_7) and arg_273_1.var_.actorSpriteComps10092 == nil then
				arg_273_1.var_.actorSpriteComps10092 = var_276_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_9 = 2

			if var_276_8 <= arg_273_1.time_ and arg_273_1.time_ < var_276_8 + var_276_9 and not isNil(var_276_7) then
				local var_276_10 = (arg_273_1.time_ - var_276_8) / var_276_9

				if arg_273_1.var_.actorSpriteComps10092 then
					for iter_276_1, iter_276_2 in pairs(arg_273_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_276_2 then
							if arg_273_1.isInRecall_ then
								local var_276_11 = Mathf.Lerp(iter_276_2.color.r, arg_273_1.hightColor2.r, var_276_10)
								local var_276_12 = Mathf.Lerp(iter_276_2.color.g, arg_273_1.hightColor2.g, var_276_10)
								local var_276_13 = Mathf.Lerp(iter_276_2.color.b, arg_273_1.hightColor2.b, var_276_10)

								iter_276_2.color = Color.New(var_276_11, var_276_12, var_276_13)
							else
								local var_276_14 = Mathf.Lerp(iter_276_2.color.r, 0.5, var_276_10)

								iter_276_2.color = Color.New(var_276_14, var_276_14, var_276_14)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= var_276_8 + var_276_9 and arg_273_1.time_ < var_276_8 + var_276_9 + arg_276_0 and not isNil(var_276_7) and arg_273_1.var_.actorSpriteComps10092 then
				for iter_276_3, iter_276_4 in pairs(arg_273_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_276_4 then
						if arg_273_1.isInRecall_ then
							iter_276_4.color = arg_273_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_276_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_273_1.var_.actorSpriteComps10092 = nil
			end

			local var_276_15 = 0
			local var_276_16 = 0.975

			if var_276_15 < arg_273_1.time_ and arg_273_1.time_ <= var_276_15 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_17 = arg_273_1:GetWordFromCfg(413081064)
				local var_276_18 = arg_273_1:FormatText(var_276_17.content)

				arg_273_1.text_.text = var_276_18

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_19 = 39
				local var_276_20 = utf8.len(var_276_18)
				local var_276_21 = var_276_19 <= 0 and var_276_16 or var_276_16 * (var_276_20 / var_276_19)

				if var_276_21 > 0 and var_276_16 < var_276_21 then
					arg_273_1.talkMaxDuration = var_276_21

					if var_276_21 + var_276_15 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_21 + var_276_15
					end
				end

				arg_273_1.text_.text = var_276_18
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_22 = math.max(var_276_16, arg_273_1.talkMaxDuration)

			if var_276_15 <= arg_273_1.time_ and arg_273_1.time_ < var_276_15 + var_276_22 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_15) / var_276_22

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_15 + var_276_22 and arg_273_1.time_ < var_276_15 + var_276_22 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play413081065 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 413081065
		arg_277_1.duration_ = 4.37

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play413081066(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.375

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_2 = arg_277_1:FormatText(StoryNameCfg[996].name)

				arg_277_1.leftNameTxt_.text = var_280_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_5")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_3 = arg_277_1:GetWordFromCfg(413081065)
				local var_280_4 = arg_277_1:FormatText(var_280_3.content)

				arg_277_1.text_.text = var_280_4

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 15
				local var_280_6 = utf8.len(var_280_4)
				local var_280_7 = var_280_5 <= 0 and var_280_1 or var_280_1 * (var_280_6 / var_280_5)

				if var_280_7 > 0 and var_280_1 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_4
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081065", "story_v_out_413081.awb") ~= 0 then
					local var_280_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081065", "story_v_out_413081.awb") / 1000

					if var_280_8 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_8 + var_280_0
					end

					if var_280_3.prefab_name ~= "" and arg_277_1.actors_[var_280_3.prefab_name] ~= nil then
						local var_280_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_3.prefab_name].transform, "story_v_out_413081", "413081065", "story_v_out_413081.awb")

						arg_277_1:RecordAudio("413081065", var_280_9)
						arg_277_1:RecordAudio("413081065", var_280_9)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_413081", "413081065", "story_v_out_413081.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_413081", "413081065", "story_v_out_413081.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_10 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_10 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_10

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_10 and arg_277_1.time_ < var_280_0 + var_280_10 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play413081066 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 413081066
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play413081067(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.5
			local var_284_1 = 1.14166666666667

			if var_284_0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_0 + arg_284_0 then
				local var_284_2 = "play"
				local var_284_3 = "effect"

				arg_281_1:AudioAction(var_284_2, var_284_3, "se_story_121_04", "se_story_121_04_blast", "")
			end

			local var_284_4 = 0
			local var_284_5 = 1.35

			if var_284_4 < arg_281_1.time_ and arg_281_1.time_ <= var_284_4 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_6 = arg_281_1:GetWordFromCfg(413081066)
				local var_284_7 = arg_281_1:FormatText(var_284_6.content)

				arg_281_1.text_.text = var_284_7

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_8 = 54
				local var_284_9 = utf8.len(var_284_7)
				local var_284_10 = var_284_8 <= 0 and var_284_5 or var_284_5 * (var_284_9 / var_284_8)

				if var_284_10 > 0 and var_284_5 < var_284_10 then
					arg_281_1.talkMaxDuration = var_284_10

					if var_284_10 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_4
					end
				end

				arg_281_1.text_.text = var_284_7
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_11 = math.max(var_284_5, arg_281_1.talkMaxDuration)

			if var_284_4 <= arg_281_1.time_ and arg_281_1.time_ < var_284_4 + var_284_11 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_4) / var_284_11

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_4 + var_284_11 and arg_281_1.time_ < var_284_4 + var_284_11 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play413081067 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 413081067
		arg_285_1.duration_ = 6.37

		local var_285_0 = {
			zh = 5.7,
			ja = 6.366
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
				arg_285_0:Play413081068(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = manager.ui.mainCamera.transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.shakeOldPos = var_288_0.localPosition
			end

			local var_288_2 = 0.6

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / 0.066
				local var_288_4, var_288_5 = math.modf(var_288_3)

				var_288_0.localPosition = Vector3.New(var_288_5 * 0.13, var_288_5 * 0.13, var_288_5 * 0.13) + arg_285_1.var_.shakeOldPos
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 then
				var_288_0.localPosition = arg_285_1.var_.shakeOldPos
			end

			local var_288_6 = 0

			if var_288_6 < arg_285_1.time_ and arg_285_1.time_ <= var_288_6 + arg_288_0 then
				arg_285_1.allBtn_.enabled = false
			end

			local var_288_7 = 0.6

			if arg_285_1.time_ >= var_288_6 + var_288_7 and arg_285_1.time_ < var_288_6 + var_288_7 + arg_288_0 then
				arg_285_1.allBtn_.enabled = true
			end

			local var_288_8 = 0
			local var_288_9 = 0.775

			if var_288_8 < arg_285_1.time_ and arg_285_1.time_ <= var_288_8 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				local var_288_10 = arg_285_1:FormatText(StoryNameCfg[998].name)

				arg_285_1.leftNameTxt_.text = var_288_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_11 = arg_285_1:GetWordFromCfg(413081067)
				local var_288_12 = arg_285_1:FormatText(var_288_11.content)

				arg_285_1.text_.text = var_288_12

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_13 = 31
				local var_288_14 = utf8.len(var_288_12)
				local var_288_15 = var_288_13 <= 0 and var_288_9 or var_288_9 * (var_288_14 / var_288_13)

				if var_288_15 > 0 and var_288_9 < var_288_15 then
					arg_285_1.talkMaxDuration = var_288_15

					if var_288_15 + var_288_8 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_15 + var_288_8
					end
				end

				arg_285_1.text_.text = var_288_12
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081067", "story_v_out_413081.awb") ~= 0 then
					local var_288_16 = manager.audio:GetVoiceLength("story_v_out_413081", "413081067", "story_v_out_413081.awb") / 1000

					if var_288_16 + var_288_8 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_16 + var_288_8
					end

					if var_288_11.prefab_name ~= "" and arg_285_1.actors_[var_288_11.prefab_name] ~= nil then
						local var_288_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_11.prefab_name].transform, "story_v_out_413081", "413081067", "story_v_out_413081.awb")

						arg_285_1:RecordAudio("413081067", var_288_17)
						arg_285_1:RecordAudio("413081067", var_288_17)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_413081", "413081067", "story_v_out_413081.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_413081", "413081067", "story_v_out_413081.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_18 = math.max(var_288_9, arg_285_1.talkMaxDuration)

			if var_288_8 <= arg_285_1.time_ and arg_285_1.time_ < var_288_8 + var_288_18 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_8) / var_288_18

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_8 + var_288_18 and arg_285_1.time_ < var_288_8 + var_288_18 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play413081068 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 413081068
		arg_289_1.duration_ = 4.5

		local var_289_0 = {
			zh = 2.7,
			ja = 4.5
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
				arg_289_0:Play413081069(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0
			local var_292_1 = 0.3

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_2 = arg_289_1:FormatText(StoryNameCfg[992].name)

				arg_289_1.leftNameTxt_.text = var_292_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_3 = arg_289_1:GetWordFromCfg(413081068)
				local var_292_4 = arg_289_1:FormatText(var_292_3.content)

				arg_289_1.text_.text = var_292_4

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 12
				local var_292_6 = utf8.len(var_292_4)
				local var_292_7 = var_292_5 <= 0 and var_292_1 or var_292_1 * (var_292_6 / var_292_5)

				if var_292_7 > 0 and var_292_1 < var_292_7 then
					arg_289_1.talkMaxDuration = var_292_7

					if var_292_7 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_7 + var_292_0
					end
				end

				arg_289_1.text_.text = var_292_4
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081068", "story_v_out_413081.awb") ~= 0 then
					local var_292_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081068", "story_v_out_413081.awb") / 1000

					if var_292_8 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_0
					end

					if var_292_3.prefab_name ~= "" and arg_289_1.actors_[var_292_3.prefab_name] ~= nil then
						local var_292_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_3.prefab_name].transform, "story_v_out_413081", "413081068", "story_v_out_413081.awb")

						arg_289_1:RecordAudio("413081068", var_292_9)
						arg_289_1:RecordAudio("413081068", var_292_9)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_413081", "413081068", "story_v_out_413081.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_413081", "413081068", "story_v_out_413081.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_10 = math.max(var_292_1, arg_289_1.talkMaxDuration)

			if var_292_0 <= arg_289_1.time_ and arg_289_1.time_ < var_292_0 + var_292_10 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_0) / var_292_10

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_0 + var_292_10 and arg_289_1.time_ < var_292_0 + var_292_10 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play413081069 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 413081069
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play413081070(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0
			local var_296_1 = 0.491666666666667

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				local var_296_2 = "play"
				local var_296_3 = "effect"

				arg_293_1:AudioAction(var_296_2, var_296_3, "se_story_122_01", "se_story_122_01_monsterattack02_loop", "")
			end

			local var_296_4 = 0
			local var_296_5 = 1.425

			if var_296_4 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_6 = arg_293_1:GetWordFromCfg(413081069)
				local var_296_7 = arg_293_1:FormatText(var_296_6.content)

				arg_293_1.text_.text = var_296_7

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_8 = 57
				local var_296_9 = utf8.len(var_296_7)
				local var_296_10 = var_296_8 <= 0 and var_296_5 or var_296_5 * (var_296_9 / var_296_8)

				if var_296_10 > 0 and var_296_5 < var_296_10 then
					arg_293_1.talkMaxDuration = var_296_10

					if var_296_10 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_10 + var_296_4
					end
				end

				arg_293_1.text_.text = var_296_7
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_11 = math.max(var_296_5, arg_293_1.talkMaxDuration)

			if var_296_4 <= arg_293_1.time_ and arg_293_1.time_ < var_296_4 + var_296_11 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_4) / var_296_11

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_4 + var_296_11 and arg_293_1.time_ < var_296_4 + var_296_11 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play413081070 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 413081070
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play413081071(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0
			local var_300_1 = 1.6

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, false)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_2 = arg_297_1:GetWordFromCfg(413081070)
				local var_300_3 = arg_297_1:FormatText(var_300_2.content)

				arg_297_1.text_.text = var_300_3

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_4 = 64
				local var_300_5 = utf8.len(var_300_3)
				local var_300_6 = var_300_4 <= 0 and var_300_1 or var_300_1 * (var_300_5 / var_300_4)

				if var_300_6 > 0 and var_300_1 < var_300_6 then
					arg_297_1.talkMaxDuration = var_300_6

					if var_300_6 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_6 + var_300_0
					end
				end

				arg_297_1.text_.text = var_300_3
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_7 = math.max(var_300_1, arg_297_1.talkMaxDuration)

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_7 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_0) / var_300_7

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_0 + var_300_7 and arg_297_1.time_ < var_300_0 + var_300_7 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play413081071 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 413081071
		arg_301_1.duration_ = 4.3

		local var_301_0 = {
			zh = 1.999999999999,
			ja = 4.3
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
				arg_301_0:Play413081072(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["10092"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos10092 = var_304_0.localPosition
				var_304_0.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("10092", 3)

				local var_304_2 = var_304_0.childCount

				for iter_304_0 = 0, var_304_2 - 1 do
					local var_304_3 = var_304_0:GetChild(iter_304_0)

					if var_304_3.name == "split_3" or not string.find(var_304_3.name, "split") then
						var_304_3.gameObject:SetActive(true)
					else
						var_304_3.gameObject:SetActive(false)
					end
				end
			end

			local var_304_4 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_4 then
				local var_304_5 = (arg_301_1.time_ - var_304_1) / var_304_4
				local var_304_6 = Vector3.New(0, -300, -295)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos10092, var_304_6, var_304_5)
			end

			if arg_301_1.time_ >= var_304_1 + var_304_4 and arg_301_1.time_ < var_304_1 + var_304_4 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_304_7 = arg_301_1.actors_["10092"]
			local var_304_8 = 0

			if var_304_8 < arg_301_1.time_ and arg_301_1.time_ <= var_304_8 + arg_304_0 and not isNil(var_304_7) and arg_301_1.var_.actorSpriteComps10092 == nil then
				arg_301_1.var_.actorSpriteComps10092 = var_304_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_9 = 2

			if var_304_8 <= arg_301_1.time_ and arg_301_1.time_ < var_304_8 + var_304_9 and not isNil(var_304_7) then
				local var_304_10 = (arg_301_1.time_ - var_304_8) / var_304_9

				if arg_301_1.var_.actorSpriteComps10092 then
					for iter_304_1, iter_304_2 in pairs(arg_301_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_304_2 then
							if arg_301_1.isInRecall_ then
								local var_304_11 = Mathf.Lerp(iter_304_2.color.r, arg_301_1.hightColor1.r, var_304_10)
								local var_304_12 = Mathf.Lerp(iter_304_2.color.g, arg_301_1.hightColor1.g, var_304_10)
								local var_304_13 = Mathf.Lerp(iter_304_2.color.b, arg_301_1.hightColor1.b, var_304_10)

								iter_304_2.color = Color.New(var_304_11, var_304_12, var_304_13)
							else
								local var_304_14 = Mathf.Lerp(iter_304_2.color.r, 1, var_304_10)

								iter_304_2.color = Color.New(var_304_14, var_304_14, var_304_14)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= var_304_8 + var_304_9 and arg_301_1.time_ < var_304_8 + var_304_9 + arg_304_0 and not isNil(var_304_7) and arg_301_1.var_.actorSpriteComps10092 then
				for iter_304_3, iter_304_4 in pairs(arg_301_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_304_4 then
						if arg_301_1.isInRecall_ then
							iter_304_4.color = arg_301_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_304_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_301_1.var_.actorSpriteComps10092 = nil
			end

			local var_304_15 = manager.ui.mainCamera.transform
			local var_304_16 = 0

			if var_304_16 < arg_301_1.time_ and arg_301_1.time_ <= var_304_16 + arg_304_0 then
				arg_301_1.var_.shakeOldPos = var_304_15.localPosition
			end

			local var_304_17 = 0.6

			if var_304_16 <= arg_301_1.time_ and arg_301_1.time_ < var_304_16 + var_304_17 then
				local var_304_18 = (arg_301_1.time_ - var_304_16) / 0.066
				local var_304_19, var_304_20 = math.modf(var_304_18)

				var_304_15.localPosition = Vector3.New(var_304_20 * 0.13, var_304_20 * 0.13, var_304_20 * 0.13) + arg_301_1.var_.shakeOldPos
			end

			if arg_301_1.time_ >= var_304_16 + var_304_17 and arg_301_1.time_ < var_304_16 + var_304_17 + arg_304_0 then
				var_304_15.localPosition = arg_301_1.var_.shakeOldPos
			end

			local var_304_21 = 0

			if var_304_21 < arg_301_1.time_ and arg_301_1.time_ <= var_304_21 + arg_304_0 then
				arg_301_1.allBtn_.enabled = false
			end

			local var_304_22 = 0.6

			if arg_301_1.time_ >= var_304_21 + var_304_22 and arg_301_1.time_ < var_304_21 + var_304_22 + arg_304_0 then
				arg_301_1.allBtn_.enabled = true
			end

			local var_304_23 = 0
			local var_304_24 = 0.491666666666667

			if var_304_23 < arg_301_1.time_ and arg_301_1.time_ <= var_304_23 + arg_304_0 then
				local var_304_25 = "stop"
				local var_304_26 = "effect"

				arg_301_1:AudioAction(var_304_25, var_304_26, "se_story_122_01", "se_story_122_01_monsterattack02_loop", "")
			end

			local var_304_27 = 0
			local var_304_28 = 0.225

			if var_304_27 < arg_301_1.time_ and arg_301_1.time_ <= var_304_27 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_29 = arg_301_1:FormatText(StoryNameCfg[996].name)

				arg_301_1.leftNameTxt_.text = var_304_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_30 = arg_301_1:GetWordFromCfg(413081071)
				local var_304_31 = arg_301_1:FormatText(var_304_30.content)

				arg_301_1.text_.text = var_304_31

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_32 = 9
				local var_304_33 = utf8.len(var_304_31)
				local var_304_34 = var_304_32 <= 0 and var_304_28 or var_304_28 * (var_304_33 / var_304_32)

				if var_304_34 > 0 and var_304_28 < var_304_34 then
					arg_301_1.talkMaxDuration = var_304_34

					if var_304_34 + var_304_27 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_34 + var_304_27
					end
				end

				arg_301_1.text_.text = var_304_31
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081071", "story_v_out_413081.awb") ~= 0 then
					local var_304_35 = manager.audio:GetVoiceLength("story_v_out_413081", "413081071", "story_v_out_413081.awb") / 1000

					if var_304_35 + var_304_27 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_35 + var_304_27
					end

					if var_304_30.prefab_name ~= "" and arg_301_1.actors_[var_304_30.prefab_name] ~= nil then
						local var_304_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_30.prefab_name].transform, "story_v_out_413081", "413081071", "story_v_out_413081.awb")

						arg_301_1:RecordAudio("413081071", var_304_36)
						arg_301_1:RecordAudio("413081071", var_304_36)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_413081", "413081071", "story_v_out_413081.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_413081", "413081071", "story_v_out_413081.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_37 = math.max(var_304_28, arg_301_1.talkMaxDuration)

			if var_304_27 <= arg_301_1.time_ and arg_301_1.time_ < var_304_27 + var_304_37 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_27) / var_304_37

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_27 + var_304_37 and arg_301_1.time_ < var_304_27 + var_304_37 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play413081072 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 413081072
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play413081073(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["10092"].transform
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.var_.moveOldPos10092 = var_308_0.localPosition
				var_308_0.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("10092", 0)

				local var_308_2 = var_308_0.childCount

				for iter_308_0 = 0, var_308_2 - 1 do
					local var_308_3 = var_308_0:GetChild(iter_308_0)

					if var_308_3.name == "" or not string.find(var_308_3.name, "split") then
						var_308_3.gameObject:SetActive(true)
					else
						var_308_3.gameObject:SetActive(false)
					end
				end
			end

			local var_308_4 = 0.001

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_4 then
				local var_308_5 = (arg_305_1.time_ - var_308_1) / var_308_4
				local var_308_6 = Vector3.New(-1500, -350, -180)

				var_308_0.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos10092, var_308_6, var_308_5)
			end

			if arg_305_1.time_ >= var_308_1 + var_308_4 and arg_305_1.time_ < var_308_1 + var_308_4 + arg_308_0 then
				var_308_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_308_7 = arg_305_1.actors_["10092"]
			local var_308_8 = 0

			if var_308_8 < arg_305_1.time_ and arg_305_1.time_ <= var_308_8 + arg_308_0 and not isNil(var_308_7) and arg_305_1.var_.actorSpriteComps10092 == nil then
				arg_305_1.var_.actorSpriteComps10092 = var_308_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_9 = 2

			if var_308_8 <= arg_305_1.time_ and arg_305_1.time_ < var_308_8 + var_308_9 and not isNil(var_308_7) then
				local var_308_10 = (arg_305_1.time_ - var_308_8) / var_308_9

				if arg_305_1.var_.actorSpriteComps10092 then
					for iter_308_1, iter_308_2 in pairs(arg_305_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_308_2 then
							if arg_305_1.isInRecall_ then
								local var_308_11 = Mathf.Lerp(iter_308_2.color.r, arg_305_1.hightColor2.r, var_308_10)
								local var_308_12 = Mathf.Lerp(iter_308_2.color.g, arg_305_1.hightColor2.g, var_308_10)
								local var_308_13 = Mathf.Lerp(iter_308_2.color.b, arg_305_1.hightColor2.b, var_308_10)

								iter_308_2.color = Color.New(var_308_11, var_308_12, var_308_13)
							else
								local var_308_14 = Mathf.Lerp(iter_308_2.color.r, 0.5, var_308_10)

								iter_308_2.color = Color.New(var_308_14, var_308_14, var_308_14)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= var_308_8 + var_308_9 and arg_305_1.time_ < var_308_8 + var_308_9 + arg_308_0 and not isNil(var_308_7) and arg_305_1.var_.actorSpriteComps10092 then
				for iter_308_3, iter_308_4 in pairs(arg_305_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_308_4 then
						if arg_305_1.isInRecall_ then
							iter_308_4.color = arg_305_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_308_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_305_1.var_.actorSpriteComps10092 = nil
			end

			local var_308_15 = 0.034
			local var_308_16 = 1

			if var_308_15 < arg_305_1.time_ and arg_305_1.time_ <= var_308_15 + arg_308_0 then
				local var_308_17 = "play"
				local var_308_18 = "effect"

				arg_305_1:AudioAction(var_308_17, var_308_18, "se_story_1211", "se_story_1211_explosionfar", "")
			end

			local var_308_19 = 0
			local var_308_20 = 1.6

			if var_308_19 < arg_305_1.time_ and arg_305_1.time_ <= var_308_19 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_21 = arg_305_1:GetWordFromCfg(413081072)
				local var_308_22 = arg_305_1:FormatText(var_308_21.content)

				arg_305_1.text_.text = var_308_22

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_23 = 64
				local var_308_24 = utf8.len(var_308_22)
				local var_308_25 = var_308_23 <= 0 and var_308_20 or var_308_20 * (var_308_24 / var_308_23)

				if var_308_25 > 0 and var_308_20 < var_308_25 then
					arg_305_1.talkMaxDuration = var_308_25

					if var_308_25 + var_308_19 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_25 + var_308_19
					end
				end

				arg_305_1.text_.text = var_308_22
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_26 = math.max(var_308_20, arg_305_1.talkMaxDuration)

			if var_308_19 <= arg_305_1.time_ and arg_305_1.time_ < var_308_19 + var_308_26 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_19) / var_308_26

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_19 + var_308_26 and arg_305_1.time_ < var_308_19 + var_308_26 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play413081073 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 413081073
		arg_309_1.duration_ = 5.3

		local var_309_0 = {
			zh = 4.633,
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
				arg_309_0:Play413081074(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 0.675

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_2 = arg_309_1:FormatText(StoryNameCfg[992].name)

				arg_309_1.leftNameTxt_.text = var_312_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_3 = arg_309_1:GetWordFromCfg(413081073)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 27
				local var_312_6 = utf8.len(var_312_4)
				local var_312_7 = var_312_5 <= 0 and var_312_1 or var_312_1 * (var_312_6 / var_312_5)

				if var_312_7 > 0 and var_312_1 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_4
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081073", "story_v_out_413081.awb") ~= 0 then
					local var_312_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081073", "story_v_out_413081.awb") / 1000

					if var_312_8 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_8 + var_312_0
					end

					if var_312_3.prefab_name ~= "" and arg_309_1.actors_[var_312_3.prefab_name] ~= nil then
						local var_312_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_3.prefab_name].transform, "story_v_out_413081", "413081073", "story_v_out_413081.awb")

						arg_309_1:RecordAudio("413081073", var_312_9)
						arg_309_1:RecordAudio("413081073", var_312_9)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_413081", "413081073", "story_v_out_413081.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_413081", "413081073", "story_v_out_413081.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_10 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_10 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_10

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_10 and arg_309_1.time_ < var_312_0 + var_312_10 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play413081074 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 413081074
		arg_313_1.duration_ = 6.1

		local var_313_0 = {
			zh = 5.366,
			ja = 6.1
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
				arg_313_0:Play413081075(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["10092"].transform
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.var_.moveOldPos10092 = var_316_0.localPosition
				var_316_0.localScale = Vector3.New(1, 1, 1)

				arg_313_1:CheckSpriteTmpPos("10092", 3)

				local var_316_2 = var_316_0.childCount

				for iter_316_0 = 0, var_316_2 - 1 do
					local var_316_3 = var_316_0:GetChild(iter_316_0)

					if var_316_3.name == "split_8" or not string.find(var_316_3.name, "split") then
						var_316_3.gameObject:SetActive(true)
					else
						var_316_3.gameObject:SetActive(false)
					end
				end
			end

			local var_316_4 = 0.001

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_4 then
				local var_316_5 = (arg_313_1.time_ - var_316_1) / var_316_4
				local var_316_6 = Vector3.New(0, -300, -295)

				var_316_0.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos10092, var_316_6, var_316_5)
			end

			if arg_313_1.time_ >= var_316_1 + var_316_4 and arg_313_1.time_ < var_316_1 + var_316_4 + arg_316_0 then
				var_316_0.localPosition = Vector3.New(0, -300, -295)
			end

			local var_316_7 = arg_313_1.actors_["10092"]
			local var_316_8 = 0

			if var_316_8 < arg_313_1.time_ and arg_313_1.time_ <= var_316_8 + arg_316_0 and not isNil(var_316_7) and arg_313_1.var_.actorSpriteComps10092 == nil then
				arg_313_1.var_.actorSpriteComps10092 = var_316_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_9 = 2

			if var_316_8 <= arg_313_1.time_ and arg_313_1.time_ < var_316_8 + var_316_9 and not isNil(var_316_7) then
				local var_316_10 = (arg_313_1.time_ - var_316_8) / var_316_9

				if arg_313_1.var_.actorSpriteComps10092 then
					for iter_316_1, iter_316_2 in pairs(arg_313_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_316_2 then
							if arg_313_1.isInRecall_ then
								local var_316_11 = Mathf.Lerp(iter_316_2.color.r, arg_313_1.hightColor1.r, var_316_10)
								local var_316_12 = Mathf.Lerp(iter_316_2.color.g, arg_313_1.hightColor1.g, var_316_10)
								local var_316_13 = Mathf.Lerp(iter_316_2.color.b, arg_313_1.hightColor1.b, var_316_10)

								iter_316_2.color = Color.New(var_316_11, var_316_12, var_316_13)
							else
								local var_316_14 = Mathf.Lerp(iter_316_2.color.r, 1, var_316_10)

								iter_316_2.color = Color.New(var_316_14, var_316_14, var_316_14)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= var_316_8 + var_316_9 and arg_313_1.time_ < var_316_8 + var_316_9 + arg_316_0 and not isNil(var_316_7) and arg_313_1.var_.actorSpriteComps10092 then
				for iter_316_3, iter_316_4 in pairs(arg_313_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_316_4 then
						if arg_313_1.isInRecall_ then
							iter_316_4.color = arg_313_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_316_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_313_1.var_.actorSpriteComps10092 = nil
			end

			local var_316_15 = 0
			local var_316_16 = 0.65

			if var_316_15 < arg_313_1.time_ and arg_313_1.time_ <= var_316_15 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_17 = arg_313_1:FormatText(StoryNameCfg[996].name)

				arg_313_1.leftNameTxt_.text = var_316_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_18 = arg_313_1:GetWordFromCfg(413081074)
				local var_316_19 = arg_313_1:FormatText(var_316_18.content)

				arg_313_1.text_.text = var_316_19

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_20 = 26
				local var_316_21 = utf8.len(var_316_19)
				local var_316_22 = var_316_20 <= 0 and var_316_16 or var_316_16 * (var_316_21 / var_316_20)

				if var_316_22 > 0 and var_316_16 < var_316_22 then
					arg_313_1.talkMaxDuration = var_316_22

					if var_316_22 + var_316_15 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_22 + var_316_15
					end
				end

				arg_313_1.text_.text = var_316_19
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081074", "story_v_out_413081.awb") ~= 0 then
					local var_316_23 = manager.audio:GetVoiceLength("story_v_out_413081", "413081074", "story_v_out_413081.awb") / 1000

					if var_316_23 + var_316_15 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_23 + var_316_15
					end

					if var_316_18.prefab_name ~= "" and arg_313_1.actors_[var_316_18.prefab_name] ~= nil then
						local var_316_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_18.prefab_name].transform, "story_v_out_413081", "413081074", "story_v_out_413081.awb")

						arg_313_1:RecordAudio("413081074", var_316_24)
						arg_313_1:RecordAudio("413081074", var_316_24)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_out_413081", "413081074", "story_v_out_413081.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_out_413081", "413081074", "story_v_out_413081.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_25 = math.max(var_316_16, arg_313_1.talkMaxDuration)

			if var_316_15 <= arg_313_1.time_ and arg_313_1.time_ < var_316_15 + var_316_25 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_15) / var_316_25

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_15 + var_316_25 and arg_313_1.time_ < var_316_15 + var_316_25 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_313_1:InitPlayNodeList()
	end,
	Play413081075 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 413081075
		arg_317_1.duration_ = 8.8

		local var_317_0 = {
			zh = 6.366,
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
				arg_317_0:Play413081076(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 0.725

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_2 = arg_317_1:FormatText(StoryNameCfg[996].name)

				arg_317_1.leftNameTxt_.text = var_320_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_3 = arg_317_1:GetWordFromCfg(413081075)
				local var_320_4 = arg_317_1:FormatText(var_320_3.content)

				arg_317_1.text_.text = var_320_4

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 29
				local var_320_6 = utf8.len(var_320_4)
				local var_320_7 = var_320_5 <= 0 and var_320_1 or var_320_1 * (var_320_6 / var_320_5)

				if var_320_7 > 0 and var_320_1 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_4
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081075", "story_v_out_413081.awb") ~= 0 then
					local var_320_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081075", "story_v_out_413081.awb") / 1000

					if var_320_8 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_8 + var_320_0
					end

					if var_320_3.prefab_name ~= "" and arg_317_1.actors_[var_320_3.prefab_name] ~= nil then
						local var_320_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_3.prefab_name].transform, "story_v_out_413081", "413081075", "story_v_out_413081.awb")

						arg_317_1:RecordAudio("413081075", var_320_9)
						arg_317_1:RecordAudio("413081075", var_320_9)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_413081", "413081075", "story_v_out_413081.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_413081", "413081075", "story_v_out_413081.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_10 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_10 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_10

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_10 and arg_317_1.time_ < var_320_0 + var_320_10 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play413081076 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 413081076
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play413081077(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["10092"].transform
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 then
				arg_321_1.var_.moveOldPos10092 = var_324_0.localPosition
				var_324_0.localScale = Vector3.New(1, 1, 1)

				arg_321_1:CheckSpriteTmpPos("10092", 7)

				local var_324_2 = var_324_0.childCount

				for iter_324_0 = 0, var_324_2 - 1 do
					local var_324_3 = var_324_0:GetChild(iter_324_0)

					if var_324_3.name == "" or not string.find(var_324_3.name, "split") then
						var_324_3.gameObject:SetActive(true)
					else
						var_324_3.gameObject:SetActive(false)
					end
				end
			end

			local var_324_4 = 0.001

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_4 then
				local var_324_5 = (arg_321_1.time_ - var_324_1) / var_324_4
				local var_324_6 = Vector3.New(0, -2000, -180)

				var_324_0.localPosition = Vector3.Lerp(arg_321_1.var_.moveOldPos10092, var_324_6, var_324_5)
			end

			if arg_321_1.time_ >= var_324_1 + var_324_4 and arg_321_1.time_ < var_324_1 + var_324_4 + arg_324_0 then
				var_324_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_324_7 = 0.716667
			local var_324_8 = 0.833333

			if var_324_7 < arg_321_1.time_ and arg_321_1.time_ <= var_324_7 + arg_324_0 then
				local var_324_9 = "play"
				local var_324_10 = "effect"

				arg_321_1:AudioAction(var_324_9, var_324_10, "se_story_1211", "se_story_1211_explosionfar", "")
			end

			local var_324_11 = 0
			local var_324_12 = 1.55

			if var_324_11 < arg_321_1.time_ and arg_321_1.time_ <= var_324_11 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, false)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_13 = arg_321_1:GetWordFromCfg(413081076)
				local var_324_14 = arg_321_1:FormatText(var_324_13.content)

				arg_321_1.text_.text = var_324_14

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_15 = 62
				local var_324_16 = utf8.len(var_324_14)
				local var_324_17 = var_324_15 <= 0 and var_324_12 or var_324_12 * (var_324_16 / var_324_15)

				if var_324_17 > 0 and var_324_12 < var_324_17 then
					arg_321_1.talkMaxDuration = var_324_17

					if var_324_17 + var_324_11 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_17 + var_324_11
					end
				end

				arg_321_1.text_.text = var_324_14
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_18 = math.max(var_324_12, arg_321_1.talkMaxDuration)

			if var_324_11 <= arg_321_1.time_ and arg_321_1.time_ < var_324_11 + var_324_18 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_11) / var_324_18

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_11 + var_324_18 and arg_321_1.time_ < var_324_11 + var_324_18 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_321_1:InitPlayNodeList()
	end,
	Play413081077 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 413081077
		arg_325_1.duration_ = 6.2

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play413081078(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 1.2
			local var_328_1 = 1

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				local var_328_2 = "play"
				local var_328_3 = "effect"

				arg_325_1:AudioAction(var_328_2, var_328_3, "minigame_activity_3_4", "minigame_activity_3_4_battle_bullet_30", "")
			end

			local var_328_4 = 0
			local var_328_5 = 1.83333333333333

			if var_328_4 < arg_325_1.time_ and arg_325_1.time_ <= var_328_4 + arg_328_0 then
				local var_328_6 = "play"
				local var_328_7 = "effect"

				arg_325_1:AudioAction(var_328_6, var_328_7, "se_story_121_04", "se_story_121_04_seal", "")
			end

			local var_328_8 = 1.325
			local var_328_9 = 1.55

			if var_328_8 < arg_325_1.time_ and arg_325_1.time_ <= var_328_8 + arg_328_0 then
				local var_328_10 = "play"
				local var_328_11 = "effect"

				arg_325_1:AudioAction(var_328_10, var_328_11, "se_story_123_01", "se_story_123_01_explosion", "")
			end

			local var_328_12 = 0
			local var_328_13 = 1.83333333333333

			if var_328_12 < arg_325_1.time_ and arg_325_1.time_ <= var_328_12 + arg_328_0 then
				local var_328_14 = "play"
				local var_328_15 = "effect"

				arg_325_1:AudioAction(var_328_14, var_328_15, "c_10079", "c_10079_bullet_7", "")
			end

			local var_328_16 = 0

			if var_328_16 < arg_325_1.time_ and arg_325_1.time_ <= var_328_16 + arg_328_0 then
				arg_325_1.mask_.enabled = true
				arg_325_1.mask_.raycastTarget = true

				arg_325_1:SetGaussion(false)
			end

			local var_328_17 = 0.8

			if var_328_16 <= arg_325_1.time_ and arg_325_1.time_ < var_328_16 + var_328_17 then
				local var_328_18 = (arg_325_1.time_ - var_328_16) / var_328_17
				local var_328_19 = Color.New(1, 1, 1)

				var_328_19.a = Mathf.Lerp(1, 0, var_328_18)
				arg_325_1.mask_.color = var_328_19
			end

			if arg_325_1.time_ >= var_328_16 + var_328_17 and arg_325_1.time_ < var_328_16 + var_328_17 + arg_328_0 then
				local var_328_20 = Color.New(1, 1, 1)
				local var_328_21 = 0

				arg_325_1.mask_.enabled = false
				var_328_20.a = var_328_21
				arg_325_1.mask_.color = var_328_20
			end

			local var_328_22 = manager.ui.mainCamera.transform
			local var_328_23 = 0.366666666666667

			if var_328_23 < arg_325_1.time_ and arg_325_1.time_ <= var_328_23 + arg_328_0 then
				local var_328_24 = arg_325_1.var_.effect12333
				local var_328_25
				local var_328_26 = var_328_22

				if not var_328_24 then
					var_328_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), var_328_26)
					var_328_24.name = "12333"
					arg_325_1.var_.effect12333 = var_328_24
				else
					var_328_24.transform:SetParent(var_328_26)
				end

				var_328_24.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_328_24.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_328_27 = manager.ui.mainCamera.transform
			local var_328_28 = 1.325

			if var_328_28 < arg_325_1.time_ and arg_325_1.time_ <= var_328_28 + arg_328_0 then
				local var_328_29 = arg_325_1.var_.effect12333

				if var_328_29 then
					Object.Destroy(var_328_29)

					arg_325_1.var_.effect12333 = nil
				end
			end

			if arg_325_1.frameCnt_ <= 1 then
				arg_325_1.dialog_:SetActive(false)
			end

			local var_328_30 = 1.2
			local var_328_31 = 0.875

			if var_328_30 < arg_325_1.time_ and arg_325_1.time_ <= var_328_30 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				arg_325_1.dialog_:SetActive(true)

				arg_325_1.dialogCg_.alpha = 0

				local var_328_32 = LeanTween.value(arg_325_1.dialog_, 0, 1, 0.3)

				var_328_32:setOnUpdate(LuaHelper.FloatAction(function(arg_329_0)
					arg_325_1.dialogCg_.alpha = arg_329_0
				end))
				var_328_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_325_1.dialog_)
					var_328_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_325_1.duration_ = arg_325_1.duration_ + 0.3

				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_33 = arg_325_1:GetWordFromCfg(413081077)
				local var_328_34 = arg_325_1:FormatText(var_328_33.content)

				arg_325_1.text_.text = var_328_34

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_35 = 35
				local var_328_36 = utf8.len(var_328_34)
				local var_328_37 = var_328_35 <= 0 and var_328_31 or var_328_31 * (var_328_36 / var_328_35)

				if var_328_37 > 0 and var_328_31 < var_328_37 then
					arg_325_1.talkMaxDuration = var_328_37
					var_328_30 = var_328_30 + 0.3

					if var_328_37 + var_328_30 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_37 + var_328_30
					end
				end

				arg_325_1.text_.text = var_328_34
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_38 = var_328_30 + 0.3
			local var_328_39 = math.max(var_328_31, arg_325_1.talkMaxDuration)

			if var_328_38 <= arg_325_1.time_ and arg_325_1.time_ < var_328_38 + var_328_39 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_38) / var_328_39

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_38 + var_328_39 and arg_325_1.time_ < var_328_38 + var_328_39 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play413081078 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 413081078
		arg_331_1.duration_ = 9

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play413081079(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 2

			if var_334_0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_0 + arg_334_0 then
				local var_334_1 = manager.ui.mainCamera.transform.localPosition
				local var_334_2 = Vector3.New(0, 0, 10) + Vector3.New(var_334_1.x, var_334_1.y, 0)
				local var_334_3 = arg_331_1.bgs_.F08i

				var_334_3.transform.localPosition = var_334_2
				var_334_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_334_4 = var_334_3:GetComponent("SpriteRenderer")

				if var_334_4 and var_334_4.sprite then
					local var_334_5 = (var_334_3.transform.localPosition - var_334_1).z
					local var_334_6 = manager.ui.mainCameraCom_
					local var_334_7 = 2 * var_334_5 * Mathf.Tan(var_334_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_334_8 = var_334_7 * var_334_6.aspect
					local var_334_9 = var_334_4.sprite.bounds.size.x
					local var_334_10 = var_334_4.sprite.bounds.size.y
					local var_334_11 = var_334_8 / var_334_9
					local var_334_12 = var_334_7 / var_334_10
					local var_334_13 = var_334_12 < var_334_11 and var_334_11 or var_334_12

					var_334_3.transform.localScale = Vector3.New(var_334_13, var_334_13, 0)
				end

				for iter_334_0, iter_334_1 in pairs(arg_331_1.bgs_) do
					if iter_334_0 ~= "F08i" then
						iter_334_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_334_14 = 3.999999999999

			if var_334_14 < arg_331_1.time_ and arg_331_1.time_ <= var_334_14 + arg_334_0 then
				arg_331_1.allBtn_.enabled = false
			end

			local var_334_15 = 0.3

			if arg_331_1.time_ >= var_334_14 + var_334_15 and arg_331_1.time_ < var_334_14 + var_334_15 + arg_334_0 then
				arg_331_1.allBtn_.enabled = true
			end

			local var_334_16 = 0

			if var_334_16 < arg_331_1.time_ and arg_331_1.time_ <= var_334_16 + arg_334_0 then
				arg_331_1.mask_.enabled = true
				arg_331_1.mask_.raycastTarget = true

				arg_331_1:SetGaussion(false)
			end

			local var_334_17 = 2

			if var_334_16 <= arg_331_1.time_ and arg_331_1.time_ < var_334_16 + var_334_17 then
				local var_334_18 = (arg_331_1.time_ - var_334_16) / var_334_17
				local var_334_19 = Color.New(0, 0, 0)

				var_334_19.a = Mathf.Lerp(0, 1, var_334_18)
				arg_331_1.mask_.color = var_334_19
			end

			if arg_331_1.time_ >= var_334_16 + var_334_17 and arg_331_1.time_ < var_334_16 + var_334_17 + arg_334_0 then
				local var_334_20 = Color.New(0, 0, 0)

				var_334_20.a = 1
				arg_331_1.mask_.color = var_334_20
			end

			local var_334_21 = 2

			if var_334_21 < arg_331_1.time_ and arg_331_1.time_ <= var_334_21 + arg_334_0 then
				arg_331_1.mask_.enabled = true
				arg_331_1.mask_.raycastTarget = true

				arg_331_1:SetGaussion(false)
			end

			local var_334_22 = 2

			if var_334_21 <= arg_331_1.time_ and arg_331_1.time_ < var_334_21 + var_334_22 then
				local var_334_23 = (arg_331_1.time_ - var_334_21) / var_334_22
				local var_334_24 = Color.New(0, 0, 0)

				var_334_24.a = Mathf.Lerp(1, 0, var_334_23)
				arg_331_1.mask_.color = var_334_24
			end

			if arg_331_1.time_ >= var_334_21 + var_334_22 and arg_331_1.time_ < var_334_21 + var_334_22 + arg_334_0 then
				local var_334_25 = Color.New(0, 0, 0)
				local var_334_26 = 0

				arg_331_1.mask_.enabled = false
				var_334_25.a = var_334_26
				arg_331_1.mask_.color = var_334_25
			end

			local var_334_27 = 1.03333333333333
			local var_334_28 = 3.474999999999

			if var_334_27 < arg_331_1.time_ and arg_331_1.time_ <= var_334_27 + arg_334_0 then
				local var_334_29 = "play"
				local var_334_30 = "effect"

				arg_331_1:AudioAction(var_334_29, var_334_30, "se_story_121_04", "se_story_121_04_explosion", "")
			end

			local var_334_31 = 3.299999999999
			local var_334_32 = 1

			if var_334_31 < arg_331_1.time_ and arg_331_1.time_ <= var_334_31 + arg_334_0 then
				local var_334_33 = "play"
				local var_334_34 = "effect"

				arg_331_1:AudioAction(var_334_33, var_334_34, "se_story_123_01", "se_story_123_01_explosion", "")
			end

			if arg_331_1.frameCnt_ <= 1 then
				arg_331_1.dialog_:SetActive(false)
			end

			local var_334_35 = 3.999999999999
			local var_334_36 = 1.775

			if var_334_35 < arg_331_1.time_ and arg_331_1.time_ <= var_334_35 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0

				arg_331_1.dialog_:SetActive(true)

				arg_331_1.dialogCg_.alpha = 0

				local var_334_37 = LeanTween.value(arg_331_1.dialog_, 0, 1, 0.3)

				var_334_37:setOnUpdate(LuaHelper.FloatAction(function(arg_335_0)
					arg_331_1.dialogCg_.alpha = arg_335_0
				end))
				var_334_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_331_1.dialog_)
					var_334_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_331_1.duration_ = arg_331_1.duration_ + 0.3

				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_38 = arg_331_1:GetWordFromCfg(413081078)
				local var_334_39 = arg_331_1:FormatText(var_334_38.content)

				arg_331_1.text_.text = var_334_39

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_40 = 71
				local var_334_41 = utf8.len(var_334_39)
				local var_334_42 = var_334_40 <= 0 and var_334_36 or var_334_36 * (var_334_41 / var_334_40)

				if var_334_42 > 0 and var_334_36 < var_334_42 then
					arg_331_1.talkMaxDuration = var_334_42
					var_334_35 = var_334_35 + 0.3

					if var_334_42 + var_334_35 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_42 + var_334_35
					end
				end

				arg_331_1.text_.text = var_334_39
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_43 = var_334_35 + 0.3
			local var_334_44 = math.max(var_334_36, arg_331_1.talkMaxDuration)

			if var_334_43 <= arg_331_1.time_ and arg_331_1.time_ < var_334_43 + var_334_44 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_43) / var_334_44

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_43 + var_334_44 and arg_331_1.time_ < var_334_43 + var_334_44 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play413081079 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 413081079
		arg_337_1.duration_ = 6.87

		local var_337_0 = {
			zh = 3.69966666666667,
			ja = 6.86666666666667
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
				arg_337_0:Play413081080(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["10022"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 then
				local var_340_2 = var_340_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_340_2 then
					arg_337_1.var_.alphaOldValue10022 = var_340_2.alpha
					arg_337_1.var_.characterEffect10022 = var_340_2
				end

				arg_337_1.var_.alphaOldValue10022 = 0
			end

			local var_340_3 = 0.5

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_3 then
				local var_340_4 = (arg_337_1.time_ - var_340_1) / var_340_3
				local var_340_5 = Mathf.Lerp(arg_337_1.var_.alphaOldValue10022, 1, var_340_4)

				if arg_337_1.var_.characterEffect10022 then
					arg_337_1.var_.characterEffect10022.alpha = var_340_5
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_3 and arg_337_1.time_ < var_340_1 + var_340_3 + arg_340_0 and arg_337_1.var_.characterEffect10022 then
				arg_337_1.var_.characterEffect10022.alpha = 1
			end

			local var_340_6 = arg_337_1.actors_["10022"].transform
			local var_340_7 = 0

			if var_340_7 < arg_337_1.time_ and arg_337_1.time_ <= var_340_7 + arg_340_0 then
				arg_337_1.var_.moveOldPos10022 = var_340_6.localPosition
				var_340_6.localScale = Vector3.New(1, 1, 1)

				arg_337_1:CheckSpriteTmpPos("10022", 2)

				local var_340_8 = var_340_6.childCount

				for iter_340_0 = 0, var_340_8 - 1 do
					local var_340_9 = var_340_6:GetChild(iter_340_0)

					if var_340_9.name == "split_8" or not string.find(var_340_9.name, "split") then
						var_340_9.gameObject:SetActive(true)
					else
						var_340_9.gameObject:SetActive(false)
					end
				end
			end

			local var_340_10 = 0.001

			if var_340_7 <= arg_337_1.time_ and arg_337_1.time_ < var_340_7 + var_340_10 then
				local var_340_11 = (arg_337_1.time_ - var_340_7) / var_340_10
				local var_340_12 = Vector3.New(-390, -315, -320)

				var_340_6.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos10022, var_340_12, var_340_11)
			end

			if arg_337_1.time_ >= var_340_7 + var_340_10 and arg_337_1.time_ < var_340_7 + var_340_10 + arg_340_0 then
				var_340_6.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_340_13 = arg_337_1.actors_["10022"]
			local var_340_14 = 0

			if var_340_14 < arg_337_1.time_ and arg_337_1.time_ <= var_340_14 + arg_340_0 and not isNil(var_340_13) and arg_337_1.var_.actorSpriteComps10022 == nil then
				arg_337_1.var_.actorSpriteComps10022 = var_340_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_15 = 0.034

			if var_340_14 <= arg_337_1.time_ and arg_337_1.time_ < var_340_14 + var_340_15 and not isNil(var_340_13) then
				local var_340_16 = (arg_337_1.time_ - var_340_14) / var_340_15

				if arg_337_1.var_.actorSpriteComps10022 then
					for iter_340_1, iter_340_2 in pairs(arg_337_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_340_2 then
							if arg_337_1.isInRecall_ then
								local var_340_17 = Mathf.Lerp(iter_340_2.color.r, arg_337_1.hightColor1.r, var_340_16)
								local var_340_18 = Mathf.Lerp(iter_340_2.color.g, arg_337_1.hightColor1.g, var_340_16)
								local var_340_19 = Mathf.Lerp(iter_340_2.color.b, arg_337_1.hightColor1.b, var_340_16)

								iter_340_2.color = Color.New(var_340_17, var_340_18, var_340_19)
							else
								local var_340_20 = Mathf.Lerp(iter_340_2.color.r, 1, var_340_16)

								iter_340_2.color = Color.New(var_340_20, var_340_20, var_340_20)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= var_340_14 + var_340_15 and arg_337_1.time_ < var_340_14 + var_340_15 + arg_340_0 and not isNil(var_340_13) and arg_337_1.var_.actorSpriteComps10022 then
				for iter_340_3, iter_340_4 in pairs(arg_337_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_340_4 then
						if arg_337_1.isInRecall_ then
							iter_340_4.color = arg_337_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_340_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_337_1.var_.actorSpriteComps10022 = nil
			end

			local var_340_21 = 0

			if var_340_21 < arg_337_1.time_ and arg_337_1.time_ <= var_340_21 + arg_340_0 then
				arg_337_1.allBtn_.enabled = false
			end

			local var_340_22 = 0.7

			if arg_337_1.time_ >= var_340_21 + var_340_22 and arg_337_1.time_ < var_340_21 + var_340_22 + arg_340_0 then
				arg_337_1.allBtn_.enabled = true
			end

			if arg_337_1.frameCnt_ <= 1 then
				arg_337_1.dialog_:SetActive(false)
			end

			local var_340_23 = 0.566666666666667
			local var_340_24 = 0.425

			if var_340_23 < arg_337_1.time_ and arg_337_1.time_ <= var_340_23 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0

				arg_337_1.dialog_:SetActive(true)

				arg_337_1.dialogCg_.alpha = 0

				local var_340_25 = LeanTween.value(arg_337_1.dialog_, 0, 1, 0.3)

				var_340_25:setOnUpdate(LuaHelper.FloatAction(function(arg_341_0)
					arg_337_1.dialogCg_.alpha = arg_341_0
				end))
				var_340_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_337_1.dialog_)
					var_340_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_337_1.duration_ = arg_337_1.duration_ + 0.3

				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_26 = arg_337_1:FormatText(StoryNameCfg[614].name)

				arg_337_1.leftNameTxt_.text = var_340_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_27 = arg_337_1:GetWordFromCfg(413081079)
				local var_340_28 = arg_337_1:FormatText(var_340_27.content)

				arg_337_1.text_.text = var_340_28

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_29 = 17
				local var_340_30 = utf8.len(var_340_28)
				local var_340_31 = var_340_29 <= 0 and var_340_24 or var_340_24 * (var_340_30 / var_340_29)

				if var_340_31 > 0 and var_340_24 < var_340_31 then
					arg_337_1.talkMaxDuration = var_340_31
					var_340_23 = var_340_23 + 0.3

					if var_340_31 + var_340_23 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_31 + var_340_23
					end
				end

				arg_337_1.text_.text = var_340_28
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081079", "story_v_out_413081.awb") ~= 0 then
					local var_340_32 = manager.audio:GetVoiceLength("story_v_out_413081", "413081079", "story_v_out_413081.awb") / 1000

					if var_340_32 + var_340_23 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_32 + var_340_23
					end

					if var_340_27.prefab_name ~= "" and arg_337_1.actors_[var_340_27.prefab_name] ~= nil then
						local var_340_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_27.prefab_name].transform, "story_v_out_413081", "413081079", "story_v_out_413081.awb")

						arg_337_1:RecordAudio("413081079", var_340_33)
						arg_337_1:RecordAudio("413081079", var_340_33)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_413081", "413081079", "story_v_out_413081.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_413081", "413081079", "story_v_out_413081.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_34 = var_340_23 + 0.3
			local var_340_35 = math.max(var_340_24, arg_337_1.talkMaxDuration)

			if var_340_34 <= arg_337_1.time_ and arg_337_1.time_ < var_340_34 + var_340_35 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_34) / var_340_35

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_34 + var_340_35 and arg_337_1.time_ < var_340_34 + var_340_35 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play413081080 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 413081080
		arg_343_1.duration_ = 5.2

		local var_343_0 = {
			zh = 3.1,
			ja = 5.2
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
				arg_343_0:Play413081081(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = arg_343_1.actors_["10022"]
			local var_346_1 = 0

			if var_346_1 < arg_343_1.time_ and arg_343_1.time_ <= var_346_1 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.actorSpriteComps10022 == nil then
				arg_343_1.var_.actorSpriteComps10022 = var_346_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_2 = 2

			if var_346_1 <= arg_343_1.time_ and arg_343_1.time_ < var_346_1 + var_346_2 and not isNil(var_346_0) then
				local var_346_3 = (arg_343_1.time_ - var_346_1) / var_346_2

				if arg_343_1.var_.actorSpriteComps10022 then
					for iter_346_0, iter_346_1 in pairs(arg_343_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_346_1 then
							if arg_343_1.isInRecall_ then
								local var_346_4 = Mathf.Lerp(iter_346_1.color.r, arg_343_1.hightColor2.r, var_346_3)
								local var_346_5 = Mathf.Lerp(iter_346_1.color.g, arg_343_1.hightColor2.g, var_346_3)
								local var_346_6 = Mathf.Lerp(iter_346_1.color.b, arg_343_1.hightColor2.b, var_346_3)

								iter_346_1.color = Color.New(var_346_4, var_346_5, var_346_6)
							else
								local var_346_7 = Mathf.Lerp(iter_346_1.color.r, 0.5, var_346_3)

								iter_346_1.color = Color.New(var_346_7, var_346_7, var_346_7)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= var_346_1 + var_346_2 and arg_343_1.time_ < var_346_1 + var_346_2 + arg_346_0 and not isNil(var_346_0) and arg_343_1.var_.actorSpriteComps10022 then
				for iter_346_2, iter_346_3 in pairs(arg_343_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_346_3 then
						if arg_343_1.isInRecall_ then
							iter_346_3.color = arg_343_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_346_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_343_1.var_.actorSpriteComps10022 = nil
			end

			local var_346_8 = arg_343_1.actors_["10094"]
			local var_346_9 = 0

			if var_346_9 < arg_343_1.time_ and arg_343_1.time_ <= var_346_9 + arg_346_0 and not isNil(var_346_8) and arg_343_1.var_.actorSpriteComps10094 == nil then
				arg_343_1.var_.actorSpriteComps10094 = var_346_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_10 = 2

			if var_346_9 <= arg_343_1.time_ and arg_343_1.time_ < var_346_9 + var_346_10 and not isNil(var_346_8) then
				local var_346_11 = (arg_343_1.time_ - var_346_9) / var_346_10

				if arg_343_1.var_.actorSpriteComps10094 then
					for iter_346_4, iter_346_5 in pairs(arg_343_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_346_5 then
							if arg_343_1.isInRecall_ then
								local var_346_12 = Mathf.Lerp(iter_346_5.color.r, arg_343_1.hightColor1.r, var_346_11)
								local var_346_13 = Mathf.Lerp(iter_346_5.color.g, arg_343_1.hightColor1.g, var_346_11)
								local var_346_14 = Mathf.Lerp(iter_346_5.color.b, arg_343_1.hightColor1.b, var_346_11)

								iter_346_5.color = Color.New(var_346_12, var_346_13, var_346_14)
							else
								local var_346_15 = Mathf.Lerp(iter_346_5.color.r, 1, var_346_11)

								iter_346_5.color = Color.New(var_346_15, var_346_15, var_346_15)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= var_346_9 + var_346_10 and arg_343_1.time_ < var_346_9 + var_346_10 + arg_346_0 and not isNil(var_346_8) and arg_343_1.var_.actorSpriteComps10094 then
				for iter_346_6, iter_346_7 in pairs(arg_343_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_346_7 then
						if arg_343_1.isInRecall_ then
							iter_346_7.color = arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_346_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_343_1.var_.actorSpriteComps10094 = nil
			end

			local var_346_16 = arg_343_1.actors_["10094"].transform
			local var_346_17 = 0

			if var_346_17 < arg_343_1.time_ and arg_343_1.time_ <= var_346_17 + arg_346_0 then
				arg_343_1.var_.moveOldPos10094 = var_346_16.localPosition
				var_346_16.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10094", 4)

				local var_346_18 = var_346_16.childCount

				for iter_346_8 = 0, var_346_18 - 1 do
					local var_346_19 = var_346_16:GetChild(iter_346_8)

					if var_346_19.name == "" or not string.find(var_346_19.name, "split") then
						var_346_19.gameObject:SetActive(true)
					else
						var_346_19.gameObject:SetActive(false)
					end
				end
			end

			local var_346_20 = 0.001

			if var_346_17 <= arg_343_1.time_ and arg_343_1.time_ < var_346_17 + var_346_20 then
				local var_346_21 = (arg_343_1.time_ - var_346_17) / var_346_20
				local var_346_22 = Vector3.New(390, -315, -320)

				var_346_16.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10094, var_346_22, var_346_21)
			end

			if arg_343_1.time_ >= var_346_17 + var_346_20 and arg_343_1.time_ < var_346_17 + var_346_20 + arg_346_0 then
				var_346_16.localPosition = Vector3.New(390, -315, -320)
			end

			local var_346_23 = 0
			local var_346_24 = 0.35

			if var_346_23 < arg_343_1.time_ and arg_343_1.time_ <= var_346_23 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_25 = arg_343_1:FormatText(StoryNameCfg[259].name)

				arg_343_1.leftNameTxt_.text = var_346_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_26 = arg_343_1:GetWordFromCfg(413081080)
				local var_346_27 = arg_343_1:FormatText(var_346_26.content)

				arg_343_1.text_.text = var_346_27

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_28 = 14
				local var_346_29 = utf8.len(var_346_27)
				local var_346_30 = var_346_28 <= 0 and var_346_24 or var_346_24 * (var_346_29 / var_346_28)

				if var_346_30 > 0 and var_346_24 < var_346_30 then
					arg_343_1.talkMaxDuration = var_346_30

					if var_346_30 + var_346_23 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_30 + var_346_23
					end
				end

				arg_343_1.text_.text = var_346_27
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081080", "story_v_out_413081.awb") ~= 0 then
					local var_346_31 = manager.audio:GetVoiceLength("story_v_out_413081", "413081080", "story_v_out_413081.awb") / 1000

					if var_346_31 + var_346_23 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_31 + var_346_23
					end

					if var_346_26.prefab_name ~= "" and arg_343_1.actors_[var_346_26.prefab_name] ~= nil then
						local var_346_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_26.prefab_name].transform, "story_v_out_413081", "413081080", "story_v_out_413081.awb")

						arg_343_1:RecordAudio("413081080", var_346_32)
						arg_343_1:RecordAudio("413081080", var_346_32)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_413081", "413081080", "story_v_out_413081.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_413081", "413081080", "story_v_out_413081.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_33 = math.max(var_346_24, arg_343_1.talkMaxDuration)

			if var_346_23 <= arg_343_1.time_ and arg_343_1.time_ < var_346_23 + var_346_33 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_23) / var_346_33

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_23 + var_346_33 and arg_343_1.time_ < var_346_23 + var_346_33 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play413081081 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 413081081
		arg_347_1.duration_ = 8.27

		local var_347_0 = {
			zh = 5.1,
			ja = 8.266
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play413081082(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["10022"]
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.actorSpriteComps10022 == nil then
				arg_347_1.var_.actorSpriteComps10022 = var_350_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_2 = 2

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 and not isNil(var_350_0) then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2

				if arg_347_1.var_.actorSpriteComps10022 then
					for iter_350_0, iter_350_1 in pairs(arg_347_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_350_1 then
							if arg_347_1.isInRecall_ then
								local var_350_4 = Mathf.Lerp(iter_350_1.color.r, arg_347_1.hightColor1.r, var_350_3)
								local var_350_5 = Mathf.Lerp(iter_350_1.color.g, arg_347_1.hightColor1.g, var_350_3)
								local var_350_6 = Mathf.Lerp(iter_350_1.color.b, arg_347_1.hightColor1.b, var_350_3)

								iter_350_1.color = Color.New(var_350_4, var_350_5, var_350_6)
							else
								local var_350_7 = Mathf.Lerp(iter_350_1.color.r, 1, var_350_3)

								iter_350_1.color = Color.New(var_350_7, var_350_7, var_350_7)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 and not isNil(var_350_0) and arg_347_1.var_.actorSpriteComps10022 then
				for iter_350_2, iter_350_3 in pairs(arg_347_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_350_3 then
						if arg_347_1.isInRecall_ then
							iter_350_3.color = arg_347_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_350_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_347_1.var_.actorSpriteComps10022 = nil
			end

			local var_350_8 = arg_347_1.actors_["10094"]
			local var_350_9 = 0

			if var_350_9 < arg_347_1.time_ and arg_347_1.time_ <= var_350_9 + arg_350_0 and not isNil(var_350_8) and arg_347_1.var_.actorSpriteComps10094 == nil then
				arg_347_1.var_.actorSpriteComps10094 = var_350_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_10 = 2

			if var_350_9 <= arg_347_1.time_ and arg_347_1.time_ < var_350_9 + var_350_10 and not isNil(var_350_8) then
				local var_350_11 = (arg_347_1.time_ - var_350_9) / var_350_10

				if arg_347_1.var_.actorSpriteComps10094 then
					for iter_350_4, iter_350_5 in pairs(arg_347_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_350_5 then
							if arg_347_1.isInRecall_ then
								local var_350_12 = Mathf.Lerp(iter_350_5.color.r, arg_347_1.hightColor2.r, var_350_11)
								local var_350_13 = Mathf.Lerp(iter_350_5.color.g, arg_347_1.hightColor2.g, var_350_11)
								local var_350_14 = Mathf.Lerp(iter_350_5.color.b, arg_347_1.hightColor2.b, var_350_11)

								iter_350_5.color = Color.New(var_350_12, var_350_13, var_350_14)
							else
								local var_350_15 = Mathf.Lerp(iter_350_5.color.r, 0.5, var_350_11)

								iter_350_5.color = Color.New(var_350_15, var_350_15, var_350_15)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= var_350_9 + var_350_10 and arg_347_1.time_ < var_350_9 + var_350_10 + arg_350_0 and not isNil(var_350_8) and arg_347_1.var_.actorSpriteComps10094 then
				for iter_350_6, iter_350_7 in pairs(arg_347_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_350_7 then
						if arg_347_1.isInRecall_ then
							iter_350_7.color = arg_347_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_350_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_347_1.var_.actorSpriteComps10094 = nil
			end

			local var_350_16 = 0
			local var_350_17 = 0.675

			if var_350_16 < arg_347_1.time_ and arg_347_1.time_ <= var_350_16 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_18 = arg_347_1:FormatText(StoryNameCfg[614].name)

				arg_347_1.leftNameTxt_.text = var_350_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_19 = arg_347_1:GetWordFromCfg(413081081)
				local var_350_20 = arg_347_1:FormatText(var_350_19.content)

				arg_347_1.text_.text = var_350_20

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_21 = 27
				local var_350_22 = utf8.len(var_350_20)
				local var_350_23 = var_350_21 <= 0 and var_350_17 or var_350_17 * (var_350_22 / var_350_21)

				if var_350_23 > 0 and var_350_17 < var_350_23 then
					arg_347_1.talkMaxDuration = var_350_23

					if var_350_23 + var_350_16 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_23 + var_350_16
					end
				end

				arg_347_1.text_.text = var_350_20
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081081", "story_v_out_413081.awb") ~= 0 then
					local var_350_24 = manager.audio:GetVoiceLength("story_v_out_413081", "413081081", "story_v_out_413081.awb") / 1000

					if var_350_24 + var_350_16 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_24 + var_350_16
					end

					if var_350_19.prefab_name ~= "" and arg_347_1.actors_[var_350_19.prefab_name] ~= nil then
						local var_350_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_19.prefab_name].transform, "story_v_out_413081", "413081081", "story_v_out_413081.awb")

						arg_347_1:RecordAudio("413081081", var_350_25)
						arg_347_1:RecordAudio("413081081", var_350_25)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_413081", "413081081", "story_v_out_413081.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_413081", "413081081", "story_v_out_413081.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_26 = math.max(var_350_17, arg_347_1.talkMaxDuration)

			if var_350_16 <= arg_347_1.time_ and arg_347_1.time_ < var_350_16 + var_350_26 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_16) / var_350_26

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_16 + var_350_26 and arg_347_1.time_ < var_350_16 + var_350_26 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play413081082 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 413081082
		arg_351_1.duration_ = 6.27

		local var_351_0 = {
			zh = 4.8,
			ja = 6.266
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
				arg_351_0:Play413081083(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0
			local var_354_1 = 0.7

			if var_354_0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_2 = arg_351_1:FormatText(StoryNameCfg[614].name)

				arg_351_1.leftNameTxt_.text = var_354_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_3 = arg_351_1:GetWordFromCfg(413081082)
				local var_354_4 = arg_351_1:FormatText(var_354_3.content)

				arg_351_1.text_.text = var_354_4

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_5 = 28
				local var_354_6 = utf8.len(var_354_4)
				local var_354_7 = var_354_5 <= 0 and var_354_1 or var_354_1 * (var_354_6 / var_354_5)

				if var_354_7 > 0 and var_354_1 < var_354_7 then
					arg_351_1.talkMaxDuration = var_354_7

					if var_354_7 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_7 + var_354_0
					end
				end

				arg_351_1.text_.text = var_354_4
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081082", "story_v_out_413081.awb") ~= 0 then
					local var_354_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081082", "story_v_out_413081.awb") / 1000

					if var_354_8 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_8 + var_354_0
					end

					if var_354_3.prefab_name ~= "" and arg_351_1.actors_[var_354_3.prefab_name] ~= nil then
						local var_354_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_3.prefab_name].transform, "story_v_out_413081", "413081082", "story_v_out_413081.awb")

						arg_351_1:RecordAudio("413081082", var_354_9)
						arg_351_1:RecordAudio("413081082", var_354_9)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_413081", "413081082", "story_v_out_413081.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_413081", "413081082", "story_v_out_413081.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_10 = math.max(var_354_1, arg_351_1.talkMaxDuration)

			if var_354_0 <= arg_351_1.time_ and arg_351_1.time_ < var_354_0 + var_354_10 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_0) / var_354_10

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_0 + var_354_10 and arg_351_1.time_ < var_354_0 + var_354_10 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play413081083 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 413081083
		arg_355_1.duration_ = 4.8

		local var_355_0 = {
			zh = 2.5,
			ja = 4.8
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play413081084(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0
			local var_358_1 = 0.375

			if var_358_0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_0 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_2 = arg_355_1:FormatText(StoryNameCfg[614].name)

				arg_355_1.leftNameTxt_.text = var_358_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_3 = arg_355_1:GetWordFromCfg(413081083)
				local var_358_4 = arg_355_1:FormatText(var_358_3.content)

				arg_355_1.text_.text = var_358_4

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 15
				local var_358_6 = utf8.len(var_358_4)
				local var_358_7 = var_358_5 <= 0 and var_358_1 or var_358_1 * (var_358_6 / var_358_5)

				if var_358_7 > 0 and var_358_1 < var_358_7 then
					arg_355_1.talkMaxDuration = var_358_7

					if var_358_7 + var_358_0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_7 + var_358_0
					end
				end

				arg_355_1.text_.text = var_358_4
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081083", "story_v_out_413081.awb") ~= 0 then
					local var_358_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081083", "story_v_out_413081.awb") / 1000

					if var_358_8 + var_358_0 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_8 + var_358_0
					end

					if var_358_3.prefab_name ~= "" and arg_355_1.actors_[var_358_3.prefab_name] ~= nil then
						local var_358_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_3.prefab_name].transform, "story_v_out_413081", "413081083", "story_v_out_413081.awb")

						arg_355_1:RecordAudio("413081083", var_358_9)
						arg_355_1:RecordAudio("413081083", var_358_9)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_413081", "413081083", "story_v_out_413081.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_413081", "413081083", "story_v_out_413081.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_10 = math.max(var_358_1, arg_355_1.talkMaxDuration)

			if var_358_0 <= arg_355_1.time_ and arg_355_1.time_ < var_358_0 + var_358_10 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_0) / var_358_10

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_0 + var_358_10 and arg_355_1.time_ < var_358_0 + var_358_10 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play413081084 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 413081084
		arg_359_1.duration_ = 9.3

		local var_359_0 = {
			zh = 4.8,
			ja = 9.3
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
				arg_359_0:Play413081085(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["10022"]
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.actorSpriteComps10022 == nil then
				arg_359_1.var_.actorSpriteComps10022 = var_362_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_2 = 0.034

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 and not isNil(var_362_0) then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2

				if arg_359_1.var_.actorSpriteComps10022 then
					for iter_362_0, iter_362_1 in pairs(arg_359_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_362_1 then
							if arg_359_1.isInRecall_ then
								local var_362_4 = Mathf.Lerp(iter_362_1.color.r, arg_359_1.hightColor2.r, var_362_3)
								local var_362_5 = Mathf.Lerp(iter_362_1.color.g, arg_359_1.hightColor2.g, var_362_3)
								local var_362_6 = Mathf.Lerp(iter_362_1.color.b, arg_359_1.hightColor2.b, var_362_3)

								iter_362_1.color = Color.New(var_362_4, var_362_5, var_362_6)
							else
								local var_362_7 = Mathf.Lerp(iter_362_1.color.r, 0.5, var_362_3)

								iter_362_1.color = Color.New(var_362_7, var_362_7, var_362_7)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 and not isNil(var_362_0) and arg_359_1.var_.actorSpriteComps10022 then
				for iter_362_2, iter_362_3 in pairs(arg_359_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_362_3 then
						if arg_359_1.isInRecall_ then
							iter_362_3.color = arg_359_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_362_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_359_1.var_.actorSpriteComps10022 = nil
			end

			local var_362_8 = arg_359_1.actors_["10022"]
			local var_362_9 = 0

			if var_362_9 < arg_359_1.time_ and arg_359_1.time_ <= var_362_9 + arg_362_0 and not isNil(var_362_8) and arg_359_1.var_.actorSpriteComps10022 == nil then
				arg_359_1.var_.actorSpriteComps10022 = var_362_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_362_10 = 2

			if var_362_9 <= arg_359_1.time_ and arg_359_1.time_ < var_362_9 + var_362_10 and not isNil(var_362_8) then
				local var_362_11 = (arg_359_1.time_ - var_362_9) / var_362_10

				if arg_359_1.var_.actorSpriteComps10022 then
					for iter_362_4, iter_362_5 in pairs(arg_359_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_362_5 then
							if arg_359_1.isInRecall_ then
								local var_362_12 = Mathf.Lerp(iter_362_5.color.r, arg_359_1.hightColor2.r, var_362_11)
								local var_362_13 = Mathf.Lerp(iter_362_5.color.g, arg_359_1.hightColor2.g, var_362_11)
								local var_362_14 = Mathf.Lerp(iter_362_5.color.b, arg_359_1.hightColor2.b, var_362_11)

								iter_362_5.color = Color.New(var_362_12, var_362_13, var_362_14)
							else
								local var_362_15 = Mathf.Lerp(iter_362_5.color.r, 0.5, var_362_11)

								iter_362_5.color = Color.New(var_362_15, var_362_15, var_362_15)
							end
						end
					end
				end
			end

			if arg_359_1.time_ >= var_362_9 + var_362_10 and arg_359_1.time_ < var_362_9 + var_362_10 + arg_362_0 and not isNil(var_362_8) and arg_359_1.var_.actorSpriteComps10022 then
				for iter_362_6, iter_362_7 in pairs(arg_359_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_362_7 then
						if arg_359_1.isInRecall_ then
							iter_362_7.color = arg_359_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_362_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_359_1.var_.actorSpriteComps10022 = nil
			end

			local var_362_16 = 0
			local var_362_17 = 0.6

			if var_362_16 < arg_359_1.time_ and arg_359_1.time_ <= var_362_16 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_18 = arg_359_1:FormatText(StoryNameCfg[993].name)

				arg_359_1.leftNameTxt_.text = var_362_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_19 = arg_359_1:GetWordFromCfg(413081084)
				local var_362_20 = arg_359_1:FormatText(var_362_19.content)

				arg_359_1.text_.text = var_362_20

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_21 = 24
				local var_362_22 = utf8.len(var_362_20)
				local var_362_23 = var_362_21 <= 0 and var_362_17 or var_362_17 * (var_362_22 / var_362_21)

				if var_362_23 > 0 and var_362_17 < var_362_23 then
					arg_359_1.talkMaxDuration = var_362_23

					if var_362_23 + var_362_16 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_23 + var_362_16
					end
				end

				arg_359_1.text_.text = var_362_20
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081084", "story_v_out_413081.awb") ~= 0 then
					local var_362_24 = manager.audio:GetVoiceLength("story_v_out_413081", "413081084", "story_v_out_413081.awb") / 1000

					if var_362_24 + var_362_16 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_24 + var_362_16
					end

					if var_362_19.prefab_name ~= "" and arg_359_1.actors_[var_362_19.prefab_name] ~= nil then
						local var_362_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_19.prefab_name].transform, "story_v_out_413081", "413081084", "story_v_out_413081.awb")

						arg_359_1:RecordAudio("413081084", var_362_25)
						arg_359_1:RecordAudio("413081084", var_362_25)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_413081", "413081084", "story_v_out_413081.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_413081", "413081084", "story_v_out_413081.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_26 = math.max(var_362_17, arg_359_1.talkMaxDuration)

			if var_362_16 <= arg_359_1.time_ and arg_359_1.time_ < var_362_16 + var_362_26 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_16) / var_362_26

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_16 + var_362_26 and arg_359_1.time_ < var_362_16 + var_362_26 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play413081085 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 413081085
		arg_363_1.duration_ = 5.63

		local var_363_0 = {
			zh = 5.633,
			ja = 5.1
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play413081086(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["10022"].transform
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 then
				arg_363_1.var_.moveOldPos10022 = var_366_0.localPosition
				var_366_0.localScale = Vector3.New(1, 1, 1)

				arg_363_1:CheckSpriteTmpPos("10022", 2)

				local var_366_2 = var_366_0.childCount

				for iter_366_0 = 0, var_366_2 - 1 do
					local var_366_3 = var_366_0:GetChild(iter_366_0)

					if var_366_3.name == "split_6" or not string.find(var_366_3.name, "split") then
						var_366_3.gameObject:SetActive(true)
					else
						var_366_3.gameObject:SetActive(false)
					end
				end
			end

			local var_366_4 = 0.001

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_4 then
				local var_366_5 = (arg_363_1.time_ - var_366_1) / var_366_4
				local var_366_6 = Vector3.New(-390, -315, -320)

				var_366_0.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos10022, var_366_6, var_366_5)
			end

			if arg_363_1.time_ >= var_366_1 + var_366_4 and arg_363_1.time_ < var_366_1 + var_366_4 + arg_366_0 then
				var_366_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_366_7 = arg_363_1.actors_["10022"]
			local var_366_8 = 0

			if var_366_8 < arg_363_1.time_ and arg_363_1.time_ <= var_366_8 + arg_366_0 and not isNil(var_366_7) and arg_363_1.var_.actorSpriteComps10022 == nil then
				arg_363_1.var_.actorSpriteComps10022 = var_366_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_9 = 2

			if var_366_8 <= arg_363_1.time_ and arg_363_1.time_ < var_366_8 + var_366_9 and not isNil(var_366_7) then
				local var_366_10 = (arg_363_1.time_ - var_366_8) / var_366_9

				if arg_363_1.var_.actorSpriteComps10022 then
					for iter_366_1, iter_366_2 in pairs(arg_363_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_366_2 then
							if arg_363_1.isInRecall_ then
								local var_366_11 = Mathf.Lerp(iter_366_2.color.r, arg_363_1.hightColor1.r, var_366_10)
								local var_366_12 = Mathf.Lerp(iter_366_2.color.g, arg_363_1.hightColor1.g, var_366_10)
								local var_366_13 = Mathf.Lerp(iter_366_2.color.b, arg_363_1.hightColor1.b, var_366_10)

								iter_366_2.color = Color.New(var_366_11, var_366_12, var_366_13)
							else
								local var_366_14 = Mathf.Lerp(iter_366_2.color.r, 1, var_366_10)

								iter_366_2.color = Color.New(var_366_14, var_366_14, var_366_14)
							end
						end
					end
				end
			end

			if arg_363_1.time_ >= var_366_8 + var_366_9 and arg_363_1.time_ < var_366_8 + var_366_9 + arg_366_0 and not isNil(var_366_7) and arg_363_1.var_.actorSpriteComps10022 then
				for iter_366_3, iter_366_4 in pairs(arg_363_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_366_4 then
						if arg_363_1.isInRecall_ then
							iter_366_4.color = arg_363_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_366_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_363_1.var_.actorSpriteComps10022 = nil
			end

			local var_366_15 = 0
			local var_366_16 = 0.65

			if var_366_15 < arg_363_1.time_ and arg_363_1.time_ <= var_366_15 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_17 = arg_363_1:FormatText(StoryNameCfg[614].name)

				arg_363_1.leftNameTxt_.text = var_366_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_18 = arg_363_1:GetWordFromCfg(413081085)
				local var_366_19 = arg_363_1:FormatText(var_366_18.content)

				arg_363_1.text_.text = var_366_19

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_20 = 26
				local var_366_21 = utf8.len(var_366_19)
				local var_366_22 = var_366_20 <= 0 and var_366_16 or var_366_16 * (var_366_21 / var_366_20)

				if var_366_22 > 0 and var_366_16 < var_366_22 then
					arg_363_1.talkMaxDuration = var_366_22

					if var_366_22 + var_366_15 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_22 + var_366_15
					end
				end

				arg_363_1.text_.text = var_366_19
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081085", "story_v_out_413081.awb") ~= 0 then
					local var_366_23 = manager.audio:GetVoiceLength("story_v_out_413081", "413081085", "story_v_out_413081.awb") / 1000

					if var_366_23 + var_366_15 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_23 + var_366_15
					end

					if var_366_18.prefab_name ~= "" and arg_363_1.actors_[var_366_18.prefab_name] ~= nil then
						local var_366_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_18.prefab_name].transform, "story_v_out_413081", "413081085", "story_v_out_413081.awb")

						arg_363_1:RecordAudio("413081085", var_366_24)
						arg_363_1:RecordAudio("413081085", var_366_24)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_413081", "413081085", "story_v_out_413081.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_413081", "413081085", "story_v_out_413081.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_25 = math.max(var_366_16, arg_363_1.talkMaxDuration)

			if var_366_15 <= arg_363_1.time_ and arg_363_1.time_ < var_366_15 + var_366_25 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_15) / var_366_25

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_15 + var_366_25 and arg_363_1.time_ < var_366_15 + var_366_25 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play413081086 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 413081086
		arg_367_1.duration_ = 5.17

		local var_367_0 = {
			zh = 1.999999999999,
			ja = 5.166
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
				arg_367_0:Play413081087(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["10022"].transform
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1.var_.moveOldPos10022 = var_370_0.localPosition
				var_370_0.localScale = Vector3.New(1, 1, 1)

				arg_367_1:CheckSpriteTmpPos("10022", 2)

				local var_370_2 = var_370_0.childCount

				for iter_370_0 = 0, var_370_2 - 1 do
					local var_370_3 = var_370_0:GetChild(iter_370_0)

					if var_370_3.name == "" or not string.find(var_370_3.name, "split") then
						var_370_3.gameObject:SetActive(true)
					else
						var_370_3.gameObject:SetActive(false)
					end
				end
			end

			local var_370_4 = 0.001

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_4 then
				local var_370_5 = (arg_367_1.time_ - var_370_1) / var_370_4
				local var_370_6 = Vector3.New(-390, -315, -320)

				var_370_0.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos10022, var_370_6, var_370_5)
			end

			if arg_367_1.time_ >= var_370_1 + var_370_4 and arg_367_1.time_ < var_370_1 + var_370_4 + arg_370_0 then
				var_370_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_370_7 = arg_367_1.actors_["10094"]
			local var_370_8 = 0

			if var_370_8 < arg_367_1.time_ and arg_367_1.time_ <= var_370_8 + arg_370_0 and not isNil(var_370_7) and arg_367_1.var_.actorSpriteComps10094 == nil then
				arg_367_1.var_.actorSpriteComps10094 = var_370_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_9 = 2

			if var_370_8 <= arg_367_1.time_ and arg_367_1.time_ < var_370_8 + var_370_9 and not isNil(var_370_7) then
				local var_370_10 = (arg_367_1.time_ - var_370_8) / var_370_9

				if arg_367_1.var_.actorSpriteComps10094 then
					for iter_370_1, iter_370_2 in pairs(arg_367_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_370_2 then
							if arg_367_1.isInRecall_ then
								local var_370_11 = Mathf.Lerp(iter_370_2.color.r, arg_367_1.hightColor1.r, var_370_10)
								local var_370_12 = Mathf.Lerp(iter_370_2.color.g, arg_367_1.hightColor1.g, var_370_10)
								local var_370_13 = Mathf.Lerp(iter_370_2.color.b, arg_367_1.hightColor1.b, var_370_10)

								iter_370_2.color = Color.New(var_370_11, var_370_12, var_370_13)
							else
								local var_370_14 = Mathf.Lerp(iter_370_2.color.r, 1, var_370_10)

								iter_370_2.color = Color.New(var_370_14, var_370_14, var_370_14)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= var_370_8 + var_370_9 and arg_367_1.time_ < var_370_8 + var_370_9 + arg_370_0 and not isNil(var_370_7) and arg_367_1.var_.actorSpriteComps10094 then
				for iter_370_3, iter_370_4 in pairs(arg_367_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_370_4 then
						if arg_367_1.isInRecall_ then
							iter_370_4.color = arg_367_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_370_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_367_1.var_.actorSpriteComps10094 = nil
			end

			local var_370_15 = arg_367_1.actors_["10022"]
			local var_370_16 = 0

			if var_370_16 < arg_367_1.time_ and arg_367_1.time_ <= var_370_16 + arg_370_0 and not isNil(var_370_15) and arg_367_1.var_.actorSpriteComps10022 == nil then
				arg_367_1.var_.actorSpriteComps10022 = var_370_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_17 = 2

			if var_370_16 <= arg_367_1.time_ and arg_367_1.time_ < var_370_16 + var_370_17 and not isNil(var_370_15) then
				local var_370_18 = (arg_367_1.time_ - var_370_16) / var_370_17

				if arg_367_1.var_.actorSpriteComps10022 then
					for iter_370_5, iter_370_6 in pairs(arg_367_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_370_6 then
							if arg_367_1.isInRecall_ then
								local var_370_19 = Mathf.Lerp(iter_370_6.color.r, arg_367_1.hightColor2.r, var_370_18)
								local var_370_20 = Mathf.Lerp(iter_370_6.color.g, arg_367_1.hightColor2.g, var_370_18)
								local var_370_21 = Mathf.Lerp(iter_370_6.color.b, arg_367_1.hightColor2.b, var_370_18)

								iter_370_6.color = Color.New(var_370_19, var_370_20, var_370_21)
							else
								local var_370_22 = Mathf.Lerp(iter_370_6.color.r, 0.5, var_370_18)

								iter_370_6.color = Color.New(var_370_22, var_370_22, var_370_22)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= var_370_16 + var_370_17 and arg_367_1.time_ < var_370_16 + var_370_17 + arg_370_0 and not isNil(var_370_15) and arg_367_1.var_.actorSpriteComps10022 then
				for iter_370_7, iter_370_8 in pairs(arg_367_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_370_8 then
						if arg_367_1.isInRecall_ then
							iter_370_8.color = arg_367_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_370_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_367_1.var_.actorSpriteComps10022 = nil
			end

			local var_370_23 = arg_367_1.actors_["10094"].transform
			local var_370_24 = 0

			if var_370_24 < arg_367_1.time_ and arg_367_1.time_ <= var_370_24 + arg_370_0 then
				arg_367_1.var_.moveOldPos10094 = var_370_23.localPosition
				var_370_23.localScale = Vector3.New(1, 1, 1)

				arg_367_1:CheckSpriteTmpPos("10094", 4)

				local var_370_25 = var_370_23.childCount

				for iter_370_9 = 0, var_370_25 - 1 do
					local var_370_26 = var_370_23:GetChild(iter_370_9)

					if var_370_26.name == "" or not string.find(var_370_26.name, "split") then
						var_370_26.gameObject:SetActive(true)
					else
						var_370_26.gameObject:SetActive(false)
					end
				end
			end

			local var_370_27 = 0.001

			if var_370_24 <= arg_367_1.time_ and arg_367_1.time_ < var_370_24 + var_370_27 then
				local var_370_28 = (arg_367_1.time_ - var_370_24) / var_370_27
				local var_370_29 = Vector3.New(390, -315, -320)

				var_370_23.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos10094, var_370_29, var_370_28)
			end

			if arg_367_1.time_ >= var_370_24 + var_370_27 and arg_367_1.time_ < var_370_24 + var_370_27 + arg_370_0 then
				var_370_23.localPosition = Vector3.New(390, -315, -320)
			end

			local var_370_30 = 0
			local var_370_31 = 0.225

			if var_370_30 < arg_367_1.time_ and arg_367_1.time_ <= var_370_30 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_32 = arg_367_1:FormatText(StoryNameCfg[259].name)

				arg_367_1.leftNameTxt_.text = var_370_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_33 = arg_367_1:GetWordFromCfg(413081086)
				local var_370_34 = arg_367_1:FormatText(var_370_33.content)

				arg_367_1.text_.text = var_370_34

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_35 = 9
				local var_370_36 = utf8.len(var_370_34)
				local var_370_37 = var_370_35 <= 0 and var_370_31 or var_370_31 * (var_370_36 / var_370_35)

				if var_370_37 > 0 and var_370_31 < var_370_37 then
					arg_367_1.talkMaxDuration = var_370_37

					if var_370_37 + var_370_30 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_37 + var_370_30
					end
				end

				arg_367_1.text_.text = var_370_34
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081086", "story_v_out_413081.awb") ~= 0 then
					local var_370_38 = manager.audio:GetVoiceLength("story_v_out_413081", "413081086", "story_v_out_413081.awb") / 1000

					if var_370_38 + var_370_30 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_38 + var_370_30
					end

					if var_370_33.prefab_name ~= "" and arg_367_1.actors_[var_370_33.prefab_name] ~= nil then
						local var_370_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_33.prefab_name].transform, "story_v_out_413081", "413081086", "story_v_out_413081.awb")

						arg_367_1:RecordAudio("413081086", var_370_39)
						arg_367_1:RecordAudio("413081086", var_370_39)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_413081", "413081086", "story_v_out_413081.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_413081", "413081086", "story_v_out_413081.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_40 = math.max(var_370_31, arg_367_1.talkMaxDuration)

			if var_370_30 <= arg_367_1.time_ and arg_367_1.time_ < var_370_30 + var_370_40 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_30) / var_370_40

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_30 + var_370_40 and arg_367_1.time_ < var_370_30 + var_370_40 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play413081087 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 413081087
		arg_371_1.duration_ = 5.83

		local var_371_0 = {
			zh = 3,
			ja = 5.833
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play413081088(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["10022"].transform
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.var_.moveOldPos10022 = var_374_0.localPosition
				var_374_0.localScale = Vector3.New(1, 1, 1)

				arg_371_1:CheckSpriteTmpPos("10022", 2)

				local var_374_2 = var_374_0.childCount

				for iter_374_0 = 0, var_374_2 - 1 do
					local var_374_3 = var_374_0:GetChild(iter_374_0)

					if var_374_3.name == "split_6" or not string.find(var_374_3.name, "split") then
						var_374_3.gameObject:SetActive(true)
					else
						var_374_3.gameObject:SetActive(false)
					end
				end
			end

			local var_374_4 = 0.001

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_4 then
				local var_374_5 = (arg_371_1.time_ - var_374_1) / var_374_4
				local var_374_6 = Vector3.New(-390, -315, -320)

				var_374_0.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos10022, var_374_6, var_374_5)
			end

			if arg_371_1.time_ >= var_374_1 + var_374_4 and arg_371_1.time_ < var_374_1 + var_374_4 + arg_374_0 then
				var_374_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_374_7 = arg_371_1.actors_["10022"]
			local var_374_8 = 0

			if var_374_8 < arg_371_1.time_ and arg_371_1.time_ <= var_374_8 + arg_374_0 and not isNil(var_374_7) and arg_371_1.var_.actorSpriteComps10022 == nil then
				arg_371_1.var_.actorSpriteComps10022 = var_374_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_9 = 2

			if var_374_8 <= arg_371_1.time_ and arg_371_1.time_ < var_374_8 + var_374_9 and not isNil(var_374_7) then
				local var_374_10 = (arg_371_1.time_ - var_374_8) / var_374_9

				if arg_371_1.var_.actorSpriteComps10022 then
					for iter_374_1, iter_374_2 in pairs(arg_371_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_374_2 then
							if arg_371_1.isInRecall_ then
								local var_374_11 = Mathf.Lerp(iter_374_2.color.r, arg_371_1.hightColor1.r, var_374_10)
								local var_374_12 = Mathf.Lerp(iter_374_2.color.g, arg_371_1.hightColor1.g, var_374_10)
								local var_374_13 = Mathf.Lerp(iter_374_2.color.b, arg_371_1.hightColor1.b, var_374_10)

								iter_374_2.color = Color.New(var_374_11, var_374_12, var_374_13)
							else
								local var_374_14 = Mathf.Lerp(iter_374_2.color.r, 1, var_374_10)

								iter_374_2.color = Color.New(var_374_14, var_374_14, var_374_14)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= var_374_8 + var_374_9 and arg_371_1.time_ < var_374_8 + var_374_9 + arg_374_0 and not isNil(var_374_7) and arg_371_1.var_.actorSpriteComps10022 then
				for iter_374_3, iter_374_4 in pairs(arg_371_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_374_4 then
						if arg_371_1.isInRecall_ then
							iter_374_4.color = arg_371_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_374_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_371_1.var_.actorSpriteComps10022 = nil
			end

			local var_374_15 = arg_371_1.actors_["10094"]
			local var_374_16 = 0

			if var_374_16 < arg_371_1.time_ and arg_371_1.time_ <= var_374_16 + arg_374_0 and not isNil(var_374_15) and arg_371_1.var_.actorSpriteComps10094 == nil then
				arg_371_1.var_.actorSpriteComps10094 = var_374_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_17 = 2

			if var_374_16 <= arg_371_1.time_ and arg_371_1.time_ < var_374_16 + var_374_17 and not isNil(var_374_15) then
				local var_374_18 = (arg_371_1.time_ - var_374_16) / var_374_17

				if arg_371_1.var_.actorSpriteComps10094 then
					for iter_374_5, iter_374_6 in pairs(arg_371_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_374_6 then
							if arg_371_1.isInRecall_ then
								local var_374_19 = Mathf.Lerp(iter_374_6.color.r, arg_371_1.hightColor2.r, var_374_18)
								local var_374_20 = Mathf.Lerp(iter_374_6.color.g, arg_371_1.hightColor2.g, var_374_18)
								local var_374_21 = Mathf.Lerp(iter_374_6.color.b, arg_371_1.hightColor2.b, var_374_18)

								iter_374_6.color = Color.New(var_374_19, var_374_20, var_374_21)
							else
								local var_374_22 = Mathf.Lerp(iter_374_6.color.r, 0.5, var_374_18)

								iter_374_6.color = Color.New(var_374_22, var_374_22, var_374_22)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= var_374_16 + var_374_17 and arg_371_1.time_ < var_374_16 + var_374_17 + arg_374_0 and not isNil(var_374_15) and arg_371_1.var_.actorSpriteComps10094 then
				for iter_374_7, iter_374_8 in pairs(arg_371_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_374_8 then
						if arg_371_1.isInRecall_ then
							iter_374_8.color = arg_371_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_374_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_371_1.var_.actorSpriteComps10094 = nil
			end

			local var_374_23 = 0
			local var_374_24 = 0.375

			if var_374_23 < arg_371_1.time_ and arg_371_1.time_ <= var_374_23 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_25 = arg_371_1:FormatText(StoryNameCfg[614].name)

				arg_371_1.leftNameTxt_.text = var_374_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_26 = arg_371_1:GetWordFromCfg(413081087)
				local var_374_27 = arg_371_1:FormatText(var_374_26.content)

				arg_371_1.text_.text = var_374_27

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_28 = 15
				local var_374_29 = utf8.len(var_374_27)
				local var_374_30 = var_374_28 <= 0 and var_374_24 or var_374_24 * (var_374_29 / var_374_28)

				if var_374_30 > 0 and var_374_24 < var_374_30 then
					arg_371_1.talkMaxDuration = var_374_30

					if var_374_30 + var_374_23 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_30 + var_374_23
					end
				end

				arg_371_1.text_.text = var_374_27
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081087", "story_v_out_413081.awb") ~= 0 then
					local var_374_31 = manager.audio:GetVoiceLength("story_v_out_413081", "413081087", "story_v_out_413081.awb") / 1000

					if var_374_31 + var_374_23 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_31 + var_374_23
					end

					if var_374_26.prefab_name ~= "" and arg_371_1.actors_[var_374_26.prefab_name] ~= nil then
						local var_374_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_26.prefab_name].transform, "story_v_out_413081", "413081087", "story_v_out_413081.awb")

						arg_371_1:RecordAudio("413081087", var_374_32)
						arg_371_1:RecordAudio("413081087", var_374_32)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_413081", "413081087", "story_v_out_413081.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_413081", "413081087", "story_v_out_413081.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_33 = math.max(var_374_24, arg_371_1.talkMaxDuration)

			if var_374_23 <= arg_371_1.time_ and arg_371_1.time_ < var_374_23 + var_374_33 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_23) / var_374_33

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_23 + var_374_33 and arg_371_1.time_ < var_374_23 + var_374_33 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play413081088 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 413081088
		arg_375_1.duration_ = 2.47

		local var_375_0 = {
			zh = 2.466,
			ja = 2.433
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
				arg_375_0:Play413081089(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["10022"].transform
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.var_.moveOldPos10022 = var_378_0.localPosition
				var_378_0.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("10022", 2)

				local var_378_2 = var_378_0.childCount

				for iter_378_0 = 0, var_378_2 - 1 do
					local var_378_3 = var_378_0:GetChild(iter_378_0)

					if var_378_3.name == "" or not string.find(var_378_3.name, "split") then
						var_378_3.gameObject:SetActive(true)
					else
						var_378_3.gameObject:SetActive(false)
					end
				end
			end

			local var_378_4 = 0.001

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_4 then
				local var_378_5 = (arg_375_1.time_ - var_378_1) / var_378_4
				local var_378_6 = Vector3.New(-390, -315, -320)

				var_378_0.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos10022, var_378_6, var_378_5)
			end

			if arg_375_1.time_ >= var_378_1 + var_378_4 and arg_375_1.time_ < var_378_1 + var_378_4 + arg_378_0 then
				var_378_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_378_7 = arg_375_1.actors_["10094"]
			local var_378_8 = 0

			if var_378_8 < arg_375_1.time_ and arg_375_1.time_ <= var_378_8 + arg_378_0 and not isNil(var_378_7) and arg_375_1.var_.actorSpriteComps10094 == nil then
				arg_375_1.var_.actorSpriteComps10094 = var_378_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_378_9 = 2

			if var_378_8 <= arg_375_1.time_ and arg_375_1.time_ < var_378_8 + var_378_9 and not isNil(var_378_7) then
				local var_378_10 = (arg_375_1.time_ - var_378_8) / var_378_9

				if arg_375_1.var_.actorSpriteComps10094 then
					for iter_378_1, iter_378_2 in pairs(arg_375_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_378_2 then
							if arg_375_1.isInRecall_ then
								local var_378_11 = Mathf.Lerp(iter_378_2.color.r, arg_375_1.hightColor1.r, var_378_10)
								local var_378_12 = Mathf.Lerp(iter_378_2.color.g, arg_375_1.hightColor1.g, var_378_10)
								local var_378_13 = Mathf.Lerp(iter_378_2.color.b, arg_375_1.hightColor1.b, var_378_10)

								iter_378_2.color = Color.New(var_378_11, var_378_12, var_378_13)
							else
								local var_378_14 = Mathf.Lerp(iter_378_2.color.r, 1, var_378_10)

								iter_378_2.color = Color.New(var_378_14, var_378_14, var_378_14)
							end
						end
					end
				end
			end

			if arg_375_1.time_ >= var_378_8 + var_378_9 and arg_375_1.time_ < var_378_8 + var_378_9 + arg_378_0 and not isNil(var_378_7) and arg_375_1.var_.actorSpriteComps10094 then
				for iter_378_3, iter_378_4 in pairs(arg_375_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_378_4 then
						if arg_375_1.isInRecall_ then
							iter_378_4.color = arg_375_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_378_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_375_1.var_.actorSpriteComps10094 = nil
			end

			local var_378_15 = arg_375_1.actors_["10022"]
			local var_378_16 = 0

			if var_378_16 < arg_375_1.time_ and arg_375_1.time_ <= var_378_16 + arg_378_0 and not isNil(var_378_15) and arg_375_1.var_.actorSpriteComps10022 == nil then
				arg_375_1.var_.actorSpriteComps10022 = var_378_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_378_17 = 2

			if var_378_16 <= arg_375_1.time_ and arg_375_1.time_ < var_378_16 + var_378_17 and not isNil(var_378_15) then
				local var_378_18 = (arg_375_1.time_ - var_378_16) / var_378_17

				if arg_375_1.var_.actorSpriteComps10022 then
					for iter_378_5, iter_378_6 in pairs(arg_375_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_378_6 then
							if arg_375_1.isInRecall_ then
								local var_378_19 = Mathf.Lerp(iter_378_6.color.r, arg_375_1.hightColor2.r, var_378_18)
								local var_378_20 = Mathf.Lerp(iter_378_6.color.g, arg_375_1.hightColor2.g, var_378_18)
								local var_378_21 = Mathf.Lerp(iter_378_6.color.b, arg_375_1.hightColor2.b, var_378_18)

								iter_378_6.color = Color.New(var_378_19, var_378_20, var_378_21)
							else
								local var_378_22 = Mathf.Lerp(iter_378_6.color.r, 0.5, var_378_18)

								iter_378_6.color = Color.New(var_378_22, var_378_22, var_378_22)
							end
						end
					end
				end
			end

			if arg_375_1.time_ >= var_378_16 + var_378_17 and arg_375_1.time_ < var_378_16 + var_378_17 + arg_378_0 and not isNil(var_378_15) and arg_375_1.var_.actorSpriteComps10022 then
				for iter_378_7, iter_378_8 in pairs(arg_375_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_378_8 then
						if arg_375_1.isInRecall_ then
							iter_378_8.color = arg_375_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_378_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_375_1.var_.actorSpriteComps10022 = nil
			end

			local var_378_23 = 0
			local var_378_24 = 0.25

			if var_378_23 < arg_375_1.time_ and arg_375_1.time_ <= var_378_23 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_25 = arg_375_1:FormatText(StoryNameCfg[259].name)

				arg_375_1.leftNameTxt_.text = var_378_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_26 = arg_375_1:GetWordFromCfg(413081088)
				local var_378_27 = arg_375_1:FormatText(var_378_26.content)

				arg_375_1.text_.text = var_378_27

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_28 = 10
				local var_378_29 = utf8.len(var_378_27)
				local var_378_30 = var_378_28 <= 0 and var_378_24 or var_378_24 * (var_378_29 / var_378_28)

				if var_378_30 > 0 and var_378_24 < var_378_30 then
					arg_375_1.talkMaxDuration = var_378_30

					if var_378_30 + var_378_23 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_30 + var_378_23
					end
				end

				arg_375_1.text_.text = var_378_27
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081088", "story_v_out_413081.awb") ~= 0 then
					local var_378_31 = manager.audio:GetVoiceLength("story_v_out_413081", "413081088", "story_v_out_413081.awb") / 1000

					if var_378_31 + var_378_23 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_31 + var_378_23
					end

					if var_378_26.prefab_name ~= "" and arg_375_1.actors_[var_378_26.prefab_name] ~= nil then
						local var_378_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_26.prefab_name].transform, "story_v_out_413081", "413081088", "story_v_out_413081.awb")

						arg_375_1:RecordAudio("413081088", var_378_32)
						arg_375_1:RecordAudio("413081088", var_378_32)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_413081", "413081088", "story_v_out_413081.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_413081", "413081088", "story_v_out_413081.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_33 = math.max(var_378_24, arg_375_1.talkMaxDuration)

			if var_378_23 <= arg_375_1.time_ and arg_375_1.time_ < var_378_23 + var_378_33 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_23) / var_378_33

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_23 + var_378_33 and arg_375_1.time_ < var_378_23 + var_378_33 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play413081089 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 413081089
		arg_379_1.duration_ = 4

		local var_379_0 = {
			zh = 3.8,
			ja = 4
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
				arg_379_0:Play413081090(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0
			local var_382_1 = 0.35

			if var_382_0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_2 = arg_379_1:FormatText(StoryNameCfg[259].name)

				arg_379_1.leftNameTxt_.text = var_382_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_3 = arg_379_1:GetWordFromCfg(413081089)
				local var_382_4 = arg_379_1:FormatText(var_382_3.content)

				arg_379_1.text_.text = var_382_4

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_5 = 14
				local var_382_6 = utf8.len(var_382_4)
				local var_382_7 = var_382_5 <= 0 and var_382_1 or var_382_1 * (var_382_6 / var_382_5)

				if var_382_7 > 0 and var_382_1 < var_382_7 then
					arg_379_1.talkMaxDuration = var_382_7

					if var_382_7 + var_382_0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_0
					end
				end

				arg_379_1.text_.text = var_382_4
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081089", "story_v_out_413081.awb") ~= 0 then
					local var_382_8 = manager.audio:GetVoiceLength("story_v_out_413081", "413081089", "story_v_out_413081.awb") / 1000

					if var_382_8 + var_382_0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_8 + var_382_0
					end

					if var_382_3.prefab_name ~= "" and arg_379_1.actors_[var_382_3.prefab_name] ~= nil then
						local var_382_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_3.prefab_name].transform, "story_v_out_413081", "413081089", "story_v_out_413081.awb")

						arg_379_1:RecordAudio("413081089", var_382_9)
						arg_379_1:RecordAudio("413081089", var_382_9)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_413081", "413081089", "story_v_out_413081.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_413081", "413081089", "story_v_out_413081.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_10 = math.max(var_382_1, arg_379_1.talkMaxDuration)

			if var_382_0 <= arg_379_1.time_ and arg_379_1.time_ < var_382_0 + var_382_10 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_0) / var_382_10

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_0 + var_382_10 and arg_379_1.time_ < var_382_0 + var_382_10 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play413081090 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 413081090
		arg_383_1.duration_ = 6.07

		local var_383_0 = {
			zh = 4.866,
			ja = 6.066
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play413081091(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["10022"].transform
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 then
				arg_383_1.var_.moveOldPos10022 = var_386_0.localPosition
				var_386_0.localScale = Vector3.New(1, 1, 1)

				arg_383_1:CheckSpriteTmpPos("10022", 2)

				local var_386_2 = var_386_0.childCount

				for iter_386_0 = 0, var_386_2 - 1 do
					local var_386_3 = var_386_0:GetChild(iter_386_0)

					if var_386_3.name == "split_3" or not string.find(var_386_3.name, "split") then
						var_386_3.gameObject:SetActive(true)
					else
						var_386_3.gameObject:SetActive(false)
					end
				end
			end

			local var_386_4 = 0.001

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_4 then
				local var_386_5 = (arg_383_1.time_ - var_386_1) / var_386_4
				local var_386_6 = Vector3.New(-390, -315, -320)

				var_386_0.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos10022, var_386_6, var_386_5)
			end

			if arg_383_1.time_ >= var_386_1 + var_386_4 and arg_383_1.time_ < var_386_1 + var_386_4 + arg_386_0 then
				var_386_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_386_7 = arg_383_1.actors_["10022"]
			local var_386_8 = 0

			if var_386_8 < arg_383_1.time_ and arg_383_1.time_ <= var_386_8 + arg_386_0 and not isNil(var_386_7) and arg_383_1.var_.actorSpriteComps10022 == nil then
				arg_383_1.var_.actorSpriteComps10022 = var_386_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_9 = 2

			if var_386_8 <= arg_383_1.time_ and arg_383_1.time_ < var_386_8 + var_386_9 and not isNil(var_386_7) then
				local var_386_10 = (arg_383_1.time_ - var_386_8) / var_386_9

				if arg_383_1.var_.actorSpriteComps10022 then
					for iter_386_1, iter_386_2 in pairs(arg_383_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_386_2 then
							if arg_383_1.isInRecall_ then
								local var_386_11 = Mathf.Lerp(iter_386_2.color.r, arg_383_1.hightColor1.r, var_386_10)
								local var_386_12 = Mathf.Lerp(iter_386_2.color.g, arg_383_1.hightColor1.g, var_386_10)
								local var_386_13 = Mathf.Lerp(iter_386_2.color.b, arg_383_1.hightColor1.b, var_386_10)

								iter_386_2.color = Color.New(var_386_11, var_386_12, var_386_13)
							else
								local var_386_14 = Mathf.Lerp(iter_386_2.color.r, 1, var_386_10)

								iter_386_2.color = Color.New(var_386_14, var_386_14, var_386_14)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= var_386_8 + var_386_9 and arg_383_1.time_ < var_386_8 + var_386_9 + arg_386_0 and not isNil(var_386_7) and arg_383_1.var_.actorSpriteComps10022 then
				for iter_386_3, iter_386_4 in pairs(arg_383_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_386_4 then
						if arg_383_1.isInRecall_ then
							iter_386_4.color = arg_383_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_386_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_383_1.var_.actorSpriteComps10022 = nil
			end

			local var_386_15 = arg_383_1.actors_["10094"]
			local var_386_16 = 0

			if var_386_16 < arg_383_1.time_ and arg_383_1.time_ <= var_386_16 + arg_386_0 and not isNil(var_386_15) and arg_383_1.var_.actorSpriteComps10094 == nil then
				arg_383_1.var_.actorSpriteComps10094 = var_386_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_17 = 2

			if var_386_16 <= arg_383_1.time_ and arg_383_1.time_ < var_386_16 + var_386_17 and not isNil(var_386_15) then
				local var_386_18 = (arg_383_1.time_ - var_386_16) / var_386_17

				if arg_383_1.var_.actorSpriteComps10094 then
					for iter_386_5, iter_386_6 in pairs(arg_383_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_386_6 then
							if arg_383_1.isInRecall_ then
								local var_386_19 = Mathf.Lerp(iter_386_6.color.r, arg_383_1.hightColor2.r, var_386_18)
								local var_386_20 = Mathf.Lerp(iter_386_6.color.g, arg_383_1.hightColor2.g, var_386_18)
								local var_386_21 = Mathf.Lerp(iter_386_6.color.b, arg_383_1.hightColor2.b, var_386_18)

								iter_386_6.color = Color.New(var_386_19, var_386_20, var_386_21)
							else
								local var_386_22 = Mathf.Lerp(iter_386_6.color.r, 0.5, var_386_18)

								iter_386_6.color = Color.New(var_386_22, var_386_22, var_386_22)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= var_386_16 + var_386_17 and arg_383_1.time_ < var_386_16 + var_386_17 + arg_386_0 and not isNil(var_386_15) and arg_383_1.var_.actorSpriteComps10094 then
				for iter_386_7, iter_386_8 in pairs(arg_383_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_386_8 then
						if arg_383_1.isInRecall_ then
							iter_386_8.color = arg_383_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_386_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_383_1.var_.actorSpriteComps10094 = nil
			end

			local var_386_23 = 0
			local var_386_24 = 0.45

			if var_386_23 < arg_383_1.time_ and arg_383_1.time_ <= var_386_23 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_25 = arg_383_1:FormatText(StoryNameCfg[614].name)

				arg_383_1.leftNameTxt_.text = var_386_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_26 = arg_383_1:GetWordFromCfg(413081090)
				local var_386_27 = arg_383_1:FormatText(var_386_26.content)

				arg_383_1.text_.text = var_386_27

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_28 = 18
				local var_386_29 = utf8.len(var_386_27)
				local var_386_30 = var_386_28 <= 0 and var_386_24 or var_386_24 * (var_386_29 / var_386_28)

				if var_386_30 > 0 and var_386_24 < var_386_30 then
					arg_383_1.talkMaxDuration = var_386_30

					if var_386_30 + var_386_23 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_30 + var_386_23
					end
				end

				arg_383_1.text_.text = var_386_27
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081090", "story_v_out_413081.awb") ~= 0 then
					local var_386_31 = manager.audio:GetVoiceLength("story_v_out_413081", "413081090", "story_v_out_413081.awb") / 1000

					if var_386_31 + var_386_23 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_31 + var_386_23
					end

					if var_386_26.prefab_name ~= "" and arg_383_1.actors_[var_386_26.prefab_name] ~= nil then
						local var_386_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_26.prefab_name].transform, "story_v_out_413081", "413081090", "story_v_out_413081.awb")

						arg_383_1:RecordAudio("413081090", var_386_32)
						arg_383_1:RecordAudio("413081090", var_386_32)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_413081", "413081090", "story_v_out_413081.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_413081", "413081090", "story_v_out_413081.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_33 = math.max(var_386_24, arg_383_1.talkMaxDuration)

			if var_386_23 <= arg_383_1.time_ and arg_383_1.time_ < var_386_23 + var_386_33 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_23) / var_386_33

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_23 + var_386_33 and arg_383_1.time_ < var_386_23 + var_386_33 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_383_1:InitPlayNodeList()
	end,
	Play413081091 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 413081091
		arg_387_1.duration_ = 6.63

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play413081092(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = arg_387_1.actors_["10022"].transform
			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 then
				arg_387_1.var_.moveOldPos10022 = var_390_0.localPosition
				var_390_0.localScale = Vector3.New(1, 1, 1)

				arg_387_1:CheckSpriteTmpPos("10022", 0)

				local var_390_2 = var_390_0.childCount

				for iter_390_0 = 0, var_390_2 - 1 do
					local var_390_3 = var_390_0:GetChild(iter_390_0)

					if var_390_3.name == "" or not string.find(var_390_3.name, "split") then
						var_390_3.gameObject:SetActive(true)
					else
						var_390_3.gameObject:SetActive(false)
					end
				end
			end

			local var_390_4 = 0.001

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_4 then
				local var_390_5 = (arg_387_1.time_ - var_390_1) / var_390_4
				local var_390_6 = Vector3.New(-5000, -315, -320)

				var_390_0.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos10022, var_390_6, var_390_5)
			end

			if arg_387_1.time_ >= var_390_1 + var_390_4 and arg_387_1.time_ < var_390_1 + var_390_4 + arg_390_0 then
				var_390_0.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_390_7 = arg_387_1.actors_["10094"].transform
			local var_390_8 = 0

			if var_390_8 < arg_387_1.time_ and arg_387_1.time_ <= var_390_8 + arg_390_0 then
				arg_387_1.var_.moveOldPos10094 = var_390_7.localPosition
				var_390_7.localScale = Vector3.New(1, 1, 1)

				arg_387_1:CheckSpriteTmpPos("10094", 0)

				local var_390_9 = var_390_7.childCount

				for iter_390_1 = 0, var_390_9 - 1 do
					local var_390_10 = var_390_7:GetChild(iter_390_1)

					if var_390_10.name == "" or not string.find(var_390_10.name, "split") then
						var_390_10.gameObject:SetActive(true)
					else
						var_390_10.gameObject:SetActive(false)
					end
				end
			end

			local var_390_11 = 0.001

			if var_390_8 <= arg_387_1.time_ and arg_387_1.time_ < var_390_8 + var_390_11 then
				local var_390_12 = (arg_387_1.time_ - var_390_8) / var_390_11
				local var_390_13 = Vector3.New(-5000, -340, -414)

				var_390_7.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos10094, var_390_13, var_390_12)
			end

			if arg_387_1.time_ >= var_390_8 + var_390_11 and arg_387_1.time_ < var_390_8 + var_390_11 + arg_390_0 then
				var_390_7.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_390_14 = arg_387_1.actors_["10022"]
			local var_390_15 = 0

			if var_390_15 < arg_387_1.time_ and arg_387_1.time_ <= var_390_15 + arg_390_0 and not isNil(var_390_14) and arg_387_1.var_.actorSpriteComps10022 == nil then
				arg_387_1.var_.actorSpriteComps10022 = var_390_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_390_16 = 2

			if var_390_15 <= arg_387_1.time_ and arg_387_1.time_ < var_390_15 + var_390_16 and not isNil(var_390_14) then
				local var_390_17 = (arg_387_1.time_ - var_390_15) / var_390_16

				if arg_387_1.var_.actorSpriteComps10022 then
					for iter_390_2, iter_390_3 in pairs(arg_387_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_390_3 then
							if arg_387_1.isInRecall_ then
								local var_390_18 = Mathf.Lerp(iter_390_3.color.r, arg_387_1.hightColor2.r, var_390_17)
								local var_390_19 = Mathf.Lerp(iter_390_3.color.g, arg_387_1.hightColor2.g, var_390_17)
								local var_390_20 = Mathf.Lerp(iter_390_3.color.b, arg_387_1.hightColor2.b, var_390_17)

								iter_390_3.color = Color.New(var_390_18, var_390_19, var_390_20)
							else
								local var_390_21 = Mathf.Lerp(iter_390_3.color.r, 0.5, var_390_17)

								iter_390_3.color = Color.New(var_390_21, var_390_21, var_390_21)
							end
						end
					end
				end
			end

			if arg_387_1.time_ >= var_390_15 + var_390_16 and arg_387_1.time_ < var_390_15 + var_390_16 + arg_390_0 and not isNil(var_390_14) and arg_387_1.var_.actorSpriteComps10022 then
				for iter_390_4, iter_390_5 in pairs(arg_387_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_390_5 then
						if arg_387_1.isInRecall_ then
							iter_390_5.color = arg_387_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_390_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_387_1.var_.actorSpriteComps10022 = nil
			end

			local var_390_22 = arg_387_1.actors_["10094"]
			local var_390_23 = 0

			if var_390_23 < arg_387_1.time_ and arg_387_1.time_ <= var_390_23 + arg_390_0 and not isNil(var_390_22) and arg_387_1.var_.actorSpriteComps10094 == nil then
				arg_387_1.var_.actorSpriteComps10094 = var_390_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_390_24 = 2

			if var_390_23 <= arg_387_1.time_ and arg_387_1.time_ < var_390_23 + var_390_24 and not isNil(var_390_22) then
				local var_390_25 = (arg_387_1.time_ - var_390_23) / var_390_24

				if arg_387_1.var_.actorSpriteComps10094 then
					for iter_390_6, iter_390_7 in pairs(arg_387_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_390_7 then
							if arg_387_1.isInRecall_ then
								local var_390_26 = Mathf.Lerp(iter_390_7.color.r, arg_387_1.hightColor2.r, var_390_25)
								local var_390_27 = Mathf.Lerp(iter_390_7.color.g, arg_387_1.hightColor2.g, var_390_25)
								local var_390_28 = Mathf.Lerp(iter_390_7.color.b, arg_387_1.hightColor2.b, var_390_25)

								iter_390_7.color = Color.New(var_390_26, var_390_27, var_390_28)
							else
								local var_390_29 = Mathf.Lerp(iter_390_7.color.r, 0.5, var_390_25)

								iter_390_7.color = Color.New(var_390_29, var_390_29, var_390_29)
							end
						end
					end
				end
			end

			if arg_387_1.time_ >= var_390_23 + var_390_24 and arg_387_1.time_ < var_390_23 + var_390_24 + arg_390_0 and not isNil(var_390_22) and arg_387_1.var_.actorSpriteComps10094 then
				for iter_390_8, iter_390_9 in pairs(arg_387_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_390_9 then
						if arg_387_1.isInRecall_ then
							iter_390_9.color = arg_387_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_390_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_387_1.var_.actorSpriteComps10094 = nil
			end

			local var_390_30 = manager.ui.mainCamera.transform
			local var_390_31 = 0

			if var_390_31 < arg_387_1.time_ and arg_387_1.time_ <= var_390_31 + arg_390_0 then
				local var_390_32 = arg_387_1.var_.effectquanyao1
				local var_390_33
				local var_390_34 = var_390_30

				if not var_390_32 then
					var_390_32 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), var_390_34)
					var_390_32.name = "quanyao1"
					arg_387_1.var_.effectquanyao1 = var_390_32
				else
					var_390_32.transform:SetParent(var_390_34)
				end

				var_390_32.transform.localPosition = Vector3.New(0, 0, 0)
				var_390_32.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_390_35 = manager.ui.mainCamera.transform
			local var_390_36 = 1.46666666666667

			if var_390_36 < arg_387_1.time_ and arg_387_1.time_ <= var_390_36 + arg_390_0 then
				local var_390_37 = arg_387_1.var_.effectquanyao1

				if var_390_37 then
					Object.Destroy(var_390_37)

					arg_387_1.var_.effectquanyao1 = nil
				end
			end

			local var_390_38 = 0

			if var_390_38 < arg_387_1.time_ and arg_387_1.time_ <= var_390_38 + arg_390_0 then
				arg_387_1.mask_.enabled = true
				arg_387_1.mask_.raycastTarget = true

				arg_387_1:SetGaussion(false)
			end

			local var_390_39 = 1

			if var_390_38 <= arg_387_1.time_ and arg_387_1.time_ < var_390_38 + var_390_39 then
				local var_390_40 = (arg_387_1.time_ - var_390_38) / var_390_39
				local var_390_41 = Color.New(1, 1, 1)

				var_390_41.a = Mathf.Lerp(0, 1, var_390_40)
				arg_387_1.mask_.color = var_390_41
			end

			if arg_387_1.time_ >= var_390_38 + var_390_39 and arg_387_1.time_ < var_390_38 + var_390_39 + arg_390_0 then
				local var_390_42 = Color.New(1, 1, 1)

				var_390_42.a = 1
				arg_387_1.mask_.color = var_390_42
			end

			local var_390_43 = 1

			if var_390_43 < arg_387_1.time_ and arg_387_1.time_ <= var_390_43 + arg_390_0 then
				arg_387_1.mask_.enabled = true
				arg_387_1.mask_.raycastTarget = true

				arg_387_1:SetGaussion(false)
			end

			local var_390_44 = 0.75

			if var_390_43 <= arg_387_1.time_ and arg_387_1.time_ < var_390_43 + var_390_44 then
				local var_390_45 = (arg_387_1.time_ - var_390_43) / var_390_44
				local var_390_46 = Color.New(1, 1, 1)

				var_390_46.a = Mathf.Lerp(1, 0, var_390_45)
				arg_387_1.mask_.color = var_390_46
			end

			if arg_387_1.time_ >= var_390_43 + var_390_44 and arg_387_1.time_ < var_390_43 + var_390_44 + arg_390_0 then
				local var_390_47 = Color.New(1, 1, 1)
				local var_390_48 = 0

				arg_387_1.mask_.enabled = false
				var_390_47.a = var_390_48
				arg_387_1.mask_.color = var_390_47
			end

			local var_390_49 = 0
			local var_390_50 = 0.491666666666667

			if var_390_49 < arg_387_1.time_ and arg_387_1.time_ <= var_390_49 + arg_390_0 then
				local var_390_51 = "play"
				local var_390_52 = "effect"

				arg_387_1:AudioAction(var_390_51, var_390_52, "se_story_134_01", "se_story_134_01_skill01", "")
			end

			if arg_387_1.frameCnt_ <= 1 then
				arg_387_1.dialog_:SetActive(false)
			end

			local var_390_53 = 1.63333333333333
			local var_390_54 = 1.675

			if var_390_53 < arg_387_1.time_ and arg_387_1.time_ <= var_390_53 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0

				arg_387_1.dialog_:SetActive(true)

				arg_387_1.dialogCg_.alpha = 0

				local var_390_55 = LeanTween.value(arg_387_1.dialog_, 0, 1, 0.3)

				var_390_55:setOnUpdate(LuaHelper.FloatAction(function(arg_391_0)
					arg_387_1.dialogCg_.alpha = arg_391_0
				end))
				var_390_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_387_1.dialog_)
					var_390_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_387_1.duration_ = arg_387_1.duration_ + 0.3

				SetActive(arg_387_1.leftNameGo_, false)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_56 = arg_387_1:GetWordFromCfg(413081091)
				local var_390_57 = arg_387_1:FormatText(var_390_56.content)

				arg_387_1.text_.text = var_390_57

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_58 = 67
				local var_390_59 = utf8.len(var_390_57)
				local var_390_60 = var_390_58 <= 0 and var_390_54 or var_390_54 * (var_390_59 / var_390_58)

				if var_390_60 > 0 and var_390_54 < var_390_60 then
					arg_387_1.talkMaxDuration = var_390_60
					var_390_53 = var_390_53 + 0.3

					if var_390_60 + var_390_53 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_60 + var_390_53
					end
				end

				arg_387_1.text_.text = var_390_57
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)
				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_61 = var_390_53 + 0.3
			local var_390_62 = math.max(var_390_54, arg_387_1.talkMaxDuration)

			if var_390_61 <= arg_387_1.time_ and arg_387_1.time_ < var_390_61 + var_390_62 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_61) / var_390_62

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_61 + var_390_62 and arg_387_1.time_ < var_390_61 + var_390_62 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_387_1:InitPlayNodeList()
	end,
	Play413081092 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 413081092
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play413081093(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0
			local var_396_1 = 1.225

			if var_396_0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_2 = arg_393_1:GetWordFromCfg(413081092)
				local var_396_3 = arg_393_1:FormatText(var_396_2.content)

				arg_393_1.text_.text = var_396_3

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_4 = 49
				local var_396_5 = utf8.len(var_396_3)
				local var_396_6 = var_396_4 <= 0 and var_396_1 or var_396_1 * (var_396_5 / var_396_4)

				if var_396_6 > 0 and var_396_1 < var_396_6 then
					arg_393_1.talkMaxDuration = var_396_6

					if var_396_6 + var_396_0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_6 + var_396_0
					end
				end

				arg_393_1.text_.text = var_396_3
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_7 = math.max(var_396_1, arg_393_1.talkMaxDuration)

			if var_396_0 <= arg_393_1.time_ and arg_393_1.time_ < var_396_0 + var_396_7 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_0) / var_396_7

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_0 + var_396_7 and arg_393_1.time_ < var_396_0 + var_396_7 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play413081093 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 413081093
		arg_397_1.duration_ = 5.73

		local var_397_0 = {
			zh = 2.766,
			ja = 5.733
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play413081094(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["10022"].transform
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 then
				arg_397_1.var_.moveOldPos10022 = var_400_0.localPosition
				var_400_0.localScale = Vector3.New(1, 1, 1)

				arg_397_1:CheckSpriteTmpPos("10022", 3)

				local var_400_2 = var_400_0.childCount

				for iter_400_0 = 0, var_400_2 - 1 do
					local var_400_3 = var_400_0:GetChild(iter_400_0)

					if var_400_3.name == "split_8" or not string.find(var_400_3.name, "split") then
						var_400_3.gameObject:SetActive(true)
					else
						var_400_3.gameObject:SetActive(false)
					end
				end
			end

			local var_400_4 = 0.001

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_4 then
				local var_400_5 = (arg_397_1.time_ - var_400_1) / var_400_4
				local var_400_6 = Vector3.New(0, -315, -320)

				var_400_0.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos10022, var_400_6, var_400_5)
			end

			if arg_397_1.time_ >= var_400_1 + var_400_4 and arg_397_1.time_ < var_400_1 + var_400_4 + arg_400_0 then
				var_400_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_400_7 = arg_397_1.actors_["10022"]
			local var_400_8 = 0

			if var_400_8 < arg_397_1.time_ and arg_397_1.time_ <= var_400_8 + arg_400_0 and not isNil(var_400_7) and arg_397_1.var_.actorSpriteComps10022 == nil then
				arg_397_1.var_.actorSpriteComps10022 = var_400_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_9 = 2

			if var_400_8 <= arg_397_1.time_ and arg_397_1.time_ < var_400_8 + var_400_9 and not isNil(var_400_7) then
				local var_400_10 = (arg_397_1.time_ - var_400_8) / var_400_9

				if arg_397_1.var_.actorSpriteComps10022 then
					for iter_400_1, iter_400_2 in pairs(arg_397_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_400_2 then
							if arg_397_1.isInRecall_ then
								local var_400_11 = Mathf.Lerp(iter_400_2.color.r, arg_397_1.hightColor1.r, var_400_10)
								local var_400_12 = Mathf.Lerp(iter_400_2.color.g, arg_397_1.hightColor1.g, var_400_10)
								local var_400_13 = Mathf.Lerp(iter_400_2.color.b, arg_397_1.hightColor1.b, var_400_10)

								iter_400_2.color = Color.New(var_400_11, var_400_12, var_400_13)
							else
								local var_400_14 = Mathf.Lerp(iter_400_2.color.r, 1, var_400_10)

								iter_400_2.color = Color.New(var_400_14, var_400_14, var_400_14)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= var_400_8 + var_400_9 and arg_397_1.time_ < var_400_8 + var_400_9 + arg_400_0 and not isNil(var_400_7) and arg_397_1.var_.actorSpriteComps10022 then
				for iter_400_3, iter_400_4 in pairs(arg_397_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_400_4 then
						if arg_397_1.isInRecall_ then
							iter_400_4.color = arg_397_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_400_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_397_1.var_.actorSpriteComps10022 = nil
			end

			local var_400_15 = 0
			local var_400_16 = 0.325

			if var_400_15 < arg_397_1.time_ and arg_397_1.time_ <= var_400_15 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_17 = arg_397_1:FormatText(StoryNameCfg[614].name)

				arg_397_1.leftNameTxt_.text = var_400_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_18 = arg_397_1:GetWordFromCfg(413081093)
				local var_400_19 = arg_397_1:FormatText(var_400_18.content)

				arg_397_1.text_.text = var_400_19

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_20 = 13
				local var_400_21 = utf8.len(var_400_19)
				local var_400_22 = var_400_20 <= 0 and var_400_16 or var_400_16 * (var_400_21 / var_400_20)

				if var_400_22 > 0 and var_400_16 < var_400_22 then
					arg_397_1.talkMaxDuration = var_400_22

					if var_400_22 + var_400_15 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_22 + var_400_15
					end
				end

				arg_397_1.text_.text = var_400_19
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081093", "story_v_out_413081.awb") ~= 0 then
					local var_400_23 = manager.audio:GetVoiceLength("story_v_out_413081", "413081093", "story_v_out_413081.awb") / 1000

					if var_400_23 + var_400_15 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_23 + var_400_15
					end

					if var_400_18.prefab_name ~= "" and arg_397_1.actors_[var_400_18.prefab_name] ~= nil then
						local var_400_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_18.prefab_name].transform, "story_v_out_413081", "413081093", "story_v_out_413081.awb")

						arg_397_1:RecordAudio("413081093", var_400_24)
						arg_397_1:RecordAudio("413081093", var_400_24)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_413081", "413081093", "story_v_out_413081.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_413081", "413081093", "story_v_out_413081.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_25 = math.max(var_400_16, arg_397_1.talkMaxDuration)

			if var_400_15 <= arg_397_1.time_ and arg_397_1.time_ < var_400_15 + var_400_25 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_15) / var_400_25

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_15 + var_400_25 and arg_397_1.time_ < var_400_15 + var_400_25 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	Play413081094 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 413081094
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play413081095(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["10022"].transform
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.var_.moveOldPos10022 = var_404_0.localPosition
				var_404_0.localScale = Vector3.New(1, 1, 1)

				arg_401_1:CheckSpriteTmpPos("10022", 7)

				local var_404_2 = var_404_0.childCount

				for iter_404_0 = 0, var_404_2 - 1 do
					local var_404_3 = var_404_0:GetChild(iter_404_0)

					if var_404_3.name == "" or not string.find(var_404_3.name, "split") then
						var_404_3.gameObject:SetActive(true)
					else
						var_404_3.gameObject:SetActive(false)
					end
				end
			end

			local var_404_4 = 0.001

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_4 then
				local var_404_5 = (arg_401_1.time_ - var_404_1) / var_404_4
				local var_404_6 = Vector3.New(0, -2000, 0)

				var_404_0.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos10022, var_404_6, var_404_5)
			end

			if arg_401_1.time_ >= var_404_1 + var_404_4 and arg_401_1.time_ < var_404_1 + var_404_4 + arg_404_0 then
				var_404_0.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_404_7 = 0
			local var_404_8 = 0.2

			if var_404_7 < arg_401_1.time_ and arg_401_1.time_ <= var_404_7 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_9 = arg_401_1:GetWordFromCfg(413081094)
				local var_404_10 = arg_401_1:FormatText(var_404_9.content)

				arg_401_1.text_.text = var_404_10

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_11 = 48
				local var_404_12 = utf8.len(var_404_10)
				local var_404_13 = var_404_11 <= 0 and var_404_8 or var_404_8 * (var_404_12 / var_404_11)

				if var_404_13 > 0 and var_404_8 < var_404_13 then
					arg_401_1.talkMaxDuration = var_404_13

					if var_404_13 + var_404_7 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_13 + var_404_7
					end
				end

				arg_401_1.text_.text = var_404_10
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_14 = math.max(var_404_8, arg_401_1.talkMaxDuration)

			if var_404_7 <= arg_401_1.time_ and arg_401_1.time_ < var_404_7 + var_404_14 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_7) / var_404_14

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_7 + var_404_14 and arg_401_1.time_ < var_404_7 + var_404_14 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play413081095 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 413081095
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play413081096(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0.2
			local var_408_1 = 1

			if var_408_0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				local var_408_2 = "play"
				local var_408_3 = "effect"

				arg_405_1:AudioAction(var_408_2, var_408_3, "se_story_121_04", "se_story_121_04_magic", "")
			end

			local var_408_4 = 0.991666666666667
			local var_408_5 = 0.533333333333333

			if var_408_4 < arg_405_1.time_ and arg_405_1.time_ <= var_408_4 + arg_408_0 then
				local var_408_6 = "play"
				local var_408_7 = "effect"

				arg_405_1:AudioAction(var_408_6, var_408_7, "se_story_128", "se_story_128_magic", "")
			end

			local var_408_8 = 0
			local var_408_9 = 1.525

			if var_408_8 < arg_405_1.time_ and arg_405_1.time_ <= var_408_8 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_10 = arg_405_1:GetWordFromCfg(413081095)
				local var_408_11 = arg_405_1:FormatText(var_408_10.content)

				arg_405_1.text_.text = var_408_11

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_12 = 61
				local var_408_13 = utf8.len(var_408_11)
				local var_408_14 = var_408_12 <= 0 and var_408_9 or var_408_9 * (var_408_13 / var_408_12)

				if var_408_14 > 0 and var_408_9 < var_408_14 then
					arg_405_1.talkMaxDuration = var_408_14

					if var_408_14 + var_408_8 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_14 + var_408_8
					end
				end

				arg_405_1.text_.text = var_408_11
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_15 = math.max(var_408_9, arg_405_1.talkMaxDuration)

			if var_408_8 <= arg_405_1.time_ and arg_405_1.time_ < var_408_8 + var_408_15 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_8) / var_408_15

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_8 + var_408_15 and arg_405_1.time_ < var_408_8 + var_408_15 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play413081096 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 413081096
		arg_409_1.duration_ = 6.27

		local var_409_0 = {
			zh = 5.233,
			ja = 6.266
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
			arg_409_1.auto_ = false
		end

		function arg_409_1.playNext_(arg_411_0)
			arg_409_1.onStoryFinished_()
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["10022"].transform
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.var_.moveOldPos10022 = var_412_0.localPosition
				var_412_0.localScale = Vector3.New(1, 1, 1)

				arg_409_1:CheckSpriteTmpPos("10022", 3)

				local var_412_2 = var_412_0.childCount

				for iter_412_0 = 0, var_412_2 - 1 do
					local var_412_3 = var_412_0:GetChild(iter_412_0)

					if var_412_3.name == "split_8" or not string.find(var_412_3.name, "split") then
						var_412_3.gameObject:SetActive(true)
					else
						var_412_3.gameObject:SetActive(false)
					end
				end
			end

			local var_412_4 = 0.001

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_4 then
				local var_412_5 = (arg_409_1.time_ - var_412_1) / var_412_4
				local var_412_6 = Vector3.New(0, -315, -320)

				var_412_0.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos10022, var_412_6, var_412_5)
			end

			if arg_409_1.time_ >= var_412_1 + var_412_4 and arg_409_1.time_ < var_412_1 + var_412_4 + arg_412_0 then
				var_412_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_412_7 = arg_409_1.actors_["10022"]
			local var_412_8 = 0

			if var_412_8 < arg_409_1.time_ and arg_409_1.time_ <= var_412_8 + arg_412_0 and not isNil(var_412_7) and arg_409_1.var_.actorSpriteComps10022 == nil then
				arg_409_1.var_.actorSpriteComps10022 = var_412_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_412_9 = 2

			if var_412_8 <= arg_409_1.time_ and arg_409_1.time_ < var_412_8 + var_412_9 and not isNil(var_412_7) then
				local var_412_10 = (arg_409_1.time_ - var_412_8) / var_412_9

				if arg_409_1.var_.actorSpriteComps10022 then
					for iter_412_1, iter_412_2 in pairs(arg_409_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_412_2 then
							if arg_409_1.isInRecall_ then
								local var_412_11 = Mathf.Lerp(iter_412_2.color.r, arg_409_1.hightColor1.r, var_412_10)
								local var_412_12 = Mathf.Lerp(iter_412_2.color.g, arg_409_1.hightColor1.g, var_412_10)
								local var_412_13 = Mathf.Lerp(iter_412_2.color.b, arg_409_1.hightColor1.b, var_412_10)

								iter_412_2.color = Color.New(var_412_11, var_412_12, var_412_13)
							else
								local var_412_14 = Mathf.Lerp(iter_412_2.color.r, 1, var_412_10)

								iter_412_2.color = Color.New(var_412_14, var_412_14, var_412_14)
							end
						end
					end
				end
			end

			if arg_409_1.time_ >= var_412_8 + var_412_9 and arg_409_1.time_ < var_412_8 + var_412_9 + arg_412_0 and not isNil(var_412_7) and arg_409_1.var_.actorSpriteComps10022 then
				for iter_412_3, iter_412_4 in pairs(arg_409_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_412_4 then
						if arg_409_1.isInRecall_ then
							iter_412_4.color = arg_409_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_412_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_409_1.var_.actorSpriteComps10022 = nil
			end

			local var_412_15 = 0
			local var_412_16 = 0.6

			if var_412_15 < arg_409_1.time_ and arg_409_1.time_ <= var_412_15 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				local var_412_17 = arg_409_1:FormatText(StoryNameCfg[614].name)

				arg_409_1.leftNameTxt_.text = var_412_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_18 = arg_409_1:GetWordFromCfg(413081096)
				local var_412_19 = arg_409_1:FormatText(var_412_18.content)

				arg_409_1.text_.text = var_412_19

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_20 = 24
				local var_412_21 = utf8.len(var_412_19)
				local var_412_22 = var_412_20 <= 0 and var_412_16 or var_412_16 * (var_412_21 / var_412_20)

				if var_412_22 > 0 and var_412_16 < var_412_22 then
					arg_409_1.talkMaxDuration = var_412_22

					if var_412_22 + var_412_15 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_22 + var_412_15
					end
				end

				arg_409_1.text_.text = var_412_19
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413081", "413081096", "story_v_out_413081.awb") ~= 0 then
					local var_412_23 = manager.audio:GetVoiceLength("story_v_out_413081", "413081096", "story_v_out_413081.awb") / 1000

					if var_412_23 + var_412_15 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_23 + var_412_15
					end

					if var_412_18.prefab_name ~= "" and arg_409_1.actors_[var_412_18.prefab_name] ~= nil then
						local var_412_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_18.prefab_name].transform, "story_v_out_413081", "413081096", "story_v_out_413081.awb")

						arg_409_1:RecordAudio("413081096", var_412_24)
						arg_409_1:RecordAudio("413081096", var_412_24)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_413081", "413081096", "story_v_out_413081.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_413081", "413081096", "story_v_out_413081.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_25 = math.max(var_412_16, arg_409_1.talkMaxDuration)

			if var_412_15 <= arg_409_1.time_ and arg_409_1.time_ < var_412_15 + var_412_25 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_15) / var_412_25

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_15 + var_412_25 and arg_409_1.time_ < var_412_15 + var_412_25 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F08m",
		"TextureConfig/Background/F08i"
	},
	voices = {
		"story_v_out_413081.awb"
	}
}
