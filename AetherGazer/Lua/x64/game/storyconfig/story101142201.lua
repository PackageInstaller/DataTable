return {
	Play114221001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114221001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play114221002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F03"

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
				local var_4_5 = arg_1_1.bgs_.F03

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
					if iter_4_0 ~= "F03" then
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
			local var_4_23 = 1

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

			local var_4_28 = 2
			local var_4_29 = 1.53333333333333

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				local var_4_30 = "play"
				local var_4_31 = "music"

				arg_1_1:AudioAction(var_4_30, var_4_31, "bgm_activity_1_4_story_source", "bgm_activity_1_4_story_source", "bgm_activity_1_4_story_source.awb")

				local var_4_32 = ""
				local var_4_33 = manager.audio:GetAudioName("bgm_activity_1_4_story_source", "bgm_activity_1_4_story_source")

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
			local var_4_35 = 1.225

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

				local var_4_37 = arg_1_1:GetWordFromCfg(114221001)
				local var_4_38 = arg_1_1:FormatText(var_4_37.content)

				arg_1_1.text_.text = var_4_38

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_39 = 49
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
	Play114221002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114221002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play114221003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0
			local var_12_1 = 1.4

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

				local var_12_2 = arg_9_1:GetWordFromCfg(114221002)
				local var_12_3 = arg_9_1:FormatText(var_12_2.content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 56
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
	Play114221003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114221003
		arg_13_1.duration_ = 9.77

		local var_13_0 = {
			ja = 7.7,
			ko = 6.7,
			zh = 5.6,
			en = 9.766
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play114221004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "10015"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10015")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(var_16_1, arg_13_1.canvasGo_.transform)

					var_16_2.transform:SetSiblingIndex(1)

					var_16_2.name = var_16_0
					var_16_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_[var_16_0] = var_16_2

					local var_16_3 = var_16_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_13_1.isInRecall_ then
						for iter_16_0, iter_16_1 in ipairs(var_16_3) do
							iter_16_1.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_4 = arg_13_1.actors_["10015"].transform
			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.var_.moveOldPos10015 = var_16_4.localPosition
				var_16_4.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10015", 3)

				local var_16_6 = var_16_4.childCount

				for iter_16_2 = 0, var_16_6 - 1 do
					local var_16_7 = var_16_4:GetChild(iter_16_2)

					if var_16_7.name == "split_6" or not string.find(var_16_7.name, "split") then
						var_16_7.gameObject:SetActive(true)
					else
						var_16_7.gameObject:SetActive(false)
					end
				end
			end

			local var_16_8 = 0.001

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_8 then
				local var_16_9 = (arg_13_1.time_ - var_16_5) / var_16_8
				local var_16_10 = Vector3.New(0, -350, -180)

				var_16_4.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10015, var_16_10, var_16_9)
			end

			if arg_13_1.time_ >= var_16_5 + var_16_8 and arg_13_1.time_ < var_16_5 + var_16_8 + arg_16_0 then
				var_16_4.localPosition = Vector3.New(0, -350, -180)
			end

			local var_16_11 = arg_13_1.actors_["10015"]
			local var_16_12 = 0

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 and not isNil(var_16_11) and arg_13_1.var_.actorSpriteComps10015 == nil then
				arg_13_1.var_.actorSpriteComps10015 = var_16_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_13 = 0.034

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_13 and not isNil(var_16_11) then
				local var_16_14 = (arg_13_1.time_ - var_16_12) / var_16_13

				if arg_13_1.var_.actorSpriteComps10015 then
					for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_16_4 then
							if arg_13_1.isInRecall_ then
								local var_16_15 = Mathf.Lerp(iter_16_4.color.r, arg_13_1.hightColor1.r, var_16_14)
								local var_16_16 = Mathf.Lerp(iter_16_4.color.g, arg_13_1.hightColor1.g, var_16_14)
								local var_16_17 = Mathf.Lerp(iter_16_4.color.b, arg_13_1.hightColor1.b, var_16_14)

								iter_16_4.color = Color.New(var_16_15, var_16_16, var_16_17)
							else
								local var_16_18 = Mathf.Lerp(iter_16_4.color.r, 1, var_16_14)

								iter_16_4.color = Color.New(var_16_18, var_16_18, var_16_18)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= var_16_12 + var_16_13 and arg_13_1.time_ < var_16_12 + var_16_13 + arg_16_0 and not isNil(var_16_11) and arg_13_1.var_.actorSpriteComps10015 then
				for iter_16_5, iter_16_6 in pairs(arg_13_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_16_6 then
						if arg_13_1.isInRecall_ then
							iter_16_6.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_16_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_13_1.var_.actorSpriteComps10015 = nil
			end

			local var_16_19 = arg_13_1.actors_["10015"]
			local var_16_20 = 0

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				local var_16_21 = var_16_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_16_21 then
					arg_13_1.var_.alphaOldValue10015 = var_16_21.alpha
					arg_13_1.var_.characterEffect10015 = var_16_21
				end

				arg_13_1.var_.alphaOldValue10015 = 0
			end

			local var_16_22 = 0.5

			if var_16_20 <= arg_13_1.time_ and arg_13_1.time_ < var_16_20 + var_16_22 then
				local var_16_23 = (arg_13_1.time_ - var_16_20) / var_16_22
				local var_16_24 = Mathf.Lerp(arg_13_1.var_.alphaOldValue10015, 1, var_16_23)

				if arg_13_1.var_.characterEffect10015 then
					arg_13_1.var_.characterEffect10015.alpha = var_16_24
				end
			end

			if arg_13_1.time_ >= var_16_20 + var_16_22 and arg_13_1.time_ < var_16_20 + var_16_22 + arg_16_0 and arg_13_1.var_.characterEffect10015 then
				arg_13_1.var_.characterEffect10015.alpha = 1
			end

			local var_16_25 = 0
			local var_16_26 = 0.55

			if var_16_25 < arg_13_1.time_ and arg_13_1.time_ <= var_16_25 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_27 = arg_13_1:FormatText(StoryNameCfg[208].name)

				arg_13_1.leftNameTxt_.text = var_16_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_28 = arg_13_1:GetWordFromCfg(114221003)
				local var_16_29 = arg_13_1:FormatText(var_16_28.content)

				arg_13_1.text_.text = var_16_29

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_30 = 22
				local var_16_31 = utf8.len(var_16_29)
				local var_16_32 = var_16_30 <= 0 and var_16_26 or var_16_26 * (var_16_31 / var_16_30)

				if var_16_32 > 0 and var_16_26 < var_16_32 then
					arg_13_1.talkMaxDuration = var_16_32

					if var_16_32 + var_16_25 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_32 + var_16_25
					end
				end

				arg_13_1.text_.text = var_16_29
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114221", "114221003", "story_v_out_114221.awb") ~= 0 then
					local var_16_33 = manager.audio:GetVoiceLength("story_v_out_114221", "114221003", "story_v_out_114221.awb") / 1000

					if var_16_33 + var_16_25 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_33 + var_16_25
					end

					if var_16_28.prefab_name ~= "" and arg_13_1.actors_[var_16_28.prefab_name] ~= nil then
						local var_16_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_28.prefab_name].transform, "story_v_out_114221", "114221003", "story_v_out_114221.awb")

						arg_13_1:RecordAudio("114221003", var_16_34)
						arg_13_1:RecordAudio("114221003", var_16_34)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_114221", "114221003", "story_v_out_114221.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_114221", "114221003", "story_v_out_114221.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_35 = math.max(var_16_26, arg_13_1.talkMaxDuration)

			if var_16_25 <= arg_13_1.time_ and arg_13_1.time_ < var_16_25 + var_16_35 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_25) / var_16_35

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_25 + var_16_35 and arg_13_1.time_ < var_16_25 + var_16_35 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play114221004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114221004
		arg_17_1.duration_ = 6.2

		local var_17_0 = {
			ja = 5.333,
			ko = 6.2,
			zh = 5.2,
			en = 6.033
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
				arg_17_0:Play114221005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.625

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[208].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:GetWordFromCfg(114221004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 25
				local var_20_6 = utf8.len(var_20_4)
				local var_20_7 = var_20_5 <= 0 and var_20_1 or var_20_1 * (var_20_6 / var_20_5)

				if var_20_7 > 0 and var_20_1 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114221", "114221004", "story_v_out_114221.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_114221", "114221004", "story_v_out_114221.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_114221", "114221004", "story_v_out_114221.awb")

						arg_17_1:RecordAudio("114221004", var_20_9)
						arg_17_1:RecordAudio("114221004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_114221", "114221004", "story_v_out_114221.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_114221", "114221004", "story_v_out_114221.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_10 and arg_17_1.time_ < var_20_0 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play114221005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114221005
		arg_21_1.duration_ = 15.37

		local var_21_0 = {
			ja = 11.533,
			ko = 14.933,
			zh = 15.366,
			en = 14.9
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
				arg_21_0:Play114221006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "10016"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Object.Instantiate(arg_21_1.imageGo_, arg_21_1.canvasGo_.transform)

				var_24_1.transform:SetSiblingIndex(1)

				var_24_1.name = var_24_0

				local var_24_2 = var_24_1:GetComponent(typeof(Image))

				var_24_2.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "10016")

				var_24_2:SetNativeSize()

				var_24_1.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_21_1.actors_[var_24_0] = var_24_1
			end

			local var_24_3 = arg_21_1.actors_["10016"].transform
			local var_24_4 = 3.8

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.var_.moveOldPos10016 = var_24_3.localPosition
				var_24_3.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10016", 2)
			end

			local var_24_5 = 0.001

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_5 then
				local var_24_6 = (arg_21_1.time_ - var_24_4) / var_24_5
				local var_24_7 = Vector3.New(-390, -350, -180)

				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10016, var_24_7, var_24_6)
			end

			if arg_21_1.time_ >= var_24_4 + var_24_5 and arg_21_1.time_ < var_24_4 + var_24_5 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_24_8 = arg_21_1.actors_["10016"]
			local var_24_9 = 3.8

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 and not isNil(var_24_8) then
				local var_24_10 = var_24_8:GetComponent("Image")

				if var_24_10 then
					arg_21_1.var_.highlightMatValue10016 = var_24_10
				end
			end

			local var_24_11 = 0.034

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_11 and not isNil(var_24_8) then
				local var_24_12 = (arg_21_1.time_ - var_24_9) / var_24_11

				if arg_21_1.var_.highlightMatValue10016 then
					local var_24_13 = Mathf.Lerp(0.5, 1, var_24_12)
					local var_24_14 = arg_21_1.var_.highlightMatValue10016
					local var_24_15 = var_24_14.color

					var_24_15.r = var_24_13
					var_24_15.g = var_24_13
					var_24_15.b = var_24_13
					var_24_14.color = var_24_15
				end
			end

			if arg_21_1.time_ >= var_24_9 + var_24_11 and arg_21_1.time_ < var_24_9 + var_24_11 + arg_24_0 and not isNil(var_24_8) and arg_21_1.var_.highlightMatValue10016 then
				local var_24_16 = 1

				var_24_8.transform:SetSiblingIndex(1)

				local var_24_17 = arg_21_1.var_.highlightMatValue10016
				local var_24_18 = var_24_17.color

				var_24_18.r = var_24_16
				var_24_18.g = var_24_16
				var_24_18.b = var_24_16
				var_24_17.color = var_24_18
			end

			local var_24_19 = arg_21_1.actors_["10016"]
			local var_24_20 = 3.8

			if var_24_20 < arg_21_1.time_ and arg_21_1.time_ <= var_24_20 + arg_24_0 then
				local var_24_21 = var_24_19:GetComponent("Image")

				if var_24_21 then
					arg_21_1.var_.alphaMatValue10016 = var_24_21
					arg_21_1.var_.alphaOldValue10016 = var_24_21.color.a
				end

				arg_21_1.var_.alphaOldValue10016 = 0
			end

			local var_24_22 = 0.5

			if var_24_20 <= arg_21_1.time_ and arg_21_1.time_ < var_24_20 + var_24_22 then
				local var_24_23 = (arg_21_1.time_ - var_24_20) / var_24_22
				local var_24_24 = Mathf.Lerp(arg_21_1.var_.alphaOldValue10016, 1, var_24_23)

				if arg_21_1.var_.alphaMatValue10016 then
					local var_24_25 = arg_21_1.var_.alphaMatValue10016.color

					var_24_25.a = var_24_24
					arg_21_1.var_.alphaMatValue10016.color = var_24_25
				end
			end

			if arg_21_1.time_ >= var_24_20 + var_24_22 and arg_21_1.time_ < var_24_20 + var_24_22 + arg_24_0 and arg_21_1.var_.alphaMatValue10016 then
				local var_24_26 = arg_21_1.var_.alphaMatValue10016
				local var_24_27 = var_24_26.color

				var_24_27.a = 1
				var_24_26.color = var_24_27
			end

			local var_24_28 = 0

			if var_24_28 < arg_21_1.time_ and arg_21_1.time_ <= var_24_28 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_29 = 2

			if var_24_28 <= arg_21_1.time_ and arg_21_1.time_ < var_24_28 + var_24_29 then
				local var_24_30 = (arg_21_1.time_ - var_24_28) / var_24_29
				local var_24_31 = Color.New(0, 0, 0)

				var_24_31.a = Mathf.Lerp(0, 1, var_24_30)
				arg_21_1.mask_.color = var_24_31
			end

			if arg_21_1.time_ >= var_24_28 + var_24_29 and arg_21_1.time_ < var_24_28 + var_24_29 + arg_24_0 then
				local var_24_32 = Color.New(0, 0, 0)

				var_24_32.a = 1
				arg_21_1.mask_.color = var_24_32
			end

			local var_24_33 = 2

			if var_24_33 < arg_21_1.time_ and arg_21_1.time_ <= var_24_33 + arg_24_0 then
				arg_21_1.mask_.enabled = true
				arg_21_1.mask_.raycastTarget = true

				arg_21_1:SetGaussion(false)
			end

			local var_24_34 = 2

			if var_24_33 <= arg_21_1.time_ and arg_21_1.time_ < var_24_33 + var_24_34 then
				local var_24_35 = (arg_21_1.time_ - var_24_33) / var_24_34
				local var_24_36 = Color.New(0, 0, 0)

				var_24_36.a = Mathf.Lerp(1, 0, var_24_35)
				arg_21_1.mask_.color = var_24_36
			end

			if arg_21_1.time_ >= var_24_33 + var_24_34 and arg_21_1.time_ < var_24_33 + var_24_34 + arg_24_0 then
				local var_24_37 = Color.New(0, 0, 0)
				local var_24_38 = 0

				arg_21_1.mask_.enabled = false
				var_24_37.a = var_24_38
				arg_21_1.mask_.color = var_24_37
			end

			local var_24_39 = arg_21_1.actors_["10015"].transform
			local var_24_40 = 1.966

			if var_24_40 < arg_21_1.time_ and arg_21_1.time_ <= var_24_40 + arg_24_0 then
				arg_21_1.var_.moveOldPos10015 = var_24_39.localPosition
				var_24_39.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10015", 7)

				local var_24_41 = var_24_39.childCount

				for iter_24_0 = 0, var_24_41 - 1 do
					local var_24_42 = var_24_39:GetChild(iter_24_0)

					if var_24_42.name == "split_6" or not string.find(var_24_42.name, "split") then
						var_24_42.gameObject:SetActive(true)
					else
						var_24_42.gameObject:SetActive(false)
					end
				end
			end

			local var_24_43 = 0.001

			if var_24_40 <= arg_21_1.time_ and arg_21_1.time_ < var_24_40 + var_24_43 then
				local var_24_44 = (arg_21_1.time_ - var_24_40) / var_24_43
				local var_24_45 = Vector3.New(0, -2000, -180)

				var_24_39.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10015, var_24_45, var_24_44)
			end

			if arg_21_1.time_ >= var_24_40 + var_24_43 and arg_21_1.time_ < var_24_40 + var_24_43 + arg_24_0 then
				var_24_39.localPosition = Vector3.New(0, -2000, -180)
			end

			if arg_21_1.frameCnt_ <= 1 then
				arg_21_1.dialog_:SetActive(false)
			end

			local var_24_46 = 4
			local var_24_47 = 1

			if var_24_46 < arg_21_1.time_ and arg_21_1.time_ <= var_24_46 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_48 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_48:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_48:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_48:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_49 = arg_21_1:FormatText(StoryNameCfg[226].name)

				arg_21_1.leftNameTxt_.text = var_24_49

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_50 = arg_21_1:GetWordFromCfg(114221005)
				local var_24_51 = arg_21_1:FormatText(var_24_50.content)

				arg_21_1.text_.text = var_24_51

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_52 = 40
				local var_24_53 = utf8.len(var_24_51)
				local var_24_54 = var_24_52 <= 0 and var_24_47 or var_24_47 * (var_24_53 / var_24_52)

				if var_24_54 > 0 and var_24_47 < var_24_54 then
					arg_21_1.talkMaxDuration = var_24_54
					var_24_46 = var_24_46 + 0.3

					if var_24_54 + var_24_46 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_54 + var_24_46
					end
				end

				arg_21_1.text_.text = var_24_51
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114221", "114221005", "story_v_out_114221.awb") ~= 0 then
					local var_24_55 = manager.audio:GetVoiceLength("story_v_out_114221", "114221005", "story_v_out_114221.awb") / 1000

					if var_24_55 + var_24_46 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_55 + var_24_46
					end

					if var_24_50.prefab_name ~= "" and arg_21_1.actors_[var_24_50.prefab_name] ~= nil then
						local var_24_56 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_50.prefab_name].transform, "story_v_out_114221", "114221005", "story_v_out_114221.awb")

						arg_21_1:RecordAudio("114221005", var_24_56)
						arg_21_1:RecordAudio("114221005", var_24_56)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_114221", "114221005", "story_v_out_114221.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_114221", "114221005", "story_v_out_114221.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_57 = var_24_46 + 0.3
			local var_24_58 = math.max(var_24_47, arg_21_1.talkMaxDuration)

			if var_24_57 <= arg_21_1.time_ and arg_21_1.time_ < var_24_57 + var_24_58 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_57) / var_24_58

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_57 + var_24_58 and arg_21_1.time_ < var_24_57 + var_24_58 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10016",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			},
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play114221006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 114221006
		arg_27_1.duration_ = 4.13

		local var_27_0 = {
			ja = 4.133,
			ko = 3.3,
			zh = 2.1,
			en = 2.2
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
				arg_27_0:Play114221007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["10015"].transform
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.var_.moveOldPos10015 = var_30_0.localPosition
				var_30_0.localScale = Vector3.New(1, 1, 1)

				arg_27_1:CheckSpriteTmpPos("10015", 4)

				local var_30_2 = var_30_0.childCount

				for iter_30_0 = 0, var_30_2 - 1 do
					local var_30_3 = var_30_0:GetChild(iter_30_0)

					if var_30_3.name == "split_5" or not string.find(var_30_3.name, "split") then
						var_30_3.gameObject:SetActive(true)
					else
						var_30_3.gameObject:SetActive(false)
					end
				end
			end

			local var_30_4 = 0.001

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_4 then
				local var_30_5 = (arg_27_1.time_ - var_30_1) / var_30_4
				local var_30_6 = Vector3.New(390, -350, -180)

				var_30_0.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos10015, var_30_6, var_30_5)
			end

			if arg_27_1.time_ >= var_30_1 + var_30_4 and arg_27_1.time_ < var_30_1 + var_30_4 + arg_30_0 then
				var_30_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_30_7 = arg_27_1.actors_["10016"]
			local var_30_8 = 0

			if var_30_8 < arg_27_1.time_ and arg_27_1.time_ <= var_30_8 + arg_30_0 and not isNil(var_30_7) then
				local var_30_9 = var_30_7:GetComponent("Image")

				if var_30_9 then
					arg_27_1.var_.highlightMatValue10016 = var_30_9
				end
			end

			local var_30_10 = 0.034

			if var_30_8 <= arg_27_1.time_ and arg_27_1.time_ < var_30_8 + var_30_10 and not isNil(var_30_7) then
				local var_30_11 = (arg_27_1.time_ - var_30_8) / var_30_10

				if arg_27_1.var_.highlightMatValue10016 then
					local var_30_12 = Mathf.Lerp(1, 0.5, var_30_11)
					local var_30_13 = arg_27_1.var_.highlightMatValue10016
					local var_30_14 = var_30_13.color

					var_30_14.r = var_30_12
					var_30_14.g = var_30_12
					var_30_14.b = var_30_12
					var_30_13.color = var_30_14
				end
			end

			if arg_27_1.time_ >= var_30_8 + var_30_10 and arg_27_1.time_ < var_30_8 + var_30_10 + arg_30_0 and not isNil(var_30_7) and arg_27_1.var_.highlightMatValue10016 then
				local var_30_15 = 0.5
				local var_30_16 = arg_27_1.var_.highlightMatValue10016
				local var_30_17 = var_30_16.color

				var_30_17.r = var_30_15
				var_30_17.g = var_30_15
				var_30_17.b = var_30_15
				var_30_16.color = var_30_17
			end

			local var_30_18 = arg_27_1.actors_["10015"]
			local var_30_19 = 0

			if var_30_19 < arg_27_1.time_ and arg_27_1.time_ <= var_30_19 + arg_30_0 and not isNil(var_30_18) and arg_27_1.var_.actorSpriteComps10015 == nil then
				arg_27_1.var_.actorSpriteComps10015 = var_30_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_20 = 0.034

			if var_30_19 <= arg_27_1.time_ and arg_27_1.time_ < var_30_19 + var_30_20 and not isNil(var_30_18) then
				local var_30_21 = (arg_27_1.time_ - var_30_19) / var_30_20

				if arg_27_1.var_.actorSpriteComps10015 then
					for iter_30_1, iter_30_2 in pairs(arg_27_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_30_2 then
							if arg_27_1.isInRecall_ then
								local var_30_22 = Mathf.Lerp(iter_30_2.color.r, arg_27_1.hightColor1.r, var_30_21)
								local var_30_23 = Mathf.Lerp(iter_30_2.color.g, arg_27_1.hightColor1.g, var_30_21)
								local var_30_24 = Mathf.Lerp(iter_30_2.color.b, arg_27_1.hightColor1.b, var_30_21)

								iter_30_2.color = Color.New(var_30_22, var_30_23, var_30_24)
							else
								local var_30_25 = Mathf.Lerp(iter_30_2.color.r, 1, var_30_21)

								iter_30_2.color = Color.New(var_30_25, var_30_25, var_30_25)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= var_30_19 + var_30_20 and arg_27_1.time_ < var_30_19 + var_30_20 + arg_30_0 and not isNil(var_30_18) and arg_27_1.var_.actorSpriteComps10015 then
				for iter_30_3, iter_30_4 in pairs(arg_27_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_30_4 then
						if arg_27_1.isInRecall_ then
							iter_30_4.color = arg_27_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_30_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_27_1.var_.actorSpriteComps10015 = nil
			end

			local var_30_26 = arg_27_1.actors_["10015"]
			local var_30_27 = 0

			if var_30_27 < arg_27_1.time_ and arg_27_1.time_ <= var_30_27 + arg_30_0 then
				local var_30_28 = var_30_26:GetComponentInChildren(typeof(CanvasGroup))

				if var_30_28 then
					arg_27_1.var_.alphaOldValue10015 = var_30_28.alpha
					arg_27_1.var_.characterEffect10015 = var_30_28
				end

				arg_27_1.var_.alphaOldValue10015 = 0
			end

			local var_30_29 = 0.5

			if var_30_27 <= arg_27_1.time_ and arg_27_1.time_ < var_30_27 + var_30_29 then
				local var_30_30 = (arg_27_1.time_ - var_30_27) / var_30_29
				local var_30_31 = Mathf.Lerp(arg_27_1.var_.alphaOldValue10015, 1, var_30_30)

				if arg_27_1.var_.characterEffect10015 then
					arg_27_1.var_.characterEffect10015.alpha = var_30_31
				end
			end

			if arg_27_1.time_ >= var_30_27 + var_30_29 and arg_27_1.time_ < var_30_27 + var_30_29 + arg_30_0 and arg_27_1.var_.characterEffect10015 then
				arg_27_1.var_.characterEffect10015.alpha = 1
			end

			local var_30_32 = 0
			local var_30_33 = 0.25

			if var_30_32 < arg_27_1.time_ and arg_27_1.time_ <= var_30_32 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_34 = arg_27_1:FormatText(StoryNameCfg[208].name)

				arg_27_1.leftNameTxt_.text = var_30_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_35 = arg_27_1:GetWordFromCfg(114221006)
				local var_30_36 = arg_27_1:FormatText(var_30_35.content)

				arg_27_1.text_.text = var_30_36

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_37 = 10
				local var_30_38 = utf8.len(var_30_36)
				local var_30_39 = var_30_37 <= 0 and var_30_33 or var_30_33 * (var_30_38 / var_30_37)

				if var_30_39 > 0 and var_30_33 < var_30_39 then
					arg_27_1.talkMaxDuration = var_30_39

					if var_30_39 + var_30_32 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_39 + var_30_32
					end
				end

				arg_27_1.text_.text = var_30_36
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114221", "114221006", "story_v_out_114221.awb") ~= 0 then
					local var_30_40 = manager.audio:GetVoiceLength("story_v_out_114221", "114221006", "story_v_out_114221.awb") / 1000

					if var_30_40 + var_30_32 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_40 + var_30_32
					end

					if var_30_35.prefab_name ~= "" and arg_27_1.actors_[var_30_35.prefab_name] ~= nil then
						local var_30_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_35.prefab_name].transform, "story_v_out_114221", "114221006", "story_v_out_114221.awb")

						arg_27_1:RecordAudio("114221006", var_30_41)
						arg_27_1:RecordAudio("114221006", var_30_41)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_114221", "114221006", "story_v_out_114221.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_114221", "114221006", "story_v_out_114221.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_42 = math.max(var_30_33, arg_27_1.talkMaxDuration)

			if var_30_32 <= arg_27_1.time_ and arg_27_1.time_ < var_30_32 + var_30_42 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_32) / var_30_42

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_32 + var_30_42 and arg_27_1.time_ < var_30_32 + var_30_42 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play114221007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 114221007
		arg_31_1.duration_ = 7

		local var_31_0 = {
			ja = 3.133,
			ko = 5.2,
			zh = 7,
			en = 4.833
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
				arg_31_0:Play114221008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["10016"]
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 and not isNil(var_34_0) then
				local var_34_2 = var_34_0:GetComponent("Image")

				if var_34_2 then
					arg_31_1.var_.highlightMatValue10016 = var_34_2
				end
			end

			local var_34_3 = 0.034

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_3 and not isNil(var_34_0) then
				local var_34_4 = (arg_31_1.time_ - var_34_1) / var_34_3

				if arg_31_1.var_.highlightMatValue10016 then
					local var_34_5 = Mathf.Lerp(0.5, 1, var_34_4)
					local var_34_6 = arg_31_1.var_.highlightMatValue10016
					local var_34_7 = var_34_6.color

					var_34_7.r = var_34_5
					var_34_7.g = var_34_5
					var_34_7.b = var_34_5
					var_34_6.color = var_34_7
				end
			end

			if arg_31_1.time_ >= var_34_1 + var_34_3 and arg_31_1.time_ < var_34_1 + var_34_3 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.highlightMatValue10016 then
				local var_34_8 = 1

				var_34_0.transform:SetSiblingIndex(1)

				local var_34_9 = arg_31_1.var_.highlightMatValue10016
				local var_34_10 = var_34_9.color

				var_34_10.r = var_34_8
				var_34_10.g = var_34_8
				var_34_10.b = var_34_8
				var_34_9.color = var_34_10
			end

			local var_34_11 = arg_31_1.actors_["10015"]
			local var_34_12 = 0

			if var_34_12 < arg_31_1.time_ and arg_31_1.time_ <= var_34_12 + arg_34_0 and not isNil(var_34_11) and arg_31_1.var_.actorSpriteComps10015 == nil then
				arg_31_1.var_.actorSpriteComps10015 = var_34_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_13 = 0.034

			if var_34_12 <= arg_31_1.time_ and arg_31_1.time_ < var_34_12 + var_34_13 and not isNil(var_34_11) then
				local var_34_14 = (arg_31_1.time_ - var_34_12) / var_34_13

				if arg_31_1.var_.actorSpriteComps10015 then
					for iter_34_0, iter_34_1 in pairs(arg_31_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_34_1 then
							if arg_31_1.isInRecall_ then
								local var_34_15 = Mathf.Lerp(iter_34_1.color.r, arg_31_1.hightColor2.r, var_34_14)
								local var_34_16 = Mathf.Lerp(iter_34_1.color.g, arg_31_1.hightColor2.g, var_34_14)
								local var_34_17 = Mathf.Lerp(iter_34_1.color.b, arg_31_1.hightColor2.b, var_34_14)

								iter_34_1.color = Color.New(var_34_15, var_34_16, var_34_17)
							else
								local var_34_18 = Mathf.Lerp(iter_34_1.color.r, 0.5, var_34_14)

								iter_34_1.color = Color.New(var_34_18, var_34_18, var_34_18)
							end
						end
					end
				end
			end

			if arg_31_1.time_ >= var_34_12 + var_34_13 and arg_31_1.time_ < var_34_12 + var_34_13 + arg_34_0 and not isNil(var_34_11) and arg_31_1.var_.actorSpriteComps10015 then
				for iter_34_2, iter_34_3 in pairs(arg_31_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_34_3 then
						if arg_31_1.isInRecall_ then
							iter_34_3.color = arg_31_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_34_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_31_1.var_.actorSpriteComps10015 = nil
			end

			local var_34_19 = 0
			local var_34_20 = 0.425

			if var_34_19 < arg_31_1.time_ and arg_31_1.time_ <= var_34_19 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_21 = arg_31_1:FormatText(StoryNameCfg[226].name)

				arg_31_1.leftNameTxt_.text = var_34_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_22 = arg_31_1:GetWordFromCfg(114221007)
				local var_34_23 = arg_31_1:FormatText(var_34_22.content)

				arg_31_1.text_.text = var_34_23

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_24 = 17
				local var_34_25 = utf8.len(var_34_23)
				local var_34_26 = var_34_24 <= 0 and var_34_20 or var_34_20 * (var_34_25 / var_34_24)

				if var_34_26 > 0 and var_34_20 < var_34_26 then
					arg_31_1.talkMaxDuration = var_34_26

					if var_34_26 + var_34_19 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_26 + var_34_19
					end
				end

				arg_31_1.text_.text = var_34_23
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114221", "114221007", "story_v_out_114221.awb") ~= 0 then
					local var_34_27 = manager.audio:GetVoiceLength("story_v_out_114221", "114221007", "story_v_out_114221.awb") / 1000

					if var_34_27 + var_34_19 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_27 + var_34_19
					end

					if var_34_22.prefab_name ~= "" and arg_31_1.actors_[var_34_22.prefab_name] ~= nil then
						local var_34_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_22.prefab_name].transform, "story_v_out_114221", "114221007", "story_v_out_114221.awb")

						arg_31_1:RecordAudio("114221007", var_34_28)
						arg_31_1:RecordAudio("114221007", var_34_28)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_114221", "114221007", "story_v_out_114221.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_114221", "114221007", "story_v_out_114221.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_29 = math.max(var_34_20, arg_31_1.talkMaxDuration)

			if var_34_19 <= arg_31_1.time_ and arg_31_1.time_ < var_34_19 + var_34_29 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_19) / var_34_29

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_19 + var_34_29 and arg_31_1.time_ < var_34_19 + var_34_29 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play114221008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 114221008
		arg_35_1.duration_ = 9.87

		local var_35_0 = {
			ja = 9.5,
			ko = 9.866,
			zh = 9.333,
			en = 9.4
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
				arg_35_0:Play114221009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0
			local var_38_1 = 0.925

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_2 = arg_35_1:FormatText(StoryNameCfg[226].name)

				arg_35_1.leftNameTxt_.text = var_38_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_3 = arg_35_1:GetWordFromCfg(114221008)
				local var_38_4 = arg_35_1:FormatText(var_38_3.content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 37
				local var_38_6 = utf8.len(var_38_4)
				local var_38_7 = var_38_5 <= 0 and var_38_1 or var_38_1 * (var_38_6 / var_38_5)

				if var_38_7 > 0 and var_38_1 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_0
					end
				end

				arg_35_1.text_.text = var_38_4
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114221", "114221008", "story_v_out_114221.awb") ~= 0 then
					local var_38_8 = manager.audio:GetVoiceLength("story_v_out_114221", "114221008", "story_v_out_114221.awb") / 1000

					if var_38_8 + var_38_0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_8 + var_38_0
					end

					if var_38_3.prefab_name ~= "" and arg_35_1.actors_[var_38_3.prefab_name] ~= nil then
						local var_38_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_3.prefab_name].transform, "story_v_out_114221", "114221008", "story_v_out_114221.awb")

						arg_35_1:RecordAudio("114221008", var_38_9)
						arg_35_1:RecordAudio("114221008", var_38_9)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_114221", "114221008", "story_v_out_114221.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_114221", "114221008", "story_v_out_114221.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_10 = math.max(var_38_1, arg_35_1.talkMaxDuration)

			if var_38_0 <= arg_35_1.time_ and arg_35_1.time_ < var_38_0 + var_38_10 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_0) / var_38_10

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_0 + var_38_10 and arg_35_1.time_ < var_38_0 + var_38_10 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play114221009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 114221009
		arg_39_1.duration_ = 5.47

		local var_39_0 = {
			ja = 4.966,
			ko = 5.466,
			zh = 3.933,
			en = 3.833
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
				arg_39_0:Play114221010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["10016"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) then
				local var_42_2 = var_42_0:GetComponent("Image")

				if var_42_2 then
					arg_39_1.var_.highlightMatValue10016 = var_42_2
				end
			end

			local var_42_3 = 0.034

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_3 and not isNil(var_42_0) then
				local var_42_4 = (arg_39_1.time_ - var_42_1) / var_42_3

				if arg_39_1.var_.highlightMatValue10016 then
					local var_42_5 = Mathf.Lerp(1, 0.5, var_42_4)
					local var_42_6 = arg_39_1.var_.highlightMatValue10016
					local var_42_7 = var_42_6.color

					var_42_7.r = var_42_5
					var_42_7.g = var_42_5
					var_42_7.b = var_42_5
					var_42_6.color = var_42_7
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_3 and arg_39_1.time_ < var_42_1 + var_42_3 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.highlightMatValue10016 then
				local var_42_8 = 0.5
				local var_42_9 = arg_39_1.var_.highlightMatValue10016
				local var_42_10 = var_42_9.color

				var_42_10.r = var_42_8
				var_42_10.g = var_42_8
				var_42_10.b = var_42_8
				var_42_9.color = var_42_10
			end

			local var_42_11 = arg_39_1.actors_["10015"]
			local var_42_12 = 0

			if var_42_12 < arg_39_1.time_ and arg_39_1.time_ <= var_42_12 + arg_42_0 and not isNil(var_42_11) and arg_39_1.var_.actorSpriteComps10015 == nil then
				arg_39_1.var_.actorSpriteComps10015 = var_42_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_13 = 0.034

			if var_42_12 <= arg_39_1.time_ and arg_39_1.time_ < var_42_12 + var_42_13 and not isNil(var_42_11) then
				local var_42_14 = (arg_39_1.time_ - var_42_12) / var_42_13

				if arg_39_1.var_.actorSpriteComps10015 then
					for iter_42_0, iter_42_1 in pairs(arg_39_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_42_1 then
							if arg_39_1.isInRecall_ then
								local var_42_15 = Mathf.Lerp(iter_42_1.color.r, arg_39_1.hightColor1.r, var_42_14)
								local var_42_16 = Mathf.Lerp(iter_42_1.color.g, arg_39_1.hightColor1.g, var_42_14)
								local var_42_17 = Mathf.Lerp(iter_42_1.color.b, arg_39_1.hightColor1.b, var_42_14)

								iter_42_1.color = Color.New(var_42_15, var_42_16, var_42_17)
							else
								local var_42_18 = Mathf.Lerp(iter_42_1.color.r, 1, var_42_14)

								iter_42_1.color = Color.New(var_42_18, var_42_18, var_42_18)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= var_42_12 + var_42_13 and arg_39_1.time_ < var_42_12 + var_42_13 + arg_42_0 and not isNil(var_42_11) and arg_39_1.var_.actorSpriteComps10015 then
				for iter_42_2, iter_42_3 in pairs(arg_39_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_42_3 then
						if arg_39_1.isInRecall_ then
							iter_42_3.color = arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_42_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_39_1.var_.actorSpriteComps10015 = nil
			end

			local var_42_19 = arg_39_1.actors_["10015"].transform
			local var_42_20 = 0

			if var_42_20 < arg_39_1.time_ and arg_39_1.time_ <= var_42_20 + arg_42_0 then
				arg_39_1.var_.moveOldPos10015 = var_42_19.localPosition
				var_42_19.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("10015", 4)

				local var_42_21 = var_42_19.childCount

				for iter_42_4 = 0, var_42_21 - 1 do
					local var_42_22 = var_42_19:GetChild(iter_42_4)

					if var_42_22.name == "split_6" or not string.find(var_42_22.name, "split") then
						var_42_22.gameObject:SetActive(true)
					else
						var_42_22.gameObject:SetActive(false)
					end
				end
			end

			local var_42_23 = 0.001

			if var_42_20 <= arg_39_1.time_ and arg_39_1.time_ < var_42_20 + var_42_23 then
				local var_42_24 = (arg_39_1.time_ - var_42_20) / var_42_23
				local var_42_25 = Vector3.New(390, -350, -180)

				var_42_19.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10015, var_42_25, var_42_24)
			end

			if arg_39_1.time_ >= var_42_20 + var_42_23 and arg_39_1.time_ < var_42_20 + var_42_23 + arg_42_0 then
				var_42_19.localPosition = Vector3.New(390, -350, -180)
			end

			local var_42_26 = 0
			local var_42_27 = 0.55

			if var_42_26 < arg_39_1.time_ and arg_39_1.time_ <= var_42_26 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_28 = arg_39_1:FormatText(StoryNameCfg[208].name)

				arg_39_1.leftNameTxt_.text = var_42_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_29 = arg_39_1:GetWordFromCfg(114221009)
				local var_42_30 = arg_39_1:FormatText(var_42_29.content)

				arg_39_1.text_.text = var_42_30

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_31 = 22
				local var_42_32 = utf8.len(var_42_30)
				local var_42_33 = var_42_31 <= 0 and var_42_27 or var_42_27 * (var_42_32 / var_42_31)

				if var_42_33 > 0 and var_42_27 < var_42_33 then
					arg_39_1.talkMaxDuration = var_42_33

					if var_42_33 + var_42_26 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_33 + var_42_26
					end
				end

				arg_39_1.text_.text = var_42_30
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114221", "114221009", "story_v_out_114221.awb") ~= 0 then
					local var_42_34 = manager.audio:GetVoiceLength("story_v_out_114221", "114221009", "story_v_out_114221.awb") / 1000

					if var_42_34 + var_42_26 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_34 + var_42_26
					end

					if var_42_29.prefab_name ~= "" and arg_39_1.actors_[var_42_29.prefab_name] ~= nil then
						local var_42_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_29.prefab_name].transform, "story_v_out_114221", "114221009", "story_v_out_114221.awb")

						arg_39_1:RecordAudio("114221009", var_42_35)
						arg_39_1:RecordAudio("114221009", var_42_35)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_114221", "114221009", "story_v_out_114221.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_114221", "114221009", "story_v_out_114221.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_36 = math.max(var_42_27, arg_39_1.talkMaxDuration)

			if var_42_26 <= arg_39_1.time_ and arg_39_1.time_ < var_42_26 + var_42_36 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_26) / var_42_36

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_26 + var_42_36 and arg_39_1.time_ < var_42_26 + var_42_36 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play114221010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 114221010
		arg_43_1.duration_ = 11.2

		local var_43_0 = {
			ja = 10.133,
			ko = 11.2,
			zh = 9.533,
			en = 9.266
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
				arg_43_0:Play114221011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["10016"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) then
				local var_46_2 = var_46_0:GetComponent("Image")

				if var_46_2 then
					arg_43_1.var_.highlightMatValue10016 = var_46_2
				end
			end

			local var_46_3 = 0.034

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_3 and not isNil(var_46_0) then
				local var_46_4 = (arg_43_1.time_ - var_46_1) / var_46_3

				if arg_43_1.var_.highlightMatValue10016 then
					local var_46_5 = Mathf.Lerp(0.5, 1, var_46_4)
					local var_46_6 = arg_43_1.var_.highlightMatValue10016
					local var_46_7 = var_46_6.color

					var_46_7.r = var_46_5
					var_46_7.g = var_46_5
					var_46_7.b = var_46_5
					var_46_6.color = var_46_7
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_3 and arg_43_1.time_ < var_46_1 + var_46_3 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.highlightMatValue10016 then
				local var_46_8 = 1

				var_46_0.transform:SetSiblingIndex(1)

				local var_46_9 = arg_43_1.var_.highlightMatValue10016
				local var_46_10 = var_46_9.color

				var_46_10.r = var_46_8
				var_46_10.g = var_46_8
				var_46_10.b = var_46_8
				var_46_9.color = var_46_10
			end

			local var_46_11 = arg_43_1.actors_["10015"]
			local var_46_12 = 0

			if var_46_12 < arg_43_1.time_ and arg_43_1.time_ <= var_46_12 + arg_46_0 and not isNil(var_46_11) and arg_43_1.var_.actorSpriteComps10015 == nil then
				arg_43_1.var_.actorSpriteComps10015 = var_46_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_13 = 0.034

			if var_46_12 <= arg_43_1.time_ and arg_43_1.time_ < var_46_12 + var_46_13 and not isNil(var_46_11) then
				local var_46_14 = (arg_43_1.time_ - var_46_12) / var_46_13

				if arg_43_1.var_.actorSpriteComps10015 then
					for iter_46_0, iter_46_1 in pairs(arg_43_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_46_1 then
							if arg_43_1.isInRecall_ then
								local var_46_15 = Mathf.Lerp(iter_46_1.color.r, arg_43_1.hightColor2.r, var_46_14)
								local var_46_16 = Mathf.Lerp(iter_46_1.color.g, arg_43_1.hightColor2.g, var_46_14)
								local var_46_17 = Mathf.Lerp(iter_46_1.color.b, arg_43_1.hightColor2.b, var_46_14)

								iter_46_1.color = Color.New(var_46_15, var_46_16, var_46_17)
							else
								local var_46_18 = Mathf.Lerp(iter_46_1.color.r, 0.5, var_46_14)

								iter_46_1.color = Color.New(var_46_18, var_46_18, var_46_18)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_12 + var_46_13 and arg_43_1.time_ < var_46_12 + var_46_13 + arg_46_0 and not isNil(var_46_11) and arg_43_1.var_.actorSpriteComps10015 then
				for iter_46_2, iter_46_3 in pairs(arg_43_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_46_3 then
						if arg_43_1.isInRecall_ then
							iter_46_3.color = arg_43_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_46_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps10015 = nil
			end

			local var_46_19 = 0
			local var_46_20 = 0.7

			if var_46_19 < arg_43_1.time_ and arg_43_1.time_ <= var_46_19 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_21 = arg_43_1:FormatText(StoryNameCfg[226].name)

				arg_43_1.leftNameTxt_.text = var_46_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_22 = arg_43_1:GetWordFromCfg(114221010)
				local var_46_23 = arg_43_1:FormatText(var_46_22.content)

				arg_43_1.text_.text = var_46_23

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_24 = 28
				local var_46_25 = utf8.len(var_46_23)
				local var_46_26 = var_46_24 <= 0 and var_46_20 or var_46_20 * (var_46_25 / var_46_24)

				if var_46_26 > 0 and var_46_20 < var_46_26 then
					arg_43_1.talkMaxDuration = var_46_26

					if var_46_26 + var_46_19 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_26 + var_46_19
					end
				end

				arg_43_1.text_.text = var_46_23
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114221", "114221010", "story_v_out_114221.awb") ~= 0 then
					local var_46_27 = manager.audio:GetVoiceLength("story_v_out_114221", "114221010", "story_v_out_114221.awb") / 1000

					if var_46_27 + var_46_19 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_27 + var_46_19
					end

					if var_46_22.prefab_name ~= "" and arg_43_1.actors_[var_46_22.prefab_name] ~= nil then
						local var_46_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_22.prefab_name].transform, "story_v_out_114221", "114221010", "story_v_out_114221.awb")

						arg_43_1:RecordAudio("114221010", var_46_28)
						arg_43_1:RecordAudio("114221010", var_46_28)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_114221", "114221010", "story_v_out_114221.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_114221", "114221010", "story_v_out_114221.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_29 = math.max(var_46_20, arg_43_1.talkMaxDuration)

			if var_46_19 <= arg_43_1.time_ and arg_43_1.time_ < var_46_19 + var_46_29 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_19) / var_46_29

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_19 + var_46_29 and arg_43_1.time_ < var_46_19 + var_46_29 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play114221011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 114221011
		arg_47_1.duration_ = 9

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play114221012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_1 = 2

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_1 then
				local var_50_2 = (arg_47_1.time_ - var_50_0) / var_50_1
				local var_50_3 = Color.New(0, 0, 0)

				var_50_3.a = Mathf.Lerp(0, 1, var_50_2)
				arg_47_1.mask_.color = var_50_3
			end

			if arg_47_1.time_ >= var_50_0 + var_50_1 and arg_47_1.time_ < var_50_0 + var_50_1 + arg_50_0 then
				local var_50_4 = Color.New(0, 0, 0)

				var_50_4.a = 1
				arg_47_1.mask_.color = var_50_4
			end

			local var_50_5 = 2

			if var_50_5 < arg_47_1.time_ and arg_47_1.time_ <= var_50_5 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_6 = 2

			if var_50_5 <= arg_47_1.time_ and arg_47_1.time_ < var_50_5 + var_50_6 then
				local var_50_7 = (arg_47_1.time_ - var_50_5) / var_50_6
				local var_50_8 = Color.New(0, 0, 0)

				var_50_8.a = Mathf.Lerp(1, 0, var_50_7)
				arg_47_1.mask_.color = var_50_8
			end

			if arg_47_1.time_ >= var_50_5 + var_50_6 and arg_47_1.time_ < var_50_5 + var_50_6 + arg_50_0 then
				local var_50_9 = Color.New(0, 0, 0)
				local var_50_10 = 0

				arg_47_1.mask_.enabled = false
				var_50_9.a = var_50_10
				arg_47_1.mask_.color = var_50_9
			end

			local var_50_11 = arg_47_1.actors_["10016"].transform
			local var_50_12 = 1.966

			if var_50_12 < arg_47_1.time_ and arg_47_1.time_ <= var_50_12 + arg_50_0 then
				arg_47_1.var_.moveOldPos10016 = var_50_11.localPosition
				var_50_11.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("10016", 7)
			end

			local var_50_13 = 0.001

			if var_50_12 <= arg_47_1.time_ and arg_47_1.time_ < var_50_12 + var_50_13 then
				local var_50_14 = (arg_47_1.time_ - var_50_12) / var_50_13
				local var_50_15 = Vector3.New(0, -2000, -180)

				var_50_11.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10016, var_50_15, var_50_14)
			end

			if arg_47_1.time_ >= var_50_12 + var_50_13 and arg_47_1.time_ < var_50_12 + var_50_13 + arg_50_0 then
				var_50_11.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_50_16 = arg_47_1.actors_["10015"].transform
			local var_50_17 = 1.966

			if var_50_17 < arg_47_1.time_ and arg_47_1.time_ <= var_50_17 + arg_50_0 then
				arg_47_1.var_.moveOldPos10015 = var_50_16.localPosition
				var_50_16.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("10015", 7)

				local var_50_18 = var_50_16.childCount

				for iter_50_0 = 0, var_50_18 - 1 do
					local var_50_19 = var_50_16:GetChild(iter_50_0)

					if var_50_19.name == "split_6" or not string.find(var_50_19.name, "split") then
						var_50_19.gameObject:SetActive(true)
					else
						var_50_19.gameObject:SetActive(false)
					end
				end
			end

			local var_50_20 = 0.001

			if var_50_17 <= arg_47_1.time_ and arg_47_1.time_ < var_50_17 + var_50_20 then
				local var_50_21 = (arg_47_1.time_ - var_50_17) / var_50_20
				local var_50_22 = Vector3.New(0, -2000, -180)

				var_50_16.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10015, var_50_22, var_50_21)
			end

			if arg_47_1.time_ >= var_50_17 + var_50_20 and arg_47_1.time_ < var_50_17 + var_50_20 + arg_50_0 then
				var_50_16.localPosition = Vector3.New(0, -2000, -180)
			end

			if arg_47_1.frameCnt_ <= 1 then
				arg_47_1.dialog_:SetActive(false)
			end

			local var_50_23 = 4
			local var_50_24 = 0.05

			if var_50_23 < arg_47_1.time_ and arg_47_1.time_ <= var_50_23 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_25 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_25:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_26 = arg_47_1:GetWordFromCfg(114221011)
				local var_50_27 = arg_47_1:FormatText(var_50_26.content)

				arg_47_1.text_.text = var_50_27

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_28 = 2
				local var_50_29 = utf8.len(var_50_27)
				local var_50_30 = var_50_28 <= 0 and var_50_24 or var_50_24 * (var_50_29 / var_50_28)

				if var_50_30 > 0 and var_50_24 < var_50_30 then
					arg_47_1.talkMaxDuration = var_50_30
					var_50_23 = var_50_23 + 0.3

					if var_50_30 + var_50_23 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_30 + var_50_23
					end
				end

				arg_47_1.text_.text = var_50_27
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_31 = var_50_23 + 0.3
			local var_50_32 = math.max(var_50_24, arg_47_1.talkMaxDuration)

			if var_50_31 <= arg_47_1.time_ and arg_47_1.time_ < var_50_31 + var_50_32 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_31) / var_50_32

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_31 + var_50_32 and arg_47_1.time_ < var_50_31 + var_50_32 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10016",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			},
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play114221012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 114221012
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play114221013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.075

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

				local var_56_2 = arg_53_1:GetWordFromCfg(114221012)
				local var_56_3 = arg_53_1:FormatText(var_56_2.content)

				arg_53_1.text_.text = var_56_3

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 43
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
	Play114221013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114221013
		arg_57_1.duration_ = 12.8

		local var_57_0 = {
			ja = 4.766,
			ko = 9.833,
			zh = 12.8,
			en = 11.233
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
				arg_57_0:Play114221014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["10015"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos10015 = var_60_0.localPosition
				var_60_0.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10015", 3)

				local var_60_2 = var_60_0.childCount

				for iter_60_0 = 0, var_60_2 - 1 do
					local var_60_3 = var_60_0:GetChild(iter_60_0)

					if var_60_3.name == "split_6" or not string.find(var_60_3.name, "split") then
						var_60_3.gameObject:SetActive(true)
					else
						var_60_3.gameObject:SetActive(false)
					end
				end
			end

			local var_60_4 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_4 then
				local var_60_5 = (arg_57_1.time_ - var_60_1) / var_60_4
				local var_60_6 = Vector3.New(0, -350, -180)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10015, var_60_6, var_60_5)
			end

			if arg_57_1.time_ >= var_60_1 + var_60_4 and arg_57_1.time_ < var_60_1 + var_60_4 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_60_7 = arg_57_1.actors_["10015"]
			local var_60_8 = 0

			if var_60_8 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 and not isNil(var_60_7) and arg_57_1.var_.actorSpriteComps10015 == nil then
				arg_57_1.var_.actorSpriteComps10015 = var_60_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_9 = 0.034

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_9 and not isNil(var_60_7) then
				local var_60_10 = (arg_57_1.time_ - var_60_8) / var_60_9

				if arg_57_1.var_.actorSpriteComps10015 then
					for iter_60_1, iter_60_2 in pairs(arg_57_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_60_2 then
							if arg_57_1.isInRecall_ then
								local var_60_11 = Mathf.Lerp(iter_60_2.color.r, arg_57_1.hightColor1.r, var_60_10)
								local var_60_12 = Mathf.Lerp(iter_60_2.color.g, arg_57_1.hightColor1.g, var_60_10)
								local var_60_13 = Mathf.Lerp(iter_60_2.color.b, arg_57_1.hightColor1.b, var_60_10)

								iter_60_2.color = Color.New(var_60_11, var_60_12, var_60_13)
							else
								local var_60_14 = Mathf.Lerp(iter_60_2.color.r, 1, var_60_10)

								iter_60_2.color = Color.New(var_60_14, var_60_14, var_60_14)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= var_60_8 + var_60_9 and arg_57_1.time_ < var_60_8 + var_60_9 + arg_60_0 and not isNil(var_60_7) and arg_57_1.var_.actorSpriteComps10015 then
				for iter_60_3, iter_60_4 in pairs(arg_57_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_60_4 then
						if arg_57_1.isInRecall_ then
							iter_60_4.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_60_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_57_1.var_.actorSpriteComps10015 = nil
			end

			local var_60_15 = arg_57_1.actors_["10015"]
			local var_60_16 = 0

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 then
				local var_60_17 = var_60_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_60_17 then
					arg_57_1.var_.alphaOldValue10015 = var_60_17.alpha
					arg_57_1.var_.characterEffect10015 = var_60_17
				end

				arg_57_1.var_.alphaOldValue10015 = 0
			end

			local var_60_18 = 0.5

			if var_60_16 <= arg_57_1.time_ and arg_57_1.time_ < var_60_16 + var_60_18 then
				local var_60_19 = (arg_57_1.time_ - var_60_16) / var_60_18
				local var_60_20 = Mathf.Lerp(arg_57_1.var_.alphaOldValue10015, 1, var_60_19)

				if arg_57_1.var_.characterEffect10015 then
					arg_57_1.var_.characterEffect10015.alpha = var_60_20
				end
			end

			if arg_57_1.time_ >= var_60_16 + var_60_18 and arg_57_1.time_ < var_60_16 + var_60_18 + arg_60_0 and arg_57_1.var_.characterEffect10015 then
				arg_57_1.var_.characterEffect10015.alpha = 1
			end

			local var_60_21 = 0
			local var_60_22 = 1.25

			if var_60_21 < arg_57_1.time_ and arg_57_1.time_ <= var_60_21 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_23 = arg_57_1:FormatText(StoryNameCfg[208].name)

				arg_57_1.leftNameTxt_.text = var_60_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_24 = arg_57_1:GetWordFromCfg(114221013)
				local var_60_25 = arg_57_1:FormatText(var_60_24.content)

				arg_57_1.text_.text = var_60_25

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_26 = 50
				local var_60_27 = utf8.len(var_60_25)
				local var_60_28 = var_60_26 <= 0 and var_60_22 or var_60_22 * (var_60_27 / var_60_26)

				if var_60_28 > 0 and var_60_22 < var_60_28 then
					arg_57_1.talkMaxDuration = var_60_28

					if var_60_28 + var_60_21 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_28 + var_60_21
					end
				end

				arg_57_1.text_.text = var_60_25
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114221", "114221013", "story_v_out_114221.awb") ~= 0 then
					local var_60_29 = manager.audio:GetVoiceLength("story_v_out_114221", "114221013", "story_v_out_114221.awb") / 1000

					if var_60_29 + var_60_21 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_29 + var_60_21
					end

					if var_60_24.prefab_name ~= "" and arg_57_1.actors_[var_60_24.prefab_name] ~= nil then
						local var_60_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_24.prefab_name].transform, "story_v_out_114221", "114221013", "story_v_out_114221.awb")

						arg_57_1:RecordAudio("114221013", var_60_30)
						arg_57_1:RecordAudio("114221013", var_60_30)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_114221", "114221013", "story_v_out_114221.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_114221", "114221013", "story_v_out_114221.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_31 = math.max(var_60_22, arg_57_1.talkMaxDuration)

			if var_60_21 <= arg_57_1.time_ and arg_57_1.time_ < var_60_21 + var_60_31 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_21) / var_60_31

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_21 + var_60_31 and arg_57_1.time_ < var_60_21 + var_60_31 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play114221014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114221014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play114221015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10015"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10015 == nil then
				arg_61_1.var_.actorSpriteComps10015 = var_64_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_2 = 0.034

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.actorSpriteComps10015 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								local var_64_4 = Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor2.r, var_64_3)
								local var_64_5 = Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor2.g, var_64_3)
								local var_64_6 = Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor2.b, var_64_3)

								iter_64_1.color = Color.New(var_64_4, var_64_5, var_64_6)
							else
								local var_64_7 = Mathf.Lerp(iter_64_1.color.r, 0.5, var_64_3)

								iter_64_1.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.actorSpriteComps10015 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_64_3 then
						if arg_61_1.isInRecall_ then
							iter_64_3.color = arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_64_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_61_1.var_.actorSpriteComps10015 = nil
			end

			local var_64_8 = 0
			local var_64_9 = 1.175

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_10 = arg_61_1:GetWordFromCfg(114221014)
				local var_64_11 = arg_61_1:FormatText(var_64_10.content)

				arg_61_1.text_.text = var_64_11

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_12 = 47
				local var_64_13 = utf8.len(var_64_11)
				local var_64_14 = var_64_12 <= 0 and var_64_9 or var_64_9 * (var_64_13 / var_64_12)

				if var_64_14 > 0 and var_64_9 < var_64_14 then
					arg_61_1.talkMaxDuration = var_64_14

					if var_64_14 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_8
					end
				end

				arg_61_1.text_.text = var_64_11
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_15 = math.max(var_64_9, arg_61_1.talkMaxDuration)

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_15 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_8) / var_64_15

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_8 + var_64_15 and arg_61_1.time_ < var_64_8 + var_64_15 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play114221015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 114221015
		arg_65_1.duration_ = 4.4

		local var_65_0 = {
			ja = 4.4,
			ko = 2.7,
			zh = 4.133,
			en = 4.4
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
				arg_65_0:Play114221016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10015"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10015 == nil then
				arg_65_1.var_.actorSpriteComps10015 = var_68_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_2 = 0.034

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.actorSpriteComps10015 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								local var_68_4 = Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor1.r, var_68_3)
								local var_68_5 = Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor1.g, var_68_3)
								local var_68_6 = Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor1.b, var_68_3)

								iter_68_1.color = Color.New(var_68_4, var_68_5, var_68_6)
							else
								local var_68_7 = Mathf.Lerp(iter_68_1.color.r, 1, var_68_3)

								iter_68_1.color = Color.New(var_68_7, var_68_7, var_68_7)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.actorSpriteComps10015 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_68_3 then
						if arg_65_1.isInRecall_ then
							iter_68_3.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10015 = nil
			end

			local var_68_8 = 0
			local var_68_9 = 0.225

			if var_68_8 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_10 = arg_65_1:FormatText(StoryNameCfg[208].name)

				arg_65_1.leftNameTxt_.text = var_68_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_11 = arg_65_1:GetWordFromCfg(114221015)
				local var_68_12 = arg_65_1:FormatText(var_68_11.content)

				arg_65_1.text_.text = var_68_12

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 9
				local var_68_14 = utf8.len(var_68_12)
				local var_68_15 = var_68_13 <= 0 and var_68_9 or var_68_9 * (var_68_14 / var_68_13)

				if var_68_15 > 0 and var_68_9 < var_68_15 then
					arg_65_1.talkMaxDuration = var_68_15

					if var_68_15 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_15 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_12
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114221", "114221015", "story_v_out_114221.awb") ~= 0 then
					local var_68_16 = manager.audio:GetVoiceLength("story_v_out_114221", "114221015", "story_v_out_114221.awb") / 1000

					if var_68_16 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_16 + var_68_8
					end

					if var_68_11.prefab_name ~= "" and arg_65_1.actors_[var_68_11.prefab_name] ~= nil then
						local var_68_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_11.prefab_name].transform, "story_v_out_114221", "114221015", "story_v_out_114221.awb")

						arg_65_1:RecordAudio("114221015", var_68_17)
						arg_65_1:RecordAudio("114221015", var_68_17)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_114221", "114221015", "story_v_out_114221.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_114221", "114221015", "story_v_out_114221.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_18 = math.max(var_68_9, arg_65_1.talkMaxDuration)

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_18 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_8) / var_68_18

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_8 + var_68_18 and arg_65_1.time_ < var_68_8 + var_68_18 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play114221016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 114221016
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play114221017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10015"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				local var_72_2 = var_72_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_72_2 then
					arg_69_1.var_.alphaOldValue10015 = var_72_2.alpha
					arg_69_1.var_.characterEffect10015 = var_72_2
				end

				arg_69_1.var_.alphaOldValue10015 = 1
			end

			local var_72_3 = 0.5

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_3 then
				local var_72_4 = (arg_69_1.time_ - var_72_1) / var_72_3
				local var_72_5 = Mathf.Lerp(arg_69_1.var_.alphaOldValue10015, 0, var_72_4)

				if arg_69_1.var_.characterEffect10015 then
					arg_69_1.var_.characterEffect10015.alpha = var_72_5
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_3 and arg_69_1.time_ < var_72_1 + var_72_3 + arg_72_0 and arg_69_1.var_.characterEffect10015 then
				arg_69_1.var_.characterEffect10015.alpha = 0
			end

			local var_72_6 = 0
			local var_72_7 = 0.5

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_8 = arg_69_1:GetWordFromCfg(114221016)
				local var_72_9 = arg_69_1:FormatText(var_72_8.content)

				arg_69_1.text_.text = var_72_9

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 20
				local var_72_11 = utf8.len(var_72_9)
				local var_72_12 = var_72_10 <= 0 and var_72_7 or var_72_7 * (var_72_11 / var_72_10)

				if var_72_12 > 0 and var_72_7 < var_72_12 then
					arg_69_1.talkMaxDuration = var_72_12

					if var_72_12 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_12 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_9
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_13 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_13 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_13

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_13 and arg_69_1.time_ < var_72_6 + var_72_13 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play114221017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 114221017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play114221018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0
			local var_76_1 = 1.95

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_2 = arg_73_1:GetWordFromCfg(114221017)
				local var_76_3 = arg_73_1:FormatText(var_76_2.content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 77
				local var_76_5 = utf8.len(var_76_3)
				local var_76_6 = var_76_4 <= 0 and var_76_1 or var_76_1 * (var_76_5 / var_76_4)

				if var_76_6 > 0 and var_76_1 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_0
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_1, arg_73_1.talkMaxDuration)

			if var_76_0 <= arg_73_1.time_ and arg_73_1.time_ < var_76_0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_0 + var_76_7 and arg_73_1.time_ < var_76_0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play114221018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 114221018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play114221019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 1.15

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_2 = arg_77_1:GetWordFromCfg(114221018)
				local var_80_3 = arg_77_1:FormatText(var_80_2.content)

				arg_77_1.text_.text = var_80_3

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 46
				local var_80_5 = utf8.len(var_80_3)
				local var_80_6 = var_80_4 <= 0 and var_80_1 or var_80_1 * (var_80_5 / var_80_4)

				if var_80_6 > 0 and var_80_1 < var_80_6 then
					arg_77_1.talkMaxDuration = var_80_6

					if var_80_6 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_3
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_7 and arg_77_1.time_ < var_80_0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play114221019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 114221019
		arg_81_1.duration_ = 2.7

		local var_81_0 = {
			ja = 0.999999999999,
			ko = 2.7,
			zh = 0.999999999999,
			en = 1.5
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
				arg_81_0:Play114221020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0
			local var_84_1 = 0.05

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_2 = arg_81_1:FormatText(StoryNameCfg[256].name)

				arg_81_1.leftNameTxt_.text = var_84_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3020")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_3 = arg_81_1:GetWordFromCfg(114221019)
				local var_84_4 = arg_81_1:FormatText(var_84_3.content)

				arg_81_1.text_.text = var_84_4

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_114221", "114221019", "story_v_out_114221.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_114221", "114221019", "story_v_out_114221.awb") / 1000

					if var_84_8 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_0
					end

					if var_84_3.prefab_name ~= "" and arg_81_1.actors_[var_84_3.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_3.prefab_name].transform, "story_v_out_114221", "114221019", "story_v_out_114221.awb")

						arg_81_1:RecordAudio("114221019", var_84_9)
						arg_81_1:RecordAudio("114221019", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_114221", "114221019", "story_v_out_114221.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_114221", "114221019", "story_v_out_114221.awb")
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
	Play114221020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 114221020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play114221021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.466666666666667
			local var_88_1 = 0.533333333333333

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				local var_88_2 = "play"
				local var_88_3 = "effect"

				arg_85_1:AudioAction(var_88_2, var_88_3, "se_story_activity_1_4_3", "se_story_activity_1_4_3_knight", "")
			end

			local var_88_4 = 0
			local var_88_5 = 0.65

			if var_88_4 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(114221020)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_8 = 26
				local var_88_9 = utf8.len(var_88_7)
				local var_88_10 = var_88_8 <= 0 and var_88_5 or var_88_5 * (var_88_9 / var_88_8)

				if var_88_10 > 0 and var_88_5 < var_88_10 then
					arg_85_1.talkMaxDuration = var_88_10

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_11 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_11 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_11

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_11 and arg_85_1.time_ < var_88_4 + var_88_11 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play114221021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 114221021
		arg_89_1.duration_ = 3.43

		local var_89_0 = {
			ja = 2.3,
			ko = 3.433,
			zh = 3.366,
			en = 3.4
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
				arg_89_0:Play114221022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0
			local var_92_1 = 0.25

			if var_92_0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_2 = arg_89_1:FormatText(StoryNameCfg[256].name)

				arg_89_1.leftNameTxt_.text = var_92_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3020")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_3 = arg_89_1:GetWordFromCfg(114221021)
				local var_92_4 = arg_89_1:FormatText(var_92_3.content)

				arg_89_1.text_.text = var_92_4

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 10
				local var_92_6 = utf8.len(var_92_4)
				local var_92_7 = var_92_5 <= 0 and var_92_1 or var_92_1 * (var_92_6 / var_92_5)

				if var_92_7 > 0 and var_92_1 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_0
					end
				end

				arg_89_1.text_.text = var_92_4
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114221", "114221021", "story_v_out_114221.awb") ~= 0 then
					local var_92_8 = manager.audio:GetVoiceLength("story_v_out_114221", "114221021", "story_v_out_114221.awb") / 1000

					if var_92_8 + var_92_0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_0
					end

					if var_92_3.prefab_name ~= "" and arg_89_1.actors_[var_92_3.prefab_name] ~= nil then
						local var_92_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_3.prefab_name].transform, "story_v_out_114221", "114221021", "story_v_out_114221.awb")

						arg_89_1:RecordAudio("114221021", var_92_9)
						arg_89_1:RecordAudio("114221021", var_92_9)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_114221", "114221021", "story_v_out_114221.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_114221", "114221021", "story_v_out_114221.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_1, arg_89_1.talkMaxDuration)

			if var_92_0 <= arg_89_1.time_ and arg_89_1.time_ < var_92_0 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_0) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_0 + var_92_10 and arg_89_1.time_ < var_92_0 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play114221022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 114221022
		arg_93_1.duration_ = 1

		local var_93_0 = {
			ja = 0.999999999999,
			ko = 1,
			zh = 1,
			en = 0.999999999999
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
				arg_93_0:Play114221023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 1

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				local var_96_2 = "play"
				local var_96_3 = "effect"

				arg_93_1:AudioAction(var_96_2, var_96_3, "se_story_activity_1_4_3", "se_story_activity_1_4_3_jump", "")
			end

			local var_96_4 = manager.ui.mainCamera.transform
			local var_96_5 = 0

			if var_96_5 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1.var_.shakeOldPos = var_96_4.localPosition
			end

			local var_96_6 = 0.5

			if var_96_5 <= arg_93_1.time_ and arg_93_1.time_ < var_96_5 + var_96_6 then
				local var_96_7 = (arg_93_1.time_ - var_96_5) / 0.066
				local var_96_8, var_96_9 = math.modf(var_96_7)

				var_96_4.localPosition = Vector3.New(var_96_9 * 0.13, var_96_9 * 0.13, var_96_9 * 0.13) + arg_93_1.var_.shakeOldPos
			end

			if arg_93_1.time_ >= var_96_5 + var_96_6 and arg_93_1.time_ < var_96_5 + var_96_6 + arg_96_0 then
				var_96_4.localPosition = arg_93_1.var_.shakeOldPos
			end

			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 then
				arg_93_1.allBtn_.enabled = false
			end

			local var_96_11 = 0.5

			if arg_93_1.time_ >= var_96_10 + var_96_11 and arg_93_1.time_ < var_96_10 + var_96_11 + arg_96_0 then
				arg_93_1.allBtn_.enabled = true
			end

			local var_96_12 = 0
			local var_96_13 = 0.075

			if var_96_12 < arg_93_1.time_ and arg_93_1.time_ <= var_96_12 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_14 = arg_93_1:FormatText(StoryNameCfg[208].name)

				arg_93_1.leftNameTxt_.text = var_96_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10015_split4")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_15 = arg_93_1:GetWordFromCfg(114221022)
				local var_96_16 = arg_93_1:FormatText(var_96_15.content)

				arg_93_1.text_.text = var_96_16

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_17 = 3
				local var_96_18 = utf8.len(var_96_16)
				local var_96_19 = var_96_17 <= 0 and var_96_13 or var_96_13 * (var_96_18 / var_96_17)

				if var_96_19 > 0 and var_96_13 < var_96_19 then
					arg_93_1.talkMaxDuration = var_96_19

					if var_96_19 + var_96_12 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_19 + var_96_12
					end
				end

				arg_93_1.text_.text = var_96_16
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114221", "114221022", "story_v_out_114221.awb") ~= 0 then
					local var_96_20 = manager.audio:GetVoiceLength("story_v_out_114221", "114221022", "story_v_out_114221.awb") / 1000

					if var_96_20 + var_96_12 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_20 + var_96_12
					end

					if var_96_15.prefab_name ~= "" and arg_93_1.actors_[var_96_15.prefab_name] ~= nil then
						local var_96_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_15.prefab_name].transform, "story_v_out_114221", "114221022", "story_v_out_114221.awb")

						arg_93_1:RecordAudio("114221022", var_96_21)
						arg_93_1:RecordAudio("114221022", var_96_21)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_114221", "114221022", "story_v_out_114221.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_114221", "114221022", "story_v_out_114221.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_22 = math.max(var_96_13, arg_93_1.talkMaxDuration)

			if var_96_12 <= arg_93_1.time_ and arg_93_1.time_ < var_96_12 + var_96_22 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_12) / var_96_22

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_12 + var_96_22 and arg_93_1.time_ < var_96_12 + var_96_22 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play114221023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 114221023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play114221024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10015"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				local var_100_2 = var_100_0:GetComponentInChildren(typeof(CanvasGroup))

				if var_100_2 then
					arg_97_1.var_.alphaOldValue10015 = var_100_2.alpha
					arg_97_1.var_.characterEffect10015 = var_100_2
				end

				arg_97_1.var_.alphaOldValue10015 = 1
			end

			local var_100_3 = 0.5

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_3 then
				local var_100_4 = (arg_97_1.time_ - var_100_1) / var_100_3
				local var_100_5 = Mathf.Lerp(arg_97_1.var_.alphaOldValue10015, 0, var_100_4)

				if arg_97_1.var_.characterEffect10015 then
					arg_97_1.var_.characterEffect10015.alpha = var_100_5
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_3 and arg_97_1.time_ < var_100_1 + var_100_3 + arg_100_0 and arg_97_1.var_.characterEffect10015 then
				arg_97_1.var_.characterEffect10015.alpha = 0
			end

			local var_100_6 = 0
			local var_100_7 = 1.55

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_8 = arg_97_1:GetWordFromCfg(114221023)
				local var_100_9 = arg_97_1:FormatText(var_100_8.content)

				arg_97_1.text_.text = var_100_9

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_10 = 62
				local var_100_11 = utf8.len(var_100_9)
				local var_100_12 = var_100_10 <= 0 and var_100_7 or var_100_7 * (var_100_11 / var_100_10)

				if var_100_12 > 0 and var_100_7 < var_100_12 then
					arg_97_1.talkMaxDuration = var_100_12

					if var_100_12 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_12 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_9
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_13 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_13 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_13

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_13 and arg_97_1.time_ < var_100_6 + var_100_13 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play114221024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 114221024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play114221025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 1.525

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_2 = arg_101_1:GetWordFromCfg(114221024)
				local var_104_3 = arg_101_1:FormatText(var_104_2.content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 61
				local var_104_5 = utf8.len(var_104_3)
				local var_104_6 = var_104_4 <= 0 and var_104_1 or var_104_1 * (var_104_5 / var_104_4)

				if var_104_6 > 0 and var_104_1 < var_104_6 then
					arg_101_1.talkMaxDuration = var_104_6

					if var_104_6 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_6 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_7 and arg_101_1.time_ < var_104_0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play114221025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 114221025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play114221026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0
			local var_108_1 = 0.925

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_2 = arg_105_1:GetWordFromCfg(114221025)
				local var_108_3 = arg_105_1:FormatText(var_108_2.content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 37
				local var_108_5 = utf8.len(var_108_3)
				local var_108_6 = var_108_4 <= 0 and var_108_1 or var_108_1 * (var_108_5 / var_108_4)

				if var_108_6 > 0 and var_108_1 < var_108_6 then
					arg_105_1.talkMaxDuration = var_108_6

					if var_108_6 + var_108_0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_0
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_1, arg_105_1.talkMaxDuration)

			if var_108_0 <= arg_105_1.time_ and arg_105_1.time_ < var_108_0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_0 + var_108_7 and arg_105_1.time_ < var_108_0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play114221026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 114221026
		arg_109_1.duration_ = 6.53

		local var_109_0 = {
			ja = 6.533,
			ko = 4,
			zh = 4.066,
			en = 5
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
				arg_109_0:Play114221027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["10015"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos10015 = var_112_0.localPosition
				var_112_0.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("10015", 3)

				local var_112_2 = var_112_0.childCount

				for iter_112_0 = 0, var_112_2 - 1 do
					local var_112_3 = var_112_0:GetChild(iter_112_0)

					if var_112_3.name == "split_1" or not string.find(var_112_3.name, "split") then
						var_112_3.gameObject:SetActive(true)
					else
						var_112_3.gameObject:SetActive(false)
					end
				end
			end

			local var_112_4 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_4 then
				local var_112_5 = (arg_109_1.time_ - var_112_1) / var_112_4
				local var_112_6 = Vector3.New(0, -350, -180)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos10015, var_112_6, var_112_5)
			end

			if arg_109_1.time_ >= var_112_1 + var_112_4 and arg_109_1.time_ < var_112_1 + var_112_4 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_112_7 = arg_109_1.actors_["10015"]
			local var_112_8 = 0

			if var_112_8 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps10015 == nil then
				arg_109_1.var_.actorSpriteComps10015 = var_112_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_9 = 0.034

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_9 and not isNil(var_112_7) then
				local var_112_10 = (arg_109_1.time_ - var_112_8) / var_112_9

				if arg_109_1.var_.actorSpriteComps10015 then
					for iter_112_1, iter_112_2 in pairs(arg_109_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_109_1.time_ >= var_112_8 + var_112_9 and arg_109_1.time_ < var_112_8 + var_112_9 + arg_112_0 and not isNil(var_112_7) and arg_109_1.var_.actorSpriteComps10015 then
				for iter_112_3, iter_112_4 in pairs(arg_109_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_112_4 then
						if arg_109_1.isInRecall_ then
							iter_112_4.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_112_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_109_1.var_.actorSpriteComps10015 = nil
			end

			local var_112_15 = arg_109_1.actors_["10015"]
			local var_112_16 = 0

			if var_112_16 < arg_109_1.time_ and arg_109_1.time_ <= var_112_16 + arg_112_0 then
				local var_112_17 = var_112_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_112_17 then
					arg_109_1.var_.alphaOldValue10015 = var_112_17.alpha
					arg_109_1.var_.characterEffect10015 = var_112_17
				end

				arg_109_1.var_.alphaOldValue10015 = 0
			end

			local var_112_18 = 0.5

			if var_112_16 <= arg_109_1.time_ and arg_109_1.time_ < var_112_16 + var_112_18 then
				local var_112_19 = (arg_109_1.time_ - var_112_16) / var_112_18
				local var_112_20 = Mathf.Lerp(arg_109_1.var_.alphaOldValue10015, 1, var_112_19)

				if arg_109_1.var_.characterEffect10015 then
					arg_109_1.var_.characterEffect10015.alpha = var_112_20
				end
			end

			if arg_109_1.time_ >= var_112_16 + var_112_18 and arg_109_1.time_ < var_112_16 + var_112_18 + arg_112_0 and arg_109_1.var_.characterEffect10015 then
				arg_109_1.var_.characterEffect10015.alpha = 1
			end

			local var_112_21 = 0
			local var_112_22 = 0.5

			if var_112_21 < arg_109_1.time_ and arg_109_1.time_ <= var_112_21 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_23 = arg_109_1:FormatText(StoryNameCfg[208].name)

				arg_109_1.leftNameTxt_.text = var_112_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_24 = arg_109_1:GetWordFromCfg(114221026)
				local var_112_25 = arg_109_1:FormatText(var_112_24.content)

				arg_109_1.text_.text = var_112_25

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_26 = 20
				local var_112_27 = utf8.len(var_112_25)
				local var_112_28 = var_112_26 <= 0 and var_112_22 or var_112_22 * (var_112_27 / var_112_26)

				if var_112_28 > 0 and var_112_22 < var_112_28 then
					arg_109_1.talkMaxDuration = var_112_28

					if var_112_28 + var_112_21 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_28 + var_112_21
					end
				end

				arg_109_1.text_.text = var_112_25
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114221", "114221026", "story_v_out_114221.awb") ~= 0 then
					local var_112_29 = manager.audio:GetVoiceLength("story_v_out_114221", "114221026", "story_v_out_114221.awb") / 1000

					if var_112_29 + var_112_21 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_29 + var_112_21
					end

					if var_112_24.prefab_name ~= "" and arg_109_1.actors_[var_112_24.prefab_name] ~= nil then
						local var_112_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_24.prefab_name].transform, "story_v_out_114221", "114221026", "story_v_out_114221.awb")

						arg_109_1:RecordAudio("114221026", var_112_30)
						arg_109_1:RecordAudio("114221026", var_112_30)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_114221", "114221026", "story_v_out_114221.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_114221", "114221026", "story_v_out_114221.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_31 = math.max(var_112_22, arg_109_1.talkMaxDuration)

			if var_112_21 <= arg_109_1.time_ and arg_109_1.time_ < var_112_21 + var_112_31 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_21) / var_112_31

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_21 + var_112_31 and arg_109_1.time_ < var_112_21 + var_112_31 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
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
	Play114221027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 114221027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play114221028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["10015"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps10015 == nil then
				arg_113_1.var_.actorSpriteComps10015 = var_116_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_2 = 0.034

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.actorSpriteComps10015 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_116_1 then
							if arg_113_1.isInRecall_ then
								local var_116_4 = Mathf.Lerp(iter_116_1.color.r, arg_113_1.hightColor2.r, var_116_3)
								local var_116_5 = Mathf.Lerp(iter_116_1.color.g, arg_113_1.hightColor2.g, var_116_3)
								local var_116_6 = Mathf.Lerp(iter_116_1.color.b, arg_113_1.hightColor2.b, var_116_3)

								iter_116_1.color = Color.New(var_116_4, var_116_5, var_116_6)
							else
								local var_116_7 = Mathf.Lerp(iter_116_1.color.r, 0.5, var_116_3)

								iter_116_1.color = Color.New(var_116_7, var_116_7, var_116_7)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.actorSpriteComps10015 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_116_3 then
						if arg_113_1.isInRecall_ then
							iter_116_3.color = arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_116_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_113_1.var_.actorSpriteComps10015 = nil
			end

			local var_116_8 = 0
			local var_116_9 = 1.2

			if var_116_8 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_10 = arg_113_1:GetWordFromCfg(114221027)
				local var_116_11 = arg_113_1:FormatText(var_116_10.content)

				arg_113_1.text_.text = var_116_11

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_12 = 48
				local var_116_13 = utf8.len(var_116_11)
				local var_116_14 = var_116_12 <= 0 and var_116_9 or var_116_9 * (var_116_13 / var_116_12)

				if var_116_14 > 0 and var_116_9 < var_116_14 then
					arg_113_1.talkMaxDuration = var_116_14

					if var_116_14 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_8
					end
				end

				arg_113_1.text_.text = var_116_11
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_15 = math.max(var_116_9, arg_113_1.talkMaxDuration)

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_15 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_8) / var_116_15

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_8 + var_116_15 and arg_113_1.time_ < var_116_8 + var_116_15 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play114221028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 114221028
		arg_117_1.duration_ = 11.43

		local var_117_0 = {
			ja = 5.433,
			ko = 9.5,
			zh = 11.433,
			en = 8.833
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
				arg_117_0:Play114221029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.8

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[256].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3020")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_3 = arg_117_1:GetWordFromCfg(114221028)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 31
				local var_120_6 = utf8.len(var_120_4)
				local var_120_7 = var_120_5 <= 0 and var_120_1 or var_120_1 * (var_120_6 / var_120_5)

				if var_120_7 > 0 and var_120_1 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114221", "114221028", "story_v_out_114221.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_114221", "114221028", "story_v_out_114221.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_out_114221", "114221028", "story_v_out_114221.awb")

						arg_117_1:RecordAudio("114221028", var_120_9)
						arg_117_1:RecordAudio("114221028", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_114221", "114221028", "story_v_out_114221.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_114221", "114221028", "story_v_out_114221.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_10 and arg_117_1.time_ < var_120_0 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play114221029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 114221029
		arg_121_1.duration_ = 5.23

		local var_121_0 = {
			ja = 5.1,
			ko = 5.233,
			zh = 4.7,
			en = 5.1
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
				arg_121_0:Play114221030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["10015"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos10015 = var_124_0.localPosition
				var_124_0.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10015", 3)

				local var_124_2 = var_124_0.childCount

				for iter_124_0 = 0, var_124_2 - 1 do
					local var_124_3 = var_124_0:GetChild(iter_124_0)

					if var_124_3.name == "split_5" or not string.find(var_124_3.name, "split") then
						var_124_3.gameObject:SetActive(true)
					else
						var_124_3.gameObject:SetActive(false)
					end
				end
			end

			local var_124_4 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_4 then
				local var_124_5 = (arg_121_1.time_ - var_124_1) / var_124_4
				local var_124_6 = Vector3.New(0, -350, -180)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10015, var_124_6, var_124_5)
			end

			if arg_121_1.time_ >= var_124_1 + var_124_4 and arg_121_1.time_ < var_124_1 + var_124_4 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_124_7 = arg_121_1.actors_["10015"]
			local var_124_8 = 0

			if var_124_8 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 and not isNil(var_124_7) and arg_121_1.var_.actorSpriteComps10015 == nil then
				arg_121_1.var_.actorSpriteComps10015 = var_124_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_9 = 0.034

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_9 and not isNil(var_124_7) then
				local var_124_10 = (arg_121_1.time_ - var_124_8) / var_124_9

				if arg_121_1.var_.actorSpriteComps10015 then
					for iter_124_1, iter_124_2 in pairs(arg_121_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_121_1.time_ >= var_124_8 + var_124_9 and arg_121_1.time_ < var_124_8 + var_124_9 + arg_124_0 and not isNil(var_124_7) and arg_121_1.var_.actorSpriteComps10015 then
				for iter_124_3, iter_124_4 in pairs(arg_121_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_124_4 then
						if arg_121_1.isInRecall_ then
							iter_124_4.color = arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_124_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_121_1.var_.actorSpriteComps10015 = nil
			end

			local var_124_15 = arg_121_1.actors_["10015"]
			local var_124_16 = 0

			if var_124_16 < arg_121_1.time_ and arg_121_1.time_ <= var_124_16 + arg_124_0 then
				local var_124_17 = var_124_15:GetComponentInChildren(typeof(CanvasGroup))

				if var_124_17 then
					arg_121_1.var_.alphaOldValue10015 = var_124_17.alpha
					arg_121_1.var_.characterEffect10015 = var_124_17
				end

				arg_121_1.var_.alphaOldValue10015 = 0
			end

			local var_124_18 = 0.0166666666666667

			if var_124_16 <= arg_121_1.time_ and arg_121_1.time_ < var_124_16 + var_124_18 then
				local var_124_19 = (arg_121_1.time_ - var_124_16) / var_124_18
				local var_124_20 = Mathf.Lerp(arg_121_1.var_.alphaOldValue10015, 1, var_124_19)

				if arg_121_1.var_.characterEffect10015 then
					arg_121_1.var_.characterEffect10015.alpha = var_124_20
				end
			end

			if arg_121_1.time_ >= var_124_16 + var_124_18 and arg_121_1.time_ < var_124_16 + var_124_18 + arg_124_0 and arg_121_1.var_.characterEffect10015 then
				arg_121_1.var_.characterEffect10015.alpha = 1
			end

			local var_124_21 = 0
			local var_124_22 = 0.475

			if var_124_21 < arg_121_1.time_ and arg_121_1.time_ <= var_124_21 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_23 = arg_121_1:FormatText(StoryNameCfg[208].name)

				arg_121_1.leftNameTxt_.text = var_124_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_24 = arg_121_1:GetWordFromCfg(114221029)
				local var_124_25 = arg_121_1:FormatText(var_124_24.content)

				arg_121_1.text_.text = var_124_25

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_26 = 19
				local var_124_27 = utf8.len(var_124_25)
				local var_124_28 = var_124_26 <= 0 and var_124_22 or var_124_22 * (var_124_27 / var_124_26)

				if var_124_28 > 0 and var_124_22 < var_124_28 then
					arg_121_1.talkMaxDuration = var_124_28

					if var_124_28 + var_124_21 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_28 + var_124_21
					end
				end

				arg_121_1.text_.text = var_124_25
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114221", "114221029", "story_v_out_114221.awb") ~= 0 then
					local var_124_29 = manager.audio:GetVoiceLength("story_v_out_114221", "114221029", "story_v_out_114221.awb") / 1000

					if var_124_29 + var_124_21 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_29 + var_124_21
					end

					if var_124_24.prefab_name ~= "" and arg_121_1.actors_[var_124_24.prefab_name] ~= nil then
						local var_124_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_24.prefab_name].transform, "story_v_out_114221", "114221029", "story_v_out_114221.awb")

						arg_121_1:RecordAudio("114221029", var_124_30)
						arg_121_1:RecordAudio("114221029", var_124_30)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_114221", "114221029", "story_v_out_114221.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_114221", "114221029", "story_v_out_114221.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_31 = math.max(var_124_22, arg_121_1.talkMaxDuration)

			if var_124_21 <= arg_121_1.time_ and arg_121_1.time_ < var_124_21 + var_124_31 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_21) / var_124_31

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_21 + var_124_31 and arg_121_1.time_ < var_124_21 + var_124_31 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
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
	Play114221030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 114221030
		arg_125_1.duration_ = 9.97

		local var_125_0 = {
			ja = 5.432999999999,
			ko = 9.499999999999,
			zh = 9.965999999999,
			en = 9.499999999999
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
				arg_125_0:Play114221031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_1 = 2

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_1 then
				local var_128_2 = (arg_125_1.time_ - var_128_0) / var_128_1
				local var_128_3 = Color.New(1, 1, 1)

				var_128_3.a = Mathf.Lerp(1, 0, var_128_2)
				arg_125_1.mask_.color = var_128_3
			end

			if arg_125_1.time_ >= var_128_0 + var_128_1 and arg_125_1.time_ < var_128_0 + var_128_1 + arg_128_0 then
				local var_128_4 = Color.New(1, 1, 1)
				local var_128_5 = 0

				arg_125_1.mask_.enabled = false
				var_128_4.a = var_128_5
				arg_125_1.mask_.color = var_128_4
			end

			local var_128_6 = arg_125_1.actors_["10015"].transform
			local var_128_7 = 0

			if var_128_7 < arg_125_1.time_ and arg_125_1.time_ <= var_128_7 + arg_128_0 then
				arg_125_1.var_.moveOldPos10015 = var_128_6.localPosition
				var_128_6.localScale = Vector3.New(1, 1, 1)

				arg_125_1:CheckSpriteTmpPos("10015", 7)

				local var_128_8 = var_128_6.childCount

				for iter_128_0 = 0, var_128_8 - 1 do
					local var_128_9 = var_128_6:GetChild(iter_128_0)

					if var_128_9.name == "split_5" or not string.find(var_128_9.name, "split") then
						var_128_9.gameObject:SetActive(true)
					else
						var_128_9.gameObject:SetActive(false)
					end
				end
			end

			local var_128_10 = 0.001

			if var_128_7 <= arg_125_1.time_ and arg_125_1.time_ < var_128_7 + var_128_10 then
				local var_128_11 = (arg_125_1.time_ - var_128_7) / var_128_10
				local var_128_12 = Vector3.New(0, -2000, -180)

				var_128_6.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10015, var_128_12, var_128_11)
			end

			if arg_125_1.time_ >= var_128_7 + var_128_10 and arg_125_1.time_ < var_128_7 + var_128_10 + arg_128_0 then
				var_128_6.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_128_13 = "OM0501"

			if arg_125_1.bgs_[var_128_13] == nil then
				local var_128_14 = Object.Instantiate(arg_125_1.paintGo_)

				var_128_14:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_128_13)
				var_128_14.name = var_128_13
				var_128_14.transform.parent = arg_125_1.stage_.transform
				var_128_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.bgs_[var_128_13] = var_128_14
			end

			local var_128_15 = 0

			if var_128_15 < arg_125_1.time_ and arg_125_1.time_ <= var_128_15 + arg_128_0 then
				local var_128_16 = manager.ui.mainCamera.transform.localPosition
				local var_128_17 = Vector3.New(0, 0, 10) + Vector3.New(var_128_16.x, var_128_16.y, 0)
				local var_128_18 = arg_125_1.bgs_.OM0501

				var_128_18.transform.localPosition = var_128_17
				var_128_18.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_128_19 = var_128_18:GetComponent("SpriteRenderer")

				if var_128_19 and var_128_19.sprite then
					local var_128_20 = (var_128_18.transform.localPosition - var_128_16).z
					local var_128_21 = manager.ui.mainCameraCom_
					local var_128_22 = 2 * var_128_20 * Mathf.Tan(var_128_21.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_128_23 = var_128_22 * var_128_21.aspect
					local var_128_24 = var_128_19.sprite.bounds.size.x
					local var_128_25 = var_128_19.sprite.bounds.size.y
					local var_128_26 = var_128_23 / var_128_24
					local var_128_27 = var_128_22 / var_128_25
					local var_128_28 = var_128_27 < var_128_26 and var_128_26 or var_128_27

					var_128_18.transform.localScale = Vector3.New(var_128_28, var_128_28, 0)
				end

				for iter_128_1, iter_128_2 in pairs(arg_125_1.bgs_) do
					if iter_128_1 ~= "OM0501" then
						iter_128_2.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_128_29 = arg_125_1.bgs_.OM0501.transform
			local var_128_30 = 0

			if var_128_30 < arg_125_1.time_ and arg_125_1.time_ <= var_128_30 + arg_128_0 then
				arg_125_1.var_.moveOldPosOM0501 = var_128_29.localPosition
			end

			local var_128_31 = 0.001

			if var_128_30 <= arg_125_1.time_ and arg_125_1.time_ < var_128_30 + var_128_31 then
				local var_128_32 = (arg_125_1.time_ - var_128_30) / var_128_31
				local var_128_33 = Vector3.New(0, 1, 9.5)

				var_128_29.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPosOM0501, var_128_33, var_128_32)
			end

			if arg_125_1.time_ >= var_128_30 + var_128_31 and arg_125_1.time_ < var_128_30 + var_128_31 + arg_128_0 then
				var_128_29.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_128_34 = arg_125_1.bgs_.OM0501.transform
			local var_128_35 = 0.034

			if var_128_35 < arg_125_1.time_ and arg_125_1.time_ <= var_128_35 + arg_128_0 then
				arg_125_1.var_.moveOldPosOM0501 = var_128_34.localPosition
			end

			local var_128_36 = 2.5

			if var_128_35 <= arg_125_1.time_ and arg_125_1.time_ < var_128_35 + var_128_36 then
				local var_128_37 = (arg_125_1.time_ - var_128_35) / var_128_36
				local var_128_38 = Vector3.New(0, 1, 10)

				var_128_34.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPosOM0501, var_128_38, var_128_37)
			end

			if arg_125_1.time_ >= var_128_35 + var_128_36 and arg_125_1.time_ < var_128_35 + var_128_36 + arg_128_0 then
				var_128_34.localPosition = Vector3.New(0, 1, 10)
			end

			local var_128_39 = 2

			if var_128_39 < arg_125_1.time_ and arg_125_1.time_ <= var_128_39 + arg_128_0 then
				arg_125_1.allBtn_.enabled = false
			end

			local var_128_40 = 0.6

			if arg_125_1.time_ >= var_128_39 + var_128_40 and arg_125_1.time_ < var_128_39 + var_128_40 + arg_128_0 then
				arg_125_1.allBtn_.enabled = true
			end

			local var_128_41 = manager.ui.mainCamera.transform
			local var_128_42 = 2

			if var_128_42 < arg_125_1.time_ and arg_125_1.time_ <= var_128_42 + arg_128_0 then
				arg_125_1.var_.shakeOldPos = var_128_41.localPosition
			end

			local var_128_43 = 0.6

			if var_128_42 <= arg_125_1.time_ and arg_125_1.time_ < var_128_42 + var_128_43 then
				local var_128_44 = (arg_125_1.time_ - var_128_42) / 0.066
				local var_128_45, var_128_46 = math.modf(var_128_44)

				var_128_41.localPosition = Vector3.New(var_128_46 * 0.13, var_128_46 * 0.13, var_128_46 * 0.13) + arg_125_1.var_.shakeOldPos
			end

			if arg_125_1.time_ >= var_128_42 + var_128_43 and arg_125_1.time_ < var_128_42 + var_128_43 + arg_128_0 then
				var_128_41.localPosition = arg_125_1.var_.shakeOldPos
			end

			if arg_125_1.frameCnt_ <= 1 then
				arg_125_1.dialog_:SetActive(false)
			end

			local var_128_47 = 1.999999999999
			local var_128_48 = 0.55

			if var_128_47 < arg_125_1.time_ and arg_125_1.time_ <= var_128_47 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0

				arg_125_1.dialog_:SetActive(true)

				arg_125_1.dialogCg_.alpha = 0

				local var_128_49 = LeanTween.value(arg_125_1.dialog_, 0, 1, 0.3)

				var_128_49:setOnUpdate(LuaHelper.FloatAction(function(arg_129_0)
					arg_125_1.dialogCg_.alpha = arg_129_0
				end))
				var_128_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_125_1.dialog_)
					var_128_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_125_1.duration_ = arg_125_1.duration_ + 0.3

				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_50 = arg_125_1:FormatText(StoryNameCfg[256].name)

				arg_125_1.leftNameTxt_.text = var_128_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3020")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_51 = arg_125_1:GetWordFromCfg(114221030)
				local var_128_52 = arg_125_1:FormatText(var_128_51.content)

				arg_125_1.text_.text = var_128_52

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_53 = 22
				local var_128_54 = utf8.len(var_128_52)
				local var_128_55 = var_128_53 <= 0 and var_128_48 or var_128_48 * (var_128_54 / var_128_53)

				if var_128_55 > 0 and var_128_48 < var_128_55 then
					arg_125_1.talkMaxDuration = var_128_55
					var_128_47 = var_128_47 + 0.3

					if var_128_55 + var_128_47 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_55 + var_128_47
					end
				end

				arg_125_1.text_.text = var_128_52
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114221", "114221030", "story_v_out_114221.awb") ~= 0 then
					local var_128_56 = manager.audio:GetVoiceLength("story_v_out_114221", "114221030", "story_v_out_114221.awb") / 1000

					if var_128_56 + var_128_47 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_56 + var_128_47
					end

					if var_128_51.prefab_name ~= "" and arg_125_1.actors_[var_128_51.prefab_name] ~= nil then
						local var_128_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_51.prefab_name].transform, "story_v_out_114221", "114221030", "story_v_out_114221.awb")

						arg_125_1:RecordAudio("114221030", var_128_57)
						arg_125_1:RecordAudio("114221030", var_128_57)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_114221", "114221030", "story_v_out_114221.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_114221", "114221030", "story_v_out_114221.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_58 = var_128_47 + 0.3
			local var_128_59 = math.max(var_128_48, arg_125_1.talkMaxDuration)

			if var_128_58 <= arg_125_1.time_ and arg_125_1.time_ < var_128_58 + var_128_59 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_58) / var_128_59

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_58 + var_128_59 and arg_125_1.time_ < var_128_58 + var_128_59 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "OM0501",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "OM0501",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.5,
				className = "StoryMoveNode",
				startTime = 0.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play114221031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 114221031
		arg_131_1.duration_ = 2.7

		local var_131_0 = {
			ja = 2.7,
			ko = 1.733,
			zh = 1.666,
			en = 1.666
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
			arg_131_1.auto_ = false
		end

		function arg_131_1.playNext_(arg_133_0)
			arg_131_1.onStoryFinished_()
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.175

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[208].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_3 = arg_131_1:GetWordFromCfg(114221031)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_114221", "114221031", "story_v_out_114221.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_114221", "114221031", "story_v_out_114221.awb") / 1000

					if var_134_8 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_0
					end

					if var_134_3.prefab_name ~= "" and arg_131_1.actors_[var_134_3.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_3.prefab_name].transform, "story_v_out_114221", "114221031", "story_v_out_114221.awb")

						arg_131_1:RecordAudio("114221031", var_134_9)
						arg_131_1:RecordAudio("114221031", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_114221", "114221031", "story_v_out_114221.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_114221", "114221031", "story_v_out_114221.awb")
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
	assets = {
		"TextureConfig/Background/F03",
		"TextureConfig/Background/OM0501"
	},
	voices = {
		"story_v_out_114221.awb"
	}
}
