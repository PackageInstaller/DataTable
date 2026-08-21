return {
	Play413022001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413022001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play413022002(arg_1_1)
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

				arg_1_1:AudioAction(var_4_32, var_4_33, "bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete.awb")

				local var_4_34 = ""
				local var_4_35 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete", "bgm_activity_3_4_story_crete")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_36 = 1.999999999999
			local var_4_37 = 0.4

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_38 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_38:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_39 = arg_1_1:GetWordFromCfg(413022001)
				local var_4_40 = arg_1_1:FormatText(var_4_39.content)

				arg_1_1.text_.text = var_4_40

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_41 = 16
				local var_4_42 = utf8.len(var_4_40)
				local var_4_43 = var_4_41 <= 0 and var_4_37 or var_4_37 * (var_4_42 / var_4_41)

				if var_4_43 > 0 and var_4_37 < var_4_43 then
					arg_1_1.talkMaxDuration = var_4_43
					var_4_36 = var_4_36 + 0.3

					if var_4_43 + var_4_36 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_43 + var_4_36
					end
				end

				arg_1_1.text_.text = var_4_40
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_44 = var_4_36 + 0.3
			local var_4_45 = math.max(var_4_37, arg_1_1.talkMaxDuration)

			if var_4_44 <= arg_1_1.time_ and arg_1_1.time_ < var_4_44 + var_4_45 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_44) / var_4_45

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_44 + var_4_45 and arg_1_1.time_ < var_4_44 + var_4_45 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play413022002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413022002
		arg_9_1.duration_ = 4.7

		local var_9_0 = {
			zh = 4.699999999999,
			ja = 4.532999999999
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play413022003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "F08h"

			if arg_9_1.bgs_[var_12_0] == nil then
				local var_12_1 = Object.Instantiate(arg_9_1.paintGo_)

				var_12_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_12_0)
				var_12_1.name = var_12_0
				var_12_1.transform.parent = arg_9_1.stage_.transform
				var_12_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.bgs_[var_12_0] = var_12_1
			end

			local var_12_2 = 0

			if var_12_2 < arg_9_1.time_ and arg_9_1.time_ <= var_12_2 + arg_12_0 then
				local var_12_3 = manager.ui.mainCamera.transform.localPosition
				local var_12_4 = Vector3.New(0, 0, 10) + Vector3.New(var_12_3.x, var_12_3.y, 0)
				local var_12_5 = arg_9_1.bgs_.F08h

				var_12_5.transform.localPosition = var_12_4
				var_12_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_12_6 = var_12_5:GetComponent("SpriteRenderer")

				if var_12_6 and var_12_6.sprite then
					local var_12_7 = (var_12_5.transform.localPosition - var_12_3).z
					local var_12_8 = manager.ui.mainCameraCom_
					local var_12_9 = 2 * var_12_7 * Mathf.Tan(var_12_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_12_10 = var_12_9 * var_12_8.aspect
					local var_12_11 = var_12_6.sprite.bounds.size.x
					local var_12_12 = var_12_6.sprite.bounds.size.y
					local var_12_13 = var_12_10 / var_12_11
					local var_12_14 = var_12_9 / var_12_12
					local var_12_15 = var_12_14 < var_12_13 and var_12_13 or var_12_14

					var_12_5.transform.localScale = Vector3.New(var_12_15, var_12_15, 0)
				end

				for iter_12_0, iter_12_1 in pairs(arg_9_1.bgs_) do
					if iter_12_0 ~= "F08h" then
						iter_12_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_12_16 = 1.999999999999

			if var_12_16 < arg_9_1.time_ and arg_9_1.time_ <= var_12_16 + arg_12_0 then
				arg_9_1.allBtn_.enabled = false
			end

			local var_12_17 = 0.3

			if arg_9_1.time_ >= var_12_16 + var_12_17 and arg_9_1.time_ < var_12_16 + var_12_17 + arg_12_0 then
				arg_9_1.allBtn_.enabled = true
			end

			local var_12_18 = 0

			if var_12_18 < arg_9_1.time_ and arg_9_1.time_ <= var_12_18 + arg_12_0 then
				arg_9_1.mask_.enabled = true
				arg_9_1.mask_.raycastTarget = true

				arg_9_1:SetGaussion(false)
			end

			local var_12_19 = 2

			if var_12_18 <= arg_9_1.time_ and arg_9_1.time_ < var_12_18 + var_12_19 then
				local var_12_20 = (arg_9_1.time_ - var_12_18) / var_12_19
				local var_12_21 = Color.New(0, 0, 0)

				var_12_21.a = Mathf.Lerp(1, 0, var_12_20)
				arg_9_1.mask_.color = var_12_21
			end

			if arg_9_1.time_ >= var_12_18 + var_12_19 and arg_9_1.time_ < var_12_18 + var_12_19 + arg_12_0 then
				local var_12_22 = Color.New(0, 0, 0)
				local var_12_23 = 0

				arg_9_1.mask_.enabled = false
				var_12_22.a = var_12_23
				arg_9_1.mask_.color = var_12_22
			end

			local var_12_24 = "10092"

			if arg_9_1.actors_[var_12_24] == nil then
				local var_12_25 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_12_25) then
					local var_12_26 = Object.Instantiate(var_12_25, arg_9_1.canvasGo_.transform)

					var_12_26.transform:SetSiblingIndex(1)

					var_12_26.name = var_12_24
					var_12_26.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_[var_12_24] = var_12_26

					local var_12_27 = var_12_26:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_9_1.isInRecall_ then
						for iter_12_2, iter_12_3 in ipairs(var_12_27) do
							iter_12_3.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_28 = arg_9_1.actors_["10092"].transform
			local var_12_29 = 2

			if var_12_29 < arg_9_1.time_ and arg_9_1.time_ <= var_12_29 + arg_12_0 then
				arg_9_1.var_.moveOldPos10092 = var_12_28.localPosition
				var_12_28.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10092", 2)

				local var_12_30 = var_12_28.childCount

				for iter_12_4 = 0, var_12_30 - 1 do
					local var_12_31 = var_12_28:GetChild(iter_12_4)

					if var_12_31.name == "split_6" or not string.find(var_12_31.name, "split") then
						var_12_31.gameObject:SetActive(true)
					else
						var_12_31.gameObject:SetActive(false)
					end
				end
			end

			local var_12_32 = 0.001

			if var_12_29 <= arg_9_1.time_ and arg_9_1.time_ < var_12_29 + var_12_32 then
				local var_12_33 = (arg_9_1.time_ - var_12_29) / var_12_32
				local var_12_34 = Vector3.New(-389.49, -300, -295)

				var_12_28.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10092, var_12_34, var_12_33)
			end

			if arg_9_1.time_ >= var_12_29 + var_12_32 and arg_9_1.time_ < var_12_29 + var_12_32 + arg_12_0 then
				var_12_28.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_12_35 = arg_9_1.actors_["10092"]
			local var_12_36 = 1.999999999999

			if var_12_36 < arg_9_1.time_ and arg_9_1.time_ <= var_12_36 + arg_12_0 and not isNil(var_12_35) and arg_9_1.var_.actorSpriteComps10092 == nil then
				arg_9_1.var_.actorSpriteComps10092 = var_12_35:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_37 = 2

			if var_12_36 <= arg_9_1.time_ and arg_9_1.time_ < var_12_36 + var_12_37 and not isNil(var_12_35) then
				local var_12_38 = (arg_9_1.time_ - var_12_36) / var_12_37

				if arg_9_1.var_.actorSpriteComps10092 then
					for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_12_6 then
							if arg_9_1.isInRecall_ then
								local var_12_39 = Mathf.Lerp(iter_12_6.color.r, arg_9_1.hightColor1.r, var_12_38)
								local var_12_40 = Mathf.Lerp(iter_12_6.color.g, arg_9_1.hightColor1.g, var_12_38)
								local var_12_41 = Mathf.Lerp(iter_12_6.color.b, arg_9_1.hightColor1.b, var_12_38)

								iter_12_6.color = Color.New(var_12_39, var_12_40, var_12_41)
							else
								local var_12_42 = Mathf.Lerp(iter_12_6.color.r, 1, var_12_38)

								iter_12_6.color = Color.New(var_12_42, var_12_42, var_12_42)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= var_12_36 + var_12_37 and arg_9_1.time_ < var_12_36 + var_12_37 + arg_12_0 and not isNil(var_12_35) and arg_9_1.var_.actorSpriteComps10092 then
				for iter_12_7, iter_12_8 in pairs(arg_9_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_12_8 then
						if arg_9_1.isInRecall_ then
							iter_12_8.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_12_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_9_1.var_.actorSpriteComps10092 = nil
			end

			local var_12_43 = arg_9_1.actors_["10092"]
			local var_12_44 = 1.999999999999

			if var_12_44 < arg_9_1.time_ and arg_9_1.time_ <= var_12_44 + arg_12_0 then
				local var_12_45 = var_12_43:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_45 then
					arg_9_1.var_.alphaOldValue10092 = var_12_45.alpha
					arg_9_1.var_.characterEffect10092 = var_12_45
				end

				arg_9_1.var_.alphaOldValue10092 = 0
			end

			local var_12_46 = 0.2

			if var_12_44 <= arg_9_1.time_ and arg_9_1.time_ < var_12_44 + var_12_46 then
				local var_12_47 = (arg_9_1.time_ - var_12_44) / var_12_46
				local var_12_48 = Mathf.Lerp(arg_9_1.var_.alphaOldValue10092, 1, var_12_47)

				if arg_9_1.var_.characterEffect10092 then
					arg_9_1.var_.characterEffect10092.alpha = var_12_48
				end
			end

			if arg_9_1.time_ >= var_12_44 + var_12_46 and arg_9_1.time_ < var_12_44 + var_12_46 + arg_12_0 and arg_9_1.var_.characterEffect10092 then
				arg_9_1.var_.characterEffect10092.alpha = 1
			end

			if arg_9_1.frameCnt_ <= 1 then
				arg_9_1.dialog_:SetActive(false)
			end

			local var_12_49 = 1.999999999999
			local var_12_50 = 0.2

			if var_12_49 < arg_9_1.time_ and arg_9_1.time_ <= var_12_49 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0

				arg_9_1.dialog_:SetActive(true)

				arg_9_1.dialogCg_.alpha = 0

				local var_12_51 = LeanTween.value(arg_9_1.dialog_, 0, 1, 0.3)

				var_12_51:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_9_1.dialogCg_.alpha = arg_13_0
				end))
				var_12_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_9_1.dialog_)
					var_12_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_9_1.duration_ = arg_9_1.duration_ + 0.3

				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_52 = arg_9_1:FormatText(StoryNameCfg[996].name)

				arg_9_1.leftNameTxt_.text = var_12_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_53 = arg_9_1:GetWordFromCfg(413022002)
				local var_12_54 = arg_9_1:FormatText(var_12_53.content)

				arg_9_1.text_.text = var_12_54

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_55 = 8
				local var_12_56 = utf8.len(var_12_54)
				local var_12_57 = var_12_55 <= 0 and var_12_50 or var_12_50 * (var_12_56 / var_12_55)

				if var_12_57 > 0 and var_12_50 < var_12_57 then
					arg_9_1.talkMaxDuration = var_12_57
					var_12_49 = var_12_49 + 0.3

					if var_12_57 + var_12_49 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_57 + var_12_49
					end
				end

				arg_9_1.text_.text = var_12_54
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022002", "story_v_out_413022.awb") ~= 0 then
					local var_12_58 = manager.audio:GetVoiceLength("story_v_out_413022", "413022002", "story_v_out_413022.awb") / 1000

					if var_12_58 + var_12_49 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_58 + var_12_49
					end

					if var_12_53.prefab_name ~= "" and arg_9_1.actors_[var_12_53.prefab_name] ~= nil then
						local var_12_59 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_53.prefab_name].transform, "story_v_out_413022", "413022002", "story_v_out_413022.awb")

						arg_9_1:RecordAudio("413022002", var_12_59)
						arg_9_1:RecordAudio("413022002", var_12_59)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_413022", "413022002", "story_v_out_413022.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_413022", "413022002", "story_v_out_413022.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_60 = var_12_49 + 0.3
			local var_12_61 = math.max(var_12_50, arg_9_1.talkMaxDuration)

			if var_12_60 <= arg_9_1.time_ and arg_9_1.time_ < var_12_60 + var_12_61 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_60) / var_12_61

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_60 + var_12_61 and arg_9_1.time_ < var_12_60 + var_12_61 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play413022003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 413022003
		arg_15_1.duration_ = 3

		local var_15_0 = {
			zh = 2.566,
			ja = 3
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play413022004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = arg_15_1.actors_["10092"].transform
			local var_18_1 = 0

			if var_18_1 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
				arg_15_1.var_.moveOldPos10092 = var_18_0.localPosition
				var_18_0.localScale = Vector3.New(1, 1, 1)

				arg_15_1:CheckSpriteTmpPos("10092", 2)

				local var_18_2 = var_18_0.childCount

				for iter_18_0 = 0, var_18_2 - 1 do
					local var_18_3 = var_18_0:GetChild(iter_18_0)

					if var_18_3.name == "" or not string.find(var_18_3.name, "split") then
						var_18_3.gameObject:SetActive(true)
					else
						var_18_3.gameObject:SetActive(false)
					end
				end
			end

			local var_18_4 = 0.001

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_4 then
				local var_18_5 = (arg_15_1.time_ - var_18_1) / var_18_4
				local var_18_6 = Vector3.New(-389.49, -300, -295)

				var_18_0.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos10092, var_18_6, var_18_5)
			end

			if arg_15_1.time_ >= var_18_1 + var_18_4 and arg_15_1.time_ < var_18_1 + var_18_4 + arg_18_0 then
				var_18_0.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_18_7 = "10022"

			if arg_15_1.actors_[var_18_7] == nil then
				local var_18_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_18_8) then
					local var_18_9 = Object.Instantiate(var_18_8, arg_15_1.canvasGo_.transform)

					var_18_9.transform:SetSiblingIndex(1)

					var_18_9.name = var_18_7
					var_18_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_15_1.actors_[var_18_7] = var_18_9

					local var_18_10 = var_18_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_15_1.isInRecall_ then
						for iter_18_1, iter_18_2 in ipairs(var_18_10) do
							iter_18_2.color = arg_15_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_18_11 = arg_15_1.actors_["10022"].transform
			local var_18_12 = 0

			if var_18_12 < arg_15_1.time_ and arg_15_1.time_ <= var_18_12 + arg_18_0 then
				arg_15_1.var_.moveOldPos10022 = var_18_11.localPosition
				var_18_11.localScale = Vector3.New(1, 1, 1)

				arg_15_1:CheckSpriteTmpPos("10022", 4)

				local var_18_13 = var_18_11.childCount

				for iter_18_3 = 0, var_18_13 - 1 do
					local var_18_14 = var_18_11:GetChild(iter_18_3)

					if var_18_14.name == "split_6" or not string.find(var_18_14.name, "split") then
						var_18_14.gameObject:SetActive(true)
					else
						var_18_14.gameObject:SetActive(false)
					end
				end
			end

			local var_18_15 = 0.001

			if var_18_12 <= arg_15_1.time_ and arg_15_1.time_ < var_18_12 + var_18_15 then
				local var_18_16 = (arg_15_1.time_ - var_18_12) / var_18_15
				local var_18_17 = Vector3.New(390, -315, -320)

				var_18_11.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos10022, var_18_17, var_18_16)
			end

			if arg_15_1.time_ >= var_18_12 + var_18_15 and arg_15_1.time_ < var_18_12 + var_18_15 + arg_18_0 then
				var_18_11.localPosition = Vector3.New(390, -315, -320)
			end

			local var_18_18 = arg_15_1.actors_["10092"]
			local var_18_19 = 0

			if var_18_19 < arg_15_1.time_ and arg_15_1.time_ <= var_18_19 + arg_18_0 and not isNil(var_18_18) and arg_15_1.var_.actorSpriteComps10092 == nil then
				arg_15_1.var_.actorSpriteComps10092 = var_18_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_18_20 = 2

			if var_18_19 <= arg_15_1.time_ and arg_15_1.time_ < var_18_19 + var_18_20 and not isNil(var_18_18) then
				local var_18_21 = (arg_15_1.time_ - var_18_19) / var_18_20

				if arg_15_1.var_.actorSpriteComps10092 then
					for iter_18_4, iter_18_5 in pairs(arg_15_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_18_5 then
							if arg_15_1.isInRecall_ then
								local var_18_22 = Mathf.Lerp(iter_18_5.color.r, arg_15_1.hightColor2.r, var_18_21)
								local var_18_23 = Mathf.Lerp(iter_18_5.color.g, arg_15_1.hightColor2.g, var_18_21)
								local var_18_24 = Mathf.Lerp(iter_18_5.color.b, arg_15_1.hightColor2.b, var_18_21)

								iter_18_5.color = Color.New(var_18_22, var_18_23, var_18_24)
							else
								local var_18_25 = Mathf.Lerp(iter_18_5.color.r, 0.5, var_18_21)

								iter_18_5.color = Color.New(var_18_25, var_18_25, var_18_25)
							end
						end
					end
				end
			end

			if arg_15_1.time_ >= var_18_19 + var_18_20 and arg_15_1.time_ < var_18_19 + var_18_20 + arg_18_0 and not isNil(var_18_18) and arg_15_1.var_.actorSpriteComps10092 then
				for iter_18_6, iter_18_7 in pairs(arg_15_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_18_7 then
						if arg_15_1.isInRecall_ then
							iter_18_7.color = arg_15_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_18_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_15_1.var_.actorSpriteComps10092 = nil
			end

			local var_18_26 = arg_15_1.actors_["10022"]
			local var_18_27 = 0

			if var_18_27 < arg_15_1.time_ and arg_15_1.time_ <= var_18_27 + arg_18_0 and not isNil(var_18_26) and arg_15_1.var_.actorSpriteComps10022 == nil then
				arg_15_1.var_.actorSpriteComps10022 = var_18_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_18_28 = 2

			if var_18_27 <= arg_15_1.time_ and arg_15_1.time_ < var_18_27 + var_18_28 and not isNil(var_18_26) then
				local var_18_29 = (arg_15_1.time_ - var_18_27) / var_18_28

				if arg_15_1.var_.actorSpriteComps10022 then
					for iter_18_8, iter_18_9 in pairs(arg_15_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_18_9 then
							if arg_15_1.isInRecall_ then
								local var_18_30 = Mathf.Lerp(iter_18_9.color.r, arg_15_1.hightColor1.r, var_18_29)
								local var_18_31 = Mathf.Lerp(iter_18_9.color.g, arg_15_1.hightColor1.g, var_18_29)
								local var_18_32 = Mathf.Lerp(iter_18_9.color.b, arg_15_1.hightColor1.b, var_18_29)

								iter_18_9.color = Color.New(var_18_30, var_18_31, var_18_32)
							else
								local var_18_33 = Mathf.Lerp(iter_18_9.color.r, 1, var_18_29)

								iter_18_9.color = Color.New(var_18_33, var_18_33, var_18_33)
							end
						end
					end
				end
			end

			if arg_15_1.time_ >= var_18_27 + var_18_28 and arg_15_1.time_ < var_18_27 + var_18_28 + arg_18_0 and not isNil(var_18_26) and arg_15_1.var_.actorSpriteComps10022 then
				for iter_18_10, iter_18_11 in pairs(arg_15_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_18_11 then
						if arg_15_1.isInRecall_ then
							iter_18_11.color = arg_15_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_18_11.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_15_1.var_.actorSpriteComps10022 = nil
			end

			local var_18_34 = arg_15_1.actors_["10022"]
			local var_18_35 = 0

			if var_18_35 < arg_15_1.time_ and arg_15_1.time_ <= var_18_35 + arg_18_0 then
				local var_18_36 = var_18_34:GetComponentInChildren(typeof(CanvasGroup))

				if var_18_36 then
					arg_15_1.var_.alphaOldValue10022 = var_18_36.alpha
					arg_15_1.var_.characterEffect10022 = var_18_36
				end

				arg_15_1.var_.alphaOldValue10022 = 0
			end

			local var_18_37 = 0.2

			if var_18_35 <= arg_15_1.time_ and arg_15_1.time_ < var_18_35 + var_18_37 then
				local var_18_38 = (arg_15_1.time_ - var_18_35) / var_18_37
				local var_18_39 = Mathf.Lerp(arg_15_1.var_.alphaOldValue10022, 1, var_18_38)

				if arg_15_1.var_.characterEffect10022 then
					arg_15_1.var_.characterEffect10022.alpha = var_18_39
				end
			end

			if arg_15_1.time_ >= var_18_35 + var_18_37 and arg_15_1.time_ < var_18_35 + var_18_37 + arg_18_0 and arg_15_1.var_.characterEffect10022 then
				arg_15_1.var_.characterEffect10022.alpha = 1
			end

			local var_18_40 = 0
			local var_18_41 = 0.3

			if var_18_40 < arg_15_1.time_ and arg_15_1.time_ <= var_18_40 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_42 = arg_15_1:FormatText(StoryNameCfg[614].name)

				arg_15_1.leftNameTxt_.text = var_18_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_43 = arg_15_1:GetWordFromCfg(413022003)
				local var_18_44 = arg_15_1:FormatText(var_18_43.content)

				arg_15_1.text_.text = var_18_44

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_45 = 12
				local var_18_46 = utf8.len(var_18_44)
				local var_18_47 = var_18_45 <= 0 and var_18_41 or var_18_41 * (var_18_46 / var_18_45)

				if var_18_47 > 0 and var_18_41 < var_18_47 then
					arg_15_1.talkMaxDuration = var_18_47

					if var_18_47 + var_18_40 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_47 + var_18_40
					end
				end

				arg_15_1.text_.text = var_18_44
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022003", "story_v_out_413022.awb") ~= 0 then
					local var_18_48 = manager.audio:GetVoiceLength("story_v_out_413022", "413022003", "story_v_out_413022.awb") / 1000

					if var_18_48 + var_18_40 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_48 + var_18_40
					end

					if var_18_43.prefab_name ~= "" and arg_15_1.actors_[var_18_43.prefab_name] ~= nil then
						local var_18_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_43.prefab_name].transform, "story_v_out_413022", "413022003", "story_v_out_413022.awb")

						arg_15_1:RecordAudio("413022003", var_18_49)
						arg_15_1:RecordAudio("413022003", var_18_49)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_413022", "413022003", "story_v_out_413022.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_413022", "413022003", "story_v_out_413022.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_50 = math.max(var_18_41, arg_15_1.talkMaxDuration)

			if var_18_40 <= arg_15_1.time_ and arg_15_1.time_ < var_18_40 + var_18_50 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_40) / var_18_50

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_40 + var_18_50 and arg_15_1.time_ < var_18_40 + var_18_50 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
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
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play413022004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 413022004
		arg_19_1.duration_ = 10.03

		local var_19_0 = {
			zh = 4.166,
			ja = 10.033
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play413022005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = arg_19_1.actors_["10092"]
			local var_22_1 = 0

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.actorSpriteComps10092 == nil then
				arg_19_1.var_.actorSpriteComps10092 = var_22_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_2 = 2

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_2 and not isNil(var_22_0) then
				local var_22_3 = (arg_19_1.time_ - var_22_1) / var_22_2

				if arg_19_1.var_.actorSpriteComps10092 then
					for iter_22_0, iter_22_1 in pairs(arg_19_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_22_1 then
							if arg_19_1.isInRecall_ then
								local var_22_4 = Mathf.Lerp(iter_22_1.color.r, arg_19_1.hightColor1.r, var_22_3)
								local var_22_5 = Mathf.Lerp(iter_22_1.color.g, arg_19_1.hightColor1.g, var_22_3)
								local var_22_6 = Mathf.Lerp(iter_22_1.color.b, arg_19_1.hightColor1.b, var_22_3)

								iter_22_1.color = Color.New(var_22_4, var_22_5, var_22_6)
							else
								local var_22_7 = Mathf.Lerp(iter_22_1.color.r, 1, var_22_3)

								iter_22_1.color = Color.New(var_22_7, var_22_7, var_22_7)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= var_22_1 + var_22_2 and arg_19_1.time_ < var_22_1 + var_22_2 + arg_22_0 and not isNil(var_22_0) and arg_19_1.var_.actorSpriteComps10092 then
				for iter_22_2, iter_22_3 in pairs(arg_19_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_22_3 then
						if arg_19_1.isInRecall_ then
							iter_22_3.color = arg_19_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_22_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_19_1.var_.actorSpriteComps10092 = nil
			end

			local var_22_8 = arg_19_1.actors_["10022"]
			local var_22_9 = 0

			if var_22_9 < arg_19_1.time_ and arg_19_1.time_ <= var_22_9 + arg_22_0 and not isNil(var_22_8) and arg_19_1.var_.actorSpriteComps10022 == nil then
				arg_19_1.var_.actorSpriteComps10022 = var_22_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_10 = 2

			if var_22_9 <= arg_19_1.time_ and arg_19_1.time_ < var_22_9 + var_22_10 and not isNil(var_22_8) then
				local var_22_11 = (arg_19_1.time_ - var_22_9) / var_22_10

				if arg_19_1.var_.actorSpriteComps10022 then
					for iter_22_4, iter_22_5 in pairs(arg_19_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_22_5 then
							if arg_19_1.isInRecall_ then
								local var_22_12 = Mathf.Lerp(iter_22_5.color.r, arg_19_1.hightColor2.r, var_22_11)
								local var_22_13 = Mathf.Lerp(iter_22_5.color.g, arg_19_1.hightColor2.g, var_22_11)
								local var_22_14 = Mathf.Lerp(iter_22_5.color.b, arg_19_1.hightColor2.b, var_22_11)

								iter_22_5.color = Color.New(var_22_12, var_22_13, var_22_14)
							else
								local var_22_15 = Mathf.Lerp(iter_22_5.color.r, 0.5, var_22_11)

								iter_22_5.color = Color.New(var_22_15, var_22_15, var_22_15)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= var_22_9 + var_22_10 and arg_19_1.time_ < var_22_9 + var_22_10 + arg_22_0 and not isNil(var_22_8) and arg_19_1.var_.actorSpriteComps10022 then
				for iter_22_6, iter_22_7 in pairs(arg_19_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_22_7 then
						if arg_19_1.isInRecall_ then
							iter_22_7.color = arg_19_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_22_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_19_1.var_.actorSpriteComps10022 = nil
			end

			local var_22_16 = 0
			local var_22_17 = 0.525

			if var_22_16 < arg_19_1.time_ and arg_19_1.time_ <= var_22_16 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_18 = arg_19_1:FormatText(StoryNameCfg[996].name)

				arg_19_1.leftNameTxt_.text = var_22_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_19 = arg_19_1:GetWordFromCfg(413022004)
				local var_22_20 = arg_19_1:FormatText(var_22_19.content)

				arg_19_1.text_.text = var_22_20

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_21 = 21
				local var_22_22 = utf8.len(var_22_20)
				local var_22_23 = var_22_21 <= 0 and var_22_17 or var_22_17 * (var_22_22 / var_22_21)

				if var_22_23 > 0 and var_22_17 < var_22_23 then
					arg_19_1.talkMaxDuration = var_22_23

					if var_22_23 + var_22_16 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_23 + var_22_16
					end
				end

				arg_19_1.text_.text = var_22_20
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022004", "story_v_out_413022.awb") ~= 0 then
					local var_22_24 = manager.audio:GetVoiceLength("story_v_out_413022", "413022004", "story_v_out_413022.awb") / 1000

					if var_22_24 + var_22_16 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_24 + var_22_16
					end

					if var_22_19.prefab_name ~= "" and arg_19_1.actors_[var_22_19.prefab_name] ~= nil then
						local var_22_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_19.prefab_name].transform, "story_v_out_413022", "413022004", "story_v_out_413022.awb")

						arg_19_1:RecordAudio("413022004", var_22_25)
						arg_19_1:RecordAudio("413022004", var_22_25)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_413022", "413022004", "story_v_out_413022.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_413022", "413022004", "story_v_out_413022.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_26 = math.max(var_22_17, arg_19_1.talkMaxDuration)

			if var_22_16 <= arg_19_1.time_ and arg_19_1.time_ < var_22_16 + var_22_26 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_16) / var_22_26

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_16 + var_22_26 and arg_19_1.time_ < var_22_16 + var_22_26 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play413022005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 413022005
		arg_23_1.duration_ = 6.17

		local var_23_0 = {
			zh = 3.866,
			ja = 6.166
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
				arg_23_0:Play413022006(arg_23_1)
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

			local var_26_8 = arg_23_1.actors_["10022"]
			local var_26_9 = 0

			if var_26_9 < arg_23_1.time_ and arg_23_1.time_ <= var_26_9 + arg_26_0 and not isNil(var_26_8) and arg_23_1.var_.actorSpriteComps10022 == nil then
				arg_23_1.var_.actorSpriteComps10022 = var_26_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_10 = 2

			if var_26_9 <= arg_23_1.time_ and arg_23_1.time_ < var_26_9 + var_26_10 and not isNil(var_26_8) then
				local var_26_11 = (arg_23_1.time_ - var_26_9) / var_26_10

				if arg_23_1.var_.actorSpriteComps10022 then
					for iter_26_4, iter_26_5 in pairs(arg_23_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_26_5 then
							if arg_23_1.isInRecall_ then
								local var_26_12 = Mathf.Lerp(iter_26_5.color.r, arg_23_1.hightColor1.r, var_26_11)
								local var_26_13 = Mathf.Lerp(iter_26_5.color.g, arg_23_1.hightColor1.g, var_26_11)
								local var_26_14 = Mathf.Lerp(iter_26_5.color.b, arg_23_1.hightColor1.b, var_26_11)

								iter_26_5.color = Color.New(var_26_12, var_26_13, var_26_14)
							else
								local var_26_15 = Mathf.Lerp(iter_26_5.color.r, 1, var_26_11)

								iter_26_5.color = Color.New(var_26_15, var_26_15, var_26_15)
							end
						end
					end
				end
			end

			if arg_23_1.time_ >= var_26_9 + var_26_10 and arg_23_1.time_ < var_26_9 + var_26_10 + arg_26_0 and not isNil(var_26_8) and arg_23_1.var_.actorSpriteComps10022 then
				for iter_26_6, iter_26_7 in pairs(arg_23_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_26_7 then
						if arg_23_1.isInRecall_ then
							iter_26_7.color = arg_23_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_26_7.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_23_1.var_.actorSpriteComps10022 = nil
			end

			local var_26_16 = 0
			local var_26_17 = 0.6

			if var_26_16 < arg_23_1.time_ and arg_23_1.time_ <= var_26_16 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_18 = arg_23_1:FormatText(StoryNameCfg[614].name)

				arg_23_1.leftNameTxt_.text = var_26_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_19 = arg_23_1:GetWordFromCfg(413022005)
				local var_26_20 = arg_23_1:FormatText(var_26_19.content)

				arg_23_1.text_.text = var_26_20

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_21 = 24
				local var_26_22 = utf8.len(var_26_20)
				local var_26_23 = var_26_21 <= 0 and var_26_17 or var_26_17 * (var_26_22 / var_26_21)

				if var_26_23 > 0 and var_26_17 < var_26_23 then
					arg_23_1.talkMaxDuration = var_26_23

					if var_26_23 + var_26_16 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_23 + var_26_16
					end
				end

				arg_23_1.text_.text = var_26_20
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022005", "story_v_out_413022.awb") ~= 0 then
					local var_26_24 = manager.audio:GetVoiceLength("story_v_out_413022", "413022005", "story_v_out_413022.awb") / 1000

					if var_26_24 + var_26_16 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_24 + var_26_16
					end

					if var_26_19.prefab_name ~= "" and arg_23_1.actors_[var_26_19.prefab_name] ~= nil then
						local var_26_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_19.prefab_name].transform, "story_v_out_413022", "413022005", "story_v_out_413022.awb")

						arg_23_1:RecordAudio("413022005", var_26_25)
						arg_23_1:RecordAudio("413022005", var_26_25)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_413022", "413022005", "story_v_out_413022.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_413022", "413022005", "story_v_out_413022.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_26 = math.max(var_26_17, arg_23_1.talkMaxDuration)

			if var_26_16 <= arg_23_1.time_ and arg_23_1.time_ < var_26_16 + var_26_26 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_16) / var_26_26

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_16 + var_26_26 and arg_23_1.time_ < var_26_16 + var_26_26 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play413022006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 413022006
		arg_27_1.duration_ = 5.57

		local var_27_0 = {
			zh = 5.566,
			ja = 4.766
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
				arg_27_0:Play413022007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0
			local var_30_1 = 0.8

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_2 = arg_27_1:FormatText(StoryNameCfg[614].name)

				arg_27_1.leftNameTxt_.text = var_30_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_3 = arg_27_1:GetWordFromCfg(413022006)
				local var_30_4 = arg_27_1:FormatText(var_30_3.content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 32
				local var_30_6 = utf8.len(var_30_4)
				local var_30_7 = var_30_5 <= 0 and var_30_1 or var_30_1 * (var_30_6 / var_30_5)

				if var_30_7 > 0 and var_30_1 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7

					if var_30_7 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_0
					end
				end

				arg_27_1.text_.text = var_30_4
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022006", "story_v_out_413022.awb") ~= 0 then
					local var_30_8 = manager.audio:GetVoiceLength("story_v_out_413022", "413022006", "story_v_out_413022.awb") / 1000

					if var_30_8 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_8 + var_30_0
					end

					if var_30_3.prefab_name ~= "" and arg_27_1.actors_[var_30_3.prefab_name] ~= nil then
						local var_30_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_3.prefab_name].transform, "story_v_out_413022", "413022006", "story_v_out_413022.awb")

						arg_27_1:RecordAudio("413022006", var_30_9)
						arg_27_1:RecordAudio("413022006", var_30_9)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_413022", "413022006", "story_v_out_413022.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_413022", "413022006", "story_v_out_413022.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_10 = math.max(var_30_1, arg_27_1.talkMaxDuration)

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_10 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_0) / var_30_10

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_0 + var_30_10 and arg_27_1.time_ < var_30_0 + var_30_10 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play413022007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 413022007
		arg_31_1.duration_ = 8.93

		local var_31_0 = {
			zh = 5,
			ja = 8.933
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
				arg_31_0:Play413022008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["10022"]
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.actorSpriteComps10022 == nil then
				arg_31_1.var_.actorSpriteComps10022 = var_34_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_34_2 = 2

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 and not isNil(var_34_0) then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2

				if arg_31_1.var_.actorSpriteComps10022 then
					for iter_34_0, iter_34_1 in pairs(arg_31_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 and not isNil(var_34_0) and arg_31_1.var_.actorSpriteComps10022 then
				for iter_34_2, iter_34_3 in pairs(arg_31_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_34_3 then
						if arg_31_1.isInRecall_ then
							iter_34_3.color = arg_31_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_34_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_31_1.var_.actorSpriteComps10022 = nil
			end

			local var_34_8 = 0
			local var_34_9 = 0.575

			if var_34_8 < arg_31_1.time_ and arg_31_1.time_ <= var_34_8 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_10 = arg_31_1:FormatText(StoryNameCfg[36].name)

				arg_31_1.leftNameTxt_.text = var_34_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10097_split_1")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_11 = arg_31_1:GetWordFromCfg(413022007)
				local var_34_12 = arg_31_1:FormatText(var_34_11.content)

				arg_31_1.text_.text = var_34_12

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_13 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022007", "story_v_out_413022.awb") ~= 0 then
					local var_34_16 = manager.audio:GetVoiceLength("story_v_out_413022", "413022007", "story_v_out_413022.awb") / 1000

					if var_34_16 + var_34_8 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_16 + var_34_8
					end

					if var_34_11.prefab_name ~= "" and arg_31_1.actors_[var_34_11.prefab_name] ~= nil then
						local var_34_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_11.prefab_name].transform, "story_v_out_413022", "413022007", "story_v_out_413022.awb")

						arg_31_1:RecordAudio("413022007", var_34_17)
						arg_31_1:RecordAudio("413022007", var_34_17)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_413022", "413022007", "story_v_out_413022.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_413022", "413022007", "story_v_out_413022.awb")
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
	Play413022008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 413022008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play413022009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["10022"].transform
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.var_.moveOldPos10022 = var_38_0.localPosition
				var_38_0.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("10022", 7)

				local var_38_2 = var_38_0.childCount

				for iter_38_0 = 0, var_38_2 - 1 do
					local var_38_3 = var_38_0:GetChild(iter_38_0)

					if var_38_3.name == "" or not string.find(var_38_3.name, "split") then
						var_38_3.gameObject:SetActive(true)
					else
						var_38_3.gameObject:SetActive(false)
					end
				end
			end

			local var_38_4 = 0.001

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_4 then
				local var_38_5 = (arg_35_1.time_ - var_38_1) / var_38_4
				local var_38_6 = Vector3.New(0, -2000, -180)

				var_38_0.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10022, var_38_6, var_38_5)
			end

			if arg_35_1.time_ >= var_38_1 + var_38_4 and arg_35_1.time_ < var_38_1 + var_38_4 + arg_38_0 then
				var_38_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_38_7 = arg_35_1.actors_["10022"]
			local var_38_8 = 0

			if var_38_8 < arg_35_1.time_ and arg_35_1.time_ <= var_38_8 + arg_38_0 and not isNil(var_38_7) and arg_35_1.var_.actorSpriteComps10022 == nil then
				arg_35_1.var_.actorSpriteComps10022 = var_38_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_9 = 2

			if var_38_8 <= arg_35_1.time_ and arg_35_1.time_ < var_38_8 + var_38_9 and not isNil(var_38_7) then
				local var_38_10 = (arg_35_1.time_ - var_38_8) / var_38_9

				if arg_35_1.var_.actorSpriteComps10022 then
					for iter_38_1, iter_38_2 in pairs(arg_35_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_38_2 then
							if arg_35_1.isInRecall_ then
								local var_38_11 = Mathf.Lerp(iter_38_2.color.r, arg_35_1.hightColor2.r, var_38_10)
								local var_38_12 = Mathf.Lerp(iter_38_2.color.g, arg_35_1.hightColor2.g, var_38_10)
								local var_38_13 = Mathf.Lerp(iter_38_2.color.b, arg_35_1.hightColor2.b, var_38_10)

								iter_38_2.color = Color.New(var_38_11, var_38_12, var_38_13)
							else
								local var_38_14 = Mathf.Lerp(iter_38_2.color.r, 0.5, var_38_10)

								iter_38_2.color = Color.New(var_38_14, var_38_14, var_38_14)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= var_38_8 + var_38_9 and arg_35_1.time_ < var_38_8 + var_38_9 + arg_38_0 and not isNil(var_38_7) and arg_35_1.var_.actorSpriteComps10022 then
				for iter_38_3, iter_38_4 in pairs(arg_35_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_38_4 then
						if arg_35_1.isInRecall_ then
							iter_38_4.color = arg_35_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_38_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_35_1.var_.actorSpriteComps10022 = nil
			end

			local var_38_15 = arg_35_1.actors_["10092"].transform
			local var_38_16 = 0

			if var_38_16 < arg_35_1.time_ and arg_35_1.time_ <= var_38_16 + arg_38_0 then
				arg_35_1.var_.moveOldPos10092 = var_38_15.localPosition
				var_38_15.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("10092", 7)

				local var_38_17 = var_38_15.childCount

				for iter_38_5 = 0, var_38_17 - 1 do
					local var_38_18 = var_38_15:GetChild(iter_38_5)

					if var_38_18.name == "" or not string.find(var_38_18.name, "split") then
						var_38_18.gameObject:SetActive(true)
					else
						var_38_18.gameObject:SetActive(false)
					end
				end
			end

			local var_38_19 = 0.001

			if var_38_16 <= arg_35_1.time_ and arg_35_1.time_ < var_38_16 + var_38_19 then
				local var_38_20 = (arg_35_1.time_ - var_38_16) / var_38_19
				local var_38_21 = Vector3.New(0, -2000, -180)

				var_38_15.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10092, var_38_21, var_38_20)
			end

			if arg_35_1.time_ >= var_38_16 + var_38_19 and arg_35_1.time_ < var_38_16 + var_38_19 + arg_38_0 then
				var_38_15.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_38_22 = arg_35_1.actors_["10092"]
			local var_38_23 = 0

			if var_38_23 < arg_35_1.time_ and arg_35_1.time_ <= var_38_23 + arg_38_0 then
				local var_38_24 = var_38_22:GetComponentInChildren(typeof(CanvasGroup))

				if var_38_24 then
					arg_35_1.var_.alphaOldValue10092 = var_38_24.alpha
					arg_35_1.var_.characterEffect10092 = var_38_24
				end

				arg_35_1.var_.alphaOldValue10092 = 1
			end

			local var_38_25 = 0.5

			if var_38_23 <= arg_35_1.time_ and arg_35_1.time_ < var_38_23 + var_38_25 then
				local var_38_26 = (arg_35_1.time_ - var_38_23) / var_38_25
				local var_38_27 = Mathf.Lerp(arg_35_1.var_.alphaOldValue10092, 0, var_38_26)

				if arg_35_1.var_.characterEffect10092 then
					arg_35_1.var_.characterEffect10092.alpha = var_38_27
				end
			end

			if arg_35_1.time_ >= var_38_23 + var_38_25 and arg_35_1.time_ < var_38_23 + var_38_25 + arg_38_0 and arg_35_1.var_.characterEffect10092 then
				arg_35_1.var_.characterEffect10092.alpha = 0
			end

			local var_38_28 = arg_35_1.actors_["10022"]
			local var_38_29 = 0

			if var_38_29 < arg_35_1.time_ and arg_35_1.time_ <= var_38_29 + arg_38_0 then
				local var_38_30 = var_38_28:GetComponentInChildren(typeof(CanvasGroup))

				if var_38_30 then
					arg_35_1.var_.alphaOldValue10022 = var_38_30.alpha
					arg_35_1.var_.characterEffect10022 = var_38_30
				end

				arg_35_1.var_.alphaOldValue10022 = 1
			end

			local var_38_31 = 0.5

			if var_38_29 <= arg_35_1.time_ and arg_35_1.time_ < var_38_29 + var_38_31 then
				local var_38_32 = (arg_35_1.time_ - var_38_29) / var_38_31
				local var_38_33 = Mathf.Lerp(arg_35_1.var_.alphaOldValue10022, 0, var_38_32)

				if arg_35_1.var_.characterEffect10022 then
					arg_35_1.var_.characterEffect10022.alpha = var_38_33
				end
			end

			if arg_35_1.time_ >= var_38_29 + var_38_31 and arg_35_1.time_ < var_38_29 + var_38_31 + arg_38_0 and arg_35_1.var_.characterEffect10022 then
				arg_35_1.var_.characterEffect10022.alpha = 0
			end

			local var_38_34 = 0
			local var_38_35 = 1

			if var_38_34 < arg_35_1.time_ and arg_35_1.time_ <= var_38_34 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_36 = arg_35_1:GetWordFromCfg(413022008)
				local var_38_37 = arg_35_1:FormatText(var_38_36.content)

				arg_35_1.text_.text = var_38_37

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_38 = 40
				local var_38_39 = utf8.len(var_38_37)
				local var_38_40 = var_38_38 <= 0 and var_38_35 or var_38_35 * (var_38_39 / var_38_38)

				if var_38_40 > 0 and var_38_35 < var_38_40 then
					arg_35_1.talkMaxDuration = var_38_40

					if var_38_40 + var_38_34 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_40 + var_38_34
					end
				end

				arg_35_1.text_.text = var_38_37
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_41 = math.max(var_38_35, arg_35_1.talkMaxDuration)

			if var_38_34 <= arg_35_1.time_ and arg_35_1.time_ < var_38_34 + var_38_41 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_34) / var_38_41

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_34 + var_38_41 and arg_35_1.time_ < var_38_34 + var_38_41 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
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
	Play413022009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 413022009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play413022010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0
			local var_42_1 = 1.15

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_2 = arg_39_1:GetWordFromCfg(413022009)
				local var_42_3 = arg_39_1:FormatText(var_42_2.content)

				arg_39_1.text_.text = var_42_3

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 46
				local var_42_5 = utf8.len(var_42_3)
				local var_42_6 = var_42_4 <= 0 and var_42_1 or var_42_1 * (var_42_5 / var_42_4)

				if var_42_6 > 0 and var_42_1 < var_42_6 then
					arg_39_1.talkMaxDuration = var_42_6

					if var_42_6 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_6 + var_42_0
					end
				end

				arg_39_1.text_.text = var_42_3
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_1, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_7 and arg_39_1.time_ < var_42_0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play413022010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 413022010
		arg_43_1.duration_ = 8.43

		local var_43_0 = {
			zh = 6.99933333333333,
			ja = 8.43333333333333
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
				arg_43_0:Play413022011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = "10097"

			if arg_43_1.actors_[var_46_0] == nil then
				local var_46_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10097")

				if not isNil(var_46_1) then
					local var_46_2 = Object.Instantiate(var_46_1, arg_43_1.canvasGo_.transform)

					var_46_2.transform:SetSiblingIndex(1)

					var_46_2.name = var_46_0
					var_46_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_43_1.actors_[var_46_0] = var_46_2

					local var_46_3 = var_46_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_43_1.isInRecall_ then
						for iter_46_0, iter_46_1 in ipairs(var_46_3) do
							iter_46_1.color = arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_46_4 = arg_43_1.actors_["10097"].transform
			local var_46_5 = 0

			if var_46_5 < arg_43_1.time_ and arg_43_1.time_ <= var_46_5 + arg_46_0 then
				arg_43_1.var_.moveOldPos10097 = var_46_4.localPosition
				var_46_4.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("10097", 3)

				local var_46_6 = var_46_4.childCount

				for iter_46_2 = 0, var_46_6 - 1 do
					local var_46_7 = var_46_4:GetChild(iter_46_2)

					if var_46_7.name == "split_2" or not string.find(var_46_7.name, "split") then
						var_46_7.gameObject:SetActive(true)
					else
						var_46_7.gameObject:SetActive(false)
					end
				end
			end

			local var_46_8 = 0.001

			if var_46_5 <= arg_43_1.time_ and arg_43_1.time_ < var_46_5 + var_46_8 then
				local var_46_9 = (arg_43_1.time_ - var_46_5) / var_46_8
				local var_46_10 = Vector3.New(0, -350, -180)

				var_46_4.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos10097, var_46_10, var_46_9)
			end

			if arg_43_1.time_ >= var_46_5 + var_46_8 and arg_43_1.time_ < var_46_5 + var_46_8 + arg_46_0 then
				var_46_4.localPosition = Vector3.New(0, -350, -180)
			end

			local var_46_11 = arg_43_1.actors_["10097"]
			local var_46_12 = 0

			if var_46_12 < arg_43_1.time_ and arg_43_1.time_ <= var_46_12 + arg_46_0 and not isNil(var_46_11) and arg_43_1.var_.actorSpriteComps10097 == nil then
				arg_43_1.var_.actorSpriteComps10097 = var_46_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_13 = 2

			if var_46_12 <= arg_43_1.time_ and arg_43_1.time_ < var_46_12 + var_46_13 and not isNil(var_46_11) then
				local var_46_14 = (arg_43_1.time_ - var_46_12) / var_46_13

				if arg_43_1.var_.actorSpriteComps10097 then
					for iter_46_3, iter_46_4 in pairs(arg_43_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_46_4 then
							if arg_43_1.isInRecall_ then
								local var_46_15 = Mathf.Lerp(iter_46_4.color.r, arg_43_1.hightColor1.r, var_46_14)
								local var_46_16 = Mathf.Lerp(iter_46_4.color.g, arg_43_1.hightColor1.g, var_46_14)
								local var_46_17 = Mathf.Lerp(iter_46_4.color.b, arg_43_1.hightColor1.b, var_46_14)

								iter_46_4.color = Color.New(var_46_15, var_46_16, var_46_17)
							else
								local var_46_18 = Mathf.Lerp(iter_46_4.color.r, 1, var_46_14)

								iter_46_4.color = Color.New(var_46_18, var_46_18, var_46_18)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= var_46_12 + var_46_13 and arg_43_1.time_ < var_46_12 + var_46_13 + arg_46_0 and not isNil(var_46_11) and arg_43_1.var_.actorSpriteComps10097 then
				for iter_46_5, iter_46_6 in pairs(arg_43_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_46_6 then
						if arg_43_1.isInRecall_ then
							iter_46_6.color = arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_46_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_43_1.var_.actorSpriteComps10097 = nil
			end

			local var_46_19 = arg_43_1.actors_["10097"]
			local var_46_20 = 0

			if var_46_20 < arg_43_1.time_ and arg_43_1.time_ <= var_46_20 + arg_46_0 then
				local var_46_21 = var_46_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_46_21 then
					arg_43_1.var_.alphaOldValue10097 = var_46_21.alpha
					arg_43_1.var_.characterEffect10097 = var_46_21
				end

				arg_43_1.var_.alphaOldValue10097 = 0
			end

			local var_46_22 = 0.2

			if var_46_20 <= arg_43_1.time_ and arg_43_1.time_ < var_46_20 + var_46_22 then
				local var_46_23 = (arg_43_1.time_ - var_46_20) / var_46_22
				local var_46_24 = Mathf.Lerp(arg_43_1.var_.alphaOldValue10097, 1, var_46_23)

				if arg_43_1.var_.characterEffect10097 then
					arg_43_1.var_.characterEffect10097.alpha = var_46_24
				end
			end

			if arg_43_1.time_ >= var_46_20 + var_46_22 and arg_43_1.time_ < var_46_20 + var_46_22 + arg_46_0 and arg_43_1.var_.characterEffect10097 then
				arg_43_1.var_.characterEffect10097.alpha = 1
			end

			if arg_43_1.frameCnt_ <= 1 then
				arg_43_1.dialog_:SetActive(false)
			end

			local var_46_25 = 0.433333333333333
			local var_46_26 = 0.725

			if var_46_25 < arg_43_1.time_ and arg_43_1.time_ <= var_46_25 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				arg_43_1.dialog_:SetActive(true)

				arg_43_1.dialogCg_.alpha = 0

				local var_46_27 = LeanTween.value(arg_43_1.dialog_, 0, 1, 0.3)

				var_46_27:setOnUpdate(LuaHelper.FloatAction(function(arg_47_0)
					arg_43_1.dialogCg_.alpha = arg_47_0
				end))
				var_46_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_43_1.dialog_)
					var_46_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_43_1.duration_ = arg_43_1.duration_ + 0.3

				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_28 = arg_43_1:FormatText(StoryNameCfg[36].name)

				arg_43_1.leftNameTxt_.text = var_46_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_29 = arg_43_1:GetWordFromCfg(413022010)
				local var_46_30 = arg_43_1:FormatText(var_46_29.content)

				arg_43_1.text_.text = var_46_30

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_31 = 29
				local var_46_32 = utf8.len(var_46_30)
				local var_46_33 = var_46_31 <= 0 and var_46_26 or var_46_26 * (var_46_32 / var_46_31)

				if var_46_33 > 0 and var_46_26 < var_46_33 then
					arg_43_1.talkMaxDuration = var_46_33
					var_46_25 = var_46_25 + 0.3

					if var_46_33 + var_46_25 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_33 + var_46_25
					end
				end

				arg_43_1.text_.text = var_46_30
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022010", "story_v_out_413022.awb") ~= 0 then
					local var_46_34 = manager.audio:GetVoiceLength("story_v_out_413022", "413022010", "story_v_out_413022.awb") / 1000

					if var_46_34 + var_46_25 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_34 + var_46_25
					end

					if var_46_29.prefab_name ~= "" and arg_43_1.actors_[var_46_29.prefab_name] ~= nil then
						local var_46_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_29.prefab_name].transform, "story_v_out_413022", "413022010", "story_v_out_413022.awb")

						arg_43_1:RecordAudio("413022010", var_46_35)
						arg_43_1:RecordAudio("413022010", var_46_35)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_413022", "413022010", "story_v_out_413022.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_413022", "413022010", "story_v_out_413022.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_36 = var_46_25 + 0.3
			local var_46_37 = math.max(var_46_26, arg_43_1.talkMaxDuration)

			if var_46_36 <= arg_43_1.time_ and arg_43_1.time_ < var_46_36 + var_46_37 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_36) / var_46_37

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_36 + var_46_37 and arg_43_1.time_ < var_46_36 + var_46_37 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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
	Play413022011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 413022011
		arg_49_1.duration_ = 5.8

		local var_49_0 = {
			zh = 3.933,
			ja = 5.8
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
				arg_49_0:Play413022012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0
			local var_52_1 = 0.45

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_2 = arg_49_1:FormatText(StoryNameCfg[36].name)

				arg_49_1.leftNameTxt_.text = var_52_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_3 = arg_49_1:GetWordFromCfg(413022011)
				local var_52_4 = arg_49_1:FormatText(var_52_3.content)

				arg_49_1.text_.text = var_52_4

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 18
				local var_52_6 = utf8.len(var_52_4)
				local var_52_7 = var_52_5 <= 0 and var_52_1 or var_52_1 * (var_52_6 / var_52_5)

				if var_52_7 > 0 and var_52_1 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_0
					end
				end

				arg_49_1.text_.text = var_52_4
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022011", "story_v_out_413022.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_413022", "413022011", "story_v_out_413022.awb") / 1000

					if var_52_8 + var_52_0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_0
					end

					if var_52_3.prefab_name ~= "" and arg_49_1.actors_[var_52_3.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_3.prefab_name].transform, "story_v_out_413022", "413022011", "story_v_out_413022.awb")

						arg_49_1:RecordAudio("413022011", var_52_9)
						arg_49_1:RecordAudio("413022011", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_413022", "413022011", "story_v_out_413022.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_413022", "413022011", "story_v_out_413022.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_1, arg_49_1.talkMaxDuration)

			if var_52_0 <= arg_49_1.time_ and arg_49_1.time_ < var_52_0 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_0) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_0 + var_52_10 and arg_49_1.time_ < var_52_0 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play413022012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 413022012
		arg_53_1.duration_ = 2.6

		local var_53_0 = {
			zh = 2.6,
			ja = 1.999999999999
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play413022013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["10097"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps10097 == nil then
				arg_53_1.var_.actorSpriteComps10097 = var_56_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_2 = 2

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.actorSpriteComps10097 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								local var_56_4 = Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor2.r, var_56_3)
								local var_56_5 = Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor2.g, var_56_3)
								local var_56_6 = Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor2.b, var_56_3)

								iter_56_1.color = Color.New(var_56_4, var_56_5, var_56_6)
							else
								local var_56_7 = Mathf.Lerp(iter_56_1.color.r, 0.5, var_56_3)

								iter_56_1.color = Color.New(var_56_7, var_56_7, var_56_7)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.actorSpriteComps10097 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_56_3 then
						if arg_53_1.isInRecall_ then
							iter_56_3.color = arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_56_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_53_1.var_.actorSpriteComps10097 = nil
			end

			local var_56_8 = 0
			local var_56_9 = 0.225

			if var_56_8 < arg_53_1.time_ and arg_53_1.time_ <= var_56_8 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_10 = arg_53_1:FormatText(StoryNameCfg[995].name)

				arg_53_1.leftNameTxt_.text = var_56_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_11 = arg_53_1:GetWordFromCfg(413022012)
				local var_56_12 = arg_53_1:FormatText(var_56_11.content)

				arg_53_1.text_.text = var_56_12

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_13 = 9
				local var_56_14 = utf8.len(var_56_12)
				local var_56_15 = var_56_13 <= 0 and var_56_9 or var_56_9 * (var_56_14 / var_56_13)

				if var_56_15 > 0 and var_56_9 < var_56_15 then
					arg_53_1.talkMaxDuration = var_56_15

					if var_56_15 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_15 + var_56_8
					end
				end

				arg_53_1.text_.text = var_56_12
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022012", "story_v_out_413022.awb") ~= 0 then
					local var_56_16 = manager.audio:GetVoiceLength("story_v_out_413022", "413022012", "story_v_out_413022.awb") / 1000

					if var_56_16 + var_56_8 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_16 + var_56_8
					end

					if var_56_11.prefab_name ~= "" and arg_53_1.actors_[var_56_11.prefab_name] ~= nil then
						local var_56_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_11.prefab_name].transform, "story_v_out_413022", "413022012", "story_v_out_413022.awb")

						arg_53_1:RecordAudio("413022012", var_56_17)
						arg_53_1:RecordAudio("413022012", var_56_17)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_413022", "413022012", "story_v_out_413022.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_413022", "413022012", "story_v_out_413022.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_18 = math.max(var_56_9, arg_53_1.talkMaxDuration)

			if var_56_8 <= arg_53_1.time_ and arg_53_1.time_ < var_56_8 + var_56_18 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_8) / var_56_18

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_8 + var_56_18 and arg_53_1.time_ < var_56_8 + var_56_18 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play413022013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 413022013
		arg_57_1.duration_ = 6.3

		local var_57_0 = {
			zh = 4.8,
			ja = 6.3
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
				arg_57_0:Play413022014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 0.525

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[993].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:GetWordFromCfg(413022013)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 21
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022013", "story_v_out_413022.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_413022", "413022013", "story_v_out_413022.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_413022", "413022013", "story_v_out_413022.awb")

						arg_57_1:RecordAudio("413022013", var_60_9)
						arg_57_1:RecordAudio("413022013", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_413022", "413022013", "story_v_out_413022.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_413022", "413022013", "story_v_out_413022.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_10 and arg_57_1.time_ < var_60_0 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play413022014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 413022014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play413022015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 0.925

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_2 = arg_61_1:GetWordFromCfg(413022014)
				local var_64_3 = arg_61_1:FormatText(var_64_2.content)

				arg_61_1.text_.text = var_64_3

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_4 = 37
				local var_64_5 = utf8.len(var_64_3)
				local var_64_6 = var_64_4 <= 0 and var_64_1 or var_64_1 * (var_64_5 / var_64_4)

				if var_64_6 > 0 and var_64_1 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_3
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_7 and arg_61_1.time_ < var_64_0 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play413022015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 413022015
		arg_65_1.duration_ = 2.2

		local var_65_0 = {
			zh = 1.999999999999,
			ja = 2.2
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
				arg_65_0:Play413022016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = "10094"

			if arg_65_1.actors_[var_68_0] == nil then
				local var_68_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_68_1) then
					local var_68_2 = Object.Instantiate(var_68_1, arg_65_1.canvasGo_.transform)

					var_68_2.transform:SetSiblingIndex(1)

					var_68_2.name = var_68_0
					var_68_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_65_1.actors_[var_68_0] = var_68_2

					local var_68_3 = var_68_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_65_1.isInRecall_ then
						for iter_68_0, iter_68_1 in ipairs(var_68_3) do
							iter_68_1.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_68_4 = arg_65_1.actors_["10094"].transform
			local var_68_5 = 0

			if var_68_5 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.var_.moveOldPos10094 = var_68_4.localPosition
				var_68_4.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10094", 2)

				local var_68_6 = var_68_4.childCount

				for iter_68_2 = 0, var_68_6 - 1 do
					local var_68_7 = var_68_4:GetChild(iter_68_2)

					if var_68_7.name == "" or not string.find(var_68_7.name, "split") then
						var_68_7.gameObject:SetActive(true)
					else
						var_68_7.gameObject:SetActive(false)
					end
				end
			end

			local var_68_8 = 0.001

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_8 then
				local var_68_9 = (arg_65_1.time_ - var_68_5) / var_68_8
				local var_68_10 = Vector3.New(-390, -340, -414)

				var_68_4.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10094, var_68_10, var_68_9)
			end

			if arg_65_1.time_ >= var_68_5 + var_68_8 and arg_65_1.time_ < var_68_5 + var_68_8 + arg_68_0 then
				var_68_4.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_68_11 = arg_65_1.actors_["10094"]
			local var_68_12 = 0

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 and not isNil(var_68_11) and arg_65_1.var_.actorSpriteComps10094 == nil then
				arg_65_1.var_.actorSpriteComps10094 = var_68_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_13 = 2

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_13 and not isNil(var_68_11) then
				local var_68_14 = (arg_65_1.time_ - var_68_12) / var_68_13

				if arg_65_1.var_.actorSpriteComps10094 then
					for iter_68_3, iter_68_4 in pairs(arg_65_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_68_4 then
							if arg_65_1.isInRecall_ then
								local var_68_15 = Mathf.Lerp(iter_68_4.color.r, arg_65_1.hightColor1.r, var_68_14)
								local var_68_16 = Mathf.Lerp(iter_68_4.color.g, arg_65_1.hightColor1.g, var_68_14)
								local var_68_17 = Mathf.Lerp(iter_68_4.color.b, arg_65_1.hightColor1.b, var_68_14)

								iter_68_4.color = Color.New(var_68_15, var_68_16, var_68_17)
							else
								local var_68_18 = Mathf.Lerp(iter_68_4.color.r, 1, var_68_14)

								iter_68_4.color = Color.New(var_68_18, var_68_18, var_68_18)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= var_68_12 + var_68_13 and arg_65_1.time_ < var_68_12 + var_68_13 + arg_68_0 and not isNil(var_68_11) and arg_65_1.var_.actorSpriteComps10094 then
				for iter_68_5, iter_68_6 in pairs(arg_65_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_68_6 then
						if arg_65_1.isInRecall_ then
							iter_68_6.color = arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_68_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_65_1.var_.actorSpriteComps10094 = nil
			end

			local var_68_19 = arg_65_1.actors_["10094"]
			local var_68_20 = 0

			if var_68_20 < arg_65_1.time_ and arg_65_1.time_ <= var_68_20 + arg_68_0 then
				local var_68_21 = var_68_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_68_21 then
					arg_65_1.var_.alphaOldValue10094 = var_68_21.alpha
					arg_65_1.var_.characterEffect10094 = var_68_21
				end

				arg_65_1.var_.alphaOldValue10094 = 0
			end

			local var_68_22 = 0.2

			if var_68_20 <= arg_65_1.time_ and arg_65_1.time_ < var_68_20 + var_68_22 then
				local var_68_23 = (arg_65_1.time_ - var_68_20) / var_68_22
				local var_68_24 = Mathf.Lerp(arg_65_1.var_.alphaOldValue10094, 1, var_68_23)

				if arg_65_1.var_.characterEffect10094 then
					arg_65_1.var_.characterEffect10094.alpha = var_68_24
				end
			end

			if arg_65_1.time_ >= var_68_20 + var_68_22 and arg_65_1.time_ < var_68_20 + var_68_22 + arg_68_0 and arg_65_1.var_.characterEffect10094 then
				arg_65_1.var_.characterEffect10094.alpha = 1
			end

			local var_68_25 = arg_65_1.actors_["10097"].transform
			local var_68_26 = 0

			if var_68_26 < arg_65_1.time_ and arg_65_1.time_ <= var_68_26 + arg_68_0 then
				arg_65_1.var_.moveOldPos10097 = var_68_25.localPosition
				var_68_25.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10097", 4)

				local var_68_27 = var_68_25.childCount

				for iter_68_7 = 0, var_68_27 - 1 do
					local var_68_28 = var_68_25:GetChild(iter_68_7)

					if var_68_28.name == "split_2" or not string.find(var_68_28.name, "split") then
						var_68_28.gameObject:SetActive(true)
					else
						var_68_28.gameObject:SetActive(false)
					end
				end
			end

			local var_68_29 = 0.001

			if var_68_26 <= arg_65_1.time_ and arg_65_1.time_ < var_68_26 + var_68_29 then
				local var_68_30 = (arg_65_1.time_ - var_68_26) / var_68_29
				local var_68_31 = Vector3.New(390, -350, -180)

				var_68_25.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10097, var_68_31, var_68_30)
			end

			if arg_65_1.time_ >= var_68_26 + var_68_29 and arg_65_1.time_ < var_68_26 + var_68_29 + arg_68_0 then
				var_68_25.localPosition = Vector3.New(390, -350, -180)
			end

			local var_68_32 = 0
			local var_68_33 = 0.15

			if var_68_32 < arg_65_1.time_ and arg_65_1.time_ <= var_68_32 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_34 = arg_65_1:FormatText(StoryNameCfg[259].name)

				arg_65_1.leftNameTxt_.text = var_68_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_35 = arg_65_1:GetWordFromCfg(413022015)
				local var_68_36 = arg_65_1:FormatText(var_68_35.content)

				arg_65_1.text_.text = var_68_36

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_37 = 6
				local var_68_38 = utf8.len(var_68_36)
				local var_68_39 = var_68_37 <= 0 and var_68_33 or var_68_33 * (var_68_38 / var_68_37)

				if var_68_39 > 0 and var_68_33 < var_68_39 then
					arg_65_1.talkMaxDuration = var_68_39

					if var_68_39 + var_68_32 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_39 + var_68_32
					end
				end

				arg_65_1.text_.text = var_68_36
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022015", "story_v_out_413022.awb") ~= 0 then
					local var_68_40 = manager.audio:GetVoiceLength("story_v_out_413022", "413022015", "story_v_out_413022.awb") / 1000

					if var_68_40 + var_68_32 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_40 + var_68_32
					end

					if var_68_35.prefab_name ~= "" and arg_65_1.actors_[var_68_35.prefab_name] ~= nil then
						local var_68_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_35.prefab_name].transform, "story_v_out_413022", "413022015", "story_v_out_413022.awb")

						arg_65_1:RecordAudio("413022015", var_68_41)
						arg_65_1:RecordAudio("413022015", var_68_41)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_413022", "413022015", "story_v_out_413022.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_413022", "413022015", "story_v_out_413022.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_42 = math.max(var_68_33, arg_65_1.talkMaxDuration)

			if var_68_32 <= arg_65_1.time_ and arg_65_1.time_ < var_68_32 + var_68_42 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_32) / var_68_42

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_32 + var_68_42 and arg_65_1.time_ < var_68_32 + var_68_42 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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
				actorName = "10097",
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
	Play413022016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413022016
		arg_69_1.duration_ = 9.93

		local var_69_0 = {
			zh = 7.8,
			ja = 9.933
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
				arg_69_0:Play413022017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10097"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos10097 = var_72_0.localPosition
				var_72_0.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10097", 4)

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
				local var_72_6 = Vector3.New(390, -350, -180)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10097, var_72_6, var_72_5)
			end

			if arg_69_1.time_ >= var_72_1 + var_72_4 and arg_69_1.time_ < var_72_1 + var_72_4 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_72_7 = arg_69_1.actors_["10094"].transform
			local var_72_8 = 0

			if var_72_8 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.var_.moveOldPos10094 = var_72_7.localPosition
				var_72_7.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10094", 2)

				local var_72_9 = var_72_7.childCount

				for iter_72_1 = 0, var_72_9 - 1 do
					local var_72_10 = var_72_7:GetChild(iter_72_1)

					if var_72_10.name == "" or not string.find(var_72_10.name, "split") then
						var_72_10.gameObject:SetActive(true)
					else
						var_72_10.gameObject:SetActive(false)
					end
				end
			end

			local var_72_11 = 0.001

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_11 then
				local var_72_12 = (arg_69_1.time_ - var_72_8) / var_72_11
				local var_72_13 = Vector3.New(-390, -340, -414)

				var_72_7.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10094, var_72_13, var_72_12)
			end

			if arg_69_1.time_ >= var_72_8 + var_72_11 and arg_69_1.time_ < var_72_8 + var_72_11 + arg_72_0 then
				var_72_7.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_72_14 = arg_69_1.actors_["10097"]
			local var_72_15 = 0

			if var_72_15 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 and not isNil(var_72_14) and arg_69_1.var_.actorSpriteComps10097 == nil then
				arg_69_1.var_.actorSpriteComps10097 = var_72_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_16 = 2

			if var_72_15 <= arg_69_1.time_ and arg_69_1.time_ < var_72_15 + var_72_16 and not isNil(var_72_14) then
				local var_72_17 = (arg_69_1.time_ - var_72_15) / var_72_16

				if arg_69_1.var_.actorSpriteComps10097 then
					for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_72_3 then
							if arg_69_1.isInRecall_ then
								local var_72_18 = Mathf.Lerp(iter_72_3.color.r, arg_69_1.hightColor1.r, var_72_17)
								local var_72_19 = Mathf.Lerp(iter_72_3.color.g, arg_69_1.hightColor1.g, var_72_17)
								local var_72_20 = Mathf.Lerp(iter_72_3.color.b, arg_69_1.hightColor1.b, var_72_17)

								iter_72_3.color = Color.New(var_72_18, var_72_19, var_72_20)
							else
								local var_72_21 = Mathf.Lerp(iter_72_3.color.r, 1, var_72_17)

								iter_72_3.color = Color.New(var_72_21, var_72_21, var_72_21)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_15 + var_72_16 and arg_69_1.time_ < var_72_15 + var_72_16 + arg_72_0 and not isNil(var_72_14) and arg_69_1.var_.actorSpriteComps10097 then
				for iter_72_4, iter_72_5 in pairs(arg_69_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_72_5 then
						if arg_69_1.isInRecall_ then
							iter_72_5.color = arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_72_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10097 = nil
			end

			local var_72_22 = arg_69_1.actors_["10094"]
			local var_72_23 = 0

			if var_72_23 < arg_69_1.time_ and arg_69_1.time_ <= var_72_23 + arg_72_0 and not isNil(var_72_22) and arg_69_1.var_.actorSpriteComps10094 == nil then
				arg_69_1.var_.actorSpriteComps10094 = var_72_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_24 = 2

			if var_72_23 <= arg_69_1.time_ and arg_69_1.time_ < var_72_23 + var_72_24 and not isNil(var_72_22) then
				local var_72_25 = (arg_69_1.time_ - var_72_23) / var_72_24

				if arg_69_1.var_.actorSpriteComps10094 then
					for iter_72_6, iter_72_7 in pairs(arg_69_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_72_7 then
							if arg_69_1.isInRecall_ then
								local var_72_26 = Mathf.Lerp(iter_72_7.color.r, arg_69_1.hightColor2.r, var_72_25)
								local var_72_27 = Mathf.Lerp(iter_72_7.color.g, arg_69_1.hightColor2.g, var_72_25)
								local var_72_28 = Mathf.Lerp(iter_72_7.color.b, arg_69_1.hightColor2.b, var_72_25)

								iter_72_7.color = Color.New(var_72_26, var_72_27, var_72_28)
							else
								local var_72_29 = Mathf.Lerp(iter_72_7.color.r, 0.5, var_72_25)

								iter_72_7.color = Color.New(var_72_29, var_72_29, var_72_29)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= var_72_23 + var_72_24 and arg_69_1.time_ < var_72_23 + var_72_24 + arg_72_0 and not isNil(var_72_22) and arg_69_1.var_.actorSpriteComps10094 then
				for iter_72_8, iter_72_9 in pairs(arg_69_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_72_9 then
						if arg_69_1.isInRecall_ then
							iter_72_9.color = arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_72_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_69_1.var_.actorSpriteComps10094 = nil
			end

			local var_72_30 = 0
			local var_72_31 = 0.575

			if var_72_30 < arg_69_1.time_ and arg_69_1.time_ <= var_72_30 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_32 = arg_69_1:FormatText(StoryNameCfg[1001].name)

				arg_69_1.leftNameTxt_.text = var_72_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_33 = arg_69_1:GetWordFromCfg(413022016)
				local var_72_34 = arg_69_1:FormatText(var_72_33.content)

				arg_69_1.text_.text = var_72_34

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_35 = 23
				local var_72_36 = utf8.len(var_72_34)
				local var_72_37 = var_72_35 <= 0 and var_72_31 or var_72_31 * (var_72_36 / var_72_35)

				if var_72_37 > 0 and var_72_31 < var_72_37 then
					arg_69_1.talkMaxDuration = var_72_37

					if var_72_37 + var_72_30 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_37 + var_72_30
					end
				end

				arg_69_1.text_.text = var_72_34
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022016", "story_v_out_413022.awb") ~= 0 then
					local var_72_38 = manager.audio:GetVoiceLength("story_v_out_413022", "413022016", "story_v_out_413022.awb") / 1000

					if var_72_38 + var_72_30 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_38 + var_72_30
					end

					if var_72_33.prefab_name ~= "" and arg_69_1.actors_[var_72_33.prefab_name] ~= nil then
						local var_72_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_33.prefab_name].transform, "story_v_out_413022", "413022016", "story_v_out_413022.awb")

						arg_69_1:RecordAudio("413022016", var_72_39)
						arg_69_1:RecordAudio("413022016", var_72_39)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_413022", "413022016", "story_v_out_413022.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_413022", "413022016", "story_v_out_413022.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_40 = math.max(var_72_31, arg_69_1.talkMaxDuration)

			if var_72_30 <= arg_69_1.time_ and arg_69_1.time_ < var_72_30 + var_72_40 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_30) / var_72_40

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_30 + var_72_40 and arg_69_1.time_ < var_72_30 + var_72_40 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_69_1:InitPlayNodeList()
	end,
	Play413022017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 413022017
		arg_73_1.duration_ = 4.83

		local var_73_0 = {
			zh = 3.5,
			ja = 4.833
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play413022018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10097"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos10097 = var_76_0.localPosition
				var_76_0.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10097", 4)

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
				local var_76_6 = Vector3.New(390, -350, -180)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10097, var_76_6, var_76_5)
			end

			if arg_73_1.time_ >= var_76_1 + var_76_4 and arg_73_1.time_ < var_76_1 + var_76_4 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_76_7 = arg_73_1.actors_["10094"].transform
			local var_76_8 = 0

			if var_76_8 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.var_.moveOldPos10094 = var_76_7.localPosition
				var_76_7.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10094", 2)

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
				local var_76_13 = Vector3.New(-390, -340, -414)

				var_76_7.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10094, var_76_13, var_76_12)
			end

			if arg_73_1.time_ >= var_76_8 + var_76_11 and arg_73_1.time_ < var_76_8 + var_76_11 + arg_76_0 then
				var_76_7.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_76_14 = arg_73_1.actors_["10097"]
			local var_76_15 = 0

			if var_76_15 < arg_73_1.time_ and arg_73_1.time_ <= var_76_15 + arg_76_0 and not isNil(var_76_14) and arg_73_1.var_.actorSpriteComps10097 == nil then
				arg_73_1.var_.actorSpriteComps10097 = var_76_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_16 = 2

			if var_76_15 <= arg_73_1.time_ and arg_73_1.time_ < var_76_15 + var_76_16 and not isNil(var_76_14) then
				local var_76_17 = (arg_73_1.time_ - var_76_15) / var_76_16

				if arg_73_1.var_.actorSpriteComps10097 then
					for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_76_3 then
							if arg_73_1.isInRecall_ then
								local var_76_18 = Mathf.Lerp(iter_76_3.color.r, arg_73_1.hightColor2.r, var_76_17)
								local var_76_19 = Mathf.Lerp(iter_76_3.color.g, arg_73_1.hightColor2.g, var_76_17)
								local var_76_20 = Mathf.Lerp(iter_76_3.color.b, arg_73_1.hightColor2.b, var_76_17)

								iter_76_3.color = Color.New(var_76_18, var_76_19, var_76_20)
							else
								local var_76_21 = Mathf.Lerp(iter_76_3.color.r, 0.5, var_76_17)

								iter_76_3.color = Color.New(var_76_21, var_76_21, var_76_21)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_15 + var_76_16 and arg_73_1.time_ < var_76_15 + var_76_16 + arg_76_0 and not isNil(var_76_14) and arg_73_1.var_.actorSpriteComps10097 then
				for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_76_5 then
						if arg_73_1.isInRecall_ then
							iter_76_5.color = arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_76_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10097 = nil
			end

			local var_76_22 = arg_73_1.actors_["10094"]
			local var_76_23 = 0

			if var_76_23 < arg_73_1.time_ and arg_73_1.time_ <= var_76_23 + arg_76_0 and not isNil(var_76_22) and arg_73_1.var_.actorSpriteComps10094 == nil then
				arg_73_1.var_.actorSpriteComps10094 = var_76_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_24 = 2

			if var_76_23 <= arg_73_1.time_ and arg_73_1.time_ < var_76_23 + var_76_24 and not isNil(var_76_22) then
				local var_76_25 = (arg_73_1.time_ - var_76_23) / var_76_24

				if arg_73_1.var_.actorSpriteComps10094 then
					for iter_76_6, iter_76_7 in pairs(arg_73_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_76_7 then
							if arg_73_1.isInRecall_ then
								local var_76_26 = Mathf.Lerp(iter_76_7.color.r, arg_73_1.hightColor1.r, var_76_25)
								local var_76_27 = Mathf.Lerp(iter_76_7.color.g, arg_73_1.hightColor1.g, var_76_25)
								local var_76_28 = Mathf.Lerp(iter_76_7.color.b, arg_73_1.hightColor1.b, var_76_25)

								iter_76_7.color = Color.New(var_76_26, var_76_27, var_76_28)
							else
								local var_76_29 = Mathf.Lerp(iter_76_7.color.r, 1, var_76_25)

								iter_76_7.color = Color.New(var_76_29, var_76_29, var_76_29)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= var_76_23 + var_76_24 and arg_73_1.time_ < var_76_23 + var_76_24 + arg_76_0 and not isNil(var_76_22) and arg_73_1.var_.actorSpriteComps10094 then
				for iter_76_8, iter_76_9 in pairs(arg_73_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_76_9 then
						if arg_73_1.isInRecall_ then
							iter_76_9.color = arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_76_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_73_1.var_.actorSpriteComps10094 = nil
			end

			local var_76_30 = 0
			local var_76_31 = 0.375

			if var_76_30 < arg_73_1.time_ and arg_73_1.time_ <= var_76_30 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_32 = arg_73_1:FormatText(StoryNameCfg[259].name)

				arg_73_1.leftNameTxt_.text = var_76_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_33 = arg_73_1:GetWordFromCfg(413022017)
				local var_76_34 = arg_73_1:FormatText(var_76_33.content)

				arg_73_1.text_.text = var_76_34

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_35 = 15
				local var_76_36 = utf8.len(var_76_34)
				local var_76_37 = var_76_35 <= 0 and var_76_31 or var_76_31 * (var_76_36 / var_76_35)

				if var_76_37 > 0 and var_76_31 < var_76_37 then
					arg_73_1.talkMaxDuration = var_76_37

					if var_76_37 + var_76_30 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_37 + var_76_30
					end
				end

				arg_73_1.text_.text = var_76_34
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022017", "story_v_out_413022.awb") ~= 0 then
					local var_76_38 = manager.audio:GetVoiceLength("story_v_out_413022", "413022017", "story_v_out_413022.awb") / 1000

					if var_76_38 + var_76_30 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_38 + var_76_30
					end

					if var_76_33.prefab_name ~= "" and arg_73_1.actors_[var_76_33.prefab_name] ~= nil then
						local var_76_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_33.prefab_name].transform, "story_v_out_413022", "413022017", "story_v_out_413022.awb")

						arg_73_1:RecordAudio("413022017", var_76_39)
						arg_73_1:RecordAudio("413022017", var_76_39)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413022", "413022017", "story_v_out_413022.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413022", "413022017", "story_v_out_413022.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_40 = math.max(var_76_31, arg_73_1.talkMaxDuration)

			if var_76_30 <= arg_73_1.time_ and arg_73_1.time_ < var_76_30 + var_76_40 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_30) / var_76_40

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_30 + var_76_40 and arg_73_1.time_ < var_76_30 + var_76_40 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_73_1:InitPlayNodeList()
	end,
	Play413022018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413022018
		arg_77_1.duration_ = 4.3

		local var_77_0 = {
			zh = 3.233,
			ja = 4.3
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
				arg_77_0:Play413022019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.325

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[259].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:GetWordFromCfg(413022018)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 13
				local var_80_6 = utf8.len(var_80_4)
				local var_80_7 = var_80_5 <= 0 and var_80_1 or var_80_1 * (var_80_6 / var_80_5)

				if var_80_7 > 0 and var_80_1 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022018", "story_v_out_413022.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_413022", "413022018", "story_v_out_413022.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_413022", "413022018", "story_v_out_413022.awb")

						arg_77_1:RecordAudio("413022018", var_80_9)
						arg_77_1:RecordAudio("413022018", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413022", "413022018", "story_v_out_413022.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413022", "413022018", "story_v_out_413022.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_10 and arg_77_1.time_ < var_80_0 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play413022019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 413022019
		arg_81_1.duration_ = 2.77

		local var_81_0 = {
			zh = 2.766,
			ja = 2.533
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
				arg_81_0:Play413022020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10097"].transform
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 then
				arg_81_1.var_.moveOldPos10097 = var_84_0.localPosition
				var_84_0.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10097", 4)

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
				local var_84_6 = Vector3.New(390, -350, -180)

				var_84_0.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10097, var_84_6, var_84_5)
			end

			if arg_81_1.time_ >= var_84_1 + var_84_4 and arg_81_1.time_ < var_84_1 + var_84_4 + arg_84_0 then
				var_84_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_84_7 = arg_81_1.actors_["10094"].transform
			local var_84_8 = 0

			if var_84_8 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.var_.moveOldPos10094 = var_84_7.localPosition
				var_84_7.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10094", 2)

				local var_84_9 = var_84_7.childCount

				for iter_84_1 = 0, var_84_9 - 1 do
					local var_84_10 = var_84_7:GetChild(iter_84_1)

					if var_84_10.name == "" or not string.find(var_84_10.name, "split") then
						var_84_10.gameObject:SetActive(true)
					else
						var_84_10.gameObject:SetActive(false)
					end
				end
			end

			local var_84_11 = 0.001

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_11 then
				local var_84_12 = (arg_81_1.time_ - var_84_8) / var_84_11
				local var_84_13 = Vector3.New(-390, -340, -414)

				var_84_7.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10094, var_84_13, var_84_12)
			end

			if arg_81_1.time_ >= var_84_8 + var_84_11 and arg_81_1.time_ < var_84_8 + var_84_11 + arg_84_0 then
				var_84_7.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_84_14 = arg_81_1.actors_["10097"]
			local var_84_15 = 0

			if var_84_15 < arg_81_1.time_ and arg_81_1.time_ <= var_84_15 + arg_84_0 and not isNil(var_84_14) and arg_81_1.var_.actorSpriteComps10097 == nil then
				arg_81_1.var_.actorSpriteComps10097 = var_84_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_16 = 2

			if var_84_15 <= arg_81_1.time_ and arg_81_1.time_ < var_84_15 + var_84_16 and not isNil(var_84_14) then
				local var_84_17 = (arg_81_1.time_ - var_84_15) / var_84_16

				if arg_81_1.var_.actorSpriteComps10097 then
					for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_84_3 then
							if arg_81_1.isInRecall_ then
								local var_84_18 = Mathf.Lerp(iter_84_3.color.r, arg_81_1.hightColor1.r, var_84_17)
								local var_84_19 = Mathf.Lerp(iter_84_3.color.g, arg_81_1.hightColor1.g, var_84_17)
								local var_84_20 = Mathf.Lerp(iter_84_3.color.b, arg_81_1.hightColor1.b, var_84_17)

								iter_84_3.color = Color.New(var_84_18, var_84_19, var_84_20)
							else
								local var_84_21 = Mathf.Lerp(iter_84_3.color.r, 1, var_84_17)

								iter_84_3.color = Color.New(var_84_21, var_84_21, var_84_21)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_15 + var_84_16 and arg_81_1.time_ < var_84_15 + var_84_16 + arg_84_0 and not isNil(var_84_14) and arg_81_1.var_.actorSpriteComps10097 then
				for iter_84_4, iter_84_5 in pairs(arg_81_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_84_5 then
						if arg_81_1.isInRecall_ then
							iter_84_5.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_84_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10097 = nil
			end

			local var_84_22 = arg_81_1.actors_["10094"]
			local var_84_23 = 0

			if var_84_23 < arg_81_1.time_ and arg_81_1.time_ <= var_84_23 + arg_84_0 and not isNil(var_84_22) and arg_81_1.var_.actorSpriteComps10094 == nil then
				arg_81_1.var_.actorSpriteComps10094 = var_84_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_24 = 2

			if var_84_23 <= arg_81_1.time_ and arg_81_1.time_ < var_84_23 + var_84_24 and not isNil(var_84_22) then
				local var_84_25 = (arg_81_1.time_ - var_84_23) / var_84_24

				if arg_81_1.var_.actorSpriteComps10094 then
					for iter_84_6, iter_84_7 in pairs(arg_81_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_84_7 then
							if arg_81_1.isInRecall_ then
								local var_84_26 = Mathf.Lerp(iter_84_7.color.r, arg_81_1.hightColor2.r, var_84_25)
								local var_84_27 = Mathf.Lerp(iter_84_7.color.g, arg_81_1.hightColor2.g, var_84_25)
								local var_84_28 = Mathf.Lerp(iter_84_7.color.b, arg_81_1.hightColor2.b, var_84_25)

								iter_84_7.color = Color.New(var_84_26, var_84_27, var_84_28)
							else
								local var_84_29 = Mathf.Lerp(iter_84_7.color.r, 0.5, var_84_25)

								iter_84_7.color = Color.New(var_84_29, var_84_29, var_84_29)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= var_84_23 + var_84_24 and arg_81_1.time_ < var_84_23 + var_84_24 + arg_84_0 and not isNil(var_84_22) and arg_81_1.var_.actorSpriteComps10094 then
				for iter_84_8, iter_84_9 in pairs(arg_81_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_84_9 then
						if arg_81_1.isInRecall_ then
							iter_84_9.color = arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_84_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_81_1.var_.actorSpriteComps10094 = nil
			end

			local var_84_30 = 0
			local var_84_31 = 0.275

			if var_84_30 < arg_81_1.time_ and arg_81_1.time_ <= var_84_30 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_32 = arg_81_1:FormatText(StoryNameCfg[1001].name)

				arg_81_1.leftNameTxt_.text = var_84_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_33 = arg_81_1:GetWordFromCfg(413022019)
				local var_84_34 = arg_81_1:FormatText(var_84_33.content)

				arg_81_1.text_.text = var_84_34

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_35 = 11
				local var_84_36 = utf8.len(var_84_34)
				local var_84_37 = var_84_35 <= 0 and var_84_31 or var_84_31 * (var_84_36 / var_84_35)

				if var_84_37 > 0 and var_84_31 < var_84_37 then
					arg_81_1.talkMaxDuration = var_84_37

					if var_84_37 + var_84_30 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_37 + var_84_30
					end
				end

				arg_81_1.text_.text = var_84_34
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022019", "story_v_out_413022.awb") ~= 0 then
					local var_84_38 = manager.audio:GetVoiceLength("story_v_out_413022", "413022019", "story_v_out_413022.awb") / 1000

					if var_84_38 + var_84_30 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_38 + var_84_30
					end

					if var_84_33.prefab_name ~= "" and arg_81_1.actors_[var_84_33.prefab_name] ~= nil then
						local var_84_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_33.prefab_name].transform, "story_v_out_413022", "413022019", "story_v_out_413022.awb")

						arg_81_1:RecordAudio("413022019", var_84_39)
						arg_81_1:RecordAudio("413022019", var_84_39)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_413022", "413022019", "story_v_out_413022.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_413022", "413022019", "story_v_out_413022.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_40 = math.max(var_84_31, arg_81_1.talkMaxDuration)

			if var_84_30 <= arg_81_1.time_ and arg_81_1.time_ < var_84_30 + var_84_40 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_30) / var_84_40

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_30 + var_84_40 and arg_81_1.time_ < var_84_30 + var_84_40 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_81_1:InitPlayNodeList()
	end,
	Play413022020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413022020
		arg_85_1.duration_ = 2.67

		local var_85_0 = {
			zh = 2.5,
			ja = 2.666
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
				arg_85_0:Play413022021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["10097"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos10097 = var_88_0.localPosition
				var_88_0.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10097", 0)

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
				local var_88_6 = Vector3.New(-1500, -350, -180)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10097, var_88_6, var_88_5)
			end

			if arg_85_1.time_ >= var_88_1 + var_88_4 and arg_85_1.time_ < var_88_1 + var_88_4 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_88_7 = arg_85_1.actors_["10094"].transform
			local var_88_8 = 0

			if var_88_8 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.var_.moveOldPos10094 = var_88_7.localPosition
				var_88_7.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10094", 0)

				local var_88_9 = var_88_7.childCount

				for iter_88_1 = 0, var_88_9 - 1 do
					local var_88_10 = var_88_7:GetChild(iter_88_1)

					if var_88_10.name == "" or not string.find(var_88_10.name, "split") then
						var_88_10.gameObject:SetActive(true)
					else
						var_88_10.gameObject:SetActive(false)
					end
				end
			end

			local var_88_11 = 0.001

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_11 then
				local var_88_12 = (arg_85_1.time_ - var_88_8) / var_88_11
				local var_88_13 = Vector3.New(-5000, -340, -414)

				var_88_7.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10094, var_88_13, var_88_12)
			end

			if arg_85_1.time_ >= var_88_8 + var_88_11 and arg_85_1.time_ < var_88_8 + var_88_11 + arg_88_0 then
				var_88_7.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_88_14 = arg_85_1.actors_["10092"].transform
			local var_88_15 = 0

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.var_.moveOldPos10092 = var_88_14.localPosition
				var_88_14.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10092", 3)

				local var_88_16 = var_88_14.childCount

				for iter_88_2 = 0, var_88_16 - 1 do
					local var_88_17 = var_88_14:GetChild(iter_88_2)

					if var_88_17.name == "split_8" or not string.find(var_88_17.name, "split") then
						var_88_17.gameObject:SetActive(true)
					else
						var_88_17.gameObject:SetActive(false)
					end
				end
			end

			local var_88_18 = 0.001

			if var_88_15 <= arg_85_1.time_ and arg_85_1.time_ < var_88_15 + var_88_18 then
				local var_88_19 = (arg_85_1.time_ - var_88_15) / var_88_18
				local var_88_20 = Vector3.New(0, -300, -295)

				var_88_14.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10092, var_88_20, var_88_19)
			end

			if arg_85_1.time_ >= var_88_15 + var_88_18 and arg_85_1.time_ < var_88_15 + var_88_18 + arg_88_0 then
				var_88_14.localPosition = Vector3.New(0, -300, -295)
			end

			local var_88_21 = arg_85_1.actors_["10097"]
			local var_88_22 = 0

			if var_88_22 < arg_85_1.time_ and arg_85_1.time_ <= var_88_22 + arg_88_0 and not isNil(var_88_21) and arg_85_1.var_.actorSpriteComps10097 == nil then
				arg_85_1.var_.actorSpriteComps10097 = var_88_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_23 = 2

			if var_88_22 <= arg_85_1.time_ and arg_85_1.time_ < var_88_22 + var_88_23 and not isNil(var_88_21) then
				local var_88_24 = (arg_85_1.time_ - var_88_22) / var_88_23

				if arg_85_1.var_.actorSpriteComps10097 then
					for iter_88_3, iter_88_4 in pairs(arg_85_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_88_4 then
							if arg_85_1.isInRecall_ then
								local var_88_25 = Mathf.Lerp(iter_88_4.color.r, arg_85_1.hightColor2.r, var_88_24)
								local var_88_26 = Mathf.Lerp(iter_88_4.color.g, arg_85_1.hightColor2.g, var_88_24)
								local var_88_27 = Mathf.Lerp(iter_88_4.color.b, arg_85_1.hightColor2.b, var_88_24)

								iter_88_4.color = Color.New(var_88_25, var_88_26, var_88_27)
							else
								local var_88_28 = Mathf.Lerp(iter_88_4.color.r, 0.5, var_88_24)

								iter_88_4.color = Color.New(var_88_28, var_88_28, var_88_28)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_22 + var_88_23 and arg_85_1.time_ < var_88_22 + var_88_23 + arg_88_0 and not isNil(var_88_21) and arg_85_1.var_.actorSpriteComps10097 then
				for iter_88_5, iter_88_6 in pairs(arg_85_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_88_6 then
						if arg_85_1.isInRecall_ then
							iter_88_6.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10097 = nil
			end

			local var_88_29 = arg_85_1.actors_["10094"]
			local var_88_30 = 0

			if var_88_30 < arg_85_1.time_ and arg_85_1.time_ <= var_88_30 + arg_88_0 and not isNil(var_88_29) and arg_85_1.var_.actorSpriteComps10094 == nil then
				arg_85_1.var_.actorSpriteComps10094 = var_88_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_31 = 2

			if var_88_30 <= arg_85_1.time_ and arg_85_1.time_ < var_88_30 + var_88_31 and not isNil(var_88_29) then
				local var_88_32 = (arg_85_1.time_ - var_88_30) / var_88_31

				if arg_85_1.var_.actorSpriteComps10094 then
					for iter_88_7, iter_88_8 in pairs(arg_85_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_88_8 then
							if arg_85_1.isInRecall_ then
								local var_88_33 = Mathf.Lerp(iter_88_8.color.r, arg_85_1.hightColor2.r, var_88_32)
								local var_88_34 = Mathf.Lerp(iter_88_8.color.g, arg_85_1.hightColor2.g, var_88_32)
								local var_88_35 = Mathf.Lerp(iter_88_8.color.b, arg_85_1.hightColor2.b, var_88_32)

								iter_88_8.color = Color.New(var_88_33, var_88_34, var_88_35)
							else
								local var_88_36 = Mathf.Lerp(iter_88_8.color.r, 0.5, var_88_32)

								iter_88_8.color = Color.New(var_88_36, var_88_36, var_88_36)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_30 + var_88_31 and arg_85_1.time_ < var_88_30 + var_88_31 + arg_88_0 and not isNil(var_88_29) and arg_85_1.var_.actorSpriteComps10094 then
				for iter_88_9, iter_88_10 in pairs(arg_85_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_88_10 then
						if arg_85_1.isInRecall_ then
							iter_88_10.color = arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_88_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10094 = nil
			end

			local var_88_37 = arg_85_1.actors_["10092"]
			local var_88_38 = 0

			if var_88_38 < arg_85_1.time_ and arg_85_1.time_ <= var_88_38 + arg_88_0 and not isNil(var_88_37) and arg_85_1.var_.actorSpriteComps10092 == nil then
				arg_85_1.var_.actorSpriteComps10092 = var_88_37:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_39 = 2

			if var_88_38 <= arg_85_1.time_ and arg_85_1.time_ < var_88_38 + var_88_39 and not isNil(var_88_37) then
				local var_88_40 = (arg_85_1.time_ - var_88_38) / var_88_39

				if arg_85_1.var_.actorSpriteComps10092 then
					for iter_88_11, iter_88_12 in pairs(arg_85_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_88_12 then
							if arg_85_1.isInRecall_ then
								local var_88_41 = Mathf.Lerp(iter_88_12.color.r, arg_85_1.hightColor1.r, var_88_40)
								local var_88_42 = Mathf.Lerp(iter_88_12.color.g, arg_85_1.hightColor1.g, var_88_40)
								local var_88_43 = Mathf.Lerp(iter_88_12.color.b, arg_85_1.hightColor1.b, var_88_40)

								iter_88_12.color = Color.New(var_88_41, var_88_42, var_88_43)
							else
								local var_88_44 = Mathf.Lerp(iter_88_12.color.r, 1, var_88_40)

								iter_88_12.color = Color.New(var_88_44, var_88_44, var_88_44)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= var_88_38 + var_88_39 and arg_85_1.time_ < var_88_38 + var_88_39 + arg_88_0 and not isNil(var_88_37) and arg_85_1.var_.actorSpriteComps10092 then
				for iter_88_13, iter_88_14 in pairs(arg_85_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_88_14 then
						if arg_85_1.isInRecall_ then
							iter_88_14.color = arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_88_14.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_85_1.var_.actorSpriteComps10092 = nil
			end

			local var_88_45 = arg_85_1.actors_["10092"]
			local var_88_46 = 0

			if var_88_46 < arg_85_1.time_ and arg_85_1.time_ <= var_88_46 + arg_88_0 then
				local var_88_47 = var_88_45:GetComponentInChildren(typeof(CanvasGroup))

				if var_88_47 then
					arg_85_1.var_.alphaOldValue10092 = var_88_47.alpha
					arg_85_1.var_.characterEffect10092 = var_88_47
				end

				arg_85_1.var_.alphaOldValue10092 = 0
			end

			local var_88_48 = 0.034

			if var_88_46 <= arg_85_1.time_ and arg_85_1.time_ < var_88_46 + var_88_48 then
				local var_88_49 = (arg_85_1.time_ - var_88_46) / var_88_48
				local var_88_50 = Mathf.Lerp(arg_85_1.var_.alphaOldValue10092, 1, var_88_49)

				if arg_85_1.var_.characterEffect10092 then
					arg_85_1.var_.characterEffect10092.alpha = var_88_50
				end
			end

			if arg_85_1.time_ >= var_88_46 + var_88_48 and arg_85_1.time_ < var_88_46 + var_88_48 + arg_88_0 and arg_85_1.var_.characterEffect10092 then
				arg_85_1.var_.characterEffect10092.alpha = 1
			end

			local var_88_51 = 0
			local var_88_52 = 0.275

			if var_88_51 < arg_85_1.time_ and arg_85_1.time_ <= var_88_51 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_53 = arg_85_1:FormatText(StoryNameCfg[996].name)

				arg_85_1.leftNameTxt_.text = var_88_53

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_54 = arg_85_1:GetWordFromCfg(413022020)
				local var_88_55 = arg_85_1:FormatText(var_88_54.content)

				arg_85_1.text_.text = var_88_55

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_56 = 11
				local var_88_57 = utf8.len(var_88_55)
				local var_88_58 = var_88_56 <= 0 and var_88_52 or var_88_52 * (var_88_57 / var_88_56)

				if var_88_58 > 0 and var_88_52 < var_88_58 then
					arg_85_1.talkMaxDuration = var_88_58

					if var_88_58 + var_88_51 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_58 + var_88_51
					end
				end

				arg_85_1.text_.text = var_88_55
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022020", "story_v_out_413022.awb") ~= 0 then
					local var_88_59 = manager.audio:GetVoiceLength("story_v_out_413022", "413022020", "story_v_out_413022.awb") / 1000

					if var_88_59 + var_88_51 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_59 + var_88_51
					end

					if var_88_54.prefab_name ~= "" and arg_85_1.actors_[var_88_54.prefab_name] ~= nil then
						local var_88_60 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_54.prefab_name].transform, "story_v_out_413022", "413022020", "story_v_out_413022.awb")

						arg_85_1:RecordAudio("413022020", var_88_60)
						arg_85_1:RecordAudio("413022020", var_88_60)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413022", "413022020", "story_v_out_413022.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413022", "413022020", "story_v_out_413022.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_61 = math.max(var_88_52, arg_85_1.talkMaxDuration)

			if var_88_51 <= arg_85_1.time_ and arg_85_1.time_ < var_88_51 + var_88_61 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_51) / var_88_61

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_51 + var_88_61 and arg_85_1.time_ < var_88_51 + var_88_61 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_85_1:InitPlayNodeList()
	end,
	Play413022021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413022021
		arg_89_1.duration_ = 4.87

		local var_89_0 = {
			zh = 4.866,
			ja = 3.466
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
				arg_89_0:Play413022022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10022"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos10022 = var_92_0.localPosition
				var_92_0.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10022", 3)

				local var_92_2 = var_92_0.childCount

				for iter_92_0 = 0, var_92_2 - 1 do
					local var_92_3 = var_92_0:GetChild(iter_92_0)

					if var_92_3.name == "split_6" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_4 then
				local var_92_5 = (arg_89_1.time_ - var_92_1) / var_92_4
				local var_92_6 = Vector3.New(0, -315, -320)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10022, var_92_6, var_92_5)
			end

			if arg_89_1.time_ >= var_92_1 + var_92_4 and arg_89_1.time_ < var_92_1 + var_92_4 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_92_7 = arg_89_1.actors_["10092"].transform
			local var_92_8 = 0

			if var_92_8 < arg_89_1.time_ and arg_89_1.time_ <= var_92_8 + arg_92_0 then
				arg_89_1.var_.moveOldPos10092 = var_92_7.localPosition
				var_92_7.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("10092", 7)

				local var_92_9 = var_92_7.childCount

				for iter_92_1 = 0, var_92_9 - 1 do
					local var_92_10 = var_92_7:GetChild(iter_92_1)

					if var_92_10.name == "" or not string.find(var_92_10.name, "split") then
						var_92_10.gameObject:SetActive(true)
					else
						var_92_10.gameObject:SetActive(false)
					end
				end
			end

			local var_92_11 = 0.001

			if var_92_8 <= arg_89_1.time_ and arg_89_1.time_ < var_92_8 + var_92_11 then
				local var_92_12 = (arg_89_1.time_ - var_92_8) / var_92_11
				local var_92_13 = Vector3.New(0, -2000, 0)

				var_92_7.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos10092, var_92_13, var_92_12)
			end

			if arg_89_1.time_ >= var_92_8 + var_92_11 and arg_89_1.time_ < var_92_8 + var_92_11 + arg_92_0 then
				var_92_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_92_14 = arg_89_1.actors_["10022"]
			local var_92_15 = 0

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 and not isNil(var_92_14) and arg_89_1.var_.actorSpriteComps10022 == nil then
				arg_89_1.var_.actorSpriteComps10022 = var_92_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_16 = 2

			if var_92_15 <= arg_89_1.time_ and arg_89_1.time_ < var_92_15 + var_92_16 and not isNil(var_92_14) then
				local var_92_17 = (arg_89_1.time_ - var_92_15) / var_92_16

				if arg_89_1.var_.actorSpriteComps10022 then
					for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_92_3 then
							if arg_89_1.isInRecall_ then
								local var_92_18 = Mathf.Lerp(iter_92_3.color.r, arg_89_1.hightColor1.r, var_92_17)
								local var_92_19 = Mathf.Lerp(iter_92_3.color.g, arg_89_1.hightColor1.g, var_92_17)
								local var_92_20 = Mathf.Lerp(iter_92_3.color.b, arg_89_1.hightColor1.b, var_92_17)

								iter_92_3.color = Color.New(var_92_18, var_92_19, var_92_20)
							else
								local var_92_21 = Mathf.Lerp(iter_92_3.color.r, 1, var_92_17)

								iter_92_3.color = Color.New(var_92_21, var_92_21, var_92_21)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_15 + var_92_16 and arg_89_1.time_ < var_92_15 + var_92_16 + arg_92_0 and not isNil(var_92_14) and arg_89_1.var_.actorSpriteComps10022 then
				for iter_92_4, iter_92_5 in pairs(arg_89_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_92_5 then
						if arg_89_1.isInRecall_ then
							iter_92_5.color = arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_92_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10022 = nil
			end

			local var_92_22 = arg_89_1.actors_["10092"]
			local var_92_23 = 0

			if var_92_23 < arg_89_1.time_ and arg_89_1.time_ <= var_92_23 + arg_92_0 and not isNil(var_92_22) and arg_89_1.var_.actorSpriteComps10092 == nil then
				arg_89_1.var_.actorSpriteComps10092 = var_92_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_24 = 2

			if var_92_23 <= arg_89_1.time_ and arg_89_1.time_ < var_92_23 + var_92_24 and not isNil(var_92_22) then
				local var_92_25 = (arg_89_1.time_ - var_92_23) / var_92_24

				if arg_89_1.var_.actorSpriteComps10092 then
					for iter_92_6, iter_92_7 in pairs(arg_89_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_92_7 then
							if arg_89_1.isInRecall_ then
								local var_92_26 = Mathf.Lerp(iter_92_7.color.r, arg_89_1.hightColor2.r, var_92_25)
								local var_92_27 = Mathf.Lerp(iter_92_7.color.g, arg_89_1.hightColor2.g, var_92_25)
								local var_92_28 = Mathf.Lerp(iter_92_7.color.b, arg_89_1.hightColor2.b, var_92_25)

								iter_92_7.color = Color.New(var_92_26, var_92_27, var_92_28)
							else
								local var_92_29 = Mathf.Lerp(iter_92_7.color.r, 0.5, var_92_25)

								iter_92_7.color = Color.New(var_92_29, var_92_29, var_92_29)
							end
						end
					end
				end
			end

			if arg_89_1.time_ >= var_92_23 + var_92_24 and arg_89_1.time_ < var_92_23 + var_92_24 + arg_92_0 and not isNil(var_92_22) and arg_89_1.var_.actorSpriteComps10092 then
				for iter_92_8, iter_92_9 in pairs(arg_89_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_92_9 then
						if arg_89_1.isInRecall_ then
							iter_92_9.color = arg_89_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_92_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_89_1.var_.actorSpriteComps10092 = nil
			end

			local var_92_30 = arg_89_1.actors_["10022"]
			local var_92_31 = 0

			if var_92_31 < arg_89_1.time_ and arg_89_1.time_ <= var_92_31 + arg_92_0 then
				local var_92_32 = var_92_30:GetComponentInChildren(typeof(CanvasGroup))

				if var_92_32 then
					arg_89_1.var_.alphaOldValue10022 = var_92_32.alpha
					arg_89_1.var_.characterEffect10022 = var_92_32
				end

				arg_89_1.var_.alphaOldValue10022 = 0
			end

			local var_92_33 = 0.034

			if var_92_31 <= arg_89_1.time_ and arg_89_1.time_ < var_92_31 + var_92_33 then
				local var_92_34 = (arg_89_1.time_ - var_92_31) / var_92_33
				local var_92_35 = Mathf.Lerp(arg_89_1.var_.alphaOldValue10022, 1, var_92_34)

				if arg_89_1.var_.characterEffect10022 then
					arg_89_1.var_.characterEffect10022.alpha = var_92_35
				end
			end

			if arg_89_1.time_ >= var_92_31 + var_92_33 and arg_89_1.time_ < var_92_31 + var_92_33 + arg_92_0 and arg_89_1.var_.characterEffect10022 then
				arg_89_1.var_.characterEffect10022.alpha = 1
			end

			local var_92_36 = 0
			local var_92_37 = 0.525

			if var_92_36 < arg_89_1.time_ and arg_89_1.time_ <= var_92_36 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_38 = arg_89_1:FormatText(StoryNameCfg[614].name)

				arg_89_1.leftNameTxt_.text = var_92_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_39 = arg_89_1:GetWordFromCfg(413022021)
				local var_92_40 = arg_89_1:FormatText(var_92_39.content)

				arg_89_1.text_.text = var_92_40

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_41 = 21
				local var_92_42 = utf8.len(var_92_40)
				local var_92_43 = var_92_41 <= 0 and var_92_37 or var_92_37 * (var_92_42 / var_92_41)

				if var_92_43 > 0 and var_92_37 < var_92_43 then
					arg_89_1.talkMaxDuration = var_92_43

					if var_92_43 + var_92_36 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_43 + var_92_36
					end
				end

				arg_89_1.text_.text = var_92_40
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022021", "story_v_out_413022.awb") ~= 0 then
					local var_92_44 = manager.audio:GetVoiceLength("story_v_out_413022", "413022021", "story_v_out_413022.awb") / 1000

					if var_92_44 + var_92_36 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_44 + var_92_36
					end

					if var_92_39.prefab_name ~= "" and arg_89_1.actors_[var_92_39.prefab_name] ~= nil then
						local var_92_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_39.prefab_name].transform, "story_v_out_413022", "413022021", "story_v_out_413022.awb")

						arg_89_1:RecordAudio("413022021", var_92_45)
						arg_89_1:RecordAudio("413022021", var_92_45)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_413022", "413022021", "story_v_out_413022.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_413022", "413022021", "story_v_out_413022.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_46 = math.max(var_92_37, arg_89_1.talkMaxDuration)

			if var_92_36 <= arg_89_1.time_ and arg_89_1.time_ < var_92_36 + var_92_46 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_36) / var_92_46

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_36 + var_92_46 and arg_89_1.time_ < var_92_36 + var_92_46 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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
				actorName = "10092",
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
	Play413022022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413022022
		arg_93_1.duration_ = 15.9

		local var_93_0 = {
			zh = 9.866,
			ja = 15.9
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
				arg_93_0:Play413022023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10097"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos10097 = var_96_0.localPosition
				var_96_0.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10097", 4)

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
				local var_96_6 = Vector3.New(390, -350, -180)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10097, var_96_6, var_96_5)
			end

			if arg_93_1.time_ >= var_96_1 + var_96_4 and arg_93_1.time_ < var_96_1 + var_96_4 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_96_7 = arg_93_1.actors_["10097"]
			local var_96_8 = 0

			if var_96_8 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.actorSpriteComps10097 == nil then
				arg_93_1.var_.actorSpriteComps10097 = var_96_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_9 = 2

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_9 and not isNil(var_96_7) then
				local var_96_10 = (arg_93_1.time_ - var_96_8) / var_96_9

				if arg_93_1.var_.actorSpriteComps10097 then
					for iter_96_1, iter_96_2 in pairs(arg_93_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_96_2 then
							if arg_93_1.isInRecall_ then
								local var_96_11 = Mathf.Lerp(iter_96_2.color.r, arg_93_1.hightColor1.r, var_96_10)
								local var_96_12 = Mathf.Lerp(iter_96_2.color.g, arg_93_1.hightColor1.g, var_96_10)
								local var_96_13 = Mathf.Lerp(iter_96_2.color.b, arg_93_1.hightColor1.b, var_96_10)

								iter_96_2.color = Color.New(var_96_11, var_96_12, var_96_13)
							else
								local var_96_14 = Mathf.Lerp(iter_96_2.color.r, 1, var_96_10)

								iter_96_2.color = Color.New(var_96_14, var_96_14, var_96_14)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= var_96_8 + var_96_9 and arg_93_1.time_ < var_96_8 + var_96_9 + arg_96_0 and not isNil(var_96_7) and arg_93_1.var_.actorSpriteComps10097 then
				for iter_96_3, iter_96_4 in pairs(arg_93_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_96_4 then
						if arg_93_1.isInRecall_ then
							iter_96_4.color = arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_96_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10097 = nil
			end

			local var_96_15 = arg_93_1.actors_["10022"].transform
			local var_96_16 = 0

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				arg_93_1.var_.moveOldPos10022 = var_96_15.localPosition
				var_96_15.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("10022", 2)

				local var_96_17 = var_96_15.childCount

				for iter_96_5 = 0, var_96_17 - 1 do
					local var_96_18 = var_96_15:GetChild(iter_96_5)

					if var_96_18.name == "split_6" or not string.find(var_96_18.name, "split") then
						var_96_18.gameObject:SetActive(true)
					else
						var_96_18.gameObject:SetActive(false)
					end
				end
			end

			local var_96_19 = 0.001

			if var_96_16 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_19 then
				local var_96_20 = (arg_93_1.time_ - var_96_16) / var_96_19
				local var_96_21 = Vector3.New(-390, -315, -320)

				var_96_15.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10022, var_96_21, var_96_20)
			end

			if arg_93_1.time_ >= var_96_16 + var_96_19 and arg_93_1.time_ < var_96_16 + var_96_19 + arg_96_0 then
				var_96_15.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_96_22 = arg_93_1.actors_["10022"]
			local var_96_23 = 0

			if var_96_23 < arg_93_1.time_ and arg_93_1.time_ <= var_96_23 + arg_96_0 and not isNil(var_96_22) and arg_93_1.var_.actorSpriteComps10022 == nil then
				arg_93_1.var_.actorSpriteComps10022 = var_96_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_24 = 2

			if var_96_23 <= arg_93_1.time_ and arg_93_1.time_ < var_96_23 + var_96_24 and not isNil(var_96_22) then
				local var_96_25 = (arg_93_1.time_ - var_96_23) / var_96_24

				if arg_93_1.var_.actorSpriteComps10022 then
					for iter_96_6, iter_96_7 in pairs(arg_93_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_93_1.time_ >= var_96_23 + var_96_24 and arg_93_1.time_ < var_96_23 + var_96_24 + arg_96_0 and not isNil(var_96_22) and arg_93_1.var_.actorSpriteComps10022 then
				for iter_96_8, iter_96_9 in pairs(arg_93_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_96_9 then
						if arg_93_1.isInRecall_ then
							iter_96_9.color = arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_96_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_93_1.var_.actorSpriteComps10022 = nil
			end

			local var_96_30 = arg_93_1.actors_["10022"]
			local var_96_31 = 0

			if var_96_31 < arg_93_1.time_ and arg_93_1.time_ <= var_96_31 + arg_96_0 then
				local var_96_32 = var_96_30:GetComponentInChildren(typeof(CanvasGroup))

				if var_96_32 then
					arg_93_1.var_.alphaOldValue10022 = var_96_32.alpha
					arg_93_1.var_.characterEffect10022 = var_96_32
				end

				arg_93_1.var_.alphaOldValue10022 = 0
			end

			local var_96_33 = 0.2

			if var_96_31 <= arg_93_1.time_ and arg_93_1.time_ < var_96_31 + var_96_33 then
				local var_96_34 = (arg_93_1.time_ - var_96_31) / var_96_33
				local var_96_35 = Mathf.Lerp(arg_93_1.var_.alphaOldValue10022, 1, var_96_34)

				if arg_93_1.var_.characterEffect10022 then
					arg_93_1.var_.characterEffect10022.alpha = var_96_35
				end
			end

			if arg_93_1.time_ >= var_96_31 + var_96_33 and arg_93_1.time_ < var_96_31 + var_96_33 + arg_96_0 and arg_93_1.var_.characterEffect10022 then
				arg_93_1.var_.characterEffect10022.alpha = 1
			end

			local var_96_36 = 0
			local var_96_37 = 0.95

			if var_96_36 < arg_93_1.time_ and arg_93_1.time_ <= var_96_36 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_38 = arg_93_1:FormatText(StoryNameCfg[1001].name)

				arg_93_1.leftNameTxt_.text = var_96_38

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_39 = arg_93_1:GetWordFromCfg(413022022)
				local var_96_40 = arg_93_1:FormatText(var_96_39.content)

				arg_93_1.text_.text = var_96_40

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_41 = 38
				local var_96_42 = utf8.len(var_96_40)
				local var_96_43 = var_96_41 <= 0 and var_96_37 or var_96_37 * (var_96_42 / var_96_41)

				if var_96_43 > 0 and var_96_37 < var_96_43 then
					arg_93_1.talkMaxDuration = var_96_43

					if var_96_43 + var_96_36 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_43 + var_96_36
					end
				end

				arg_93_1.text_.text = var_96_40
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022022", "story_v_out_413022.awb") ~= 0 then
					local var_96_44 = manager.audio:GetVoiceLength("story_v_out_413022", "413022022", "story_v_out_413022.awb") / 1000

					if var_96_44 + var_96_36 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_44 + var_96_36
					end

					if var_96_39.prefab_name ~= "" and arg_93_1.actors_[var_96_39.prefab_name] ~= nil then
						local var_96_45 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_39.prefab_name].transform, "story_v_out_413022", "413022022", "story_v_out_413022.awb")

						arg_93_1:RecordAudio("413022022", var_96_45)
						arg_93_1:RecordAudio("413022022", var_96_45)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413022", "413022022", "story_v_out_413022.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413022", "413022022", "story_v_out_413022.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_46 = math.max(var_96_37, arg_93_1.talkMaxDuration)

			if var_96_36 <= arg_93_1.time_ and arg_93_1.time_ < var_96_36 + var_96_46 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_36) / var_96_46

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_36 + var_96_46 and arg_93_1.time_ < var_96_36 + var_96_46 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_93_1:InitPlayNodeList()
	end,
	Play413022023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413022023
		arg_97_1.duration_ = 6.43

		local var_97_0 = {
			zh = 4.666,
			ja = 6.433
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
				arg_97_0:Play413022024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10094"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos10094 = var_100_0.localPosition
				var_100_0.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10094", 2)

				local var_100_2 = var_100_0.childCount

				for iter_100_0 = 0, var_100_2 - 1 do
					local var_100_3 = var_100_0:GetChild(iter_100_0)

					if var_100_3.name == "" or not string.find(var_100_3.name, "split") then
						var_100_3.gameObject:SetActive(true)
					else
						var_100_3.gameObject:SetActive(false)
					end
				end
			end

			local var_100_4 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_4 then
				local var_100_5 = (arg_97_1.time_ - var_100_1) / var_100_4
				local var_100_6 = Vector3.New(-390, -340, -414)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10094, var_100_6, var_100_5)
			end

			if arg_97_1.time_ >= var_100_1 + var_100_4 and arg_97_1.time_ < var_100_1 + var_100_4 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_100_7 = arg_97_1.actors_["10097"].transform
			local var_100_8 = 0

			if var_100_8 < arg_97_1.time_ and arg_97_1.time_ <= var_100_8 + arg_100_0 then
				arg_97_1.var_.moveOldPos10097 = var_100_7.localPosition
				var_100_7.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("10097", 4)

				local var_100_9 = var_100_7.childCount

				for iter_100_1 = 0, var_100_9 - 1 do
					local var_100_10 = var_100_7:GetChild(iter_100_1)

					if var_100_10.name == "" or not string.find(var_100_10.name, "split") then
						var_100_10.gameObject:SetActive(true)
					else
						var_100_10.gameObject:SetActive(false)
					end
				end
			end

			local var_100_11 = 0.001

			if var_100_8 <= arg_97_1.time_ and arg_97_1.time_ < var_100_8 + var_100_11 then
				local var_100_12 = (arg_97_1.time_ - var_100_8) / var_100_11
				local var_100_13 = Vector3.New(390, -350, -180)

				var_100_7.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10097, var_100_13, var_100_12)
			end

			if arg_97_1.time_ >= var_100_8 + var_100_11 and arg_97_1.time_ < var_100_8 + var_100_11 + arg_100_0 then
				var_100_7.localPosition = Vector3.New(390, -350, -180)
			end

			local var_100_14 = arg_97_1.actors_["10094"]
			local var_100_15 = 0

			if var_100_15 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 and not isNil(var_100_14) and arg_97_1.var_.actorSpriteComps10094 == nil then
				arg_97_1.var_.actorSpriteComps10094 = var_100_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_16 = 2

			if var_100_15 <= arg_97_1.time_ and arg_97_1.time_ < var_100_15 + var_100_16 and not isNil(var_100_14) then
				local var_100_17 = (arg_97_1.time_ - var_100_15) / var_100_16

				if arg_97_1.var_.actorSpriteComps10094 then
					for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_100_3 then
							if arg_97_1.isInRecall_ then
								local var_100_18 = Mathf.Lerp(iter_100_3.color.r, arg_97_1.hightColor1.r, var_100_17)
								local var_100_19 = Mathf.Lerp(iter_100_3.color.g, arg_97_1.hightColor1.g, var_100_17)
								local var_100_20 = Mathf.Lerp(iter_100_3.color.b, arg_97_1.hightColor1.b, var_100_17)

								iter_100_3.color = Color.New(var_100_18, var_100_19, var_100_20)
							else
								local var_100_21 = Mathf.Lerp(iter_100_3.color.r, 1, var_100_17)

								iter_100_3.color = Color.New(var_100_21, var_100_21, var_100_21)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_15 + var_100_16 and arg_97_1.time_ < var_100_15 + var_100_16 + arg_100_0 and not isNil(var_100_14) and arg_97_1.var_.actorSpriteComps10094 then
				for iter_100_4, iter_100_5 in pairs(arg_97_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_100_5 then
						if arg_97_1.isInRecall_ then
							iter_100_5.color = arg_97_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_100_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10094 = nil
			end

			local var_100_22 = arg_97_1.actors_["10097"]
			local var_100_23 = 0

			if var_100_23 < arg_97_1.time_ and arg_97_1.time_ <= var_100_23 + arg_100_0 and not isNil(var_100_22) and arg_97_1.var_.actorSpriteComps10097 == nil then
				arg_97_1.var_.actorSpriteComps10097 = var_100_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_24 = 2

			if var_100_23 <= arg_97_1.time_ and arg_97_1.time_ < var_100_23 + var_100_24 and not isNil(var_100_22) then
				local var_100_25 = (arg_97_1.time_ - var_100_23) / var_100_24

				if arg_97_1.var_.actorSpriteComps10097 then
					for iter_100_6, iter_100_7 in pairs(arg_97_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_100_7 then
							if arg_97_1.isInRecall_ then
								local var_100_26 = Mathf.Lerp(iter_100_7.color.r, arg_97_1.hightColor2.r, var_100_25)
								local var_100_27 = Mathf.Lerp(iter_100_7.color.g, arg_97_1.hightColor2.g, var_100_25)
								local var_100_28 = Mathf.Lerp(iter_100_7.color.b, arg_97_1.hightColor2.b, var_100_25)

								iter_100_7.color = Color.New(var_100_26, var_100_27, var_100_28)
							else
								local var_100_29 = Mathf.Lerp(iter_100_7.color.r, 0.5, var_100_25)

								iter_100_7.color = Color.New(var_100_29, var_100_29, var_100_29)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= var_100_23 + var_100_24 and arg_97_1.time_ < var_100_23 + var_100_24 + arg_100_0 and not isNil(var_100_22) and arg_97_1.var_.actorSpriteComps10097 then
				for iter_100_8, iter_100_9 in pairs(arg_97_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_100_9 then
						if arg_97_1.isInRecall_ then
							iter_100_9.color = arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_100_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_97_1.var_.actorSpriteComps10097 = nil
			end

			local var_100_30 = 0
			local var_100_31 = 0.425

			if var_100_30 < arg_97_1.time_ and arg_97_1.time_ <= var_100_30 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_32 = arg_97_1:FormatText(StoryNameCfg[259].name)

				arg_97_1.leftNameTxt_.text = var_100_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_33 = arg_97_1:GetWordFromCfg(413022023)
				local var_100_34 = arg_97_1:FormatText(var_100_33.content)

				arg_97_1.text_.text = var_100_34

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_35 = 17
				local var_100_36 = utf8.len(var_100_34)
				local var_100_37 = var_100_35 <= 0 and var_100_31 or var_100_31 * (var_100_36 / var_100_35)

				if var_100_37 > 0 and var_100_31 < var_100_37 then
					arg_97_1.talkMaxDuration = var_100_37

					if var_100_37 + var_100_30 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_37 + var_100_30
					end
				end

				arg_97_1.text_.text = var_100_34
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022023", "story_v_out_413022.awb") ~= 0 then
					local var_100_38 = manager.audio:GetVoiceLength("story_v_out_413022", "413022023", "story_v_out_413022.awb") / 1000

					if var_100_38 + var_100_30 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_38 + var_100_30
					end

					if var_100_33.prefab_name ~= "" and arg_97_1.actors_[var_100_33.prefab_name] ~= nil then
						local var_100_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_33.prefab_name].transform, "story_v_out_413022", "413022023", "story_v_out_413022.awb")

						arg_97_1:RecordAudio("413022023", var_100_39)
						arg_97_1:RecordAudio("413022023", var_100_39)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_413022", "413022023", "story_v_out_413022.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_413022", "413022023", "story_v_out_413022.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_40 = math.max(var_100_31, arg_97_1.talkMaxDuration)

			if var_100_30 <= arg_97_1.time_ and arg_97_1.time_ < var_100_30 + var_100_40 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_30) / var_100_40

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_30 + var_100_40 and arg_97_1.time_ < var_100_30 + var_100_40 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
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
				actorName = "10097",
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
	Play413022024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413022024
		arg_101_1.duration_ = 7.2

		local var_101_0 = {
			zh = 4.566,
			ja = 7.2
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
				arg_101_0:Play413022025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10097"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos10097 = var_104_0.localPosition
				var_104_0.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10097", 4)

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
				local var_104_6 = Vector3.New(390, -350, -180)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10097, var_104_6, var_104_5)
			end

			if arg_101_1.time_ >= var_104_1 + var_104_4 and arg_101_1.time_ < var_104_1 + var_104_4 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_104_7 = arg_101_1.actors_["10094"].transform
			local var_104_8 = 0

			if var_104_8 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.var_.moveOldPos10094 = var_104_7.localPosition
				var_104_7.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10094", 2)

				local var_104_9 = var_104_7.childCount

				for iter_104_1 = 0, var_104_9 - 1 do
					local var_104_10 = var_104_7:GetChild(iter_104_1)

					if var_104_10.name == "" or not string.find(var_104_10.name, "split") then
						var_104_10.gameObject:SetActive(true)
					else
						var_104_10.gameObject:SetActive(false)
					end
				end
			end

			local var_104_11 = 0.001

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_11 then
				local var_104_12 = (arg_101_1.time_ - var_104_8) / var_104_11
				local var_104_13 = Vector3.New(-390, -340, -414)

				var_104_7.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10094, var_104_13, var_104_12)
			end

			if arg_101_1.time_ >= var_104_8 + var_104_11 and arg_101_1.time_ < var_104_8 + var_104_11 + arg_104_0 then
				var_104_7.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_104_14 = arg_101_1.actors_["10097"]
			local var_104_15 = 0

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 and not isNil(var_104_14) and arg_101_1.var_.actorSpriteComps10097 == nil then
				arg_101_1.var_.actorSpriteComps10097 = var_104_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_16 = 2

			if var_104_15 <= arg_101_1.time_ and arg_101_1.time_ < var_104_15 + var_104_16 and not isNil(var_104_14) then
				local var_104_17 = (arg_101_1.time_ - var_104_15) / var_104_16

				if arg_101_1.var_.actorSpriteComps10097 then
					for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_104_3 then
							if arg_101_1.isInRecall_ then
								local var_104_18 = Mathf.Lerp(iter_104_3.color.r, arg_101_1.hightColor1.r, var_104_17)
								local var_104_19 = Mathf.Lerp(iter_104_3.color.g, arg_101_1.hightColor1.g, var_104_17)
								local var_104_20 = Mathf.Lerp(iter_104_3.color.b, arg_101_1.hightColor1.b, var_104_17)

								iter_104_3.color = Color.New(var_104_18, var_104_19, var_104_20)
							else
								local var_104_21 = Mathf.Lerp(iter_104_3.color.r, 1, var_104_17)

								iter_104_3.color = Color.New(var_104_21, var_104_21, var_104_21)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_15 + var_104_16 and arg_101_1.time_ < var_104_15 + var_104_16 + arg_104_0 and not isNil(var_104_14) and arg_101_1.var_.actorSpriteComps10097 then
				for iter_104_4, iter_104_5 in pairs(arg_101_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_104_5 then
						if arg_101_1.isInRecall_ then
							iter_104_5.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_104_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10097 = nil
			end

			local var_104_22 = arg_101_1.actors_["10094"]
			local var_104_23 = 0

			if var_104_23 < arg_101_1.time_ and arg_101_1.time_ <= var_104_23 + arg_104_0 and not isNil(var_104_22) and arg_101_1.var_.actorSpriteComps10094 == nil then
				arg_101_1.var_.actorSpriteComps10094 = var_104_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_24 = 2

			if var_104_23 <= arg_101_1.time_ and arg_101_1.time_ < var_104_23 + var_104_24 and not isNil(var_104_22) then
				local var_104_25 = (arg_101_1.time_ - var_104_23) / var_104_24

				if arg_101_1.var_.actorSpriteComps10094 then
					for iter_104_6, iter_104_7 in pairs(arg_101_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_104_7 then
							if arg_101_1.isInRecall_ then
								local var_104_26 = Mathf.Lerp(iter_104_7.color.r, arg_101_1.hightColor2.r, var_104_25)
								local var_104_27 = Mathf.Lerp(iter_104_7.color.g, arg_101_1.hightColor2.g, var_104_25)
								local var_104_28 = Mathf.Lerp(iter_104_7.color.b, arg_101_1.hightColor2.b, var_104_25)

								iter_104_7.color = Color.New(var_104_26, var_104_27, var_104_28)
							else
								local var_104_29 = Mathf.Lerp(iter_104_7.color.r, 0.5, var_104_25)

								iter_104_7.color = Color.New(var_104_29, var_104_29, var_104_29)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= var_104_23 + var_104_24 and arg_101_1.time_ < var_104_23 + var_104_24 + arg_104_0 and not isNil(var_104_22) and arg_101_1.var_.actorSpriteComps10094 then
				for iter_104_8, iter_104_9 in pairs(arg_101_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_104_9 then
						if arg_101_1.isInRecall_ then
							iter_104_9.color = arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_104_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_101_1.var_.actorSpriteComps10094 = nil
			end

			local var_104_30 = 0
			local var_104_31 = 0.45

			if var_104_30 < arg_101_1.time_ and arg_101_1.time_ <= var_104_30 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_32 = arg_101_1:FormatText(StoryNameCfg[1001].name)

				arg_101_1.leftNameTxt_.text = var_104_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_33 = arg_101_1:GetWordFromCfg(413022024)
				local var_104_34 = arg_101_1:FormatText(var_104_33.content)

				arg_101_1.text_.text = var_104_34

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_35 = 18
				local var_104_36 = utf8.len(var_104_34)
				local var_104_37 = var_104_35 <= 0 and var_104_31 or var_104_31 * (var_104_36 / var_104_35)

				if var_104_37 > 0 and var_104_31 < var_104_37 then
					arg_101_1.talkMaxDuration = var_104_37

					if var_104_37 + var_104_30 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_37 + var_104_30
					end
				end

				arg_101_1.text_.text = var_104_34
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022024", "story_v_out_413022.awb") ~= 0 then
					local var_104_38 = manager.audio:GetVoiceLength("story_v_out_413022", "413022024", "story_v_out_413022.awb") / 1000

					if var_104_38 + var_104_30 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_38 + var_104_30
					end

					if var_104_33.prefab_name ~= "" and arg_101_1.actors_[var_104_33.prefab_name] ~= nil then
						local var_104_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_33.prefab_name].transform, "story_v_out_413022", "413022024", "story_v_out_413022.awb")

						arg_101_1:RecordAudio("413022024", var_104_39)
						arg_101_1:RecordAudio("413022024", var_104_39)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_413022", "413022024", "story_v_out_413022.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_413022", "413022024", "story_v_out_413022.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_40 = math.max(var_104_31, arg_101_1.talkMaxDuration)

			if var_104_30 <= arg_101_1.time_ and arg_101_1.time_ < var_104_30 + var_104_40 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_30) / var_104_40

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_30 + var_104_40 and arg_101_1.time_ < var_104_30 + var_104_40 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_101_1:InitPlayNodeList()
	end,
	Play413022025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 413022025
		arg_105_1.duration_ = 9

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play413022026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 2

			if var_108_0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_0 + arg_108_0 then
				local var_108_1 = manager.ui.mainCamera.transform.localPosition
				local var_108_2 = Vector3.New(0, 0, 10) + Vector3.New(var_108_1.x, var_108_1.y, 0)
				local var_108_3 = arg_105_1.bgs_.F08h

				var_108_3.transform.localPosition = var_108_2
				var_108_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_108_4 = var_108_3:GetComponent("SpriteRenderer")

				if var_108_4 and var_108_4.sprite then
					local var_108_5 = (var_108_3.transform.localPosition - var_108_1).z
					local var_108_6 = manager.ui.mainCameraCom_
					local var_108_7 = 2 * var_108_5 * Mathf.Tan(var_108_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_108_8 = var_108_7 * var_108_6.aspect
					local var_108_9 = var_108_4.sprite.bounds.size.x
					local var_108_10 = var_108_4.sprite.bounds.size.y
					local var_108_11 = var_108_8 / var_108_9
					local var_108_12 = var_108_7 / var_108_10
					local var_108_13 = var_108_12 < var_108_11 and var_108_11 or var_108_12

					var_108_3.transform.localScale = Vector3.New(var_108_13, var_108_13, 0)
				end

				for iter_108_0, iter_108_1 in pairs(arg_105_1.bgs_) do
					if iter_108_0 ~= "F08h" then
						iter_108_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_108_14 = 3.999999999999

			if var_108_14 < arg_105_1.time_ and arg_105_1.time_ <= var_108_14 + arg_108_0 then
				arg_105_1.allBtn_.enabled = false
			end

			local var_108_15 = 0.3

			if arg_105_1.time_ >= var_108_14 + var_108_15 and arg_105_1.time_ < var_108_14 + var_108_15 + arg_108_0 then
				arg_105_1.allBtn_.enabled = true
			end

			local var_108_16 = 0

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_17 = 2

			if var_108_16 <= arg_105_1.time_ and arg_105_1.time_ < var_108_16 + var_108_17 then
				local var_108_18 = (arg_105_1.time_ - var_108_16) / var_108_17
				local var_108_19 = Color.New(0, 0, 0)

				var_108_19.a = Mathf.Lerp(0, 1, var_108_18)
				arg_105_1.mask_.color = var_108_19
			end

			if arg_105_1.time_ >= var_108_16 + var_108_17 and arg_105_1.time_ < var_108_16 + var_108_17 + arg_108_0 then
				local var_108_20 = Color.New(0, 0, 0)

				var_108_20.a = 1
				arg_105_1.mask_.color = var_108_20
			end

			local var_108_21 = 1.999999999999

			if var_108_21 < arg_105_1.time_ and arg_105_1.time_ <= var_108_21 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_22 = 2

			if var_108_21 <= arg_105_1.time_ and arg_105_1.time_ < var_108_21 + var_108_22 then
				local var_108_23 = (arg_105_1.time_ - var_108_21) / var_108_22
				local var_108_24 = Color.New(0, 0, 0)

				var_108_24.a = Mathf.Lerp(1, 0, var_108_23)
				arg_105_1.mask_.color = var_108_24
			end

			if arg_105_1.time_ >= var_108_21 + var_108_22 and arg_105_1.time_ < var_108_21 + var_108_22 + arg_108_0 then
				local var_108_25 = Color.New(0, 0, 0)
				local var_108_26 = 0

				arg_105_1.mask_.enabled = false
				var_108_25.a = var_108_26
				arg_105_1.mask_.color = var_108_25
			end

			local var_108_27 = arg_105_1.actors_["10097"].transform
			local var_108_28 = 1.966

			if var_108_28 < arg_105_1.time_ and arg_105_1.time_ <= var_108_28 + arg_108_0 then
				arg_105_1.var_.moveOldPos10097 = var_108_27.localPosition
				var_108_27.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10097", 0)

				local var_108_29 = var_108_27.childCount

				for iter_108_2 = 0, var_108_29 - 1 do
					local var_108_30 = var_108_27:GetChild(iter_108_2)

					if var_108_30.name == "" or not string.find(var_108_30.name, "split") then
						var_108_30.gameObject:SetActive(true)
					else
						var_108_30.gameObject:SetActive(false)
					end
				end
			end

			local var_108_31 = 0.001

			if var_108_28 <= arg_105_1.time_ and arg_105_1.time_ < var_108_28 + var_108_31 then
				local var_108_32 = (arg_105_1.time_ - var_108_28) / var_108_31
				local var_108_33 = Vector3.New(-1500, -350, -180)

				var_108_27.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10097, var_108_33, var_108_32)
			end

			if arg_105_1.time_ >= var_108_28 + var_108_31 and arg_105_1.time_ < var_108_28 + var_108_31 + arg_108_0 then
				var_108_27.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_108_34 = arg_105_1.actors_["10094"].transform
			local var_108_35 = 1.966

			if var_108_35 < arg_105_1.time_ and arg_105_1.time_ <= var_108_35 + arg_108_0 then
				arg_105_1.var_.moveOldPos10094 = var_108_34.localPosition
				var_108_34.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10094", 0)

				local var_108_36 = var_108_34.childCount

				for iter_108_3 = 0, var_108_36 - 1 do
					local var_108_37 = var_108_34:GetChild(iter_108_3)

					if var_108_37.name == "" or not string.find(var_108_37.name, "split") then
						var_108_37.gameObject:SetActive(true)
					else
						var_108_37.gameObject:SetActive(false)
					end
				end
			end

			local var_108_38 = 0.001

			if var_108_35 <= arg_105_1.time_ and arg_105_1.time_ < var_108_35 + var_108_38 then
				local var_108_39 = (arg_105_1.time_ - var_108_35) / var_108_38
				local var_108_40 = Vector3.New(-5000, -340, -414)

				var_108_34.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10094, var_108_40, var_108_39)
			end

			if arg_105_1.time_ >= var_108_35 + var_108_38 and arg_105_1.time_ < var_108_35 + var_108_38 + arg_108_0 then
				var_108_34.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_108_41 = arg_105_1.actors_["10097"]
			local var_108_42 = 1.966

			if var_108_42 < arg_105_1.time_ and arg_105_1.time_ <= var_108_42 + arg_108_0 and not isNil(var_108_41) and arg_105_1.var_.actorSpriteComps10097 == nil then
				arg_105_1.var_.actorSpriteComps10097 = var_108_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_43 = 0.034

			if var_108_42 <= arg_105_1.time_ and arg_105_1.time_ < var_108_42 + var_108_43 and not isNil(var_108_41) then
				local var_108_44 = (arg_105_1.time_ - var_108_42) / var_108_43

				if arg_105_1.var_.actorSpriteComps10097 then
					for iter_108_4, iter_108_5 in pairs(arg_105_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_108_5 then
							if arg_105_1.isInRecall_ then
								local var_108_45 = Mathf.Lerp(iter_108_5.color.r, arg_105_1.hightColor2.r, var_108_44)
								local var_108_46 = Mathf.Lerp(iter_108_5.color.g, arg_105_1.hightColor2.g, var_108_44)
								local var_108_47 = Mathf.Lerp(iter_108_5.color.b, arg_105_1.hightColor2.b, var_108_44)

								iter_108_5.color = Color.New(var_108_45, var_108_46, var_108_47)
							else
								local var_108_48 = Mathf.Lerp(iter_108_5.color.r, 0.5, var_108_44)

								iter_108_5.color = Color.New(var_108_48, var_108_48, var_108_48)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_42 + var_108_43 and arg_105_1.time_ < var_108_42 + var_108_43 + arg_108_0 and not isNil(var_108_41) and arg_105_1.var_.actorSpriteComps10097 then
				for iter_108_6, iter_108_7 in pairs(arg_105_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_108_7 then
						if arg_105_1.isInRecall_ then
							iter_108_7.color = arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_108_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10097 = nil
			end

			local var_108_49 = arg_105_1.actors_["10094"]
			local var_108_50 = 1.966

			if var_108_50 < arg_105_1.time_ and arg_105_1.time_ <= var_108_50 + arg_108_0 and not isNil(var_108_49) and arg_105_1.var_.actorSpriteComps10094 == nil then
				arg_105_1.var_.actorSpriteComps10094 = var_108_49:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_51 = 0.034

			if var_108_50 <= arg_105_1.time_ and arg_105_1.time_ < var_108_50 + var_108_51 and not isNil(var_108_49) then
				local var_108_52 = (arg_105_1.time_ - var_108_50) / var_108_51

				if arg_105_1.var_.actorSpriteComps10094 then
					for iter_108_8, iter_108_9 in pairs(arg_105_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_108_9 then
							if arg_105_1.isInRecall_ then
								local var_108_53 = Mathf.Lerp(iter_108_9.color.r, arg_105_1.hightColor2.r, var_108_52)
								local var_108_54 = Mathf.Lerp(iter_108_9.color.g, arg_105_1.hightColor2.g, var_108_52)
								local var_108_55 = Mathf.Lerp(iter_108_9.color.b, arg_105_1.hightColor2.b, var_108_52)

								iter_108_9.color = Color.New(var_108_53, var_108_54, var_108_55)
							else
								local var_108_56 = Mathf.Lerp(iter_108_9.color.r, 0.5, var_108_52)

								iter_108_9.color = Color.New(var_108_56, var_108_56, var_108_56)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= var_108_50 + var_108_51 and arg_105_1.time_ < var_108_50 + var_108_51 + arg_108_0 and not isNil(var_108_49) and arg_105_1.var_.actorSpriteComps10094 then
				for iter_108_10, iter_108_11 in pairs(arg_105_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_108_11 then
						if arg_105_1.isInRecall_ then
							iter_108_11.color = arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_108_11.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_105_1.var_.actorSpriteComps10094 = nil
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_57 = 4
			local var_108_58 = 1.425

			if var_108_57 < arg_105_1.time_ and arg_105_1.time_ <= var_108_57 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_59 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_59:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_59:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_59:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_60 = arg_105_1:GetWordFromCfg(413022025)
				local var_108_61 = arg_105_1:FormatText(var_108_60.content)

				arg_105_1.text_.text = var_108_61

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_62 = 57
				local var_108_63 = utf8.len(var_108_61)
				local var_108_64 = var_108_62 <= 0 and var_108_58 or var_108_58 * (var_108_63 / var_108_62)

				if var_108_64 > 0 and var_108_58 < var_108_64 then
					arg_105_1.talkMaxDuration = var_108_64
					var_108_57 = var_108_57 + 0.3

					if var_108_64 + var_108_57 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_64 + var_108_57
					end
				end

				arg_105_1.text_.text = var_108_61
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_65 = var_108_57 + 0.3
			local var_108_66 = math.max(var_108_58, arg_105_1.talkMaxDuration)

			if var_108_65 <= arg_105_1.time_ and arg_105_1.time_ < var_108_65 + var_108_66 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_65) / var_108_66

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_65 + var_108_66 and arg_105_1.time_ < var_108_65 + var_108_66 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play413022026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 413022026
		arg_111_1.duration_ = 17

		local var_111_0 = {
			zh = 12.066,
			ja = 17
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play413022027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = "10096"

			if arg_111_1.actors_[var_114_0] == nil then
				local var_114_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10096")

				if not isNil(var_114_1) then
					local var_114_2 = Object.Instantiate(var_114_1, arg_111_1.canvasGo_.transform)

					var_114_2.transform:SetSiblingIndex(1)

					var_114_2.name = var_114_0
					var_114_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_111_1.actors_[var_114_0] = var_114_2

					local var_114_3 = var_114_2:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_111_1.isInRecall_ then
						for iter_114_0, iter_114_1 in ipairs(var_114_3) do
							iter_114_1.color = arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_114_4 = arg_111_1.actors_["10096"].transform
			local var_114_5 = 0

			if var_114_5 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 then
				arg_111_1.var_.moveOldPos10096 = var_114_4.localPosition
				var_114_4.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("10096", 3)

				local var_114_6 = var_114_4.childCount

				for iter_114_2 = 0, var_114_6 - 1 do
					local var_114_7 = var_114_4:GetChild(iter_114_2)

					if var_114_7.name == "" or not string.find(var_114_7.name, "split") then
						var_114_7.gameObject:SetActive(true)
					else
						var_114_7.gameObject:SetActive(false)
					end
				end
			end

			local var_114_8 = 0.001

			if var_114_5 <= arg_111_1.time_ and arg_111_1.time_ < var_114_5 + var_114_8 then
				local var_114_9 = (arg_111_1.time_ - var_114_5) / var_114_8
				local var_114_10 = Vector3.New(0, -350, -210)

				var_114_4.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10096, var_114_10, var_114_9)
			end

			if arg_111_1.time_ >= var_114_5 + var_114_8 and arg_111_1.time_ < var_114_5 + var_114_8 + arg_114_0 then
				var_114_4.localPosition = Vector3.New(0, -350, -210)
			end

			local var_114_11 = arg_111_1.actors_["10096"]
			local var_114_12 = 0

			if var_114_12 < arg_111_1.time_ and arg_111_1.time_ <= var_114_12 + arg_114_0 and not isNil(var_114_11) and arg_111_1.var_.actorSpriteComps10096 == nil then
				arg_111_1.var_.actorSpriteComps10096 = var_114_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_13 = 2

			if var_114_12 <= arg_111_1.time_ and arg_111_1.time_ < var_114_12 + var_114_13 and not isNil(var_114_11) then
				local var_114_14 = (arg_111_1.time_ - var_114_12) / var_114_13

				if arg_111_1.var_.actorSpriteComps10096 then
					for iter_114_3, iter_114_4 in pairs(arg_111_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_114_4 then
							if arg_111_1.isInRecall_ then
								local var_114_15 = Mathf.Lerp(iter_114_4.color.r, arg_111_1.hightColor1.r, var_114_14)
								local var_114_16 = Mathf.Lerp(iter_114_4.color.g, arg_111_1.hightColor1.g, var_114_14)
								local var_114_17 = Mathf.Lerp(iter_114_4.color.b, arg_111_1.hightColor1.b, var_114_14)

								iter_114_4.color = Color.New(var_114_15, var_114_16, var_114_17)
							else
								local var_114_18 = Mathf.Lerp(iter_114_4.color.r, 1, var_114_14)

								iter_114_4.color = Color.New(var_114_18, var_114_18, var_114_18)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= var_114_12 + var_114_13 and arg_111_1.time_ < var_114_12 + var_114_13 + arg_114_0 and not isNil(var_114_11) and arg_111_1.var_.actorSpriteComps10096 then
				for iter_114_5, iter_114_6 in pairs(arg_111_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_114_6 then
						if arg_111_1.isInRecall_ then
							iter_114_6.color = arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_114_6.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_111_1.var_.actorSpriteComps10096 = nil
			end

			local var_114_19 = arg_111_1.actors_["10096"]
			local var_114_20 = 0

			if var_114_20 < arg_111_1.time_ and arg_111_1.time_ <= var_114_20 + arg_114_0 then
				local var_114_21 = var_114_19:GetComponentInChildren(typeof(CanvasGroup))

				if var_114_21 then
					arg_111_1.var_.alphaOldValue10096 = var_114_21.alpha
					arg_111_1.var_.characterEffect10096 = var_114_21
				end

				arg_111_1.var_.alphaOldValue10096 = 0
			end

			local var_114_22 = 0.2

			if var_114_20 <= arg_111_1.time_ and arg_111_1.time_ < var_114_20 + var_114_22 then
				local var_114_23 = (arg_111_1.time_ - var_114_20) / var_114_22
				local var_114_24 = Mathf.Lerp(arg_111_1.var_.alphaOldValue10096, 1, var_114_23)

				if arg_111_1.var_.characterEffect10096 then
					arg_111_1.var_.characterEffect10096.alpha = var_114_24
				end
			end

			if arg_111_1.time_ >= var_114_20 + var_114_22 and arg_111_1.time_ < var_114_20 + var_114_22 + arg_114_0 and arg_111_1.var_.characterEffect10096 then
				arg_111_1.var_.characterEffect10096.alpha = 1
			end

			local var_114_25 = 0
			local var_114_26 = 0.675

			if var_114_25 < arg_111_1.time_ and arg_111_1.time_ <= var_114_25 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_27 = arg_111_1:FormatText(StoryNameCfg[36].name)

				arg_111_1.leftNameTxt_.text = var_114_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_28 = arg_111_1:GetWordFromCfg(413022026)
				local var_114_29 = arg_111_1:FormatText(var_114_28.content)

				arg_111_1.text_.text = var_114_29

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_30 = 27
				local var_114_31 = utf8.len(var_114_29)
				local var_114_32 = var_114_30 <= 0 and var_114_26 or var_114_26 * (var_114_31 / var_114_30)

				if var_114_32 > 0 and var_114_26 < var_114_32 then
					arg_111_1.talkMaxDuration = var_114_32

					if var_114_32 + var_114_25 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_32 + var_114_25
					end
				end

				arg_111_1.text_.text = var_114_29
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022026", "story_v_out_413022.awb") ~= 0 then
					local var_114_33 = manager.audio:GetVoiceLength("story_v_out_413022", "413022026", "story_v_out_413022.awb") / 1000

					if var_114_33 + var_114_25 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_33 + var_114_25
					end

					if var_114_28.prefab_name ~= "" and arg_111_1.actors_[var_114_28.prefab_name] ~= nil then
						local var_114_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_28.prefab_name].transform, "story_v_out_413022", "413022026", "story_v_out_413022.awb")

						arg_111_1:RecordAudio("413022026", var_114_34)
						arg_111_1:RecordAudio("413022026", var_114_34)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_413022", "413022026", "story_v_out_413022.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_413022", "413022026", "story_v_out_413022.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_35 = math.max(var_114_26, arg_111_1.talkMaxDuration)

			if var_114_25 <= arg_111_1.time_ and arg_111_1.time_ < var_114_25 + var_114_35 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_25) / var_114_35

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_25 + var_114_35 and arg_111_1.time_ < var_114_25 + var_114_35 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play413022027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 413022027
		arg_115_1.duration_ = 6.63

		local var_115_0 = {
			zh = 5.2,
			ja = 6.633
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
				arg_115_0:Play413022028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0
			local var_118_1 = 0.425

			if var_118_0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_2 = arg_115_1:FormatText(StoryNameCfg[36].name)

				arg_115_1.leftNameTxt_.text = var_118_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_3 = arg_115_1:GetWordFromCfg(413022027)
				local var_118_4 = arg_115_1:FormatText(var_118_3.content)

				arg_115_1.text_.text = var_118_4

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 17
				local var_118_6 = utf8.len(var_118_4)
				local var_118_7 = var_118_5 <= 0 and var_118_1 or var_118_1 * (var_118_6 / var_118_5)

				if var_118_7 > 0 and var_118_1 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_4
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022027", "story_v_out_413022.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_413022", "413022027", "story_v_out_413022.awb") / 1000

					if var_118_8 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_0
					end

					if var_118_3.prefab_name ~= "" and arg_115_1.actors_[var_118_3.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_3.prefab_name].transform, "story_v_out_413022", "413022027", "story_v_out_413022.awb")

						arg_115_1:RecordAudio("413022027", var_118_9)
						arg_115_1:RecordAudio("413022027", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_413022", "413022027", "story_v_out_413022.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_413022", "413022027", "story_v_out_413022.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_10 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_10 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_10

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_10 and arg_115_1.time_ < var_118_0 + var_118_10 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play413022028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 413022028
		arg_119_1.duration_ = 7

		local var_119_0 = {
			zh = 3.866,
			ja = 7
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play413022029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10096"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos10096 = var_122_0.localPosition
				var_122_0.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10096", 4)

				local var_122_2 = var_122_0.childCount

				for iter_122_0 = 0, var_122_2 - 1 do
					local var_122_3 = var_122_0:GetChild(iter_122_0)

					if var_122_3.name == "" or not string.find(var_122_3.name, "split") then
						var_122_3.gameObject:SetActive(true)
					else
						var_122_3.gameObject:SetActive(false)
					end
				end
			end

			local var_122_4 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_4 then
				local var_122_5 = (arg_119_1.time_ - var_122_1) / var_122_4
				local var_122_6 = Vector3.New(390, -350, -210)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10096, var_122_6, var_122_5)
			end

			if arg_119_1.time_ >= var_122_1 + var_122_4 and arg_119_1.time_ < var_122_1 + var_122_4 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(390, -350, -210)
			end

			local var_122_7 = "10095"

			if arg_119_1.actors_[var_122_7] == nil then
				local var_122_8 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10095")

				if not isNil(var_122_8) then
					local var_122_9 = Object.Instantiate(var_122_8, arg_119_1.canvasGo_.transform)

					var_122_9.transform:SetSiblingIndex(1)

					var_122_9.name = var_122_7
					var_122_9.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_119_1.actors_[var_122_7] = var_122_9

					local var_122_10 = var_122_9:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_119_1.isInRecall_ then
						for iter_122_1, iter_122_2 in ipairs(var_122_10) do
							iter_122_2.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_122_11 = arg_119_1.actors_["10095"].transform
			local var_122_12 = 0

			if var_122_12 < arg_119_1.time_ and arg_119_1.time_ <= var_122_12 + arg_122_0 then
				arg_119_1.var_.moveOldPos10095 = var_122_11.localPosition
				var_122_11.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10095", 2)

				local var_122_13 = var_122_11.childCount

				for iter_122_3 = 0, var_122_13 - 1 do
					local var_122_14 = var_122_11:GetChild(iter_122_3)

					if var_122_14.name == "split_1_1" or not string.find(var_122_14.name, "split") then
						var_122_14.gameObject:SetActive(true)
					else
						var_122_14.gameObject:SetActive(false)
					end
				end
			end

			local var_122_15 = 0.001

			if var_122_12 <= arg_119_1.time_ and arg_119_1.time_ < var_122_12 + var_122_15 then
				local var_122_16 = (arg_119_1.time_ - var_122_12) / var_122_15
				local var_122_17 = Vector3.New(-390, -405, -10)

				var_122_11.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10095, var_122_17, var_122_16)
			end

			if arg_119_1.time_ >= var_122_12 + var_122_15 and arg_119_1.time_ < var_122_12 + var_122_15 + arg_122_0 then
				var_122_11.localPosition = Vector3.New(-390, -405, -10)
			end

			local var_122_18 = arg_119_1.actors_["10096"]
			local var_122_19 = 0

			if var_122_19 < arg_119_1.time_ and arg_119_1.time_ <= var_122_19 + arg_122_0 and not isNil(var_122_18) and arg_119_1.var_.actorSpriteComps10096 == nil then
				arg_119_1.var_.actorSpriteComps10096 = var_122_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_20 = 2

			if var_122_19 <= arg_119_1.time_ and arg_119_1.time_ < var_122_19 + var_122_20 and not isNil(var_122_18) then
				local var_122_21 = (arg_119_1.time_ - var_122_19) / var_122_20

				if arg_119_1.var_.actorSpriteComps10096 then
					for iter_122_4, iter_122_5 in pairs(arg_119_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_122_5 then
							if arg_119_1.isInRecall_ then
								local var_122_22 = Mathf.Lerp(iter_122_5.color.r, arg_119_1.hightColor2.r, var_122_21)
								local var_122_23 = Mathf.Lerp(iter_122_5.color.g, arg_119_1.hightColor2.g, var_122_21)
								local var_122_24 = Mathf.Lerp(iter_122_5.color.b, arg_119_1.hightColor2.b, var_122_21)

								iter_122_5.color = Color.New(var_122_22, var_122_23, var_122_24)
							else
								local var_122_25 = Mathf.Lerp(iter_122_5.color.r, 0.5, var_122_21)

								iter_122_5.color = Color.New(var_122_25, var_122_25, var_122_25)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_19 + var_122_20 and arg_119_1.time_ < var_122_19 + var_122_20 + arg_122_0 and not isNil(var_122_18) and arg_119_1.var_.actorSpriteComps10096 then
				for iter_122_6, iter_122_7 in pairs(arg_119_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_122_7 then
						if arg_119_1.isInRecall_ then
							iter_122_7.color = arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_122_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps10096 = nil
			end

			local var_122_26 = arg_119_1.actors_["10095"]
			local var_122_27 = 0

			if var_122_27 < arg_119_1.time_ and arg_119_1.time_ <= var_122_27 + arg_122_0 and not isNil(var_122_26) and arg_119_1.var_.actorSpriteComps10095 == nil then
				arg_119_1.var_.actorSpriteComps10095 = var_122_26:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_28 = 2

			if var_122_27 <= arg_119_1.time_ and arg_119_1.time_ < var_122_27 + var_122_28 and not isNil(var_122_26) then
				local var_122_29 = (arg_119_1.time_ - var_122_27) / var_122_28

				if arg_119_1.var_.actorSpriteComps10095 then
					for iter_122_8, iter_122_9 in pairs(arg_119_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_122_9 then
							if arg_119_1.isInRecall_ then
								local var_122_30 = Mathf.Lerp(iter_122_9.color.r, arg_119_1.hightColor1.r, var_122_29)
								local var_122_31 = Mathf.Lerp(iter_122_9.color.g, arg_119_1.hightColor1.g, var_122_29)
								local var_122_32 = Mathf.Lerp(iter_122_9.color.b, arg_119_1.hightColor1.b, var_122_29)

								iter_122_9.color = Color.New(var_122_30, var_122_31, var_122_32)
							else
								local var_122_33 = Mathf.Lerp(iter_122_9.color.r, 1, var_122_29)

								iter_122_9.color = Color.New(var_122_33, var_122_33, var_122_33)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= var_122_27 + var_122_28 and arg_119_1.time_ < var_122_27 + var_122_28 + arg_122_0 and not isNil(var_122_26) and arg_119_1.var_.actorSpriteComps10095 then
				for iter_122_10, iter_122_11 in pairs(arg_119_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_122_11 then
						if arg_119_1.isInRecall_ then
							iter_122_11.color = arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_122_11.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_119_1.var_.actorSpriteComps10095 = nil
			end

			local var_122_34 = arg_119_1.actors_["10095"]
			local var_122_35 = 0

			if var_122_35 < arg_119_1.time_ and arg_119_1.time_ <= var_122_35 + arg_122_0 then
				local var_122_36 = var_122_34:GetComponentInChildren(typeof(CanvasGroup))

				if var_122_36 then
					arg_119_1.var_.alphaOldValue10095 = var_122_36.alpha
					arg_119_1.var_.characterEffect10095 = var_122_36
				end

				arg_119_1.var_.alphaOldValue10095 = 0
			end

			local var_122_37 = 0.2

			if var_122_35 <= arg_119_1.time_ and arg_119_1.time_ < var_122_35 + var_122_37 then
				local var_122_38 = (arg_119_1.time_ - var_122_35) / var_122_37
				local var_122_39 = Mathf.Lerp(arg_119_1.var_.alphaOldValue10095, 1, var_122_38)

				if arg_119_1.var_.characterEffect10095 then
					arg_119_1.var_.characterEffect10095.alpha = var_122_39
				end
			end

			if arg_119_1.time_ >= var_122_35 + var_122_37 and arg_119_1.time_ < var_122_35 + var_122_37 + arg_122_0 and arg_119_1.var_.characterEffect10095 then
				arg_119_1.var_.characterEffect10095.alpha = 1
			end

			local var_122_40 = 0
			local var_122_41 = 0.275

			if var_122_40 < arg_119_1.time_ and arg_119_1.time_ <= var_122_40 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_42 = arg_119_1:FormatText(StoryNameCfg[1002].name)

				arg_119_1.leftNameTxt_.text = var_122_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_43 = arg_119_1:GetWordFromCfg(413022028)
				local var_122_44 = arg_119_1:FormatText(var_122_43.content)

				arg_119_1.text_.text = var_122_44

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_45 = 11
				local var_122_46 = utf8.len(var_122_44)
				local var_122_47 = var_122_45 <= 0 and var_122_41 or var_122_41 * (var_122_46 / var_122_45)

				if var_122_47 > 0 and var_122_41 < var_122_47 then
					arg_119_1.talkMaxDuration = var_122_47

					if var_122_47 + var_122_40 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_47 + var_122_40
					end
				end

				arg_119_1.text_.text = var_122_44
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022028", "story_v_out_413022.awb") ~= 0 then
					local var_122_48 = manager.audio:GetVoiceLength("story_v_out_413022", "413022028", "story_v_out_413022.awb") / 1000

					if var_122_48 + var_122_40 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_48 + var_122_40
					end

					if var_122_43.prefab_name ~= "" and arg_119_1.actors_[var_122_43.prefab_name] ~= nil then
						local var_122_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_43.prefab_name].transform, "story_v_out_413022", "413022028", "story_v_out_413022.awb")

						arg_119_1:RecordAudio("413022028", var_122_49)
						arg_119_1:RecordAudio("413022028", var_122_49)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_413022", "413022028", "story_v_out_413022.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_413022", "413022028", "story_v_out_413022.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_50 = math.max(var_122_41, arg_119_1.talkMaxDuration)

			if var_122_40 <= arg_119_1.time_ and arg_119_1.time_ < var_122_40 + var_122_50 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_40) / var_122_50

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_40 + var_122_50 and arg_119_1.time_ < var_122_40 + var_122_50 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play413022029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 413022029
		arg_123_1.duration_ = 5.77

		local var_123_0 = {
			zh = 5,
			ja = 5.766
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play413022030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.375

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[1002].name)

				arg_123_1.leftNameTxt_.text = var_126_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:GetWordFromCfg(413022029)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 15
				local var_126_6 = utf8.len(var_126_4)
				local var_126_7 = var_126_5 <= 0 and var_126_1 or var_126_1 * (var_126_6 / var_126_5)

				if var_126_7 > 0 and var_126_1 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022029", "story_v_out_413022.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_413022", "413022029", "story_v_out_413022.awb") / 1000

					if var_126_8 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_0
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_413022", "413022029", "story_v_out_413022.awb")

						arg_123_1:RecordAudio("413022029", var_126_9)
						arg_123_1:RecordAudio("413022029", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_413022", "413022029", "story_v_out_413022.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_413022", "413022029", "story_v_out_413022.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_10 and arg_123_1.time_ < var_126_0 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play413022030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 413022030
		arg_127_1.duration_ = 12.67

		local var_127_0 = {
			zh = 6.733,
			ja = 12.666
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
				arg_127_0:Play413022031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10096"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps10096 == nil then
				arg_127_1.var_.actorSpriteComps10096 = var_130_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_2 = 2

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.actorSpriteComps10096 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_130_1 then
							if arg_127_1.isInRecall_ then
								local var_130_4 = Mathf.Lerp(iter_130_1.color.r, arg_127_1.hightColor1.r, var_130_3)
								local var_130_5 = Mathf.Lerp(iter_130_1.color.g, arg_127_1.hightColor1.g, var_130_3)
								local var_130_6 = Mathf.Lerp(iter_130_1.color.b, arg_127_1.hightColor1.b, var_130_3)

								iter_130_1.color = Color.New(var_130_4, var_130_5, var_130_6)
							else
								local var_130_7 = Mathf.Lerp(iter_130_1.color.r, 1, var_130_3)

								iter_130_1.color = Color.New(var_130_7, var_130_7, var_130_7)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.actorSpriteComps10096 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_130_3 then
						if arg_127_1.isInRecall_ then
							iter_130_3.color = arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_130_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps10096 = nil
			end

			local var_130_8 = arg_127_1.actors_["10095"]
			local var_130_9 = 0

			if var_130_9 < arg_127_1.time_ and arg_127_1.time_ <= var_130_9 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps10095 == nil then
				arg_127_1.var_.actorSpriteComps10095 = var_130_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_10 = 2

			if var_130_9 <= arg_127_1.time_ and arg_127_1.time_ < var_130_9 + var_130_10 and not isNil(var_130_8) then
				local var_130_11 = (arg_127_1.time_ - var_130_9) / var_130_10

				if arg_127_1.var_.actorSpriteComps10095 then
					for iter_130_4, iter_130_5 in pairs(arg_127_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_130_5 then
							if arg_127_1.isInRecall_ then
								local var_130_12 = Mathf.Lerp(iter_130_5.color.r, arg_127_1.hightColor2.r, var_130_11)
								local var_130_13 = Mathf.Lerp(iter_130_5.color.g, arg_127_1.hightColor2.g, var_130_11)
								local var_130_14 = Mathf.Lerp(iter_130_5.color.b, arg_127_1.hightColor2.b, var_130_11)

								iter_130_5.color = Color.New(var_130_12, var_130_13, var_130_14)
							else
								local var_130_15 = Mathf.Lerp(iter_130_5.color.r, 0.5, var_130_11)

								iter_130_5.color = Color.New(var_130_15, var_130_15, var_130_15)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= var_130_9 + var_130_10 and arg_127_1.time_ < var_130_9 + var_130_10 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps10095 then
				for iter_130_6, iter_130_7 in pairs(arg_127_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_130_7 then
						if arg_127_1.isInRecall_ then
							iter_130_7.color = arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_130_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_127_1.var_.actorSpriteComps10095 = nil
			end

			local var_130_16 = 0
			local var_130_17 = 0.55

			if var_130_16 < arg_127_1.time_ and arg_127_1.time_ <= var_130_16 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_18 = arg_127_1:FormatText(StoryNameCfg[36].name)

				arg_127_1.leftNameTxt_.text = var_130_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_19 = arg_127_1:GetWordFromCfg(413022030)
				local var_130_20 = arg_127_1:FormatText(var_130_19.content)

				arg_127_1.text_.text = var_130_20

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_21 = 22
				local var_130_22 = utf8.len(var_130_20)
				local var_130_23 = var_130_21 <= 0 and var_130_17 or var_130_17 * (var_130_22 / var_130_21)

				if var_130_23 > 0 and var_130_17 < var_130_23 then
					arg_127_1.talkMaxDuration = var_130_23

					if var_130_23 + var_130_16 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_23 + var_130_16
					end
				end

				arg_127_1.text_.text = var_130_20
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022030", "story_v_out_413022.awb") ~= 0 then
					local var_130_24 = manager.audio:GetVoiceLength("story_v_out_413022", "413022030", "story_v_out_413022.awb") / 1000

					if var_130_24 + var_130_16 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_24 + var_130_16
					end

					if var_130_19.prefab_name ~= "" and arg_127_1.actors_[var_130_19.prefab_name] ~= nil then
						local var_130_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_19.prefab_name].transform, "story_v_out_413022", "413022030", "story_v_out_413022.awb")

						arg_127_1:RecordAudio("413022030", var_130_25)
						arg_127_1:RecordAudio("413022030", var_130_25)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_413022", "413022030", "story_v_out_413022.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_413022", "413022030", "story_v_out_413022.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_26 = math.max(var_130_17, arg_127_1.talkMaxDuration)

			if var_130_16 <= arg_127_1.time_ and arg_127_1.time_ < var_130_16 + var_130_26 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_16) / var_130_26

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_16 + var_130_26 and arg_127_1.time_ < var_130_16 + var_130_26 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play413022031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 413022031
		arg_131_1.duration_ = 7

		local var_131_0 = {
			zh = 4.733,
			ja = 7
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
				arg_131_0:Play413022032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.425

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[36].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_3 = arg_131_1:GetWordFromCfg(413022031)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022031", "story_v_out_413022.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_413022", "413022031", "story_v_out_413022.awb") / 1000

					if var_134_8 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_0
					end

					if var_134_3.prefab_name ~= "" and arg_131_1.actors_[var_134_3.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_3.prefab_name].transform, "story_v_out_413022", "413022031", "story_v_out_413022.awb")

						arg_131_1:RecordAudio("413022031", var_134_9)
						arg_131_1:RecordAudio("413022031", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_413022", "413022031", "story_v_out_413022.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_413022", "413022031", "story_v_out_413022.awb")
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
	Play413022032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 413022032
		arg_135_1.duration_ = 8.47

		local var_135_0 = {
			zh = 8.466,
			ja = 8.4
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
				arg_135_0:Play413022033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10095"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos10095 = var_138_0.localPosition
				var_138_0.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10095", 2)

				local var_138_2 = var_138_0.childCount

				for iter_138_0 = 0, var_138_2 - 1 do
					local var_138_3 = var_138_0:GetChild(iter_138_0)

					if var_138_3.name == "split_1_6" or not string.find(var_138_3.name, "split") then
						var_138_3.gameObject:SetActive(true)
					else
						var_138_3.gameObject:SetActive(false)
					end
				end
			end

			local var_138_4 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_4 then
				local var_138_5 = (arg_135_1.time_ - var_138_1) / var_138_4
				local var_138_6 = Vector3.New(-390, -405, -10)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10095, var_138_6, var_138_5)
			end

			if arg_135_1.time_ >= var_138_1 + var_138_4 and arg_135_1.time_ < var_138_1 + var_138_4 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(-390, -405, -10)
			end

			local var_138_7 = arg_135_1.actors_["10096"]
			local var_138_8 = 0

			if var_138_8 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.actorSpriteComps10096 == nil then
				arg_135_1.var_.actorSpriteComps10096 = var_138_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_9 = 2

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_9 and not isNil(var_138_7) then
				local var_138_10 = (arg_135_1.time_ - var_138_8) / var_138_9

				if arg_135_1.var_.actorSpriteComps10096 then
					for iter_138_1, iter_138_2 in pairs(arg_135_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_138_2 then
							if arg_135_1.isInRecall_ then
								local var_138_11 = Mathf.Lerp(iter_138_2.color.r, arg_135_1.hightColor2.r, var_138_10)
								local var_138_12 = Mathf.Lerp(iter_138_2.color.g, arg_135_1.hightColor2.g, var_138_10)
								local var_138_13 = Mathf.Lerp(iter_138_2.color.b, arg_135_1.hightColor2.b, var_138_10)

								iter_138_2.color = Color.New(var_138_11, var_138_12, var_138_13)
							else
								local var_138_14 = Mathf.Lerp(iter_138_2.color.r, 0.5, var_138_10)

								iter_138_2.color = Color.New(var_138_14, var_138_14, var_138_14)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_8 + var_138_9 and arg_135_1.time_ < var_138_8 + var_138_9 + arg_138_0 and not isNil(var_138_7) and arg_135_1.var_.actorSpriteComps10096 then
				for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_138_4 then
						if arg_135_1.isInRecall_ then
							iter_138_4.color = arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_138_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps10096 = nil
			end

			local var_138_15 = arg_135_1.actors_["10095"]
			local var_138_16 = 0

			if var_138_16 < arg_135_1.time_ and arg_135_1.time_ <= var_138_16 + arg_138_0 and not isNil(var_138_15) and arg_135_1.var_.actorSpriteComps10095 == nil then
				arg_135_1.var_.actorSpriteComps10095 = var_138_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_17 = 2

			if var_138_16 <= arg_135_1.time_ and arg_135_1.time_ < var_138_16 + var_138_17 and not isNil(var_138_15) then
				local var_138_18 = (arg_135_1.time_ - var_138_16) / var_138_17

				if arg_135_1.var_.actorSpriteComps10095 then
					for iter_138_5, iter_138_6 in pairs(arg_135_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_138_6 then
							if arg_135_1.isInRecall_ then
								local var_138_19 = Mathf.Lerp(iter_138_6.color.r, arg_135_1.hightColor1.r, var_138_18)
								local var_138_20 = Mathf.Lerp(iter_138_6.color.g, arg_135_1.hightColor1.g, var_138_18)
								local var_138_21 = Mathf.Lerp(iter_138_6.color.b, arg_135_1.hightColor1.b, var_138_18)

								iter_138_6.color = Color.New(var_138_19, var_138_20, var_138_21)
							else
								local var_138_22 = Mathf.Lerp(iter_138_6.color.r, 1, var_138_18)

								iter_138_6.color = Color.New(var_138_22, var_138_22, var_138_22)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= var_138_16 + var_138_17 and arg_135_1.time_ < var_138_16 + var_138_17 + arg_138_0 and not isNil(var_138_15) and arg_135_1.var_.actorSpriteComps10095 then
				for iter_138_7, iter_138_8 in pairs(arg_135_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_138_8 then
						if arg_135_1.isInRecall_ then
							iter_138_8.color = arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_138_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_135_1.var_.actorSpriteComps10095 = nil
			end

			local var_138_23 = 0
			local var_138_24 = 0.6

			if var_138_23 < arg_135_1.time_ and arg_135_1.time_ <= var_138_23 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_25 = arg_135_1:FormatText(StoryNameCfg[1002].name)

				arg_135_1.leftNameTxt_.text = var_138_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_26 = arg_135_1:GetWordFromCfg(413022032)
				local var_138_27 = arg_135_1:FormatText(var_138_26.content)

				arg_135_1.text_.text = var_138_27

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_28 = 24
				local var_138_29 = utf8.len(var_138_27)
				local var_138_30 = var_138_28 <= 0 and var_138_24 or var_138_24 * (var_138_29 / var_138_28)

				if var_138_30 > 0 and var_138_24 < var_138_30 then
					arg_135_1.talkMaxDuration = var_138_30

					if var_138_30 + var_138_23 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_30 + var_138_23
					end
				end

				arg_135_1.text_.text = var_138_27
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022032", "story_v_out_413022.awb") ~= 0 then
					local var_138_31 = manager.audio:GetVoiceLength("story_v_out_413022", "413022032", "story_v_out_413022.awb") / 1000

					if var_138_31 + var_138_23 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_31 + var_138_23
					end

					if var_138_26.prefab_name ~= "" and arg_135_1.actors_[var_138_26.prefab_name] ~= nil then
						local var_138_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_26.prefab_name].transform, "story_v_out_413022", "413022032", "story_v_out_413022.awb")

						arg_135_1:RecordAudio("413022032", var_138_32)
						arg_135_1:RecordAudio("413022032", var_138_32)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_413022", "413022032", "story_v_out_413022.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_413022", "413022032", "story_v_out_413022.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_33 = math.max(var_138_24, arg_135_1.talkMaxDuration)

			if var_138_23 <= arg_135_1.time_ and arg_135_1.time_ < var_138_23 + var_138_33 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_23) / var_138_33

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_23 + var_138_33 and arg_135_1.time_ < var_138_23 + var_138_33 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play413022033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 413022033
		arg_139_1.duration_ = 10.2

		local var_139_0 = {
			zh = 9.433,
			ja = 10.2
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
				arg_139_0:Play413022034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10096"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps10096 == nil then
				arg_139_1.var_.actorSpriteComps10096 = var_142_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_2 = 2

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.actorSpriteComps10096 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								local var_142_4 = Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor1.r, var_142_3)
								local var_142_5 = Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor1.g, var_142_3)
								local var_142_6 = Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor1.b, var_142_3)

								iter_142_1.color = Color.New(var_142_4, var_142_5, var_142_6)
							else
								local var_142_7 = Mathf.Lerp(iter_142_1.color.r, 1, var_142_3)

								iter_142_1.color = Color.New(var_142_7, var_142_7, var_142_7)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.actorSpriteComps10096 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_142_3 then
						if arg_139_1.isInRecall_ then
							iter_142_3.color = arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_142_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps10096 = nil
			end

			local var_142_8 = arg_139_1.actors_["10095"]
			local var_142_9 = 0

			if var_142_9 < arg_139_1.time_ and arg_139_1.time_ <= var_142_9 + arg_142_0 and not isNil(var_142_8) and arg_139_1.var_.actorSpriteComps10095 == nil then
				arg_139_1.var_.actorSpriteComps10095 = var_142_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_10 = 2

			if var_142_9 <= arg_139_1.time_ and arg_139_1.time_ < var_142_9 + var_142_10 and not isNil(var_142_8) then
				local var_142_11 = (arg_139_1.time_ - var_142_9) / var_142_10

				if arg_139_1.var_.actorSpriteComps10095 then
					for iter_142_4, iter_142_5 in pairs(arg_139_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_142_5 then
							if arg_139_1.isInRecall_ then
								local var_142_12 = Mathf.Lerp(iter_142_5.color.r, arg_139_1.hightColor2.r, var_142_11)
								local var_142_13 = Mathf.Lerp(iter_142_5.color.g, arg_139_1.hightColor2.g, var_142_11)
								local var_142_14 = Mathf.Lerp(iter_142_5.color.b, arg_139_1.hightColor2.b, var_142_11)

								iter_142_5.color = Color.New(var_142_12, var_142_13, var_142_14)
							else
								local var_142_15 = Mathf.Lerp(iter_142_5.color.r, 0.5, var_142_11)

								iter_142_5.color = Color.New(var_142_15, var_142_15, var_142_15)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= var_142_9 + var_142_10 and arg_139_1.time_ < var_142_9 + var_142_10 + arg_142_0 and not isNil(var_142_8) and arg_139_1.var_.actorSpriteComps10095 then
				for iter_142_6, iter_142_7 in pairs(arg_139_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_142_7 then
						if arg_139_1.isInRecall_ then
							iter_142_7.color = arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_142_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_139_1.var_.actorSpriteComps10095 = nil
			end

			local var_142_16 = 0
			local var_142_17 = 0.75

			if var_142_16 < arg_139_1.time_ and arg_139_1.time_ <= var_142_16 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_18 = arg_139_1:FormatText(StoryNameCfg[36].name)

				arg_139_1.leftNameTxt_.text = var_142_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_19 = arg_139_1:GetWordFromCfg(413022033)
				local var_142_20 = arg_139_1:FormatText(var_142_19.content)

				arg_139_1.text_.text = var_142_20

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_21 = 30
				local var_142_22 = utf8.len(var_142_20)
				local var_142_23 = var_142_21 <= 0 and var_142_17 or var_142_17 * (var_142_22 / var_142_21)

				if var_142_23 > 0 and var_142_17 < var_142_23 then
					arg_139_1.talkMaxDuration = var_142_23

					if var_142_23 + var_142_16 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_23 + var_142_16
					end
				end

				arg_139_1.text_.text = var_142_20
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022033", "story_v_out_413022.awb") ~= 0 then
					local var_142_24 = manager.audio:GetVoiceLength("story_v_out_413022", "413022033", "story_v_out_413022.awb") / 1000

					if var_142_24 + var_142_16 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_24 + var_142_16
					end

					if var_142_19.prefab_name ~= "" and arg_139_1.actors_[var_142_19.prefab_name] ~= nil then
						local var_142_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_19.prefab_name].transform, "story_v_out_413022", "413022033", "story_v_out_413022.awb")

						arg_139_1:RecordAudio("413022033", var_142_25)
						arg_139_1:RecordAudio("413022033", var_142_25)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_413022", "413022033", "story_v_out_413022.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_413022", "413022033", "story_v_out_413022.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_26 = math.max(var_142_17, arg_139_1.talkMaxDuration)

			if var_142_16 <= arg_139_1.time_ and arg_139_1.time_ < var_142_16 + var_142_26 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_16) / var_142_26

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_16 + var_142_26 and arg_139_1.time_ < var_142_16 + var_142_26 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play413022034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 413022034
		arg_143_1.duration_ = 11.3

		local var_143_0 = {
			zh = 5.333,
			ja = 11.3
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play413022035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.5

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[36].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_3 = arg_143_1:GetWordFromCfg(413022034)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 20
				local var_146_6 = utf8.len(var_146_4)
				local var_146_7 = var_146_5 <= 0 and var_146_1 or var_146_1 * (var_146_6 / var_146_5)

				if var_146_7 > 0 and var_146_1 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022034", "story_v_out_413022.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_413022", "413022034", "story_v_out_413022.awb") / 1000

					if var_146_8 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_0
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_413022", "413022034", "story_v_out_413022.awb")

						arg_143_1:RecordAudio("413022034", var_146_9)
						arg_143_1:RecordAudio("413022034", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_413022", "413022034", "story_v_out_413022.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_413022", "413022034", "story_v_out_413022.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_10 and arg_143_1.time_ < var_146_0 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play413022035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 413022035
		arg_147_1.duration_ = 8.2

		local var_147_0 = {
			zh = 4.9,
			ja = 8.2
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
				arg_147_0:Play413022036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.3

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[36].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:GetWordFromCfg(413022035)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022035", "story_v_out_413022.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_413022", "413022035", "story_v_out_413022.awb") / 1000

					if var_150_8 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_0
					end

					if var_150_3.prefab_name ~= "" and arg_147_1.actors_[var_150_3.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_3.prefab_name].transform, "story_v_out_413022", "413022035", "story_v_out_413022.awb")

						arg_147_1:RecordAudio("413022035", var_150_9)
						arg_147_1:RecordAudio("413022035", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_413022", "413022035", "story_v_out_413022.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_413022", "413022035", "story_v_out_413022.awb")
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
	Play413022036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 413022036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play413022037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10096"].transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.moveOldPos10096 = var_154_0.localPosition
				var_154_0.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("10096", 0)

				local var_154_2 = var_154_0.childCount

				for iter_154_0 = 0, var_154_2 - 1 do
					local var_154_3 = var_154_0:GetChild(iter_154_0)

					if var_154_3.name == "" or not string.find(var_154_3.name, "split") then
						var_154_3.gameObject:SetActive(true)
					else
						var_154_3.gameObject:SetActive(false)
					end
				end
			end

			local var_154_4 = 0.001

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_4 then
				local var_154_5 = (arg_151_1.time_ - var_154_1) / var_154_4
				local var_154_6 = Vector3.New(-1500, -350, -180)

				var_154_0.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10096, var_154_6, var_154_5)
			end

			if arg_151_1.time_ >= var_154_1 + var_154_4 and arg_151_1.time_ < var_154_1 + var_154_4 + arg_154_0 then
				var_154_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_154_7 = arg_151_1.actors_["10095"].transform
			local var_154_8 = 0

			if var_154_8 < arg_151_1.time_ and arg_151_1.time_ <= var_154_8 + arg_154_0 then
				arg_151_1.var_.moveOldPos10095 = var_154_7.localPosition
				var_154_7.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("10095", 0)

				local var_154_9 = var_154_7.childCount

				for iter_154_1 = 0, var_154_9 - 1 do
					local var_154_10 = var_154_7:GetChild(iter_154_1)

					if var_154_10.name == "" or not string.find(var_154_10.name, "split") then
						var_154_10.gameObject:SetActive(true)
					else
						var_154_10.gameObject:SetActive(false)
					end
				end
			end

			local var_154_11 = 0.001

			if var_154_8 <= arg_151_1.time_ and arg_151_1.time_ < var_154_8 + var_154_11 then
				local var_154_12 = (arg_151_1.time_ - var_154_8) / var_154_11
				local var_154_13 = Vector3.New(-1500, -350, -180)

				var_154_7.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10095, var_154_13, var_154_12)
			end

			if arg_151_1.time_ >= var_154_8 + var_154_11 and arg_151_1.time_ < var_154_8 + var_154_11 + arg_154_0 then
				var_154_7.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_154_14 = arg_151_1.actors_["10096"]
			local var_154_15 = 0

			if var_154_15 < arg_151_1.time_ and arg_151_1.time_ <= var_154_15 + arg_154_0 and not isNil(var_154_14) and arg_151_1.var_.actorSpriteComps10096 == nil then
				arg_151_1.var_.actorSpriteComps10096 = var_154_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_16 = 2

			if var_154_15 <= arg_151_1.time_ and arg_151_1.time_ < var_154_15 + var_154_16 and not isNil(var_154_14) then
				local var_154_17 = (arg_151_1.time_ - var_154_15) / var_154_16

				if arg_151_1.var_.actorSpriteComps10096 then
					for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_154_3 then
							if arg_151_1.isInRecall_ then
								local var_154_18 = Mathf.Lerp(iter_154_3.color.r, arg_151_1.hightColor2.r, var_154_17)
								local var_154_19 = Mathf.Lerp(iter_154_3.color.g, arg_151_1.hightColor2.g, var_154_17)
								local var_154_20 = Mathf.Lerp(iter_154_3.color.b, arg_151_1.hightColor2.b, var_154_17)

								iter_154_3.color = Color.New(var_154_18, var_154_19, var_154_20)
							else
								local var_154_21 = Mathf.Lerp(iter_154_3.color.r, 0.5, var_154_17)

								iter_154_3.color = Color.New(var_154_21, var_154_21, var_154_21)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_15 + var_154_16 and arg_151_1.time_ < var_154_15 + var_154_16 + arg_154_0 and not isNil(var_154_14) and arg_151_1.var_.actorSpriteComps10096 then
				for iter_154_4, iter_154_5 in pairs(arg_151_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_154_5 then
						if arg_151_1.isInRecall_ then
							iter_154_5.color = arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_154_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps10096 = nil
			end

			local var_154_22 = arg_151_1.actors_["10095"]
			local var_154_23 = 0

			if var_154_23 < arg_151_1.time_ and arg_151_1.time_ <= var_154_23 + arg_154_0 and not isNil(var_154_22) and arg_151_1.var_.actorSpriteComps10095 == nil then
				arg_151_1.var_.actorSpriteComps10095 = var_154_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_24 = 2

			if var_154_23 <= arg_151_1.time_ and arg_151_1.time_ < var_154_23 + var_154_24 and not isNil(var_154_22) then
				local var_154_25 = (arg_151_1.time_ - var_154_23) / var_154_24

				if arg_151_1.var_.actorSpriteComps10095 then
					for iter_154_6, iter_154_7 in pairs(arg_151_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_154_7 then
							if arg_151_1.isInRecall_ then
								local var_154_26 = Mathf.Lerp(iter_154_7.color.r, arg_151_1.hightColor2.r, var_154_25)
								local var_154_27 = Mathf.Lerp(iter_154_7.color.g, arg_151_1.hightColor2.g, var_154_25)
								local var_154_28 = Mathf.Lerp(iter_154_7.color.b, arg_151_1.hightColor2.b, var_154_25)

								iter_154_7.color = Color.New(var_154_26, var_154_27, var_154_28)
							else
								local var_154_29 = Mathf.Lerp(iter_154_7.color.r, 0.5, var_154_25)

								iter_154_7.color = Color.New(var_154_29, var_154_29, var_154_29)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= var_154_23 + var_154_24 and arg_151_1.time_ < var_154_23 + var_154_24 + arg_154_0 and not isNil(var_154_22) and arg_151_1.var_.actorSpriteComps10095 then
				for iter_154_8, iter_154_9 in pairs(arg_151_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_154_9 then
						if arg_151_1.isInRecall_ then
							iter_154_9.color = arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_154_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_151_1.var_.actorSpriteComps10095 = nil
			end

			local var_154_30 = 0
			local var_154_31 = 0.266666666666667

			if var_154_30 < arg_151_1.time_ and arg_151_1.time_ <= var_154_30 + arg_154_0 then
				local var_154_32 = "play"
				local var_154_33 = "music"

				arg_151_1:AudioAction(var_154_32, var_154_33, "ui_battle", "ui_battle_stopbgm", "")

				local var_154_34 = ""
				local var_154_35 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_154_35 ~= "" then
					if arg_151_1.bgmTxt_.text ~= var_154_35 and arg_151_1.bgmTxt_.text ~= "" then
						if arg_151_1.bgmTxt2_.text ~= "" then
							arg_151_1.bgmTxt_.text = arg_151_1.bgmTxt2_.text
						end

						arg_151_1.bgmTxt2_.text = var_154_35

						arg_151_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_151_1.bgmTxt_.text = var_154_35
						arg_151_1.bgmTxt2_.text = var_154_35
					end

					if arg_151_1.bgmTimer then
						arg_151_1.bgmTimer:Stop()

						arg_151_1.bgmTimer = nil
					end

					if arg_151_1.settingData.show_music_name == 1 then
						arg_151_1.musicController:SetSelectedState("show")
						arg_151_1.musicAnimator_:Play("open", 0, 0)

						if arg_151_1.settingData.music_time ~= 0 then
							arg_151_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_151_1.settingData.music_time), function()
								if arg_151_1 == nil or isNil(arg_151_1.bgmTxt_) then
									return
								end

								arg_151_1.musicController:SetSelectedState("hide")
								arg_151_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_154_36 = 0
			local var_154_37 = 1

			if var_154_36 < arg_151_1.time_ and arg_151_1.time_ <= var_154_36 + arg_154_0 then
				local var_154_38 = "play"
				local var_154_39 = "effect"

				arg_151_1:AudioAction(var_154_38, var_154_39, "se_story_activity_1_1", "se_story_activity_1_1_breeze", "")
			end

			local var_154_40 = 0
			local var_154_41 = 1.35

			if var_154_40 < arg_151_1.time_ and arg_151_1.time_ <= var_154_40 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_42 = arg_151_1:GetWordFromCfg(413022036)
				local var_154_43 = arg_151_1:FormatText(var_154_42.content)

				arg_151_1.text_.text = var_154_43

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_44 = 54
				local var_154_45 = utf8.len(var_154_43)
				local var_154_46 = var_154_44 <= 0 and var_154_41 or var_154_41 * (var_154_45 / var_154_44)

				if var_154_46 > 0 and var_154_41 < var_154_46 then
					arg_151_1.talkMaxDuration = var_154_46

					if var_154_46 + var_154_40 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_46 + var_154_40
					end
				end

				arg_151_1.text_.text = var_154_43
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_47 = math.max(var_154_41, arg_151_1.talkMaxDuration)

			if var_154_40 <= arg_151_1.time_ and arg_151_1.time_ < var_154_40 + var_154_47 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_40) / var_154_47

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_40 + var_154_47 and arg_151_1.time_ < var_154_40 + var_154_47 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play413022037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 413022037
		arg_156_1.duration_ = 9

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play413022038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = "ST0601"

			if arg_156_1.bgs_[var_159_0] == nil then
				local var_159_1 = Object.Instantiate(arg_156_1.paintGo_)

				var_159_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_159_0)
				var_159_1.name = var_159_0
				var_159_1.transform.parent = arg_156_1.stage_.transform
				var_159_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_156_1.bgs_[var_159_0] = var_159_1
			end

			local var_159_2 = 2

			if var_159_2 < arg_156_1.time_ and arg_156_1.time_ <= var_159_2 + arg_159_0 then
				local var_159_3 = manager.ui.mainCamera.transform.localPosition
				local var_159_4 = Vector3.New(0, 0, 10) + Vector3.New(var_159_3.x, var_159_3.y, 0)
				local var_159_5 = arg_156_1.bgs_.ST0601

				var_159_5.transform.localPosition = var_159_4
				var_159_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_159_6 = var_159_5:GetComponent("SpriteRenderer")

				if var_159_6 and var_159_6.sprite then
					local var_159_7 = (var_159_5.transform.localPosition - var_159_3).z
					local var_159_8 = manager.ui.mainCameraCom_
					local var_159_9 = 2 * var_159_7 * Mathf.Tan(var_159_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_159_10 = var_159_9 * var_159_8.aspect
					local var_159_11 = var_159_6.sprite.bounds.size.x
					local var_159_12 = var_159_6.sprite.bounds.size.y
					local var_159_13 = var_159_10 / var_159_11
					local var_159_14 = var_159_9 / var_159_12
					local var_159_15 = var_159_14 < var_159_13 and var_159_13 or var_159_14

					var_159_5.transform.localScale = Vector3.New(var_159_15, var_159_15, 0)
				end

				for iter_159_0, iter_159_1 in pairs(arg_156_1.bgs_) do
					if iter_159_0 ~= "ST0601" then
						iter_159_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_159_16 = 4

			if var_159_16 < arg_156_1.time_ and arg_156_1.time_ <= var_159_16 + arg_159_0 then
				arg_156_1.allBtn_.enabled = false
			end

			local var_159_17 = 0.3

			if arg_156_1.time_ >= var_159_16 + var_159_17 and arg_156_1.time_ < var_159_16 + var_159_17 + arg_159_0 then
				arg_156_1.allBtn_.enabled = true
			end

			local var_159_18 = 0

			if var_159_18 < arg_156_1.time_ and arg_156_1.time_ <= var_159_18 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_19 = 2

			if var_159_18 <= arg_156_1.time_ and arg_156_1.time_ < var_159_18 + var_159_19 then
				local var_159_20 = (arg_156_1.time_ - var_159_18) / var_159_19
				local var_159_21 = Color.New(0, 0, 0)

				var_159_21.a = Mathf.Lerp(0, 1, var_159_20)
				arg_156_1.mask_.color = var_159_21
			end

			if arg_156_1.time_ >= var_159_18 + var_159_19 and arg_156_1.time_ < var_159_18 + var_159_19 + arg_159_0 then
				local var_159_22 = Color.New(0, 0, 0)

				var_159_22.a = 1
				arg_156_1.mask_.color = var_159_22
			end

			local var_159_23 = 2

			if var_159_23 < arg_156_1.time_ and arg_156_1.time_ <= var_159_23 + arg_159_0 then
				arg_156_1.mask_.enabled = true
				arg_156_1.mask_.raycastTarget = true

				arg_156_1:SetGaussion(false)
			end

			local var_159_24 = 2

			if var_159_23 <= arg_156_1.time_ and arg_156_1.time_ < var_159_23 + var_159_24 then
				local var_159_25 = (arg_156_1.time_ - var_159_23) / var_159_24
				local var_159_26 = Color.New(0, 0, 0)

				var_159_26.a = Mathf.Lerp(1, 0, var_159_25)
				arg_156_1.mask_.color = var_159_26
			end

			if arg_156_1.time_ >= var_159_23 + var_159_24 and arg_156_1.time_ < var_159_23 + var_159_24 + arg_159_0 then
				local var_159_27 = Color.New(0, 0, 0)
				local var_159_28 = 0

				arg_156_1.mask_.enabled = false
				var_159_27.a = var_159_28
				arg_156_1.mask_.color = var_159_27
			end

			local var_159_29 = 0
			local var_159_30 = 0.266666666666667

			if var_159_29 < arg_156_1.time_ and arg_156_1.time_ <= var_159_29 + arg_159_0 then
				local var_159_31 = "play"
				local var_159_32 = "music"

				arg_156_1:AudioAction(var_159_31, var_159_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_159_33 = ""
				local var_159_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_159_34 ~= "" then
					if arg_156_1.bgmTxt_.text ~= var_159_34 and arg_156_1.bgmTxt_.text ~= "" then
						if arg_156_1.bgmTxt2_.text ~= "" then
							arg_156_1.bgmTxt_.text = arg_156_1.bgmTxt2_.text
						end

						arg_156_1.bgmTxt2_.text = var_159_34

						arg_156_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_156_1.bgmTxt_.text = var_159_34
						arg_156_1.bgmTxt2_.text = var_159_34
					end

					if arg_156_1.bgmTimer then
						arg_156_1.bgmTimer:Stop()

						arg_156_1.bgmTimer = nil
					end

					if arg_156_1.settingData.show_music_name == 1 then
						arg_156_1.musicController:SetSelectedState("show")
						arg_156_1.musicAnimator_:Play("open", 0, 0)

						if arg_156_1.settingData.music_time ~= 0 then
							arg_156_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_156_1.settingData.music_time), function()
								if arg_156_1 == nil or isNil(arg_156_1.bgmTxt_) then
									return
								end

								arg_156_1.musicController:SetSelectedState("hide")
								arg_156_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_159_35 = 2
			local var_159_36 = 0.833333333333333

			if var_159_35 < arg_156_1.time_ and arg_156_1.time_ <= var_159_35 + arg_159_0 then
				local var_159_37 = "play"
				local var_159_38 = "music"

				arg_156_1:AudioAction(var_159_37, var_159_38, "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_159_39 = ""
				local var_159_40 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if var_159_40 ~= "" then
					if arg_156_1.bgmTxt_.text ~= var_159_40 and arg_156_1.bgmTxt_.text ~= "" then
						if arg_156_1.bgmTxt2_.text ~= "" then
							arg_156_1.bgmTxt_.text = arg_156_1.bgmTxt2_.text
						end

						arg_156_1.bgmTxt2_.text = var_159_40

						arg_156_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_156_1.bgmTxt_.text = var_159_40
						arg_156_1.bgmTxt2_.text = var_159_40
					end

					if arg_156_1.bgmTimer then
						arg_156_1.bgmTimer:Stop()

						arg_156_1.bgmTimer = nil
					end

					if arg_156_1.settingData.show_music_name == 1 then
						arg_156_1.musicController:SetSelectedState("show")
						arg_156_1.musicAnimator_:Play("open", 0, 0)

						if arg_156_1.settingData.music_time ~= 0 then
							arg_156_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_156_1.settingData.music_time), function()
								if arg_156_1 == nil or isNil(arg_156_1.bgmTxt_) then
									return
								end

								arg_156_1.musicController:SetSelectedState("hide")
								arg_156_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_156_1.frameCnt_ <= 1 then
				arg_156_1.dialog_:SetActive(false)
			end

			local var_159_41 = 4
			local var_159_42 = 1.35

			if var_159_41 < arg_156_1.time_ and arg_156_1.time_ <= var_159_41 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0

				arg_156_1.dialog_:SetActive(true)

				arg_156_1.dialogCg_.alpha = 0

				local var_159_43 = LeanTween.value(arg_156_1.dialog_, 0, 1, 0.3)

				var_159_43:setOnUpdate(LuaHelper.FloatAction(function(arg_162_0)
					arg_156_1.dialogCg_.alpha = arg_162_0
				end))
				var_159_43:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_156_1.dialog_)
					var_159_43:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_156_1.duration_ = arg_156_1.duration_ + 0.3

				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_44 = arg_156_1:GetWordFromCfg(413022037)
				local var_159_45 = arg_156_1:FormatText(var_159_44.content)

				arg_156_1.text_.text = var_159_45

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_46 = 54
				local var_159_47 = utf8.len(var_159_45)
				local var_159_48 = var_159_46 <= 0 and var_159_42 or var_159_42 * (var_159_47 / var_159_46)

				if var_159_48 > 0 and var_159_42 < var_159_48 then
					arg_156_1.talkMaxDuration = var_159_48
					var_159_41 = var_159_41 + 0.3

					if var_159_48 + var_159_41 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_48 + var_159_41
					end
				end

				arg_156_1.text_.text = var_159_45
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_49 = var_159_41 + 0.3
			local var_159_50 = math.max(var_159_42, arg_156_1.talkMaxDuration)

			if var_159_49 <= arg_156_1.time_ and arg_156_1.time_ < var_159_49 + var_159_50 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_49) / var_159_50

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_49 + var_159_50 and arg_156_1.time_ < var_159_49 + var_159_50 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play413022038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 413022038
		arg_164_1.duration_ = 7.1

		local var_164_0 = {
			zh = 3.666,
			ja = 7.1
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
				arg_164_0:Play413022039(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["10094"].transform
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.var_.moveOldPos10094 = var_167_0.localPosition
				var_167_0.localScale = Vector3.New(1, 1, 1)

				arg_164_1:CheckSpriteTmpPos("10094", 2)

				local var_167_2 = var_167_0.childCount

				for iter_167_0 = 0, var_167_2 - 1 do
					local var_167_3 = var_167_0:GetChild(iter_167_0)

					if var_167_3.name == "" or not string.find(var_167_3.name, "split") then
						var_167_3.gameObject:SetActive(true)
					else
						var_167_3.gameObject:SetActive(false)
					end
				end
			end

			local var_167_4 = 0.001

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_4 then
				local var_167_5 = (arg_164_1.time_ - var_167_1) / var_167_4
				local var_167_6 = Vector3.New(-390, -340, -414)

				var_167_0.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos10094, var_167_6, var_167_5)
			end

			if arg_164_1.time_ >= var_167_1 + var_167_4 and arg_164_1.time_ < var_167_1 + var_167_4 + arg_167_0 then
				var_167_0.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_167_7 = arg_164_1.actors_["10094"]
			local var_167_8 = 0

			if var_167_8 < arg_164_1.time_ and arg_164_1.time_ <= var_167_8 + arg_167_0 and not isNil(var_167_7) and arg_164_1.var_.actorSpriteComps10094 == nil then
				arg_164_1.var_.actorSpriteComps10094 = var_167_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_167_9 = 2

			if var_167_8 <= arg_164_1.time_ and arg_164_1.time_ < var_167_8 + var_167_9 and not isNil(var_167_7) then
				local var_167_10 = (arg_164_1.time_ - var_167_8) / var_167_9

				if arg_164_1.var_.actorSpriteComps10094 then
					for iter_167_1, iter_167_2 in pairs(arg_164_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_167_2 then
							if arg_164_1.isInRecall_ then
								local var_167_11 = Mathf.Lerp(iter_167_2.color.r, arg_164_1.hightColor1.r, var_167_10)
								local var_167_12 = Mathf.Lerp(iter_167_2.color.g, arg_164_1.hightColor1.g, var_167_10)
								local var_167_13 = Mathf.Lerp(iter_167_2.color.b, arg_164_1.hightColor1.b, var_167_10)

								iter_167_2.color = Color.New(var_167_11, var_167_12, var_167_13)
							else
								local var_167_14 = Mathf.Lerp(iter_167_2.color.r, 1, var_167_10)

								iter_167_2.color = Color.New(var_167_14, var_167_14, var_167_14)
							end
						end
					end
				end
			end

			if arg_164_1.time_ >= var_167_8 + var_167_9 and arg_164_1.time_ < var_167_8 + var_167_9 + arg_167_0 and not isNil(var_167_7) and arg_164_1.var_.actorSpriteComps10094 then
				for iter_167_3, iter_167_4 in pairs(arg_164_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_167_4 then
						if arg_164_1.isInRecall_ then
							iter_167_4.color = arg_164_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_167_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_164_1.var_.actorSpriteComps10094 = nil
			end

			local var_167_15 = 0
			local var_167_16 = 0.35

			if var_167_15 < arg_164_1.time_ and arg_164_1.time_ <= var_167_15 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_17 = arg_164_1:FormatText(StoryNameCfg[259].name)

				arg_164_1.leftNameTxt_.text = var_167_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_18 = arg_164_1:GetWordFromCfg(413022038)
				local var_167_19 = arg_164_1:FormatText(var_167_18.content)

				arg_164_1.text_.text = var_167_19

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_20 = 14
				local var_167_21 = utf8.len(var_167_19)
				local var_167_22 = var_167_20 <= 0 and var_167_16 or var_167_16 * (var_167_21 / var_167_20)

				if var_167_22 > 0 and var_167_16 < var_167_22 then
					arg_164_1.talkMaxDuration = var_167_22

					if var_167_22 + var_167_15 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_22 + var_167_15
					end
				end

				arg_164_1.text_.text = var_167_19
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022038", "story_v_out_413022.awb") ~= 0 then
					local var_167_23 = manager.audio:GetVoiceLength("story_v_out_413022", "413022038", "story_v_out_413022.awb") / 1000

					if var_167_23 + var_167_15 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_23 + var_167_15
					end

					if var_167_18.prefab_name ~= "" and arg_164_1.actors_[var_167_18.prefab_name] ~= nil then
						local var_167_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_18.prefab_name].transform, "story_v_out_413022", "413022038", "story_v_out_413022.awb")

						arg_164_1:RecordAudio("413022038", var_167_24)
						arg_164_1:RecordAudio("413022038", var_167_24)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_413022", "413022038", "story_v_out_413022.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_413022", "413022038", "story_v_out_413022.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_25 = math.max(var_167_16, arg_164_1.talkMaxDuration)

			if var_167_15 <= arg_164_1.time_ and arg_164_1.time_ < var_167_15 + var_167_25 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_15) / var_167_25

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_15 + var_167_25 and arg_164_1.time_ < var_167_15 + var_167_25 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
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

		arg_164_1:InitPlayNodeList()
	end,
	Play413022039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 413022039
		arg_168_1.duration_ = 11.27

		local var_168_0 = {
			zh = 11.266,
			ja = 9.5
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play413022040(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["10097"].transform
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.var_.moveOldPos10097 = var_171_0.localPosition
				var_171_0.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("10097", 4)

				local var_171_2 = var_171_0.childCount

				for iter_171_0 = 0, var_171_2 - 1 do
					local var_171_3 = var_171_0:GetChild(iter_171_0)

					if var_171_3.name == "" or not string.find(var_171_3.name, "split") then
						var_171_3.gameObject:SetActive(true)
					else
						var_171_3.gameObject:SetActive(false)
					end
				end
			end

			local var_171_4 = 0.001

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_4 then
				local var_171_5 = (arg_168_1.time_ - var_171_1) / var_171_4
				local var_171_6 = Vector3.New(390, -350, -180)

				var_171_0.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10097, var_171_6, var_171_5)
			end

			if arg_168_1.time_ >= var_171_1 + var_171_4 and arg_168_1.time_ < var_171_1 + var_171_4 + arg_171_0 then
				var_171_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_171_7 = arg_168_1.actors_["10094"].transform
			local var_171_8 = 0

			if var_171_8 < arg_168_1.time_ and arg_168_1.time_ <= var_171_8 + arg_171_0 then
				arg_168_1.var_.moveOldPos10094 = var_171_7.localPosition
				var_171_7.localScale = Vector3.New(1, 1, 1)

				arg_168_1:CheckSpriteTmpPos("10094", 2)

				local var_171_9 = var_171_7.childCount

				for iter_171_1 = 0, var_171_9 - 1 do
					local var_171_10 = var_171_7:GetChild(iter_171_1)

					if var_171_10.name == "" or not string.find(var_171_10.name, "split") then
						var_171_10.gameObject:SetActive(true)
					else
						var_171_10.gameObject:SetActive(false)
					end
				end
			end

			local var_171_11 = 0.001

			if var_171_8 <= arg_168_1.time_ and arg_168_1.time_ < var_171_8 + var_171_11 then
				local var_171_12 = (arg_168_1.time_ - var_171_8) / var_171_11
				local var_171_13 = Vector3.New(-390, -340, -414)

				var_171_7.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos10094, var_171_13, var_171_12)
			end

			if arg_168_1.time_ >= var_171_8 + var_171_11 and arg_168_1.time_ < var_171_8 + var_171_11 + arg_171_0 then
				var_171_7.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_171_14 = arg_168_1.actors_["10097"]
			local var_171_15 = 0

			if var_171_15 < arg_168_1.time_ and arg_168_1.time_ <= var_171_15 + arg_171_0 and not isNil(var_171_14) and arg_168_1.var_.actorSpriteComps10097 == nil then
				arg_168_1.var_.actorSpriteComps10097 = var_171_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_16 = 2

			if var_171_15 <= arg_168_1.time_ and arg_168_1.time_ < var_171_15 + var_171_16 and not isNil(var_171_14) then
				local var_171_17 = (arg_168_1.time_ - var_171_15) / var_171_16

				if arg_168_1.var_.actorSpriteComps10097 then
					for iter_171_2, iter_171_3 in pairs(arg_168_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_171_3 then
							if arg_168_1.isInRecall_ then
								local var_171_18 = Mathf.Lerp(iter_171_3.color.r, arg_168_1.hightColor1.r, var_171_17)
								local var_171_19 = Mathf.Lerp(iter_171_3.color.g, arg_168_1.hightColor1.g, var_171_17)
								local var_171_20 = Mathf.Lerp(iter_171_3.color.b, arg_168_1.hightColor1.b, var_171_17)

								iter_171_3.color = Color.New(var_171_18, var_171_19, var_171_20)
							else
								local var_171_21 = Mathf.Lerp(iter_171_3.color.r, 1, var_171_17)

								iter_171_3.color = Color.New(var_171_21, var_171_21, var_171_21)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= var_171_15 + var_171_16 and arg_168_1.time_ < var_171_15 + var_171_16 + arg_171_0 and not isNil(var_171_14) and arg_168_1.var_.actorSpriteComps10097 then
				for iter_171_4, iter_171_5 in pairs(arg_168_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_171_5 then
						if arg_168_1.isInRecall_ then
							iter_171_5.color = arg_168_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_171_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_168_1.var_.actorSpriteComps10097 = nil
			end

			local var_171_22 = arg_168_1.actors_["10094"]
			local var_171_23 = 0

			if var_171_23 < arg_168_1.time_ and arg_168_1.time_ <= var_171_23 + arg_171_0 and not isNil(var_171_22) and arg_168_1.var_.actorSpriteComps10094 == nil then
				arg_168_1.var_.actorSpriteComps10094 = var_171_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_171_24 = 2

			if var_171_23 <= arg_168_1.time_ and arg_168_1.time_ < var_171_23 + var_171_24 and not isNil(var_171_22) then
				local var_171_25 = (arg_168_1.time_ - var_171_23) / var_171_24

				if arg_168_1.var_.actorSpriteComps10094 then
					for iter_171_6, iter_171_7 in pairs(arg_168_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_171_7 then
							if arg_168_1.isInRecall_ then
								local var_171_26 = Mathf.Lerp(iter_171_7.color.r, arg_168_1.hightColor2.r, var_171_25)
								local var_171_27 = Mathf.Lerp(iter_171_7.color.g, arg_168_1.hightColor2.g, var_171_25)
								local var_171_28 = Mathf.Lerp(iter_171_7.color.b, arg_168_1.hightColor2.b, var_171_25)

								iter_171_7.color = Color.New(var_171_26, var_171_27, var_171_28)
							else
								local var_171_29 = Mathf.Lerp(iter_171_7.color.r, 0.5, var_171_25)

								iter_171_7.color = Color.New(var_171_29, var_171_29, var_171_29)
							end
						end
					end
				end
			end

			if arg_168_1.time_ >= var_171_23 + var_171_24 and arg_168_1.time_ < var_171_23 + var_171_24 + arg_171_0 and not isNil(var_171_22) and arg_168_1.var_.actorSpriteComps10094 then
				for iter_171_8, iter_171_9 in pairs(arg_168_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_171_9 then
						if arg_168_1.isInRecall_ then
							iter_171_9.color = arg_168_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_171_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_168_1.var_.actorSpriteComps10094 = nil
			end

			local var_171_30 = 0
			local var_171_31 = 1.2

			if var_171_30 < arg_168_1.time_ and arg_168_1.time_ <= var_171_30 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_32 = arg_168_1:FormatText(StoryNameCfg[1001].name)

				arg_168_1.leftNameTxt_.text = var_171_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_33 = arg_168_1:GetWordFromCfg(413022039)
				local var_171_34 = arg_168_1:FormatText(var_171_33.content)

				arg_168_1.text_.text = var_171_34

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_35 = 48
				local var_171_36 = utf8.len(var_171_34)
				local var_171_37 = var_171_35 <= 0 and var_171_31 or var_171_31 * (var_171_36 / var_171_35)

				if var_171_37 > 0 and var_171_31 < var_171_37 then
					arg_168_1.talkMaxDuration = var_171_37

					if var_171_37 + var_171_30 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_37 + var_171_30
					end
				end

				arg_168_1.text_.text = var_171_34
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022039", "story_v_out_413022.awb") ~= 0 then
					local var_171_38 = manager.audio:GetVoiceLength("story_v_out_413022", "413022039", "story_v_out_413022.awb") / 1000

					if var_171_38 + var_171_30 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_38 + var_171_30
					end

					if var_171_33.prefab_name ~= "" and arg_168_1.actors_[var_171_33.prefab_name] ~= nil then
						local var_171_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_33.prefab_name].transform, "story_v_out_413022", "413022039", "story_v_out_413022.awb")

						arg_168_1:RecordAudio("413022039", var_171_39)
						arg_168_1:RecordAudio("413022039", var_171_39)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_413022", "413022039", "story_v_out_413022.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_413022", "413022039", "story_v_out_413022.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_40 = math.max(var_171_31, arg_168_1.talkMaxDuration)

			if var_171_30 <= arg_168_1.time_ and arg_168_1.time_ < var_171_30 + var_171_40 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_30) / var_171_40

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_30 + var_171_40 and arg_168_1.time_ < var_171_30 + var_171_40 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_168_1:InitPlayNodeList()
	end,
	Play413022040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 413022040
		arg_172_1.duration_ = 10.9

		local var_172_0 = {
			zh = 7.666,
			ja = 10.9
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
				arg_172_0:Play413022041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0
			local var_175_1 = 0.85

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_2 = arg_172_1:FormatText(StoryNameCfg[1001].name)

				arg_172_1.leftNameTxt_.text = var_175_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_3 = arg_172_1:GetWordFromCfg(413022040)
				local var_175_4 = arg_172_1:FormatText(var_175_3.content)

				arg_172_1.text_.text = var_175_4

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 34
				local var_175_6 = utf8.len(var_175_4)
				local var_175_7 = var_175_5 <= 0 and var_175_1 or var_175_1 * (var_175_6 / var_175_5)

				if var_175_7 > 0 and var_175_1 < var_175_7 then
					arg_172_1.talkMaxDuration = var_175_7

					if var_175_7 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_7 + var_175_0
					end
				end

				arg_172_1.text_.text = var_175_4
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022040", "story_v_out_413022.awb") ~= 0 then
					local var_175_8 = manager.audio:GetVoiceLength("story_v_out_413022", "413022040", "story_v_out_413022.awb") / 1000

					if var_175_8 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_8 + var_175_0
					end

					if var_175_3.prefab_name ~= "" and arg_172_1.actors_[var_175_3.prefab_name] ~= nil then
						local var_175_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_3.prefab_name].transform, "story_v_out_413022", "413022040", "story_v_out_413022.awb")

						arg_172_1:RecordAudio("413022040", var_175_9)
						arg_172_1:RecordAudio("413022040", var_175_9)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_413022", "413022040", "story_v_out_413022.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_413022", "413022040", "story_v_out_413022.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_10 = math.max(var_175_1, arg_172_1.talkMaxDuration)

			if var_175_0 <= arg_172_1.time_ and arg_172_1.time_ < var_175_0 + var_175_10 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_0) / var_175_10

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_0 + var_175_10 and arg_172_1.time_ < var_175_0 + var_175_10 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play413022041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 413022041
		arg_176_1.duration_ = 3.43

		local var_176_0 = {
			zh = 2.166,
			ja = 3.433
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
				arg_176_0:Play413022042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["10097"].transform
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				arg_176_1.var_.moveOldPos10097 = var_179_0.localPosition
				var_179_0.localScale = Vector3.New(1, 1, 1)

				arg_176_1:CheckSpriteTmpPos("10097", 4)

				local var_179_2 = var_179_0.childCount

				for iter_179_0 = 0, var_179_2 - 1 do
					local var_179_3 = var_179_0:GetChild(iter_179_0)

					if var_179_3.name == "" or not string.find(var_179_3.name, "split") then
						var_179_3.gameObject:SetActive(true)
					else
						var_179_3.gameObject:SetActive(false)
					end
				end
			end

			local var_179_4 = 0.001

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_4 then
				local var_179_5 = (arg_176_1.time_ - var_179_1) / var_179_4
				local var_179_6 = Vector3.New(390, -350, -180)

				var_179_0.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10097, var_179_6, var_179_5)
			end

			if arg_176_1.time_ >= var_179_1 + var_179_4 and arg_176_1.time_ < var_179_1 + var_179_4 + arg_179_0 then
				var_179_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_179_7 = arg_176_1.actors_["10094"].transform
			local var_179_8 = 0

			if var_179_8 < arg_176_1.time_ and arg_176_1.time_ <= var_179_8 + arg_179_0 then
				arg_176_1.var_.moveOldPos10094 = var_179_7.localPosition
				var_179_7.localScale = Vector3.New(1, 1, 1)

				arg_176_1:CheckSpriteTmpPos("10094", 2)

				local var_179_9 = var_179_7.childCount

				for iter_179_1 = 0, var_179_9 - 1 do
					local var_179_10 = var_179_7:GetChild(iter_179_1)

					if var_179_10.name == "" or not string.find(var_179_10.name, "split") then
						var_179_10.gameObject:SetActive(true)
					else
						var_179_10.gameObject:SetActive(false)
					end
				end
			end

			local var_179_11 = 0.001

			if var_179_8 <= arg_176_1.time_ and arg_176_1.time_ < var_179_8 + var_179_11 then
				local var_179_12 = (arg_176_1.time_ - var_179_8) / var_179_11
				local var_179_13 = Vector3.New(-390, -340, -414)

				var_179_7.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10094, var_179_13, var_179_12)
			end

			if arg_176_1.time_ >= var_179_8 + var_179_11 and arg_176_1.time_ < var_179_8 + var_179_11 + arg_179_0 then
				var_179_7.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_179_14 = arg_176_1.actors_["10097"]
			local var_179_15 = 0

			if var_179_15 < arg_176_1.time_ and arg_176_1.time_ <= var_179_15 + arg_179_0 and not isNil(var_179_14) and arg_176_1.var_.actorSpriteComps10097 == nil then
				arg_176_1.var_.actorSpriteComps10097 = var_179_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_16 = 2

			if var_179_15 <= arg_176_1.time_ and arg_176_1.time_ < var_179_15 + var_179_16 and not isNil(var_179_14) then
				local var_179_17 = (arg_176_1.time_ - var_179_15) / var_179_16

				if arg_176_1.var_.actorSpriteComps10097 then
					for iter_179_2, iter_179_3 in pairs(arg_176_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_179_3 then
							if arg_176_1.isInRecall_ then
								local var_179_18 = Mathf.Lerp(iter_179_3.color.r, arg_176_1.hightColor2.r, var_179_17)
								local var_179_19 = Mathf.Lerp(iter_179_3.color.g, arg_176_1.hightColor2.g, var_179_17)
								local var_179_20 = Mathf.Lerp(iter_179_3.color.b, arg_176_1.hightColor2.b, var_179_17)

								iter_179_3.color = Color.New(var_179_18, var_179_19, var_179_20)
							else
								local var_179_21 = Mathf.Lerp(iter_179_3.color.r, 0.5, var_179_17)

								iter_179_3.color = Color.New(var_179_21, var_179_21, var_179_21)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= var_179_15 + var_179_16 and arg_176_1.time_ < var_179_15 + var_179_16 + arg_179_0 and not isNil(var_179_14) and arg_176_1.var_.actorSpriteComps10097 then
				for iter_179_4, iter_179_5 in pairs(arg_176_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_179_5 then
						if arg_176_1.isInRecall_ then
							iter_179_5.color = arg_176_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_179_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_176_1.var_.actorSpriteComps10097 = nil
			end

			local var_179_22 = arg_176_1.actors_["10094"]
			local var_179_23 = 0

			if var_179_23 < arg_176_1.time_ and arg_176_1.time_ <= var_179_23 + arg_179_0 and not isNil(var_179_22) and arg_176_1.var_.actorSpriteComps10094 == nil then
				arg_176_1.var_.actorSpriteComps10094 = var_179_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_179_24 = 2

			if var_179_23 <= arg_176_1.time_ and arg_176_1.time_ < var_179_23 + var_179_24 and not isNil(var_179_22) then
				local var_179_25 = (arg_176_1.time_ - var_179_23) / var_179_24

				if arg_176_1.var_.actorSpriteComps10094 then
					for iter_179_6, iter_179_7 in pairs(arg_176_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_179_7 then
							if arg_176_1.isInRecall_ then
								local var_179_26 = Mathf.Lerp(iter_179_7.color.r, arg_176_1.hightColor1.r, var_179_25)
								local var_179_27 = Mathf.Lerp(iter_179_7.color.g, arg_176_1.hightColor1.g, var_179_25)
								local var_179_28 = Mathf.Lerp(iter_179_7.color.b, arg_176_1.hightColor1.b, var_179_25)

								iter_179_7.color = Color.New(var_179_26, var_179_27, var_179_28)
							else
								local var_179_29 = Mathf.Lerp(iter_179_7.color.r, 1, var_179_25)

								iter_179_7.color = Color.New(var_179_29, var_179_29, var_179_29)
							end
						end
					end
				end
			end

			if arg_176_1.time_ >= var_179_23 + var_179_24 and arg_176_1.time_ < var_179_23 + var_179_24 + arg_179_0 and not isNil(var_179_22) and arg_176_1.var_.actorSpriteComps10094 then
				for iter_179_8, iter_179_9 in pairs(arg_176_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_179_9 then
						if arg_176_1.isInRecall_ then
							iter_179_9.color = arg_176_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_179_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_176_1.var_.actorSpriteComps10094 = nil
			end

			local var_179_30 = 0
			local var_179_31 = 0.275

			if var_179_30 < arg_176_1.time_ and arg_176_1.time_ <= var_179_30 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_32 = arg_176_1:FormatText(StoryNameCfg[259].name)

				arg_176_1.leftNameTxt_.text = var_179_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_33 = arg_176_1:GetWordFromCfg(413022041)
				local var_179_34 = arg_176_1:FormatText(var_179_33.content)

				arg_176_1.text_.text = var_179_34

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_35 = 11
				local var_179_36 = utf8.len(var_179_34)
				local var_179_37 = var_179_35 <= 0 and var_179_31 or var_179_31 * (var_179_36 / var_179_35)

				if var_179_37 > 0 and var_179_31 < var_179_37 then
					arg_176_1.talkMaxDuration = var_179_37

					if var_179_37 + var_179_30 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_37 + var_179_30
					end
				end

				arg_176_1.text_.text = var_179_34
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022041", "story_v_out_413022.awb") ~= 0 then
					local var_179_38 = manager.audio:GetVoiceLength("story_v_out_413022", "413022041", "story_v_out_413022.awb") / 1000

					if var_179_38 + var_179_30 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_38 + var_179_30
					end

					if var_179_33.prefab_name ~= "" and arg_176_1.actors_[var_179_33.prefab_name] ~= nil then
						local var_179_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_33.prefab_name].transform, "story_v_out_413022", "413022041", "story_v_out_413022.awb")

						arg_176_1:RecordAudio("413022041", var_179_39)
						arg_176_1:RecordAudio("413022041", var_179_39)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_413022", "413022041", "story_v_out_413022.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_413022", "413022041", "story_v_out_413022.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_40 = math.max(var_179_31, arg_176_1.talkMaxDuration)

			if var_179_30 <= arg_176_1.time_ and arg_176_1.time_ < var_179_30 + var_179_40 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_30) / var_179_40

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_30 + var_179_40 and arg_176_1.time_ < var_179_30 + var_179_40 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_176_1:InitPlayNodeList()
	end,
	Play413022042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 413022042
		arg_180_1.duration_ = 10.57

		local var_180_0 = {
			zh = 10.366,
			ja = 10.566
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play413022043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["10097"].transform
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.var_.moveOldPos10097 = var_183_0.localPosition
				var_183_0.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("10097", 4)

				local var_183_2 = var_183_0.childCount

				for iter_183_0 = 0, var_183_2 - 1 do
					local var_183_3 = var_183_0:GetChild(iter_183_0)

					if var_183_3.name == "" or not string.find(var_183_3.name, "split") then
						var_183_3.gameObject:SetActive(true)
					else
						var_183_3.gameObject:SetActive(false)
					end
				end
			end

			local var_183_4 = 0.001

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_4 then
				local var_183_5 = (arg_180_1.time_ - var_183_1) / var_183_4
				local var_183_6 = Vector3.New(390, -350, -180)

				var_183_0.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10097, var_183_6, var_183_5)
			end

			if arg_180_1.time_ >= var_183_1 + var_183_4 and arg_180_1.time_ < var_183_1 + var_183_4 + arg_183_0 then
				var_183_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_183_7 = arg_180_1.actors_["10094"].transform
			local var_183_8 = 0

			if var_183_8 < arg_180_1.time_ and arg_180_1.time_ <= var_183_8 + arg_183_0 then
				arg_180_1.var_.moveOldPos10094 = var_183_7.localPosition
				var_183_7.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("10094", 2)

				local var_183_9 = var_183_7.childCount

				for iter_183_1 = 0, var_183_9 - 1 do
					local var_183_10 = var_183_7:GetChild(iter_183_1)

					if var_183_10.name == "" or not string.find(var_183_10.name, "split") then
						var_183_10.gameObject:SetActive(true)
					else
						var_183_10.gameObject:SetActive(false)
					end
				end
			end

			local var_183_11 = 0.001

			if var_183_8 <= arg_180_1.time_ and arg_180_1.time_ < var_183_8 + var_183_11 then
				local var_183_12 = (arg_180_1.time_ - var_183_8) / var_183_11
				local var_183_13 = Vector3.New(-390, -340, -414)

				var_183_7.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10094, var_183_13, var_183_12)
			end

			if arg_180_1.time_ >= var_183_8 + var_183_11 and arg_180_1.time_ < var_183_8 + var_183_11 + arg_183_0 then
				var_183_7.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_183_14 = arg_180_1.actors_["10097"]
			local var_183_15 = 0

			if var_183_15 < arg_180_1.time_ and arg_180_1.time_ <= var_183_15 + arg_183_0 and not isNil(var_183_14) and arg_180_1.var_.actorSpriteComps10097 == nil then
				arg_180_1.var_.actorSpriteComps10097 = var_183_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_16 = 2

			if var_183_15 <= arg_180_1.time_ and arg_180_1.time_ < var_183_15 + var_183_16 and not isNil(var_183_14) then
				local var_183_17 = (arg_180_1.time_ - var_183_15) / var_183_16

				if arg_180_1.var_.actorSpriteComps10097 then
					for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_183_3 then
							if arg_180_1.isInRecall_ then
								local var_183_18 = Mathf.Lerp(iter_183_3.color.r, arg_180_1.hightColor1.r, var_183_17)
								local var_183_19 = Mathf.Lerp(iter_183_3.color.g, arg_180_1.hightColor1.g, var_183_17)
								local var_183_20 = Mathf.Lerp(iter_183_3.color.b, arg_180_1.hightColor1.b, var_183_17)

								iter_183_3.color = Color.New(var_183_18, var_183_19, var_183_20)
							else
								local var_183_21 = Mathf.Lerp(iter_183_3.color.r, 1, var_183_17)

								iter_183_3.color = Color.New(var_183_21, var_183_21, var_183_21)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= var_183_15 + var_183_16 and arg_180_1.time_ < var_183_15 + var_183_16 + arg_183_0 and not isNil(var_183_14) and arg_180_1.var_.actorSpriteComps10097 then
				for iter_183_4, iter_183_5 in pairs(arg_180_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_183_5 then
						if arg_180_1.isInRecall_ then
							iter_183_5.color = arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_183_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps10097 = nil
			end

			local var_183_22 = arg_180_1.actors_["10094"]
			local var_183_23 = 0

			if var_183_23 < arg_180_1.time_ and arg_180_1.time_ <= var_183_23 + arg_183_0 and not isNil(var_183_22) and arg_180_1.var_.actorSpriteComps10094 == nil then
				arg_180_1.var_.actorSpriteComps10094 = var_183_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_24 = 2

			if var_183_23 <= arg_180_1.time_ and arg_180_1.time_ < var_183_23 + var_183_24 and not isNil(var_183_22) then
				local var_183_25 = (arg_180_1.time_ - var_183_23) / var_183_24

				if arg_180_1.var_.actorSpriteComps10094 then
					for iter_183_6, iter_183_7 in pairs(arg_180_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_183_7 then
							if arg_180_1.isInRecall_ then
								local var_183_26 = Mathf.Lerp(iter_183_7.color.r, arg_180_1.hightColor2.r, var_183_25)
								local var_183_27 = Mathf.Lerp(iter_183_7.color.g, arg_180_1.hightColor2.g, var_183_25)
								local var_183_28 = Mathf.Lerp(iter_183_7.color.b, arg_180_1.hightColor2.b, var_183_25)

								iter_183_7.color = Color.New(var_183_26, var_183_27, var_183_28)
							else
								local var_183_29 = Mathf.Lerp(iter_183_7.color.r, 0.5, var_183_25)

								iter_183_7.color = Color.New(var_183_29, var_183_29, var_183_29)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= var_183_23 + var_183_24 and arg_180_1.time_ < var_183_23 + var_183_24 + arg_183_0 and not isNil(var_183_22) and arg_180_1.var_.actorSpriteComps10094 then
				for iter_183_8, iter_183_9 in pairs(arg_180_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_183_9 then
						if arg_180_1.isInRecall_ then
							iter_183_9.color = arg_180_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_183_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_180_1.var_.actorSpriteComps10094 = nil
			end

			local var_183_30 = 0
			local var_183_31 = 0.925

			if var_183_30 < arg_180_1.time_ and arg_180_1.time_ <= var_183_30 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_32 = arg_180_1:FormatText(StoryNameCfg[1001].name)

				arg_180_1.leftNameTxt_.text = var_183_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_33 = arg_180_1:GetWordFromCfg(413022042)
				local var_183_34 = arg_180_1:FormatText(var_183_33.content)

				arg_180_1.text_.text = var_183_34

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_35 = 37
				local var_183_36 = utf8.len(var_183_34)
				local var_183_37 = var_183_35 <= 0 and var_183_31 or var_183_31 * (var_183_36 / var_183_35)

				if var_183_37 > 0 and var_183_31 < var_183_37 then
					arg_180_1.talkMaxDuration = var_183_37

					if var_183_37 + var_183_30 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_37 + var_183_30
					end
				end

				arg_180_1.text_.text = var_183_34
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022042", "story_v_out_413022.awb") ~= 0 then
					local var_183_38 = manager.audio:GetVoiceLength("story_v_out_413022", "413022042", "story_v_out_413022.awb") / 1000

					if var_183_38 + var_183_30 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_38 + var_183_30
					end

					if var_183_33.prefab_name ~= "" and arg_180_1.actors_[var_183_33.prefab_name] ~= nil then
						local var_183_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_33.prefab_name].transform, "story_v_out_413022", "413022042", "story_v_out_413022.awb")

						arg_180_1:RecordAudio("413022042", var_183_39)
						arg_180_1:RecordAudio("413022042", var_183_39)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_413022", "413022042", "story_v_out_413022.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_413022", "413022042", "story_v_out_413022.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_40 = math.max(var_183_31, arg_180_1.talkMaxDuration)

			if var_183_30 <= arg_180_1.time_ and arg_180_1.time_ < var_183_30 + var_183_40 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_30) / var_183_40

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_30 + var_183_40 and arg_180_1.time_ < var_183_30 + var_183_40 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_180_1:InitPlayNodeList()
	end,
	Play413022043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 413022043
		arg_184_1.duration_ = 5.83

		local var_184_0 = {
			zh = 5.833,
			ja = 3.533
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
				arg_184_0:Play413022044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10097"].transform
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.var_.moveOldPos10097 = var_187_0.localPosition
				var_187_0.localScale = Vector3.New(1, 1, 1)

				arg_184_1:CheckSpriteTmpPos("10097", 0)

				local var_187_2 = var_187_0.childCount

				for iter_187_0 = 0, var_187_2 - 1 do
					local var_187_3 = var_187_0:GetChild(iter_187_0)

					if var_187_3.name == "" or not string.find(var_187_3.name, "split") then
						var_187_3.gameObject:SetActive(true)
					else
						var_187_3.gameObject:SetActive(false)
					end
				end
			end

			local var_187_4 = 0.001

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_4 then
				local var_187_5 = (arg_184_1.time_ - var_187_1) / var_187_4
				local var_187_6 = Vector3.New(-1500, -350, -180)

				var_187_0.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10097, var_187_6, var_187_5)
			end

			if arg_184_1.time_ >= var_187_1 + var_187_4 and arg_184_1.time_ < var_187_1 + var_187_4 + arg_187_0 then
				var_187_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_187_7 = arg_184_1.actors_["10094"].transform
			local var_187_8 = 0

			if var_187_8 < arg_184_1.time_ and arg_184_1.time_ <= var_187_8 + arg_187_0 then
				arg_184_1.var_.moveOldPos10094 = var_187_7.localPosition
				var_187_7.localScale = Vector3.New(1, 1, 1)

				arg_184_1:CheckSpriteTmpPos("10094", 0)

				local var_187_9 = var_187_7.childCount

				for iter_187_1 = 0, var_187_9 - 1 do
					local var_187_10 = var_187_7:GetChild(iter_187_1)

					if var_187_10.name == "" or not string.find(var_187_10.name, "split") then
						var_187_10.gameObject:SetActive(true)
					else
						var_187_10.gameObject:SetActive(false)
					end
				end
			end

			local var_187_11 = 0.001

			if var_187_8 <= arg_184_1.time_ and arg_184_1.time_ < var_187_8 + var_187_11 then
				local var_187_12 = (arg_184_1.time_ - var_187_8) / var_187_11
				local var_187_13 = Vector3.New(-5000, -340, -414)

				var_187_7.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10094, var_187_13, var_187_12)
			end

			if arg_184_1.time_ >= var_187_8 + var_187_11 and arg_184_1.time_ < var_187_8 + var_187_11 + arg_187_0 then
				var_187_7.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_187_14 = arg_184_1.actors_["10022"].transform
			local var_187_15 = 0

			if var_187_15 < arg_184_1.time_ and arg_184_1.time_ <= var_187_15 + arg_187_0 then
				arg_184_1.var_.moveOldPos10022 = var_187_14.localPosition
				var_187_14.localScale = Vector3.New(1, 1, 1)

				arg_184_1:CheckSpriteTmpPos("10022", 3)

				local var_187_16 = var_187_14.childCount

				for iter_187_2 = 0, var_187_16 - 1 do
					local var_187_17 = var_187_14:GetChild(iter_187_2)

					if var_187_17.name == "split_6" or not string.find(var_187_17.name, "split") then
						var_187_17.gameObject:SetActive(true)
					else
						var_187_17.gameObject:SetActive(false)
					end
				end
			end

			local var_187_18 = 0.001

			if var_187_15 <= arg_184_1.time_ and arg_184_1.time_ < var_187_15 + var_187_18 then
				local var_187_19 = (arg_184_1.time_ - var_187_15) / var_187_18
				local var_187_20 = Vector3.New(0, -315, -320)

				var_187_14.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10022, var_187_20, var_187_19)
			end

			if arg_184_1.time_ >= var_187_15 + var_187_18 and arg_184_1.time_ < var_187_15 + var_187_18 + arg_187_0 then
				var_187_14.localPosition = Vector3.New(0, -315, -320)
			end

			local var_187_21 = arg_184_1.actors_["10097"]
			local var_187_22 = 0

			if var_187_22 < arg_184_1.time_ and arg_184_1.time_ <= var_187_22 + arg_187_0 and not isNil(var_187_21) and arg_184_1.var_.actorSpriteComps10097 == nil then
				arg_184_1.var_.actorSpriteComps10097 = var_187_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_23 = 2

			if var_187_22 <= arg_184_1.time_ and arg_184_1.time_ < var_187_22 + var_187_23 and not isNil(var_187_21) then
				local var_187_24 = (arg_184_1.time_ - var_187_22) / var_187_23

				if arg_184_1.var_.actorSpriteComps10097 then
					for iter_187_3, iter_187_4 in pairs(arg_184_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_187_4 then
							if arg_184_1.isInRecall_ then
								local var_187_25 = Mathf.Lerp(iter_187_4.color.r, arg_184_1.hightColor2.r, var_187_24)
								local var_187_26 = Mathf.Lerp(iter_187_4.color.g, arg_184_1.hightColor2.g, var_187_24)
								local var_187_27 = Mathf.Lerp(iter_187_4.color.b, arg_184_1.hightColor2.b, var_187_24)

								iter_187_4.color = Color.New(var_187_25, var_187_26, var_187_27)
							else
								local var_187_28 = Mathf.Lerp(iter_187_4.color.r, 0.5, var_187_24)

								iter_187_4.color = Color.New(var_187_28, var_187_28, var_187_28)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= var_187_22 + var_187_23 and arg_184_1.time_ < var_187_22 + var_187_23 + arg_187_0 and not isNil(var_187_21) and arg_184_1.var_.actorSpriteComps10097 then
				for iter_187_5, iter_187_6 in pairs(arg_184_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_187_6 then
						if arg_184_1.isInRecall_ then
							iter_187_6.color = arg_184_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_187_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_184_1.var_.actorSpriteComps10097 = nil
			end

			local var_187_29 = arg_184_1.actors_["10094"]
			local var_187_30 = 0

			if var_187_30 < arg_184_1.time_ and arg_184_1.time_ <= var_187_30 + arg_187_0 and not isNil(var_187_29) and arg_184_1.var_.actorSpriteComps10094 == nil then
				arg_184_1.var_.actorSpriteComps10094 = var_187_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_31 = 2

			if var_187_30 <= arg_184_1.time_ and arg_184_1.time_ < var_187_30 + var_187_31 and not isNil(var_187_29) then
				local var_187_32 = (arg_184_1.time_ - var_187_30) / var_187_31

				if arg_184_1.var_.actorSpriteComps10094 then
					for iter_187_7, iter_187_8 in pairs(arg_184_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_187_8 then
							if arg_184_1.isInRecall_ then
								local var_187_33 = Mathf.Lerp(iter_187_8.color.r, arg_184_1.hightColor2.r, var_187_32)
								local var_187_34 = Mathf.Lerp(iter_187_8.color.g, arg_184_1.hightColor2.g, var_187_32)
								local var_187_35 = Mathf.Lerp(iter_187_8.color.b, arg_184_1.hightColor2.b, var_187_32)

								iter_187_8.color = Color.New(var_187_33, var_187_34, var_187_35)
							else
								local var_187_36 = Mathf.Lerp(iter_187_8.color.r, 0.5, var_187_32)

								iter_187_8.color = Color.New(var_187_36, var_187_36, var_187_36)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= var_187_30 + var_187_31 and arg_184_1.time_ < var_187_30 + var_187_31 + arg_187_0 and not isNil(var_187_29) and arg_184_1.var_.actorSpriteComps10094 then
				for iter_187_9, iter_187_10 in pairs(arg_184_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_187_10 then
						if arg_184_1.isInRecall_ then
							iter_187_10.color = arg_184_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_187_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_184_1.var_.actorSpriteComps10094 = nil
			end

			local var_187_37 = arg_184_1.actors_["10022"]
			local var_187_38 = 0

			if var_187_38 < arg_184_1.time_ and arg_184_1.time_ <= var_187_38 + arg_187_0 and not isNil(var_187_37) and arg_184_1.var_.actorSpriteComps10022 == nil then
				arg_184_1.var_.actorSpriteComps10022 = var_187_37:GetComponentsInChildren(typeof(Image), true)
			end

			local var_187_39 = 2

			if var_187_38 <= arg_184_1.time_ and arg_184_1.time_ < var_187_38 + var_187_39 and not isNil(var_187_37) then
				local var_187_40 = (arg_184_1.time_ - var_187_38) / var_187_39

				if arg_184_1.var_.actorSpriteComps10022 then
					for iter_187_11, iter_187_12 in pairs(arg_184_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_187_12 then
							if arg_184_1.isInRecall_ then
								local var_187_41 = Mathf.Lerp(iter_187_12.color.r, arg_184_1.hightColor1.r, var_187_40)
								local var_187_42 = Mathf.Lerp(iter_187_12.color.g, arg_184_1.hightColor1.g, var_187_40)
								local var_187_43 = Mathf.Lerp(iter_187_12.color.b, arg_184_1.hightColor1.b, var_187_40)

								iter_187_12.color = Color.New(var_187_41, var_187_42, var_187_43)
							else
								local var_187_44 = Mathf.Lerp(iter_187_12.color.r, 1, var_187_40)

								iter_187_12.color = Color.New(var_187_44, var_187_44, var_187_44)
							end
						end
					end
				end
			end

			if arg_184_1.time_ >= var_187_38 + var_187_39 and arg_184_1.time_ < var_187_38 + var_187_39 + arg_187_0 and not isNil(var_187_37) and arg_184_1.var_.actorSpriteComps10022 then
				for iter_187_13, iter_187_14 in pairs(arg_184_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_187_14 then
						if arg_184_1.isInRecall_ then
							iter_187_14.color = arg_184_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_187_14.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_184_1.var_.actorSpriteComps10022 = nil
			end

			local var_187_45 = 0
			local var_187_46 = 0.825

			if var_187_45 < arg_184_1.time_ and arg_184_1.time_ <= var_187_45 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_47 = arg_184_1:FormatText(StoryNameCfg[614].name)

				arg_184_1.leftNameTxt_.text = var_187_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_48 = arg_184_1:GetWordFromCfg(413022043)
				local var_187_49 = arg_184_1:FormatText(var_187_48.content)

				arg_184_1.text_.text = var_187_49

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_50 = 33
				local var_187_51 = utf8.len(var_187_49)
				local var_187_52 = var_187_50 <= 0 and var_187_46 or var_187_46 * (var_187_51 / var_187_50)

				if var_187_52 > 0 and var_187_46 < var_187_52 then
					arg_184_1.talkMaxDuration = var_187_52

					if var_187_52 + var_187_45 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_52 + var_187_45
					end
				end

				arg_184_1.text_.text = var_187_49
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022043", "story_v_out_413022.awb") ~= 0 then
					local var_187_53 = manager.audio:GetVoiceLength("story_v_out_413022", "413022043", "story_v_out_413022.awb") / 1000

					if var_187_53 + var_187_45 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_53 + var_187_45
					end

					if var_187_48.prefab_name ~= "" and arg_184_1.actors_[var_187_48.prefab_name] ~= nil then
						local var_187_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_48.prefab_name].transform, "story_v_out_413022", "413022043", "story_v_out_413022.awb")

						arg_184_1:RecordAudio("413022043", var_187_54)
						arg_184_1:RecordAudio("413022043", var_187_54)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_413022", "413022043", "story_v_out_413022.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_413022", "413022043", "story_v_out_413022.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_55 = math.max(var_187_46, arg_184_1.talkMaxDuration)

			if var_187_45 <= arg_184_1.time_ and arg_184_1.time_ < var_187_45 + var_187_55 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_45) / var_187_55

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_45 + var_187_55 and arg_184_1.time_ < var_187_45 + var_187_55 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_184_1:InitPlayNodeList()
	end,
	Play413022044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 413022044
		arg_188_1.duration_ = 7.47

		local var_188_0 = {
			zh = 6.466,
			ja = 7.466
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
				arg_188_0:Play413022045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["10097"].transform
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.var_.moveOldPos10097 = var_191_0.localPosition
				var_191_0.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("10097", 3)

				local var_191_2 = var_191_0.childCount

				for iter_191_0 = 0, var_191_2 - 1 do
					local var_191_3 = var_191_0:GetChild(iter_191_0)

					if var_191_3.name == "" or not string.find(var_191_3.name, "split") then
						var_191_3.gameObject:SetActive(true)
					else
						var_191_3.gameObject:SetActive(false)
					end
				end
			end

			local var_191_4 = 0.001

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_4 then
				local var_191_5 = (arg_188_1.time_ - var_191_1) / var_191_4
				local var_191_6 = Vector3.New(0, -350, -180)

				var_191_0.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10097, var_191_6, var_191_5)
			end

			if arg_188_1.time_ >= var_191_1 + var_191_4 and arg_188_1.time_ < var_191_1 + var_191_4 + arg_191_0 then
				var_191_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_191_7 = arg_188_1.actors_["10022"].transform
			local var_191_8 = 0

			if var_191_8 < arg_188_1.time_ and arg_188_1.time_ <= var_191_8 + arg_191_0 then
				arg_188_1.var_.moveOldPos10022 = var_191_7.localPosition
				var_191_7.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("10022", 0)

				local var_191_9 = var_191_7.childCount

				for iter_191_1 = 0, var_191_9 - 1 do
					local var_191_10 = var_191_7:GetChild(iter_191_1)

					if var_191_10.name == "" or not string.find(var_191_10.name, "split") then
						var_191_10.gameObject:SetActive(true)
					else
						var_191_10.gameObject:SetActive(false)
					end
				end
			end

			local var_191_11 = 0.001

			if var_191_8 <= arg_188_1.time_ and arg_188_1.time_ < var_191_8 + var_191_11 then
				local var_191_12 = (arg_188_1.time_ - var_191_8) / var_191_11
				local var_191_13 = Vector3.New(-1500, -350, -180)

				var_191_7.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10022, var_191_13, var_191_12)
			end

			if arg_188_1.time_ >= var_191_8 + var_191_11 and arg_188_1.time_ < var_191_8 + var_191_11 + arg_191_0 then
				var_191_7.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_191_14 = arg_188_1.actors_["10097"]
			local var_191_15 = 0

			if var_191_15 < arg_188_1.time_ and arg_188_1.time_ <= var_191_15 + arg_191_0 and not isNil(var_191_14) and arg_188_1.var_.actorSpriteComps10097 == nil then
				arg_188_1.var_.actorSpriteComps10097 = var_191_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_16 = 2

			if var_191_15 <= arg_188_1.time_ and arg_188_1.time_ < var_191_15 + var_191_16 and not isNil(var_191_14) then
				local var_191_17 = (arg_188_1.time_ - var_191_15) / var_191_16

				if arg_188_1.var_.actorSpriteComps10097 then
					for iter_191_2, iter_191_3 in pairs(arg_188_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_191_3 then
							if arg_188_1.isInRecall_ then
								local var_191_18 = Mathf.Lerp(iter_191_3.color.r, arg_188_1.hightColor1.r, var_191_17)
								local var_191_19 = Mathf.Lerp(iter_191_3.color.g, arg_188_1.hightColor1.g, var_191_17)
								local var_191_20 = Mathf.Lerp(iter_191_3.color.b, arg_188_1.hightColor1.b, var_191_17)

								iter_191_3.color = Color.New(var_191_18, var_191_19, var_191_20)
							else
								local var_191_21 = Mathf.Lerp(iter_191_3.color.r, 1, var_191_17)

								iter_191_3.color = Color.New(var_191_21, var_191_21, var_191_21)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= var_191_15 + var_191_16 and arg_188_1.time_ < var_191_15 + var_191_16 + arg_191_0 and not isNil(var_191_14) and arg_188_1.var_.actorSpriteComps10097 then
				for iter_191_4, iter_191_5 in pairs(arg_188_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_191_5 then
						if arg_188_1.isInRecall_ then
							iter_191_5.color = arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_191_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_188_1.var_.actorSpriteComps10097 = nil
			end

			local var_191_22 = arg_188_1.actors_["10022"]
			local var_191_23 = 0

			if var_191_23 < arg_188_1.time_ and arg_188_1.time_ <= var_191_23 + arg_191_0 and not isNil(var_191_22) and arg_188_1.var_.actorSpriteComps10022 == nil then
				arg_188_1.var_.actorSpriteComps10022 = var_191_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_24 = 2

			if var_191_23 <= arg_188_1.time_ and arg_188_1.time_ < var_191_23 + var_191_24 and not isNil(var_191_22) then
				local var_191_25 = (arg_188_1.time_ - var_191_23) / var_191_24

				if arg_188_1.var_.actorSpriteComps10022 then
					for iter_191_6, iter_191_7 in pairs(arg_188_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_191_7 then
							if arg_188_1.isInRecall_ then
								local var_191_26 = Mathf.Lerp(iter_191_7.color.r, arg_188_1.hightColor2.r, var_191_25)
								local var_191_27 = Mathf.Lerp(iter_191_7.color.g, arg_188_1.hightColor2.g, var_191_25)
								local var_191_28 = Mathf.Lerp(iter_191_7.color.b, arg_188_1.hightColor2.b, var_191_25)

								iter_191_7.color = Color.New(var_191_26, var_191_27, var_191_28)
							else
								local var_191_29 = Mathf.Lerp(iter_191_7.color.r, 0.5, var_191_25)

								iter_191_7.color = Color.New(var_191_29, var_191_29, var_191_29)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= var_191_23 + var_191_24 and arg_188_1.time_ < var_191_23 + var_191_24 + arg_191_0 and not isNil(var_191_22) and arg_188_1.var_.actorSpriteComps10022 then
				for iter_191_8, iter_191_9 in pairs(arg_188_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_191_9 then
						if arg_188_1.isInRecall_ then
							iter_191_9.color = arg_188_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_191_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_188_1.var_.actorSpriteComps10022 = nil
			end

			local var_191_30 = 0
			local var_191_31 = 0.75

			if var_191_30 < arg_188_1.time_ and arg_188_1.time_ <= var_191_30 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_32 = arg_188_1:FormatText(StoryNameCfg[1001].name)

				arg_188_1.leftNameTxt_.text = var_191_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_33 = arg_188_1:GetWordFromCfg(413022044)
				local var_191_34 = arg_188_1:FormatText(var_191_33.content)

				arg_188_1.text_.text = var_191_34

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_35 = 30
				local var_191_36 = utf8.len(var_191_34)
				local var_191_37 = var_191_35 <= 0 and var_191_31 or var_191_31 * (var_191_36 / var_191_35)

				if var_191_37 > 0 and var_191_31 < var_191_37 then
					arg_188_1.talkMaxDuration = var_191_37

					if var_191_37 + var_191_30 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_37 + var_191_30
					end
				end

				arg_188_1.text_.text = var_191_34
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022044", "story_v_out_413022.awb") ~= 0 then
					local var_191_38 = manager.audio:GetVoiceLength("story_v_out_413022", "413022044", "story_v_out_413022.awb") / 1000

					if var_191_38 + var_191_30 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_38 + var_191_30
					end

					if var_191_33.prefab_name ~= "" and arg_188_1.actors_[var_191_33.prefab_name] ~= nil then
						local var_191_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_33.prefab_name].transform, "story_v_out_413022", "413022044", "story_v_out_413022.awb")

						arg_188_1:RecordAudio("413022044", var_191_39)
						arg_188_1:RecordAudio("413022044", var_191_39)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_413022", "413022044", "story_v_out_413022.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_413022", "413022044", "story_v_out_413022.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_40 = math.max(var_191_31, arg_188_1.talkMaxDuration)

			if var_191_30 <= arg_188_1.time_ and arg_188_1.time_ < var_191_30 + var_191_40 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_30) / var_191_40

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_30 + var_191_40 and arg_188_1.time_ < var_191_30 + var_191_40 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_188_1:InitPlayNodeList()
	end,
	Play413022045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 413022045
		arg_192_1.duration_ = 8.87

		local var_192_0 = {
			zh = 5.7,
			ja = 8.866
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
				arg_192_0:Play413022046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["10022"].transform
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.var_.moveOldPos10022 = var_195_0.localPosition
				var_195_0.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("10022", 2)

				local var_195_2 = var_195_0.childCount

				for iter_195_0 = 0, var_195_2 - 1 do
					local var_195_3 = var_195_0:GetChild(iter_195_0)

					if var_195_3.name == "split_6" or not string.find(var_195_3.name, "split") then
						var_195_3.gameObject:SetActive(true)
					else
						var_195_3.gameObject:SetActive(false)
					end
				end
			end

			local var_195_4 = 0.001

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_4 then
				local var_195_5 = (arg_192_1.time_ - var_195_1) / var_195_4
				local var_195_6 = Vector3.New(-390, -315, -320)

				var_195_0.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10022, var_195_6, var_195_5)
			end

			if arg_192_1.time_ >= var_195_1 + var_195_4 and arg_192_1.time_ < var_195_1 + var_195_4 + arg_195_0 then
				var_195_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_195_7 = arg_192_1.actors_["10097"].transform
			local var_195_8 = 0

			if var_195_8 < arg_192_1.time_ and arg_192_1.time_ <= var_195_8 + arg_195_0 then
				arg_192_1.var_.moveOldPos10097 = var_195_7.localPosition
				var_195_7.localScale = Vector3.New(1, 1, 1)

				arg_192_1:CheckSpriteTmpPos("10097", 4)

				local var_195_9 = var_195_7.childCount

				for iter_195_1 = 0, var_195_9 - 1 do
					local var_195_10 = var_195_7:GetChild(iter_195_1)

					if var_195_10.name == "" or not string.find(var_195_10.name, "split") then
						var_195_10.gameObject:SetActive(true)
					else
						var_195_10.gameObject:SetActive(false)
					end
				end
			end

			local var_195_11 = 0.001

			if var_195_8 <= arg_192_1.time_ and arg_192_1.time_ < var_195_8 + var_195_11 then
				local var_195_12 = (arg_192_1.time_ - var_195_8) / var_195_11
				local var_195_13 = Vector3.New(390, -350, -180)

				var_195_7.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10097, var_195_13, var_195_12)
			end

			if arg_192_1.time_ >= var_195_8 + var_195_11 and arg_192_1.time_ < var_195_8 + var_195_11 + arg_195_0 then
				var_195_7.localPosition = Vector3.New(390, -350, -180)
			end

			local var_195_14 = arg_192_1.actors_["10022"]
			local var_195_15 = 0

			if var_195_15 < arg_192_1.time_ and arg_192_1.time_ <= var_195_15 + arg_195_0 and not isNil(var_195_14) and arg_192_1.var_.actorSpriteComps10022 == nil then
				arg_192_1.var_.actorSpriteComps10022 = var_195_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_16 = 2

			if var_195_15 <= arg_192_1.time_ and arg_192_1.time_ < var_195_15 + var_195_16 and not isNil(var_195_14) then
				local var_195_17 = (arg_192_1.time_ - var_195_15) / var_195_16

				if arg_192_1.var_.actorSpriteComps10022 then
					for iter_195_2, iter_195_3 in pairs(arg_192_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_195_3 then
							if arg_192_1.isInRecall_ then
								local var_195_18 = Mathf.Lerp(iter_195_3.color.r, arg_192_1.hightColor1.r, var_195_17)
								local var_195_19 = Mathf.Lerp(iter_195_3.color.g, arg_192_1.hightColor1.g, var_195_17)
								local var_195_20 = Mathf.Lerp(iter_195_3.color.b, arg_192_1.hightColor1.b, var_195_17)

								iter_195_3.color = Color.New(var_195_18, var_195_19, var_195_20)
							else
								local var_195_21 = Mathf.Lerp(iter_195_3.color.r, 1, var_195_17)

								iter_195_3.color = Color.New(var_195_21, var_195_21, var_195_21)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= var_195_15 + var_195_16 and arg_192_1.time_ < var_195_15 + var_195_16 + arg_195_0 and not isNil(var_195_14) and arg_192_1.var_.actorSpriteComps10022 then
				for iter_195_4, iter_195_5 in pairs(arg_192_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_195_5 then
						if arg_192_1.isInRecall_ then
							iter_195_5.color = arg_192_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_195_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_192_1.var_.actorSpriteComps10022 = nil
			end

			local var_195_22 = arg_192_1.actors_["10097"]
			local var_195_23 = 0

			if var_195_23 < arg_192_1.time_ and arg_192_1.time_ <= var_195_23 + arg_195_0 and not isNil(var_195_22) and arg_192_1.var_.actorSpriteComps10097 == nil then
				arg_192_1.var_.actorSpriteComps10097 = var_195_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_195_24 = 2

			if var_195_23 <= arg_192_1.time_ and arg_192_1.time_ < var_195_23 + var_195_24 and not isNil(var_195_22) then
				local var_195_25 = (arg_192_1.time_ - var_195_23) / var_195_24

				if arg_192_1.var_.actorSpriteComps10097 then
					for iter_195_6, iter_195_7 in pairs(arg_192_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_195_7 then
							if arg_192_1.isInRecall_ then
								local var_195_26 = Mathf.Lerp(iter_195_7.color.r, arg_192_1.hightColor2.r, var_195_25)
								local var_195_27 = Mathf.Lerp(iter_195_7.color.g, arg_192_1.hightColor2.g, var_195_25)
								local var_195_28 = Mathf.Lerp(iter_195_7.color.b, arg_192_1.hightColor2.b, var_195_25)

								iter_195_7.color = Color.New(var_195_26, var_195_27, var_195_28)
							else
								local var_195_29 = Mathf.Lerp(iter_195_7.color.r, 0.5, var_195_25)

								iter_195_7.color = Color.New(var_195_29, var_195_29, var_195_29)
							end
						end
					end
				end
			end

			if arg_192_1.time_ >= var_195_23 + var_195_24 and arg_192_1.time_ < var_195_23 + var_195_24 + arg_195_0 and not isNil(var_195_22) and arg_192_1.var_.actorSpriteComps10097 then
				for iter_195_8, iter_195_9 in pairs(arg_192_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_195_9 then
						if arg_192_1.isInRecall_ then
							iter_195_9.color = arg_192_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_195_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_192_1.var_.actorSpriteComps10097 = nil
			end

			local var_195_30 = 0
			local var_195_31 = 0.8

			if var_195_30 < arg_192_1.time_ and arg_192_1.time_ <= var_195_30 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				local var_195_32 = arg_192_1:FormatText(StoryNameCfg[614].name)

				arg_192_1.leftNameTxt_.text = var_195_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_33 = arg_192_1:GetWordFromCfg(413022045)
				local var_195_34 = arg_192_1:FormatText(var_195_33.content)

				arg_192_1.text_.text = var_195_34

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_35 = 33
				local var_195_36 = utf8.len(var_195_34)
				local var_195_37 = var_195_35 <= 0 and var_195_31 or var_195_31 * (var_195_36 / var_195_35)

				if var_195_37 > 0 and var_195_31 < var_195_37 then
					arg_192_1.talkMaxDuration = var_195_37

					if var_195_37 + var_195_30 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_37 + var_195_30
					end
				end

				arg_192_1.text_.text = var_195_34
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022045", "story_v_out_413022.awb") ~= 0 then
					local var_195_38 = manager.audio:GetVoiceLength("story_v_out_413022", "413022045", "story_v_out_413022.awb") / 1000

					if var_195_38 + var_195_30 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_38 + var_195_30
					end

					if var_195_33.prefab_name ~= "" and arg_192_1.actors_[var_195_33.prefab_name] ~= nil then
						local var_195_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_33.prefab_name].transform, "story_v_out_413022", "413022045", "story_v_out_413022.awb")

						arg_192_1:RecordAudio("413022045", var_195_39)
						arg_192_1:RecordAudio("413022045", var_195_39)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_413022", "413022045", "story_v_out_413022.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_413022", "413022045", "story_v_out_413022.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_40 = math.max(var_195_31, arg_192_1.talkMaxDuration)

			if var_195_30 <= arg_192_1.time_ and arg_192_1.time_ < var_195_30 + var_195_40 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_30) / var_195_40

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_30 + var_195_40 and arg_192_1.time_ < var_195_30 + var_195_40 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
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
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play413022046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 413022046
		arg_196_1.duration_ = 3.93

		local var_196_0 = {
			zh = 1.999999999999,
			ja = 3.933
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
				arg_196_0:Play413022047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = arg_196_1.actors_["10097"].transform
			local var_199_1 = 0

			if var_199_1 < arg_196_1.time_ and arg_196_1.time_ <= var_199_1 + arg_199_0 then
				arg_196_1.var_.moveOldPos10097 = var_199_0.localPosition
				var_199_0.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("10097", 4)

				local var_199_2 = var_199_0.childCount

				for iter_199_0 = 0, var_199_2 - 1 do
					local var_199_3 = var_199_0:GetChild(iter_199_0)

					if var_199_3.name == "" or not string.find(var_199_3.name, "split") then
						var_199_3.gameObject:SetActive(true)
					else
						var_199_3.gameObject:SetActive(false)
					end
				end
			end

			local var_199_4 = 0.001

			if var_199_1 <= arg_196_1.time_ and arg_196_1.time_ < var_199_1 + var_199_4 then
				local var_199_5 = (arg_196_1.time_ - var_199_1) / var_199_4
				local var_199_6 = Vector3.New(390, -350, -180)

				var_199_0.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos10097, var_199_6, var_199_5)
			end

			if arg_196_1.time_ >= var_199_1 + var_199_4 and arg_196_1.time_ < var_199_1 + var_199_4 + arg_199_0 then
				var_199_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_199_7 = arg_196_1.actors_["10022"]
			local var_199_8 = 0

			if var_199_8 < arg_196_1.time_ and arg_196_1.time_ <= var_199_8 + arg_199_0 and not isNil(var_199_7) and arg_196_1.var_.actorSpriteComps10022 == nil then
				arg_196_1.var_.actorSpriteComps10022 = var_199_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_9 = 2

			if var_199_8 <= arg_196_1.time_ and arg_196_1.time_ < var_199_8 + var_199_9 and not isNil(var_199_7) then
				local var_199_10 = (arg_196_1.time_ - var_199_8) / var_199_9

				if arg_196_1.var_.actorSpriteComps10022 then
					for iter_199_1, iter_199_2 in pairs(arg_196_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_199_2 then
							if arg_196_1.isInRecall_ then
								local var_199_11 = Mathf.Lerp(iter_199_2.color.r, arg_196_1.hightColor2.r, var_199_10)
								local var_199_12 = Mathf.Lerp(iter_199_2.color.g, arg_196_1.hightColor2.g, var_199_10)
								local var_199_13 = Mathf.Lerp(iter_199_2.color.b, arg_196_1.hightColor2.b, var_199_10)

								iter_199_2.color = Color.New(var_199_11, var_199_12, var_199_13)
							else
								local var_199_14 = Mathf.Lerp(iter_199_2.color.r, 0.5, var_199_10)

								iter_199_2.color = Color.New(var_199_14, var_199_14, var_199_14)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= var_199_8 + var_199_9 and arg_196_1.time_ < var_199_8 + var_199_9 + arg_199_0 and not isNil(var_199_7) and arg_196_1.var_.actorSpriteComps10022 then
				for iter_199_3, iter_199_4 in pairs(arg_196_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_199_4 then
						if arg_196_1.isInRecall_ then
							iter_199_4.color = arg_196_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_199_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_196_1.var_.actorSpriteComps10022 = nil
			end

			local var_199_15 = arg_196_1.actors_["10097"]
			local var_199_16 = 0

			if var_199_16 < arg_196_1.time_ and arg_196_1.time_ <= var_199_16 + arg_199_0 and not isNil(var_199_15) and arg_196_1.var_.actorSpriteComps10097 == nil then
				arg_196_1.var_.actorSpriteComps10097 = var_199_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_199_17 = 2

			if var_199_16 <= arg_196_1.time_ and arg_196_1.time_ < var_199_16 + var_199_17 and not isNil(var_199_15) then
				local var_199_18 = (arg_196_1.time_ - var_199_16) / var_199_17

				if arg_196_1.var_.actorSpriteComps10097 then
					for iter_199_5, iter_199_6 in pairs(arg_196_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_199_6 then
							if arg_196_1.isInRecall_ then
								local var_199_19 = Mathf.Lerp(iter_199_6.color.r, arg_196_1.hightColor1.r, var_199_18)
								local var_199_20 = Mathf.Lerp(iter_199_6.color.g, arg_196_1.hightColor1.g, var_199_18)
								local var_199_21 = Mathf.Lerp(iter_199_6.color.b, arg_196_1.hightColor1.b, var_199_18)

								iter_199_6.color = Color.New(var_199_19, var_199_20, var_199_21)
							else
								local var_199_22 = Mathf.Lerp(iter_199_6.color.r, 1, var_199_18)

								iter_199_6.color = Color.New(var_199_22, var_199_22, var_199_22)
							end
						end
					end
				end
			end

			if arg_196_1.time_ >= var_199_16 + var_199_17 and arg_196_1.time_ < var_199_16 + var_199_17 + arg_199_0 and not isNil(var_199_15) and arg_196_1.var_.actorSpriteComps10097 then
				for iter_199_7, iter_199_8 in pairs(arg_196_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_199_8 then
						if arg_196_1.isInRecall_ then
							iter_199_8.color = arg_196_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_199_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_196_1.var_.actorSpriteComps10097 = nil
			end

			local var_199_23 = 0
			local var_199_24 = 0.125

			if var_199_23 < arg_196_1.time_ and arg_196_1.time_ <= var_199_23 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				local var_199_25 = arg_196_1:FormatText(StoryNameCfg[1001].name)

				arg_196_1.leftNameTxt_.text = var_199_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_26 = arg_196_1:GetWordFromCfg(413022046)
				local var_199_27 = arg_196_1:FormatText(var_199_26.content)

				arg_196_1.text_.text = var_199_27

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_28 = 5
				local var_199_29 = utf8.len(var_199_27)
				local var_199_30 = var_199_28 <= 0 and var_199_24 or var_199_24 * (var_199_29 / var_199_28)

				if var_199_30 > 0 and var_199_24 < var_199_30 then
					arg_196_1.talkMaxDuration = var_199_30

					if var_199_30 + var_199_23 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_30 + var_199_23
					end
				end

				arg_196_1.text_.text = var_199_27
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022046", "story_v_out_413022.awb") ~= 0 then
					local var_199_31 = manager.audio:GetVoiceLength("story_v_out_413022", "413022046", "story_v_out_413022.awb") / 1000

					if var_199_31 + var_199_23 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_31 + var_199_23
					end

					if var_199_26.prefab_name ~= "" and arg_196_1.actors_[var_199_26.prefab_name] ~= nil then
						local var_199_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_26.prefab_name].transform, "story_v_out_413022", "413022046", "story_v_out_413022.awb")

						arg_196_1:RecordAudio("413022046", var_199_32)
						arg_196_1:RecordAudio("413022046", var_199_32)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_413022", "413022046", "story_v_out_413022.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_413022", "413022046", "story_v_out_413022.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_33 = math.max(var_199_24, arg_196_1.talkMaxDuration)

			if var_199_23 <= arg_196_1.time_ and arg_196_1.time_ < var_199_23 + var_199_33 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_23) / var_199_33

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_23 + var_199_33 and arg_196_1.time_ < var_199_23 + var_199_33 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play413022047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 413022047
		arg_200_1.duration_ = 10.9

		local var_200_0 = {
			zh = 5.066,
			ja = 10.9
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
				arg_200_0:Play413022048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = arg_200_1.actors_["10022"].transform
			local var_203_1 = 0

			if var_203_1 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.var_.moveOldPos10022 = var_203_0.localPosition
				var_203_0.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("10022", 0)

				local var_203_2 = var_203_0.childCount

				for iter_203_0 = 0, var_203_2 - 1 do
					local var_203_3 = var_203_0:GetChild(iter_203_0)

					if var_203_3.name == "" or not string.find(var_203_3.name, "split") then
						var_203_3.gameObject:SetActive(true)
					else
						var_203_3.gameObject:SetActive(false)
					end
				end
			end

			local var_203_4 = 0.001

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_4 then
				local var_203_5 = (arg_200_1.time_ - var_203_1) / var_203_4
				local var_203_6 = Vector3.New(-1500, -350, -180)

				var_203_0.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10022, var_203_6, var_203_5)
			end

			if arg_200_1.time_ >= var_203_1 + var_203_4 and arg_200_1.time_ < var_203_1 + var_203_4 + arg_203_0 then
				var_203_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_203_7 = arg_200_1.actors_["10097"].transform
			local var_203_8 = 0

			if var_203_8 < arg_200_1.time_ and arg_200_1.time_ <= var_203_8 + arg_203_0 then
				arg_200_1.var_.moveOldPos10097 = var_203_7.localPosition
				var_203_7.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("10097", 0)

				local var_203_9 = var_203_7.childCount

				for iter_203_1 = 0, var_203_9 - 1 do
					local var_203_10 = var_203_7:GetChild(iter_203_1)

					if var_203_10.name == "" or not string.find(var_203_10.name, "split") then
						var_203_10.gameObject:SetActive(true)
					else
						var_203_10.gameObject:SetActive(false)
					end
				end
			end

			local var_203_11 = 0.001

			if var_203_8 <= arg_200_1.time_ and arg_200_1.time_ < var_203_8 + var_203_11 then
				local var_203_12 = (arg_200_1.time_ - var_203_8) / var_203_11
				local var_203_13 = Vector3.New(-1500, -350, -180)

				var_203_7.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10097, var_203_13, var_203_12)
			end

			if arg_200_1.time_ >= var_203_8 + var_203_11 and arg_200_1.time_ < var_203_8 + var_203_11 + arg_203_0 then
				var_203_7.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_203_14 = arg_200_1.actors_["10092"].transform
			local var_203_15 = 0

			if var_203_15 < arg_200_1.time_ and arg_200_1.time_ <= var_203_15 + arg_203_0 then
				arg_200_1.var_.moveOldPos10092 = var_203_14.localPosition
				var_203_14.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("10092", 3)

				local var_203_16 = var_203_14.childCount

				for iter_203_2 = 0, var_203_16 - 1 do
					local var_203_17 = var_203_14:GetChild(iter_203_2)

					if var_203_17.name == "" or not string.find(var_203_17.name, "split") then
						var_203_17.gameObject:SetActive(true)
					else
						var_203_17.gameObject:SetActive(false)
					end
				end
			end

			local var_203_18 = 0.001

			if var_203_15 <= arg_200_1.time_ and arg_200_1.time_ < var_203_15 + var_203_18 then
				local var_203_19 = (arg_200_1.time_ - var_203_15) / var_203_18
				local var_203_20 = Vector3.New(0, -300, -295)

				var_203_14.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10092, var_203_20, var_203_19)
			end

			if arg_200_1.time_ >= var_203_15 + var_203_18 and arg_200_1.time_ < var_203_15 + var_203_18 + arg_203_0 then
				var_203_14.localPosition = Vector3.New(0, -300, -295)
			end

			local var_203_21 = arg_200_1.actors_["10022"]
			local var_203_22 = 0

			if var_203_22 < arg_200_1.time_ and arg_200_1.time_ <= var_203_22 + arg_203_0 and not isNil(var_203_21) and arg_200_1.var_.actorSpriteComps10022 == nil then
				arg_200_1.var_.actorSpriteComps10022 = var_203_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_23 = 2

			if var_203_22 <= arg_200_1.time_ and arg_200_1.time_ < var_203_22 + var_203_23 and not isNil(var_203_21) then
				local var_203_24 = (arg_200_1.time_ - var_203_22) / var_203_23

				if arg_200_1.var_.actorSpriteComps10022 then
					for iter_203_3, iter_203_4 in pairs(arg_200_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_203_4 then
							if arg_200_1.isInRecall_ then
								local var_203_25 = Mathf.Lerp(iter_203_4.color.r, arg_200_1.hightColor2.r, var_203_24)
								local var_203_26 = Mathf.Lerp(iter_203_4.color.g, arg_200_1.hightColor2.g, var_203_24)
								local var_203_27 = Mathf.Lerp(iter_203_4.color.b, arg_200_1.hightColor2.b, var_203_24)

								iter_203_4.color = Color.New(var_203_25, var_203_26, var_203_27)
							else
								local var_203_28 = Mathf.Lerp(iter_203_4.color.r, 0.5, var_203_24)

								iter_203_4.color = Color.New(var_203_28, var_203_28, var_203_28)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= var_203_22 + var_203_23 and arg_200_1.time_ < var_203_22 + var_203_23 + arg_203_0 and not isNil(var_203_21) and arg_200_1.var_.actorSpriteComps10022 then
				for iter_203_5, iter_203_6 in pairs(arg_200_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_203_6 then
						if arg_200_1.isInRecall_ then
							iter_203_6.color = arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_203_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_200_1.var_.actorSpriteComps10022 = nil
			end

			local var_203_29 = arg_200_1.actors_["10097"]
			local var_203_30 = 0

			if var_203_30 < arg_200_1.time_ and arg_200_1.time_ <= var_203_30 + arg_203_0 and not isNil(var_203_29) and arg_200_1.var_.actorSpriteComps10097 == nil then
				arg_200_1.var_.actorSpriteComps10097 = var_203_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_31 = 2

			if var_203_30 <= arg_200_1.time_ and arg_200_1.time_ < var_203_30 + var_203_31 and not isNil(var_203_29) then
				local var_203_32 = (arg_200_1.time_ - var_203_30) / var_203_31

				if arg_200_1.var_.actorSpriteComps10097 then
					for iter_203_7, iter_203_8 in pairs(arg_200_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_203_8 then
							if arg_200_1.isInRecall_ then
								local var_203_33 = Mathf.Lerp(iter_203_8.color.r, arg_200_1.hightColor2.r, var_203_32)
								local var_203_34 = Mathf.Lerp(iter_203_8.color.g, arg_200_1.hightColor2.g, var_203_32)
								local var_203_35 = Mathf.Lerp(iter_203_8.color.b, arg_200_1.hightColor2.b, var_203_32)

								iter_203_8.color = Color.New(var_203_33, var_203_34, var_203_35)
							else
								local var_203_36 = Mathf.Lerp(iter_203_8.color.r, 0.5, var_203_32)

								iter_203_8.color = Color.New(var_203_36, var_203_36, var_203_36)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= var_203_30 + var_203_31 and arg_200_1.time_ < var_203_30 + var_203_31 + arg_203_0 and not isNil(var_203_29) and arg_200_1.var_.actorSpriteComps10097 then
				for iter_203_9, iter_203_10 in pairs(arg_200_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_203_10 then
						if arg_200_1.isInRecall_ then
							iter_203_10.color = arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_203_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_200_1.var_.actorSpriteComps10097 = nil
			end

			local var_203_37 = arg_200_1.actors_["10092"]
			local var_203_38 = 0

			if var_203_38 < arg_200_1.time_ and arg_200_1.time_ <= var_203_38 + arg_203_0 and not isNil(var_203_37) and arg_200_1.var_.actorSpriteComps10092 == nil then
				arg_200_1.var_.actorSpriteComps10092 = var_203_37:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_39 = 2

			if var_203_38 <= arg_200_1.time_ and arg_200_1.time_ < var_203_38 + var_203_39 and not isNil(var_203_37) then
				local var_203_40 = (arg_200_1.time_ - var_203_38) / var_203_39

				if arg_200_1.var_.actorSpriteComps10092 then
					for iter_203_11, iter_203_12 in pairs(arg_200_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_203_12 then
							if arg_200_1.isInRecall_ then
								local var_203_41 = Mathf.Lerp(iter_203_12.color.r, arg_200_1.hightColor1.r, var_203_40)
								local var_203_42 = Mathf.Lerp(iter_203_12.color.g, arg_200_1.hightColor1.g, var_203_40)
								local var_203_43 = Mathf.Lerp(iter_203_12.color.b, arg_200_1.hightColor1.b, var_203_40)

								iter_203_12.color = Color.New(var_203_41, var_203_42, var_203_43)
							else
								local var_203_44 = Mathf.Lerp(iter_203_12.color.r, 1, var_203_40)

								iter_203_12.color = Color.New(var_203_44, var_203_44, var_203_44)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= var_203_38 + var_203_39 and arg_200_1.time_ < var_203_38 + var_203_39 + arg_203_0 and not isNil(var_203_37) and arg_200_1.var_.actorSpriteComps10092 then
				for iter_203_13, iter_203_14 in pairs(arg_200_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_203_14 then
						if arg_200_1.isInRecall_ then
							iter_203_14.color = arg_200_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_203_14.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_200_1.var_.actorSpriteComps10092 = nil
			end

			local var_203_45 = arg_200_1.actors_["10092"]
			local var_203_46 = 0

			if var_203_46 < arg_200_1.time_ and arg_200_1.time_ <= var_203_46 + arg_203_0 then
				local var_203_47 = var_203_45:GetComponentInChildren(typeof(CanvasGroup))

				if var_203_47 then
					arg_200_1.var_.alphaOldValue10092 = var_203_47.alpha
					arg_200_1.var_.characterEffect10092 = var_203_47
				end

				arg_200_1.var_.alphaOldValue10092 = 0
			end

			local var_203_48 = 0.0166666666666667

			if var_203_46 <= arg_200_1.time_ and arg_200_1.time_ < var_203_46 + var_203_48 then
				local var_203_49 = (arg_200_1.time_ - var_203_46) / var_203_48
				local var_203_50 = Mathf.Lerp(arg_200_1.var_.alphaOldValue10092, 1, var_203_49)

				if arg_200_1.var_.characterEffect10092 then
					arg_200_1.var_.characterEffect10092.alpha = var_203_50
				end
			end

			if arg_200_1.time_ >= var_203_46 + var_203_48 and arg_200_1.time_ < var_203_46 + var_203_48 + arg_203_0 and arg_200_1.var_.characterEffect10092 then
				arg_200_1.var_.characterEffect10092.alpha = 1
			end

			local var_203_51 = 0
			local var_203_52 = 0.65

			if var_203_51 < arg_200_1.time_ and arg_200_1.time_ <= var_203_51 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				local var_203_53 = arg_200_1:FormatText(StoryNameCfg[996].name)

				arg_200_1.leftNameTxt_.text = var_203_53

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_54 = arg_200_1:GetWordFromCfg(413022047)
				local var_203_55 = arg_200_1:FormatText(var_203_54.content)

				arg_200_1.text_.text = var_203_55

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_56 = 26
				local var_203_57 = utf8.len(var_203_55)
				local var_203_58 = var_203_56 <= 0 and var_203_52 or var_203_52 * (var_203_57 / var_203_56)

				if var_203_58 > 0 and var_203_52 < var_203_58 then
					arg_200_1.talkMaxDuration = var_203_58

					if var_203_58 + var_203_51 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_58 + var_203_51
					end
				end

				arg_200_1.text_.text = var_203_55
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022047", "story_v_out_413022.awb") ~= 0 then
					local var_203_59 = manager.audio:GetVoiceLength("story_v_out_413022", "413022047", "story_v_out_413022.awb") / 1000

					if var_203_59 + var_203_51 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_59 + var_203_51
					end

					if var_203_54.prefab_name ~= "" and arg_200_1.actors_[var_203_54.prefab_name] ~= nil then
						local var_203_60 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_54.prefab_name].transform, "story_v_out_413022", "413022047", "story_v_out_413022.awb")

						arg_200_1:RecordAudio("413022047", var_203_60)
						arg_200_1:RecordAudio("413022047", var_203_60)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_413022", "413022047", "story_v_out_413022.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_413022", "413022047", "story_v_out_413022.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_61 = math.max(var_203_52, arg_200_1.talkMaxDuration)

			if var_203_51 <= arg_200_1.time_ and arg_200_1.time_ < var_203_51 + var_203_61 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_51) / var_203_61

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_51 + var_203_61 and arg_200_1.time_ < var_203_51 + var_203_61 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
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
				actorName = "10097",
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

		arg_200_1:InitPlayNodeList()
	end,
	Play413022048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 413022048
		arg_204_1.duration_ = 9.73

		local var_204_0 = {
			zh = 3.533,
			ja = 9.733
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
				arg_204_0:Play413022049(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = arg_204_1.actors_["10094"].transform
			local var_207_1 = 0

			if var_207_1 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 then
				arg_204_1.var_.moveOldPos10094 = var_207_0.localPosition
				var_207_0.localScale = Vector3.New(1, 1, 1)

				arg_204_1:CheckSpriteTmpPos("10094", 3)

				local var_207_2 = var_207_0.childCount

				for iter_207_0 = 0, var_207_2 - 1 do
					local var_207_3 = var_207_0:GetChild(iter_207_0)

					if var_207_3.name == "" or not string.find(var_207_3.name, "split") then
						var_207_3.gameObject:SetActive(true)
					else
						var_207_3.gameObject:SetActive(false)
					end
				end
			end

			local var_207_4 = 0.001

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_4 then
				local var_207_5 = (arg_204_1.time_ - var_207_1) / var_207_4
				local var_207_6 = Vector3.New(0, -340, -414)

				var_207_0.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10094, var_207_6, var_207_5)
			end

			if arg_204_1.time_ >= var_207_1 + var_207_4 and arg_204_1.time_ < var_207_1 + var_207_4 + arg_207_0 then
				var_207_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_207_7 = arg_204_1.actors_["10092"].transform
			local var_207_8 = 0

			if var_207_8 < arg_204_1.time_ and arg_204_1.time_ <= var_207_8 + arg_207_0 then
				arg_204_1.var_.moveOldPos10092 = var_207_7.localPosition
				var_207_7.localScale = Vector3.New(1, 1, 1)

				arg_204_1:CheckSpriteTmpPos("10092", 0)

				local var_207_9 = var_207_7.childCount

				for iter_207_1 = 0, var_207_9 - 1 do
					local var_207_10 = var_207_7:GetChild(iter_207_1)

					if var_207_10.name == "" or not string.find(var_207_10.name, "split") then
						var_207_10.gameObject:SetActive(true)
					else
						var_207_10.gameObject:SetActive(false)
					end
				end
			end

			local var_207_11 = 0.001

			if var_207_8 <= arg_204_1.time_ and arg_204_1.time_ < var_207_8 + var_207_11 then
				local var_207_12 = (arg_204_1.time_ - var_207_8) / var_207_11
				local var_207_13 = Vector3.New(-1500, -350, -180)

				var_207_7.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10092, var_207_13, var_207_12)
			end

			if arg_204_1.time_ >= var_207_8 + var_207_11 and arg_204_1.time_ < var_207_8 + var_207_11 + arg_207_0 then
				var_207_7.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_207_14 = arg_204_1.actors_["10094"]
			local var_207_15 = 0

			if var_207_15 < arg_204_1.time_ and arg_204_1.time_ <= var_207_15 + arg_207_0 and not isNil(var_207_14) and arg_204_1.var_.actorSpriteComps10094 == nil then
				arg_204_1.var_.actorSpriteComps10094 = var_207_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_16 = 2

			if var_207_15 <= arg_204_1.time_ and arg_204_1.time_ < var_207_15 + var_207_16 and not isNil(var_207_14) then
				local var_207_17 = (arg_204_1.time_ - var_207_15) / var_207_16

				if arg_204_1.var_.actorSpriteComps10094 then
					for iter_207_2, iter_207_3 in pairs(arg_204_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_207_3 then
							if arg_204_1.isInRecall_ then
								local var_207_18 = Mathf.Lerp(iter_207_3.color.r, arg_204_1.hightColor1.r, var_207_17)
								local var_207_19 = Mathf.Lerp(iter_207_3.color.g, arg_204_1.hightColor1.g, var_207_17)
								local var_207_20 = Mathf.Lerp(iter_207_3.color.b, arg_204_1.hightColor1.b, var_207_17)

								iter_207_3.color = Color.New(var_207_18, var_207_19, var_207_20)
							else
								local var_207_21 = Mathf.Lerp(iter_207_3.color.r, 1, var_207_17)

								iter_207_3.color = Color.New(var_207_21, var_207_21, var_207_21)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= var_207_15 + var_207_16 and arg_204_1.time_ < var_207_15 + var_207_16 + arg_207_0 and not isNil(var_207_14) and arg_204_1.var_.actorSpriteComps10094 then
				for iter_207_4, iter_207_5 in pairs(arg_204_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_207_5 then
						if arg_204_1.isInRecall_ then
							iter_207_5.color = arg_204_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_207_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_204_1.var_.actorSpriteComps10094 = nil
			end

			local var_207_22 = arg_204_1.actors_["10092"]
			local var_207_23 = 0

			if var_207_23 < arg_204_1.time_ and arg_204_1.time_ <= var_207_23 + arg_207_0 and not isNil(var_207_22) and arg_204_1.var_.actorSpriteComps10092 == nil then
				arg_204_1.var_.actorSpriteComps10092 = var_207_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_207_24 = 2

			if var_207_23 <= arg_204_1.time_ and arg_204_1.time_ < var_207_23 + var_207_24 and not isNil(var_207_22) then
				local var_207_25 = (arg_204_1.time_ - var_207_23) / var_207_24

				if arg_204_1.var_.actorSpriteComps10092 then
					for iter_207_6, iter_207_7 in pairs(arg_204_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_207_7 then
							if arg_204_1.isInRecall_ then
								local var_207_26 = Mathf.Lerp(iter_207_7.color.r, arg_204_1.hightColor2.r, var_207_25)
								local var_207_27 = Mathf.Lerp(iter_207_7.color.g, arg_204_1.hightColor2.g, var_207_25)
								local var_207_28 = Mathf.Lerp(iter_207_7.color.b, arg_204_1.hightColor2.b, var_207_25)

								iter_207_7.color = Color.New(var_207_26, var_207_27, var_207_28)
							else
								local var_207_29 = Mathf.Lerp(iter_207_7.color.r, 0.5, var_207_25)

								iter_207_7.color = Color.New(var_207_29, var_207_29, var_207_29)
							end
						end
					end
				end
			end

			if arg_204_1.time_ >= var_207_23 + var_207_24 and arg_204_1.time_ < var_207_23 + var_207_24 + arg_207_0 and not isNil(var_207_22) and arg_204_1.var_.actorSpriteComps10092 then
				for iter_207_8, iter_207_9 in pairs(arg_204_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_207_9 then
						if arg_204_1.isInRecall_ then
							iter_207_9.color = arg_204_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_207_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_204_1.var_.actorSpriteComps10092 = nil
			end

			local var_207_30 = 0
			local var_207_31 = 0.425

			if var_207_30 < arg_204_1.time_ and arg_204_1.time_ <= var_207_30 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_32 = arg_204_1:FormatText(StoryNameCfg[259].name)

				arg_204_1.leftNameTxt_.text = var_207_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_33 = arg_204_1:GetWordFromCfg(413022048)
				local var_207_34 = arg_204_1:FormatText(var_207_33.content)

				arg_204_1.text_.text = var_207_34

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_35 = 17
				local var_207_36 = utf8.len(var_207_34)
				local var_207_37 = var_207_35 <= 0 and var_207_31 or var_207_31 * (var_207_36 / var_207_35)

				if var_207_37 > 0 and var_207_31 < var_207_37 then
					arg_204_1.talkMaxDuration = var_207_37

					if var_207_37 + var_207_30 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_37 + var_207_30
					end
				end

				arg_204_1.text_.text = var_207_34
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022048", "story_v_out_413022.awb") ~= 0 then
					local var_207_38 = manager.audio:GetVoiceLength("story_v_out_413022", "413022048", "story_v_out_413022.awb") / 1000

					if var_207_38 + var_207_30 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_38 + var_207_30
					end

					if var_207_33.prefab_name ~= "" and arg_204_1.actors_[var_207_33.prefab_name] ~= nil then
						local var_207_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_33.prefab_name].transform, "story_v_out_413022", "413022048", "story_v_out_413022.awb")

						arg_204_1:RecordAudio("413022048", var_207_39)
						arg_204_1:RecordAudio("413022048", var_207_39)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_413022", "413022048", "story_v_out_413022.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_413022", "413022048", "story_v_out_413022.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_40 = math.max(var_207_31, arg_204_1.talkMaxDuration)

			if var_207_30 <= arg_204_1.time_ and arg_204_1.time_ < var_207_30 + var_207_40 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_30) / var_207_40

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_30 + var_207_40 and arg_204_1.time_ < var_207_30 + var_207_40 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
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

		arg_204_1:InitPlayNodeList()
	end,
	Play413022049 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 413022049
		arg_208_1.duration_ = 13.27

		local var_208_0 = {
			zh = 12.333,
			ja = 13.266
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
				arg_208_0:Play413022050(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["10097"].transform
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.var_.moveOldPos10097 = var_211_0.localPosition
				var_211_0.localScale = Vector3.New(1, 1, 1)

				arg_208_1:CheckSpriteTmpPos("10097", 3)

				local var_211_2 = var_211_0.childCount

				for iter_211_0 = 0, var_211_2 - 1 do
					local var_211_3 = var_211_0:GetChild(iter_211_0)

					if var_211_3.name == "" or not string.find(var_211_3.name, "split") then
						var_211_3.gameObject:SetActive(true)
					else
						var_211_3.gameObject:SetActive(false)
					end
				end
			end

			local var_211_4 = 0.001

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_4 then
				local var_211_5 = (arg_208_1.time_ - var_211_1) / var_211_4
				local var_211_6 = Vector3.New(0, -350, -180)

				var_211_0.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10097, var_211_6, var_211_5)
			end

			if arg_208_1.time_ >= var_211_1 + var_211_4 and arg_208_1.time_ < var_211_1 + var_211_4 + arg_211_0 then
				var_211_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_211_7 = arg_208_1.actors_["10094"].transform
			local var_211_8 = 0

			if var_211_8 < arg_208_1.time_ and arg_208_1.time_ <= var_211_8 + arg_211_0 then
				arg_208_1.var_.moveOldPos10094 = var_211_7.localPosition
				var_211_7.localScale = Vector3.New(1, 1, 1)

				arg_208_1:CheckSpriteTmpPos("10094", 0)

				local var_211_9 = var_211_7.childCount

				for iter_211_1 = 0, var_211_9 - 1 do
					local var_211_10 = var_211_7:GetChild(iter_211_1)

					if var_211_10.name == "" or not string.find(var_211_10.name, "split") then
						var_211_10.gameObject:SetActive(true)
					else
						var_211_10.gameObject:SetActive(false)
					end
				end
			end

			local var_211_11 = 0.001

			if var_211_8 <= arg_208_1.time_ and arg_208_1.time_ < var_211_8 + var_211_11 then
				local var_211_12 = (arg_208_1.time_ - var_211_8) / var_211_11
				local var_211_13 = Vector3.New(-5000, -340, -414)

				var_211_7.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10094, var_211_13, var_211_12)
			end

			if arg_208_1.time_ >= var_211_8 + var_211_11 and arg_208_1.time_ < var_211_8 + var_211_11 + arg_211_0 then
				var_211_7.localPosition = Vector3.New(-5000, -340, -414)
			end

			local var_211_14 = arg_208_1.actors_["10097"]
			local var_211_15 = 0

			if var_211_15 < arg_208_1.time_ and arg_208_1.time_ <= var_211_15 + arg_211_0 and not isNil(var_211_14) and arg_208_1.var_.actorSpriteComps10097 == nil then
				arg_208_1.var_.actorSpriteComps10097 = var_211_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_211_16 = 2

			if var_211_15 <= arg_208_1.time_ and arg_208_1.time_ < var_211_15 + var_211_16 and not isNil(var_211_14) then
				local var_211_17 = (arg_208_1.time_ - var_211_15) / var_211_16

				if arg_208_1.var_.actorSpriteComps10097 then
					for iter_211_2, iter_211_3 in pairs(arg_208_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_211_3 then
							if arg_208_1.isInRecall_ then
								local var_211_18 = Mathf.Lerp(iter_211_3.color.r, arg_208_1.hightColor1.r, var_211_17)
								local var_211_19 = Mathf.Lerp(iter_211_3.color.g, arg_208_1.hightColor1.g, var_211_17)
								local var_211_20 = Mathf.Lerp(iter_211_3.color.b, arg_208_1.hightColor1.b, var_211_17)

								iter_211_3.color = Color.New(var_211_18, var_211_19, var_211_20)
							else
								local var_211_21 = Mathf.Lerp(iter_211_3.color.r, 1, var_211_17)

								iter_211_3.color = Color.New(var_211_21, var_211_21, var_211_21)
							end
						end
					end
				end
			end

			if arg_208_1.time_ >= var_211_15 + var_211_16 and arg_208_1.time_ < var_211_15 + var_211_16 + arg_211_0 and not isNil(var_211_14) and arg_208_1.var_.actorSpriteComps10097 then
				for iter_211_4, iter_211_5 in pairs(arg_208_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_211_5 then
						if arg_208_1.isInRecall_ then
							iter_211_5.color = arg_208_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_211_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_208_1.var_.actorSpriteComps10097 = nil
			end

			local var_211_22 = arg_208_1.actors_["10094"]
			local var_211_23 = 0

			if var_211_23 < arg_208_1.time_ and arg_208_1.time_ <= var_211_23 + arg_211_0 and not isNil(var_211_22) and arg_208_1.var_.actorSpriteComps10094 == nil then
				arg_208_1.var_.actorSpriteComps10094 = var_211_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_211_24 = 2

			if var_211_23 <= arg_208_1.time_ and arg_208_1.time_ < var_211_23 + var_211_24 and not isNil(var_211_22) then
				local var_211_25 = (arg_208_1.time_ - var_211_23) / var_211_24

				if arg_208_1.var_.actorSpriteComps10094 then
					for iter_211_6, iter_211_7 in pairs(arg_208_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_211_7 then
							if arg_208_1.isInRecall_ then
								local var_211_26 = Mathf.Lerp(iter_211_7.color.r, arg_208_1.hightColor2.r, var_211_25)
								local var_211_27 = Mathf.Lerp(iter_211_7.color.g, arg_208_1.hightColor2.g, var_211_25)
								local var_211_28 = Mathf.Lerp(iter_211_7.color.b, arg_208_1.hightColor2.b, var_211_25)

								iter_211_7.color = Color.New(var_211_26, var_211_27, var_211_28)
							else
								local var_211_29 = Mathf.Lerp(iter_211_7.color.r, 0.5, var_211_25)

								iter_211_7.color = Color.New(var_211_29, var_211_29, var_211_29)
							end
						end
					end
				end
			end

			if arg_208_1.time_ >= var_211_23 + var_211_24 and arg_208_1.time_ < var_211_23 + var_211_24 + arg_211_0 and not isNil(var_211_22) and arg_208_1.var_.actorSpriteComps10094 then
				for iter_211_8, iter_211_9 in pairs(arg_208_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_211_9 then
						if arg_208_1.isInRecall_ then
							iter_211_9.color = arg_208_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_211_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_208_1.var_.actorSpriteComps10094 = nil
			end

			local var_211_30 = 0
			local var_211_31 = 1.075

			if var_211_30 < arg_208_1.time_ and arg_208_1.time_ <= var_211_30 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_32 = arg_208_1:FormatText(StoryNameCfg[1001].name)

				arg_208_1.leftNameTxt_.text = var_211_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_33 = arg_208_1:GetWordFromCfg(413022049)
				local var_211_34 = arg_208_1:FormatText(var_211_33.content)

				arg_208_1.text_.text = var_211_34

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_35 = 43
				local var_211_36 = utf8.len(var_211_34)
				local var_211_37 = var_211_35 <= 0 and var_211_31 or var_211_31 * (var_211_36 / var_211_35)

				if var_211_37 > 0 and var_211_31 < var_211_37 then
					arg_208_1.talkMaxDuration = var_211_37

					if var_211_37 + var_211_30 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_37 + var_211_30
					end
				end

				arg_208_1.text_.text = var_211_34
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022049", "story_v_out_413022.awb") ~= 0 then
					local var_211_38 = manager.audio:GetVoiceLength("story_v_out_413022", "413022049", "story_v_out_413022.awb") / 1000

					if var_211_38 + var_211_30 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_38 + var_211_30
					end

					if var_211_33.prefab_name ~= "" and arg_208_1.actors_[var_211_33.prefab_name] ~= nil then
						local var_211_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_33.prefab_name].transform, "story_v_out_413022", "413022049", "story_v_out_413022.awb")

						arg_208_1:RecordAudio("413022049", var_211_39)
						arg_208_1:RecordAudio("413022049", var_211_39)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_413022", "413022049", "story_v_out_413022.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_413022", "413022049", "story_v_out_413022.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_40 = math.max(var_211_31, arg_208_1.talkMaxDuration)

			if var_211_30 <= arg_208_1.time_ and arg_208_1.time_ < var_211_30 + var_211_40 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_30) / var_211_40

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_30 + var_211_40 and arg_208_1.time_ < var_211_30 + var_211_40 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_208_1:InitPlayNodeList()
	end,
	Play413022050 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 413022050
		arg_212_1.duration_ = 12.97

		local var_212_0 = {
			zh = 8.233,
			ja = 12.966
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play413022051(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 0
			local var_215_1 = 0.85

			if var_215_0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_2 = arg_212_1:FormatText(StoryNameCfg[1001].name)

				arg_212_1.leftNameTxt_.text = var_215_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_3 = arg_212_1:GetWordFromCfg(413022050)
				local var_215_4 = arg_212_1:FormatText(var_215_3.content)

				arg_212_1.text_.text = var_215_4

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_5 = 34
				local var_215_6 = utf8.len(var_215_4)
				local var_215_7 = var_215_5 <= 0 and var_215_1 or var_215_1 * (var_215_6 / var_215_5)

				if var_215_7 > 0 and var_215_1 < var_215_7 then
					arg_212_1.talkMaxDuration = var_215_7

					if var_215_7 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_7 + var_215_0
					end
				end

				arg_212_1.text_.text = var_215_4
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022050", "story_v_out_413022.awb") ~= 0 then
					local var_215_8 = manager.audio:GetVoiceLength("story_v_out_413022", "413022050", "story_v_out_413022.awb") / 1000

					if var_215_8 + var_215_0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_8 + var_215_0
					end

					if var_215_3.prefab_name ~= "" and arg_212_1.actors_[var_215_3.prefab_name] ~= nil then
						local var_215_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_3.prefab_name].transform, "story_v_out_413022", "413022050", "story_v_out_413022.awb")

						arg_212_1:RecordAudio("413022050", var_215_9)
						arg_212_1:RecordAudio("413022050", var_215_9)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_413022", "413022050", "story_v_out_413022.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_413022", "413022050", "story_v_out_413022.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_10 = math.max(var_215_1, arg_212_1.talkMaxDuration)

			if var_215_0 <= arg_212_1.time_ and arg_212_1.time_ < var_215_0 + var_215_10 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_0) / var_215_10

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_0 + var_215_10 and arg_212_1.time_ < var_215_0 + var_215_10 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play413022051 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 413022051
		arg_216_1.duration_ = 11.33

		local var_216_0 = {
			zh = 8.6,
			ja = 11.333
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
				arg_216_0:Play413022052(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 0
			local var_219_1 = 0.875

			if var_219_0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_2 = arg_216_1:FormatText(StoryNameCfg[1001].name)

				arg_216_1.leftNameTxt_.text = var_219_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_3 = arg_216_1:GetWordFromCfg(413022051)
				local var_219_4 = arg_216_1:FormatText(var_219_3.content)

				arg_216_1.text_.text = var_219_4

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022051", "story_v_out_413022.awb") ~= 0 then
					local var_219_8 = manager.audio:GetVoiceLength("story_v_out_413022", "413022051", "story_v_out_413022.awb") / 1000

					if var_219_8 + var_219_0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_8 + var_219_0
					end

					if var_219_3.prefab_name ~= "" and arg_216_1.actors_[var_219_3.prefab_name] ~= nil then
						local var_219_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_3.prefab_name].transform, "story_v_out_413022", "413022051", "story_v_out_413022.awb")

						arg_216_1:RecordAudio("413022051", var_219_9)
						arg_216_1:RecordAudio("413022051", var_219_9)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_413022", "413022051", "story_v_out_413022.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_413022", "413022051", "story_v_out_413022.awb")
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
	Play413022052 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 413022052
		arg_220_1.duration_ = 13.2

		local var_220_0 = {
			zh = 9.133,
			ja = 13.2
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
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play413022053(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = arg_220_1.actors_["10022"].transform
			local var_223_1 = 0

			if var_223_1 < arg_220_1.time_ and arg_220_1.time_ <= var_223_1 + arg_223_0 then
				arg_220_1.var_.moveOldPos10022 = var_223_0.localPosition
				var_223_0.localScale = Vector3.New(1, 1, 1)

				arg_220_1:CheckSpriteTmpPos("10022", 2)

				local var_223_2 = var_223_0.childCount

				for iter_223_0 = 0, var_223_2 - 1 do
					local var_223_3 = var_223_0:GetChild(iter_223_0)

					if var_223_3.name == "" or not string.find(var_223_3.name, "split") then
						var_223_3.gameObject:SetActive(true)
					else
						var_223_3.gameObject:SetActive(false)
					end
				end
			end

			local var_223_4 = 0.001

			if var_223_1 <= arg_220_1.time_ and arg_220_1.time_ < var_223_1 + var_223_4 then
				local var_223_5 = (arg_220_1.time_ - var_223_1) / var_223_4
				local var_223_6 = Vector3.New(-390, -315, -320)

				var_223_0.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos10022, var_223_6, var_223_5)
			end

			if arg_220_1.time_ >= var_223_1 + var_223_4 and arg_220_1.time_ < var_223_1 + var_223_4 + arg_223_0 then
				var_223_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_223_7 = arg_220_1.actors_["10097"].transform
			local var_223_8 = 0

			if var_223_8 < arg_220_1.time_ and arg_220_1.time_ <= var_223_8 + arg_223_0 then
				arg_220_1.var_.moveOldPos10097 = var_223_7.localPosition
				var_223_7.localScale = Vector3.New(1, 1, 1)

				arg_220_1:CheckSpriteTmpPos("10097", 4)

				local var_223_9 = var_223_7.childCount

				for iter_223_1 = 0, var_223_9 - 1 do
					local var_223_10 = var_223_7:GetChild(iter_223_1)

					if var_223_10.name == "" or not string.find(var_223_10.name, "split") then
						var_223_10.gameObject:SetActive(true)
					else
						var_223_10.gameObject:SetActive(false)
					end
				end
			end

			local var_223_11 = 0.001

			if var_223_8 <= arg_220_1.time_ and arg_220_1.time_ < var_223_8 + var_223_11 then
				local var_223_12 = (arg_220_1.time_ - var_223_8) / var_223_11
				local var_223_13 = Vector3.New(390, -350, -180)

				var_223_7.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos10097, var_223_13, var_223_12)
			end

			if arg_220_1.time_ >= var_223_8 + var_223_11 and arg_220_1.time_ < var_223_8 + var_223_11 + arg_223_0 then
				var_223_7.localPosition = Vector3.New(390, -350, -180)
			end

			local var_223_14 = arg_220_1.actors_["10022"]
			local var_223_15 = 0

			if var_223_15 < arg_220_1.time_ and arg_220_1.time_ <= var_223_15 + arg_223_0 and not isNil(var_223_14) and arg_220_1.var_.actorSpriteComps10022 == nil then
				arg_220_1.var_.actorSpriteComps10022 = var_223_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_16 = 2

			if var_223_15 <= arg_220_1.time_ and arg_220_1.time_ < var_223_15 + var_223_16 and not isNil(var_223_14) then
				local var_223_17 = (arg_220_1.time_ - var_223_15) / var_223_16

				if arg_220_1.var_.actorSpriteComps10022 then
					for iter_223_2, iter_223_3 in pairs(arg_220_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_223_3 then
							if arg_220_1.isInRecall_ then
								local var_223_18 = Mathf.Lerp(iter_223_3.color.r, arg_220_1.hightColor1.r, var_223_17)
								local var_223_19 = Mathf.Lerp(iter_223_3.color.g, arg_220_1.hightColor1.g, var_223_17)
								local var_223_20 = Mathf.Lerp(iter_223_3.color.b, arg_220_1.hightColor1.b, var_223_17)

								iter_223_3.color = Color.New(var_223_18, var_223_19, var_223_20)
							else
								local var_223_21 = Mathf.Lerp(iter_223_3.color.r, 1, var_223_17)

								iter_223_3.color = Color.New(var_223_21, var_223_21, var_223_21)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= var_223_15 + var_223_16 and arg_220_1.time_ < var_223_15 + var_223_16 + arg_223_0 and not isNil(var_223_14) and arg_220_1.var_.actorSpriteComps10022 then
				for iter_223_4, iter_223_5 in pairs(arg_220_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_223_5 then
						if arg_220_1.isInRecall_ then
							iter_223_5.color = arg_220_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_223_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_220_1.var_.actorSpriteComps10022 = nil
			end

			local var_223_22 = arg_220_1.actors_["10097"]
			local var_223_23 = 0

			if var_223_23 < arg_220_1.time_ and arg_220_1.time_ <= var_223_23 + arg_223_0 and not isNil(var_223_22) and arg_220_1.var_.actorSpriteComps10097 == nil then
				arg_220_1.var_.actorSpriteComps10097 = var_223_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_24 = 2

			if var_223_23 <= arg_220_1.time_ and arg_220_1.time_ < var_223_23 + var_223_24 and not isNil(var_223_22) then
				local var_223_25 = (arg_220_1.time_ - var_223_23) / var_223_24

				if arg_220_1.var_.actorSpriteComps10097 then
					for iter_223_6, iter_223_7 in pairs(arg_220_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_223_7 then
							if arg_220_1.isInRecall_ then
								local var_223_26 = Mathf.Lerp(iter_223_7.color.r, arg_220_1.hightColor2.r, var_223_25)
								local var_223_27 = Mathf.Lerp(iter_223_7.color.g, arg_220_1.hightColor2.g, var_223_25)
								local var_223_28 = Mathf.Lerp(iter_223_7.color.b, arg_220_1.hightColor2.b, var_223_25)

								iter_223_7.color = Color.New(var_223_26, var_223_27, var_223_28)
							else
								local var_223_29 = Mathf.Lerp(iter_223_7.color.r, 0.5, var_223_25)

								iter_223_7.color = Color.New(var_223_29, var_223_29, var_223_29)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= var_223_23 + var_223_24 and arg_220_1.time_ < var_223_23 + var_223_24 + arg_223_0 and not isNil(var_223_22) and arg_220_1.var_.actorSpriteComps10097 then
				for iter_223_8, iter_223_9 in pairs(arg_220_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_223_9 then
						if arg_220_1.isInRecall_ then
							iter_223_9.color = arg_220_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_223_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_220_1.var_.actorSpriteComps10097 = nil
			end

			local var_223_30 = 0
			local var_223_31 = 1.25

			if var_223_30 < arg_220_1.time_ and arg_220_1.time_ <= var_223_30 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_32 = arg_220_1:FormatText(StoryNameCfg[614].name)

				arg_220_1.leftNameTxt_.text = var_223_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_33 = arg_220_1:GetWordFromCfg(413022052)
				local var_223_34 = arg_220_1:FormatText(var_223_33.content)

				arg_220_1.text_.text = var_223_34

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_35 = 50
				local var_223_36 = utf8.len(var_223_34)
				local var_223_37 = var_223_35 <= 0 and var_223_31 or var_223_31 * (var_223_36 / var_223_35)

				if var_223_37 > 0 and var_223_31 < var_223_37 then
					arg_220_1.talkMaxDuration = var_223_37

					if var_223_37 + var_223_30 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_37 + var_223_30
					end
				end

				arg_220_1.text_.text = var_223_34
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022052", "story_v_out_413022.awb") ~= 0 then
					local var_223_38 = manager.audio:GetVoiceLength("story_v_out_413022", "413022052", "story_v_out_413022.awb") / 1000

					if var_223_38 + var_223_30 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_38 + var_223_30
					end

					if var_223_33.prefab_name ~= "" and arg_220_1.actors_[var_223_33.prefab_name] ~= nil then
						local var_223_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_33.prefab_name].transform, "story_v_out_413022", "413022052", "story_v_out_413022.awb")

						arg_220_1:RecordAudio("413022052", var_223_39)
						arg_220_1:RecordAudio("413022052", var_223_39)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_413022", "413022052", "story_v_out_413022.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_413022", "413022052", "story_v_out_413022.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_40 = math.max(var_223_31, arg_220_1.talkMaxDuration)

			if var_223_30 <= arg_220_1.time_ and arg_220_1.time_ < var_223_30 + var_223_40 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_30) / var_223_40

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_30 + var_223_40 and arg_220_1.time_ < var_223_30 + var_223_40 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
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
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play413022053 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 413022053
		arg_224_1.duration_ = 11.4

		local var_224_0 = {
			zh = 9.866,
			ja = 11.4
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play413022054(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = arg_224_1.actors_["10097"].transform
			local var_227_1 = 0

			if var_227_1 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 then
				arg_224_1.var_.moveOldPos10097 = var_227_0.localPosition
				var_227_0.localScale = Vector3.New(1, 1, 1)

				arg_224_1:CheckSpriteTmpPos("10097", 4)

				local var_227_2 = var_227_0.childCount

				for iter_227_0 = 0, var_227_2 - 1 do
					local var_227_3 = var_227_0:GetChild(iter_227_0)

					if var_227_3.name == "" or not string.find(var_227_3.name, "split") then
						var_227_3.gameObject:SetActive(true)
					else
						var_227_3.gameObject:SetActive(false)
					end
				end
			end

			local var_227_4 = 0.001

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_4 then
				local var_227_5 = (arg_224_1.time_ - var_227_1) / var_227_4
				local var_227_6 = Vector3.New(390, -350, -180)

				var_227_0.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos10097, var_227_6, var_227_5)
			end

			if arg_224_1.time_ >= var_227_1 + var_227_4 and arg_224_1.time_ < var_227_1 + var_227_4 + arg_227_0 then
				var_227_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_227_7 = arg_224_1.actors_["10022"]
			local var_227_8 = 0

			if var_227_8 < arg_224_1.time_ and arg_224_1.time_ <= var_227_8 + arg_227_0 and not isNil(var_227_7) and arg_224_1.var_.actorSpriteComps10022 == nil then
				arg_224_1.var_.actorSpriteComps10022 = var_227_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_9 = 2

			if var_227_8 <= arg_224_1.time_ and arg_224_1.time_ < var_227_8 + var_227_9 and not isNil(var_227_7) then
				local var_227_10 = (arg_224_1.time_ - var_227_8) / var_227_9

				if arg_224_1.var_.actorSpriteComps10022 then
					for iter_227_1, iter_227_2 in pairs(arg_224_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_227_2 then
							if arg_224_1.isInRecall_ then
								local var_227_11 = Mathf.Lerp(iter_227_2.color.r, arg_224_1.hightColor2.r, var_227_10)
								local var_227_12 = Mathf.Lerp(iter_227_2.color.g, arg_224_1.hightColor2.g, var_227_10)
								local var_227_13 = Mathf.Lerp(iter_227_2.color.b, arg_224_1.hightColor2.b, var_227_10)

								iter_227_2.color = Color.New(var_227_11, var_227_12, var_227_13)
							else
								local var_227_14 = Mathf.Lerp(iter_227_2.color.r, 0.5, var_227_10)

								iter_227_2.color = Color.New(var_227_14, var_227_14, var_227_14)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= var_227_8 + var_227_9 and arg_224_1.time_ < var_227_8 + var_227_9 + arg_227_0 and not isNil(var_227_7) and arg_224_1.var_.actorSpriteComps10022 then
				for iter_227_3, iter_227_4 in pairs(arg_224_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_227_4 then
						if arg_224_1.isInRecall_ then
							iter_227_4.color = arg_224_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_227_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_224_1.var_.actorSpriteComps10022 = nil
			end

			local var_227_15 = arg_224_1.actors_["10097"]
			local var_227_16 = 0

			if var_227_16 < arg_224_1.time_ and arg_224_1.time_ <= var_227_16 + arg_227_0 and not isNil(var_227_15) and arg_224_1.var_.actorSpriteComps10097 == nil then
				arg_224_1.var_.actorSpriteComps10097 = var_227_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_17 = 2

			if var_227_16 <= arg_224_1.time_ and arg_224_1.time_ < var_227_16 + var_227_17 and not isNil(var_227_15) then
				local var_227_18 = (arg_224_1.time_ - var_227_16) / var_227_17

				if arg_224_1.var_.actorSpriteComps10097 then
					for iter_227_5, iter_227_6 in pairs(arg_224_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_227_6 then
							if arg_224_1.isInRecall_ then
								local var_227_19 = Mathf.Lerp(iter_227_6.color.r, arg_224_1.hightColor1.r, var_227_18)
								local var_227_20 = Mathf.Lerp(iter_227_6.color.g, arg_224_1.hightColor1.g, var_227_18)
								local var_227_21 = Mathf.Lerp(iter_227_6.color.b, arg_224_1.hightColor1.b, var_227_18)

								iter_227_6.color = Color.New(var_227_19, var_227_20, var_227_21)
							else
								local var_227_22 = Mathf.Lerp(iter_227_6.color.r, 1, var_227_18)

								iter_227_6.color = Color.New(var_227_22, var_227_22, var_227_22)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= var_227_16 + var_227_17 and arg_224_1.time_ < var_227_16 + var_227_17 + arg_227_0 and not isNil(var_227_15) and arg_224_1.var_.actorSpriteComps10097 then
				for iter_227_7, iter_227_8 in pairs(arg_224_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_227_8 then
						if arg_224_1.isInRecall_ then
							iter_227_8.color = arg_224_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_227_8.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_224_1.var_.actorSpriteComps10097 = nil
			end

			local var_227_23 = 0
			local var_227_24 = 0.75

			if var_227_23 < arg_224_1.time_ and arg_224_1.time_ <= var_227_23 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_25 = arg_224_1:FormatText(StoryNameCfg[1001].name)

				arg_224_1.leftNameTxt_.text = var_227_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_26 = arg_224_1:GetWordFromCfg(413022053)
				local var_227_27 = arg_224_1:FormatText(var_227_26.content)

				arg_224_1.text_.text = var_227_27

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_28 = 30
				local var_227_29 = utf8.len(var_227_27)
				local var_227_30 = var_227_28 <= 0 and var_227_24 or var_227_24 * (var_227_29 / var_227_28)

				if var_227_30 > 0 and var_227_24 < var_227_30 then
					arg_224_1.talkMaxDuration = var_227_30

					if var_227_30 + var_227_23 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_30 + var_227_23
					end
				end

				arg_224_1.text_.text = var_227_27
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022053", "story_v_out_413022.awb") ~= 0 then
					local var_227_31 = manager.audio:GetVoiceLength("story_v_out_413022", "413022053", "story_v_out_413022.awb") / 1000

					if var_227_31 + var_227_23 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_31 + var_227_23
					end

					if var_227_26.prefab_name ~= "" and arg_224_1.actors_[var_227_26.prefab_name] ~= nil then
						local var_227_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_26.prefab_name].transform, "story_v_out_413022", "413022053", "story_v_out_413022.awb")

						arg_224_1:RecordAudio("413022053", var_227_32)
						arg_224_1:RecordAudio("413022053", var_227_32)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_413022", "413022053", "story_v_out_413022.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_413022", "413022053", "story_v_out_413022.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_33 = math.max(var_227_24, arg_224_1.talkMaxDuration)

			if var_227_23 <= arg_224_1.time_ and arg_224_1.time_ < var_227_23 + var_227_33 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_23) / var_227_33

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_23 + var_227_33 and arg_224_1.time_ < var_227_23 + var_227_33 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play413022054 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 413022054
		arg_228_1.duration_ = 4.1

		local var_228_0 = {
			zh = 2.4,
			ja = 4.1
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play413022055(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["10022"].transform
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1.var_.moveOldPos10022 = var_231_0.localPosition
				var_231_0.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("10022", 0)

				local var_231_2 = var_231_0.childCount

				for iter_231_0 = 0, var_231_2 - 1 do
					local var_231_3 = var_231_0:GetChild(iter_231_0)

					if var_231_3.name == "" or not string.find(var_231_3.name, "split") then
						var_231_3.gameObject:SetActive(true)
					else
						var_231_3.gameObject:SetActive(false)
					end
				end
			end

			local var_231_4 = 0.001

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_4 then
				local var_231_5 = (arg_228_1.time_ - var_231_1) / var_231_4
				local var_231_6 = Vector3.New(-1500, -350, -180)

				var_231_0.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10022, var_231_6, var_231_5)
			end

			if arg_228_1.time_ >= var_231_1 + var_231_4 and arg_228_1.time_ < var_231_1 + var_231_4 + arg_231_0 then
				var_231_0.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_231_7 = arg_228_1.actors_["10097"].transform
			local var_231_8 = 0

			if var_231_8 < arg_228_1.time_ and arg_228_1.time_ <= var_231_8 + arg_231_0 then
				arg_228_1.var_.moveOldPos10097 = var_231_7.localPosition
				var_231_7.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("10097", 0)

				local var_231_9 = var_231_7.childCount

				for iter_231_1 = 0, var_231_9 - 1 do
					local var_231_10 = var_231_7:GetChild(iter_231_1)

					if var_231_10.name == "" or not string.find(var_231_10.name, "split") then
						var_231_10.gameObject:SetActive(true)
					else
						var_231_10.gameObject:SetActive(false)
					end
				end
			end

			local var_231_11 = 0.001

			if var_231_8 <= arg_228_1.time_ and arg_228_1.time_ < var_231_8 + var_231_11 then
				local var_231_12 = (arg_228_1.time_ - var_231_8) / var_231_11
				local var_231_13 = Vector3.New(-1500, -350, -180)

				var_231_7.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10097, var_231_13, var_231_12)
			end

			if arg_228_1.time_ >= var_231_8 + var_231_11 and arg_228_1.time_ < var_231_8 + var_231_11 + arg_231_0 then
				var_231_7.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_231_14 = arg_228_1.actors_["10092"].transform
			local var_231_15 = 0

			if var_231_15 < arg_228_1.time_ and arg_228_1.time_ <= var_231_15 + arg_231_0 then
				arg_228_1.var_.moveOldPos10092 = var_231_14.localPosition
				var_231_14.localScale = Vector3.New(1, 1, 1)

				arg_228_1:CheckSpriteTmpPos("10092", 3)

				local var_231_16 = var_231_14.childCount

				for iter_231_2 = 0, var_231_16 - 1 do
					local var_231_17 = var_231_14:GetChild(iter_231_2)

					if var_231_17.name == "split_5" or not string.find(var_231_17.name, "split") then
						var_231_17.gameObject:SetActive(true)
					else
						var_231_17.gameObject:SetActive(false)
					end
				end
			end

			local var_231_18 = 0.001

			if var_231_15 <= arg_228_1.time_ and arg_228_1.time_ < var_231_15 + var_231_18 then
				local var_231_19 = (arg_228_1.time_ - var_231_15) / var_231_18
				local var_231_20 = Vector3.New(0, -350, -180)

				var_231_14.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10092, var_231_20, var_231_19)
			end

			if arg_228_1.time_ >= var_231_15 + var_231_18 and arg_228_1.time_ < var_231_15 + var_231_18 + arg_231_0 then
				var_231_14.localPosition = Vector3.New(0, -350, -180)
			end

			local var_231_21 = arg_228_1.actors_["10022"]
			local var_231_22 = 0

			if var_231_22 < arg_228_1.time_ and arg_228_1.time_ <= var_231_22 + arg_231_0 and not isNil(var_231_21) and arg_228_1.var_.actorSpriteComps10022 == nil then
				arg_228_1.var_.actorSpriteComps10022 = var_231_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_23 = 2

			if var_231_22 <= arg_228_1.time_ and arg_228_1.time_ < var_231_22 + var_231_23 and not isNil(var_231_21) then
				local var_231_24 = (arg_228_1.time_ - var_231_22) / var_231_23

				if arg_228_1.var_.actorSpriteComps10022 then
					for iter_231_3, iter_231_4 in pairs(arg_228_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_231_4 then
							if arg_228_1.isInRecall_ then
								local var_231_25 = Mathf.Lerp(iter_231_4.color.r, arg_228_1.hightColor2.r, var_231_24)
								local var_231_26 = Mathf.Lerp(iter_231_4.color.g, arg_228_1.hightColor2.g, var_231_24)
								local var_231_27 = Mathf.Lerp(iter_231_4.color.b, arg_228_1.hightColor2.b, var_231_24)

								iter_231_4.color = Color.New(var_231_25, var_231_26, var_231_27)
							else
								local var_231_28 = Mathf.Lerp(iter_231_4.color.r, 0.5, var_231_24)

								iter_231_4.color = Color.New(var_231_28, var_231_28, var_231_28)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= var_231_22 + var_231_23 and arg_228_1.time_ < var_231_22 + var_231_23 + arg_231_0 and not isNil(var_231_21) and arg_228_1.var_.actorSpriteComps10022 then
				for iter_231_5, iter_231_6 in pairs(arg_228_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_231_6 then
						if arg_228_1.isInRecall_ then
							iter_231_6.color = arg_228_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_231_6.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_228_1.var_.actorSpriteComps10022 = nil
			end

			local var_231_29 = arg_228_1.actors_["10097"]
			local var_231_30 = 0

			if var_231_30 < arg_228_1.time_ and arg_228_1.time_ <= var_231_30 + arg_231_0 and not isNil(var_231_29) and arg_228_1.var_.actorSpriteComps10097 == nil then
				arg_228_1.var_.actorSpriteComps10097 = var_231_29:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_31 = 2

			if var_231_30 <= arg_228_1.time_ and arg_228_1.time_ < var_231_30 + var_231_31 and not isNil(var_231_29) then
				local var_231_32 = (arg_228_1.time_ - var_231_30) / var_231_31

				if arg_228_1.var_.actorSpriteComps10097 then
					for iter_231_7, iter_231_8 in pairs(arg_228_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_231_8 then
							if arg_228_1.isInRecall_ then
								local var_231_33 = Mathf.Lerp(iter_231_8.color.r, arg_228_1.hightColor2.r, var_231_32)
								local var_231_34 = Mathf.Lerp(iter_231_8.color.g, arg_228_1.hightColor2.g, var_231_32)
								local var_231_35 = Mathf.Lerp(iter_231_8.color.b, arg_228_1.hightColor2.b, var_231_32)

								iter_231_8.color = Color.New(var_231_33, var_231_34, var_231_35)
							else
								local var_231_36 = Mathf.Lerp(iter_231_8.color.r, 0.5, var_231_32)

								iter_231_8.color = Color.New(var_231_36, var_231_36, var_231_36)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= var_231_30 + var_231_31 and arg_228_1.time_ < var_231_30 + var_231_31 + arg_231_0 and not isNil(var_231_29) and arg_228_1.var_.actorSpriteComps10097 then
				for iter_231_9, iter_231_10 in pairs(arg_228_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_231_10 then
						if arg_228_1.isInRecall_ then
							iter_231_10.color = arg_228_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_231_10.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_228_1.var_.actorSpriteComps10097 = nil
			end

			local var_231_37 = arg_228_1.actors_["10092"]
			local var_231_38 = 0

			if var_231_38 < arg_228_1.time_ and arg_228_1.time_ <= var_231_38 + arg_231_0 and not isNil(var_231_37) and arg_228_1.var_.actorSpriteComps10092 == nil then
				arg_228_1.var_.actorSpriteComps10092 = var_231_37:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_39 = 2

			if var_231_38 <= arg_228_1.time_ and arg_228_1.time_ < var_231_38 + var_231_39 and not isNil(var_231_37) then
				local var_231_40 = (arg_228_1.time_ - var_231_38) / var_231_39

				if arg_228_1.var_.actorSpriteComps10092 then
					for iter_231_11, iter_231_12 in pairs(arg_228_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_231_12 then
							if arg_228_1.isInRecall_ then
								local var_231_41 = Mathf.Lerp(iter_231_12.color.r, arg_228_1.hightColor1.r, var_231_40)
								local var_231_42 = Mathf.Lerp(iter_231_12.color.g, arg_228_1.hightColor1.g, var_231_40)
								local var_231_43 = Mathf.Lerp(iter_231_12.color.b, arg_228_1.hightColor1.b, var_231_40)

								iter_231_12.color = Color.New(var_231_41, var_231_42, var_231_43)
							else
								local var_231_44 = Mathf.Lerp(iter_231_12.color.r, 1, var_231_40)

								iter_231_12.color = Color.New(var_231_44, var_231_44, var_231_44)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= var_231_38 + var_231_39 and arg_228_1.time_ < var_231_38 + var_231_39 + arg_231_0 and not isNil(var_231_37) and arg_228_1.var_.actorSpriteComps10092 then
				for iter_231_13, iter_231_14 in pairs(arg_228_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_231_14 then
						if arg_228_1.isInRecall_ then
							iter_231_14.color = arg_228_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_231_14.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_228_1.var_.actorSpriteComps10092 = nil
			end

			local var_231_45 = 0
			local var_231_46 = 0.275

			if var_231_45 < arg_228_1.time_ and arg_228_1.time_ <= var_231_45 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_47 = arg_228_1:FormatText(StoryNameCfg[996].name)

				arg_228_1.leftNameTxt_.text = var_231_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_48 = arg_228_1:GetWordFromCfg(413022054)
				local var_231_49 = arg_228_1:FormatText(var_231_48.content)

				arg_228_1.text_.text = var_231_49

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_50 = 11
				local var_231_51 = utf8.len(var_231_49)
				local var_231_52 = var_231_50 <= 0 and var_231_46 or var_231_46 * (var_231_51 / var_231_50)

				if var_231_52 > 0 and var_231_46 < var_231_52 then
					arg_228_1.talkMaxDuration = var_231_52

					if var_231_52 + var_231_45 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_52 + var_231_45
					end
				end

				arg_228_1.text_.text = var_231_49
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022054", "story_v_out_413022.awb") ~= 0 then
					local var_231_53 = manager.audio:GetVoiceLength("story_v_out_413022", "413022054", "story_v_out_413022.awb") / 1000

					if var_231_53 + var_231_45 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_53 + var_231_45
					end

					if var_231_48.prefab_name ~= "" and arg_228_1.actors_[var_231_48.prefab_name] ~= nil then
						local var_231_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_48.prefab_name].transform, "story_v_out_413022", "413022054", "story_v_out_413022.awb")

						arg_228_1:RecordAudio("413022054", var_231_54)
						arg_228_1:RecordAudio("413022054", var_231_54)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_413022", "413022054", "story_v_out_413022.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_413022", "413022054", "story_v_out_413022.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_55 = math.max(var_231_46, arg_228_1.talkMaxDuration)

			if var_231_45 <= arg_228_1.time_ and arg_228_1.time_ < var_231_45 + var_231_55 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_45) / var_231_55

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_45 + var_231_55 and arg_228_1.time_ < var_231_45 + var_231_55 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
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
				actorName = "10097",
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

		arg_228_1:InitPlayNodeList()
	end,
	Play413022055 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 413022055
		arg_232_1.duration_ = 8.1

		local var_232_0 = {
			zh = 6.133,
			ja = 8.1
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play413022056(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["10022"].transform
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.var_.moveOldPos10022 = var_235_0.localPosition
				var_235_0.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("10022", 3)

				local var_235_2 = var_235_0.childCount

				for iter_235_0 = 0, var_235_2 - 1 do
					local var_235_3 = var_235_0:GetChild(iter_235_0)

					if var_235_3.name == "split_3" or not string.find(var_235_3.name, "split") then
						var_235_3.gameObject:SetActive(true)
					else
						var_235_3.gameObject:SetActive(false)
					end
				end
			end

			local var_235_4 = 0.001

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_4 then
				local var_235_5 = (arg_232_1.time_ - var_235_1) / var_235_4
				local var_235_6 = Vector3.New(0, -315, -320)

				var_235_0.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10022, var_235_6, var_235_5)
			end

			if arg_232_1.time_ >= var_235_1 + var_235_4 and arg_232_1.time_ < var_235_1 + var_235_4 + arg_235_0 then
				var_235_0.localPosition = Vector3.New(0, -315, -320)
			end

			local var_235_7 = arg_232_1.actors_["10092"].transform
			local var_235_8 = 0

			if var_235_8 < arg_232_1.time_ and arg_232_1.time_ <= var_235_8 + arg_235_0 then
				arg_232_1.var_.moveOldPos10092 = var_235_7.localPosition
				var_235_7.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("10092", 7)

				local var_235_9 = var_235_7.childCount

				for iter_235_1 = 0, var_235_9 - 1 do
					local var_235_10 = var_235_7:GetChild(iter_235_1)

					if var_235_10.name == "" or not string.find(var_235_10.name, "split") then
						var_235_10.gameObject:SetActive(true)
					else
						var_235_10.gameObject:SetActive(false)
					end
				end
			end

			local var_235_11 = 0.001

			if var_235_8 <= arg_232_1.time_ and arg_232_1.time_ < var_235_8 + var_235_11 then
				local var_235_12 = (arg_232_1.time_ - var_235_8) / var_235_11
				local var_235_13 = Vector3.New(0, -2000, -180)

				var_235_7.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10092, var_235_13, var_235_12)
			end

			if arg_232_1.time_ >= var_235_8 + var_235_11 and arg_232_1.time_ < var_235_8 + var_235_11 + arg_235_0 then
				var_235_7.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_235_14 = arg_232_1.actors_["10022"]
			local var_235_15 = 0

			if var_235_15 < arg_232_1.time_ and arg_232_1.time_ <= var_235_15 + arg_235_0 and not isNil(var_235_14) and arg_232_1.var_.actorSpriteComps10022 == nil then
				arg_232_1.var_.actorSpriteComps10022 = var_235_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_16 = 2

			if var_235_15 <= arg_232_1.time_ and arg_232_1.time_ < var_235_15 + var_235_16 and not isNil(var_235_14) then
				local var_235_17 = (arg_232_1.time_ - var_235_15) / var_235_16

				if arg_232_1.var_.actorSpriteComps10022 then
					for iter_235_2, iter_235_3 in pairs(arg_232_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_235_3 then
							if arg_232_1.isInRecall_ then
								local var_235_18 = Mathf.Lerp(iter_235_3.color.r, arg_232_1.hightColor1.r, var_235_17)
								local var_235_19 = Mathf.Lerp(iter_235_3.color.g, arg_232_1.hightColor1.g, var_235_17)
								local var_235_20 = Mathf.Lerp(iter_235_3.color.b, arg_232_1.hightColor1.b, var_235_17)

								iter_235_3.color = Color.New(var_235_18, var_235_19, var_235_20)
							else
								local var_235_21 = Mathf.Lerp(iter_235_3.color.r, 1, var_235_17)

								iter_235_3.color = Color.New(var_235_21, var_235_21, var_235_21)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= var_235_15 + var_235_16 and arg_232_1.time_ < var_235_15 + var_235_16 + arg_235_0 and not isNil(var_235_14) and arg_232_1.var_.actorSpriteComps10022 then
				for iter_235_4, iter_235_5 in pairs(arg_232_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_235_5 then
						if arg_232_1.isInRecall_ then
							iter_235_5.color = arg_232_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_235_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_232_1.var_.actorSpriteComps10022 = nil
			end

			local var_235_22 = arg_232_1.actors_["10092"]
			local var_235_23 = 0

			if var_235_23 < arg_232_1.time_ and arg_232_1.time_ <= var_235_23 + arg_235_0 and not isNil(var_235_22) and arg_232_1.var_.actorSpriteComps10092 == nil then
				arg_232_1.var_.actorSpriteComps10092 = var_235_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_235_24 = 2

			if var_235_23 <= arg_232_1.time_ and arg_232_1.time_ < var_235_23 + var_235_24 and not isNil(var_235_22) then
				local var_235_25 = (arg_232_1.time_ - var_235_23) / var_235_24

				if arg_232_1.var_.actorSpriteComps10092 then
					for iter_235_6, iter_235_7 in pairs(arg_232_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_235_7 then
							if arg_232_1.isInRecall_ then
								local var_235_26 = Mathf.Lerp(iter_235_7.color.r, arg_232_1.hightColor2.r, var_235_25)
								local var_235_27 = Mathf.Lerp(iter_235_7.color.g, arg_232_1.hightColor2.g, var_235_25)
								local var_235_28 = Mathf.Lerp(iter_235_7.color.b, arg_232_1.hightColor2.b, var_235_25)

								iter_235_7.color = Color.New(var_235_26, var_235_27, var_235_28)
							else
								local var_235_29 = Mathf.Lerp(iter_235_7.color.r, 0.5, var_235_25)

								iter_235_7.color = Color.New(var_235_29, var_235_29, var_235_29)
							end
						end
					end
				end
			end

			if arg_232_1.time_ >= var_235_23 + var_235_24 and arg_232_1.time_ < var_235_23 + var_235_24 + arg_235_0 and not isNil(var_235_22) and arg_232_1.var_.actorSpriteComps10092 then
				for iter_235_8, iter_235_9 in pairs(arg_232_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_235_9 then
						if arg_232_1.isInRecall_ then
							iter_235_9.color = arg_232_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_235_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_232_1.var_.actorSpriteComps10092 = nil
			end

			local var_235_30 = 0
			local var_235_31 = 0.85

			if var_235_30 < arg_232_1.time_ and arg_232_1.time_ <= var_235_30 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_32 = arg_232_1:FormatText(StoryNameCfg[614].name)

				arg_232_1.leftNameTxt_.text = var_235_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_33 = arg_232_1:GetWordFromCfg(413022055)
				local var_235_34 = arg_232_1:FormatText(var_235_33.content)

				arg_232_1.text_.text = var_235_34

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_35 = 34
				local var_235_36 = utf8.len(var_235_34)
				local var_235_37 = var_235_35 <= 0 and var_235_31 or var_235_31 * (var_235_36 / var_235_35)

				if var_235_37 > 0 and var_235_31 < var_235_37 then
					arg_232_1.talkMaxDuration = var_235_37

					if var_235_37 + var_235_30 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_37 + var_235_30
					end
				end

				arg_232_1.text_.text = var_235_34
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022055", "story_v_out_413022.awb") ~= 0 then
					local var_235_38 = manager.audio:GetVoiceLength("story_v_out_413022", "413022055", "story_v_out_413022.awb") / 1000

					if var_235_38 + var_235_30 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_38 + var_235_30
					end

					if var_235_33.prefab_name ~= "" and arg_232_1.actors_[var_235_33.prefab_name] ~= nil then
						local var_235_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_33.prefab_name].transform, "story_v_out_413022", "413022055", "story_v_out_413022.awb")

						arg_232_1:RecordAudio("413022055", var_235_39)
						arg_232_1:RecordAudio("413022055", var_235_39)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_413022", "413022055", "story_v_out_413022.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_413022", "413022055", "story_v_out_413022.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_40 = math.max(var_235_31, arg_232_1.talkMaxDuration)

			if var_235_30 <= arg_232_1.time_ and arg_232_1.time_ < var_235_30 + var_235_40 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_30) / var_235_40

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_30 + var_235_40 and arg_232_1.time_ < var_235_30 + var_235_40 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
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
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play413022056 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 413022056
		arg_236_1.duration_ = 13.6

		local var_236_0 = {
			zh = 13.6,
			ja = 12.4
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
				arg_236_0:Play413022057(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["10097"].transform
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 then
				arg_236_1.var_.moveOldPos10097 = var_239_0.localPosition
				var_239_0.localScale = Vector3.New(1, 1, 1)

				arg_236_1:CheckSpriteTmpPos("10097", 3)

				local var_239_2 = var_239_0.childCount

				for iter_239_0 = 0, var_239_2 - 1 do
					local var_239_3 = var_239_0:GetChild(iter_239_0)

					if var_239_3.name == "split_2" or not string.find(var_239_3.name, "split") then
						var_239_3.gameObject:SetActive(true)
					else
						var_239_3.gameObject:SetActive(false)
					end
				end
			end

			local var_239_4 = 0.001

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_4 then
				local var_239_5 = (arg_236_1.time_ - var_239_1) / var_239_4
				local var_239_6 = Vector3.New(0, -350, -180)

				var_239_0.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10097, var_239_6, var_239_5)
			end

			if arg_236_1.time_ >= var_239_1 + var_239_4 and arg_236_1.time_ < var_239_1 + var_239_4 + arg_239_0 then
				var_239_0.localPosition = Vector3.New(0, -350, -180)
			end

			local var_239_7 = arg_236_1.actors_["10097"]
			local var_239_8 = 0

			if var_239_8 < arg_236_1.time_ and arg_236_1.time_ <= var_239_8 + arg_239_0 and not isNil(var_239_7) and arg_236_1.var_.actorSpriteComps10097 == nil then
				arg_236_1.var_.actorSpriteComps10097 = var_239_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_9 = 2

			if var_239_8 <= arg_236_1.time_ and arg_236_1.time_ < var_239_8 + var_239_9 and not isNil(var_239_7) then
				local var_239_10 = (arg_236_1.time_ - var_239_8) / var_239_9

				if arg_236_1.var_.actorSpriteComps10097 then
					for iter_239_1, iter_239_2 in pairs(arg_236_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_239_2 then
							if arg_236_1.isInRecall_ then
								local var_239_11 = Mathf.Lerp(iter_239_2.color.r, arg_236_1.hightColor1.r, var_239_10)
								local var_239_12 = Mathf.Lerp(iter_239_2.color.g, arg_236_1.hightColor1.g, var_239_10)
								local var_239_13 = Mathf.Lerp(iter_239_2.color.b, arg_236_1.hightColor1.b, var_239_10)

								iter_239_2.color = Color.New(var_239_11, var_239_12, var_239_13)
							else
								local var_239_14 = Mathf.Lerp(iter_239_2.color.r, 1, var_239_10)

								iter_239_2.color = Color.New(var_239_14, var_239_14, var_239_14)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= var_239_8 + var_239_9 and arg_236_1.time_ < var_239_8 + var_239_9 + arg_239_0 and not isNil(var_239_7) and arg_236_1.var_.actorSpriteComps10097 then
				for iter_239_3, iter_239_4 in pairs(arg_236_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_239_4 then
						if arg_236_1.isInRecall_ then
							iter_239_4.color = arg_236_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_239_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_236_1.var_.actorSpriteComps10097 = nil
			end

			local var_239_15 = arg_236_1.actors_["10022"]
			local var_239_16 = 0

			if var_239_16 < arg_236_1.time_ and arg_236_1.time_ <= var_239_16 + arg_239_0 and not isNil(var_239_15) and arg_236_1.var_.actorSpriteComps10022 == nil then
				arg_236_1.var_.actorSpriteComps10022 = var_239_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_239_17 = 2

			if var_239_16 <= arg_236_1.time_ and arg_236_1.time_ < var_239_16 + var_239_17 and not isNil(var_239_15) then
				local var_239_18 = (arg_236_1.time_ - var_239_16) / var_239_17

				if arg_236_1.var_.actorSpriteComps10022 then
					for iter_239_5, iter_239_6 in pairs(arg_236_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_239_6 then
							if arg_236_1.isInRecall_ then
								local var_239_19 = Mathf.Lerp(iter_239_6.color.r, arg_236_1.hightColor2.r, var_239_18)
								local var_239_20 = Mathf.Lerp(iter_239_6.color.g, arg_236_1.hightColor2.g, var_239_18)
								local var_239_21 = Mathf.Lerp(iter_239_6.color.b, arg_236_1.hightColor2.b, var_239_18)

								iter_239_6.color = Color.New(var_239_19, var_239_20, var_239_21)
							else
								local var_239_22 = Mathf.Lerp(iter_239_6.color.r, 0.5, var_239_18)

								iter_239_6.color = Color.New(var_239_22, var_239_22, var_239_22)
							end
						end
					end
				end
			end

			if arg_236_1.time_ >= var_239_16 + var_239_17 and arg_236_1.time_ < var_239_16 + var_239_17 + arg_239_0 and not isNil(var_239_15) and arg_236_1.var_.actorSpriteComps10022 then
				for iter_239_7, iter_239_8 in pairs(arg_236_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_239_8 then
						if arg_236_1.isInRecall_ then
							iter_239_8.color = arg_236_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_239_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_236_1.var_.actorSpriteComps10022 = nil
			end

			local var_239_23 = 0
			local var_239_24 = 1.35

			if var_239_23 < arg_236_1.time_ and arg_236_1.time_ <= var_239_23 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_25 = arg_236_1:FormatText(StoryNameCfg[1001].name)

				arg_236_1.leftNameTxt_.text = var_239_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_26 = arg_236_1:GetWordFromCfg(413022056)
				local var_239_27 = arg_236_1:FormatText(var_239_26.content)

				arg_236_1.text_.text = var_239_27

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_28 = 54
				local var_239_29 = utf8.len(var_239_27)
				local var_239_30 = var_239_28 <= 0 and var_239_24 or var_239_24 * (var_239_29 / var_239_28)

				if var_239_30 > 0 and var_239_24 < var_239_30 then
					arg_236_1.talkMaxDuration = var_239_30

					if var_239_30 + var_239_23 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_30 + var_239_23
					end
				end

				arg_236_1.text_.text = var_239_27
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022056", "story_v_out_413022.awb") ~= 0 then
					local var_239_31 = manager.audio:GetVoiceLength("story_v_out_413022", "413022056", "story_v_out_413022.awb") / 1000

					if var_239_31 + var_239_23 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_31 + var_239_23
					end

					if var_239_26.prefab_name ~= "" and arg_236_1.actors_[var_239_26.prefab_name] ~= nil then
						local var_239_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_26.prefab_name].transform, "story_v_out_413022", "413022056", "story_v_out_413022.awb")

						arg_236_1:RecordAudio("413022056", var_239_32)
						arg_236_1:RecordAudio("413022056", var_239_32)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_413022", "413022056", "story_v_out_413022.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_413022", "413022056", "story_v_out_413022.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_33 = math.max(var_239_24, arg_236_1.talkMaxDuration)

			if var_239_23 <= arg_236_1.time_ and arg_236_1.time_ < var_239_23 + var_239_33 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_23) / var_239_33

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_23 + var_239_33 and arg_236_1.time_ < var_239_23 + var_239_33 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play413022057 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 413022057
		arg_240_1.duration_ = 11.93

		local var_240_0 = {
			zh = 6.366,
			ja = 11.933
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play413022058(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["10092"]
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.actorSpriteComps10092 == nil then
				arg_240_1.var_.actorSpriteComps10092 = var_243_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_2 = 2

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_2 and not isNil(var_243_0) then
				local var_243_3 = (arg_240_1.time_ - var_243_1) / var_243_2

				if arg_240_1.var_.actorSpriteComps10092 then
					for iter_243_0, iter_243_1 in pairs(arg_240_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_243_1 then
							if arg_240_1.isInRecall_ then
								local var_243_4 = Mathf.Lerp(iter_243_1.color.r, arg_240_1.hightColor1.r, var_243_3)
								local var_243_5 = Mathf.Lerp(iter_243_1.color.g, arg_240_1.hightColor1.g, var_243_3)
								local var_243_6 = Mathf.Lerp(iter_243_1.color.b, arg_240_1.hightColor1.b, var_243_3)

								iter_243_1.color = Color.New(var_243_4, var_243_5, var_243_6)
							else
								local var_243_7 = Mathf.Lerp(iter_243_1.color.r, 1, var_243_3)

								iter_243_1.color = Color.New(var_243_7, var_243_7, var_243_7)
							end
						end
					end
				end
			end

			if arg_240_1.time_ >= var_243_1 + var_243_2 and arg_240_1.time_ < var_243_1 + var_243_2 + arg_243_0 and not isNil(var_243_0) and arg_240_1.var_.actorSpriteComps10092 then
				for iter_243_2, iter_243_3 in pairs(arg_240_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_243_3 then
						if arg_240_1.isInRecall_ then
							iter_243_3.color = arg_240_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_243_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_240_1.var_.actorSpriteComps10092 = nil
			end

			local var_243_8 = arg_240_1.actors_["10097"]
			local var_243_9 = 0

			if var_243_9 < arg_240_1.time_ and arg_240_1.time_ <= var_243_9 + arg_243_0 and not isNil(var_243_8) and arg_240_1.var_.actorSpriteComps10097 == nil then
				arg_240_1.var_.actorSpriteComps10097 = var_243_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_10 = 2

			if var_243_9 <= arg_240_1.time_ and arg_240_1.time_ < var_243_9 + var_243_10 and not isNil(var_243_8) then
				local var_243_11 = (arg_240_1.time_ - var_243_9) / var_243_10

				if arg_240_1.var_.actorSpriteComps10097 then
					for iter_243_4, iter_243_5 in pairs(arg_240_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_243_5 then
							if arg_240_1.isInRecall_ then
								local var_243_12 = Mathf.Lerp(iter_243_5.color.r, arg_240_1.hightColor2.r, var_243_11)
								local var_243_13 = Mathf.Lerp(iter_243_5.color.g, arg_240_1.hightColor2.g, var_243_11)
								local var_243_14 = Mathf.Lerp(iter_243_5.color.b, arg_240_1.hightColor2.b, var_243_11)

								iter_243_5.color = Color.New(var_243_12, var_243_13, var_243_14)
							else
								local var_243_15 = Mathf.Lerp(iter_243_5.color.r, 0.5, var_243_11)

								iter_243_5.color = Color.New(var_243_15, var_243_15, var_243_15)
							end
						end
					end
				end
			end

			if arg_240_1.time_ >= var_243_9 + var_243_10 and arg_240_1.time_ < var_243_9 + var_243_10 + arg_243_0 and not isNil(var_243_8) and arg_240_1.var_.actorSpriteComps10097 then
				for iter_243_6, iter_243_7 in pairs(arg_240_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_243_7 then
						if arg_240_1.isInRecall_ then
							iter_243_7.color = arg_240_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_243_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_240_1.var_.actorSpriteComps10097 = nil
			end

			local var_243_16 = arg_240_1.actors_["10097"].transform
			local var_243_17 = 0

			if var_243_17 < arg_240_1.time_ and arg_240_1.time_ <= var_243_17 + arg_243_0 then
				arg_240_1.var_.moveOldPos10097 = var_243_16.localPosition
				var_243_16.localScale = Vector3.New(1, 1, 1)

				arg_240_1:CheckSpriteTmpPos("10097", 4)

				local var_243_18 = var_243_16.childCount

				for iter_243_8 = 0, var_243_18 - 1 do
					local var_243_19 = var_243_16:GetChild(iter_243_8)

					if var_243_19.name == "split_2" or not string.find(var_243_19.name, "split") then
						var_243_19.gameObject:SetActive(true)
					else
						var_243_19.gameObject:SetActive(false)
					end
				end
			end

			local var_243_20 = 0.001

			if var_243_17 <= arg_240_1.time_ and arg_240_1.time_ < var_243_17 + var_243_20 then
				local var_243_21 = (arg_240_1.time_ - var_243_17) / var_243_20
				local var_243_22 = Vector3.New(390, -350, -180)

				var_243_16.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10097, var_243_22, var_243_21)
			end

			if arg_240_1.time_ >= var_243_17 + var_243_20 and arg_240_1.time_ < var_243_17 + var_243_20 + arg_243_0 then
				var_243_16.localPosition = Vector3.New(390, -350, -180)
			end

			local var_243_23 = arg_240_1.actors_["10092"].transform
			local var_243_24 = 0

			if var_243_24 < arg_240_1.time_ and arg_240_1.time_ <= var_243_24 + arg_243_0 then
				arg_240_1.var_.moveOldPos10092 = var_243_23.localPosition
				var_243_23.localScale = Vector3.New(1, 1, 1)

				arg_240_1:CheckSpriteTmpPos("10092", 2)

				local var_243_25 = var_243_23.childCount

				for iter_243_9 = 0, var_243_25 - 1 do
					local var_243_26 = var_243_23:GetChild(iter_243_9)

					if var_243_26.name == "split_1_1" or not string.find(var_243_26.name, "split") then
						var_243_26.gameObject:SetActive(true)
					else
						var_243_26.gameObject:SetActive(false)
					end
				end
			end

			local var_243_27 = 0.001

			if var_243_24 <= arg_240_1.time_ and arg_240_1.time_ < var_243_24 + var_243_27 then
				local var_243_28 = (arg_240_1.time_ - var_243_24) / var_243_27
				local var_243_29 = Vector3.New(-389.49, -300, -295)

				var_243_23.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10092, var_243_29, var_243_28)
			end

			if arg_240_1.time_ >= var_243_24 + var_243_27 and arg_240_1.time_ < var_243_24 + var_243_27 + arg_243_0 then
				var_243_23.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_243_30 = 0
			local var_243_31 = 0.9

			if var_243_30 < arg_240_1.time_ and arg_240_1.time_ <= var_243_30 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_32 = arg_240_1:FormatText(StoryNameCfg[996].name)

				arg_240_1.leftNameTxt_.text = var_243_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_33 = arg_240_1:GetWordFromCfg(413022057)
				local var_243_34 = arg_240_1:FormatText(var_243_33.content)

				arg_240_1.text_.text = var_243_34

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_35 = 36
				local var_243_36 = utf8.len(var_243_34)
				local var_243_37 = var_243_35 <= 0 and var_243_31 or var_243_31 * (var_243_36 / var_243_35)

				if var_243_37 > 0 and var_243_31 < var_243_37 then
					arg_240_1.talkMaxDuration = var_243_37

					if var_243_37 + var_243_30 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_37 + var_243_30
					end
				end

				arg_240_1.text_.text = var_243_34
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022057", "story_v_out_413022.awb") ~= 0 then
					local var_243_38 = manager.audio:GetVoiceLength("story_v_out_413022", "413022057", "story_v_out_413022.awb") / 1000

					if var_243_38 + var_243_30 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_38 + var_243_30
					end

					if var_243_33.prefab_name ~= "" and arg_240_1.actors_[var_243_33.prefab_name] ~= nil then
						local var_243_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_33.prefab_name].transform, "story_v_out_413022", "413022057", "story_v_out_413022.awb")

						arg_240_1:RecordAudio("413022057", var_243_39)
						arg_240_1:RecordAudio("413022057", var_243_39)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_413022", "413022057", "story_v_out_413022.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_413022", "413022057", "story_v_out_413022.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_40 = math.max(var_243_31, arg_240_1.talkMaxDuration)

			if var_243_30 <= arg_240_1.time_ and arg_240_1.time_ < var_243_30 + var_243_40 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_30) / var_243_40

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_30 + var_243_40 and arg_240_1.time_ < var_243_30 + var_243_40 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_240_1:InitPlayNodeList()
	end,
	Play413022058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 413022058
		arg_244_1.duration_ = 13.5

		local var_244_0 = {
			zh = 13.5,
			ja = 11.133
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
				arg_244_0:Play413022059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["10097"]
			local var_247_1 = 0

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.actorSpriteComps10097 == nil then
				arg_244_1.var_.actorSpriteComps10097 = var_247_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_2 = 2

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_2 and not isNil(var_247_0) then
				local var_247_3 = (arg_244_1.time_ - var_247_1) / var_247_2

				if arg_244_1.var_.actorSpriteComps10097 then
					for iter_247_0, iter_247_1 in pairs(arg_244_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_247_1 then
							if arg_244_1.isInRecall_ then
								local var_247_4 = Mathf.Lerp(iter_247_1.color.r, arg_244_1.hightColor1.r, var_247_3)
								local var_247_5 = Mathf.Lerp(iter_247_1.color.g, arg_244_1.hightColor1.g, var_247_3)
								local var_247_6 = Mathf.Lerp(iter_247_1.color.b, arg_244_1.hightColor1.b, var_247_3)

								iter_247_1.color = Color.New(var_247_4, var_247_5, var_247_6)
							else
								local var_247_7 = Mathf.Lerp(iter_247_1.color.r, 1, var_247_3)

								iter_247_1.color = Color.New(var_247_7, var_247_7, var_247_7)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= var_247_1 + var_247_2 and arg_244_1.time_ < var_247_1 + var_247_2 + arg_247_0 and not isNil(var_247_0) and arg_244_1.var_.actorSpriteComps10097 then
				for iter_247_2, iter_247_3 in pairs(arg_244_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_247_3 then
						if arg_244_1.isInRecall_ then
							iter_247_3.color = arg_244_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_247_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_244_1.var_.actorSpriteComps10097 = nil
			end

			local var_247_8 = arg_244_1.actors_["10092"]
			local var_247_9 = 0

			if var_247_9 < arg_244_1.time_ and arg_244_1.time_ <= var_247_9 + arg_247_0 and not isNil(var_247_8) and arg_244_1.var_.actorSpriteComps10092 == nil then
				arg_244_1.var_.actorSpriteComps10092 = var_247_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_10 = 2

			if var_247_9 <= arg_244_1.time_ and arg_244_1.time_ < var_247_9 + var_247_10 and not isNil(var_247_8) then
				local var_247_11 = (arg_244_1.time_ - var_247_9) / var_247_10

				if arg_244_1.var_.actorSpriteComps10092 then
					for iter_247_4, iter_247_5 in pairs(arg_244_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_247_5 then
							if arg_244_1.isInRecall_ then
								local var_247_12 = Mathf.Lerp(iter_247_5.color.r, arg_244_1.hightColor2.r, var_247_11)
								local var_247_13 = Mathf.Lerp(iter_247_5.color.g, arg_244_1.hightColor2.g, var_247_11)
								local var_247_14 = Mathf.Lerp(iter_247_5.color.b, arg_244_1.hightColor2.b, var_247_11)

								iter_247_5.color = Color.New(var_247_12, var_247_13, var_247_14)
							else
								local var_247_15 = Mathf.Lerp(iter_247_5.color.r, 0.5, var_247_11)

								iter_247_5.color = Color.New(var_247_15, var_247_15, var_247_15)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= var_247_9 + var_247_10 and arg_244_1.time_ < var_247_9 + var_247_10 + arg_247_0 and not isNil(var_247_8) and arg_244_1.var_.actorSpriteComps10092 then
				for iter_247_6, iter_247_7 in pairs(arg_244_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_247_7 then
						if arg_244_1.isInRecall_ then
							iter_247_7.color = arg_244_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_247_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_244_1.var_.actorSpriteComps10092 = nil
			end

			local var_247_16 = 0
			local var_247_17 = 0.825

			if var_247_16 < arg_244_1.time_ and arg_244_1.time_ <= var_247_16 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_18 = arg_244_1:FormatText(StoryNameCfg[1001].name)

				arg_244_1.leftNameTxt_.text = var_247_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_19 = arg_244_1:GetWordFromCfg(413022058)
				local var_247_20 = arg_244_1:FormatText(var_247_19.content)

				arg_244_1.text_.text = var_247_20

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_21 = 33
				local var_247_22 = utf8.len(var_247_20)
				local var_247_23 = var_247_21 <= 0 and var_247_17 or var_247_17 * (var_247_22 / var_247_21)

				if var_247_23 > 0 and var_247_17 < var_247_23 then
					arg_244_1.talkMaxDuration = var_247_23

					if var_247_23 + var_247_16 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_23 + var_247_16
					end
				end

				arg_244_1.text_.text = var_247_20
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022058", "story_v_out_413022.awb") ~= 0 then
					local var_247_24 = manager.audio:GetVoiceLength("story_v_out_413022", "413022058", "story_v_out_413022.awb") / 1000

					if var_247_24 + var_247_16 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_24 + var_247_16
					end

					if var_247_19.prefab_name ~= "" and arg_244_1.actors_[var_247_19.prefab_name] ~= nil then
						local var_247_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_19.prefab_name].transform, "story_v_out_413022", "413022058", "story_v_out_413022.awb")

						arg_244_1:RecordAudio("413022058", var_247_25)
						arg_244_1:RecordAudio("413022058", var_247_25)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_413022", "413022058", "story_v_out_413022.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_413022", "413022058", "story_v_out_413022.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_26 = math.max(var_247_17, arg_244_1.talkMaxDuration)

			if var_247_16 <= arg_244_1.time_ and arg_244_1.time_ < var_247_16 + var_247_26 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_16) / var_247_26

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_16 + var_247_26 and arg_244_1.time_ < var_247_16 + var_247_26 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play413022059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 413022059
		arg_248_1.duration_ = 20.67

		local var_248_0 = {
			zh = 10.866,
			ja = 20.666
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
				arg_248_0:Play413022060(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = 0
			local var_251_1 = 1.025

			if var_251_0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_0 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_2 = arg_248_1:FormatText(StoryNameCfg[1001].name)

				arg_248_1.leftNameTxt_.text = var_251_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_3 = arg_248_1:GetWordFromCfg(413022059)
				local var_251_4 = arg_248_1:FormatText(var_251_3.content)

				arg_248_1.text_.text = var_251_4

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_5 = 41
				local var_251_6 = utf8.len(var_251_4)
				local var_251_7 = var_251_5 <= 0 and var_251_1 or var_251_1 * (var_251_6 / var_251_5)

				if var_251_7 > 0 and var_251_1 < var_251_7 then
					arg_248_1.talkMaxDuration = var_251_7

					if var_251_7 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_7 + var_251_0
					end
				end

				arg_248_1.text_.text = var_251_4
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022059", "story_v_out_413022.awb") ~= 0 then
					local var_251_8 = manager.audio:GetVoiceLength("story_v_out_413022", "413022059", "story_v_out_413022.awb") / 1000

					if var_251_8 + var_251_0 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_8 + var_251_0
					end

					if var_251_3.prefab_name ~= "" and arg_248_1.actors_[var_251_3.prefab_name] ~= nil then
						local var_251_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_3.prefab_name].transform, "story_v_out_413022", "413022059", "story_v_out_413022.awb")

						arg_248_1:RecordAudio("413022059", var_251_9)
						arg_248_1:RecordAudio("413022059", var_251_9)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_413022", "413022059", "story_v_out_413022.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_413022", "413022059", "story_v_out_413022.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_10 = math.max(var_251_1, arg_248_1.talkMaxDuration)

			if var_251_0 <= arg_248_1.time_ and arg_248_1.time_ < var_251_0 + var_251_10 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_0) / var_251_10

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_0 + var_251_10 and arg_248_1.time_ < var_251_0 + var_251_10 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play413022060 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 413022060
		arg_252_1.duration_ = 18.03

		local var_252_0 = {
			zh = 8.166,
			ja = 18.033
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
				arg_252_0:Play413022061(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["10092"]
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.actorSpriteComps10092 == nil then
				arg_252_1.var_.actorSpriteComps10092 = var_255_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_2 = 2

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 and not isNil(var_255_0) then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2

				if arg_252_1.var_.actorSpriteComps10092 then
					for iter_255_0, iter_255_1 in pairs(arg_252_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_255_1 then
							if arg_252_1.isInRecall_ then
								local var_255_4 = Mathf.Lerp(iter_255_1.color.r, arg_252_1.hightColor1.r, var_255_3)
								local var_255_5 = Mathf.Lerp(iter_255_1.color.g, arg_252_1.hightColor1.g, var_255_3)
								local var_255_6 = Mathf.Lerp(iter_255_1.color.b, arg_252_1.hightColor1.b, var_255_3)

								iter_255_1.color = Color.New(var_255_4, var_255_5, var_255_6)
							else
								local var_255_7 = Mathf.Lerp(iter_255_1.color.r, 1, var_255_3)

								iter_255_1.color = Color.New(var_255_7, var_255_7, var_255_7)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.actorSpriteComps10092 then
				for iter_255_2, iter_255_3 in pairs(arg_252_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_255_3 then
						if arg_252_1.isInRecall_ then
							iter_255_3.color = arg_252_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_255_3.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_252_1.var_.actorSpriteComps10092 = nil
			end

			local var_255_8 = arg_252_1.actors_["10097"]
			local var_255_9 = 0

			if var_255_9 < arg_252_1.time_ and arg_252_1.time_ <= var_255_9 + arg_255_0 and not isNil(var_255_8) and arg_252_1.var_.actorSpriteComps10097 == nil then
				arg_252_1.var_.actorSpriteComps10097 = var_255_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_255_10 = 2

			if var_255_9 <= arg_252_1.time_ and arg_252_1.time_ < var_255_9 + var_255_10 and not isNil(var_255_8) then
				local var_255_11 = (arg_252_1.time_ - var_255_9) / var_255_10

				if arg_252_1.var_.actorSpriteComps10097 then
					for iter_255_4, iter_255_5 in pairs(arg_252_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_255_5 then
							if arg_252_1.isInRecall_ then
								local var_255_12 = Mathf.Lerp(iter_255_5.color.r, arg_252_1.hightColor2.r, var_255_11)
								local var_255_13 = Mathf.Lerp(iter_255_5.color.g, arg_252_1.hightColor2.g, var_255_11)
								local var_255_14 = Mathf.Lerp(iter_255_5.color.b, arg_252_1.hightColor2.b, var_255_11)

								iter_255_5.color = Color.New(var_255_12, var_255_13, var_255_14)
							else
								local var_255_15 = Mathf.Lerp(iter_255_5.color.r, 0.5, var_255_11)

								iter_255_5.color = Color.New(var_255_15, var_255_15, var_255_15)
							end
						end
					end
				end
			end

			if arg_252_1.time_ >= var_255_9 + var_255_10 and arg_252_1.time_ < var_255_9 + var_255_10 + arg_255_0 and not isNil(var_255_8) and arg_252_1.var_.actorSpriteComps10097 then
				for iter_255_6, iter_255_7 in pairs(arg_252_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_255_7 then
						if arg_252_1.isInRecall_ then
							iter_255_7.color = arg_252_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_255_7.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_252_1.var_.actorSpriteComps10097 = nil
			end

			local var_255_16 = arg_252_1.actors_["10092"].transform
			local var_255_17 = 0

			if var_255_17 < arg_252_1.time_ and arg_252_1.time_ <= var_255_17 + arg_255_0 then
				arg_252_1.var_.moveOldPos10092 = var_255_16.localPosition
				var_255_16.localScale = Vector3.New(1, 1, 1)

				arg_252_1:CheckSpriteTmpPos("10092", 2)

				local var_255_18 = var_255_16.childCount

				for iter_255_8 = 0, var_255_18 - 1 do
					local var_255_19 = var_255_16:GetChild(iter_255_8)

					if var_255_19.name == "split_8" or not string.find(var_255_19.name, "split") then
						var_255_19.gameObject:SetActive(true)
					else
						var_255_19.gameObject:SetActive(false)
					end
				end
			end

			local var_255_20 = 0.001

			if var_255_17 <= arg_252_1.time_ and arg_252_1.time_ < var_255_17 + var_255_20 then
				local var_255_21 = (arg_252_1.time_ - var_255_17) / var_255_20
				local var_255_22 = Vector3.New(-389.49, -300, -295)

				var_255_16.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10092, var_255_22, var_255_21)
			end

			if arg_252_1.time_ >= var_255_17 + var_255_20 and arg_252_1.time_ < var_255_17 + var_255_20 + arg_255_0 then
				var_255_16.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_255_23 = 0
			local var_255_24 = 0.825

			if var_255_23 < arg_252_1.time_ and arg_252_1.time_ <= var_255_23 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_25 = arg_252_1:FormatText(StoryNameCfg[996].name)

				arg_252_1.leftNameTxt_.text = var_255_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_26 = arg_252_1:GetWordFromCfg(413022060)
				local var_255_27 = arg_252_1:FormatText(var_255_26.content)

				arg_252_1.text_.text = var_255_27

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_28 = 33
				local var_255_29 = utf8.len(var_255_27)
				local var_255_30 = var_255_28 <= 0 and var_255_24 or var_255_24 * (var_255_29 / var_255_28)

				if var_255_30 > 0 and var_255_24 < var_255_30 then
					arg_252_1.talkMaxDuration = var_255_30

					if var_255_30 + var_255_23 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_30 + var_255_23
					end
				end

				arg_252_1.text_.text = var_255_27
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022060", "story_v_out_413022.awb") ~= 0 then
					local var_255_31 = manager.audio:GetVoiceLength("story_v_out_413022", "413022060", "story_v_out_413022.awb") / 1000

					if var_255_31 + var_255_23 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_31 + var_255_23
					end

					if var_255_26.prefab_name ~= "" and arg_252_1.actors_[var_255_26.prefab_name] ~= nil then
						local var_255_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_26.prefab_name].transform, "story_v_out_413022", "413022060", "story_v_out_413022.awb")

						arg_252_1:RecordAudio("413022060", var_255_32)
						arg_252_1:RecordAudio("413022060", var_255_32)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_413022", "413022060", "story_v_out_413022.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_413022", "413022060", "story_v_out_413022.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_33 = math.max(var_255_24, arg_252_1.talkMaxDuration)

			if var_255_23 <= arg_252_1.time_ and arg_252_1.time_ < var_255_23 + var_255_33 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_23) / var_255_33

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_23 + var_255_33 and arg_252_1.time_ < var_255_23 + var_255_33 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
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

		arg_252_1:InitPlayNodeList()
	end,
	Play413022061 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 413022061
		arg_256_1.duration_ = 5.03

		local var_256_0 = {
			zh = 5.033,
			ja = 3.3
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
				arg_256_0:Play413022062(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["10097"].transform
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
				arg_256_1.var_.moveOldPos10097 = var_259_0.localPosition
				var_259_0.localScale = Vector3.New(1, 1, 1)

				arg_256_1:CheckSpriteTmpPos("10097", 4)

				local var_259_2 = var_259_0.childCount

				for iter_259_0 = 0, var_259_2 - 1 do
					local var_259_3 = var_259_0:GetChild(iter_259_0)

					if var_259_3.name == "split_4" or not string.find(var_259_3.name, "split") then
						var_259_3.gameObject:SetActive(true)
					else
						var_259_3.gameObject:SetActive(false)
					end
				end
			end

			local var_259_4 = 0.001

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_4 then
				local var_259_5 = (arg_256_1.time_ - var_259_1) / var_259_4
				local var_259_6 = Vector3.New(390, -350, -180)

				var_259_0.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos10097, var_259_6, var_259_5)
			end

			if arg_256_1.time_ >= var_259_1 + var_259_4 and arg_256_1.time_ < var_259_1 + var_259_4 + arg_259_0 then
				var_259_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_259_7 = arg_256_1.actors_["10097"]
			local var_259_8 = 0

			if var_259_8 < arg_256_1.time_ and arg_256_1.time_ <= var_259_8 + arg_259_0 and not isNil(var_259_7) and arg_256_1.var_.actorSpriteComps10097 == nil then
				arg_256_1.var_.actorSpriteComps10097 = var_259_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_259_9 = 2

			if var_259_8 <= arg_256_1.time_ and arg_256_1.time_ < var_259_8 + var_259_9 and not isNil(var_259_7) then
				local var_259_10 = (arg_256_1.time_ - var_259_8) / var_259_9

				if arg_256_1.var_.actorSpriteComps10097 then
					for iter_259_1, iter_259_2 in pairs(arg_256_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_259_2 then
							if arg_256_1.isInRecall_ then
								local var_259_11 = Mathf.Lerp(iter_259_2.color.r, arg_256_1.hightColor1.r, var_259_10)
								local var_259_12 = Mathf.Lerp(iter_259_2.color.g, arg_256_1.hightColor1.g, var_259_10)
								local var_259_13 = Mathf.Lerp(iter_259_2.color.b, arg_256_1.hightColor1.b, var_259_10)

								iter_259_2.color = Color.New(var_259_11, var_259_12, var_259_13)
							else
								local var_259_14 = Mathf.Lerp(iter_259_2.color.r, 1, var_259_10)

								iter_259_2.color = Color.New(var_259_14, var_259_14, var_259_14)
							end
						end
					end
				end
			end

			if arg_256_1.time_ >= var_259_8 + var_259_9 and arg_256_1.time_ < var_259_8 + var_259_9 + arg_259_0 and not isNil(var_259_7) and arg_256_1.var_.actorSpriteComps10097 then
				for iter_259_3, iter_259_4 in pairs(arg_256_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_259_4 then
						if arg_256_1.isInRecall_ then
							iter_259_4.color = arg_256_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_259_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_256_1.var_.actorSpriteComps10097 = nil
			end

			local var_259_15 = arg_256_1.actors_["10092"]
			local var_259_16 = 0

			if var_259_16 < arg_256_1.time_ and arg_256_1.time_ <= var_259_16 + arg_259_0 and not isNil(var_259_15) and arg_256_1.var_.actorSpriteComps10092 == nil then
				arg_256_1.var_.actorSpriteComps10092 = var_259_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_259_17 = 2

			if var_259_16 <= arg_256_1.time_ and arg_256_1.time_ < var_259_16 + var_259_17 and not isNil(var_259_15) then
				local var_259_18 = (arg_256_1.time_ - var_259_16) / var_259_17

				if arg_256_1.var_.actorSpriteComps10092 then
					for iter_259_5, iter_259_6 in pairs(arg_256_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_259_6 then
							if arg_256_1.isInRecall_ then
								local var_259_19 = Mathf.Lerp(iter_259_6.color.r, arg_256_1.hightColor2.r, var_259_18)
								local var_259_20 = Mathf.Lerp(iter_259_6.color.g, arg_256_1.hightColor2.g, var_259_18)
								local var_259_21 = Mathf.Lerp(iter_259_6.color.b, arg_256_1.hightColor2.b, var_259_18)

								iter_259_6.color = Color.New(var_259_19, var_259_20, var_259_21)
							else
								local var_259_22 = Mathf.Lerp(iter_259_6.color.r, 0.5, var_259_18)

								iter_259_6.color = Color.New(var_259_22, var_259_22, var_259_22)
							end
						end
					end
				end
			end

			if arg_256_1.time_ >= var_259_16 + var_259_17 and arg_256_1.time_ < var_259_16 + var_259_17 + arg_259_0 and not isNil(var_259_15) and arg_256_1.var_.actorSpriteComps10092 then
				for iter_259_7, iter_259_8 in pairs(arg_256_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_259_8 then
						if arg_256_1.isInRecall_ then
							iter_259_8.color = arg_256_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_259_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_256_1.var_.actorSpriteComps10092 = nil
			end

			local var_259_23 = 1.16666666666667
			local var_259_24 = 0.7

			if var_259_23 < arg_256_1.time_ and arg_256_1.time_ <= var_259_23 + arg_259_0 then
				local var_259_25 = "play"
				local var_259_26 = "effect"

				arg_256_1:AudioAction(var_259_25, var_259_26, "se_story_134_01", "se_story_134_01_table", "")
			end

			local var_259_27 = 0
			local var_259_28 = 0.425

			if var_259_27 < arg_256_1.time_ and arg_256_1.time_ <= var_259_27 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_29 = arg_256_1:FormatText(StoryNameCfg[1001].name)

				arg_256_1.leftNameTxt_.text = var_259_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_30 = arg_256_1:GetWordFromCfg(413022061)
				local var_259_31 = arg_256_1:FormatText(var_259_30.content)

				arg_256_1.text_.text = var_259_31

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_32 = 17
				local var_259_33 = utf8.len(var_259_31)
				local var_259_34 = var_259_32 <= 0 and var_259_28 or var_259_28 * (var_259_33 / var_259_32)

				if var_259_34 > 0 and var_259_28 < var_259_34 then
					arg_256_1.talkMaxDuration = var_259_34

					if var_259_34 + var_259_27 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_34 + var_259_27
					end
				end

				arg_256_1.text_.text = var_259_31
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022061", "story_v_out_413022.awb") ~= 0 then
					local var_259_35 = manager.audio:GetVoiceLength("story_v_out_413022", "413022061", "story_v_out_413022.awb") / 1000

					if var_259_35 + var_259_27 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_35 + var_259_27
					end

					if var_259_30.prefab_name ~= "" and arg_256_1.actors_[var_259_30.prefab_name] ~= nil then
						local var_259_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_30.prefab_name].transform, "story_v_out_413022", "413022061", "story_v_out_413022.awb")

						arg_256_1:RecordAudio("413022061", var_259_36)
						arg_256_1:RecordAudio("413022061", var_259_36)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_413022", "413022061", "story_v_out_413022.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_413022", "413022061", "story_v_out_413022.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_37 = math.max(var_259_28, arg_256_1.talkMaxDuration)

			if var_259_27 <= arg_256_1.time_ and arg_256_1.time_ < var_259_27 + var_259_37 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_27) / var_259_37

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_27 + var_259_37 and arg_256_1.time_ < var_259_27 + var_259_37 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play413022062 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 413022062
		arg_260_1.duration_ = 12.1

		local var_260_0 = {
			zh = 9.266,
			ja = 12.1
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play413022063(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0
			local var_263_1 = 0.9

			if var_263_0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_2 = arg_260_1:FormatText(StoryNameCfg[1001].name)

				arg_260_1.leftNameTxt_.text = var_263_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_3 = arg_260_1:GetWordFromCfg(413022062)
				local var_263_4 = arg_260_1:FormatText(var_263_3.content)

				arg_260_1.text_.text = var_263_4

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_5 = 36
				local var_263_6 = utf8.len(var_263_4)
				local var_263_7 = var_263_5 <= 0 and var_263_1 or var_263_1 * (var_263_6 / var_263_5)

				if var_263_7 > 0 and var_263_1 < var_263_7 then
					arg_260_1.talkMaxDuration = var_263_7

					if var_263_7 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_7 + var_263_0
					end
				end

				arg_260_1.text_.text = var_263_4
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022062", "story_v_out_413022.awb") ~= 0 then
					local var_263_8 = manager.audio:GetVoiceLength("story_v_out_413022", "413022062", "story_v_out_413022.awb") / 1000

					if var_263_8 + var_263_0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_8 + var_263_0
					end

					if var_263_3.prefab_name ~= "" and arg_260_1.actors_[var_263_3.prefab_name] ~= nil then
						local var_263_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_3.prefab_name].transform, "story_v_out_413022", "413022062", "story_v_out_413022.awb")

						arg_260_1:RecordAudio("413022062", var_263_9)
						arg_260_1:RecordAudio("413022062", var_263_9)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_413022", "413022062", "story_v_out_413022.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_413022", "413022062", "story_v_out_413022.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_10 = math.max(var_263_1, arg_260_1.talkMaxDuration)

			if var_263_0 <= arg_260_1.time_ and arg_260_1.time_ < var_263_0 + var_263_10 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_0) / var_263_10

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_0 + var_263_10 and arg_260_1.time_ < var_263_0 + var_263_10 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play413022063 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 413022063
		arg_264_1.duration_ = 6.63

		local var_264_0 = {
			zh = 6,
			ja = 6.633
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play413022064(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = arg_264_1.actors_["10097"].transform
			local var_267_1 = 0.0333333333333333

			if var_267_1 < arg_264_1.time_ and arg_264_1.time_ <= var_267_1 + arg_267_0 then
				arg_264_1.var_.shakeOldPos10097 = var_267_0.localPosition
			end

			local var_267_2 = 0.6

			if var_267_1 <= arg_264_1.time_ and arg_264_1.time_ < var_267_1 + var_267_2 then
				local var_267_3 = (arg_264_1.time_ - var_267_1) / 0.066
				local var_267_4, var_267_5 = math.modf(var_267_3)

				var_267_0.localPosition = Vector3.New(var_267_5 * 0.13, var_267_5 * 0.13, var_267_5 * 0.13) + arg_264_1.var_.shakeOldPos10097
			end

			if arg_264_1.time_ >= var_267_1 + var_267_2 and arg_264_1.time_ < var_267_1 + var_267_2 + arg_267_0 then
				var_267_0.localPosition = arg_264_1.var_.shakeOldPos10097
			end

			local var_267_6 = 0

			if var_267_6 < arg_264_1.time_ and arg_264_1.time_ <= var_267_6 + arg_267_0 then
				arg_264_1.allBtn_.enabled = false
			end

			local var_267_7 = 0.633333333333333

			if arg_264_1.time_ >= var_267_6 + var_267_7 and arg_264_1.time_ < var_267_6 + var_267_7 + arg_267_0 then
				arg_264_1.allBtn_.enabled = true
			end

			local var_267_8 = 0
			local var_267_9 = 0.475

			if var_267_8 < arg_264_1.time_ and arg_264_1.time_ <= var_267_8 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_10 = arg_264_1:FormatText(StoryNameCfg[1001].name)

				arg_264_1.leftNameTxt_.text = var_267_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_11 = arg_264_1:GetWordFromCfg(413022063)
				local var_267_12 = arg_264_1:FormatText(var_267_11.content)

				arg_264_1.text_.text = var_267_12

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_13 = 19
				local var_267_14 = utf8.len(var_267_12)
				local var_267_15 = var_267_13 <= 0 and var_267_9 or var_267_9 * (var_267_14 / var_267_13)

				if var_267_15 > 0 and var_267_9 < var_267_15 then
					arg_264_1.talkMaxDuration = var_267_15

					if var_267_15 + var_267_8 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_15 + var_267_8
					end
				end

				arg_264_1.text_.text = var_267_12
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022063", "story_v_out_413022.awb") ~= 0 then
					local var_267_16 = manager.audio:GetVoiceLength("story_v_out_413022", "413022063", "story_v_out_413022.awb") / 1000

					if var_267_16 + var_267_8 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_16 + var_267_8
					end

					if var_267_11.prefab_name ~= "" and arg_264_1.actors_[var_267_11.prefab_name] ~= nil then
						local var_267_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_11.prefab_name].transform, "story_v_out_413022", "413022063", "story_v_out_413022.awb")

						arg_264_1:RecordAudio("413022063", var_267_17)
						arg_264_1:RecordAudio("413022063", var_267_17)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_413022", "413022063", "story_v_out_413022.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_413022", "413022063", "story_v_out_413022.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_18 = math.max(var_267_9, arg_264_1.talkMaxDuration)

			if var_267_8 <= arg_264_1.time_ and arg_264_1.time_ < var_267_8 + var_267_18 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_8) / var_267_18

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_8 + var_267_18 and arg_264_1.time_ < var_267_8 + var_267_18 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play413022064 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 413022064
		arg_268_1.duration_ = 2

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play413022065(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = arg_268_1.actors_["10092"].transform
			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1.var_.moveOldPos10092 = var_271_0.localPosition
				var_271_0.localScale = Vector3.New(1, 1, 1)

				arg_268_1:CheckSpriteTmpPos("10092", 7)

				local var_271_2 = var_271_0.childCount

				for iter_271_0 = 0, var_271_2 - 1 do
					local var_271_3 = var_271_0:GetChild(iter_271_0)

					if var_271_3.name == "" or not string.find(var_271_3.name, "split") then
						var_271_3.gameObject:SetActive(true)
					else
						var_271_3.gameObject:SetActive(false)
					end
				end
			end

			local var_271_4 = 0.001

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_4 then
				local var_271_5 = (arg_268_1.time_ - var_271_1) / var_271_4
				local var_271_6 = Vector3.New(0, -2000, -180)

				var_271_0.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos10092, var_271_6, var_271_5)
			end

			if arg_268_1.time_ >= var_271_1 + var_271_4 and arg_268_1.time_ < var_271_1 + var_271_4 + arg_271_0 then
				var_271_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_271_7 = arg_268_1.actors_["10097"].transform
			local var_271_8 = 0

			if var_271_8 < arg_268_1.time_ and arg_268_1.time_ <= var_271_8 + arg_271_0 then
				arg_268_1.var_.moveOldPos10097 = var_271_7.localPosition
				var_271_7.localScale = Vector3.New(1, 1, 1)

				arg_268_1:CheckSpriteTmpPos("10097", 7)

				local var_271_9 = var_271_7.childCount

				for iter_271_1 = 0, var_271_9 - 1 do
					local var_271_10 = var_271_7:GetChild(iter_271_1)

					if var_271_10.name == "" or not string.find(var_271_10.name, "split") then
						var_271_10.gameObject:SetActive(true)
					else
						var_271_10.gameObject:SetActive(false)
					end
				end
			end

			local var_271_11 = 0.001

			if var_271_8 <= arg_268_1.time_ and arg_268_1.time_ < var_271_8 + var_271_11 then
				local var_271_12 = (arg_268_1.time_ - var_271_8) / var_271_11
				local var_271_13 = Vector3.New(0, -2000, -180)

				var_271_7.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos10097, var_271_13, var_271_12)
			end

			if arg_268_1.time_ >= var_271_8 + var_271_11 and arg_268_1.time_ < var_271_8 + var_271_11 + arg_271_0 then
				var_271_7.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_271_14 = "10093"

			if arg_268_1.actors_[var_271_14] == nil then
				local var_271_15 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_271_15) then
					local var_271_16 = Object.Instantiate(var_271_15, arg_268_1.canvasGo_.transform)

					var_271_16.transform:SetSiblingIndex(1)

					var_271_16.name = var_271_14
					var_271_16.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_268_1.actors_[var_271_14] = var_271_16

					local var_271_17 = var_271_16:GetComponentsInChildren(typeof(Image), true):ToTable()

					if arg_268_1.isInRecall_ then
						for iter_271_2, iter_271_3 in ipairs(var_271_17) do
							iter_271_3.color = arg_268_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_271_18 = arg_268_1.actors_["10093"].transform
			local var_271_19 = 0

			if var_271_19 < arg_268_1.time_ and arg_268_1.time_ <= var_271_19 + arg_271_0 then
				arg_268_1.var_.moveOldPos10093 = var_271_18.localPosition
				var_271_18.localScale = Vector3.New(1, 1, 1)

				arg_268_1:CheckSpriteTmpPos("10093", 3)

				local var_271_20 = var_271_18.childCount

				for iter_271_4 = 0, var_271_20 - 1 do
					local var_271_21 = var_271_18:GetChild(iter_271_4)

					if var_271_21.name == "split_4" or not string.find(var_271_21.name, "split") then
						var_271_21.gameObject:SetActive(true)
					else
						var_271_21.gameObject:SetActive(false)
					end
				end
			end

			local var_271_22 = 0.001

			if var_271_19 <= arg_268_1.time_ and arg_268_1.time_ < var_271_19 + var_271_22 then
				local var_271_23 = (arg_268_1.time_ - var_271_19) / var_271_22
				local var_271_24 = Vector3.New(0, -345, -245)

				var_271_18.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos10093, var_271_24, var_271_23)
			end

			if arg_268_1.time_ >= var_271_19 + var_271_22 and arg_268_1.time_ < var_271_19 + var_271_22 + arg_271_0 then
				var_271_18.localPosition = Vector3.New(0, -345, -245)
			end

			local var_271_25 = arg_268_1.actors_["10022"]
			local var_271_26 = 0

			if var_271_26 < arg_268_1.time_ and arg_268_1.time_ <= var_271_26 + arg_271_0 and not isNil(var_271_25) and arg_268_1.var_.actorSpriteComps10022 == nil then
				arg_268_1.var_.actorSpriteComps10022 = var_271_25:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_27 = 2

			if var_271_26 <= arg_268_1.time_ and arg_268_1.time_ < var_271_26 + var_271_27 and not isNil(var_271_25) then
				local var_271_28 = (arg_268_1.time_ - var_271_26) / var_271_27

				if arg_268_1.var_.actorSpriteComps10022 then
					for iter_271_5, iter_271_6 in pairs(arg_268_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_271_6 then
							if arg_268_1.isInRecall_ then
								local var_271_29 = Mathf.Lerp(iter_271_6.color.r, arg_268_1.hightColor2.r, var_271_28)
								local var_271_30 = Mathf.Lerp(iter_271_6.color.g, arg_268_1.hightColor2.g, var_271_28)
								local var_271_31 = Mathf.Lerp(iter_271_6.color.b, arg_268_1.hightColor2.b, var_271_28)

								iter_271_6.color = Color.New(var_271_29, var_271_30, var_271_31)
							else
								local var_271_32 = Mathf.Lerp(iter_271_6.color.r, 0.5, var_271_28)

								iter_271_6.color = Color.New(var_271_32, var_271_32, var_271_32)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= var_271_26 + var_271_27 and arg_268_1.time_ < var_271_26 + var_271_27 + arg_271_0 and not isNil(var_271_25) and arg_268_1.var_.actorSpriteComps10022 then
				for iter_271_7, iter_271_8 in pairs(arg_268_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_271_8 then
						if arg_268_1.isInRecall_ then
							iter_271_8.color = arg_268_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_271_8.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_268_1.var_.actorSpriteComps10022 = nil
			end

			local var_271_33 = arg_268_1.actors_["10097"]
			local var_271_34 = 0

			if var_271_34 < arg_268_1.time_ and arg_268_1.time_ <= var_271_34 + arg_271_0 and not isNil(var_271_33) and arg_268_1.var_.actorSpriteComps10097 == nil then
				arg_268_1.var_.actorSpriteComps10097 = var_271_33:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_35 = 2

			if var_271_34 <= arg_268_1.time_ and arg_268_1.time_ < var_271_34 + var_271_35 and not isNil(var_271_33) then
				local var_271_36 = (arg_268_1.time_ - var_271_34) / var_271_35

				if arg_268_1.var_.actorSpriteComps10097 then
					for iter_271_9, iter_271_10 in pairs(arg_268_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_271_10 then
							if arg_268_1.isInRecall_ then
								local var_271_37 = Mathf.Lerp(iter_271_10.color.r, arg_268_1.hightColor2.r, var_271_36)
								local var_271_38 = Mathf.Lerp(iter_271_10.color.g, arg_268_1.hightColor2.g, var_271_36)
								local var_271_39 = Mathf.Lerp(iter_271_10.color.b, arg_268_1.hightColor2.b, var_271_36)

								iter_271_10.color = Color.New(var_271_37, var_271_38, var_271_39)
							else
								local var_271_40 = Mathf.Lerp(iter_271_10.color.r, 0.5, var_271_36)

								iter_271_10.color = Color.New(var_271_40, var_271_40, var_271_40)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= var_271_34 + var_271_35 and arg_268_1.time_ < var_271_34 + var_271_35 + arg_271_0 and not isNil(var_271_33) and arg_268_1.var_.actorSpriteComps10097 then
				for iter_271_11, iter_271_12 in pairs(arg_268_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_271_12 then
						if arg_268_1.isInRecall_ then
							iter_271_12.color = arg_268_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_271_12.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_268_1.var_.actorSpriteComps10097 = nil
			end

			local var_271_41 = arg_268_1.actors_["10093"]
			local var_271_42 = 0

			if var_271_42 < arg_268_1.time_ and arg_268_1.time_ <= var_271_42 + arg_271_0 and not isNil(var_271_41) and arg_268_1.var_.actorSpriteComps10093 == nil then
				arg_268_1.var_.actorSpriteComps10093 = var_271_41:GetComponentsInChildren(typeof(Image), true)
			end

			local var_271_43 = 2

			if var_271_42 <= arg_268_1.time_ and arg_268_1.time_ < var_271_42 + var_271_43 and not isNil(var_271_41) then
				local var_271_44 = (arg_268_1.time_ - var_271_42) / var_271_43

				if arg_268_1.var_.actorSpriteComps10093 then
					for iter_271_13, iter_271_14 in pairs(arg_268_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_271_14 then
							if arg_268_1.isInRecall_ then
								local var_271_45 = Mathf.Lerp(iter_271_14.color.r, arg_268_1.hightColor1.r, var_271_44)
								local var_271_46 = Mathf.Lerp(iter_271_14.color.g, arg_268_1.hightColor1.g, var_271_44)
								local var_271_47 = Mathf.Lerp(iter_271_14.color.b, arg_268_1.hightColor1.b, var_271_44)

								iter_271_14.color = Color.New(var_271_45, var_271_46, var_271_47)
							else
								local var_271_48 = Mathf.Lerp(iter_271_14.color.r, 1, var_271_44)

								iter_271_14.color = Color.New(var_271_48, var_271_48, var_271_48)
							end
						end
					end
				end
			end

			if arg_268_1.time_ >= var_271_42 + var_271_43 and arg_268_1.time_ < var_271_42 + var_271_43 + arg_271_0 and not isNil(var_271_41) and arg_268_1.var_.actorSpriteComps10093 then
				for iter_271_15, iter_271_16 in pairs(arg_268_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_271_16 then
						if arg_268_1.isInRecall_ then
							iter_271_16.color = arg_268_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_271_16.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_268_1.var_.actorSpriteComps10093 = nil
			end

			local var_271_49 = 0
			local var_271_50 = 0.075

			if var_271_49 < arg_268_1.time_ and arg_268_1.time_ <= var_271_49 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_51 = arg_268_1:FormatText(StoryNameCfg[28].name)

				arg_268_1.leftNameTxt_.text = var_271_51

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_52 = arg_268_1:GetWordFromCfg(413022064)
				local var_271_53 = arg_268_1:FormatText(var_271_52.content)

				arg_268_1.text_.text = var_271_53

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_54 = 3
				local var_271_55 = utf8.len(var_271_53)
				local var_271_56 = var_271_54 <= 0 and var_271_50 or var_271_50 * (var_271_55 / var_271_54)

				if var_271_56 > 0 and var_271_50 < var_271_56 then
					arg_268_1.talkMaxDuration = var_271_56

					if var_271_56 + var_271_49 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_56 + var_271_49
					end
				end

				arg_268_1.text_.text = var_271_53
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022064", "story_v_out_413022.awb") ~= 0 then
					local var_271_57 = manager.audio:GetVoiceLength("story_v_out_413022", "413022064", "story_v_out_413022.awb") / 1000

					if var_271_57 + var_271_49 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_57 + var_271_49
					end

					if var_271_52.prefab_name ~= "" and arg_268_1.actors_[var_271_52.prefab_name] ~= nil then
						local var_271_58 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_52.prefab_name].transform, "story_v_out_413022", "413022064", "story_v_out_413022.awb")

						arg_268_1:RecordAudio("413022064", var_271_58)
						arg_268_1:RecordAudio("413022064", var_271_58)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_413022", "413022064", "story_v_out_413022.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_413022", "413022064", "story_v_out_413022.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_59 = math.max(var_271_50, arg_268_1.talkMaxDuration)

			if var_271_49 <= arg_268_1.time_ and arg_268_1.time_ < var_271_49 + var_271_59 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_49) / var_271_59

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_49 + var_271_59 and arg_268_1.time_ < var_271_49 + var_271_59 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
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
				actorName = "10097",
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

		arg_268_1:InitPlayNodeList()
	end,
	Play413022065 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 413022065
		arg_272_1.duration_ = 2

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play413022066(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = arg_272_1.actors_["10093"].transform
			local var_275_1 = 0

			if var_275_1 < arg_272_1.time_ and arg_272_1.time_ <= var_275_1 + arg_275_0 then
				arg_272_1.var_.moveOldPos10093 = var_275_0.localPosition
				var_275_0.localScale = Vector3.New(1, 1, 1)

				arg_272_1:CheckSpriteTmpPos("10093", 7)

				local var_275_2 = var_275_0.childCount

				for iter_275_0 = 0, var_275_2 - 1 do
					local var_275_3 = var_275_0:GetChild(iter_275_0)

					if var_275_3.name == "" or not string.find(var_275_3.name, "split") then
						var_275_3.gameObject:SetActive(true)
					else
						var_275_3.gameObject:SetActive(false)
					end
				end
			end

			local var_275_4 = 0.001

			if var_275_1 <= arg_272_1.time_ and arg_272_1.time_ < var_275_1 + var_275_4 then
				local var_275_5 = (arg_272_1.time_ - var_275_1) / var_275_4
				local var_275_6 = Vector3.New(0, -2000, -180)

				var_275_0.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos10093, var_275_6, var_275_5)
			end

			if arg_272_1.time_ >= var_275_1 + var_275_4 and arg_272_1.time_ < var_275_1 + var_275_4 + arg_275_0 then
				var_275_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_275_7 = arg_272_1.actors_["10092"].transform
			local var_275_8 = 0

			if var_275_8 < arg_272_1.time_ and arg_272_1.time_ <= var_275_8 + arg_275_0 then
				arg_272_1.var_.moveOldPos10092 = var_275_7.localPosition
				var_275_7.localScale = Vector3.New(1, 1, 1)

				arg_272_1:CheckSpriteTmpPos("10092", 3)

				local var_275_9 = var_275_7.childCount

				for iter_275_1 = 0, var_275_9 - 1 do
					local var_275_10 = var_275_7:GetChild(iter_275_1)

					if var_275_10.name == "split_8" or not string.find(var_275_10.name, "split") then
						var_275_10.gameObject:SetActive(true)
					else
						var_275_10.gameObject:SetActive(false)
					end
				end
			end

			local var_275_11 = 0.001

			if var_275_8 <= arg_272_1.time_ and arg_272_1.time_ < var_275_8 + var_275_11 then
				local var_275_12 = (arg_272_1.time_ - var_275_8) / var_275_11
				local var_275_13 = Vector3.New(0, -300, -295)

				var_275_7.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos10092, var_275_13, var_275_12)
			end

			if arg_272_1.time_ >= var_275_8 + var_275_11 and arg_272_1.time_ < var_275_8 + var_275_11 + arg_275_0 then
				var_275_7.localPosition = Vector3.New(0, -300, -295)
			end

			local var_275_14 = arg_272_1.actors_["10093"]
			local var_275_15 = 0

			if var_275_15 < arg_272_1.time_ and arg_272_1.time_ <= var_275_15 + arg_275_0 and not isNil(var_275_14) and arg_272_1.var_.actorSpriteComps10093 == nil then
				arg_272_1.var_.actorSpriteComps10093 = var_275_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_275_16 = 2

			if var_275_15 <= arg_272_1.time_ and arg_272_1.time_ < var_275_15 + var_275_16 and not isNil(var_275_14) then
				local var_275_17 = (arg_272_1.time_ - var_275_15) / var_275_16

				if arg_272_1.var_.actorSpriteComps10093 then
					for iter_275_2, iter_275_3 in pairs(arg_272_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_275_3 then
							if arg_272_1.isInRecall_ then
								local var_275_18 = Mathf.Lerp(iter_275_3.color.r, arg_272_1.hightColor2.r, var_275_17)
								local var_275_19 = Mathf.Lerp(iter_275_3.color.g, arg_272_1.hightColor2.g, var_275_17)
								local var_275_20 = Mathf.Lerp(iter_275_3.color.b, arg_272_1.hightColor2.b, var_275_17)

								iter_275_3.color = Color.New(var_275_18, var_275_19, var_275_20)
							else
								local var_275_21 = Mathf.Lerp(iter_275_3.color.r, 0.5, var_275_17)

								iter_275_3.color = Color.New(var_275_21, var_275_21, var_275_21)
							end
						end
					end
				end
			end

			if arg_272_1.time_ >= var_275_15 + var_275_16 and arg_272_1.time_ < var_275_15 + var_275_16 + arg_275_0 and not isNil(var_275_14) and arg_272_1.var_.actorSpriteComps10093 then
				for iter_275_4, iter_275_5 in pairs(arg_272_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_275_5 then
						if arg_272_1.isInRecall_ then
							iter_275_5.color = arg_272_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_275_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_272_1.var_.actorSpriteComps10093 = nil
			end

			local var_275_22 = arg_272_1.actors_["10092"]
			local var_275_23 = 0

			if var_275_23 < arg_272_1.time_ and arg_272_1.time_ <= var_275_23 + arg_275_0 and not isNil(var_275_22) and arg_272_1.var_.actorSpriteComps10092 == nil then
				arg_272_1.var_.actorSpriteComps10092 = var_275_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_275_24 = 2

			if var_275_23 <= arg_272_1.time_ and arg_272_1.time_ < var_275_23 + var_275_24 and not isNil(var_275_22) then
				local var_275_25 = (arg_272_1.time_ - var_275_23) / var_275_24

				if arg_272_1.var_.actorSpriteComps10092 then
					for iter_275_6, iter_275_7 in pairs(arg_272_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_275_7 then
							if arg_272_1.isInRecall_ then
								local var_275_26 = Mathf.Lerp(iter_275_7.color.r, arg_272_1.hightColor1.r, var_275_25)
								local var_275_27 = Mathf.Lerp(iter_275_7.color.g, arg_272_1.hightColor1.g, var_275_25)
								local var_275_28 = Mathf.Lerp(iter_275_7.color.b, arg_272_1.hightColor1.b, var_275_25)

								iter_275_7.color = Color.New(var_275_26, var_275_27, var_275_28)
							else
								local var_275_29 = Mathf.Lerp(iter_275_7.color.r, 1, var_275_25)

								iter_275_7.color = Color.New(var_275_29, var_275_29, var_275_29)
							end
						end
					end
				end
			end

			if arg_272_1.time_ >= var_275_23 + var_275_24 and arg_272_1.time_ < var_275_23 + var_275_24 + arg_275_0 and not isNil(var_275_22) and arg_272_1.var_.actorSpriteComps10092 then
				for iter_275_8, iter_275_9 in pairs(arg_272_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_275_9 then
						if arg_272_1.isInRecall_ then
							iter_275_9.color = arg_272_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_275_9.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_272_1.var_.actorSpriteComps10092 = nil
			end

			local var_275_30 = 0
			local var_275_31 = 0.175

			if var_275_30 < arg_272_1.time_ and arg_272_1.time_ <= var_275_30 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_32 = arg_272_1:FormatText(StoryNameCfg[996].name)

				arg_272_1.leftNameTxt_.text = var_275_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_33 = arg_272_1:GetWordFromCfg(413022065)
				local var_275_34 = arg_272_1:FormatText(var_275_33.content)

				arg_272_1.text_.text = var_275_34

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_35 = 7
				local var_275_36 = utf8.len(var_275_34)
				local var_275_37 = var_275_35 <= 0 and var_275_31 or var_275_31 * (var_275_36 / var_275_35)

				if var_275_37 > 0 and var_275_31 < var_275_37 then
					arg_272_1.talkMaxDuration = var_275_37

					if var_275_37 + var_275_30 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_37 + var_275_30
					end
				end

				arg_272_1.text_.text = var_275_34
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022065", "story_v_out_413022.awb") ~= 0 then
					local var_275_38 = manager.audio:GetVoiceLength("story_v_out_413022", "413022065", "story_v_out_413022.awb") / 1000

					if var_275_38 + var_275_30 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_38 + var_275_30
					end

					if var_275_33.prefab_name ~= "" and arg_272_1.actors_[var_275_33.prefab_name] ~= nil then
						local var_275_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_33.prefab_name].transform, "story_v_out_413022", "413022065", "story_v_out_413022.awb")

						arg_272_1:RecordAudio("413022065", var_275_39)
						arg_272_1:RecordAudio("413022065", var_275_39)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_413022", "413022065", "story_v_out_413022.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_413022", "413022065", "story_v_out_413022.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_40 = math.max(var_275_31, arg_272_1.talkMaxDuration)

			if var_275_30 <= arg_272_1.time_ and arg_272_1.time_ < var_275_30 + var_275_40 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_30) / var_275_40

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_30 + var_275_40 and arg_272_1.time_ < var_275_30 + var_275_40 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
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

		arg_272_1:InitPlayNodeList()
	end,
	Play413022066 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 413022066
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play413022067(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["10092"].transform
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.var_.moveOldPos10092 = var_279_0.localPosition
				var_279_0.localScale = Vector3.New(1, 1, 1)

				arg_276_1:CheckSpriteTmpPos("10092", 7)

				local var_279_2 = var_279_0.childCount

				for iter_279_0 = 0, var_279_2 - 1 do
					local var_279_3 = var_279_0:GetChild(iter_279_0)

					if var_279_3.name == "" or not string.find(var_279_3.name, "split") then
						var_279_3.gameObject:SetActive(true)
					else
						var_279_3.gameObject:SetActive(false)
					end
				end
			end

			local var_279_4 = 0.001

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_4 then
				local var_279_5 = (arg_276_1.time_ - var_279_1) / var_279_4
				local var_279_6 = Vector3.New(0, -2000, -180)

				var_279_0.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos10092, var_279_6, var_279_5)
			end

			if arg_276_1.time_ >= var_279_1 + var_279_4 and arg_276_1.time_ < var_279_1 + var_279_4 + arg_279_0 then
				var_279_0.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_279_7 = arg_276_1.actors_["10092"]
			local var_279_8 = 0

			if var_279_8 < arg_276_1.time_ and arg_276_1.time_ <= var_279_8 + arg_279_0 and not isNil(var_279_7) and arg_276_1.var_.actorSpriteComps10092 == nil then
				arg_276_1.var_.actorSpriteComps10092 = var_279_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_279_9 = 2

			if var_279_8 <= arg_276_1.time_ and arg_276_1.time_ < var_279_8 + var_279_9 and not isNil(var_279_7) then
				local var_279_10 = (arg_276_1.time_ - var_279_8) / var_279_9

				if arg_276_1.var_.actorSpriteComps10092 then
					for iter_279_1, iter_279_2 in pairs(arg_276_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_279_2 then
							if arg_276_1.isInRecall_ then
								local var_279_11 = Mathf.Lerp(iter_279_2.color.r, arg_276_1.hightColor2.r, var_279_10)
								local var_279_12 = Mathf.Lerp(iter_279_2.color.g, arg_276_1.hightColor2.g, var_279_10)
								local var_279_13 = Mathf.Lerp(iter_279_2.color.b, arg_276_1.hightColor2.b, var_279_10)

								iter_279_2.color = Color.New(var_279_11, var_279_12, var_279_13)
							else
								local var_279_14 = Mathf.Lerp(iter_279_2.color.r, 0.5, var_279_10)

								iter_279_2.color = Color.New(var_279_14, var_279_14, var_279_14)
							end
						end
					end
				end
			end

			if arg_276_1.time_ >= var_279_8 + var_279_9 and arg_276_1.time_ < var_279_8 + var_279_9 + arg_279_0 and not isNil(var_279_7) and arg_276_1.var_.actorSpriteComps10092 then
				for iter_279_3, iter_279_4 in pairs(arg_276_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_279_4 then
						if arg_276_1.isInRecall_ then
							iter_279_4.color = arg_276_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_279_4.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_276_1.var_.actorSpriteComps10092 = nil
			end

			local var_279_15 = 0
			local var_279_16 = 1.15

			if var_279_15 < arg_276_1.time_ and arg_276_1.time_ <= var_279_15 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_17 = arg_276_1:GetWordFromCfg(413022066)
				local var_279_18 = arg_276_1:FormatText(var_279_17.content)

				arg_276_1.text_.text = var_279_18

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_19 = 46
				local var_279_20 = utf8.len(var_279_18)
				local var_279_21 = var_279_19 <= 0 and var_279_16 or var_279_16 * (var_279_20 / var_279_19)

				if var_279_21 > 0 and var_279_16 < var_279_21 then
					arg_276_1.talkMaxDuration = var_279_21

					if var_279_21 + var_279_15 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_21 + var_279_15
					end
				end

				arg_276_1.text_.text = var_279_18
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_22 = math.max(var_279_16, arg_276_1.talkMaxDuration)

			if var_279_15 <= arg_276_1.time_ and arg_276_1.time_ < var_279_15 + var_279_22 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_15) / var_279_22

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_15 + var_279_22 and arg_276_1.time_ < var_279_15 + var_279_22 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
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

		arg_276_1:InitPlayNodeList()
	end,
	Play413022067 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 413022067
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play413022068(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = 0
			local var_283_1 = 1.9

			if var_283_0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_0 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, false)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_2 = arg_280_1:GetWordFromCfg(413022067)
				local var_283_3 = arg_280_1:FormatText(var_283_2.content)

				arg_280_1.text_.text = var_283_3

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_4 = 76
				local var_283_5 = utf8.len(var_283_3)
				local var_283_6 = var_283_4 <= 0 and var_283_1 or var_283_1 * (var_283_5 / var_283_4)

				if var_283_6 > 0 and var_283_1 < var_283_6 then
					arg_280_1.talkMaxDuration = var_283_6

					if var_283_6 + var_283_0 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_6 + var_283_0
					end
				end

				arg_280_1.text_.text = var_283_3
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_7 = math.max(var_283_1, arg_280_1.talkMaxDuration)

			if var_283_0 <= arg_280_1.time_ and arg_280_1.time_ < var_283_0 + var_283_7 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_0) / var_283_7

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_0 + var_283_7 and arg_280_1.time_ < var_283_0 + var_283_7 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play413022068 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 413022068
		arg_284_1.duration_ = 5.67

		local var_284_0 = {
			zh = 3.3,
			ja = 5.666
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play413022069(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["10094"].transform
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 then
				arg_284_1.var_.moveOldPos10094 = var_287_0.localPosition
				var_287_0.localScale = Vector3.New(1, 1, 1)

				arg_284_1:CheckSpriteTmpPos("10094", 3)

				local var_287_2 = var_287_0.childCount

				for iter_287_0 = 0, var_287_2 - 1 do
					local var_287_3 = var_287_0:GetChild(iter_287_0)

					if var_287_3.name == "" or not string.find(var_287_3.name, "split") then
						var_287_3.gameObject:SetActive(true)
					else
						var_287_3.gameObject:SetActive(false)
					end
				end
			end

			local var_287_4 = 0.001

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_4 then
				local var_287_5 = (arg_284_1.time_ - var_287_1) / var_287_4
				local var_287_6 = Vector3.New(0, -340, -414)

				var_287_0.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos10094, var_287_6, var_287_5)
			end

			if arg_284_1.time_ >= var_287_1 + var_287_4 and arg_284_1.time_ < var_287_1 + var_287_4 + arg_287_0 then
				var_287_0.localPosition = Vector3.New(0, -340, -414)
			end

			local var_287_7 = arg_284_1.actors_["10094"]
			local var_287_8 = 0

			if var_287_8 < arg_284_1.time_ and arg_284_1.time_ <= var_287_8 + arg_287_0 and not isNil(var_287_7) and arg_284_1.var_.actorSpriteComps10094 == nil then
				arg_284_1.var_.actorSpriteComps10094 = var_287_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_287_9 = 2

			if var_287_8 <= arg_284_1.time_ and arg_284_1.time_ < var_287_8 + var_287_9 and not isNil(var_287_7) then
				local var_287_10 = (arg_284_1.time_ - var_287_8) / var_287_9

				if arg_284_1.var_.actorSpriteComps10094 then
					for iter_287_1, iter_287_2 in pairs(arg_284_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_287_2 then
							if arg_284_1.isInRecall_ then
								local var_287_11 = Mathf.Lerp(iter_287_2.color.r, arg_284_1.hightColor1.r, var_287_10)
								local var_287_12 = Mathf.Lerp(iter_287_2.color.g, arg_284_1.hightColor1.g, var_287_10)
								local var_287_13 = Mathf.Lerp(iter_287_2.color.b, arg_284_1.hightColor1.b, var_287_10)

								iter_287_2.color = Color.New(var_287_11, var_287_12, var_287_13)
							else
								local var_287_14 = Mathf.Lerp(iter_287_2.color.r, 1, var_287_10)

								iter_287_2.color = Color.New(var_287_14, var_287_14, var_287_14)
							end
						end
					end
				end
			end

			if arg_284_1.time_ >= var_287_8 + var_287_9 and arg_284_1.time_ < var_287_8 + var_287_9 + arg_287_0 and not isNil(var_287_7) and arg_284_1.var_.actorSpriteComps10094 then
				for iter_287_3, iter_287_4 in pairs(arg_284_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_287_4 then
						if arg_284_1.isInRecall_ then
							iter_287_4.color = arg_284_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_287_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_284_1.var_.actorSpriteComps10094 = nil
			end

			local var_287_15 = 0
			local var_287_16 = 0.35

			if var_287_15 < arg_284_1.time_ and arg_284_1.time_ <= var_287_15 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_17 = arg_284_1:FormatText(StoryNameCfg[259].name)

				arg_284_1.leftNameTxt_.text = var_287_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_18 = arg_284_1:GetWordFromCfg(413022068)
				local var_287_19 = arg_284_1:FormatText(var_287_18.content)

				arg_284_1.text_.text = var_287_19

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_20 = 14
				local var_287_21 = utf8.len(var_287_19)
				local var_287_22 = var_287_20 <= 0 and var_287_16 or var_287_16 * (var_287_21 / var_287_20)

				if var_287_22 > 0 and var_287_16 < var_287_22 then
					arg_284_1.talkMaxDuration = var_287_22

					if var_287_22 + var_287_15 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_22 + var_287_15
					end
				end

				arg_284_1.text_.text = var_287_19
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022068", "story_v_out_413022.awb") ~= 0 then
					local var_287_23 = manager.audio:GetVoiceLength("story_v_out_413022", "413022068", "story_v_out_413022.awb") / 1000

					if var_287_23 + var_287_15 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_23 + var_287_15
					end

					if var_287_18.prefab_name ~= "" and arg_284_1.actors_[var_287_18.prefab_name] ~= nil then
						local var_287_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_18.prefab_name].transform, "story_v_out_413022", "413022068", "story_v_out_413022.awb")

						arg_284_1:RecordAudio("413022068", var_287_24)
						arg_284_1:RecordAudio("413022068", var_287_24)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_413022", "413022068", "story_v_out_413022.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_413022", "413022068", "story_v_out_413022.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_25 = math.max(var_287_16, arg_284_1.talkMaxDuration)

			if var_287_15 <= arg_284_1.time_ and arg_284_1.time_ < var_287_15 + var_287_25 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_15) / var_287_25

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_15 + var_287_25 and arg_284_1.time_ < var_287_15 + var_287_25 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
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

		arg_284_1:InitPlayNodeList()
	end,
	Play413022069 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 413022069
		arg_288_1.duration_ = 9.5

		local var_288_0 = {
			zh = 9.5,
			ja = 6.466
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play413022070(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["10097"].transform
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 then
				arg_288_1.var_.moveOldPos10097 = var_291_0.localPosition
				var_291_0.localScale = Vector3.New(1, 1, 1)

				arg_288_1:CheckSpriteTmpPos("10097", 4)

				local var_291_2 = var_291_0.childCount

				for iter_291_0 = 0, var_291_2 - 1 do
					local var_291_3 = var_291_0:GetChild(iter_291_0)

					if var_291_3.name == "" or not string.find(var_291_3.name, "split") then
						var_291_3.gameObject:SetActive(true)
					else
						var_291_3.gameObject:SetActive(false)
					end
				end
			end

			local var_291_4 = 0.001

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_4 then
				local var_291_5 = (arg_288_1.time_ - var_291_1) / var_291_4
				local var_291_6 = Vector3.New(390, -350, -180)

				var_291_0.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos10097, var_291_6, var_291_5)
			end

			if arg_288_1.time_ >= var_291_1 + var_291_4 and arg_288_1.time_ < var_291_1 + var_291_4 + arg_291_0 then
				var_291_0.localPosition = Vector3.New(390, -350, -180)
			end

			local var_291_7 = arg_288_1.actors_["10097"]
			local var_291_8 = 0

			if var_291_8 < arg_288_1.time_ and arg_288_1.time_ <= var_291_8 + arg_291_0 and not isNil(var_291_7) and arg_288_1.var_.actorSpriteComps10097 == nil then
				arg_288_1.var_.actorSpriteComps10097 = var_291_7:GetComponentsInChildren(typeof(Image), true)
			end

			local var_291_9 = 2

			if var_291_8 <= arg_288_1.time_ and arg_288_1.time_ < var_291_8 + var_291_9 and not isNil(var_291_7) then
				local var_291_10 = (arg_288_1.time_ - var_291_8) / var_291_9

				if arg_288_1.var_.actorSpriteComps10097 then
					for iter_291_1, iter_291_2 in pairs(arg_288_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_291_2 then
							if arg_288_1.isInRecall_ then
								local var_291_11 = Mathf.Lerp(iter_291_2.color.r, arg_288_1.hightColor1.r, var_291_10)
								local var_291_12 = Mathf.Lerp(iter_291_2.color.g, arg_288_1.hightColor1.g, var_291_10)
								local var_291_13 = Mathf.Lerp(iter_291_2.color.b, arg_288_1.hightColor1.b, var_291_10)

								iter_291_2.color = Color.New(var_291_11, var_291_12, var_291_13)
							else
								local var_291_14 = Mathf.Lerp(iter_291_2.color.r, 1, var_291_10)

								iter_291_2.color = Color.New(var_291_14, var_291_14, var_291_14)
							end
						end
					end
				end
			end

			if arg_288_1.time_ >= var_291_8 + var_291_9 and arg_288_1.time_ < var_291_8 + var_291_9 + arg_291_0 and not isNil(var_291_7) and arg_288_1.var_.actorSpriteComps10097 then
				for iter_291_3, iter_291_4 in pairs(arg_288_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_291_4 then
						if arg_288_1.isInRecall_ then
							iter_291_4.color = arg_288_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_291_4.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_288_1.var_.actorSpriteComps10097 = nil
			end

			local var_291_15 = arg_288_1.actors_["10094"].transform
			local var_291_16 = 0

			if var_291_16 < arg_288_1.time_ and arg_288_1.time_ <= var_291_16 + arg_291_0 then
				arg_288_1.var_.moveOldPos10094 = var_291_15.localPosition
				var_291_15.localScale = Vector3.New(1, 1, 1)

				arg_288_1:CheckSpriteTmpPos("10094", 2)

				local var_291_17 = var_291_15.childCount

				for iter_291_5 = 0, var_291_17 - 1 do
					local var_291_18 = var_291_15:GetChild(iter_291_5)

					if var_291_18.name == "" or not string.find(var_291_18.name, "split") then
						var_291_18.gameObject:SetActive(true)
					else
						var_291_18.gameObject:SetActive(false)
					end
				end
			end

			local var_291_19 = 0.001

			if var_291_16 <= arg_288_1.time_ and arg_288_1.time_ < var_291_16 + var_291_19 then
				local var_291_20 = (arg_288_1.time_ - var_291_16) / var_291_19
				local var_291_21 = Vector3.New(-390, -340, -414)

				var_291_15.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos10094, var_291_21, var_291_20)
			end

			if arg_288_1.time_ >= var_291_16 + var_291_19 and arg_288_1.time_ < var_291_16 + var_291_19 + arg_291_0 then
				var_291_15.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_291_22 = arg_288_1.actors_["10094"]
			local var_291_23 = 0

			if var_291_23 < arg_288_1.time_ and arg_288_1.time_ <= var_291_23 + arg_291_0 and not isNil(var_291_22) and arg_288_1.var_.actorSpriteComps10094 == nil then
				arg_288_1.var_.actorSpriteComps10094 = var_291_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_291_24 = 2

			if var_291_23 <= arg_288_1.time_ and arg_288_1.time_ < var_291_23 + var_291_24 and not isNil(var_291_22) then
				local var_291_25 = (arg_288_1.time_ - var_291_23) / var_291_24

				if arg_288_1.var_.actorSpriteComps10094 then
					for iter_291_6, iter_291_7 in pairs(arg_288_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_291_7 then
							if arg_288_1.isInRecall_ then
								local var_291_26 = Mathf.Lerp(iter_291_7.color.r, arg_288_1.hightColor2.r, var_291_25)
								local var_291_27 = Mathf.Lerp(iter_291_7.color.g, arg_288_1.hightColor2.g, var_291_25)
								local var_291_28 = Mathf.Lerp(iter_291_7.color.b, arg_288_1.hightColor2.b, var_291_25)

								iter_291_7.color = Color.New(var_291_26, var_291_27, var_291_28)
							else
								local var_291_29 = Mathf.Lerp(iter_291_7.color.r, 0.5, var_291_25)

								iter_291_7.color = Color.New(var_291_29, var_291_29, var_291_29)
							end
						end
					end
				end
			end

			if arg_288_1.time_ >= var_291_23 + var_291_24 and arg_288_1.time_ < var_291_23 + var_291_24 + arg_291_0 and not isNil(var_291_22) and arg_288_1.var_.actorSpriteComps10094 then
				for iter_291_8, iter_291_9 in pairs(arg_288_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_291_9 then
						if arg_288_1.isInRecall_ then
							iter_291_9.color = arg_288_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_291_9.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_288_1.var_.actorSpriteComps10094 = nil
			end

			local var_291_30 = 0
			local var_291_31 = 0.3

			if var_291_30 < arg_288_1.time_ and arg_288_1.time_ <= var_291_30 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_32 = arg_288_1:FormatText(StoryNameCfg[1001].name)

				arg_288_1.leftNameTxt_.text = var_291_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_33 = arg_288_1:GetWordFromCfg(413022069)
				local var_291_34 = arg_288_1:FormatText(var_291_33.content)

				arg_288_1.text_.text = var_291_34

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_35 = 12
				local var_291_36 = utf8.len(var_291_34)
				local var_291_37 = var_291_35 <= 0 and var_291_31 or var_291_31 * (var_291_36 / var_291_35)

				if var_291_37 > 0 and var_291_31 < var_291_37 then
					arg_288_1.talkMaxDuration = var_291_37

					if var_291_37 + var_291_30 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_37 + var_291_30
					end
				end

				arg_288_1.text_.text = var_291_34
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022069", "story_v_out_413022.awb") ~= 0 then
					local var_291_38 = manager.audio:GetVoiceLength("story_v_out_413022", "413022069", "story_v_out_413022.awb") / 1000

					if var_291_38 + var_291_30 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_38 + var_291_30
					end

					if var_291_33.prefab_name ~= "" and arg_288_1.actors_[var_291_33.prefab_name] ~= nil then
						local var_291_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_33.prefab_name].transform, "story_v_out_413022", "413022069", "story_v_out_413022.awb")

						arg_288_1:RecordAudio("413022069", var_291_39)
						arg_288_1:RecordAudio("413022069", var_291_39)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_413022", "413022069", "story_v_out_413022.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_413022", "413022069", "story_v_out_413022.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_40 = math.max(var_291_31, arg_288_1.talkMaxDuration)

			if var_291_30 <= arg_288_1.time_ and arg_288_1.time_ < var_291_30 + var_291_40 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_30) / var_291_40

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_30 + var_291_40 and arg_288_1.time_ < var_291_30 + var_291_40 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_288_1:InitPlayNodeList()
	end,
	Play413022070 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 413022070
		arg_292_1.duration_ = 13.67

		local var_292_0 = {
			zh = 8.266,
			ja = 13.666
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play413022071(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["10022"].transform
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 then
				arg_292_1.var_.moveOldPos10022 = var_295_0.localPosition
				var_295_0.localScale = Vector3.New(1, 1, 1)

				arg_292_1:CheckSpriteTmpPos("10022", 2)

				local var_295_2 = var_295_0.childCount

				for iter_295_0 = 0, var_295_2 - 1 do
					local var_295_3 = var_295_0:GetChild(iter_295_0)

					if var_295_3.name == "" or not string.find(var_295_3.name, "split") then
						var_295_3.gameObject:SetActive(true)
					else
						var_295_3.gameObject:SetActive(false)
					end
				end
			end

			local var_295_4 = 0.001

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_4 then
				local var_295_5 = (arg_292_1.time_ - var_295_1) / var_295_4
				local var_295_6 = Vector3.New(-390, -315, -320)

				var_295_0.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos10022, var_295_6, var_295_5)
			end

			if arg_292_1.time_ >= var_295_1 + var_295_4 and arg_292_1.time_ < var_295_1 + var_295_4 + arg_295_0 then
				var_295_0.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_295_7 = arg_292_1.actors_["10097"].transform
			local var_295_8 = 0

			if var_295_8 < arg_292_1.time_ and arg_292_1.time_ <= var_295_8 + arg_295_0 then
				arg_292_1.var_.moveOldPos10097 = var_295_7.localPosition
				var_295_7.localScale = Vector3.New(1, 1, 1)

				arg_292_1:CheckSpriteTmpPos("10097", 4)

				local var_295_9 = var_295_7.childCount

				for iter_295_1 = 0, var_295_9 - 1 do
					local var_295_10 = var_295_7:GetChild(iter_295_1)

					if var_295_10.name == "" or not string.find(var_295_10.name, "split") then
						var_295_10.gameObject:SetActive(true)
					else
						var_295_10.gameObject:SetActive(false)
					end
				end
			end

			local var_295_11 = 0.001

			if var_295_8 <= arg_292_1.time_ and arg_292_1.time_ < var_295_8 + var_295_11 then
				local var_295_12 = (arg_292_1.time_ - var_295_8) / var_295_11
				local var_295_13 = Vector3.New(390, -350, -180)

				var_295_7.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos10097, var_295_13, var_295_12)
			end

			if arg_292_1.time_ >= var_295_8 + var_295_11 and arg_292_1.time_ < var_295_8 + var_295_11 + arg_295_0 then
				var_295_7.localPosition = Vector3.New(390, -350, -180)
			end

			local var_295_14 = arg_292_1.actors_["10022"]
			local var_295_15 = 0

			if var_295_15 < arg_292_1.time_ and arg_292_1.time_ <= var_295_15 + arg_295_0 and not isNil(var_295_14) and arg_292_1.var_.actorSpriteComps10022 == nil then
				arg_292_1.var_.actorSpriteComps10022 = var_295_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_16 = 2

			if var_295_15 <= arg_292_1.time_ and arg_292_1.time_ < var_295_15 + var_295_16 and not isNil(var_295_14) then
				local var_295_17 = (arg_292_1.time_ - var_295_15) / var_295_16

				if arg_292_1.var_.actorSpriteComps10022 then
					for iter_295_2, iter_295_3 in pairs(arg_292_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_295_3 then
							if arg_292_1.isInRecall_ then
								local var_295_18 = Mathf.Lerp(iter_295_3.color.r, arg_292_1.hightColor1.r, var_295_17)
								local var_295_19 = Mathf.Lerp(iter_295_3.color.g, arg_292_1.hightColor1.g, var_295_17)
								local var_295_20 = Mathf.Lerp(iter_295_3.color.b, arg_292_1.hightColor1.b, var_295_17)

								iter_295_3.color = Color.New(var_295_18, var_295_19, var_295_20)
							else
								local var_295_21 = Mathf.Lerp(iter_295_3.color.r, 1, var_295_17)

								iter_295_3.color = Color.New(var_295_21, var_295_21, var_295_21)
							end
						end
					end
				end
			end

			if arg_292_1.time_ >= var_295_15 + var_295_16 and arg_292_1.time_ < var_295_15 + var_295_16 + arg_295_0 and not isNil(var_295_14) and arg_292_1.var_.actorSpriteComps10022 then
				for iter_295_4, iter_295_5 in pairs(arg_292_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_295_5 then
						if arg_292_1.isInRecall_ then
							iter_295_5.color = arg_292_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						else
							iter_295_5.color = Color.New(1, 1, 1)
						end
					end
				end

				arg_292_1.var_.actorSpriteComps10022 = nil
			end

			local var_295_22 = 0
			local var_295_23 = 0.925

			if var_295_22 < arg_292_1.time_ and arg_292_1.time_ <= var_295_22 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_24 = arg_292_1:FormatText(StoryNameCfg[614].name)

				arg_292_1.leftNameTxt_.text = var_295_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_25 = arg_292_1:GetWordFromCfg(413022070)
				local var_295_26 = arg_292_1:FormatText(var_295_25.content)

				arg_292_1.text_.text = var_295_26

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_27 = 37
				local var_295_28 = utf8.len(var_295_26)
				local var_295_29 = var_295_27 <= 0 and var_295_23 or var_295_23 * (var_295_28 / var_295_27)

				if var_295_29 > 0 and var_295_23 < var_295_29 then
					arg_292_1.talkMaxDuration = var_295_29

					if var_295_29 + var_295_22 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_29 + var_295_22
					end
				end

				arg_292_1.text_.text = var_295_26
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022070", "story_v_out_413022.awb") ~= 0 then
					local var_295_30 = manager.audio:GetVoiceLength("story_v_out_413022", "413022070", "story_v_out_413022.awb") / 1000

					if var_295_30 + var_295_22 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_30 + var_295_22
					end

					if var_295_25.prefab_name ~= "" and arg_292_1.actors_[var_295_25.prefab_name] ~= nil then
						local var_295_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_25.prefab_name].transform, "story_v_out_413022", "413022070", "story_v_out_413022.awb")

						arg_292_1:RecordAudio("413022070", var_295_31)
						arg_292_1:RecordAudio("413022070", var_295_31)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_413022", "413022070", "story_v_out_413022.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_413022", "413022070", "story_v_out_413022.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_32 = math.max(var_295_23, arg_292_1.talkMaxDuration)

			if var_295_22 <= arg_292_1.time_ and arg_292_1.time_ < var_295_22 + var_295_32 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_22) / var_295_32

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_22 + var_295_32 and arg_292_1.time_ < var_295_22 + var_295_32 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
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
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play413022071 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 413022071
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play413022072(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["10022"]
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.actorSpriteComps10022 == nil then
				arg_296_1.var_.actorSpriteComps10022 = var_299_0:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_2 = 2

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 and not isNil(var_299_0) then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2

				if arg_296_1.var_.actorSpriteComps10022 then
					for iter_299_0, iter_299_1 in pairs(arg_296_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_299_1 then
							if arg_296_1.isInRecall_ then
								local var_299_4 = Mathf.Lerp(iter_299_1.color.r, arg_296_1.hightColor2.r, var_299_3)
								local var_299_5 = Mathf.Lerp(iter_299_1.color.g, arg_296_1.hightColor2.g, var_299_3)
								local var_299_6 = Mathf.Lerp(iter_299_1.color.b, arg_296_1.hightColor2.b, var_299_3)

								iter_299_1.color = Color.New(var_299_4, var_299_5, var_299_6)
							else
								local var_299_7 = Mathf.Lerp(iter_299_1.color.r, 0.5, var_299_3)

								iter_299_1.color = Color.New(var_299_7, var_299_7, var_299_7)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 and not isNil(var_299_0) and arg_296_1.var_.actorSpriteComps10022 then
				for iter_299_2, iter_299_3 in pairs(arg_296_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_299_3 then
						if arg_296_1.isInRecall_ then
							iter_299_3.color = arg_296_1.hightColor2 or Color.New(0.46, 0.43, 0.35)
						else
							iter_299_3.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end

				arg_296_1.var_.actorSpriteComps10022 = nil
			end

			local var_299_8 = arg_296_1.actors_["10097"].transform
			local var_299_9 = 0

			if var_299_9 < arg_296_1.time_ and arg_296_1.time_ <= var_299_9 + arg_299_0 then
				arg_296_1.var_.moveOldPos10097 = var_299_8.localPosition
				var_299_8.localScale = Vector3.New(1, 1, 1)

				arg_296_1:CheckSpriteTmpPos("10097", 7)

				local var_299_10 = var_299_8.childCount

				for iter_299_4 = 0, var_299_10 - 1 do
					local var_299_11 = var_299_8:GetChild(iter_299_4)

					if var_299_11.name == "" or not string.find(var_299_11.name, "split") then
						var_299_11.gameObject:SetActive(true)
					else
						var_299_11.gameObject:SetActive(false)
					end
				end
			end

			local var_299_12 = 0.001

			if var_299_9 <= arg_296_1.time_ and arg_296_1.time_ < var_299_9 + var_299_12 then
				local var_299_13 = (arg_296_1.time_ - var_299_9) / var_299_12
				local var_299_14 = Vector3.New(0, -2000, -180)

				var_299_8.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10097, var_299_14, var_299_13)
			end

			if arg_296_1.time_ >= var_299_9 + var_299_12 and arg_296_1.time_ < var_299_9 + var_299_12 + arg_299_0 then
				var_299_8.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_299_15 = arg_296_1.actors_["10022"].transform
			local var_299_16 = 0

			if var_299_16 < arg_296_1.time_ and arg_296_1.time_ <= var_299_16 + arg_299_0 then
				arg_296_1.var_.moveOldPos10022 = var_299_15.localPosition
				var_299_15.localScale = Vector3.New(1, 1, 1)

				arg_296_1:CheckSpriteTmpPos("10022", 7)

				local var_299_17 = var_299_15.childCount

				for iter_299_5 = 0, var_299_17 - 1 do
					local var_299_18 = var_299_15:GetChild(iter_299_5)

					if var_299_18.name == "" or not string.find(var_299_18.name, "split") then
						var_299_18.gameObject:SetActive(true)
					else
						var_299_18.gameObject:SetActive(false)
					end
				end
			end

			local var_299_19 = 0.001

			if var_299_16 <= arg_296_1.time_ and arg_296_1.time_ < var_299_16 + var_299_19 then
				local var_299_20 = (arg_296_1.time_ - var_299_16) / var_299_19
				local var_299_21 = Vector3.New(0, -2000, 0)

				var_299_15.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10022, var_299_21, var_299_20)
			end

			if arg_296_1.time_ >= var_299_16 + var_299_19 and arg_296_1.time_ < var_299_16 + var_299_19 + arg_299_0 then
				var_299_15.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_299_22 = 0
			local var_299_23 = 1.525

			if var_299_22 < arg_296_1.time_ and arg_296_1.time_ <= var_299_22 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_24 = arg_296_1:GetWordFromCfg(413022071)
				local var_299_25 = arg_296_1:FormatText(var_299_24.content)

				arg_296_1.text_.text = var_299_25

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_26 = 61
				local var_299_27 = utf8.len(var_299_25)
				local var_299_28 = var_299_26 <= 0 and var_299_23 or var_299_23 * (var_299_27 / var_299_26)

				if var_299_28 > 0 and var_299_23 < var_299_28 then
					arg_296_1.talkMaxDuration = var_299_28

					if var_299_28 + var_299_22 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_28 + var_299_22
					end
				end

				arg_296_1.text_.text = var_299_25
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_29 = math.max(var_299_23, arg_296_1.talkMaxDuration)

			if var_299_22 <= arg_296_1.time_ and arg_296_1.time_ < var_299_22 + var_299_29 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_22) / var_299_29

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_22 + var_299_29 and arg_296_1.time_ < var_299_22 + var_299_29 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_296_1:InitPlayNodeList()
	end,
	Play413022072 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 413022072
		arg_300_1.duration_ = 5.8

		local var_300_0 = {
			zh = 5.8,
			ja = 5.233
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
			arg_300_1.auto_ = false
		end

		function arg_300_1.playNext_(arg_302_0)
			arg_300_1.onStoryFinished_()
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0
			local var_303_1 = 0.35

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_2 = arg_300_1:FormatText(StoryNameCfg[1001].name)

				arg_300_1.leftNameTxt_.text = var_303_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10097_split_3")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_3 = arg_300_1:GetWordFromCfg(413022072)
				local var_303_4 = arg_300_1:FormatText(var_303_3.content)

				arg_300_1.text_.text = var_303_4

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_5 = 14
				local var_303_6 = utf8.len(var_303_4)
				local var_303_7 = var_303_5 <= 0 and var_303_1 or var_303_1 * (var_303_6 / var_303_5)

				if var_303_7 > 0 and var_303_1 < var_303_7 then
					arg_300_1.talkMaxDuration = var_303_7

					if var_303_7 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_7 + var_303_0
					end
				end

				arg_300_1.text_.text = var_303_4
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413022", "413022072", "story_v_out_413022.awb") ~= 0 then
					local var_303_8 = manager.audio:GetVoiceLength("story_v_out_413022", "413022072", "story_v_out_413022.awb") / 1000

					if var_303_8 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_8 + var_303_0
					end

					if var_303_3.prefab_name ~= "" and arg_300_1.actors_[var_303_3.prefab_name] ~= nil then
						local var_303_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_3.prefab_name].transform, "story_v_out_413022", "413022072", "story_v_out_413022.awb")

						arg_300_1:RecordAudio("413022072", var_303_9)
						arg_300_1:RecordAudio("413022072", var_303_9)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_413022", "413022072", "story_v_out_413022.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_413022", "413022072", "story_v_out_413022.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_10 = math.max(var_303_1, arg_300_1.talkMaxDuration)

			if var_303_0 <= arg_300_1.time_ and arg_300_1.time_ < var_303_0 + var_303_10 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_0) / var_303_10

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_0 + var_303_10 and arg_300_1.time_ < var_303_0 + var_303_10 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/F08h",
		"TextureConfig/Background/ST0601"
	},
	voices = {
		"story_v_out_413022.awb"
	}
}
